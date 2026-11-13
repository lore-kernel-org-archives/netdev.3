Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604583;
	b=4/9RSzy5tWWCy7adrZyhS2h7yEZvJitoTOrClYV1QE2qGICPZFasBO1knjfp/qehK1sb
	 i7FTtB9s31LW+45RWgPmpD1yzPbSgdZazzKudZgtqqgiYNN6YnscoLLiIsfRGEUQF9vKL
	 MasHTNwf6kloanNs9hv1vZKsQspon8Vf54g1m1w2afsfXC72EM6In7shs+UvpAdVERrmQ
	 hKgDhCwPHWG/6jVwFuUZ0sU5OfgoZInpGiyz7e8PlFeHA0Esv0RO3i36sC7RLTcyV8Gkf
	 LWjUazM2+BAjQW/6gGxqIHxdcmOHpY7WDoRTq73AepazqurF2EYR+fbMP0KEwp96BTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604583;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=RQ3Vk/jpF+XnFd0d9LPtGNns0WkiwbIRfoIJESI6ZNE=;
	b=Fvrv1sAvPEBD2cQvzTGtjPsx+XbX8ac3UzS+W18w3YX96uakUxtesXT9dsD83jnFG18w
	 BJ0ePOq54tun/6bPqiKvbGbNx0KbzgBRxB0bNr5GiHJ8kLB9XeMjpR/6CQLMAkxD3n9xO
	 9VBl3VH3CSjRu9/hxiKRUyM1Oc+2kDIqlhLblMMjgsrmXdTmsvYff1CppFZznuXbZAvkU
	 yijPaqYat0dG8GGykctmqlV3zGCfSehELxpXbtr3KLprdglZ8B1K+8R0+wZC6LrDViBCr
	 +aDGcbLFOSQOVjh3cnkdBTt97fYTvI0vHapTVuGLKLORvRSOp4RZZEJgQVHm+evoGdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Jb6BfITW;
	arc=none smtp.remote-ip=209.85.214.228
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F87606A897
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 21:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F87606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Jb6BfITW
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2ede7cb02daso18292095ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604582; x=1795209382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQ3Vk/jpF+XnFd0d9LPtGNns0WkiwbIRfoIJESI6ZNE=;
        b=QTLGGPIPqtq4hDS+cQFe9uHNSVaquNkiRGls6OUx2votCz5vcC4KHzQGtMfcmLfhJu
         F1rjBH2JCYWh0XpjqUT22LOYbwkN4BA5EvBbWGQGkI7J5OanIGAdnuUrSeFlnWsk8DHD
         9o5bAgEdS5xGDNJ0Hguh2mgQ0QE0R3hL3mpAb+5MefDaqAqrkK+XoMdKxClzrJvpn8tP
         kLilHCy6r56B3HExbOd02dcsgVtr0+tCDk2qxFs5iFRSpVYNH7n40qPmqkC3QQfT4csg
         NgM3MH/bE+AuBqDZukap258sVBNJzifPkFSfWTBlIX/QAFSroiAOrmqz83L4B2P8jNAs
         jt1g==
X-Gm-Message-State: APuU4Z8gpy2drmarGsBBtNhqWHHWJpSXBN3K2Xxovx9SNORm6lKrFZAF
	kLwPdSyRI40g3ZhvDCi/ddUDq4Ln83rs9ZrhD81fNbwM1vnzOJcyy/6GoR3AT8SVh9KhE7ieK+M
	Hheo2aGqzRXUl4zIR584C0KNXAuLPN8ZW98Tjl4U98gb3i1YEpUmlmlCVQzhFVIYdLu6BuT4rua
	1o6KMbeQunwqvbm+Iof2Syk8sZPH1To6SrxZWf/ppyCIbrB7MVFTeqS2eAqFcgyloSCzaipV1Ej
	t1EwehIwxKWO6nb
X-Gm-Gg: AYBFou2pzMJqKQ2zNLbp41ps2Y5mg7wGj3FLsdRLnl/UhrVaGhCVgCMkpl0XJQlJaeQ
	sGhbuxoId/3wCF+nBIU35w1KtPh4nQ8isyj7IUMbmFv0GEXJJxiMY/xwvbbElY263gaZBwHNs0h
	Iti/Hqn4RdtS+IshOY7cEX/vaQbbh8H35pWDT2sO8t7iNT3K978bKGXHDxRM7NxcPhfAGNferQt
	gIVL8rreymCkLyKDGWHjg9MvY0htgfQsBrQEgrsew+C3gwRM2s57f2B3DVjU5hhGNiZH6WpJVbU
	GKoKT2IpPKRT8siwhG5Ak4MSfVqiahQ70j4yEDe6kBbzmncZSxxmpXEZyiRqrta9O9R+PWvKCge
	0tE5IDdpL/SkoG+iukOuvoRC2PtlXzK7E0KJgIL7p2mOwlIUJHRsg6DQ06WS5Qkn+V+RFFxCmxP
	AOUTuwDkdUDY4B4Z0LKqPGN8Aj2FV+1uvGB3PspCUX
