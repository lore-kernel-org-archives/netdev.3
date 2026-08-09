Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C928506F
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291309; cv=none; b=UehiviEaE5Ip4V2SAC3YYrrs4qhpn3LyzhbxTZk+Oaxhyq8paHO3NpL9RMaFJGWLp1zxgKaS5eHrrpShbonP5jYDrx6KCAujALwqfisv7MNinotm180q7l8vtc2wkN4KmdKIppZklB6uAM3XkE0DqipI0oqBK9p2kuiFRlZQ2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291309; c=relaxed/simple;
	bh=JFpoyHgm5GyydrgU0EIwnMkmtDfqznZohBF+D+l8oXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PANCdfYfgLUrwOumqZomLOlA+ao/BDTkaFbC3j4AJbplZbvupVupVHDt/ovnq8V6FjCXsmEvPyUd7vGpQp6oDBLkANO9A3INKZt2dyN0tkXJ6ZfEGYnfAToKfOntnq+O0MlBLBQKipp0ZCmNLQMTKEGQVN1ZZH+wMsYVWHFIFDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWBFVcYB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWBFVcYB"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so784144a91.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786291307; x=1786896107; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ey9ID6BlPfSQP74G4aQENA12QCbeo+NzYrkTNceu870=;
        b=OWBFVcYBZewtLCTI06dJGJjFZkHxWpYupYlxCzoX8E8JSq/1K0HdQ26vdICte+sgmv
         VaidpYWXIf00sV7K7XZ17aa9NZPu9TluOL1Y0fmxpfG4xws8hkCkz57QqYu/3FBGYEug
         IY42iEFkpdJ1V8g6fgwEN2wxC7g7I5EIrJ75+o6X0q/GLLO4ACC/1N3e4t6Tl51d2xrI
         V5UadnlbYPPeGCuKDB7tKJvpBxQrfiuLDxblDYsmjZpJpxO2zMgf1JexzQUgn/sLwNW+
         tDghvbCZG1xtQjmi4Pam16I5yQ/OzV5wfE1eySDmG3OvbXaZm3I4dx9LvpNOAqfIO58W
         wxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786291307; x=1786896107;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ey9ID6BlPfSQP74G4aQENA12QCbeo+NzYrkTNceu870=;
        b=K28Y3c8xjBYoeF05rfsMMA2XSCJOK+r2ZHtynLB4rI0UXWwhcuyCLJtxGhBux9n0mL
         zDLmTD0WI+e1/tw+bUo9WbSUtTaWkxnT/GDy1lJntvt02/NFGFWRnyjIt5z5b1uGzO/g
         0gZTdq3tpO9q2IWeSF6/GRx//teH7woxq0YDT6ObBuBmzsHx5fjONKQyRnXwweDYSLba
         K7TNJ4d2KmS09PzQ9s6ek7gfxKyzwF6t6pJif5CsdkjYKf3b14VY3JVDZQx4glZFzF9U
         3lcVFQXAgxRhw9g0IgoG9EitsPXp/T854kQbqWebea8XNctdwe8qSWmdzE65giT7WWhw
         q8gg==
X-Gm-Message-State: AOJu0YwFGXEGU2DvKg6lJN0/l1ti7EvIEHmvTUdhpw+byFGltLuqQxGx
	EupumuikoyE7cQm3vHPB0t8sISdW4RV8VUr0s64PE8J2jM+VHHvMw30n
X-Gm-Gg: AR+sD13w7GKGv9w18eYBSOQD2IMQgAN3ttI8nVe9nWQs05wuM0NLfqddfrCj/Frl2lz
	SYvSTt8Hx3H5O7rEQUgLrU3wKsnAWeD6KIdUHN+rlK3OFj3GoKRghDxYzl69mhMs6SWeVo9avLq
	DRG48VyxxVKJAQrJEInuJCKrUx95L/4iYnL9jvCzVOJgB5jg3Y9FUAb8VuSIjz0IpmwnEspaxUe
	uNL1Wjvu1gEyhyvWzX55/EAb479U3C70pmjmGcslPH531vCp/wKBw36zooUmO/3ghhkcNZa8iiJ
	u7wLNzvoxzDkeBilEoPUyTaqBLbPoOAY7K+8GTB4CZbh166rN2RK0ZVsK5x8QDG6hxxQoBPWNid
	oSPLE7rCAdo39b2Smv4lJXjp0jWHZMTmTJyc4TzCI8HW0LNbPcL+arKnGB64Z3z5AhA3oLLQFZz
	XUTCuPxBiaNrh52k/DFm99UnPDZQpIVUnwvtQjWS9UgLPR5hvYEwWzQ+EPGq27t1h/XEM6yyfPs
	hx+roxdWI6Tg+NhrMJq86/SWO2tZA6nvBM183tQYw==
X-Received: by 2002:a17:90b:4b91:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-3909d7a4839mr21073351a91.1.1786291306864;
        Sun, 09 Aug 2026 09:01:46 -0700 (PDT)
