Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984143B14A4
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792126768; cv=none; b=SwMy3+1XOAjZLuTGWVb76zTkBkZneCCyvRQFVugYpjQGPAG/S8ybbLgS0UM1K1dC/BgQOb43V8c8y1WYL5FUIr1etU7sdqEgpNm38/ntKLRbDNLNk15qqxJ2wRoSUNpAyPxRj3mH8kFvTCyjb1HJJRS/2EcFBwkiaZSlmvu85F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792126768; c=relaxed/simple;
	bh=IO4m2zMuyhW0KS0Jvv/07DF2IaAt20vkVzoV253KRQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTrXpNLZHTyEIRDaDTPq5+LfE4q1Mfv5RHZmjwXVQzB84e47YDTIFI/3F29OSOALIpy++mhD44c7gozgdS+xzUy5ymiDKQU85oDjw7U2EyoDGfYWUr3AFWZCO9BuMwrfKXmvqCZp4Cz1BNz8liC+f/d3Pc//g5MvFvDSLhdD0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyof34RX; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyof34RX"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e635220b4so589546385a.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792126765; x=1792731565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkExTl4ImtT/SqRzjGR9HGgwzVDT2pgqDXXqm237AHQ=;
        b=iyof34RXGtg4l5AjvSLE7DmExggufR7Eol7Tyd7AsCfGHJUO/TlwZmhcoP7UM2XW9s
         tO4zj6MUVuJsWKLWqFy3TrN2ZLLYz/0v/zDaLYKO/vYzXS5UkD+IikbKtH7nMEGti17o
         6Betkzsvm2MPxU4O+E7cg4iUKbIijt98rhAKKGDQnVf+aQpDC8sR1ezcVrXMjZCFGaGF
         bIVoNdnT/xbCGWYZB+TeO8fj1aozO+aqYcQ4QEeJ9OSlIC8wYOAuXF46EFDCZqOsyQ6j
         bXa3Ed/wxZ4CEQlAQUgUMQNjGjV6h+ycW+sC3pU0T2j3s7i8HLNLlmnLw3VLx6k/uHi0
         9iTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792126765; x=1792731565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkExTl4ImtT/SqRzjGR9HGgwzVDT2pgqDXXqm237AHQ=;
        b=I1YwdsmDeLSO/R86wiF25OwGCPPk58VOqRpJNqOl1tyC3Kiqvgn4CWQFONifz0lQhz
         KNl59+BrSTmeMDT3S0Gi0tIE6bLTOAAHWYG/ltMWRALa5xmXgm1JjkWiv3syLGP4tqJ8
         HSVGvecTMQAyPjTOdYTti4//vA3gzOz6C3QEpWrDqxMH4vMSFZ/JuaQNEwCZv2DqoE5C
         rIkG5aUaeRTpliwR2++upAddm+XHhsZNzVzJXvULhGndfhRjJ6oVO+gvScile0Ia3jfd
         LWvGz4ifJOgq26zsU/GGkx8bQjRvBn8oqcPKiISswU4p+6wgEqIja/5SNL/k3awh62Sf
         caPg==
X-Forwarded-Encrypted: i=1; AKwUvBw716S8ekS7HVIH0HK/jmL9nJ3sSlsQZa0xMyPfWz3eNaqzJWmqpaBkTRFA+vHkV+ZSj6eEI2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYfZmpvNrzq7R5vGYyVAwyh0G++ogBXCmJTzFoQeAR63GoRLWY
	xFh662NhXfUtwAhCTQX8umoLBlZ3dWzFIQ3cR4cpjs7ropsiV0zRTMm9
X-Gm-Gg: AYBFou1DsS1jv+5CiVGYaU6/2gghlkLdnhQgb6vnFqVx6tOMHjFnOWjakWARvMK+J6Y
	C3qXn8/qicVTxwRS7goI79VlczPcQDcCx4YOYLt+7QgqHCPpUB/usCplKkn9tJMObCYBE7YjuV0
	aPjEAUxeJA1V7IG05RdcNHA03fcmbERG28GMlWVXSVcevd3RvjcCDw5EcmnYi9KcYbBXQk9zF/4
	tzpzXgAYkFN5aXblndvkzz3m11R63AuHY4QnvrxltWsy1REuzGw9ecF+jqBsu9jlMnKzGtaYVTQ
	Pn4SDV4QDRcASqQquBWtu3df3JPPltVN3i9MZLoUY0wI6VnRPcRO05QhNP+y8nRNUph4gqidmS8
	LvT/b5XadJ2VT/RePkEEOJmGOk9uI5+d8EE91rqWYcJZohpaslVQRl12yynO95TmVb54fFplvNR
	m7+X21ReXyyyiP9S3KK6bIaHIC+BioGRwDclRgl7sKvMvcuga5EN5LLHOf6n2seoOSJ3dWSvjjf
	VOpJJaJ9bjxOb6EGD80JTY=
X-Received: by 2002:a05:620a:2911:b0:93e:6100:6c1e with SMTP id af79cd13be357-93ebd2448d3mr3640455885a.30.1792126765586;
        Thu, 15 Oct 2026 21:59:25 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a198372sm118038685a.27.2026.10.15.21.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:59:24 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ariel Levkovich <lariel@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Alex Vesker <valex@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH net-next v1 4/4] net/mlx5: HWS, Don't free the send ring CQ buffer if destroying the CQ fails
Date: Fri, 16 Oct 2026 00:57:49 -0400
Message-ID: <20261016045849.813696-10-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016045849.813696-6-oss.patchbox@gmail.com>
References: <20261016045849.813696-6-oss.patchbox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hws_send_ring_close_cq() ignores the result of mlx5_core_destroy_cq()
and frees the CQ buffer and doorbell record with mlx5_wq_destroy()
anyway. If DESTROY_CQ fails, the CQ may still exist in firmware and
retain access to that memory after it has been returned to the
allocator.

Leak the buffer instead when the CQ cannot be destroyed. A device in
internal error is not affected, since the mlx5 core reports success for
DESTROY_CQ in that state.

Fixes: 2ca62599aa0b ("net/mlx5: HWS, added send engine and context handling")
Assisted-by: LLM
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
This was found with a static analysis tool from ongoing, not yet
published research, and confirmed by code inspection. It has not been
reproduced on hardware.

 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index df3b93499eebb..21e2d0a26e88a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -1005,7 +1005,9 @@ static int hws_send_ring_open_cq(struct mlx5_core_dev *mdev,
 
 static void hws_send_ring_close_cq(struct mlx5hws_send_ring_cq *cq)
 {
-	mlx5_core_destroy_cq(cq->mdev, &cq->mcq);
+	/* A CQ that was not destroyed can still access its buffer, leak it */
+	if (mlx5_core_destroy_cq(cq->mdev, &cq->mcq))
+		return;
 	mlx5_wq_destroy(&cq->wq_ctrl);
 }
 
-- 
2.43.0

