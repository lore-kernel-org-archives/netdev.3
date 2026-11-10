Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283078;
	b=2i6mzdeMEUzB5B2JzNDuFDAWtZPuRweZmmD+IEVQhQfMjE5E0ft59UqZT7X8HsPcTM1h
	 YZfX8cEdC1uow52BWXasHApOjx8XKvcO7lhJDjgPSZ6BIKsQGAxYACDCgNpVYdk3WH6qw
	 5XUqzgp9fDAaAa+haHQR6ZZup3d3FTTWhRnEBrEx84JwfHFtK1HjHRibC7+4KssyvB21K
	 zZWYYoywB0/fwc9j2EyO3146YrVRO+RqAbxs8UOZtqENAdceXygPwB1UYvRU0BKaotrhD
	 P1/NAnvABztyK0DXDS/lDJlYvqKNLxL4NLFil0+iea2eqvt/bMBIQy71KXo6vd7v2Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CXkr2SuKnzOJFNr+1uuWJMDmIGWuxbgW0PPb+hSRh9s=;
	b=em1hvPY7GngT10/Rox5NMHUmRxlcNVummXmVqkn62XwsYi58UMyX3zpxWFffbsDuBNS/
	 Ebvgn18YZx0eGm8YFdM8pnm5PIhTryvJjqj8xz+XgZE+2kK7yokeppPzwVy8hPmD+WZHR
	 poZ/iBietVKzVro6PMMbtwLbgEdd2oaQeTARMzw8jGrjbnjFN1SLyxxw8AP6S1J4dIP00
	 aCBogss5E/xJ5Jtn5Po3UULlTpdmmDixcQSrYA9z29u2kNa99oJsGptwDuM0L82lOC9uY
	 A0r59y5eeJD8ApftWYL6yP00wSri6asgsA0tq4jRZ55lfaWbx666QlKBRGAAzz4oWBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eWioS0GS;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B660A2604
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 019B660A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eWioS0GS
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-3adfd217146so584286a91.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794283077; x=1794887877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CXkr2SuKnzOJFNr+1uuWJMDmIGWuxbgW0PPb+hSRh9s=;
        b=eWioS0GSjJlvh6ZHCBGxaaeRsfQzkJcz33RP+AaoFNuh3hDMddsz7w5znvRQzJ3Dls
         n+Fg0ZOheqMQcJc8Q1ya9lPIqyKWWgjAjKOQmXd7s340JImqVg5F9F4RUxdITsykRs9P
         jV9CUDMEkySfso4mcRKycLxZnApuuoxPWjmekbsYqg2akOLS+2tbI/jH4KehIv7IwDb6
         2RaVvTZegBY6dX+8qAyKHxsHqCSZ0ti8aBCLCPEiAimi4Q/mU5i3/x0xdSNTeRataRu6
         m/ZMf43HMHWsEfeym+ATo4mX3nBntTDnUgOq+qsJJZJUEPkrEArzQjHCZxTFPZYI6sBO
         676A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283077; x=1794887877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CXkr2SuKnzOJFNr+1uuWJMDmIGWuxbgW0PPb+hSRh9s=;
        b=jD0aZWfse3N9if5SQpSvoUCumcmM4vUvhMAY3DTJZzWxy/bJ7PtDWPwrAy4vISftM4
         TV6o/UdNYQNB7islZouXeZiunJVVPkjGNu0W/49O8K9JzwMq6RwryN9iR1bQnwAVNjdf
         l0Man+inOiCwNy4WGs0rUJi7gCPpaQwyQVYyaNoB81IWgkHQ3klCoAUtEW17dQ7oErYy
         xpk7EXXl/4hR94e+AIU8LoGq3EVTOsLa9/jztPRTmM7AMaKAwqB8UwWrVoGWO3hdf2Zr
         NTeYfjKhsUTDMk07IjqMFHl9qj0UV1WBMEqVYKGVLmY8A43WJmGaqXrS3AfL2qenoqdk
         uM+g==
X-Gm-Message-State: APuU4Z8lZZl+K2dzvZIbSuhYzI8ZLJF67WdQnipyL6ugk19iBXDibxc8
	sAaxlGDdj8BLDSjiQ1EjL8oEXD0XFbaFgY8uvije8efYE8T0W+ORzDZ4V7mLEWlUae2VUQ==
