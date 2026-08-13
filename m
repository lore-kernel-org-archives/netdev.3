Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE1426D03
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648087; cv=none; b=mex3qIGEojxzMchkPtMLCdF3lzywXXpzzfcgc66DfevNnGbLBYN1FhF/u4vLVEDPaOC7i75IbHo++C/IYi4dgZjUXw/L+rgw0DsGfQAFLkWugL7ysJf/P/x92F/OeCxAQHO5z0tUp1/2lAND48GNfASS8FMACcIicJEG+ATAcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648087; c=relaxed/simple;
	bh=Tud4eUO2xHdHMLanMzOvMuFiHkLGOKwIvvgYvzDmhMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZupBZDmdZpQZlj4dEweSvzeeYrwjbn2dI+JyNpBPx/h4Kv1crAuu2ivph0qJ4vxvFADx4HajhckBFluwRQfh7+T6wXAhX8XsGAFfZYGAsRcIYD6l9++cQOOHsEXDH2zxCPaghasu+YCkNLbygexVM1Fqty9fokyKmOU+GWoKm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0mraj8O; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0mraj8O"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3810f0aba07so81048a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786648085; x=1787252885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjeV9JcXmMB5XUYPG/BDWWBwnse1nt9xQQ5l1gfrbe8=;
        b=i0mraj8OoIpXvRPCdaHjRWZOBk8XJCEgEXrrV9Kp66o+mDLVdTDX3Dfx6GqufnBjus
         J50flLwhn4toaNfny4l/1F+Egf1dieJUm4wq9HbAlyBWZqxC0aiK89nyzsKyIjZG4xiU
         q0ac8I+77Z9ocgdTz2A9fh5QpoDpATSm3tppPmWenY7SQ/Dt0STR2gmlWxRyBRqbGgaZ
         FSUziE5NaC4v94hWgr8/FY2NHztvqkr7fuXY6nun4Iv+hTAFQg2jo9NnxuuiFOblmXDK
         xNhdrdIBVK41eobOY9FwEL55WDYivVAQEzkHaHpv+xGylYwQTY9YoQ2coMI67pbChBca
         hpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648085; x=1787252885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zjeV9JcXmMB5XUYPG/BDWWBwnse1nt9xQQ5l1gfrbe8=;
        b=HCduMjMK013Wupi1C6klXgEpBM1JdX+iG8P2ZCVQJKhrS0wHARVHUEkNlPhp/oyebu
         YtEK5bdXHL5law2bB5MDArmlvgi5toEiosmOF5ZkG4qebobiYo+GmO49o+pxmEjt60D6
         w9Y3dEdSlDxjXxCljC6tk6I2UPRjyrr9u6MbIw5qfkBr8e5/GZrDI8aBvpT50PBPNk4j
         aC7segx1UsPshUrKhGE70sMIb/icnIxinBWAHt4jWbE3mgIn+6iTj2gEM1/DzqxyBLBp
         MJTrXva4wMjqW7cQVnK8PEYkwMBkYo0yg8Az3rwX/SwZzXZZ5L2ykVcoXszC1W4uEJW8
         bZng==
X-Gm-Message-State: AOJu0YwSzDiMzarzs95fulw/65MTsK9V2MmxSi3kj45z/4cI/XE82U2/
	Ju8IMHaMSWn2RCZCIaHcCDdGbagSv/2EmDmZ8CS1CjSOj7qwX8LaeMbCRND9V7V6
X-Gm-Gg: AR+sD105KQEz+pBeVsUjQ+lJg+4/JMoB4SCZW36GlB5Yh0muzO/vJvWbO0u4YEaolYK
	MKJl8EFpjPy/rRpmW7qb8DAikssZoYgaJItAdg5sDq2gZAWjt9VJUrFCO5D8KhNTgmfaDjXvSB8
	A75Gl0gl0nJi48M5Rficr3UyqbIjfGZLmDUGFVBJ57rsCWUgASPwOKUeIjzqwyshVh651z4SY0P
	32LSKHgwH7fjH3t2vNCSLBfj5lYgcnQNSQSu4+8wBy408wneEbRUqrKSUFJGrFyERVbH2BweZRc
	B5qqOiBhP96DUEgn0TWHRVHfu8C3V2f7ANs7qzq77eEJf4G+dJxFxtYxgdJHXQ1ksystWvyhlGb
	HOpjBJQuAG9Bc//HfPhThbeNVVca0X4G47I2czU+M5UKV9unfJXqE1sAY74CJjtF/EYy506FbVj
	I/rcWmJJ7e5IUpTUk0Um2GaMlBoJwHMv460M/O0GMNG5CbGG3lWA4KCA==
X-Received: by 2002:a17:90b:2f0d:b0:38e:7268:220d with SMTP id 98e67ed59e1d1-3933ed5e238mr29902a91.20.1786648085014;
        Thu, 13 Aug 2026 12:08:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:52::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339fe280fsm485100a91.12.2026.08.13.12.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:08:04 -0700 (PDT)
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
Subject: [PATCH net v2 3/3] net: stmmac: skip queueMaxSDU check for AF_XDP
Date: Thu, 13 Aug 2026 12:08:00 -0700
Message-ID: <20260813190800.222527-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190800.222527-1-sdf@fomichev.me>
References: <20260813190800.222527-1-sdf@fomichev.me>
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

The assumptions is that AF_XDP zero-copy traffic bypasses the qdisc, so
taprio's queueMaxSDU check does not apply to this path.

Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 62de03e65a90..4a82f4351303 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2710,13 +2710,6 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
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

