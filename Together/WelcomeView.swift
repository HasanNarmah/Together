//
//  WelcomeView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI

struct OnboardingStep {
    let emoji: String
    let title: String
    let subtitle: String
    let description: String
}

struct WelcomeView: View {
    @State private var currentStep = 0
    @State private var animateEmoji = false
    
    private let onboardingSteps = [
        OnboardingStep(
            emoji: "🏠",
            title: "Welcome",
            subtitle: "Together 🌍",
            description: "A safe space for those who have been displaced. We understand your journey and are here to support you every step of the way."
        ),
        OnboardingStep(
            emoji: "🤝",
            title: "Connect",
            subtitle: "Find Your Community",
            description: "Connect with others who share similar experiences. Build meaningful relationships with people who truly understand your situation."
        ),
        OnboardingStep(
            emoji: "🛡️",
            title: "Stay Safe",
            subtitle: "Security & Support",
            description: "Access essential safety resources, emergency contacts, and protective services designed specifically for displaced individuals."
        ),
        OnboardingStep(
            emoji: "🌱",
            title: "Rebuild",
            subtitle: "Recovery & Growth",
            description: "Find housing assistance, employment opportunities, legal aid, and other vital resources to help you rebuild your life."
        ),
        OnboardingStep(
            emoji: "💪",
            title: "Thrive",
            subtitle: "Stronger Together",
            description: "Join a supportive network that empowers you to not just survive, but thrive in your new community and circumstances."
        )
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Animated gradient background
                LinearGradient(
                    gradient: Gradient(colors: [
                        AppColor.background.opacity(0.8),
                        AppColor.background,
                        AppColor.accent.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 1.0), value: currentStep)
                
                VStack(spacing: 40) {
                    // Progress indicator
                    HStack(spacing: 8) {
                        ForEach(0..<onboardingSteps.count, id: \.self) { index in
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(index <= currentStep ? AppColor.accent : AppColor.accent.opacity(0.3))
                                .scaleEffect(index == currentStep ? 1.2 : 1.0)
                                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: currentStep)
                        }
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    // Main content
                    VStack(spacing: 30) {
                        // App title (only on first step)
                        if currentStep == 0 {
                            Text(onboardingSteps[currentStep].subtitle)
                                .font(.custom("Futura", size: 46))
                                .foregroundColor(AppColor.text)
                                .fontWeight(.bold)
                        } else {
                            Text(onboardingSteps[currentStep].subtitle)
                                .font(.largeTitle)
                                .foregroundColor(AppColor.text)
                                .fontWeight(.bold)
                        }
                        
                        // Animated emoji with smooth transitions
                        Text(onboardingSteps[currentStep].emoji)
                            .font(.system(size: 80))
                            .scaleEffect(animateEmoji ? 1.1 : 1.0)
                            .offset(x: animateEmoji ? 0 : -50)
                            .opacity(animateEmoji ? 1 : 0)
                            .animation(.spring(response: 0.8, dampingFraction: 0.7), value: animateEmoji)
                            .animation(.spring(response: 0.8, dampingFraction: 0.7), value: currentStep)
                        
                        // Title
                        Text(onboardingSteps[currentStep].title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(AppColor.text)
                        
                        // Description
                        Text(onboardingSteps[currentStep].description)
                            .font(.headline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    
                    Spacer()
                    
                    // Interactive buttons
                    VStack(spacing: 16) {
                        if currentStep < onboardingSteps.count - 1 {
                            // Skip button
                            Button(action: skipToEnd) {
                                Text("Skip")
                                    .font(.subheadline)
                                    .foregroundColor(AppColor.accent)
                            }
                        } else {
                            // Get started button
                            NavigationLink {
                                LoginView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack {
                                    Text("Get Started")
                                    Image(systemName: "sparkles")
                                        .font(.system(size: 16, weight: .semibold))
                                }
                            }
                            .modifier(ButtonModifiers())
                        }
                        
                        // Swipe gesture hint
                        if currentStep < onboardingSteps.count - 1 {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Swipe to navigate")
                                Image(systemName: "chevron.right")
                            }
                            .font(.caption)
                            .foregroundColor(AppColor.accent.opacity(0.6))
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 50 && currentStep > 0 {
                        previousStep()
                    } else if value.translation.width < -50 && currentStep < onboardingSteps.count - 1 {
                        nextStep()
                    }
                }
        )
        .onAppear {
            animateEmoji = true
        }
        .onChange(of: currentStep) { _ in
            animateEmoji = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animateEmoji = true
            }
        }
    }
    
    private func nextStep() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            if currentStep < onboardingSteps.count - 1 {
                currentStep += 1
            }
        }
        
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
    
    private func previousStep() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            if currentStep > 0 {
                currentStep -= 1
            }
        }
        
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
    
    private func skipToEnd() {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8)) {
            currentStep = onboardingSteps.count - 1
        }
    }
}


#Preview {
    WelcomeView()
}
