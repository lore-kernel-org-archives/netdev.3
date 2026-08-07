Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C1135A53
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138256; cv=none; b=G3ZIOUyFmTRpQVqsh4ly6CEO20ZvfUdKrZI0FbjiafXG0x+eK0Hv4QjrYaCfPJbR6JrK4dkBSpb5Iee3jB433gsNvuorbNLfXSeMvo9LeR2Z9fiiDek+hS8oCQJQ3GoPsa5NSwbRP3lfybE9+tzR3GWrvgOTsLk+TqLhPim2dcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138256; c=relaxed/simple;
	bh=AVzdyQJUrM+8wlroWY+3HVSUiUmjQ1tLsS7jUjuMWBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1U9XVrEgdPUgsIZNR5sfoBW1UPAVbsboJUwXxQ16kwpzgrjmdy2R1GVuL267IBqqkwZ3RwX+LV407wyDNArfRbVux+oxPTEW249phJTBHWhy2ScpCQOa1ssORO43nc/tTusgUHxTbUh5nmg+XB8b+/iuur9Q6FaJw6p6DKvHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myTk8/hM; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myTk8/hM"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15e0279316so154179466b.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786138253; x=1786743053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H6IV52QIobw2DVzKpoVxCneWji2rotbUjjk9kXim9TY=;
        b=myTk8/hMahUIqGUkBfPCk+cjaq6s3PA6kza+/ZatZ2UvM7a4PnvJIoAL8MFPPQXiHg
         U+eff7lc6dWMcKz1MgXyYhZ7CjUUPeDOpKJCkJ5WS3zUXFX2Qi6X42vJeJdF7Wt2WOy+
         gy7c3X6bxYAK8vX2UxWRpPcwTmdVCIpNydhh1+oXNXm5NZnBq4w+Fy22aGbbZbb4QIKa
         XlipX6bYQ1KHd/7emmIAJZ3+B/KonR8IcYNOCE/uLKZBMvCBwK5zOhWfRD1U+1eqaUJ5
         cgSmlGjAdHptR1IongrB5pT+kwpDkltlJpXIJAoNqhi1c8qJDRtfkq8KmW8zOHnGwlzJ
         EC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786138253; x=1786743053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H6IV52QIobw2DVzKpoVxCneWji2rotbUjjk9kXim9TY=;
        b=ozy9eqN8aAb6WpP2i5v7xz/9jiq83TaWqTKzxf4MuCJFU7mMmQVRVqoToo02pkmEaX
         e6++FESFNE/xEWQK/GoAwznbkEpjciJS3hVaa6HRJ0QeCjgKe+ttVEtzlzB/NsbjkRNF
         RfjugGrLAPJ0qAE/lCFDjZIKNL1BT1lPgoHHXaw2YK/Tp6tRIpM1PUhL8NmMno2xeHxf
         MtwqKRdUXF44WQZSickq7DhoN1fjszD1vU5ag5q5p9mlsXZf1g9/yAn0OUwDK9F46JX6
         d+S+LYX17QlyhlYcZcE+LoWMmxLJC4oZ54DZ7ZEjdjij2IJ3w0tkGflK/hrKg65bajAm
         wOog==
X-Gm-Message-State: AOJu0YwXIUf6sI/O5UeewVfN3Op/5wEc4P1OARRTrTOVyYgOefHGxOVq
	z5KV2HnhzB4LGbP6UubCO8EC1Rt+HE8oOuN8uUOdeOKULLfipJItAGAk30ZJ+GMWmplHc3tA
