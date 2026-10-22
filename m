Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703477;
	b=bhaRnyl3hx+tUOibzw/DytRZiY4S5GsPMr1RBtVA/yN01OhikBO4ICCgRTdeiMb1Y6c4
	 W6ob4YZ/uP2A6mDnzDOI7MTf9I0FY0WNJGhII0RAvtZzgbUHRP3vgzTw0fCMNuU8MyxpD
	 H2YoiAadNglmC9VTHQ63vZVLjtuAapEf0Ijwp+1ZEIdbFFeFwfyG/j3iPyjK89d7Puo4N
	 WQIFixJG4YIhKB4i3Kv9DOONye5hGRV8Z7j10FppKkYxrJIrwsvKUTT18KDrL+Oe+rnh9
	 e63nGsOm5JGCTowMhn8aewq7os7I0PQWftXRUqCT1hEbcZPI9bn73sfSnyGY9Vg/mXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703477;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Jr5rPi7GIbeiqhpTp8DgZlKeEnkXJuQx6KaG0JPkgb8=;
	b=HtlqPhASewcJBE8857CmCk7ZiWT5mPIEY3gAuEXVo67ClwgHV4rondiQxtA77saNxSc/
	 RBs2pXHabo7YIh1woKoylLksvZ0z0MoGN837cXiYRxOBLMdhefiYSNxHilUwES9oY6444
	 5olif3d2Ib6j7l3/fS18ZftN5cKTEjSRf71EUvVsOp3yCLGZsr5IyX8ddUIpDd1ORr26x
	 Xq2g8CuVl7wdBBQAzaswk102SrWOCScByPu4Pt0osKA/EuPajUysWSmTzKgYA0jU0gMFS
	 4l1nYEasIV35t+xiNPJyjt3zV3ItYfWXogS5OncZQgbWq/ZLmR+NLcJ0jPk425J6ugg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=doXHLztH;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A9606A31F
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 21:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 542A9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=doXHLztH
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso144953a12.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703477; x=1793308277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jr5rPi7GIbeiqhpTp8DgZlKeEnkXJuQx6KaG0JPkgb8=;
        b=u4Y9R48TbICNilq3qO2s3q5biRyS5TGZE2V3ruscZWO4lH+4FXUdgmYubX6u4kGWPh
         uRoDHJM5BkbHVOGCTEAqQAssbXj1ReRMUysNIM0i7MPCrJi8TaSXwILbTDMbHg05jCeU
         FzzPr9SC00Kdyoeh4f/uLtLNP1IjaO4lq6LgZsrCFR6O3rBneTzjr6ChD9LXFBjgBZ4i
         jxM5b1Tu7TJnzYvsBS3mxgE6ZsJhyWmpcBuc5Yr8wMIPBcjChUwM/bwWjuFCwNo0vUDY
         gZJ8ebpDLIu2ZkzrOMfYNmfgyZ1QPq5m9A9TGPrmov6ZFCgfnsel8eeBgBZsJ+4QoV4h
         +DLA==
X-Gm-Message-State: AFq9FYIcPMBRysmC+bfY1yW5sOGKhuWLuaQxWaRUy5mH5bLCrBA/cIGl
	VZGbQkhlQoIXu2caMTSx/xM9e5UT7GLvzxtvOuqpr7q1aPPYDpzGptw94B+02xVK5R52DP8u4Hf
	wKrtAw3jRYPxBHAd8HE01t7DGEDgxaWROBIKHN4BUaBC1U87p2Dpmd+mxrqTzFqM3mnq1FG9zFo
	92PSBJvk7yC1Kaop6Lb3PVTDmd0fQLZ4jml5tflo7ZUR2qq3kX8dUzdebLnBkWNIy6MzUCklHQt
	1SMa0TQWEjYicEC
