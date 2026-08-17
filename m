Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6A421220
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990627; cv=none; b=AoIMOJ5yg/8MXLsoEiYcROdVsD2f40IVnlH8RvDEgBgEsPJ6H0V7Oi9fR38W/L9sxjY3UjrgPtp0yU14NANXhUYFlxzuEB8NIFNQEDi6iFCXxmsb4nm+pITXp6FhTmZcA6+/IWFg50uAyY34wFCfWauRh1V8y3/dkWLuTPCnOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990627; c=relaxed/simple;
	bh=e7YINFxiEWfrdRjB7YyK1q6FCtAp+fGYeGsyaMd4wTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KMHIUOTkqPc9p8K/sNNrNRxfRzk8OK6o3HjCXSVbqlK9aGEYI6CwZAmVFs1l92LXfw1ZyR+qXFEejFFDvbFDZDGjmjpwns9qTVqwquVWEGCdF+YtrHqZEItrui9hgykikvv4EJZanrIWsdOchkFX7EOx46i+Q8NiwwhSMkp0B50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au/EH669; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au/EH669"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4980dc26022so37893455e9.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786990624; x=1787595424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xc1ui9x+ODrVCjZdh/8HAj5CPDG/jh1HP7ryoge6smE=;
        b=au/EH669lT55TljCNFQQBMFGN/SkKr+LsMmQh20A9hUECGZLBUmDJ5Mu6lN7QHCGl7
         Dl1RaUT1idkHfdykU5vOUU357PIvkcfkRRV/VPazGtelEzk3Jlbs8R8UXUA/j5CkcCpR
         lkDRn3wtuBp6y+JH97LZOx7l9kmTfFjWXbXXV4tqCep1TEZNVkPhLApx9Ucupzofhg4K
         +sKj6qv52BRLF+y0ujFSZNNQqZoENrSl0Dx0zoN7JCX4x5h4OYfGQpKfUFhOV5Yq43SC
         4Vej5l8WamFF3eXAt/Z+ES4ezg5gKA6j/BwaMPmpgMiFMDa7pY5wiDwOxz/5jh+YqZHl
         q7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786990624; x=1787595424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xc1ui9x+ODrVCjZdh/8HAj5CPDG/jh1HP7ryoge6smE=;
        b=ZEDFmXNxaRBIrEW5CvSQpvIyBVKRbb7pBBeaS6rdFIXOB9ftjEBH9FwX0Rnb2qyWZj
         grJyQUT0ssUzeXWsBiYyb0+kfLOTIU10MmUd+nND+hW4QCffvmn51y878f+A8gZFF8vP
         8A0nFDSNNZXSpzTmVeO0Y7pXddauDGgefAtsB7fFmiwfNCN77KEOyDTaCkz1HfLSG1gt
         QI/BbotqNQX180oOJI8bC0G1Eq8qq86Q0pRGS5bQ2heOMZFsjXYBrEeNgwqOxr77oZM3
         Dqgb//UjYtFe1pfU+VSV3AuTxQ2A5TCRCk1cP11v2Rd+duAA1LSv1cBcZo+/6Ly90tfK
         1NzA==
X-Forwarded-Encrypted: i=1; AHgh+RrwMGQYFdCsPNKVJUmWqyXnEDpBqA/bXtPEstT913fZOTJDEW33QXz/JlbLGU5esfZF1Ho7Ofk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyytC2LAhnRO/s9gUg+zmUn15XOgd9dFf7v8M9kbWw6CQcwB//j
	X8Rp0WiQy58/R9a3QQOVJMh++GhEL2lRyTZAC2VVFih/P1fakiwppKPc