X-Gm-Gg: AR+sD1389bpCdP8pz/2K3O8WzWIH5LUBPv8ESmu/GQ2mupsa92oAR+1Lx5/zYYBIlL8
	7qsOmis1Dez9jAI54IsAxnGVuqCl5vDY/lNPlkroyqVXt0R2VH1k+p4LQODjE/4aiIqx0ELzGVN
	RUgmObJDBt34nW+AkaPPccStuscdax7tegAMWQUArWTLWtpxyCADVD1n1jKFYt8AiKcILFMgfq7
	2Y+bzT2S/az+SNXTqjUOTvIvnfQFwuDk6K4C2Q6291nzSLAfHgoQ123o7aTtKnJUf4Fn22tTgvj
	z/QwSN7K8bMWwmJsPtkMjnEV4QG9rGUJKr/Zsy58UX/0Z4g1UuSPDJsOXryi2CkEqyDTcHk34X+
	w7y2wD/11LYxtNCDfjKjJMFY1OY2WcKjFc4nB8G46C+wR0dBOnYlUughDmSm9DXsy/zZQ8tHC+W
	wR+wTgYojOSQ5GYX1QDg3j0T9Tv/2Ni4D/iLxO0c3bkjXp9DYFT3Ox3fQwTl5nD8FJmWD0zFW0
X-Received: by 2002:a17:907:1c01:b0:c12:b227:614b with SMTP id a640c23a62f3a-c2087558b24mr156450866b.27.1786138252660;
        Fri, 07 Aug 2026 14:30:52 -0700 (PDT)
Received: from linux-kernel-git.home.wilm.ink ([2001:9e0:862d:9c10:be24:11ff:fee2:1f8f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a63sm95746066b.8.2026.08.07.14.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:30:52 -0700 (PDT)
From: Xander Wilmink <xwilmink@gmail.com>
To: netdev@vger.kernel.org
Cc: Xander Wilmink <xwilmink@gmail.com>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next] net: sfp: Add quirk for Dell M14MK module
Date: Fri,  7 Aug 2026 21:30:25 +0000
Message-ID: <20260807213025.1206-1-xwilmink@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This adds an quirk for the Dell M14MK (S28-10G-25G-SR-85C) SFP28 module.
These are short range fiber modules, and should advertise 10000baseSR/Full.
Incorrectly these advertise as being a copper module: 10000baseCR/Full. 
The link fails to come up, and the kernel logs "unsupported SFP module: 
no common interface modes."
With the quirk added, the 10Gbit/s link comes up.

Tested on a Linksys LGS328PC with OpenWRT SNAPSHOT version:
OpenWrt SNAPSHOT r35298-2a73f02e56 / LuCI Master 26.190.71895~a18dc50.
Ethtool advertises now "10000baseSR/Full" and the link works on 10Gbit/s.

Thank you for your time.

Kind regards,

Xander Wilmink

Co-authored-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Signed-off-by: Xander Wilmink <xwilmink@gmail.com>

---
 drivers/net/phy/sfp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 6c25b73c668a..64b4ec08f28a 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -477,6 +477,13 @@ static void sfp_quirk_2500basex(const struct sfp_eeprom_id *id,
 	__set_bit(PHY_INTERFACE_MODE_2500BASEX, caps->interfaces);
 }
 
+static void sfp_quirk_25g_10g_dual(const struct sfp_eeprom_id *id,
+				   struct sfp_module_caps *caps)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
+			 caps->link_modes);
+	__set_bit(PHY_INTERFACE_MODE_10GBASER, caps->interfaces);
+
 static void sfp_quirk_disable_autoneg(const struct sfp_eeprom_id *id,
 				      struct sfp_module_caps *caps)
 {
@@ -523,6 +530,10 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
+	// Dell M14MK, 10/25 GBit SFP28 module. Labeled as Dell S28-10G-25G-SR-85C.
+	// Runs at 10 Gbit/s in a SFP+ port, but does not advertise this properly.
+	SFP_QUIRK_S("DELL", "M14MK", sfp_quirk_25g_10g_dual),
+
 	// Alcatel Lucent G-010S-A can operate at 2500base-X, but report 3.2GBd
 	// NRZ in their EEPROM
 	SFP_QUIRK("ALCATELLUCENT", "3FE46541AA", sfp_quirk_2500basex,
-- 
2.52.0

