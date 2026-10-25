Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952431;
	b=yAPHp725Ycq40q8944O6KEehuZWFnFDShmDE2dOq5yVbxLyaYMeTEu14lecUjr7TeZ09
	 qXzk7BCLHuT8PLqYJ7MlByVHJ4PnxasaisCdjPgM9g/z+bsTWaA255k/QI3axHHl2uALl
	 zRf+ZpjB0I7BD4fEmdVp6ZKufT/ukovo1EiJLCQ5AIT9qc6PCWmJ5FfXZtJO5HQCVnze+
	 mhxfr493+5T4F4dkPRN8pfn0YlIwq4+pxJV/qcdbdk3QQg/2h6IZu1spNhz7+eoUeONwA
	 Gsj9pBalY3gDrdNFTdVyz6/9jBugwXjEBh/ph+URIDy6/+wLGP4SyvCArweTZCAyY8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kkg7v9pYa1AwlmOfl8C/ErCvRwIjr29iyWLeNc7eLhs=;
	b=B5trN5+Yft4Wd/89E8j/2dwMwFo0b1OiLdbDUdoRw1EhmeQK1tqylzslYtHDITbyzbGe
	 IT6Mphc+CvfM+gBzVVQnkSWOy5Esw9YFRV9Hc0M6OjK5VL1F9lCVWzoDuGPL09AOOp9Kl
	 6fdtD42ChS8Al15pQJN0VrmxsmCpRBZdrHpq9/1l7taQL2mFCw5s5BPXcoKnE0ilEhG8J
	 9W1FtdH0Q2tFAOx/532qJC8xpyml1KkX04LYUYoCfuEz6iG/kd+cn1kcpXPCLZ9ZOHa8s
	 cO53Rbo04+mOxmXlOnhp1j5tN4c+vXOtb+pq6YEJK0XhtkfuFfeogwECJSekLX8YvcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hGg8IcG8;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C10606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 18:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C10606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hGg8IcG8
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1663158a91.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792952430; x=1793557230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kkg7v9pYa1AwlmOfl8C/ErCvRwIjr29iyWLeNc7eLhs=;
        b=hGg8IcG8zi4/Z/awlqSK8ljg8JDI7fwQl3Gd8hkVh8ELqDTkoDUnkR3YLv1jEfaZCa
         7SDrXXOS3u4rgPbH7mtse+ndeA/T3iyjofXVtdfWNSyat7E30OY7KB8hErs78BX78YVU
         RIKz9THfOb8vSxqplRih10XOdz+F7ny9kNM5k4PH3Nk2aL6eKeab/lggbYlBLYWrlNLq
         vADXZg9wus2h2VjPq7t8CZEYCGjqJLq6yn10t9uBQ4LPUHQcp05QUusLmfx5f03i+gXW
         xydEaeLW54FbOBhSn6YBcDkID/acsI3mXcWNJBxXhwgEKFat3v/Dimsx0tyLXepsqVqY
         GokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792952430; x=1793557230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkg7v9pYa1AwlmOfl8C/ErCvRwIjr29iyWLeNc7eLhs=;
        b=vHa+YKD5/MSOiXBinQFkuRlIt1Fq8Vg9UYJG/SE/leLy8Qc11aMpCoZKcXBEpPgL97
         rBAhC9fAq0SbnawrNI7E7PjMVxv5xMQb5AZgiInckFiaTDQV8uJtsVC2jO0xCpKpGWq9
         p7pN609qqWQvt8RTwKgdbuo6U3nW5agQul8Ul1Kg1Eyd/gAtJoALK3fLUYeQCT9JFtXv
         9YFn4rp/nj4lpvSzf9SIUihnxni1p8nC7LLKiF4RcccrDry2g0U0VfzlrZp61DwPbm2I
         aSNK82UkjYHu0IoNvfm0bMEU4GBXH6h2UTcQGXohuVGwJmrkA7/GujyKfIEAG21atqsM
         eVIQ==
X-Gm-Message-State: AFq9FYLcplpkYBrSnbdiY0EFXcreKnjdTDfhJeo397zKdvzyFCdAdFlH
	+6SdrFW9b8TyV0VxWZ/3X1De40Wz4k+S+LRn6aHo+A/BVK4s8JVmWhDSxF+zZku1
X-Gm-Gg: AYBFou2McaJYpj1VnawWzPyhzq0cuOJAdCsKvCasqVy6yoEoD99HG4vWHZOXDu/ThG/
	lWR2zZtchJyUGmsefuYifjeelG9gOeY9mbI8ps07zc57BizK62xrRxQBrFDZxpOpXINiOeaYj6b
	sGIMocdDQf46dAuYsXMaQ1JylauqjY4OSn4Gt/Kzo6lNQb8fUYR08zmyU+OxUkgDjiw6jclOciz
	yt4DWqpvUCl7smgKS44XSLVT+d4hLLEDBZpOCeuHPQVgrsHazNjn3DOpaXcELYZxZinsWnnXSrE
	lEeHfcXUHIEBM7Sw6/HKOUHsZ8IKQQN5J4/ZH4HjSlZlDgB5NraT5TGCJOwWgsstQiVZUP01boX
	35CsxxVNId4CgSSxse0K+XcZG0O7aA7ALbNMl3eLn4ZozpHz5QECVdg3Fty60LlaLlpkXxjnuLn
	4TVrUJY5khLErI7Lr1cPAKA635r4HnVb1CF3mKW4cAMILJwHsOb0BqWj6z01batgrswoWiN5Ivw
	9E91AF3u0jroVbEvnRAvdh/gBlcZu+T2FUQaov+beyYd7+ofmSrCSrkjIhINfzzcho4DZfsnl/6
	SBFe8VM=
X-Received: by 2002:a17:90b:4acf:b0:3ac:9e76:aa93 with SMTP id 98e67ed59e1d1-3adea0b1206mr3533541a91.7.1792952430015;
        Sun, 25 Oct 2026 11:20:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6212:1232::1d0:de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaddd45sm4108709a91.2.2026.10.25.11.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:20:29 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	stable@vger.kernel.org,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dongpo Li <lidongpo@hisilicon.com>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: hisilicon: hisi_femac: Stop the receiver before releasing the RX ring
Date: Mon, 26 Oct 2026 02:20:18 +0800
Message-ID: <20261025182022.2959333-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

hisi_femac_net_close() frees the receive ring while the RX address queue
still holds every address that was pushed to IQ_ADDR.

A port that keeps receiving then DMAs arrived frames into buffers that
other slab caches have already taken back; on an EC6108V9C (hi3798mv100)
the queue still held all 52 armed addresses right after the interface
was closed, and had dropped to 43 after 15 s of broadcast traffic.

Reset the port before the buffers are released, so that the receiver no
longer holds any of their addresses.

Fixes: 542ae60af24f ("net: hisilicon: Add Fast Ethernet MAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 016605e86f0b..a44ea0a2b1ee 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -491,6 +491,7 @@ static int hisi_femac_net_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	napi_disable(&priv->napi);
 
+	hisi_femac_port_reset(priv);
 	hisi_femac_free_skb_rings(priv);
 
 	return 0;
-- 
2.53.0

