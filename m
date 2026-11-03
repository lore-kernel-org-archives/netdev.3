Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710233;
	b=NMsX0V2vAYYt4r4ZNUM8W0LKr9RTdlHvxNeO/k6yGiKuDrYqY2RvVHGZ+9uX/jcQ74bk
	 ifoz7Llb0d7bn900+N6QiIcbKdX42EfwetQFok1+bh1oEAbEMBeoXgY4WLf/v5BUlKoCx
	 5awdZAzXHb/vS37cm74bkAYvJUSmvO73s5amjJCyZhfZU889hLe2fnof5no4UzmiYhEsZ
	 IhyknYSQ40/YQifxv+iD/5sIGwEqtLlk2bR9PlcnQqrnB53qv9yASHVS1v9sgHeEUGrQy
	 13VRLkNlfla6mRNyLsUfj9wIw8Y2JiDubiN1A9BFFO4ytfI5bWkZ9bjkAa6R/sQOkkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1NAP4iF8tx2I40R8y1tQZkrx8jrdq8+wikbWsRrd7CI=;
	b=L80O90f5aEb9jZnGdrolDRuDLC5ZlxJG5pMy/SZZq9L8T+NyEqSyxIl06HWKaRye9vg8
	 4gGHJuUz146Poa4ScyidMXuu+DcFVLv0ratgKjem0XNoIrZ9c2h2o1H+Hf/G5lrWbfGSl
	 GoTOyJbDAXMcTDAK/Mx6KsxyY0H03NszTYLjR/abno2DaoWbdDnJeFiWZWpRGbmOf+ZCY
	 baugAzrHPlLYcpkmymW7SYeUUhHEudQfIizIBU/6wVoELgWTWNyxJA08A4CmXSaydiMSx
	 qFEy/mGtruGjclM+qloI4i/VEg60tE1GUiGqM4es0KUemQunslIY+906TqOzskOOzZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ja+WhYAh;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4D606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F4D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ja+WhYAh
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so37087095e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793710231; x=1794315031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1NAP4iF8tx2I40R8y1tQZkrx8jrdq8+wikbWsRrd7CI=;
        b=ja+WhYAhQW6k/D+gXVKDFFRtoaFYUk99Q5tNtj7tmBlx0z4yzPVZKBctjj0MGU6ZRp
         kcCqdrRpUr9YaHJ1JfSrxmu1jne2YcHa28BGGRxot2w8BiCOJxkuqckkzYlKwx4wjvzl
         eGs68qp6hzI55kGGPv7WOgAVnerYTmbaWpdYcE7Mrv+UlUw1Bijg0RpDzyVosSn1ek4+
         SbS1GAUJKStqJ5v4n8NKuk4pJHM/uBkQpqpBns7DlQP0vej7V4BgJZ2rCEarmvcSfInB
         kU8muZhshpXLn6KDim8AfcN+V4/HQUSXNgxbAWUEvhHcHVFCJyd1+A26dMbUJBMZxeYB
         m2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710231; x=1794315031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1NAP4iF8tx2I40R8y1tQZkrx8jrdq8+wikbWsRrd7CI=;
        b=zKMS2lTHxQd7QNYQLxoBXL09HcIayFGuPdvTKLhmI66DZLXpiIsLSxutw44sobVmvK
         2uByLsWMsYTaxygK+4IqGkfchzgzR/7tRCm5Sliyv3+T4VUEHsPslFSwanNxlIn1dVYJ
         9QbEiqua5u1plIryHJuA4DpckuqXep44K0HKtZK8d8eUBsCjd+/PepCirxu4IFItSDdF
         BaHJHjpFLvWG8R741gIdzDYtG8zAppHzB70cIsiVwKFtVi01LsEPeiGukWjDSPYZGIET
         DxHu6QbdpWkv+UsUuZ/RftpyTPKSGvgjfTbcTeS/iKBBzas1UyJQb3aHb5Os9NN31bCD
         hD8A==
X-Gm-Message-State: APuU4Z9ZE2d19eg8jj9BTcUB6MxOVspXo/1HR2zELIma4TFULHgdn6I/
	0QjV2+QIiL/Dh4GnTUDKdJQMCPbeyUK53LkT5aqbPyzojwA6B7E0k2U7D5h50iWK
