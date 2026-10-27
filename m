Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140326;
	b=0cL6o4c2rkeI4/x7XywD2wGDDEJYlDAhB1bYKuajajxvQVccgHFzGzmC5ULjS381jeVw
	 4gO9w96B3ceJWoCkZmIrMtE32mb9lOVPVimrTy0mHFEJH90V4GJVuu+keck3uBshFBWU3
	 /dO05dtIOESPNJxG1jTmbGmsbRXB1sdIqaSLjxz58ozm/MWZJAFYBZokXTDxA5T9A7Dly
	 d6Ybn3Bnwz8ua/8x5kvGnXCpfibeLwAg8MqLYD/TGM6zSehzjRfDCrwv4bgu/0kt2vUxg
	 xxsO4nRi0fbCPGoJvBGKr1qvM4FjReJs0xjAagzb7toPcEwmw004jWpaUGjz+OJQuGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aFPoSxt0aWUwwqX5xUF8SwWRu98kYFqbtHO45/HLvLo=;
	b=YSoFkCh3XvQmbwRMtQdUOe3/h9U8BAKR8Twx8PJ6YJOgkT9wjn2vUFxOMUOesADEd4xH
	 muzvDNbAL/k+COPlHGUKUq++nUcl7mOWXtL3df19AyH4dSNx41X3hVesm33yaotSUAriK
	 fcYIQcgKKGFbg07cXnGpQvwCKLjczeogktz5Zl+EouqXC/iV5Mdz1uC+5R8+MErMyE1aW
	 F1kZO7bwv1UEv6nykmIAxzrbBBr4O/s0iw9rSR+1HBcI+0SbJ2+YYyvVe/v7JpLp3orHp
	 3/XhJuDxTO6NNjv0imyuEi2Im1r+IEQJq/EJgt84/0By3NWUt2agWh+n1S8aUpJMSTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uM8EvCLN;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF60606A334
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAF60606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uM8EvCLN
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-181516de561so303554c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140317; x=1793745117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aFPoSxt0aWUwwqX5xUF8SwWRu98kYFqbtHO45/HLvLo=;
        b=uM8EvCLNm2DGrjEr2LrwYXsjBKHYFAimMRiXuB/e0kurGkMNFcn9Vui5i+Xp0Kbmr+
         9u0uEybvTPR8dTzR9ygcxvfmziI3vRvDsx9ZW3KGugHGkWYskaBdqepcXx8o0IkFIJvm
         pKkl/PKHao1c+aOW+fBYNkYHENYLUQwma8F+nNkxYA2vhe0DuDNh7rilonVz1ek0lWil
         02nDbbCb4ID32L1rzgutCIlx7QvqgFS/auoDlSDdix9EJj5yu6s/JnuMUnWU+7skXXxn
         fF5wRXziSMRZVFhfQbAjnk95Yot1yy74JovfkBZb/7jqbEjmkhSiBDFylzBevubczvh0
         /ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140317; x=1793745117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aFPoSxt0aWUwwqX5xUF8SwWRu98kYFqbtHO45/HLvLo=;
        b=hK2qsAoElJ85YVMoonNI0MKlRR08GMskfUiLOLioaff3E9Vl+e4P4dJEz0UoxPywY7
         I79PR+t+jexKdWzVUz+FpE8bJ1pb3Kaf8BWjPlXnecU4vzPMOsIQGsCFokHFrqBfQObG
         lShbSNLKh5c5l6I+4GH9H7xdaFqt4jI2U6Onnu25rLCbmeobVe3d/vovm+YRdlvTGz7Y
         SK6aDUnaleiMlSPWltZP0TqOBYD631QhYOsF5bygC5JT25nUBQM3xdgg7hTelj5KKqA8
         U0MyTTnglSHAVSxCP59ofXuQVYum0Jd7shCEy8T4H+vYIp8Ac3OuzlEoNqU+Dh1KuQRw
         oVkQ==
X-Gm-Message-State: AFq9FYJRY1CShm7O/irvEqm+HlbNg+jv79ZbeOqU36x1WG38FSUV2QAI
	I3D1oUDy1Gzn8KbeYvK36GY6589ozHM5wDqPeb0i/XrAYUgYPt58NeY9zyI+R3Ab
X-Gm-Gg: AYBFou1Pw3jo1/XsbfEmBkh5F8EsmwYT7vVIBwmR18lcSBuadsgzKOgGg6Q8KgG8pA6
	7i00EcWbDpxeTKaZHwD1+6caGk2o1ZP19njahykQAq+VbUcVUquP0/ajfsTRcYUn32cwNBJTP/A
	2cf09AAsGYrfALgRRllAjxFjp4JQ6pLfE5LbZT3whgkTv14PXNlN9ueAkBvU7s+8EG2akn+Gm4j
	Lrdtvqkj6596I5f+Xl7SE+JZJecbpfkljci0bxQrhc7Cbn2QIG3I4KlF6L0omIUgZArNYApJ4NN
	Lg4TURefHLDN/4r62D49Ei8LqtiqxSUlKZglrMSRFnFuBA4Sdz2jTDbwIZGtQ6jNlvGFn/ylZKM
	0ARHI6+3qrDw+bJCTB4UUgRzr+cJU9Z8NpsesrfsI1NRV0z7Ux2FsLxxTv5krqtzEMnmn4Yw1ZY
	6Yq7biSBmnc2yxVjF8k3Ww0eT/bXn68kxIJtau895jf1vLIam3mfEKkw5uZNdkjO/jjJJP1n0Kq
	l0Yzj3lbcgg6S/Kt4KhaCRugi56NaWvxY+6FK1axj1pju+WP3jaknA5BX4xwb2w4oYARMHe40bR
	TPvoNSGDxKwQtTL+e4gp6VmcnoU=
X-Received: by 2002:a05:7022:283:20b0:184:ae11:51c8 with SMTP id a92af1059eb24-1a3c9cc235emr4697526c88.23.1793140316817;
        Tue, 27 Oct 2026 15:31:56 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:31:55 -0700 (PDT)
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
Subject: [PATCH net 02/11] net: au1000: clear all-multicast mode when restoring hash filtering
Date: Tue, 27 Oct 2026 15:31:31 -0700
Message-ID: <20261027223140.3774570-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027223140.3774570-1-f.fainelli@gmail.com>
References: <20261027223140.3774570-1-f.fainelli@gmail.com>
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

