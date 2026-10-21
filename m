Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.144.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609852;
	b=Pre8ckhVT7y2a2mG3PNapO30aSDXep4jB/bYt7jp0U5En2MOGlNNRF+Zerzi2mp5CJhE
	 oGxyGT+yMewvjRexn9GJH8ZD+1NnKj07CFlgjLDYh877Yh1qpsong1CUklh0bkjxIi5S+
	 Ltof1Z5CRe2Cn/1vEfQE1hUN5mTPVFKaBMO7mj1/xszK/Et4DdyPXycYshWc0yVdPbWSJ
	 wlJPV15zfYoA1RtG0Hb9A9rS1tm39uqWK+dFqQdXsxAw3nVBeoWz9KFisIGxI1VAoZy2h
	 lwvWRZ4aVJQfujdKcVT+9brjGzNEOpWJ7ULUX1QpKt/v3QyAjBRI/XKB3B8mVtvEz/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609852;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mZnLYWYthQyH/1Q08I94hYQu+8M2DcuSm/l3CvY+1vI=;
	b=BmlZrlk+CSwt2f87KkyAxcqxmA6CUVmzrs6vz0aSfXpnpta0jt5fvOTPN8T0esCMU1/R
	 XsZe3A9TBuDUiMu9ETIJakAtvRpIzHRkDFZKBEt1MHKuyWgryq7IeT+dWADSLJRYCa4Su
	 mSUFzvmmRMdXR9g3wuWqgDOtMTdi78rmuL9Uz/c0QgdBSxEBRzpzfP+VjCN9u7/g3RWl/
	 NaDbolzdRh+3m+5NTawa65tq3gbK7RLtyypIbwnkOuK2jsJh8NKBwEzko9b5GeOTBWPNj
	 +rgkAu+ZBw4x2qnaBDck5GFrfuOox0d55LCR+pVj6GoGZVHDJBNTvEgzF9Whc/tQBPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=FPEFi5sf;
	arc=none smtp.remote-ip=192.19.144.205
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73796606A31A;
	Wed, 21 Oct 2026 19:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73796606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=FPEFi5sf
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3089DC0003E6;
	Wed, 21 Oct 2026 12:10:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3089DC0003E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792609850;
	bh=/A5oZYXNQMjUMploRdqR03mvQq8qWvVx5LgB4bTZe0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPEFi5sf/RkgD70EOa8WjoESgD0XOeNY19+1DZFYld6W6j4wvXWzpjz5Du+G7LLz/
	 5jzaT7JiYcHY0qjfEEmb6mtf8FYFQCKzNktKeMQCJjTO4k/MDXHQf/qzbOjciJaYCR
	 dlBwBzHtZBaj2kNZIHIEygsp8a9oUc9sPqwXgToY=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id BF9E0A88;
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
Subject: [PATCH net 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
Date: Wed, 21 Oct 2026 12:10:34 -0700
Message-ID: <20261021191035.751684-2-florian.fainelli@broadcom.com>
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
index 1835266fdd09..7079228e70c0 100644
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
2.53.0

