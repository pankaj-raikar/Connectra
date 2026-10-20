import type { Metadata } from "next";
import {Inter} from 'next/font/google'
import "./globals.css";

import { Providers } from "@/components/providers/Providers";
import Navbar from "@/components/layout/Navbar";


const inter = Inter({subsets: ['latin']})
export const metadata: Metadata = {
  title: "Connectra | Real-Time Social Platform",
  description: "Modern full-stack real-time social networking platform featuring live chat, instant notifications, online presence, and scalable event-driven architecture.",
};



export default function RootLayout({ 
  children,
 }: {
  children: React.ReactNode;
 }) {
  return (
    <html lang="en">
      <body className={`${inter.className} bg-gray-50 text-slate-800`}>
      <Providers>
        <Navbar />
        <main className="mx-auto max-w-7xl pt-16 h-[calc(100vh)] overflow-hidden">
              {children}
        </main>
      </Providers>
        </body>
    </html>
  );
}
