Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAE48EC77
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045325; cv=none; b=t7hy/WNSnDBHKGXWIUKrS8FgzCTvQO5hxoyuszssPtF8d4iLGVmNPmBKn7cuolKrgccUHI0qWl8VPxKLY6jwwuP2RHDJihuuCtzLPzgvhLNoEeIxs/Tiw5TNxGJwEj39G+CUrtM9ETIGIk1vgC31yfHX50MXtUhS9DxpAm7JqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045325; c=relaxed/simple;
	bh=N/b/q/uzmSxos8Iew06bDzpCf5ZY+3UhCakxp4lntWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWO+sf78wgZBe9Khnctjw0h7n3HKIJSleaBEDdglM4+2la3JmQ3+WzXqvBqNQe7B13dcZ5l38Nt8OmJw9fo0i6MunRrlYIYcKQy4PdtzhPe+i1j3bXZo02GkcNIo6HyiDHRNx+MtodwsdO7dzWaZI2x9sFAbAjvXmKT1A7RWY4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6rIEySw; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6rIEySw"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4b39befc6a8so3828098b6e.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789045320; x=1789650120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iqDMD9CvlNAztFnDyHXHWtHzKTDStZHHy9fL//d1qZ8=;
        b=o6rIEySwIQFchaHtuU6jxOIUVB+KUVletT6cY/atCItj67Ylubngf3W1FGDabuPUrL
         T/EMlxsDHzsaG6C+ncm0d18o4VHHYoxLnWN55JWO01VkdO/qsseYbkuhM7Pr7JP/6rCP
         yp1TJHBNeo8b9O8Pa8fc3qksz74X9Fgxw1Ud7rw/M0eHkJrUYhqoZrCxoUbgPkMXIog2
         h3awtz+bhhDEjsT1DsDJCk5hymnDcVldGuDf9CdAr8kcWIvIMdg81YSZJzvwxtc9sf8w
         DVmuyQK0uXp6gf9NUldi3jlQ5RE+xFS5Q0zTL6W01nh+yaeD3BTTXUdR5mLH7GiA+5mn
         4HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045320; x=1789650120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqDMD9CvlNAztFnDyHXHWtHzKTDStZHHy9fL//d1qZ8=;
        b=jXpWj0+6OiUzEQDNwC/3JG0WJL9jYZZYV72qJB8ugpxwMqYRJmsxqzU3HnJ9J6eWFt
         ftEz4lta3p3k/foPfOpB43aoIHScn2TfpHMBUH5vHPCj1FKh05ZrhixXEKFtOktGELjJ
         43V3B0+rws8A7qh+gefcUiJAEWkEO+M8InBJa0xvAkkFV+lFXtK7wMfTQg3rw5Dv88o7
         1gwMJLzPcJ9LS6uwTFTevbBvxxpWWNOzKloThT1dWtKE7xv5Scs4GY6Ka5rQBvv5XSU8
         uRAq3+cuTAlOhKLfl5pxWk5trAJ6srqQbL7sqKZS/OmhVJb+SafAH0SY2PrzTdkDL3D7
         09xw==
X-Forwarded-Encrypted: i=1; AKwUvBzIpgXnT5nyfaAbOS+lYy3HMU7OQIH3xKf4G3Y1qrc41geHthntLv1TTCl1L4q84tqis5x5MOg=@vger.kernel.org
X-Gm-Message-State: AFuF++lmOali9AiKr6vx7D9KvtBZxSbwkCA6eGHFEgQwGL4gXtu7kZ3s
	/84GGSjCKv+1iIZZKeqgPygY1tsBqOLK4T0+tQ1csmgsdSlpY8iKH2BG
X-Gm-Gg: AYBFou2VnJZcp2w8gu+rayMeS0JE700qYzvg9o0IWA74+4yGx0R1o2ALKTjCakZOSDj
	yLvnUy0hYPnC/cWztOjIrtEVF9mnM4qUDU8N4AtPfICRLCT7NDFVXujkTzo9iZ+UKgRqrZzK6L8
	+0xT1rbq5LCOWZyffa9ULylHBSD0qU6fJt6JrWguzjNbbnkmdbstXlnWsR6fS2i0DTyxd24TMLz
	qD4+DH8NC7mMNVduYUrbPxOu9SnqIxRnAX7PA+cZmdMhs5PAJtKrPEXCtaP1NWz0EBmJ2B+a592
	Yv+17NJkEO29+ee6dGwLJ0vQfd1dRXal+crLKpYOmjG00F/1P325zhhbdFD3ZNyYDBSC5oBZ5RN
	s4gbehlsxXAd/3gfOfLXi9z0MCglG/rOzcgP40DYnuDJ2GUbgRUZpIVjH+3wZLNGZMJqkfFQORR
	an01QSiMWgAs2YceIcmowx5gGYiIykEXCqJE8Lpml8EgIyzSFfb/cMmiX/11F9BYeE38gZuUhBf
	bREpnByV6TvEfdoOafF/LR1
