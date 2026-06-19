Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC53839B3
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874801; cv=none; b=OIQW92iayFyditvJVX4ShrLO9yovMXwOu8zkYAxflLRNo/242TKGmG3nLiKObcWcxlaEugZwA561dxqgqvz8DaRpGw+1v0DoObmrawEHhlrI1dNBJi6LAXwvbRJSl50Ndyd/YQOmH6HjOUrxYL15RSzlIJJEMNE2hPBhAn0gOrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874801; c=relaxed/simple;
	bh=LWlEbFNStvhviH/m2eCSZQ6BtbXcMG4AyptYoDYhRZw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i+DW4jGjmZVOBrzm20fNyUK0GGAiZJuSitSEOrAqjgxyD/cOVGzn0s1vwWw+LaIkzyuwuHZZEEh8bzJwZdU+a5MyLzDK1XJoO9lJku7sV8dCuXhnCvkArqnEhLxyOq3o88LBt3hdhEeysENE9shrPtZEHn49jPKwWxJLeZ0w6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXvAoGAc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXvAoGAc"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845438a46d4so1008125b3a.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781874799; x=1782479599; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yHv7U02AjGCdC10QhmFKNYOGrXRPq55x+46nkeHZEeg=;
        b=UXvAoGAciU/5+YnyECx3bGwNtNNncBoRDiIjEFnYL87QK+3Gz7MVwbcH0nFepvBpfn
         YX7cGfAADDX4QEnQ4ZGh7lSzuknyhm4r8+YN6ROnNwd9Cqq7DWfqnPimneBsJzSzK9IK
         1BQNl91J66Rd4ydcLdr51v8qXSIaivpyZC6U52sA6Bl4SzEPWtPBQcI/+mSvzAvwdSqL
         Q10PwxGkb61CoA+isjPGzSCSxMnuQCuBqrPoIl+ifjb0TOzVM8o4+U7fCR2A6F3YJlOE
         /iRuohmH6vEHgQK2AdjdKCf+5060eQXm5rsFSw8daKQxTsoJ46rUqQldPkkNSV/mqWXv
         X3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874799; x=1782479599;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHv7U02AjGCdC10QhmFKNYOGrXRPq55x+46nkeHZEeg=;
        b=kJ11S3p/NWHR4c2eJOm/3nEKWV+NF7vVE4p4mGnUCQdc2rIkH7JwKmMGa0Fy4sbHyv
         pLaCwtgvxeRFrr6F+HI6odLn7hIp9LUuZIzRpmHwnhalkejcpPw7dzOEB2U+IX9aW+ON
         /aSLtpXwqKAmG3waNtY8LDyDiaO8wKnjhlj3CcAsqM3YP/ajnmNEJ/IS5nykL07UUPAR
         S3CKPujkUnvOWDbY25llBOJJ6a6UlqS+3xydObA9SWPyjTer3fTbEKCTrGS6x9Zpi+hE
         +cjDFi/ge1Uvn4mFxlRkCK/76XsPlsidVGts7W0I2KsZGyDfTA5bGD831S8mj83tfhTd
         jQtw==
X-Gm-Message-State: AOJu0Yx2YFvt2CVdZe6OvqqPGAP9u8kIJXbs9IqBKVwAz1YDIav1vfXg
	/No67pa4L9Ujpxxwxp8ZcRWJR29FWwUXm32SGATP+cOA01ybQLW99+V7rwUyzH5Iwls=
X-Gm-Gg: AfdE7cnaa7IJNWBYw0DAz+J38Q/lOHD/HR/TrCMd2InfzuTFpMrysEafZDnWw5IdeDq
	WwoJe5uZq81pQweC10+/MYmhWfmmQYlzmIXCNpkxWawWD5JEa+m6mkQHdH4s8EBgYCEfWhS7Ru0
	h3hfRzJQe4Svvm1K2qIJHRfFCe66snyKtoK4WHYlz4KT9sR2I5zO973IuBiwmyh0qu+IsveTAKz
	UzbKcZ5xEsafoqeYKAM4yrdnElyBLlTrFpbFkrG+WLtDgF77rXEnJt/dW5Zo3Ci7iTQXaHptaPz
	1+OflVoCEamRXeo/68/aof6Wb5+TOiVSRXBM3Xo94yyQ0wX9Oej1dR4AgD3k0c1vPvBbOTC/MeX
	71aydTyBOXWUvPCJxt4RTfKhDLMn/mtp1wBnz1LfpdUmcko6RBE2JoXzr4DCEhMIhG4lB1Zgxm/
	9YMx1PkQ==
X-Received: by 2002:a05:6a00:124f:b0:83f:2568:d45f with SMTP id d2e1a72fcca58-84550870aacmr4566062b3a.23.1781874799141;
        Fri, 19 Jun 2026 06:13:19 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455364b25asm2490504b3a.7.2026.06.19.06.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:13:18 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 net] net: airoha: Fix TX scheduler queue mask loop upper bound
Date: Fri, 19 Jun 2026 21:12:06 +0800
Message-ID: <178187479434.2400840.1312143943526335838@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

In airoha_qdma_set_chan_tx_sched(), the loop clearing queue mask was
using AIROHA_NUM_TX_RING (32) instead of AIROHA_NUM_QOS_QUEUES (8).

Each channel has 8 queues, and TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i)
computes BIT(i + (channel * 8)). With i ranging 0..31, this causes:
- channel 0: clears bit 0..31 (all 4 channels) instead of 0..7
- channel 1: clears bit 8..31 (channels 1-3) instead of 8..15
- channel 2: clears bit 16..31 (channels 2-3) instead of 16..23
- channel 3: clears bit 24..31 (channel 3 only) - correct by accident

While BIT(32+) on arm64 produces 64-bit values truncated to 0 in u32
mask parameter, the loop still incorrectly clears queues within the
same channel beyond queue 7.

Even though this is functionally harmless (the register resets to 0
and is only ever cleared, never set — so clearing extra bits is a
no-op), the loop bound is semantically wrong and should be fixed for
correctness and clarity.

Fix by using AIROHA_NUM_QOS_QUEUES (8) as the loop upper bound.

Fixes: ef1ca9271313 ("net: airoha: Add sched HTB offload support")
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Wayen Yan <win847@gmail.com>
---
Changes in v3:
- Rebase on top of current net tree (Lorenzo pointed out v2 was
  not based on latest net HEAD).
- No code changes from v2.

 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64dde6464f..47fb32517a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2395,7 +2395,7 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	int i;
 
-	for (i = 0; i < AIROHA_NUM_TX_RING; i++)
+	for (i = 0; i < AIROHA_NUM_QOS_QUEUES; i++)
 		airoha_qdma_clear(dev->qdma, REG_QUEUE_CLOSE_CFG(channel),
 				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));
 
-- 
2.51.0