X-Gm-Gg: AYBFou1FQHBl8VNLt6oj1UBhZylcvLX4FPUwVn4hveyM0iXb6ymqoU8lTxpDQO1NrUm
	723e/oypk95ZRamdAHJyVbUAI2QKlPi+pfHrMGqQAlIGEAYSs3tS0J/A3W8/vaaSnl+6PCJVdGK
	ZgGCL62dsMb2CGi9HcYqPKDGGb2fGf84BbAiszHJqPSLcvu+ZDvPrE1ohLOYIX7Gc7VpmbRrIuc
	BGtTjDN6k+jzSfINKxxa/IOIe3YkFeqKxDUz3uZRPr92FtQPWBykPYKPX9VZYdOP8sup8tXQ8dx
	oVruXjKqR8B+Yjs0hxX5QJZjd4oTgqz2a7/mMNG/Xhc4z9Il6+uMSb8HYQj5DW9yNyxYSvuT4/c
	DWupy9Lvmv16Pu7BqnA25VY3Y2/74b8jDeeBfv/h1huBbvGtwNT9kdDmdMRuSU8I86gFeWQ283a
	RfvsvGvWxg281ZGO6Itj43KDnExat7i2P0ZiEhT9EuEcY=
X-Received: by 2002:a17:90b:35c6:b0:3ab:c80:9370 with SMTP id 98e67ed59e1d1-3adcdfaab1fmr108285a91.20.1792703476573;
        Thu, 22 Oct 2026 14:11:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ada488f07esm2973081a91.1.2026.10.22.14.11.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 14:11:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53397338004so5171191cf.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792703475; x=1793308275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jr5rPi7GIbeiqhpTp8DgZlKeEnkXJuQx6KaG0JPkgb8=;
        b=doXHLztHi0vD8wGQ+eAmWYSDIJUs15j3Mjeuh1wUdUQFE3Cdf4XvAx4XXJ45sGXCCl
         irlIRhG8/qDS3P47zl2NS076I7vh0VE409L7R3/tplLwOMzmuM/1bu66FjnOR+frO1o+
         /tMJe+pOK1/vCoym9sAC533XwRYqkhqONioFo=
X-Received: by 2002:a05:622a:647:b0:536:64f4:45e with SMTP id d75a77b69052e-536c259a058mr2373251cf.50.1792703474734;
        Thu, 22 Oct 2026 14:11:14 -0700 (PDT)
X-Received: by 2002:a05:622a:647:b0:536:64f4:45e with SMTP id d75a77b69052e-536c259a058mr2372651cf.50.1792703474145;
        Thu, 22 Oct 2026 14:11:14 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396afa91sm2472036d6.11.2026.10.22.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:11:13 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
Date: Thu, 22 Oct 2026 14:11:03 -0700
Message-Id: <20261022211104.2091128-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022211104.2091128-1-florian.fainelli@broadcom.com>
References: <20261022211104.2091128-1-florian.fainelli@broadcom.com>
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

Northstar and Northstar Plus use a 2.5 Gbps internal link between the
AMAC and the switch.  BGMAC_FEAT_FORCE_SPEED_2500 makes bgmac_miiconfig()
configure that speed, but bgmac_adjust_link() subsequently replaces it
with the synthetic fixed PHY's 1 Gbps speed.

Use the forced speed when processing link changes so the MAC remains at
2.5 Gbps.  Together with configuring the switch IMP port for its 2 Gbps
mode, this eliminates the output queue discards that caused approximately
1000 TCP retransmissions per second during an iperf3 transmit test.

Fixes: f6a95a24957a ("net: ethernet: bgmac: Add platform device support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 3e9c57196a39..11487ff48e0d 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1415,11 +1415,15 @@ void bgmac_adjust_link(struct net_device *net_dev)
 {
 	struct bgmac *bgmac = netdev_priv(net_dev);
 	struct phy_device *phy_dev = net_dev->phydev;
+	int speed = phy_dev->speed;
 	bool update = false;
 
+	if (bgmac->feature_flags & BGMAC_FEAT_FORCE_SPEED_2500)
+		speed = SPEED_2500;
+
 	if (phy_dev->link) {
-		if (phy_dev->speed != bgmac->mac_speed) {
-			bgmac->mac_speed = phy_dev->speed;
+		if (speed != bgmac->mac_speed) {
+			bgmac->mac_speed = speed;
 			update = true;
 		}
 
-- 
2.34.1