X-Received: by 2002:a05:6808:d4e:b0:4b9:a829:f00f with SMTP id 5614622812f47-4b9a829f90cmr21412378b6e.27.1789045319616;
        Thu, 10 Sep 2026 06:01:59 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.135.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4ae9cef7dsm1250087a12.28.2026.09.10.06.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:01:58 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javen Xu <javen_xu@realsil.com.cn>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>
Subject: [PATCH net v2] r8169: don't enable chip LTR when the platform has not
 enabled LTR
Date: Thu, 10 Sep 2026 18:31:40 +0530
Message-ID: <20260910130140.910-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rtl_enable_ltr() programs the MAC to generate LTR messages - ALDPS_LTR_EN,=
=0D
LTR_SNOOP_EN, LTR_OBFF_LOCK_EN, plus LINK_SPEED_CHANGE_EN on=0D
RTL8125/RTL8126/RTL8127 - and rtl_hw_aspm_clkreq_enable() calls it on=0D
every ASPM enable, then goes on to let the chip trigger L1.2.=0D
=0D
The only gate is tp->aspm_manageable, which records that the OS is allowed=
=0D
to control ASPM. It says nothing about LTR. LTR is a separate PCIe=0D
capability that only works if every device on the path to the root port=0D
supports it. The PCI core works that out in pci_configure_ltr() and=0D
records the result in pci_dev->ltr_path; per PCIe r6.0 sec 7.5.3.16 a=0D
function must not issue LTR messages while LTR Mechanism Enable is clear.=0D
=0D
So on a platform whose hierarchy has no LTR path, the driver tells the=0D
chip to start sending LTR messages nothing will honour, and ties ALDPS -=0D
the PHY's link-down power saving - to them. A report against RTL8125B=0D
(rev 05, firmware rtl8125b-2_0.0.2) in a mini PC shows the effect: 291=0D
link down/up transitions in one eight-hour boot, with repeated downshifts=0D
to 100Mbps, against four transitions at boot and then a stable link on=0D
the kernel before the LTR change.=0D
=0D
Gate the chip's LTR programming on pci_dev->ltr_path. That field lives=0D
inside CONFIG_PCIEASPM, and without ASPM support there is nothing here to=0D
enable LTR for, so compile the function out in that configuration.=0D
=0D
Note this does change CONFIG_PCIEASPM=3Dn builds, which used to program=0D
chip LTR unconditionally: pci_disable_link_state() is a stub that returns=0D
success there, so tp->aspm_manageable ends up set. The PCI core does not=0D
configure LTR in that configuration either.=0D
=0D
Fixes: 9ab94a32af70 ("r8169: enable LTR support")=0D
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2529752=0D
Assisted-by: LLM=0D
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>=0D
---=0D
v2:=0D
 - Gate on pci_dev->ltr_path instead of reading PCI_EXP_DEVCTL2 directly,=0D
   and compile rtl_enable_ltr() out for CONFIG_PCIEASPM=3Dn, where that=0D
   field does not exist and there is nothing to enable LTR for.=0D
   Suggested by Heiner Kallweit.=0D
 - Commit message notes the resulting change for CONFIG_PCIEASPM=3Dn builds=
.=0D
 - No change to the RTL8125 register programming itself.=0D
=0D
v1: https://lore.kernel.org/all/20260909110554.1977-1-yogeshgaur.83@gmail.c=
om/=0D
=0D
 drivers/net/ethernet/realtek/r8169_main.c | 13 +++++++++++++=0D
 1 file changed, 13 insertions(+)=0D
=0D
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethern=
et/realtek/r8169_main.c=0D
index ec4fc21fa21f..05f7a44aff01 100644=0D
--- a/drivers/net/ethernet/realtek/r8169_main.c=0D
+++ b/drivers/net/ethernet/realtek/r8169_main.c=0D
@@ -3035,8 +3035,16 @@ static void rtl_disable_exit_l1(struct rtl8169_priva=
te *tp)=0D
 	}=0D
 }=0D
 =0D
+#ifdef CONFIG_PCIEASPM=0D
 static void rtl_enable_ltr(struct rtl8169_private *tp)=0D
 {=0D
+	/* The chip must not issue LTR messages unless LTR is enabled on the=0D
+	 * whole path up to the root port. pci_configure_ltr() works that out=0D
+	 * and records the result in pci_dev->ltr_path.=0D
+	 */=0D
+	if (!tp->pci_dev->ltr_path)=0D
+		return;=0D
+=0D
 	switch (tp->mac_version) {=0D
 	case RTL_GIGA_MAC_VER_80:=0D
 		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);=0D
@@ -3120,6 +3128,11 @@ static void rtl_enable_ltr(struct rtl8169_private *t=
p)=0D
 	/* chip can trigger LTR */=0D
 	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);=0D
 }=0D
+#else=0D
+static void rtl_enable_ltr(struct rtl8169_private *tp)=0D
+{=0D
+}=0D
+#endif=0D
 =0D
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool ena=
ble)=0D
 {=0D
-- =0D
2.34.1=0D
=0D
