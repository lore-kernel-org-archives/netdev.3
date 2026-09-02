Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623A14A4CC
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314250; cv=none; b=fddBKWpsNBjq/fxFKoErnCjojoLNBRjrx06JqCETxxIPwIYfb+0pTWWjLTBhvzq5+NMD+uQVl1qgadD42fNvt9APRBldG+eC5PHOFonylP7A0KVWldhrkWX6wyhooXP7wBwzL35EBfMXeYJLX88IoOZ5gSTt3T4mP1sZCzRexmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314250; c=relaxed/simple;
	bh=bMFLT2hd1hgF7+PT38bLPmDwKJnBhytafbJhxitvRbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8yHDuOiUFsKyI5AQFfYoBjKoX+1wACCPI7ANIYtwaqy/q4CrwHlxb7LiymibIstygOtzGNUNnR+AI3YX4o54tXKdhKEgwXQcCjTWQS0lEyU8wuuwCQe/ETIRJayF4iFgCob8D4lb9A8yiqpA1OMUugFp5W58xejKn/28RIX+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=hnlTxdUa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="hnlTxdUa"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so472551a91.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788314237; x=1788919037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=24B4a/9ThhnK86I6tiKZdFQ0uGyx0+7AN1IThAG1aFQ=;
        b=hnlTxdUaTABgt+Dr91k5xaxbTnzqZ8WafnMaUN5j3D3qizjd31MAQm/cw9uxXbxZr9
         Dv4pc4BmOA6csckTPVE3NnGxDZlMuG1kPiJhto7zK6f6YBfDmMcJZk494afI4uMtuX4o
         JH00h785k62lgBIG+IpZwFLZ2tfkfgefsvqPCUUjj8nRLOapdFWTumTHctueqhk4kWgz
         uaL0V/46xdxs0Ia6jp3Z+zPhT+atgmyn0sovgZA8lhCxjlx6cDWcKeATaQ2lt5XEAwAX
         cbBQ4jty4Vq3HjI4s6ArUCZuOXLgIzM+DVpY5XcG0bXAB5CF06Jn6WIZO5UPbBz7O7ej
         gjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314237; x=1788919037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=24B4a/9ThhnK86I6tiKZdFQ0uGyx0+7AN1IThAG1aFQ=;
        b=fj+AOaN07rADrzYjNIp+veg1BQjadw45JAKT54RJv2/VwbX1oiuJIx5PcXsyVahJ8c
         TDmNQcNlSKq0a5R6raivkj9/3WHzDdxsNVHYmWzixZ92tqU1Ntawy/wCqH+Lhr7ldgtZ
         UZ19q0SLmkvW09ivBTuKN4aMyznLeMD0Byu2mT2Ont6rhkwC9lLxVbF16uK1jmjmrPas
         ytp8s2FlLX6JPEFz5T8M682MJTvRZ48i4B0XgJ2hXagn3TL9KApVjl0BEPpQwGU3J3v0
         f4uy5b/KYWQ7CsUtbpflYWlBCzxtG5CHZXhBHfeLv7QvKT8BLxTHiDDxAJVoEa3McEQU
         /9WA==
X-Gm-Message-State: AFuF++nBD3TtzwfGNbdv1O0rzrzvDV/IVsrhJ61kOu62vB/Sk3lITycO
	oHohBnp5pB5Ot2o7iVnX4D2FkZA2O6P/bZqwl2pUIpb6v20BYZFhKjK2P7IKajcl1rXOtw5sUzj
	UQSmhodU=
X-Gm-Gg: AYBFou1ePoTR+hJ2AyVioko23omsjGIQDW0e1FCqNTkEknUh97UvGX4FKct0/iPrpfI
	ahgJVm0rE7qg0p49SxAA5GkFGvdiKh0X9XkhoHEE9WvmuDDscCqzhJFnPben08zeTMYsNpzuGoB
	C8WIrNf7/vB1za3P984ezbRVAhBH+t5VlfMVrA4BxkLQYj65Egh/7gf5VzPsaj9kOJ1EH1evujl
	LcslgCGuj/mds6A4axzQo7CCEN9fqEhBRx2B4vISsr0+c2FpkaBxhKBqvOm0oyiC3Y/+36Kg9fW
	kZZcguFiyL8Vt45LduZQDc9mMV8Uv5KwTmRwAMOLtN+m7cWLsrGA1Rj0eQqmnlNZH9NR2i+GikX
	t6/a62tGU3gYEJwm6EvZsgijoOOVewIQHIsmau++awxknW/51Av6r+naWJjsEMHpIYy4Bxmn8Tc
	kbqBhnDoAN4UMHYg2pluytf6U2gnjpQ83dcziNsD+Djw==
X-Received: by 2002:a17:90b:4b89:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-39aee105a46mr1643584a91.18.1788314237407;
        Tue, 01 Sep 2026 18:57:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0dfeff4sm2473024a91.4.2026.09.01.18.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:57:16 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Cc: horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	Joe Damato <joe@dama.to>,
	Sashiko <sashiko-bot+sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v5 3/6] bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()
Date: Tue,  1 Sep 2026 18:56:46 -0700
Message-ID: <20260902015652.2421609-4-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902015652.2421609-1-joe@dama.to>
References: <20260902015652.2421609-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_alloc_one_tpa_info_data() returns -ENOMEM as soon as one allocation
fails. This leaves the remaining rxr->rx_tpa[] entries zeroed.

bnxt_queue_mem_alloc() discards that return value, so the partially
initialized ring is installed by bnxt_queue_start().

Since the agg_id is picked by the hardware and bnxt_alloc_agg_idx maps
it to a SW index in rxr->rx_tpa[], it is possible that an uninitialized
slot can be chosen which would hand a zero DMA address to the device.

Fix this by checking the return value of bnxt_alloc_one_tpa_info_data
and unwinding, freeing the ring buffers.

Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementation")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f44a23c8a590..3755a30f8d40 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16378,11 +16378,16 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_alloc_one_rx_ring_netmem(bp, clone, idx);
-	if (bp->flags & BNXT_FLAG_TPA)
-		bnxt_alloc_one_tpa_info_data(bp, clone);
+	if (bp->flags & BNXT_FLAG_TPA) {
+		rc = bnxt_alloc_one_tpa_info_data(bp, clone);
+		if (rc)
+			goto err_free_rx_ring_skbs;
+	}
 
 	return 0;
 
+err_free_rx_ring_skbs:
+	bnxt_free_one_rx_ring_skbs(bp, clone);
 err_free_tpa_info:
 	bnxt_free_one_tpa_info(bp, clone);
 err_free_rx_agg_ring:
-- 
2.53.0-Meta

