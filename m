Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048836;
	b=nmG7/c1fS8ED0/6oAs/dknawXz3g+/4lumhJ3MIH8PGyJbLyA4+YJuRdlxH6EBHoaufv
	 ZEtsy1Idt6wlCrEmeMSko65FjpNLbb7SV0Xsl4vi/2SaMadcBSHqzjH84qSyI+1W0MqJc
	 ZGQtz2mYhyfhwR3HXacvVXaYIH5NYEwKuBUzZjF3lYkZxHfGQq3vKHvMNrhGL8kS5WAeg
	 vJCEo5JQMXbpyRBmXaGHtSTEtXekyva+5vJezRdvrnmcGle7puEoRReeqZ9moc37awjqi
	 hagTuAmqM6+o2znoP4vzznhW5d86jqyM7gIkd7C6vSmW4+yadstIWYeSHgywr66Vv1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048836;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=HopYss4iDrkEwjdJIVLLh7fS7trael+HjQMhbwq1Pqk=;
	b=FZHBR3ocCfs5OVex7jTffteGzDR3wfm6Wcsiv476+NUMEdPiiNQgGXE+HKpd+p+WbxOV
	 PapJTTjFNiWqEuNl+GCIm7EgGJl79ZaOmwg5UXbDMc5lQqmuyDqIcwZU5slc14MPDFJwF
	 yiySJwOmglk3NtkRk0kpjNAoJhe0NNRaBv8ncJh7EWSEhVsO6AX4e7ZRI4GlSKOs2eofg
	 ULmstaso+nGmXYI7orNzqZVGhMtjxdUg4wuPJkw0yZuEveAjdrbxmHlRZU+TxhE+rFrlM
	 YqsOnHzBcuXDFIONEgAb2Q7XfC2lt6Ez3YUBLduuszo1ldnYJYMWfwE/dRb6WbbcREQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=SJRh6S2c;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512EC606A33A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 512EC606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=SJRh6S2c
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1415566a12.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048836; x=1793653636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HopYss4iDrkEwjdJIVLLh7fS7trael+HjQMhbwq1Pqk=;
        b=ALM0DkglLwMBBKKgUipEx2fWYkVR1JPSEYagp6Ymqb5T4AKuen+B00R/Y2y9o8L9q+
         rbJtqu8euvFl5R/90vIoDcZweKgiyzGoNw1jhrqgigubKmE/0ydgOSy/dY944ZhQzsn1
         cZiqHPIYkgVfPsZ+f7gfoX0uKxdj9XeJ0aWA7gXYrPUahq4676X/3da2tGAQGyP+sUZR
         SLl/QF9I2PGSnnMg957al2cO6w41FmtfyG+TWMUk5mN7Bd/MnYTLoiz2MV6oupjgfQNQ
         cesIuubV61SDRgMz+QbBMmyZ3j7dyUEkZepvQHlrHL3ggmkTOWbiaGEVbcpX8Pd3abtq
         NlkQ==
X-Gm-Message-State: AFq9FYKBwQuLQmBUevDMD2EwgbNXPDwarn+P0eBDGNF29jEHSI6WHf9V
	MrY/G6SqUO44Y50JoQaW3oCqhKlo9dj10JyqbyUtN1IWUI/DCfADQJ4R7+RMY7fp2E+6+kWkAZq
	5pETsYnVmgWxhDn/0Z+5eyN4Ctul3XObfeN4fqC6n8RseP0xr3lsA+t4jNTZjQUmtlmc1x99ZZV
	k0nc1mqy+KGCRdWLZ0VGgEFothfPo85PJMh1D+S46AFsCcK60p8fr620DpzcuXDKguvnlyf2nK0
	kQBSzuW2sxBLBeupj8=
X-Gm-Gg: AYBFou0z8Ykf4+sC5aOHXyNYx9dkplVqdVRu73+c++Dq+/j/1Ig/8MlUQ/h7BjaTAXq
	DrWyTHe+TLnRf6/p4NVG5n2QOadsoLU41L9qPMncd8fatFsIVKeyhy9XOf/rMgqRqYmyYEgYGbT
	aRzKGW2JLtA345NjyblvmgH/NpKqkUZ0WqtVYuHzOoWiYYvUwGNDEkGWxoojCFUTsvxKh3IdRuP
	ottW3TDEyHnN3gdNG5N4N8llCEGAhZoUQJO5csNTiNfwxAiKw3RcjWosqJs3fYVyh62dlBccWob
	Z52CDxitRtjupsKVUjDTg7GfRkH9gbgQhT9NHHo2oXGgiMXUpq418tteGrHeG5xSt2v3PfF10RX
	tNR3Zq2Jn5nzCBTbcn5Wbc3Ytl2pibyocMch9ckTC0bQbfkNVOppU0nSqdRe66l10/rNRj5xHVU
	WPwO1tZmibSD5qxh5OLVjbJHlK5zwc6Ipui57G/JVY
X-Received: by 2002:a17:90b:582d:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3adeb13167emr5727295a91.51.1793048835611;
        Mon, 26 Oct 2026 14:07:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae406dbad7sm505691a91.2.2026.10.26.14.07.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:07:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d02df2bf09so24445095ad.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793048834; x=1793653634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HopYss4iDrkEwjdJIVLLh7fS7trael+HjQMhbwq1Pqk=;
        b=SJRh6S2cYRVKQDfoPYcPgm1hfL5n4fLOHKLqgD5DsBOiII3fQZvUUPaYnsX6bOyNr4
         qfJiOjFTXgisrCn7WmKUhtHiPg9pF2NhuCLarP8Ka2XsqhOtgFyXPNZ1kwacc9TDxmfE
         7o4uKfDVLbz+BX/DvpWcd9Y9R++elYMW45bIo=
X-Received: by 2002:a17:903:fa8:b0:2e9:5eee:e078 with SMTP id d9443c01a7336-2ea9c0f39c7mr56116205ad.3.1793048833850;
        Mon, 26 Oct 2026 14:07:13 -0700 (PDT)
X-Received: by 2002:a17:903:fa8:b0:2e9:5eee:e078 with SMTP id d9443c01a7336-2ea9c0f39c7mr56115955ad.3.1793048833405;
        Mon, 26 Oct 2026 14:07:13 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ce5d92sm808245ad.75.2026.10.26.14.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:07:11 -0700 (PDT)
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
	Jon Mason <jon.mason@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
Date: Mon, 26 Oct 2026 13:37:41 -0700
Message-ID: <20261026203742.3198673-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026203742.3198673-1-florian.fainelli@broadcom.com>
References: <20261026203742.3198673-1-florian.fainelli@broadcom.com>
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
index b3a92ae95de3..ec879c203bc5 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1417,11 +1417,15 @@ void bgmac_adjust_link(struct net_device *net_dev)
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