Received: from ubuntu-openwrt.local ([175.100.133.108])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410cc132c1sm13029552c88.8.2026.08.09.09.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 09:01:46 -0700 (PDT)
From: Sandeep Sondagar <sandeepsondagar@gmail.com>
Date: Sun, 09 Aug 2026 21:31:41 +0530
Subject: [PATCH net v3] net: phylink: treat PSGMII as an inband capable
 interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGSkeGoC/yWMQQ6CMBQFr0Le2iZNVQpexbCw8IGvWJt+NBDC3
 S2wnElmFghFJsEtWxDpx8Ifn+B8ylD3D9+R4iYxjDa5LnSpQj8P7F8qSPdmVtfCuvZirKPGIkU
 hUsvTPrzD04jqkPJ1T6rHbYV1/QP4ue0XdwAAAA==
X-Change-ID: 20260809-phylink-psgmii-587bf427bed7
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Gabor Juhos <j4g8y7@gmail.com>, Robert Marko <robert.marko@sartura.hr>, 
 Sandeep Sondagar <sandeepsondagar@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1786291302; l=3651;
 i=sandeepsondagar@gmail.com; h=from:subject:message-id;
 bh=JFpoyHgm5GyydrgU0EIwnMkmtDfqznZohBF+D+l8oXQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgWL6/5cLb314YjVwn3WCpMi6P3C0wG
 GH40C6yYF9u5GIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLgH1EKB+8E3TlrPH/2Vo9N+CrVjJFYABV0MxqcUNcr9tzXTW/+WM2VKhcd15XImD3HlECAZ2ec
 Vvpn1dN6XJgk=
X-Developer-Key: i=sandeepsondagar@gmail.com; a=openssh;
 fpr=SHA256:ki2iXEGRLBiw/R2sikL7Qg80oJ7p+KMkU88RlzgzZDU

PSGMII (the Qualcomm 5-port SGMII) conveys the link negotiation result
from the PHY back to the MAC through per-channel in-band SGMII words,
exactly like SGMII and QSGMII.

However, PHY_INTERFACE_MODE_PSGMII is missing from
phylink_get_inband_type(), so phylink reports INBAND_NONE for it and
phylink_pcs_neg_mode() falls back to PHYLINK_PCS_NEG_NONE. The PCS is
then programmed in force mode and its control-register speed bits (which
default to 1000base) are used, so a slower copper link - e.g. 100base-T
- is reported as 1Gbps and cannot pass traffic.

Classify PSGMII alongside SGMII and QSGMII as INBAND_CISCO_SGMII so the
PCS negotiates in-band and the resolved link speed comes from the PHY
in-band word.

Also add PSGMII to the generic clause 22 PCS helper functions which
handle the SGMII in-band word. Without this, a PCS using these helpers
would still fall through to the default handling and force the link
state to false in phylink_mii_c22_pcs_decode_state(), fail to encode
the SGMII advertisement, and get rejected by phylink_get_link_timer_ns().

Fixes: 83b5f0253b1e ("net: phy: Introduce PSGMII PHY interface mode")
Signed-off-by: Sandeep Sondagar <sandeepsondagar@gmail.com>
---
This series classifies PHY_INTERFACE_MODE_PSGMII (the Qualcomm 5-port
SGMII) as an in-band capable interface in phylink, and adds the mode to
the generic clause 22 PCS helpers so that the in-band SGMII word is
actually used to derive the resolved link speed and state.

Currently PSGMII is missing from phylink_get_inband_type(), so phylink
reports INBAND_NONE and the PCS falls back to PHYLINK_PCS_NEG_NONE,
being programmed in force mode with its control-register speed bits
(default 1000base). A slower copper link, e.g. 100base-T, is therefore
reported as 1Gbps and cannot pass traffic.
---
 drivers/net/phy/phylink.c | 3 +++
 include/linux/phylink.h   | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 18d2ead97aa5..1ce9d2266774 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1040,6 +1040,7 @@ static enum inband_type phylink_get_inband_type(phy_interface_t interface)
 {
 	switch (interface) {
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_PSGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
@@ -4183,6 +4184,7 @@ void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
 		break;
 
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_PSGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 			phylink_decode_sgmii_word(state, lpa);
@@ -4263,6 +4265,7 @@ int phylink_mii_c22_pcs_encode_advertisement(phy_interface_t interface,
 			adv |= ADVERTISE_1000XPSE_ASYM;
 		return adv;
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_PSGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 		return 0x0001;
 	default:
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2bc0db3d52ac..1dda5c7ed5f1 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -791,6 +791,7 @@ static inline int phylink_get_link_timer_ns(phy_interface_t interface)
 {
 	switch (interface) {
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_PSGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
 	case PHY_INTERFACE_MODE_10G_QXGMII:

---
base-commit: 594d905195024b228c962627ae5ae7c17bd582a4
change-id: 20260809-phylink-psgmii-587bf427bed7

Best regards,
--  
Sandeep Sondagar <sandeepsondagar@gmail.com>

