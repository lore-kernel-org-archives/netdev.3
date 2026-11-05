Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907294;
	b=BbC0JI3qTWr0zvzviwKNdN5TjiYGx+9Ch0CYEAvX02aA39yN6rLzSFutW8ZA07smhYOX
	 W8ElWctznP6r0khNptAPrnml72Laydt+vRezX9V5jrpv+idzssoQ9W/GbjO1h9sOpJOLj
	 QdTT1rLa7zbhAV0/UUx46xfoXbIedN+jqMlbYTSmaV7s9VxoR+x3OS0+STxH8DI1JtUl7
	 +42RLCR+uDqJDXGf+4J3LHr4cTVk0/VfcvNYSqx6TYtfKYRFb5d0Z9TgBQPjgyUzQssDN
	 FegV0k37Ur6GLdcUJw64tTKBALNJk5xW2XQstlbntQvYyoJzcsalFXMVS9gyQY/bebA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2Fv3H+zDanDtQ7jLhmV5almycA1hA89Pb/ACh8oQAlU=;
	b=VQEkWL9so3hfZISoTdCJe/TeJx3bvuUrEP4x18q1omp4gb4IDWyP/GeBK6E+GqwhcA/W
	 aUQK4lfxb6Tby7MkIfX1FRotRs9IUm3ElUTnOQ6DarlDJLGigGTjdkA5G4fCoobRXLb6g
	 g6R85ZIkiiRVyLdeUlDQO/0xr3ITXhpZR+ayUVAr0YVTFejKgVQ0tagEFX4SwIjW0gLx+
	 rvfTNSGgUNK1kFbF4ooIpf7x6VaHCUoNeyF69aMapQQW2mPJEyFTvO++L28HaNwDOmpaA
	 +jG/f4ME5W5TUnhEtkfIccUUYi5Sfvw04PBQqnLf+Q5SE7ch05LbnUSE4rF4cTQbFqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1saw5zh;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50F606D50D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 19:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E50F606D50D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1saw5zh
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1149437a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 11:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907293; x=1794512093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Fv3H+zDanDtQ7jLhmV5almycA1hA89Pb/ACh8oQAlU=;
        b=H1saw5zh75ifw1BXi9g9xov7UnYjJbvOSZ7pQoBLxQOXS4DxMhFcopCWl7exFRaoaR
         525kxunFQaCpaQ3JpfcGT0LOJ2jBU+cWinjflVz79VXpG+psW3Y5om04iBvty7eCsn3d
         dm5Zqry9y5XqLQ1lDVDlWzjGHcvouBvYDJU6MxH7alAbHYRCn1q4mnIcf8fL3Zc+83Vq
         XpqbSWsR7Homo/4Striad5FgPD1NbhWF1wIC9syzQ9V4tjI3xQLHpjJRvRGYbVuvj5ZV
         57+FCMzVxaloTlvU6nP8OG+zUH8H0CXYej5FgvFog9LMjVkv28iZvOIRI8OApz+alLPr
         BGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907293; x=1794512093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Fv3H+zDanDtQ7jLhmV5almycA1hA89Pb/ACh8oQAlU=;
        b=R5U6houVDSGHDIDgRLPmboAkp5GZMHc4gtwU3ccFfGubZZNS8gYzXCMuHXC/BSVGLa
         2dh5BO3hVP6sTp4v3rmvlyc3stg+AmIsq+XEH6Yjls47Qgj7Kc6ciZ0gqpr64fnLJ6NZ
         pupwkKhsobQyA8Do1eeIf1RaE5kBwPf9sa+Ehw4LEHc77fb0FtE3uLW0wdBrdyazBRFn
         +yozQ0/xlsEsYbO+lE26HWsq/QMvVsg4dxYfhPSAYH86KQRJDarLa0hGoBJLPfWDBMzW
         +uGHionzCutG054Zcii7b5JZy+TbcJM4yc0iEoD1dG1W5HZo8Kk277A6+Uu7yUHtNRNP
         vg5A==
