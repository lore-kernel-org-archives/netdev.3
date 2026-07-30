Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E292299927
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785376679; cv=none; b=mQhBGFYDRhkT/ekPKhSNJDuh+nhpCIQjVIfYBpnZcncRoJYPuvROKy6td7VNL84sBFBJPNkgmLyJxagBcduCdk8QRWzKow5XzC8ooHEbgFoR5AxfbwWW5YHmqI5yQHXKEXSVwQTvxvUQFeAOAlPfWCN0BGMGksreLahzHYF9RPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785376679; c=relaxed/simple;
	bh=M3YnSlexDzgyDOLOglqYCKDYpDRc2VPjQZ14dQyfHEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W/HNSSZZNeDkDmEsW4oGpi3IBUmG8McdttPkbsu0fbf8QH/fRjLi1ZgHVVlInjYTGBCZ9QnqbjDeouJnebxDlInbgd+fwt4DpXKyxP7jChJCStoimSAkZmPxaRvxJigy4mYd/uJw3folGLAswDGXhviuxizy047KHg7GOW1QcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE352PiA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE352PiA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f236418so1287022b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 18:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785376677; x=1785981477; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=om9QvL01n821FqLOPoOT8G2ZwVTrvL93rWtkTe5w6rs=;
        b=LE352PiAAbqT1D+6L+Bo1tlChFAxHZxu7N3kCa37I31/cZPmZu2sAwxwuwIrWNYf/v
         IbJZXV5FXWct+3rJTDCQ/PzRL0GZPo5jlfBm/LYpEE0AKCaKLfTpigKSH9Cgd3jCf8nF
         neI9hSU8kxODRb97xrSn0nwnTgVC6m5qw08sjC7bg6TTvc4RvtFAiJAW0pjXCKOCOB3c
         psdYXV4a65DIBiLb0vL4zRSAdhWU0LxchGYOSez8i+rZxxqzyK9WfBv3qCKYrSmfDMdU
         +1b5fqrKtRUpJ6ZX9CUf80m8YnYmeCpUGvIAutFILVsmVlP8+p91Bij1LqLs7+wgyclb
         d1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785376677; x=1785981477;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=om9QvL01n821FqLOPoOT8G2ZwVTrvL93rWtkTe5w6rs=;
        b=SLEO48N40xGJRqFeJnMt0E+4XvZGRSgluZ8C7aZfN30X8lspGSa9Vs2JtvzwzliksX
         EjSxNzVWpTj0HIfw1KR4xqNVqJ2UF0MlkD5TKXJ9RGDbE2/kX79cDj0sFzqxHBs4F8ZG
         QeBQqaVMeu9JcjBZY5wvBmig+FJAixp0wu+SMPqWI4S7yQen11zc+9D4jHHG2Zg65sL+
         7R2F0V1t5shKLXzP+9pXJ8Ib/psz85JZP8DEdvg4h2t7jetPX4ob5FB5O4L7a1Y1+kHS
         qyf3SRLXF3J4R8au6ntNOJq6lUuUMq0wbotyqSZfY342NU8PmxkaH2oyL/z+0t+kjnyi
         s0hw==
X-Gm-Message-State: AOJu0Yz23oxxCuVKOg/WsrhfXqkmlFHpGcYZVGFTnG25A7QKlWNEDQHn
	GK709453cObnmh7mbs8ogvI6wQaakRjSo8GIxkncYjVVEmVHxtzPo0SL
X-Gm-Gg: AR+sD10Nc/Wg+r2GQUYI6q80s5CA22lwkXZdaD02f509CTGcSFLngQZPCNQsVzfDV2K
	tuXGBjvFrh/xza+ZeoLNbZ4wctFCl28LRF/hGOvF7jWbUnJ5JeS7EgLZhtp8SSgMQie9C3+io8F
	Arp5hx/KmC4grxQ3teLHpZcyYyW8JG9mbSp2Txnt19jllvJ7C+x0QcPEPHP0bkwaaIay7KhwBot
	uclKR4+yZPjdt4h1jB/9ghMRTECmkjpNPoEY9z9ivXMW7Ct+lp6CcLhNAxhJhnlgtmJQSCIBMsR
	2dZqN44aehC8/0TeqGGDs2Fjro9ZKfRnSRJv5IaYSabBlSBxek8TgGk6NdkSRxENvwgLGJNrExb
	OFibszOdo2WH8aST+kH27mCPdzqDt7mPkrV2qkInv3IYB1CqnrwOxY17Ls53vLjnG6j83PkYCVw
	o9iUOzu8p/LXq3ZjJ6W3oX4Eh2F2xRj8q+SZTlo+/XjI8LcgxbNMpa7DFQYA==
X-Received: by 2002:a05:6a00:4c83:b0:845:dfef:75b8 with SMTP id d2e1a72fcca58-84ebc1fd794mr723014b3a.15.1785376676571;
        Wed, 29 Jul 2026 18:57:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe2153csm2149386b3a.3.2026.07.29.18.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 18:57:55 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 29 Jul 2026 18:57:35 -0700
Subject: [PATCH net v2] net/mlx5e: fix BQL reset on SQ re-activation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-mlx5-bql-v2-1-cdf285e586df@meta.com>
X-B4-Tracking: v=1; b=H4sIAJCvamoC/2XMwQqDIBwH4FeR31mHSWV12nuMDmb/LSFt04hG+
 O4Drzt/8F1IFB0lDOxCpMMltwUMTHEGu5jwIuFmDAxKqlZq1Qm/no2YPqvoapLKNKZubQfO8I7
 0dGepHgi0Y+QMi0v7Fr+lP6pC/9NRiUr0vZFm0ppm0ndPu7nZzWPMOf8A1NtpUKQAAAA=
X-Change-ID: 20260728-mlx5-bql-84e02a5a46c8
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

mlx5e_queue_start() deactivates and re-activates all channels but closes
only the queue being restarted. mlx5e_activate_txqsq() then
unconditionally calls netdev_tx_reset_queue(), zeroing the BQL counters
of channels that kept their in-flight TX WQEs. The next completion then
over-charges and trips the BUG_ON() in dql_completed():

  kernel BUG at lib/dynamic_queue_limits.c:99!
  RIP: 0010:dql_completed+0x23d/0x280
  Call Trace:
   <IRQ>
   mlx5e_poll_tx_cq+0x668/0xa60
   mlx5e_napi_poll+0x5b/0x7b0
   net_rx_action+0x15a/0x580

Reset BQL only when the SQ has no bytes in flight (sq->cc == sq->pc).

In the case that reset is skipped, the outstanding WQEs will eventually
complete and rebalance the dql. The dql->limit is carried across the
reset.

Fixes: b2588ea40ec9 ("net/mlx5e: Implement queue mgmt ops and single channel swap")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- remove misleading comment (Tariq)
- Link to v1: https://lore.kernel.org/r/20260728-mlx5-bql-v1-1-99a0ab77ede7@meta.com
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4a8351f95b27..44834890a409 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1940,7 +1940,9 @@ void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
 {
 	sq->txq = netdev_get_tx_queue(sq->netdev, sq->txq_ix);
 	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
-	netdev_tx_reset_queue(sq->txq);
+	/* Reset BQL only when the SQ has no bytes in flight. */
+	if (sq->cc == sq->pc)
+		netdev_tx_reset_queue(sq->txq);
 	netif_tx_start_queue(sq->txq);
 	netif_queue_set_napi(sq->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, sq->cq.napi);
 }

---
base-commit: ec83512ba345b1e415ca491509a7a952db84c4c7
change-id: 20260728-mlx5-bql-84e02a5a46c8

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