X-Gm-Gg: AYBFou1Hr7F8AFp1nWfim2LY5hrdX5gJsQ/Gg5b6tRUzMxVz2Njt2OlTnUAFcuQhULr
	4jx2w6q8XOtNK3/2EbLFok5PjSFBsiazYqO0EwlkY/NKRXW7ipds9hO0cRTVc66OhY4PylgGu9a
	HGJ1358yJ1NQK3l4HoalJvF/L/NasSQ9OcXUmbDSCJ++zH/wxZPcl7HY3wiKUFMDbTPyi07d/vk
	RyNomDbj+IxbkmquVx3Bkq3SNSbrWhfAkqM3A6vulA9KP4OUec1NxWvep9hDKgRl+d1FX+YrIB0
	y+8qFCXzh64TJS+34XdVhWrU9+8j/RGEKqDVAwOHnob5qDLjo51Scd27BvSnG9hueRdB7hoNUJC
	TyrNazig2nbf6rNBR96xKQ5a2osiF8BzmVCCwNx8rm21c+TAxT2owYMVQrOodvZQQDk2YsPK7NP
	ZiBb66JTwhU7+wU/2uG4shU0CQ+SCYYJkWx4JZNSWjU7bK1f12ns41XQSD+0he7ckmj8XBM3z3q
	5YJ6jAdNCZg73qmD3dU/oxTcBjeJlOUS/wOe0Y/ApCXhLdscNkFnPtqJEoxwPgR14ToOBEH7gS8
	xkjXgSROVQwe6gX9zWZkbwR2Hc3dNBnjA0D3dO6usBh3qxs=
X-Received: by 2002:a17:90b:4a48:b0:3b0:d365:f8ed with SMTP id 98e67ed59e1d1-3b166cd7209mr1698733a91.21.1794283077269;
        Mon, 09 Nov 2026 19:57:57 -0800 (PST)
Received: from localhost ([164.52.124.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d7b37casm322833a12.22.2026.11.09.19.57.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:57:56 -0800 (PST)
From: Jiabin Deng <dengjiabin2023@gmail.com>
To: netdev@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net/mlx5e: SHAMPO, Disable end padding when relaxed ordering is supported
Date: Tue, 10 Nov 2026 11:57:23 +0800
Message-ID: <20261110035723.26587-1-dengjiabin2023@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When SHAMPO and relaxed ordering writes are enabled, aligned RQ end
padding can corrupt received TCP data. Due to reordering, alignment
padding written at the end of one packet can overwrite data from the
next packet.

The current RQ end padding selection avoids alignment padding for LRO,
but not for SHAMPO. Extend the condition to SHAMPO to prevent this
corruption.

The issue was observed in a two-host test using a BlueField-3 NIC and
an NVIDIA H20 GPU. In the original test with MTU 1500, 354 of 400
transfers contained corrupted data before the fix. After applying this
change, all 400 transfers across eight message sizes from 32 KiB to
4 MiB, with 50 transfers per size, completed successfully, with no
incorrect bytes or corrupted intervals.

Fixes: e5ca8fb08ab2 ("net/mlx5e: Add control path for SHAMPO feature")
Closes: https://lore.kernel.org/r/CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com
Link: https://lore.kernel.org/r/atZKOtjrb9HKSNHF@dtatulea-c5.nvidia.com
Suggested-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jiabin Deng <dengjiabin2023@gmail.com>
---

Notes (shampo-submission):
    Changes in v3:
    - Use lore.kernel.org links for the original report and fix discussion.
    - Add Tariq Toukan's Reviewed-by tag.
    - Cc the netdev maintainers and linux-rdma mailing list.
    - No code changes.
    
    v2: https://lore.kernel.org/netdev/20261109034444.11241-1-dengjiabin2023@gmail.com/
    
    Changes in v2:
    - Clarify that the corruption is not specific to GPU or DMA-BUF memory.
    - Explain how reordered alignment padding can overwrite the next
      packet's data.
    - Add Dragos Tatulea's Reviewed-by tag.
    - No code changes.
    
    v1: https://lore.kernel.org/netdev/20261106083719.22798-1-dengjiabin2023@gmail.com/

 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 5caf7820a136..159f79302a08 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -911,10 +911,11 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 
 static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *params)
 {
-	bool lro_en = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO;
+	bool no_pad = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO ||
+		      params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO;
 	bool ro = MLX5_CAP_GEN(mdev, relaxed_ordering_write);
 
-	return ro && lro_en ?
+	return ro && no_pad ?
 		MLX5_WQ_END_PAD_MODE_NONE : MLX5_WQ_END_PAD_MODE_ALIGN;
 }
 

base-commit: fafbc4051123d5459ea6950899cec08ed946e278
-- 
2.51.0