X-Gm-Gg: AR+sD106jrhDIwD6A1EEpAaCDnzdhM4Hw0sNNTJTxEHLmJVhzlZ7/MYHpQhfeesdH1D
	YAPTQX8EbD4iUb0zymfsQdhfwLtI3pNNAfOxPwK0QFcXkV2EHV5cJMyw7AD7xBdvTyd8JnKpi83
	D8NM069lNUwMUkjVM0Gd6+8aYrIIX04wzCXqzVPNvjhikw4Y0tfSO7VwoDLNleS07c8MvjhABb+
	ypEfT5HnM9EvWKRbOe2GcMcJd7GaDSioliaUFefLCLS/CozRuU+s+jfLExWJIuj6B+FAFxdf9OW
	NpaGnJmF3ugYq10mSNFLyLUXwphtF3RGIoTjJ6T2ixWodXxi2bVq17CLDvWpUGJJrvbauO3CZAe
	skrY8yjk+exJS5rajWjr+2dB+tP+tYlPCJnxTvgJV5pSg1EaGBx7rBOUmvx2uzUOqaGRSCh/Qd4
	E0mb7+yG03GKnc+lzGVmXO2xLoNQyD1SW/EyGXOzeUEGnbN0KAl+QAcQMTwkO7Up+mBQGktq86l
	qdTLA==
X-Received: by 2002:a05:600c:564a:b0:498:ff3:71ed with SMTP id 5b1f17b1804b1-49987993affmr328999525e9.17.1786990623928;
        Mon, 17 Aug 2026 11:17:03 -0700 (PDT)
Received: from syslab05.cs.virginia.edu ([128.143.69.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996176b95sm124434885e9.10.2026.08.17.11.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 11:17:03 -0700 (PDT)
From: Tianyu Zuo <cosmosocket@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Khalid Manaa <khalidm@nvidia.com>,
	Ben Ben-Ishay <benishay@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net/mlx5e: SHAMPO, Fix IP length overflow on large HW GRO sessions
Date: Mon, 17 Aug 2026 14:16:18 -0400
Message-Id: <20260817181618.2786456-1-cosmosocket@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5e_hw_gro_skb_has_enough_space() bounds a HW GRO session by the
payload held in the skb fragments only. The L3/L4 headers that
header-data split placed in the linear area are not accounted for, and
the limit is inclusive of GRO_LEGACY_MAX_SIZE.

On a 4K page system a session can therefore grow to 16 full page
fragments (65536 bytes) plus the 40 bytes of IPv4/TCP headers in the
linear part, giving skb->len = 65576.

mlx5e_shampo_update_hdr() writes the IP length itself:

	__be16 newlen = htons(skb->len - nhoff);
	csum_replace2(&ipv4->check, ipv4->tot_len, newlen);
	ipv4->tot_len = newlen;

The result wraps. ip_rcv_core() then trims the 64KB skb down to the
wrapped tot_len, silently dropping the payload. The IPv6 path wraps
identically in ipv6hdr->payload_len.

Both branches of the check are inclusive of GRO_LEGACY_MAX_SIZE, so a
session can reach skb->len == 65536 and wrap tot_len to zero. In the
page_size >= GRO_LEGACY_MAX_SIZE branch skb->len already covers the
linear area, so that off by one is the only problem there. The fragment
based branch additionally omits the linear area entirely.

Account for skb_headlen() in the fragment based branch and make both
comparisons strictly less than GRO_LEGACY_MAX_SIZE, so that skb->len can
never exceed 65535. The new bound is strictly tighter than the old one,
so the implicit limit on the fragment count (at most 65536 / page_size,
well below MAX_SKB_FRAGS) is preserved.

Fixes: 92552d3abd32 ("net/mlx5e: HW_GRO cqe handler implementation")
Signed-off-by: Tianyu Zuo <cosmosocket@gmail.com>
---
v2: commit message only, per review from Dragos and Tariq.

v1: https://lore.kernel.org/netdev/20260729204745.166584-1-cosmosocket@gmail.com/

 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 6fbc0441c4b8..2e9676305439 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2222,9 +2222,10 @@ static bool mlx5e_hw_gro_skb_has_enough_space(struct sk_buff *skb,
 	int nr_frags = skb_shinfo(skb)->nr_frags;
 
 	if (page_size >= GRO_LEGACY_MAX_SIZE)
-		return skb->len + data_bcnt <= GRO_LEGACY_MAX_SIZE;
+		return skb->len + data_bcnt < GRO_LEGACY_MAX_SIZE;
 	else
-		return page_size * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
+		return skb_headlen(skb) + page_size * nr_frags + data_bcnt <
+			GRO_LEGACY_MAX_SIZE;
 }
 
 static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)

base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
-- 
2.34.1

