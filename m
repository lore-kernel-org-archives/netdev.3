Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.144.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609852;
	b=0Mjti8UGumEpOd/WUNh0k2qr2Aw897LxZamc8Ef3505LCIKt45EQ1x5HtKxz3R0HltYV
	 lcbcgMWDOm9c9PVbCzy32+ZnAW3Jc1WqakdOBVNl0qN/+svmhmgcG9unwtLMch86pRoVQ
	 U8xq9WtYx7cZeALiw+18732QM9ziTiCI4EpH/DAoI5F2QFSvBXJ7Q16fd82HoDfagCBlq
	 15fcytnMQ+p1JyKe6UXlNf+3f02su1WlLQoObWRu3mSNJaAAEPfvC9dPxPgWjwFzA2HpZ
	 1bHnMif1kewwbSzVK/4IzIXlg06RW/YYtZYKk7m+w18o059buX+qg5B+fAEjceyY9ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609852;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DhjqB52cVSniFLBr98bAAxm6C8MjiFp/OffhpB2cAhA=;
	b=2N7fpOb8fyusXi8+qsGZ0CWEva8hYDFA/cx3pfhyNqlMsYvdZWwOx0XVLWcO6+R5ps0C
	 vU3vthxC3A012qkNq8al4ZpnfTYp4hLsykcz/tw65yojffD8UKmyLmrnY4TU/028LAOs7
	 UudJXxORZ86m9vOFabBO03m7KFRMevqCHLvfedhyq+RtthB+0G/2paZlS7/o8kIxCkfsz
	 RsbhQK1CMuLRoou/xEtee7zH2+0bvks53L3TTZs9h2vCxYtw0o8VfCzgi7DJGjgS3/nRM
	 ZbyslcKXPehoeNLAp4qOe/KMs+Kh0gsH6EaChz52Bu0Wu7hpoIpUuMjPRI6wL9GTkTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=HMEe05Jq;
	arc=none smtp.remote-ip=192.19.144.205
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A5606A319;
	Wed, 21 Oct 2026 19:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662A5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=HMEe05Jq
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 65A11C0003EC;
	Wed, 21 Oct 2026 12:10:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 65A11C0003EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792609850;
	bh=4MZad6rWW40fiA5vPcQ+YRmxEz+AtRz3SS2ieip7DdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMEe05Jq3N2ye4Y47ArHPARuDY79889yB9uGqH5WOdN24FWvjcVjEvrF0jqL6BJwX
	 Bnp/ViHINOaz7BCzukAC4Y0tqxSYcrlyS2QKXAk4SXA4j8XSQuhOxX0upa+4FsRWEb
	 udCBXeaREeTbTATluVopXwvZ5ZNvIBkPnWN57mJI=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id F0376A8A;
	Wed, 21 Oct 2026 12:10:49 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	Jon Mason <jon.mason@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps mode
Date: Wed, 21 Oct 2026 12:10:35 -0700
Message-ID: <20261021191035.751684-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021191035.751684-1-florian.fainelli@broadcom.com>
References: <20261021191035.751684-1-florian.fainelli@broadcom.com>
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

The Northstar Plus IMP port uses the switch's proprietary 2 Gbps mode for
its internal link to the AMAC.  Its fixed-link description reports 1 Gbps,
so applying that speed clears PORT_OVERRIDE_SPEED_2000M and leaves the two
ends of the internal link configured at different speeds.

Force the 2 Gbps mode and flow control for BCM5301x and NSP CPU ports.  The
mismatch caused switch output queue discards on both copper and SerDes
ports, with one discard for every TCP retransmission.  With both ends
restored to their high-speed modes, iperf3 reports no retransmissions.

Fixes: b6a8a5477fe9 ("net: dsa: b53: fix resetting speed and pause on forced link")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 172ada124cbf..5c7d7b210347 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1643,10 +1643,13 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
 	if (!b53_phylink_mac_needs_override(dev, port, mode, interface))
 		return;
 
-	/* Force flow control on BCM5301x's CPU port */
-	if (mode == MLO_AN_FIXED && is5301x(dev) && dsa_is_cpu_port(ds, port)) {
+	/* Force flow control on BCM5301x and NSP CPU ports */
+	if (mode == MLO_AN_FIXED &&
+	    (is5301x(dev) || dev->chip_id == BCM58XX_DEVICE_ID) &&
+	    dsa_is_cpu_port(ds, port)) {
 		tx_pause = true;
 		rx_pause = true;
+		speed = 2000;
 	}
 
 	/* PCS negotiation supplies state; the MAC applies phylink's policy. */
-- 
2.53.0

