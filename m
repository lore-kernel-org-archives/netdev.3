Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408276;
	b=qsF95orhEv240uUq40Mo9uZ8wItLt0niO3qtgAE1z4OqLTLogJsvg2fM1/JZPG3ZzWMn
	 N3H8NRsJBp2s31lQIAsgxgDywOHww0VBRl4iSvBeZ4WEZ0PI1zEQb3/0Bv4Hi65t32j0T
	 VV3b/fRkF8OXZJHp+FWQOw5VS0vrrI3Lxs6S/d9j9GsMASPB8ZOkJ+GC1D7ohb4VAKBEI
	 iSU+A1ga/d4rd2iNV+4HIt5b3tMPwf9s3DTLbQMaEiANWaILhgJMSa0p7VNA1bmKdQ8KH
	 G7mvwN1max4yovd/tO/VDKR6dHc0E/DheypSmS/uzH6orw8SgXegKIcJhGydulPr6Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ihkB9FM28RtXDynQhG6sYSquSmbZ93rrnlR0/YF37d0=;
	b=rtKyE3D4trX8w1pjHFyszbn0NFpIAV4uddEglXaMjradUBJ1fWt+74NNq00SfSlFtFw3
	 6CtctZZoEoBgI1/FQmoLYPTLhSaE80k0ebg0J90tfn9bUswdTXCKMu8/T11X0Uq4u1Ltu
	 Jx13YWdW0GJjIf8aCOcH5t3IRFpm5dgzMZOpfd0YBGrU0p248zDPaM+sJYZ8ZCSHMGefB
	 o7e92RAXUZUjkYhKQOh25Hs/5yrQHWSHz2/0Y73h7UWc3IuCDVIUsHXQjObrcBRT89ua9
	 u6eGLq454A3DPixZznHMEbChccRl4DIbR9O5kxdme6kTPkmRuUBjdInVrb4k2URZrdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lxcv0kJs;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B1606A8BD
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E0B1606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lxcv0kJs
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so19783395e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408275; x=1795013075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ihkB9FM28RtXDynQhG6sYSquSmbZ93rrnlR0/YF37d0=;
        b=lxcv0kJsZ98NSPjbORZDxEUJ3JH/hNaN0PzRtl1xrSfNWEJrPEKijUUDQY7ltCAScu
         mZv7r77zJ546S+1GlMEsngJNEUXQXf4GXRiw5Dst2XaLAF3uvfJarsL23Qsn77D/IIUW
         jWhwnJrudNp2c9xFcPdXUBsvePpyAUze/rjtOfs8ilbcGgV622BP4EwRqYfJX+OJeBF8
         i0z5MUCdW2cMxbrO+I6MJwmQ3mqN8BceFsGRSbKVYwNDLrUEdkrlrA8bBIibIAxliOG/
         kXJ9ZmLUtEMF9nfKmNXa0WrjruvpgF/gcrlKur9NyZ6URVGYDY8n3zCH32sksdN2n3di
         Emuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408275; x=1795013075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ihkB9FM28RtXDynQhG6sYSquSmbZ93rrnlR0/YF37d0=;
        b=KXjJJogxVQP5SLhejkvAja0nn0vlijUEQgy01pc1TIUfh33R/Ho/aheKEsjIMT+Vey
         CSof/GdKbTCetXtgFUssXv73tgQ1VP+I3yGw2tP5+mAIwAOw9dMvd9bzm1zKzMtUvTG7
         o2gu4YhvyjULkrDPdsqOvkxnn9QvrbvfYO5a3x2bke0IReuc33cvtdIpRZQNwXxK7C4Z
         Vy2vgOUJB0P1tQWuReIuPEdmylP1Y13cEZ7hVSuyWmCUVzejGpfmpOR+8gEsgNa7glGH
         fM6Q80I0gR9c+VoUNIAsSHFONR+PWX7Va4u34r8AxheZL78PuxyWqNw+RL/2Wf0dtYSC
         iTCQ==