X-Gm-Gg: AYBFou1uhbzMapyDk83MLugsjjk+hmZODUluGkKot/tthD8yG9HZV9isnnGI+2wq4iH
	PoMv5whYsMZaRrOQ6a9rsbIrgN9zCtqrV2NcndtjoAjU+TNmmA64KHZbhbvWL2UVAbFo/sNqRFN
	trRI4mWWoCZ7VuwmSlWGyHUlpyEh3WUehOtXEbpw5JFnLyvX2ljbKm3wB/RO1QXTqWzce13upgs
	hgcEWACnvu4pNDkmy0jZdPxn/QRY+0fvVatpCnHDGxKOc2vyXtvLRTUB6Lw7Qy0ZPToU+TpsKY4
	Cl8Tq9VM9fKMGOJ2aEd/ZRoIP/r1eNL8RcRK5diTKGw8Kfj4QOzaFKnamoep1IY/WLSsR+Fo/DD
	Ay+95MXudwVE+CYlXi7IQnODYqUBie9MHkn6GJeenqjfX/sR4IhnbvX++CyueXYjZewGwb7RnSD
	HfK1mwEvLlHKeMJNnYeL4tJ0p9aHHc/PaQAZS8ln1nvlXz8YswzR02l4jXy/OI5S+573LuY9AZT
	o+/brFZHTLHQwEDnz3UqOduqI1FLVdcuTosBXFfbNJsuIR3OCH7XGkD5MYQfKbyXTljpbS8bkFP
	acFDKrXple7fxMcgjA/7OEj1dHFSeoKjQHMJ4FrcWwHZR1DJk9EK2aj6XGLth8rak85ytZ+7SA0
	BP37voyxpkvJHQZnQZop4bqO7U1/rZPdUabbm6vSC5l25piOVPBhP+dKgwplV8w==
X-Received: by 2002:a05:600c:3b97:b0:4a3:5a91:5f64 with SMTP id 5b1f17b1804b1-4ac18e5dcbamr293862585e9.27.1793710231136;
        Tue, 03 Nov 2026 04:50:31 -0800 (PST)
Received: from localhost.localdomain ([2a00:102a:403b:96a2:e8a9:f4a7:ed37:36a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm61406425e9.0.2026.11.03.04.50.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 04:50:30 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	w@1wt.eu,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/5] net: mvneta: fix the removal of the mqprio offload
Date: Tue,  3 Nov 2026 13:50:18 +0100
Message-ID: <20261103125021.70845-3-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
References: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
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

Deleting an offloaded mqprio qdisc leaves its traffic classes and
per-queue rate limits in place.

mqprio_disable_offload() passes an all-zero configuration, so qopt.hw
is 0 and mvneta_setup_mqprio() returns before it reaches the teardown
code.

Check qopt.hw only when traffic classes are set up.

A replacement qdisc is set up before the old one is torn down.
Replacing an offloaded mqprio qdisc with another mqprio under a new
handle therefore loses the new configuration, as with software mqprio.

Tested on a Turris Omnia (Armada 385) with 10 Mbit/s limits on a
100 Mbit/s link. After the qdisc was deleted, only TX queues 0-3 were
used and the link carried 19 Mbit/s. With this patch and the previous
one, the queues above 3 are used again and the link reaches 94 Mbit/s.

Fixes: e7ca75fe6662 ("net: mvneta: Don't force-set the offloading flag")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 9b9efac2846e..79711a117c39 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5251,11 +5251,12 @@ static int mvneta_setup_mqprio(struct net_device *dev,
 	int rxq, txq, tc, ret;
 	u8 num_tc;
 
-	if (mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
-		return 0;
-
 	num_tc = mqprio->qopt.num_tc;
 
+	/* On removal the qdisc passes an all-zero qopt, with hw 0 */
+	if (num_tc && mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
+		return 0;
+
 	if (num_tc > rxq_number)
 		return -EINVAL;
 
-- 
2.54.0 (Apple Git-157)

