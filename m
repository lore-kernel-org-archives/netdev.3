Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0661DDC37
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132185; cv=none; b=nlPSlXmJU1XrYbl5e4PS2FJ4PY2WWWHvOr3OzarewcGUdIg9mz9/IVu+ePewha0/5rQEK2FnnnjSpOwPZ+yNmyLpTJ3VzvANuym4/6OTH5M4mrcv9irFw4YqmSZ0nq+xoNIH4HOpcs4KCN4aXvV4ymHkpLIOX9u7Ew+EfkjuTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132185; c=relaxed/simple;
	bh=cDE7rA8aqN5e7rQ7XoHZoyTnsUGAF4oK9A5CKhOIVkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTK1uwgRkE7YyR1bu45DsyEL8vFpSgVFDlt64KXO54Q862w05FGfqfHFRLjy0QJgTEguFTZCAgfIDWsltRISb+P0k3/KRKS/6T1ECr2XYPDYAuAk5GuKMa/guwT7ZFXcUd6JyncEc4AIlEH1ZuH9bnHatFglWeQuFf3rHMC1lN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOqnr1Oj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOqnr1Oj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso34526775ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786132184; x=1786736984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pjt4VBNA9RhvwHOG/dB1GY/jBYqoDr2m2fvZn74cx+Y=;
        b=dOqnr1Oj5pkhzSzIY4CJlicnS54FZQYGA7yXX40fSdGtXIieNcX1CTg6NLP+s2Mqcn
         U8ZuSf1OTy7FZ/93AijVG8V9wtaDH9dTQ4QRkvh+aQfBURRQmsavp7aps+3AYWwKyhX2
         6mScQnFn0bWs/FW/ZjaA8TEVt4Vbmb3ZuCtGgUo/xtjH0t3FvxuHpp6Gty/Jg52JZx9z
         qktbcRrzueFYKiT/QtDtkMgewVtZ7Me0RCUqmk5HGqX+ZDfajkL+ixkxyerSNIOfdLvc
         /bQxcsz3LZLIXkfZ76y4U+hWOtdDZ04MoDRD729IVfk7yAtfsOYBDAkow2J9rEfxCxX9
         QIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786132184; x=1786736984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pjt4VBNA9RhvwHOG/dB1GY/jBYqoDr2m2fvZn74cx+Y=;
        b=kW10OoNAfdyzIg76CJIxTssBowLM8P58emq+z/0KKtyKbnfApvKsOt6vJcz1ExTQvB
         nE/Pj1RLO2aFjA7IKGTFHkITEtbA9Gtm/VK/9jIMW5vW3fWKhFXUlEOXTc5kA7kw0yv8
         SNQiw3Ae+PE9xHXnPf7dizAvwtFyv8663hfSVmhgD/UvyR8n6SPm+u8HjKgtuc8HfgFN
         e2kNH24IQmaqQqiAVTkYY3qmTlugqm84GQ9OG44SDbG3IgtQeDVNn0HMmzH8Nz2Nd5MN
         MWCgP/6TxGFRY7omhxKa74fbnCizcRDZvl+BVPVjQk4EkFXp1u7gd+1BxA88xIOXTXw9
         ICZg==
X-Gm-Message-State: AOJu0Yzg4/M0X8BYYmrWdR6Q9i1VkvN0QczD+rzrsjouslNqlmhyqJPS
	LHzTucui8J7HdJ3ZrrdDQV7DEoQG/NcnD0HRCa0CD5PzItLtD419dXIPGJUkwBjsKJc=
X-Gm-Gg: AR+sD12F694UbvaKzLisJjzd1BrmtDA24xu2i04RhnuinHRYyedsPKmXZ+8aUyqqB3w
	R0Sis844ZO3swL+Rm1uOo9s5lDtsVAZhelrQl864C9mMdEm+4ZOpWHaGkHqRsjD3G40+TKGbyF6
	7ki4rjy8iDlT6DDI5DV9p0Ur57eavtaNyHpvXwBjbcImgXcXzV+r/hfBnT0+04BxqulFU91739v
	bjkOduE+rZdoeVdC0DRN/9PQ7CElVZZBhya7rFsrmnHzpZZTP6AJ2qd0EhJxGo/S/KiCHdwaXCh
	PigR9rY3/TR6dvCizu+VJede1VXqd0kmSBB4DtBZA9lHEJYTeiFdBS8H9dlDOGH0v2wXU7zN0ND
	yGprutKy4csr64T6JC5Mysg1M7BHAa/oQ2dXAGK6Nu8gM6ZCD6xQhWHFH3HHVR+FvmlQljmuMvV
	/wS2VXESh54+Fw01Ip9VqqLs/yE+9C2hGRK18dRj0NBi0Elr/NyOZ2HJyNEAUSJ/e7tS5+SSLNG
	RxUANdoKlcfbsA+4vwXQX82jxmTIVx7NEOPY1l07src2TX7q9PRmw==
X-Received: by 2002:a05:6a21:6e0c:b0:3bf:c223:4640 with SMTP id adf61e73a8af0-3cb85f4e199mr32087435637.32.1786132183828;
        Fri, 07 Aug 2026 12:49:43 -0700 (PDT)
Received: from ubuntu-openwrt.tail1b3f25.ts.net ([123.201.0.80])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm9527458c88.14.2026.08.07.12.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 12:49:43 -0700 (PDT)
From: Sandeep Sondagar <sandeepsondagar@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Sandeep Sondagar <sandeepsondagar@gmail.com>
Subject: [PATCH net] net: phylink: treat PSGMII as an inband capable interface
Date: Sat,  8 Aug 2026 01:19:37 +0530
Message-ID: <20260807194937.785825-1-sandeepsondagar@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PSGMII (the Qualcomm 5-port SGMII) conveys the link negotiation result
from the PHY back to the MAC through per-channel inband SGMII words,
exactly like SGMII and QSGMII.

However, PHY_INTERFACE_MODE_PSGMII is missing from
phylink_get_inband_type(), so phylink reports INBAND_NONE for it and
phylink_pcs_neg_mode() falls back to PHYLINK_PCS_NEG_NONE. The PCS is
then programmed in force mode and its control-register speed bits (which
default to 1000base) are used, so a slower copper link - e.g. 100base-T
- is reported as 1Gbps and cannot pass traffic.

Classify PSGMII alongside SGMII and QSGMII as INBAND_CISCO_SGMII so the
PCS negotiates inband and the resolved link speed comes from the PHY
inband word.

Signed-off-by: Sandeep Sondagar <sandeepsondagar@gmail.com>
---
 drivers/net/phy/phylink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 18d2ead97aa5..983a1a3cee37 100644
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
-- 
2.43.0

