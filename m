Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354333;
	b=LE3UVc3RkAz38Yn27QOZDjH6uUtht30i1TS5B36B8Hq6FTr5oqRr81mAetoclTZO99Ab
	 IzoLwZCFRot+nmFZXKNR6u/zoBj260GVEWas9Qn0sLKmGwfeLVodZdQCbHjIBtxLtwTBS
	 zmgfI01NzVnopZG5NHiTxM7PmrZnk5hYPTYnpfnEjzpftjd1xvj7R8bv3A0mrE1DjkyfT
	 QfB3OD7uxsEdyJ4ZjGG2yZR22u8jHj9nc6ouobQNMemXdtkkv7agItEVVuvr+1ujne0q2
	 TLhmCT2KnIYg+KJwkEe9yAF4b2g8oZcBSKchIZFY1A4qSD+TdNsiCfayT24LZ3Gwuiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z80b0kOprqBXJCQHVSp5eJ9qB/tGXVw8oMunX8BeLbA=;
	b=vjaQAQjpZ/YyNW0NXliAy+JOv5vUmiLZUWIdeKuf2QGMvDVnKupHHqDa8k2GgCz+RhFz
	 2kEx8bmlrOqXSmYU4KPytEwUTU+M7nTiVpChonhu1NmwNM1Al4lxWVl6yPKiWJq/pKtU7
	 MGs3Uff3m6sITU7yL1aNWysALFdEA1jCM8wFBo49b6i/scAgR02oXHANFPAbNTvzrPapo
	 bp9lKJAq0hfO8grBc5BL3y/uRiu3kPGcN800UiwAQY9L3VBqm1InjL04y3r3EYZb/puCE
	 KklwtJlybcIq4kkKCzikd8fzFiBfS+2YisAT8UluFMQJWrtnr2wyfHziQl3vLfp2zEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AloBNOqB;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B73606A33C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40B73606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AloBNOqB
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a3c08d6928so4480726c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354332; x=1794959132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z80b0kOprqBXJCQHVSp5eJ9qB/tGXVw8oMunX8BeLbA=;
        b=AloBNOqB4kQhoGjT0vpJtAKQ1DgaDo9i21QVmYkBnBn4lKOhGSL29DF1B1yxGy0iMx
         jmOFxUlzrv646NvIX1DbbJWj9YX4SgaW4LoLKnQrxSZatfh4toQo5bWzt67q9IWpHbCd
         xB4LDmRn230Jg5sfTOEZhPRcW3X/HqEn6fJDwOVUbBoBxm32Tvn9p9N2CRwc2Hf6tXEH
         B1XR5TQPM0mTONNleai5YNJkD2kuWUD6TEF5Sqw9bpb2brXa0Ai+mLHVQflnrkPHiYT0
         HfPL64BPTNSXCjAHbcB5pGr/NOf+isrMRDeO5hP7ogR7kcByrIAM6C0AloYSwRhjuZiy
         eX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354332; x=1794959132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z80b0kOprqBXJCQHVSp5eJ9qB/tGXVw8oMunX8BeLbA=;
        b=vs6D3gC/CJHO9SRKMqpeS3gARk/D7LAjafNtVAW5U5tbrWDNAaYCOwAcdM+po86Me3
         Wkd7cFpjYkLscUSZxOPpFxC7S05QTdl1/NYD9ba/XF/d6eUuCQYrySXKLJMqvBD87iYu
         mLH6eQh26cpB1WE6rTKAlJWQrmQftLI62pcDx6vp+Hiqgs5aybk9KUxna2fUWDQTjGn7
         r5CEw+zgYw/w0NTSnhnwlj8U/CWyDjFtEMG5ASoTgBCxxMAprwzbLIIz9HGu+8w5srLU
         NXjRH52ez4n07J6uhxsdIVnFzs8w6EG8DiQxyNFRFvjC/zznbrCs79e4vgz/olM22UXK
         RNvQ==
X-Gm-Message-State: APuU4Z9ynhDt4n13xOv4iniGoDuYGKgwziNnR8sXDhpvdX+3hNH5Lavd
	CdRvyVM3dmmF6XHfIPYtn4Bl3SNsN8NwWWz36xnHiQ2U/BGA3ZL5qBrsxzzvPQ==
X-Gm-Gg: AYBFou0UzEB6ygktF7DzL2tYgsRDQI0F5tvJCpDrVvarZKqPdcB8oQc4SOViGDkBRfc
	cFI+42FjN/ockq70MX1cn2safFGzePaqdwT82LMg6FYyrqMRsQC+eCm6fgMIrOHdyvMv0Mez9Td
	z4BlAyDx3CGBribCuRJFe5FNXFrbb5UOhEUFhRel4wt965U9kUXVlpt5KsgsU1IsMj810ZDmvYJ
	BJPhkiysiKX+euwGO2KpUaHxAMCvjZwL7sHKV3rtsOgd7Q0ie28I8QG8c4wtww0e0eoGnG921gY
	d4K97DDg3tirvGZjs1TfkasmKxLjRdtZ0F6gMrJArElyXLDQNgps/DXAZChChfL5UJ29Inl++bk
	ndkWePY1cAs4H4K/C8EvAZgq7EYGi5EWIqyU2CTN8/AmjoIMvnGNcfJf/NWkfwFxZLRdQOlSya3
	TvlGQ2wF6thlKtDcTjTjzZMM4AfD5NJSau8maRXrP2+T8T7sKHcDP48nKjGHfQIf/DWjUEsrBIG
	SFy2u3lDd7odu5msIJyGLMksHHYhZwGQP00uwTcSwgLdamxmUqWCyQ6usNDR+1aYC0iFZ1Ow30I
	48XdXoe6
X-Received: by 2002:a05:7022:3a0c:b0:144:fb87:5b91 with SMTP id a92af1059eb24-1b3c036b339mr655736c88.44.1794354332061;
        Tue, 10 Nov 2026 15:45:32 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm9145881c88.8.2026.11.10.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:45:29 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 3/4] net: sb1250-mac: Add ethtool autonegotiation restart support
Date: Tue, 10 Nov 2026 15:02:59 -0800
Message-ID: <20261110230300.2769327-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110230300.2769327-1-f.fainelli@gmail.com>
References: <20261110230300.2769327-1-f.fainelli@gmail.com>
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

Wire up the nway_reset callback to phy_ethtool_nway_reset() so that
ethtool -r can restart PHY autonegotiation. The phylib helper handles
PHY locking and returns -ENODEV when the interface has no attached PHY.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/sb1250-mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index 546415d3134c..433aa1e24439 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -2129,6 +2129,7 @@ static void sbmac_setmulti(struct sbmac_softc *sc)
 }
 
 static const struct ethtool_ops sbmac_ethtool_ops = {
+	.nway_reset		= phy_ethtool_nway_reset,
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
-- 
2.53.0

