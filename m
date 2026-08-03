Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B53AA4E0
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734159; cv=none; b=kKGF5UJZ7Hrg0bo1OiTOkwKJHJz4MTjOS144ahqqNfMTY/ay9zUvcI2zIFhs8iNN/BBmLSG7/psr8QV5TO8agonar/yEeTsYJkxCmy94Sim7qqVvPsbZrzdpS2FANI70Io0UBn3Us5nAUe5XaXO1rLqCYuAe3zRUk3M7UcnpFQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734159; c=relaxed/simple;
	bh=GJHoT3sGNBaHJutusjqByQrs0uUzgfDmspxJwWo+2Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsXYpadyb6gk/PlkUc+VOSiY75+f2R0XM3rwEk5Nrf6ZRfgCvruzJC1LIPKHJyePgC7AnvtEXYbH7q8tRRjwTJrPNvGlA7JhaqtiFof8mHewaHyLMZ6qAx5fxS3fel4kILOlY7Ovc/NKZT9I/JrQqejNIlfwoVwyZoUTotBuYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST7HRXPc; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST7HRXPc"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb6573bd52so2068269a34.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734156; x=1786338956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3THAfFmoIZwxbw2uyAABLxKH+fs/K6w42J64CA1198=;
        b=ST7HRXPcMmjr8vPiDHuHugjkiSSNt3m0EpUVbjXGoiYvVT5I0gKXO6JAo7NLtNiUVC
         Rrc5Z4ktBlZQNsbKV/S4nZFVjXmJDerLjH7tOsxlMPfs39MRtpumznRqzC7ylUavnS3c
         2sGZaE8ZAfGJKWGcGSC1L+gEvxSt9P8V/k8LPWcvZaqqYwZtpblw56G/3XEKjzSzb0Pl
         a+6bmeMrU9ib/z6d2YzGs0UJshembYC8vPrVMgjvATJp3ptyi3gEj0elgUIqXJ080fH0
         ELO8x7RqToUhtY1wPBACNpUElgHTQ93HYtlU3586S4A8/HUuJY4xAfiPmOmF3N8jORq+
         ISRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734156; x=1786338956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3THAfFmoIZwxbw2uyAABLxKH+fs/K6w42J64CA1198=;
        b=SIms9CBbJzczrUIEtkfV51XySWwHNPqJ4GQyEHVkDHvGbaA19dYHJp/Nw31hCjJg5P
         Wghmn0OLixm8qL/zATapah4krarQjKNraQYPKbt0LBK44NITMbZomHoZVqQxTwwiOFgp
         PLtMKeBh96dLvT3qW3ruwqP53ePole9WDwGC6qsTIwtp2DfxfZX0Q8BTUq4fdOs6IhSE
         WS6a1jXXKshbPjVxKuxHII6EzbWzt/ZHT8VoPhtoy5vFrHtLtUk0EJVTKdt8nFFQClah
         WinGM85hiebBCvbdBJkVu676ARzsu5dLMWXj/UJrvSwmrVpEkjaKkacwmYkMBrDTI8No
         Rc/Q==
X-Gm-Message-State: AOJu0YzQW+OVCnpur19QUQBy6kag4ecXQiOWpgledTc3L2U9siyaQjfR
	YqSUTm64XRhXjpOWG52KJM0FfYS+EKoBhXrf0i+6jpIcq9jMrIisy5R3
X-Gm-Gg: AR+sD11II1vp2WGcARfOv8UfquFA1LTRknoQ6YBmpuWf0gKWH7DzgHMMEL8+1BpWpQF
	gn149qlzFMsRyT8uTnXNhX1Wuru+Lhw59isKNv3G/s0e7I+XMoxx8CCW4Bs7NKccOPTnUjoR8/t
	+ANRVFbHluIhWK7J6yQAawoUnC4X310i5No+e0UIuG55SCudVySPo9Dynig6kIbDY/vyxiODUdC
	PrzCSTNqwglHxIqIwERv0FUL3FtWpxR0WTwiCoRw8KEBfh4+jt/L8HMRdrvm08NMj0AJTNWjmCm
	h04MN2z5X7X38liyRS+UyYO9NVxym9BGT8bxpCCAMC4krHBdHNFVJGvNe+wbbW4zvfmHeQ1MedK
	bs0J2JhSBZfH61F721wyyoINzuTPKtrEsWOex6QClO9s07bfmw2Nj1hBF+kFhPIsC3tgJmZopH7
	qW2YhutHVi2KwBu9eBispNgu3cnB92lxVT0PVH3Hl1Ebx4jNl0tfZQy5UiqVEjQwhpF2fE6FORI
	P1P0IP/ge/h+TmAnEnXdo6sAGbiXMB1iPbOcp1RY4LeGKKtiVSBGiebHct2cDwHCjiii+ZMwO/Q
	N3tSbHjqMQsbyoLCWj2qLE1RtsfwsZAiTfycs71RVh2BJc5UvEeIMHcpUXn8j3c5o6S6QEJwv+f
	7o+CEPEnR5BcxtOWPj4doLOpSNT+l+S2O32mN
X-Received: by 2002:a05:6830:2a8b:b0:7e6:f7fb:9678 with SMTP id 46e09a7af769-7f196cb65a7mr14526881a34.1.1785734154482;
        Sun, 02 Aug 2026 22:15:54 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:31 -0600
Subject: [PATCH 21/21] arm64: defconfig: enable X-Powers ACx00 Ethernet
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-21-0a53cd9e21cc@gmail.com>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Build the H616 PWM clock provider, AC200 MFD, both variant-specific
EPHY control drivers and the shared link-PHY driver as modules. Enable the
netdev LED trigger as a module so DT-described PHY LEDs can use hardware
offload.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 654a102cb5bc..53f6b8edaf33 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -475,6 +475,9 @@ CONFIG_DP83869_PHY=m
 CONFIG_DP83TD510_PHY=y
 CONFIG_DP83TG720_PHY=m
 CONFIG_VITESSE_PHY=y
+CONFIG_XPOWERS_AC200_PHY_CTL=m
+CONFIG_XPOWERS_AC300_PHY_CTL=m
+CONFIG_XPOWERS_ACX00_PHY=m
 CONFIG_XILINX_GMII2RGMII=m
 CONFIG_CAN_FLEXCAN=m
 CONFIG_CAN_XILINXCAN=m
@@ -828,6 +831,7 @@ CONFIG_BCM7038_WDT=m
 CONFIG_MFD_ADP5585=m
 CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_BD9571MWV=y
+CONFIG_MFD_AC200=m
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_MACSMC=m
@@ -1325,6 +1329,7 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_LEDS_TRIGGER_PANIC=y
+CONFIG_LEDS_TRIGGER_NETDEV=m
 CONFIG_EDAC=y
 CONFIG_EDAC_GHES=y
 CONFIG_EDAC_LAYERSCAPE=m
@@ -1726,6 +1731,7 @@ CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_STM32=m
 CONFIG_PWM_SUN4I=m
+CONFIG_PWM_SUN8I=m
 CONFIG_PWM_TEGRA=m
 CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m

-- 
2.53.0

