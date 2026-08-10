Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51342396D25
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387680; cv=none; b=mkgXQcX0ptJphv7b0MMf/A35tbRyF6HUg7pe3QuJzJ1IY4LD1oaRbrvzS0tVkH9YLLzhA2fUzamRR5dJ17PDASqjlaTHwNPOOPqpPNOYGj8bXGREbnS2XjAasExybCUonYQxDXSBTqcU1q7ZcesLfwDLJzS13DREo95ArMpl/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387680; c=relaxed/simple;
	bh=GKE9WxfuuFSk4fxayK4oJhsYIA/EvxRVXK9sR7Ol0aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfoCKcPR6q173PG6YfdfqOJC/2WJaqJi/BqwiEmO4AM7/DdCShwPS2IxzfTtW9dDMuEOmfFWq2o5cOJpCBHmric08PXs6bd+6VNNCYsA6nbOvnYynU0wi7umimrSPbnVso1MY5hKAQvHClqWg53rRXr3aVJUi/8oLjaxEzhQh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gtb724h4; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtb724h4"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-392c6555df6so404647a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786387677; x=1786992477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/h1pNasFi/92T6RUAvXDvHq7QawRH4lT9AOvszwUiP4=;
        b=Gtb724h4xyP9iqtruN9lvhZNNL2Mw5QzZSOwevKtUYvMt2cv0ckDAO4u8UfQEu0Zmx
         AxeaZZQWOLhKOIifUYslieR9maZ62toBToi/nN97tqOf4MpJzwYbvRuzAOs1+GzV0tI1
         wwkgAzfDg1emRhyjMdLbf/t7z8A+K3S+FFmUOhE4DJrsAhqMRdHYG7/c3/EXFQ42Ltce
         5pXlXLBF3vTVjOAHNF6ZklKLAobnxQzrkk3BnZF9eWJ3DggbRrgGoczbgYGbnbJPF/QO
         l4KSvZvF1HGx2t05JVLHKUlk7dRQSdd1rrwLGQkhzv1fuGCAI0pZAizo4y0U2Z00BREU
         hDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786387677; x=1786992477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/h1pNasFi/92T6RUAvXDvHq7QawRH4lT9AOvszwUiP4=;
        b=n0N4eeP0nVwsDirXDZY8AGIls75PKPQnU+RBg5MXuX8L9SgYhI8e6AxhIclPh6On4G
         wCDGGMjqoM0nYdp5UG5KVH4Tts4iRksVlTW40cri0w8qNCVSfWVg2jV2Ig8HHRxeM2B3
         ZuRtUH7uq4ZZpMkgHBzNtjgeSEbGTwDxE4fh5z2qIES6wsUrwBn9nP/SzUWZIdCdXjUn
         YrChVUExt9PYAUANPRvgRGHbElBNLMSn0QKt1iGDX7G7Df7eifhUBTBj7HJj+pGotYpD
         taLQbhSyKZYzgLFfuTuJ9uQO8nDjZUy94BJ7hmhQZJvWl5Mf5XT+KceGZ15ndGORL3aM
         T3zw==
X-Gm-Message-State: AOJu0YxYoKfu7FoQ0di7HZHdTLiVAofBCH6WPtN/9gkFbfmNQ8ZQL0hx
	wmk24ZG1qsPRUYwRpQVUopWsUoJJC5edXBivBC8qbGr5aTq6Lo9dfrOrBjoRYyvb
X-Gm-Gg: AR+sD10GNVtD9BPyCZNEVxQy+mM+ddieBPqSdJ1wLF10OFFsplEwrldIDyT+jWglSiq
	z6eadOWDuNlTEMGkGtUnIeiCDI2SJ3qBbjctgtsWFQyBg8YhRA2wN8F1flC5ox76NBJkQ1vle37
	q/r+2djUJWCWDTZ/SkQauqtKCzaNOg78prD93ZXCoB1oekn+VbadIIuUH0VjUjEJQVjngSGYsEU
	ebYCAZrgA+eMpxhy/b8QuyN/PgOtNvoYZj2rr+BAlc8DUbkejoMgNtuaZWpelnwps+Wwq/ioivb
	dyc1vcNJRVnPdXJWQmPSjej7H6Oxg5s5CS/1Qblk1mPv+wPxUfOcJQevAHOFv3LiHSvfqK8DTFu
	m2d291/YBj4qAGrIlcP6z7a1baJ0JuUdEUDDw3n6b+z31K9REr7TrHGdkUdF1lw/hRxGRGFJuTz
	QISGcx9vVH9THlGCjeFJP36v0tusJpJFA2AzoasW9A1IGC40+6sY/P1w==
X-Received: by 2002:a05:6a20:918c:b0:3c3:89cf:f3a with SMTP id adf61e73a8af0-3cbce6cb365mr23635499637.5.1786387677292;
        Mon, 10 Aug 2026 11:47:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f38882fsm4517610a12.31.2026.08.10.11.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:47:56 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	alice.kernel@fastmail.im,
	dtatulea@nvidia.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	rohan.g.thomas@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next 3/3] net: stmmac: skip queueMaxSDU check for AF_XDP
Date: Mon, 10 Aug 2026 11:47:53 -0700
Message-ID: <20260810184753.135756-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810184753.135756-1-sdf@fomichev.me>
References: <20260810184753.135756-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
was inspired by commit 92a0dcb8427d ("igc: offload queue max SDU from
tc-taprio"), but the igc change does not apply the check to AF_XDP.

xsk_tx_peek_desc() reserves a completion entry. Continuing without
queuing or completing the descriptor leaves the AF_XDP rings imbalanced,
so remove the check from the zero-copy path.

Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index efa35cfecc4f..6e9d4cb336ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2714,13 +2714,6 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
-		if (priv->est && priv->est->enable &&
-		    priv->est->max_sdu[queue] &&
-		    xdp_desc.len > priv->est->max_sdu[queue]) {
-			priv->xstats.max_sdu_txq_drop[queue]++;
-			continue;
-		}
-
 		tx_desc = stmmac_get_tx_desc(priv, tx_q, entry);
 		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
 		meta = xsk_buff_get_metadata(pool, xdp_desc.addr,
-- 
2.53.0-Meta

