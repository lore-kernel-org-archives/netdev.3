Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2E4DDB39
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397000; cv=none; b=XUTa4vH3W3oRGy/oQbWgbaMQe3q/dWutsiPO781micrG1ozanT21qEY6BGtxME6MfyoumT3SfwiMtKhPXoAg73aElT6C1q9ML+huapEUPtmXJGtUJ10yqv5KiVvS9QKdIJTYSUOVjFz955pnMg7ae/9sOtohhAcc3XDT/AytDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397000; c=relaxed/simple;
	bh=zznhnNGgkEt9ZSSy2T9PlgogR6INn8I/GpUQzjq8ahE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qla0EBmsXDUv3xZwjr0CUWPxLl9s4/tmdm0Z3OVLMdx3UDIPddjhP62MqJs2TEwdOXdsJchzLEk2X2dRFOvriRNoy/Uzhh3I+icgEREdMu5gKv1A3XOqCKu4XGhRYg4zSqmXDn4jxQUq0y4g7YowrhOtA3mtWM/GTDZGUSWvv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Z3bBgEpI; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Z3bBgEpI"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9144e8021d3so72041416d6.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791396997; x=1792001797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
        b=Z3bBgEpIg9si/rzGnkwx+hT3M9EhY7/mvvbue/rYLQRjusEjYgVIgoGNA2MG3mxjPF
         v7zSLDDRKmZqwzY2fx/MX74Ew73hieAd1+7D8M8RnEkPCzI2qO9P3nc8kEY1tD2X+4Y5
         9nWS8H6ttd8Mzq/iHfJ3f3Bpt55fx3PkxYtWaz0sE2m60wB5q0MZmSL4hFGFVk0iHPYv
         SEL3342Uw7HLnAjVMPqbD1R4BJNUISBEizwrlRJq/KuvCWcJBGCkeCTTcUlYaP8NvOgD
         UB6bs8GToQ0lO3wuzoCXUvG1LJjBhsL6mq87YMtOLnwxq48X19+zITlCqdzvHvf+JwsF
         ZxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396997; x=1792001797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
        b=bZy4+7MtV/xbt3JS+DsR2tFY9YU+K7daF734B0MI0KRlb9x8b24b5aJYHJ8jFw0UiU
         Gvdb3tmz5V/fpaiD5f0EsoKUlbjwEhGHS3Z5xbjEC6r1i1BLKvAyU2cE1+Ufiuy+Od+S
         wG6ow6lUCeVwPo9URJ3Pnb6rBenYSDehzX4cu5vYOw2CZFX4VaRaLg0sQ5OCHF4WZjO/
         es/ybsJoHBTvmbKt9NgwyKw8spQ8jiCjYvDWdkdtX+SEinyLzUyPLbApL1fsZtdu2UBg
         eMJx7EhAAFRC6DNqlrkZKLScWqk658kEwo8YGLO+ebXIaevE1ag/ZW5asnVEtaJVg0Zy
         qGyQ==
X-Forwarded-Encrypted: i=1; AKwUvByGN21aqBmEOfXeJkgXph7x5WcrCEV/W54cKwXWB3/x/94h7cf5cBI/DwXo/X4oKnlFFD3xyDw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGG8Y4HpTRuedfj3Lsh8hVpjpM6pkcFdjUp/oZ4xZIqZ5gRDa5
	WxHfdSWoCB+ksCHu5sYI7R7GLoyB+JPmtPEPlHsPNl9GjlUb0AzYKSWK47b8u7OVvOw=
X-Gm-Gg: AYBFou2OX1IhW2OLqhMAR4ZQr/etRSW6HpFCItS3BRkWL5lB6AwMiJnryc7XirHIUDp
	iXNOMlYKi8F2g5QRmm3WTrfW5hLtxw1VZUwF/xgigbLIb+L+69gNco+WCqrFjvZtYeGO31wZM5B
	GXOo4Z6dvfY494MZkj+BjL/3Tq7Qn7MOP+2Ag8PqvG+6FNHOCpfVy8pNwWrr8Ge+J8c4qiKrQZb
	L2Ha+eq6KCdVj2NNN9z5Ii5s2q5YacgiMmyBA/FtkDon9FyIzTd+e1tpy+XPC8xIBt4yz4JIPhZ
	B9ESWYr5ecnpq80jioTAOxq228p35JU/SGpXYRfPJE1e1j6W+t1stBkoTuHpkBoYpHxOzIekGnN
	twyfL+A5DATQBy8wHpXH3R8Tkf1c2fvOd0yjQB5hGe34rJVz72r7hK99xYwp0jyjRBE4xpatwRj
	RkPzz0dzsIoLmHak4vo7N/WI43KNzLP6R+NEj3DjW+np+TF8tN9USaMIe/KFbVg9N1Fp6mKdQRB
	ytwxYNQDM6EDjM=
X-Received: by 2002:a05:6214:29ea:b0:917:8400:5eec with SMTP id 6a1803df08f44-919976fd758mr60391986d6.5.1791396996945;
        Wed, 07 Oct 2026 11:16:36 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996bac803sm26531506d6.3.2026.10.07.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:16:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:15 +0000
Subject: [PATCH net-next 2/9] net/mlx5e: check for failure when pulling the
 Ethernet header after XDP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-2-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1491;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=zznhnNGgkEt9ZSSy2T9PlgogR6INn8I/GpUQzjq8ahE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM+jiGljpi2X00qowHNyzmeos/hw24wETOq7O8HQRrlF1LPa5A0l/9HtyUoj5T4Hstal4F6tvLe
 zEFqab3/2JAY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When an XDP program leaves less than ETH_HLEN in the linear part of a
multi-buffer packet, mlx5e_skb_from_cqe_mpwrq_nonlinear() pulls the rest
of the Ethernet header in from the frags with __pskb_pull_tail() and
ignores the return value.  If that pull fails, eth_type_trans() later
finds less than ETH_HLEN in the head and BUG()s in __skb_pull().

Use pskb_may_pull() instead and drop the packet if it fails.  Pulling
min(ETH_HLEN, skb->len) keeps today's behaviour for a frame shorter
than an Ethernet header.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index e3f915beebe1..b1e1e30a77e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2060,9 +2060,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				pagep->frags++;
 			while (++pagep < frag_page);
 
-			if (len < ETH_HLEN)
-				__pskb_pull_tail(skb, min(ETH_HLEN - len,
-							  skb->data_len));
+			if (len < ETH_HLEN &&
+			    !pskb_may_pull(skb, min(ETH_HLEN, skb->len))) {
+				rq->stats->buff_alloc_err++;
+				dev_kfree_skb_any(skb);
+				return NULL;
+			}
 		}
 	} else {
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {

-- 
2.55.0

