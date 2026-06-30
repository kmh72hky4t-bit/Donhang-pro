/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['var(--font-be-vietnam)', 'system-ui', 'sans-serif'],
      },
      colors: {
        bg:      '#0d0f14',
        surface: '#161921',
        card:    '#1c2030',
        border:  '#262c3d',
        accent:  '#4ade80',
        orange:  '#f97316',
        muted:   '#6b7280',
        danger:  '#f87171',
      },
      borderRadius: { DEFAULT: '0.5rem' },
    },
  },
  plugins: [],
}