X-Gm-Message-State: APuU4Z83tdp2Gd0Gtv2eUCPb4q78jJHyyeFzqxKRu94wLQmzrSeEh+UT
	lmf52T6Atl1k6sfDKBMcfwBxbDptR4MIgR8xgdswhAvj9DSOZZjwqXewZyw7mQ==
X-Gm-Gg: AYBFou3m7K4Zsly3H+3NTzKSeK3hr2Uv/q2O4VrdjkrTKiyaff/KD6NJllGyUDRe7Fz
	YB75omxC65Juyp7DHo5jsNdK+mFzOC9tr4ipeWyLzWYJIX9hzvnrU52CGeLpYJtpc6w3k4j4BTn
	NdIgKEDJvMKSXPh6ltqiahJVs/zzJMHkFlibL5Zovu3gqLS+GMprR3CSCYCc1vmjHqwoecQE6f/
	/JQpxoNrEbPRS/VDWw75KnZaDf3oEYkRGj9iblER+BSIVUTQU90kSeO1EH1IzHdwTcZ/xzD1mnK
	2VnZP0nCgF17lwz5BFXRazH9HrMYB8dsuAnD7qisnR1lvxASzvmO/O4G8/V9IqxHXAMRlilm2bz
	KuFLEfgFCL4qGvPdDbPv7ikAnrF+eUvCKciEs2LYC+64emgELlKvr/OYqn9vtX2PfUi+MpJp1Po
	4TSxHdnVOPc82PxRkl6lfmGIwUz8Qwl1lwrs37ZgJD83EK1iIPs0Utmg4oEt0watV29MjKJ831t
	HWXg/m7SK+/R4SNn4fS5TRRDFldITFeM4wmFYjfiEMEG291DyBU0lLgQw3w7nq2C9IW/BKL1TiO
	APLSZSVHNJbwnZ0UG88GFFZDPFb2mQ==
X-Received: by 2002:a05:7022:7f12:b0:1ab:faad:cc9 with SMTP id a92af1059eb24-1ac5bbb503dmr30695941c88.11.1793907292811;
        Thu, 05 Nov 2026 11:34:52 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c127sm18023186c88.6.2026.11.05.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:34:46 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	macro@orcam.me.uk
Subject: [PATCH net-next 1/3] net: sb1250-mac: Add ethtool link settings support
Date: Thu,  5 Nov 2026 11:34:33 -0800
Message-ID: <20261105193435.2050321-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105193435.2050321-1-f.fainelli@gmail.com>
References: <20261105193435.2050321-1-f.fainelli@gmail.com>
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

The driver connects to its PHY through phylib, but does not provide
ethtool operations. As a result, ethtool cannot report or configure the
link settings.

Use the phylib get_link_ksettings and set_link_ksettings helpers, and
provide ethtool_op_get_link for carrier reporting. The helpers return
-ENODEV when the PHY is not attached, as the driver attaches it when
the interface is opened and disconnects it when the interface is closed.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/sb1250-mac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index c839dd9804d3..1843b52e96f5 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -2128,6 +2128,12 @@ static void sbmac_setmulti(struct sbmac_softc *sc)
 	}
 }
 
+static const struct ethtool_ops sbmac_ethtool_ops = {
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+};
+
 static const struct net_device_ops sbmac_netdev_ops = {
 	.ndo_open		= sbmac_open,
 	.ndo_stop		= sbmac_close,
@@ -2197,6 +2203,7 @@ static int sbmac_init(struct platform_device *pldev, long long base)
 	spin_lock_init(&(sc->sbm_lock));
 
 	dev->netdev_ops = &sbmac_netdev_ops;
+	dev->ethtool_ops = &sbmac_ethtool_ops;
 	dev->watchdog_timeo = TX_TIMEOUT;
 	dev->min_mtu = 0;
 	dev->max_mtu = ENET_PACKET_SIZE;
-- 
2.53.0