X-Received: by 2002:a17:903:3784:b0:2ee:81:1714 with SMTP id d9443c01a7336-2ee00812091mr23035445ad.32.1794604581528;
        Fri, 13 Nov 2026 13:16:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ee0f89475bsm1596685ad.35.2026.11.13.13.16.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:16:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb93c874bso503536985a.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794604578; x=1795209378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RQ3Vk/jpF+XnFd0d9LPtGNns0WkiwbIRfoIJESI6ZNE=;
        b=Jb6BfITWlRyjsDPa8qKBUEKle2bAzo3W8WD5Z9o9QJbmoqKRLM4YeIUomRl6X/Q6Ol
         DveSqc4kF6F9ElQG2tbB5Nex0x5LSt9g5vx9GTJ6ZzkfqYky9AYdI9drFTb0zKR5gEzg
         3JIYAaogq7Mrnk7gpR8vI0DqQoGigsL9MBJ6U=
X-Received: by 2002:a05:620a:454f:b0:945:d3ba:7d99 with SMTP id af79cd13be357-9494bc2d68amr607929785a.37.1794604578371;
        Fri, 13 Nov 2026 13:16:18 -0800 (PST)
X-Received: by 2002:a05:620a:454f:b0:945:d3ba:7d99 with SMTP id af79cd13be357-9494bc2d68amr607922885a.37.1794604577617;
        Fri, 13 Nov 2026 13:16:17 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8f92bbsm273474385a.40.2026.11.13.13.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:16:16 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	Mlody12 mlody12 <kudzo51@gmail.com>
Subject: [PATCH net-next 1/3] net: mdio: mdio-bcm-unimac: Define MDIO_OP_SHIFT
Date: Fri, 13 Nov 2026 13:15:52 -0800
Message-Id: <20261113211554.2058181-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
References: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The MDIO_CMD operation code field starts at bit 26. Define
MDIO_OP_SHIFT for it and use it to build the opcodes instead of open
coding the shift.

While at it, rename MDIO_RD and MDIO_WR to MDIO_RD_C22 and MDIO_WR_C22 to
make it clear that these are the Clause 22 opcodes, in preparation for
adding the Clause 45 ones.

No functional change.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/mdio/mdio-bcm-unimac.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 31e396cc9fbf..6df824aba75e 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -21,8 +21,9 @@
 #define MDIO_CMD		0x00
 #define  MDIO_START_BUSY	(1 << 29)
 #define  MDIO_READ_FAIL		(1 << 28)
-#define  MDIO_RD		(2 << 26)
-#define  MDIO_WR		(1 << 26)
+#define  MDIO_OP_SHIFT		26
+#define  MDIO_RD_C22		(2 << MDIO_OP_SHIFT)
+#define  MDIO_WR_C22		(1 << MDIO_OP_SHIFT)
 #define  MDIO_PMD_SHIFT		21
 #define  MDIO_PMD_MASK		0x1F
 #define  MDIO_REG_SHIFT		16
@@ -99,7 +100,8 @@ static int unimac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 		return ret;
 
 	/* Prepare the read operation */
-	cmd = MDIO_RD | (phy_id << MDIO_PMD_SHIFT) | (reg << MDIO_REG_SHIFT);
+	cmd = MDIO_RD_C22 | (phy_id << MDIO_PMD_SHIFT) |
+		(reg << MDIO_REG_SHIFT);
 	unimac_mdio_writel(priv, cmd, MDIO_CMD);
 
 	/* Start MDIO transaction */
@@ -139,7 +141,7 @@ static int unimac_mdio_write(struct mii_bus *bus, int phy_id,
 		return ret;
 
 	/* Prepare the write operation */
-	cmd = MDIO_WR | (phy_id << MDIO_PMD_SHIFT) |
+	cmd = MDIO_WR_C22 | (phy_id << MDIO_PMD_SHIFT) |
 		(reg << MDIO_REG_SHIFT) | (0xffff & val);
 	unimac_mdio_writel(priv, cmd, MDIO_CMD);
 
-- 
2.34.1

