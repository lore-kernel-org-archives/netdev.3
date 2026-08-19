Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE3485502
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155544; cv=none; b=NA2rM/Y1+o5fCDJ1sgBU//kOkjPSkAZy3D6j3I/04T9rawZXs/YBr+VsOnVVTtmeQOecGhrVreT2Sb+gVkMH8jmZG7Sshu93UZTMOOzyd4NmKnPpIOYB3MOK0woWZ5jAyMtdy+ekiCM4muQDH5LWNAPyoDfeA/ac6Q87MahZ3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155544; c=relaxed/simple;
	bh=cQTwj67zy7Laq/EhHZBENAZnhoe0otCikzM/pbJIwzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQc2ct1sDQ5dYfuxY8pyaWqA0759HLCtsyggfqAogp+PLa60u3opL8Nd1OwOG+ruCrGQRCfCr8iwF8zcEm37OaXuwclP8LOdz0tuaIqcnDRFJMDpa0pam/v3P4WEiDJgkw8b4UgtGnoeZ5JGxaaCklgotMCF/uD6wvfRCaEqkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTESn9Xd; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTESn9Xd"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so402323a91.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787155541; x=1787760341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CKdPBJAuwbKNHRSj/o9wx9GTRe/KKjDR+X94RAURNcg=;
        b=nTESn9XdI2bnT31A6rjMNe8XOps2FXnK2IdAMHwlZb66qHA9q//IzNOCds//X13m4B
         B6M533AYGYZn7B6ZkSBwBY9bk79Qb9qtedfroxLfFnL/9mHVtkh0SBqanWw/qRCcyhbx
         PXbKjmjmLfw3hYUAabnJ9NCcDg/zAD+yGlBwfKsC6ECinw5bcm5N/+w6otEJNGeXFyHk
         iy4JDjS4WVwRVSbIp3NF8XzH9D2dP7UC3Z3G6SOWW03oeRyohkMixfQ5oA/YFtEw01Dw
         K8sxUreEQBJ4EuFDNL/6tFJa9WEblqVFlaJh0DsQt+AdpXWsobqDoFgcMwwe8JqPJWwb
         CiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787155541; x=1787760341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CKdPBJAuwbKNHRSj/o9wx9GTRe/KKjDR+X94RAURNcg=;
        b=F1MNV2Qu+JgNM+Y4TrIwBUvODejoJ0tbbBfCgfGcHBblwDqgUumgMwxvA9C3aGuA5l
         8NnopDGR4QDUwO3U0yFbngOeN8uzGVd8EzwRtQQfyMsrLZ1cYQW33XA9LEDivqmn3IA8
         yTDr1lFmBzFivdcJgdxN2kzoyEFsrxY2vAz35bBz4p6V54sblJkeP8B6GTVLSTxpfSHM
         CtT+m+WmNXM/h5hPOQVxokp98PeQKCJqeKiVmwgykQNViOv9OvK9uiZB1gIVsTSvUc/m
         BNisIS00U6TQjwLpZIekxvxUZ1DX4KWCEFKRrWLx5A3spCx71BW999C9XTWyMY1uFUnz
         MW9A==
X-Gm-Message-State: AFuF++mr3o+MvXJ78iE/O6R+/IX1W0v8+uHeh4AwNTnvGP3Pz6NDmJRV
	UbQyAeDoMCVO3jbsgr5g4vqLdDbsrd9ivXuwp1A3q6nyDCYhsqXbVApNUUZLXsju
X-Gm-Gg: AR+sD111UXcny1YHBaal3Y/gK02shCsS8MLxe75GcWuwEVoKlVK4TIwXiY6VgCpzCQo
	/apXxo1WqTbpwyRv3wJZiUKb6fimv7b0Z7lAKXUHb7mvcILAUzddU2Y9GJSUWtgl9Bnq0dCCRA7
	ZMYw3ZATG/zWBqSwIpbOWNdCnBA+ffPVMHuVvPEG/elvYltl0LDEJpf2HBLIL+xwobkZjUO3j7r
	Z2zyQe/JfUkwMv/3LJjQYqIUOWD6dssbde+yLKJpm5pONysZvNi0FubCP0lxt5wKnui6Zt0U+NQ
	jX0JZgevtIuDZcdPf3+gaQucSjkv5yDq6lGJIpgkzPR+KqZpshCEc1JJ98S4FflvuNpW0vFOH2h
	zkFbKY4SI0jSVcUnwH/cpDNsF/LkW5krpjs7ivddy5js8vGNCMzR86yCV9ucR+CeX0uKukDpX1H
	G/blYvjQf/k2mHxFWdjdVX6PhdhCKH8ulSTk9dB0cSdPFCKbw8k6+Vv0ULfdCUNLHZ
X-Received: by 2002:a17:90b:3fc4:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-3958110c755mr10914058a91.12.1787155541199;
        Wed, 19 Aug 2026 09:05:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb17eb5sm3740911a91.3.2026.08.19.09.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:05:40 -0700 (PDT)
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
	guoren@kernel.org,
	dtatulea@nvidia.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	linux-csky@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame handling
Date: Wed, 19 Aug 2026 09:05:35 -0700
Message-ID: <20260819160535.1472459-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819160535.1472459-1-sdf@fomichev.me>
References: <20260819160535.1472459-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac drops AF_XDP zero-copy frames that exceed taprio's queueMaxSDU
after xsk_tx_peek_desc() has reserved their completion entries.

Completing a rejected descriptor is unsafe because AF_XDP completions are
ordered: xsk_tx_completed(pool, 1) would complete the oldest outstanding
descriptor, which may still be owned by hardware. Instead, leave the
completion pending so the ring eventually wedges and increment the drop
counter to expose the application error without risking hardware
misbehavior.

Document this intentional ring imbalance at the check.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 62de03e65a90..6a532747c039 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2713,6 +2713,10 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (priv->est && priv->est->enable &&
 		    priv->est->max_sdu[queue] &&
 		    xdp_desc.len > priv->est->max_sdu[queue]) {
+			/* Completions are ordered, so this descriptor cannot
+			 * be completed safely. Wedge the ring to expose the
+			 * application error instead.
+			 */
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			continue;
 		}
-- 
2.53.0-Meta

