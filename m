Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE458B6DA
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986606; cv=none; b=VdrhD1jeJHvQekOnrvAIfLddY65lArGlDDtpFV1emuCC2Nr5pqKu9E8Cp4KOI0X8ab4zmjwbre/FSoDTbOjKhzzUoITQE6xkO4cy1Xu/Ah9VxHq1bjFUMG2iTocBb7KICuS/NiOfnbWyjbKZhlEjHBuxQhg7OSL6vB6tWaTs/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986606; c=relaxed/simple;
	bh=ms+wPxxykgLhoZIPeEqV1SUNEDq6O/wPxWyQ2fNzuOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLln+k8o1EOBe58nHr0ObW74bjrcUuSMVGtkWzhsmzg+TMkrfmHnrV0abxmhRh6dkYDSCA1riFwvt8cWao8rcwxfvoSvuSgaCb7dau+z+gFcB7fMxyAgrB9p2xn3fl+YBADzy0/IEeufw8zxo964DXfwMV3IpdG1V0q7So7VMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=am39DyZ5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="am39DyZ5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48441a2ba14so5329257f8f.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788986594; x=1789591394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MCT7Y2OFjhcDKKihQE5DUJP52LKyDCkCXjyba/ItNY=;
        b=am39DyZ5bpMeXNn/GKFma2YAv0wQ7iOBY6EiZSDBjgVlL2BFzvjynz5WjHSSp6WJDx
         vINt9mbwhWnE/gzo0WpJMr9aJRIrg5J2/IpqLPcAR2WvWD1ZLgO7DeGgP6JiWBt6Eayf
         mvmKu+L9amaBXOmSQq9xGD5q75//Pw4g7A+fTrrUlycXSstclYg/xV31S8fWUd4wJKnV
         qsAN5FSrPqF9qa37bAjF5OamAXhWIFAOgE37+s6AzvMiYhMnYGtU1AqKX8DdzUwN+YuV
         lA6Y+IU4OtPFdFOcKeawKIzmNJ6D+UFNXjn8qRW/JE88ecU/S3us5fH8tx9mheHiSpTg
         1P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986594; x=1789591394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0MCT7Y2OFjhcDKKihQE5DUJP52LKyDCkCXjyba/ItNY=;
        b=i3xw9XoQnVW7tSQHVuPYdsyebIrutx/3eB5N9zaopTx3PECsJuDU1CZGqYB1ouqHoz
         bMp43BRsvOfCvoKO9TjCL9UAIoHbuE5TQpXwQkJIIgOz4ax944TdFqPT/5b6XQNaHa59
         ARlJJUMZB40wbnYGsKs1sfFrrmLeGCeWGvZtj8S8g8e/Z9Jv2isWTfAUWMm+qBW4HgG+
         uriGzCeQ0TKIK6II7odOroG+SkKhq/+YA/HNfw1fEX/Wt9jE6RaOrckCju8s6+LJ80zf
         RowkrKu/+/GOjpSSRBnouii7qlzXDMPt8BA/tRvZcX4YaJo9OHO1ZI3Sr62l/7zKkDzB
         Xq0A==
X-Forwarded-Encrypted: i=1; AKwUvBwqmkQ9VktWciBFPrWjJWUAbiFXPVeIKI4LtSGUOgoHVOCr5pMYTr9/gdw3X5T0tEiVAI+pMS4=@vger.kernel.org
X-Gm-Message-State: AFuF++lXt3KViCqDFIbbpRgImV4FV7+VGxUfpI7tKVINevtmtKHYqi1c
	ZJRaCZ+bA+8f63POPd7X+a/JnnQWMtdKWMJ7d4hlHhjcS+1kmpd37YJKVviLsLt0xzyn2t6aeQx
	vNPpRWjpBG8kDbPY=
X-Gm-Gg: AYBFou2yawcjca8uUWQePWTdcux92deZIEomy4UlRNPipcFv1JVSrgWrkO4H8xB0QhB
	Jt9lnxaxPG1ktrPkGnmGLLA9IuTJ/vV9sn7X45s7gJlclQTKoyMolZ1hNb+7ZoHJEa1qSnSflOV
	bDIE0EktLqHtYUBv4r+uSuqprmZZECj3gFW4gP3EB5GQVM3G91h5NtPhqjHrRhD/KOKIPjQazqt
	kJGspHlzT2n9DElY6jQ2uGSaHaZEYTy9Amwjhxez//93EDfRXARmGGehMA57HAIhY9KFLwd59D5
	6rnscKV16yue+ZmIItVfDzhZGgIItDK8uCs1dn8ihcDgAiQS1MuRClQBcXL0BJLI1grloxKfSlg
	56IjnSesF9i5tOlNgcaFo9k9Gkkxrmvflb4BSEEKyhi/cZkmhqe55a2i/KlCwOTDmX/oG8X767R
	8L1K8LKgV0+j+5pt9buRK8U73h77ZeYyg4bnWBFIKomNINBQhZkA==
X-Received: by 2002:a05:6000:1785:b0:485:91ac:434f with SMTP id ffacd0b85a97d-48591ac44a5mr29197734f8f.16.1788986594389;
        Wed, 09 Sep 2026 13:43:14 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm40693606f8f.9.2026.09.09.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:43:14 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v7 2/2] net: phy: take the interrupt back from the bus on detach
Date: Wed,  9 Sep 2026 20:43:06 +0000
Message-ID: <20260909204306.2374562-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909204306.2374562-1-f@lex.la>
References: <20260909204306.2374562-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY whose own driver is a module on a filesystem that is not mounted
when the MAC probes gets the generic driver first. phy_probe() replaces
phydev->irq with PHY_POLL because that driver has no interrupt support,
nothing puts it back, and the PHY polls for the rest of the uptime once
its real driver takes over.

Take the number back in phy_detach(), from mdiobus->irq[], which is
where phy_device_create() seeded phydev->irq from and where the bus that
described the interrupt still holds it. Detach is the end of every bind
cycle, so this covers the two substitutions phy_attach_direct() makes as
well as the one in phy_probe(), without any of them having to record
anything.

Doing it here rather than from phy_remove() keeps a single writer on the
rtnl side. phy_attach_direct() is what reads the number back and decides
whether to request an interrupt, and it holds no lock against the driver
core, so a restore driven by an unbind would be racing that decision
rather than ordered against it.

A bus whose driver writes only phydev->irq and never the table is not
covered, because the table then holds PHY_POLL and there is nothing to
take back; lan78xx, smsc95xx and sxgbe are in that position today and
registering the interrupt with the bus is theirs to do.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/phy_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..84e2da81dbd3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1969,6 +1969,11 @@ void phy_detach(struct phy_device *phydev)
 		phydev->is_genphy_driven = 0;
 	}
 
+	/* Whatever this attachment did to the interrupt, the bus that
+	 * described it still knows the number. Take it back from there.
+	 */
+	phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
+
 	/* Assert the reset signal */
 	phy_device_reset(phydev, 1);
 
-- 
2.53.0

