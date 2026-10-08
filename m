Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60B39B4A5
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426540; cv=none; b=qaJ6qMbjHyYTkrk4BljhmOq+tQMoPsuXT08duQFsH4cBhHbDKb3u9uk6hs4te/8/7lX8KY3e0/ZZFPhaALS/JEnGqp/SZ6bT1ZG0q9ILYPn2Mt5F/TCVE4bo+0z18GEbs4mQCx9v+uhPXPCay2qwE1jzu2LUe1qA8hqwbxiyjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426540; c=relaxed/simple;
	bh=CFLOuVQOgam3jkBVURC4w92TAktjOLOypT6fEBEUKiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zn6OWfGYXoa94rBiVP0MTjmRtBox4V2MskLwQPl2czux6Qn5VWJNLnbE9AA5NKr2mIDkls1rWTskuASRwtGrkh8OlzyNdCJ0+NlPoiOddMyFCuiuBJwxHZN8wpvsiRnpOT+4MlhMl9ySU9/UHwEMKq3E8pohKE8uvY1HNybHT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RumpQAW5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RumpQAW5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e61f017091so5796895ad.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791426538; x=1792031338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MPbrsivg4lBVveFygK2YCavyoi4TzFrSrERw+gfW+Uw=;
        b=RumpQAW5BUEc5j6h/3j5q0X9OQFLl+RJb7Qc+TCrVNM45krK6E/NrQNW2haC23maI8
         QKfpcwNFsj+d8pBOd+gV5pWH7fBkTXlv0VFrHwUS5UKp7sLv9/gnPxSYU8yf9xxHVvUL
         6Wcg9Vr99Eq1Is5eljE8JI3SQllkcqsg643ShGS36CwYi5dKQBYugdqts/W2V+TErb6E
         1XaKLuCkOpH1iqK7xDfCerguMCpts0IQFar9q9b3Lg3QTzuNIQP3sdArdo6xVOOE9RSO
         kWhraCQn9VenWKuRQRFVzsBBU3ihTqK0ZSMZmIWGQOLME+bVsEg1HBAeswb6GJqAojGa
         JXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426538; x=1792031338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MPbrsivg4lBVveFygK2YCavyoi4TzFrSrERw+gfW+Uw=;
        b=HIx8lAwB3J79ykJMTmXnoLyyW6W95+0PWifFKe4aYG+AndOvtwAWZaDwiVxlTRfFie
         wiA130HE3OX2Otj0PgPJBbbe0L5uRUt377dxI4FPg6tZddCW3JO3GZicAVBAHqQGGJgK
         e3Y5Qsvbv7YLkUUuzrW7YoY9FsUJbG+LKaNmmwM4YziAfq2L9cZCn/e+YO99RCZAr15u
         kizavuXbF33efGHm5Px+BSTKmXLFxDwVMH5GcRhQSjU+Uj/h0vqMScuu+P8dPDpAr/6c
         psYV3E1CTU4ig4ru6OOvO1gjZVV6yIT8B60elR+vFTNALOOgrnbM7l4WPW450Oq1m1nW
         qRzQ==
X-Gm-Message-State: AFq9FYKIOpdemvFgzXzJTb5ZolRC+TcwpZqCW2up1icIUIqZn0DJPPCN
	OnK/S45xoT9vqRIw9OkEcSLlHX1GyzGkqKK23UvBpTGzpJz+9PIzhX4T+Kd93g==
X-Gm-Gg: AYBFou2vbkqIV+62rXQXeAwzypaDpONsXWN7CDkXfSvcntL0h/7x0kumAoADz0ZK5Yl
	yScabtbg2wn7lw4N/zi/izl02o+cX8HeHLSv7Gg9vTHSNmI7kAPdpsi6iMTsM/kBSnpimaawPTo
	3hKI9pcLUrpukJKoLFE4nEAQVsVB4ce+qIwN6czcpl6NSOsH+72Ms0Q/rYf0LOeF1H49ohhQG4F
	ElSzFb6sDg+vcrsAgvh/lXqblQdyitxj2S5C/yUQywqCmESkoZxne5jU33EXC3POCgKLWt9dx0h
	1aa3pGJsIzlgSbBYzMlvwQERSJQfnpegkue0c1HV82JeFMdvmX19JLzlDlPLbeqdL62Zjamp5xi
	1As2qOMeekHnzWNqislliCh3JXYOLoxgNqAWP44QnxyIGBNfiWesWp+A2V3DxaYJsQgCLIFWkFT
	0L1eAMutlMTZ7SERAfyjdUbCWrjvJMT+1/9ub1JbWOPr1fZqbRg8HGmo18nNj4u70NoKXulUFt6
	KnzAfMcYaIJrzA46EJZCnc9f1aUIdMRdmDJ
X-Received: by 2002:a17:903:4b03:b0:2e6:1828:59fa with SMTP id d9443c01a7336-2e618286095mr22273805ad.18.1791426537739;
        Wed, 07 Oct 2026 19:28:57 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm18045865ad.50.2026.10.07.19.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 19:28:57 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Ciprian Regus <ciprian.regus@analog.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 04/10] net: ethernet: adi: Move setting of netops to fix crash
Date: Thu,  8 Oct 2026 10:26:46 +0800
Message-ID: <20261008022656.3592191-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008022656.3592191-1-mmyangfl@gmail.com>
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adin1140_probe() calls adin1140_phy_init(), which connects the PHY,
before netdev->netdev_ops is assigned. phy_attach_direct() ->
phy_link_topo_add_phy() reads dev->netdev_ops through
netdev_need_ops_lock() since the commit in question, so probing crashes
with a NULL pointer dereference when CONFIG_NET_SHAPER is enabled.

Assign netdev_ops before the PHY attach, as was done for emac in commit
7c9f391ec89c ("net: emac: move setting of netops to fix crash").

Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/adi/adin1140.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adi/adin1140.c b/drivers/net/ethernet/adi/adin1140.c
index 93710baca151..ca96a919c24b 100644
--- a/drivers/net/ethernet/adi/adin1140.c
+++ b/drivers/net/ethernet/adi/adin1140.c
@@ -733,6 +733,8 @@ static int adin1140_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	netdev->netdev_ops = &adin1140_netdev_ops;
+
 	ret = adin1140_phy_init(priv, spi);
 	if (ret)
 		return ret;
@@ -748,7 +750,6 @@ static int adin1140_probe(struct spi_device *spi)
 
 	netdev->if_port = IF_PORT_10BASET;
 	netdev->irq = spi->irq;
-	netdev->netdev_ops = &adin1140_netdev_ops;
 	netdev->ethtool_ops = &adin1140_ethtool_ops;
 	netdev->netns_immutable = true;
 	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
-- 
2.53.0

