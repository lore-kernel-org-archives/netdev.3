Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199705;
	b=WF2NXf+mFtgS/Deh1u6JcaXR8DRx7B04o2qm7E/IjHTrs5lZHxwcjhP3V+s/XvWYTOJm
	 FpAR3sLNBTJw2y5konBgGBUJ9khvnog3YwKoRVFxZosK5W0MOW4t8kOuN11VxRunZs2QJ
	 gRvGr/KJEXn2qgJj1J/Vk9DlNUdV7Moo28tVDAskaphzmO7f0tfW/Iy5SwxhdkVX6WxM6
	 A5hI05eOEwTpgKkwsNTyImZK9zWvJqIgMo8LbDhbDAHmrJc4kzfR1hrGb54mOPpVbcZsC
	 Hs3W+f8rX/BsLrbePGafAsH9R6yBLYVmGT5kLt/Q71Ldghle4175GhWtjdqXESdISuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=31f6k6Qk+dLIN5aIDYfqU1+fJxCFB196QGT96yn9g4U=;
	b=aoQxZmX4sRfhX/IVj2zdf1IS2BQn6KPupyF64qC+0vmUvn5tcadG8o59ru2QAAFwm4tr
	 +hngRhcZefNk8euR46KQp7snU0MtQRogGuz6K2LHL6htjLlPznxb8Ysyh4vUhIz2pQZaY
	 p/+r8hNIjcz8qLCfyCXFrqPUqCwWDu+7GXkHQiQl3rRMz4Pr/dYmsStYsfEcHFDm5pn5+
	 HLTgxm6sCKOkT2MmEHjHfKVJ1BxoAKIWiEdEPx8v8bWbmOdrjV7EN6mpLwCUZKJ1css7Q
	 Aqhx/BNuUOmkRFWFUGX3/kmJ7MenQCXz69mQ0xB2tUrHjJIDx69KkFkZfQoBYimxBFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r3sNAAXt;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099D606A325
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A099D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r3sNAAXt
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c5b7d5865so140895f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793199703; x=1793804503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=31f6k6Qk+dLIN5aIDYfqU1+fJxCFB196QGT96yn9g4U=;
        b=r3sNAAXtYs2FC/jtFhBxipQFUpM3FslY8spcfNfWA01UUVWzD4GMailvz4SifQgLun
         UL3i8TTTAPERxcZFH76u9T0+NR6kZvfr3FiyZk+MnlGSm0Vy+0Cec5oV8UoIvIjnwNnr
         lBB/Z3n8RQua4T+hRhIotsduSdFQP50yFF2JUnTNMPWz+B+mVzKXGkm0FM/veDc6MMMw
         qPjz0pzYx4OXlKUfucUgj6eNHDHneT7BrQk/0xME3zo7vZZbucRFlHwweMmoYrB3Pb0u
         fT44eTdA1Jved3FeIKDE5uZkNasdxhW2M9Cpd9EPlbQgDKCtPWXKvNDL4/vkCiHpY1k4
         Lx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793199703; x=1793804503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31f6k6Qk+dLIN5aIDYfqU1+fJxCFB196QGT96yn9g4U=;
        b=wm7V9bTm9GIwDBiROWl4HObaDHu9i3rrAUcPs4e1PLLS7mEiedpPVNAz+aHpxOvnq5
         gHRvaQmde7gwSVXTo23TfDdefhzZhMfWLqGq6mA3bVy/d+tfiYaF9aVkGZC+0PZyc1Be
         dxDTloWg5x7wA4f7ITxIhxJVg1Ydx6qgq3iEP+kea5UtFH0Vn2evPNg/CTr7StCprN8X
         +LmC7mpO1FdwqbpV5RBU2tq2nf3NjfHD/8LBR2B5GSXx88QTFQ7xDHza6plCZgGy35NS
         r0C2owYt/7McLPq/c2um/2MmUK6ciTTcadiOgYMoH2gFzKg9cCkcyouIQUSPmNqFPZqU
         7/1Q==
