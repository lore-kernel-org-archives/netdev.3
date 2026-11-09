Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794195943;
	b=byyWEEinELDMJG2lISUn5UV3UDV8d0L9cQLU6roYm3RWUyEu7Xf630M8EoakjXBNiiOy
	 Re8qWIsYHLq6RIEszx80DGerCaNWsZCXxvg3ymfSdSVoARQFn6BeLFwxnki2xlcrdXAU+
	 xQLDrTO/UzwXWSwGCq1wiyulHn4xkmwwiR2f7iI7G0XehlGSe78sOz+Vy1pX1OaCwEw/j
	 AL5zy+ApN5yTgQborpGKL7nnYxswaKIe77+OOV5FDhi1lAVX8i2oGBSF4Sn9sLTdPJuLg
	 /Zrv9atXhEqEb8IORfaJMFv88vXIcAjiYSkRfOM80/DrLpeoUQMOCgqBbJEJewtHEZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Pgnpxv0RoNPV5p8XWSvBBpRKwBTfMqOXLtDwjioOWr0=;
	b=GZiXrJPbnJrud/xc5escYe6VdyH9X26aZkEILBNScz65QBoms88tdr8WLi7weeZ2CG56
	 Hok+PVpMIwl9Pwy3bGIsI323oxLuuuMNsMc5FF2GoM6+/6WFnnJZ3pq+gjNn475Dg1jBj
	 49+OXcJ2Csuiim1TvsqpHwW/PUpkFNY4p0vQDgUxeeFLTJDCPzkXoxZ2rzRrgJOjwYMb+
	 Gua16kxPFQVRuYIacFmk8e9nYEAXhvueYXsgpNa9XqlyJ+x/C/xs2mfFK8zyplFapc8Di
	 tJUOcqSkqramVZOjmNQZNZN0wHBzsJlKOf1L9fqDvqRf6W/0lgKtRfjm8/hatYhxBag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Khb7yAbc;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFE606A322
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 03:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40CFE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Khb7yAbc
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso283030c88.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 19:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794195942; x=1794800742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pgnpxv0RoNPV5p8XWSvBBpRKwBTfMqOXLtDwjioOWr0=;
        b=Khb7yAbc5rELj+ohLViY7jPfHoj7CtrDp9eidzJyaqonSb+DwIv0qXBpeQ8gMTgDph
         HCxbImG6Ng008il+ZTRpkr1d54Pyi6TPFTAvIHeDqR0oteMus0YMPewI6u2bEVhZtBZZ
         P1TYj/YTYFBOT8XxDx1JrVpC2Fu8CpQfRnVJNRcpdspOelpJKXoKK+385iC3p50ZGx1Z
         sxWaeFiRnwKSAs2N+JSWKDE7qlW5NM1p0S6nA/U9c0I8lGilNNpmMCdSLyO5ceFcWwoC
         +VRecQ/tSL6iqt4eaksFmIMWmLWWPJN0GwAFX4mc5k6Iwy0E5Cd3GGQ3HohljwBEB0Wy
         +Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794195942; x=1794800742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pgnpxv0RoNPV5p8XWSvBBpRKwBTfMqOXLtDwjioOWr0=;
        b=OK5A+0JGI/f8oWoiECfKaaTBHwQCPI4LhsBOZs8FoKKojqNFz1jJ/pDlTZUUSgWww0
         x4Phd3mZBLbxtDeTIQobZlljrTl0nYy0nweGGUqEEJ9cP/NjR+lqCAFby/L7N18ulwBP
         VTBUEF2HOydBOFq9EB208fLYY0Phc8f1ikQAu2EnThXKnKeToiRAXYXBF3zdENL8eWiJ
         mzk8L90N5PhNlsaElF5cpURpshOHI0lloQgYezJUqYOjS4UMQOhVZsb72zInHvkjlGnb
         BzFqcxoI4TWbrjZpBv01Kfgfm2rDKZ+D18gcvj4ckmrN9wGOyBeWXLrz/R/uLljp9oUD
         5ecg==
X-Gm-Message-State: APuU4Z/0rkEWYVjr7gLukr6zSRQUk0VJqW3mDRnRFt8QNy8Hmo9cxAJz
	WTEo7AjqKFwlkrRIyHkz9+HiyZQixZOzTi7FGqk7yKPPy9issm27IfzJ5O0kcBOqI1qqGw==
X-Gm-Gg: AYBFou2+WnpkU8IR4p1AVLIw3D6Jiu/58Ww3uWDtHoLLt7dbHogC+GOVaI4uxh99Wtq
	CltDIApS30GdDY1pJ7OdQsFTshnm6vUMtTARuSw9CEY0jT2o/8Yz8LKrilUgsTyS1oqQVPeVCBL
	+Gdj4TVizoLALI/Skp8lZukx4zEdPRKaeleSg4JPHqyuh9vv0GjGvXse1+kjmorujeZwuQ5uuCX
	Z2CA/JPfyVp7JmIMVoKBpUskvJO+VoJKm6w79wpkwABYlIJyLLnPe42ARvyTq7UCXKWf7CMb7qE
	MqY1UdyhnC1qNfkBbOFoofYl3d7UzVlsgiT3eBnwnU+yQM0rvcHc/RRXXg34QcrblEzxWyB/Gb4
	5R3YMSZvvYtuUC4UvlpCVLPXqjdODAQqrIwsLfRu4owGdiDEC5fDhfkJBQPmf/wvmw1BOw7kiTD
	jyJGfRRNCjncocDX1cscNqr+FqfOKCzFIYkRhei1NTBSMB18KaEB7D6HeEYpvWrR9VTu0RkTbO7
	+LqNF1MIeBXJib/ZtrlqMNjg7ea607QTwE2S1WtfwcVUpH1OXFIT5WoJlyWOHhvivQrSm7vRKrA
	6U6GUkpduFZGQCjTlva/FelzYI4DJQOoZ2hzteGN3skU3/OdsgbPv989ajvpPtqoy2Gy
X-Received: by 2002:a05:7023:d07:b0:1b3:ad63:b9c2 with SMTP id a92af1059eb24-1b3ad63ba53mr1375561c88.22.1794195942220;
        Sun, 08 Nov 2026 19:45:42 -0800 (PST)
Received: from localhost ([164.52.124.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755eb6efsm11468146c88.4.2026.11.08.19.45.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 19:45:41 -0800 (PST)
From: Jiabin Deng <dengjiabin2023@gmail.com>
To: netdev@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net/mlx5e: SHAMPO, Disable end padding when relaxed ordering is supported
Date: Mon,  9 Nov 2026 11:44:44 +0800
Message-ID: <20261109034444.11241-1-dengjiabin2023@gmail.com>
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
Closes: https://lists.openwall.net/linux-kernel/2026/09/15/154
Link: https://lists.openwall.net/linux-kernel/2026/10/20/1322
Suggested-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jiabin Deng <dengjiabin2023@gmail.com>
---
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

