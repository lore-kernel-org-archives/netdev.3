Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459210;
	b=SfWED1lqrLvpalrzd/NBQTFb1w6aGWy6WBX4Pk2k9yfcplRZN6nPoy+h+NjQDg4QmxBW
	 MW0lLimfXfyrE5h+FmHIBOyq6f+SDUHqUikI1u474RrIv4tbKI0KOS8BIClv3H8pewaYj
	 1x4U0eVoFxPZDd0ULW9j8KI1Co6Z+UAboC7HPrG5Ea/K2LCtaR/n6ZFbZfWqbE73xaXle
	 Qtranlf7QsI184ORIU35aOgOjE5VzorchBPO52wL9Z80ZCus4Ld961R0+W80v+PfRbbHO
	 5yBCAYI1aB1Ij6f+N9ApEljcHVY3+LtjAD8Hd6QMU2BABSIJwe9APdgWKnS2WAOscdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aFPoSxt0aWUwwqX5xUF8SwWRu98kYFqbtHO45/HLvLo=;
	b=IvUJil4RB/bFuiFMRVRZObHwCpwkSFru9rD01qi9kXi+krgk0M1f7EljOPZv+8qUIX3I
	 xJm83aC4X5jwcrUH1drirk79AAwfhHSWvO4vRPhuTd9nRqCJryewtv6Pkjn+eVuNtKaIJ
	 vJyxO+3Y1JBGnxTumCIA6mUcpM4tMYjDhYkTnv6dCwwxlr5vyWBxt0ZX9ok5tp0CqFjAv
	 rlavTQ8MVDZgI5OUVQlcik4i3KKt6ULxZaDD6XGy8kqD7cTVhd+Ex3iSBeX0kqRFJQhyd
	 rgiKaMfHHLgzo1hkxWpajQSjdjGXOa4RVBuLsiymjNKiFdCryWFTiCgbnOCfY8uWfiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RzTAuL1X;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502C606A33C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1502C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RzTAuL1X
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15dd124bbe7so6026946c88.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459209; x=1795064009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aFPoSxt0aWUwwqX5xUF8SwWRu98kYFqbtHO45/HLvLo=;
        b=RzTAuL1Xty2p5RwFlgMH7n1jdFP11HvdtB4QDh/wHeqzwGq2opOI+7x7SQ7nRglu+Z
         TBuCzR6aoVSfXlX3HBEM7PF28P4MKloJkLgmImElrvsp9BNeM36hZ/MIPusZGZib52LC
         Bw9RwwiqXuwzU0l50tQtrk6F4jqucIKilXfBQX+K1UTG5iJs/g7o7Z14pTzXdzUPGNom
         dpabiataK+HkycV/5XtfhBVUmAoo60as8WKPluJyx7E5hhPUvue6zp6ZQrqJY4S+AfPK
         /TjWQh7DN91Q6w1JwYHeKRy1MwewY/eF4jHAO5ym/Bcp2rA37fNckKmnX0uZclUbKH09
         D5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459209; x=1795064009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aFPoSxt0aWUwwqX5xUF8SwWRu98kYFqbtHO45/HLvLo=;
        b=treUGBuFGUVPeyi2o+6MPIzDvC2zGCms9c+mxNSSg1BEUUQBBHXhqAIAIv0JRUvep8
         /c7IOxpw+moEGyzC2d9d2tf5vgZ8KHWDzIGPNFSaGxREUh/BaIpkbw14A92O8O4Lv3es
         Qwvl8BqiVHyXAalMPbO68CQY3dgaciken1PCpbGHnx/oLcCOKoF7Ouega5cZIAE9mLsT
         UEYLdLv04PQaL9c8tzFHTE5rrQLcOPiy/eMocLEIBYCEwfN5eRIEv46inz2tgb53haii
         A6qnEw+p/tJnVViqTn6DQoLH4O5QTpuCzX5qCIdz0fxotOfc2xsaRc/lFHsO3poR7PY/
         rD+A==
X-Gm-Message-State: APuU4Z8gpr1emGreBOqpdK+YjIOPkMS+y41fC+K5EvQNJnMBY+j7jHj9
	x4cutxm2SXBY1KSSRijnckGsAC70gAWFkAiw67SxBMjECB6umhAk/uAJCDhqsw==
X-Gm-Gg: AYBFou2vJmWB/FvK+Qgm64jKEhg1yyLo/xHwR3Pk6MOZ648qaaDL18HI5OrmaSnNZMY
	8N6kYiuPUDVw74YyVwa9TGEq69X7viSV2qRuNIZyMYbLJWhltjEe78fjwHZB1I4qB1brkbxtm5k
	8TZj/iatcLYRiUzm0elHt5+lfNfJhWQtNi9V7QrExE6OwtR6TPUQ3sJcNqbWmejoIGktE+U+oKr
	4NqDX25ThfjloHuuujt5Srd0lFkxHMIZc8qP/52lpQPjgkwcKV8jZjjgeYWQxuG456dDNb7DdD6
	qvpfdT3z9VjNMSg15sY5qPfDywxCtwMUg3pzCaEKh2h8Nwv7oDFuyt0r26ZxNY3NDV0hidzrogS
	UziVdBTVkToq9VpGph705BhY1oO8JI7PR7bnLswTAaIXEpOetnhBRgUs3sxSoUB3zrQ1yjhD4D1
	zTHgriTN7c5n0/CvMcGGmOVafdCWaJBYAhbs3NF9uJpPZTJRvvUAg/jhBZZIDbKT4j8fTABdHY7
	4sd1i9mASfVK8yUVjrnEY8p/AqcNkejqs0mlPEJdo22tYym2xKCWtZP2nFirhN2LS0aAEHTQqGQ
	Jl9z7xWH
X-Received: by 2002:a05:7301:2329:b0:358:3426:d601 with SMTP id 5a478bee46e88-3768366a41amr4535295eec.2.1794459209097;
        Wed, 11 Nov 2026 20:53:29 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:53:24 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net v2 02/12] net: au1000: clear all-multicast mode when restoring hash filtering
Date: Wed, 11 Nov 2026 20:52:44 -0800
Message-ID: <20261112045301.3669532-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112045301.3669532-1-f.fainelli@gmail.com>
References: <20261112045301.3669532-1-f.fainelli@gmail.com>
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

MAC_PASS_ALL_MULTI remains set after IFF_ALLMULTI is cleared or the
multicast list shrinks below the filter limit. Clear it when programming
the selective multicast hash so unwanted multicast traffic is filtered
again.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index cd25248f4e3a..58bc8e1b539d 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -1042,7 +1042,7 @@ static void au1000_multicast_list(struct net_device *dev)
 					(long *)mc_filter);
 		writel(mc_filter[1], &aup->mac->multi_hash_high);
 		writel(mc_filter[0], &aup->mac->multi_hash_low);
-		reg &= ~MAC_PROMISCUOUS;
+		reg &= ~(MAC_PROMISCUOUS | MAC_PASS_ALL_MULTI);
 		reg |= MAC_HASH_MODE;
 	}
 	writel(reg, &aup->mac->control);
-- 
2.53.0

