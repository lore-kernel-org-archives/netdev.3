Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415F448BB3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493413; cv=none; b=OGbTmaSqtrkWXu9xvcG/8mptz21RtSO1KP3uChXwd2X0l+Twr9GFxELeHA3yACdwr7PE6o4SccNeyd2bGWhX6D43/1EfI8t37H7Y/7MRs2EpZJHgvyxLkzYvJMYLWBX3cAFvM0Y8YMGbqTQcbnJ7ULKgy+R2WcGDL9nwp6nuBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493413; c=relaxed/simple;
	bh=zznhnNGgkEt9ZSSy2T9PlgogR6INn8I/GpUQzjq8ahE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUNGk0GthEf4GkFi9qZtg02E4OBAw9f6WRo69/GiRI5vBVoRYCh/vyH11UrzoQ9SwN53HiGynu30smL+/EEBK546jQ6lDI4i+4R+TuvovbwsDDUmF4I9r0mDa0Jq9KmfX3scZ2keU9/05tUqTCL1/ep4jqlYQtcg756gcETYXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=bDiXTmrm; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="bDiXTmrm"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e027da24aso288037885a.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791493409; x=1792098209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
        b=bDiXTmrmwBfykzMR22ynZChL38KvPNioLsJn/yciYP2StI3Rb10Fa1AETdsyF79vdT
         kJpTH7nkZ7zeCczCoIvZSQVKXznUi/yqDlR1Qgi9TQhv2d2yKPh9kjRDG7ZnJpxnFlI4
         4xQpoRUMzuqkqwRTZcZ+e9KwfsdMkrZp6tooL+4rD0K8S9+96fweDZLEf/vlWgsTPrC7
         /ZRTJrEVzPlKdS3MHytKydjt6DIizv9IeKXUhKdlDt0yshQ+Gf9eFv9M2bmyZYMcsnVl
         DJYBPLVf4YDLtwQ6jWuMec+JpQAqhpRpAmNrGcqYw5BmBJxJ7lu45upg34gMJHUMl9gQ
         aYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493409; x=1792098209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
        b=qX/JfpziLgNqwOMGwiWEUGQ3y0X1v3dpqqb3nW3GWPrmWb5YGZnMfgy+VzGzZJFP8f
         KlaTAZyTqqAFaHRnofXFiHihoLLjzDnLi2I3YEu7ZDwqAf0Nn4dJ+5PHCUgR4zLuDrib
         tv6wj6yN+CgHQeV1+6NpGuQoSqyTabmm3AZe375/R9Yl1o163l2pqSwVaS7UYbC9bq4N
         cipcTeT6MRPl2jzHBizpEvrsRM5abEJIkTY+D8H8nFb/fOwNaEz7d0SB0/NdIxq9ANga
         a/K3M8+pSEmjWuOBRbXbzg9E3ykDdvOGOaTxjA7dqwId81KIiyGzB5gcCVZRXIUchhfN
         5ryw==
X-Forwarded-Encrypted: i=1; AKwUvBzGZWE6mKXwN0RGOSJv5+4AsGa8bWh6r46jvVSeinhEcMU8vnEe8+cBt3PJpBPncKyvf+nmhVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIivCeD0zkMO0UqOGO9PJp4zhf2WpM+0ZfNFkMIb0/aHBsWhjYS
	3EVyNs7S5dKDnvhl81D9s3YopH3b2xo9FzSSzC0lT9kZaiU0Ru/RsbRLcBHiWHICDG8=
X-Gm-Gg: AYBFou0Xs8U2V7mSbhQcoMUnuOuDkxTmWdU2zdsZrUr2MAK7soeisGNopzbIIKbmlbj
	j9rvRjwUct7kbl+bRwoYKcIkjhNqwudHHHnWddwE4rh7F9PRdTynhzRMC/7kk2fbhajAFfP7nX6
	y6OOAoM/B1iXX1GrhK5UUXjzGUKxRRHTtbJ57EPxyKdm4pVNWIPcs7mA4TqD2wIBLdNoXbvIMBE
	cyTm8mCOvEpGSkQCnxmCzmWhFcnaziaizCiWNhZlfOijDz7S7eOfZj1ShvhSvh9Nx2FqaNxoRI/
	Y/VDGdU6WyOY4ZqOyVLjHKgn18lqfhRQQVRdpSj8g1zyGsbjkgkfsMjMlZWFWIFzoQDrWDLjkDu
	wDWCQ1XW+2Bk7uTOIt4NwQOm+d/heB9DyTF2SiCUyyDx7SnZp660c0lK1xR9fEMt1jsHmaJ7BFz
	jTJJY6//1srXHENLxFA8hO9urdk8NoR5dufvpi3FSrN/NmdTAAPZMnEAtxMuGRHrZSpSIovnljA
	/OAIIy0kNJq9PA=
X-Received: by 2002:a05:620a:29c7:b0:93a:2a59:3377 with SMTP id af79cd13be357-93e9b799671mr1358007485a.41.1791493405607;
        Thu, 08 Oct 2026 14:03:25 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98c818esm23024485a.36.2026.10.08.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:03:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:50 +0000
Subject: [PATCH net-next v2 03/10] net/mlx5e: check for failure when
 pulling the Ethernet header after XDP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-3-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493384; l=1491;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=zznhnNGgkEt9ZSSy2T9PlgogR6INn8I/GpUQzjq8ahE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFaj9m1MCb6yydGhkDduTFS5Q4Ekj/GXk/66W/KuEGtH8miGll+pKUls7h6lvdP0A6+k8X0JuWF
 J9s3G82EktQ0=
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