X-Forwarded-Encrypted: i=1; AL+hErHk36sKejqbnxzGiFXlcLKoQg3LzLPeSCIosrubq1iqq0pfqHbiNx6vF0NmUEvbxwg6kDjxYrU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lqyFDivm3tLf4InliCKU5rLRtra+xVm8dDt7FpZsw1nYKU+4p
	MrbvpJO5G+qchigtiXog1OJk+FSBMQLtnQL6QYWYmbZBj9V6PGPucFip
X-Gm-Gg: AYBFou0lfZg7HCpPncw0wUhLQqrL5EenfpFNwqW6I1rhY27nzD3JhZKxXubkP+3Wtrs
	wc3pbqba/kVGrqFv3MJvxbRkvRPob8Nnu7dOHdjpp51SGPIoGNCUwYwBqDqgIJBLJmIRr0FtbrA
	hsblZVpzyTdaqAE7QNgjJ3sfRQmTkHtg2wwn4+/C5LmACHA0/U29usDz4OCcWAX5VEEwYBKWMhK
	52z+sVoWU3LsSOBlx4FIUd6gJHSItYBsIxVVxmxKT+/weSNGsqILRrD5ckUeG5x5lNo/6RohEXL
	2RSdCpVDBVUtAwhgg5a/ItOlvuVdlQBd1F1dN1KEJYZRJRmRIyBZcOdyfUtgEfg/5CGClaUPuHs
	tpo/3p8mfJvhwYfCdC+LkFTRvpq7cE9erR3o5LigYDCgsf6QfCRVM9oQ1DC5wCJMdBEo4PDve+l
	2F1lYjxfb7vNrtB6Waq8a1Q0ah4PFN4u1+FFy58/9U2CQp4tlQQhgi8Kh/Kl8/hXp/5ohlMz0mG
	J3HpN0OciLsHl7DRz8AKc267ycjCAPFg7ETRLSRSBB3qScjSvoytxMNzryJvZ6dWmrUUUdmSpg3
	J0UXgtp6twHn2EkrdYvM22+GW7v4uYjZurc=
X-Received: by 2002:a05:600c:19d0:b0:4a1:ddaa:571e with SMTP id 5b1f17b1804b1-4ba093aa687mr48679885e9.15.1794408274601;
        Wed, 11 Nov 2026 06:44:34 -0800 (PST)
Received: from dev.Default ([86.127.229.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08de826asm46656495e9.0.2026.11.11.06.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:44:32 -0800 (PST)
From: Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>
To: Navid Ghahremani <ghahramani.navid@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Junyang Han <han.junyang@zte.com.cn>,
	=?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 2/5] ARM: dts: zte: zx279128s: add the WLAN DMA interrupt
Date: Wed, 11 Nov 2026 15:44:23 +0100
Message-Id: <20261111144426.1321237-3-isasmendi.agus@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20261111144426.1321237-1-isasmendi.agus@gmail.com>
References: <20261111144426.1321237-1-isasmendi.agus@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch's second DMA engine, the ring pair the vendor firmware uses
for offloaded WLAN flows, has its own interrupt line, GIC SPI 38.  Add
it to the ethernet node as the optional "wlan" interrupt.

Assisted-by: LLM
Signed-off-by: Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>
---
 arch/arm/boot/dts/zte/zx279128s.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zte/zx279128s.dtsi b/arch/arm/boot/dts/zte/zx279128s.dtsi
index 8896a8b06725..9ddc5ee02687 100644
--- a/arch/arm/boot/dts/zte/zx279128s.dtsi
+++ b/arch/arm/boot/dts/zte/zx279128s.dtsi
@@ -201,7 +201,9 @@ pcie1: pcie@f100000 {
 		gmac: ethernet@92000000 {
 			compatible = "zte,zx279128s-gmac";
 			reg = <0x92000000 0x400000>;
-			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tm", "wlan";
 			status = "disabled";
 
 			ethernet-ports {
-- 
2.30.2