X-Forwarded-Encrypted: i=1; AKwUvByy26rUpxTdRuEx3jkpCteDPNk9Ow8c859HSnJLyUpXeJ9a3WSN+25pLcHmvDSGdQrGaJGde1I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI69/+QlBu0WIqlOp5I5TzraCbhn7CoXZQQWotZwWoTRVfi9MDU
	AfA6P8fkOujRG8hkndCh567dmog2rJgsQ7M5y4okHrWY7O9Ghn4noX88
X-Gm-Gg: AYBFou3nAiPtdnY7YH1+CM+ZyS/dWHMWVgY8xJW3GXswVFIvdd8RmWtieZsf+XHPLqh
	kfz0+JOmF9maC+Cbpvlf83SFJTs4Lzzb88TmkRyxifTnQYMEOvoC/H4trXrET246WgC/uRfGd7a
	9Wb37UvZ+ICwq09MNdA3nAGGEuUZFONVFHdCT2LrZ4BGLPByjZKVqsT1MazZYEeoo5xG2AmWXtB
	S+JbhQOZ/MZNm0mt5ndurpdDH0czC6EXUxfAebYydQHJa+rfp1czOgPr5mF6xWf+J1x+fiPunx5
	TjYzG37Mhqm9BPc4EpdE7L48KOCZ/oPjDHF8eDr6LVLyJCs9WlQEJNdcdIf9w0hKEyZaWS2uiJ7
	DJHYHrGDxtWmBBwxKsJj5WdZR9w/MJqsfgodZv4nvGOQxn/EMsIHRGINA7z2CcxAz5uBLEROgzb
	5oQq5K7INc1lesoF+ru6nccReeft5GHolX7ZdP/bEfljuvjZbfi7DGXUMqsQ89XM/4xN+/lCASl
	ErgQ4X2yOUR8kA1VjVcA7qjLsinLiaNxENGEw7kqR/WhzdRi22EEMYJQYNDWq3ZzKlTAcjMXc4O
	cflrP+Nh95PycP8vNxZhZHAFsWjNxUks4B6yWRJAJLmWiSDboidtXOMqZpi3NYvJVlPa6cG1A5K
	hkGhgliYDPHxD6nE7S2RqSS/KEMDdTr+dHmOtEMwuohg=
X-Received: by 2002:a5d:4584:0:b0:48a:f41d:83c with SMTP id ffacd0b85a97d-48e5d2cfc69mr4811478f8f.0.1793199702768;
        Wed, 28 Oct 2026 08:01:42 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4bc5sm28951293f8f.34.2026.10.28.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:01:42 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oz Shlomo <ozsh@nvidia.com>,
	Roi Dayan <roid@nvidia.com>,
	netdev@vger.kernel.org (open list:MELLANOX ETHERNET DRIVER (mlx5e)),
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net/mlx5e: TC, Fix double free of branch in failure
Date: Wed, 28 Oct 2026 15:57:02 +0100
Message-ID: <20261028145805.54595-3-fourier.thomas@gmail.com>
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

When allocating the false branch fails in parse_branch_ctrl(), the
already allocated true branch is freed but attr->branch_true is left
pointing to it. The caller parse_tc_actions() fails the flow, and
free_flow_post_acts(), mlx5_free_flow_attr_actions() which calls again
free_branch_attr() on attr->branch_true.

Clear the pointer after freeing it.

This bug is theoretical and was compile tested only.

Fixes: f86488cb4685 ("net/mlx5e: TC, initialize branch flow attributes")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index b290beb4369a..c40c7b55a54d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -4005,6 +4005,7 @@ parse_branch_ctrl(struct flow_action_entry *act, struct mlx5e_tc_act *tc_act,
 
 err_branch_false:
 	free_branch_attr(flow, attr->branch_true);
+	attr->branch_true = NULL;
 out_err:
 	return err;
 }
-- 
2.53.0

