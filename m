Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917268;
	b=RfxH9CiBLoZDMndJeagqbJvIPUMRu4FnZ+kMxXwTowuK9jFnrrp7qJeS7GWLBSSnD0Q0
	 UCtoLvSdGVsqmKUThJ36Qf7VriDZW9w5XKJSoQjPJ8+7FerZC+tUFFCG5V8LUYEAQq/+5
	 0OYWwG0ddmoFj+WWme05wzYpp1g8T7iIISTNfF/lTF4BsRpQb9Xa3U6mofXEW4sZUZErC
	 gqFTHULpf+28+x4D1pXLfsbrX7t7rr8mkyM5ZRVcuxbQbKJoKEwfpkl75UJgDpXNFk96l
	 f7cXQ6ufWg7rP9tJp8o5w0xpWK/Yq28Ql9F9cOdo3SSALbfv7hICNi0xDwXSJ/WY1nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Wko9jYbcFlAwe6oX0v98B8vdw+6Ys7oB0hN4NsC1Zvg=;
	b=01DJ+59EDaZfGg2ZMTVbn8yuaOMjHI8YyzQTT1HtF/cGS/Z2tTFOuE70YK3Ek5E++I1F
	 wcHYm82DskL6gmXLYffQaowbuurix84Kk9ht5G34ab8cPcsyOxRnTkylvMbqGmmzREiyo
	 0AjuRWO6dcOit+JHzfsnwjf+YS8z+JXT6DiembbAJ3sFxK4kvK5bqLi6q1PfqFymM6e2e
	 T7LZ71DLwE9Qo/OF0qHdtakg/21jAkhJgEpFlKVn800qY1JsdjLe/cPhAG12cFmn2yXWf
	 MO9/ASZjwAlPa13LaCYdu90FmjCVZ/A73lxrFNvHr96HJ0fxtOenbwoP8XM2fAOktOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tz21y1+Q;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DA606D820
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F7DA606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tz21y1+Q
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9e2dfb29so108eec.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 14:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917267; x=1794522067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wko9jYbcFlAwe6oX0v98B8vdw+6Ys7oB0hN4NsC1Zvg=;
        b=tz21y1+Qew7hl/Wnsu0cT4nQ9LapPqP/EcySc55XzEzSKyvsKJPQqZfz+zYFLEh7Pu
         8g2X3a1E91Jy0F5IKQJ0GKPJdh8Fr66eG4DTrBw6XlKyXkOa/pYZriB8Js1SGkmxLOUy
         IE5lxum48sXc1czWgAt6Q/hnyojkVE9KjN/7aotvbHY04rpX3SRuLsJVi/FcOLYhTuCz
         aQGg121SHDcG9s08QKA2Wq4D568nrjceOo1sPCbasiCsiVNqCIGZDlS62S21v6ypct88
         3guGUj+JrBBCf80e+jdO1jhBvMuBAs3N9PNQUY7GmVHXWnsHC591iuygoJwOC6lFcnyY
         Yc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917267; x=1794522067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wko9jYbcFlAwe6oX0v98B8vdw+6Ys7oB0hN4NsC1Zvg=;
        b=UhsDhC8fXyMXAul/BtgcWKviQI43SWkWbCr3vSN7POmGhgdwgbwmI6OR/Yo7RP5AMa
         8MqJRan6BRCUPvTO/ojiLPrRiy28gFNs1E2oRHl6NxrKl63aicbQMqyqgWeGrWZIm4mh
         /CbUyZtvw42EcmI1G7UoeP0EK+tf5vNaiqg8GJci4enHuzuCLIuwsER17iYq74tkcvnQ
         3STpSVP7IBWtdGuJ+SKkVsEuXgCfYAI8Z/jshKaVeuH8bK3Y9t6GR9tsv02mRiaa9s2l
         mgbTj0mqo/BQOE0XOw0rvoSjum/oZulGdV1a+izZskTpi4GKeuic6z6+RzAAC5BDXiTm
         sPKw==
X-Gm-Message-State: APuU4Z/2YvoYvUuu7/yRB3nqu1htlKzkh3ZFNAX/FcOVOb3RqQ80jnZI
	uBC/XgjMVQji3YZ78ZuM+wGFzSD+3LiiUaURIHpQSPHD8UkUg8NShFZlIUaIHPVtPBQ=
X-Gm-Gg: AYBFou0y4OPKywmJmVBWS+MDFDdb2m+VkLqOkCIZN+TxCk+TpDO3ceE/CAwrpnrDVrc
	28BuYNB4GMnqSsqG2Vb/PxuHTBuu4zmvUI5iWnz/EOb5u8cQXZowsxq+1SPOal2UXLVXrSDwhMV
	xZ4AmDmJf6z1HOUh192ZePcb3Mt8dal8qWu/hsg7kKv5uxbyJfPXvTrcMTPZln+ihF4Cvu84wNX
	5rfjyPBRxJOY0rsCb9MBJPk3m26ZuZu4epY3DuTFg5LKnzjUnHFbhLIMgSWw4SnUKRVIiqoRtze
	WFDtmKNMUf3J6r9katrrmlr8sH909K7MppeiE2l8qDs2vOifUXEUd0ob8X6ZtxMla5y8zYHJn2+
	q7HuTau+P/Zi8J1wh/kkZc6QThWUlnaU70Wi2iwH5Tt2lSvcin2ZFFx7AF7rLD1izzSwBW+Hu4Y
	maMcZDH300/xL6QEfjrY5g5czkuLJWkBTZKu1UZcP6EW5YIfXxqdcm6GDMIeW1lYsY+UJVmMZ9U
	Ac10899Oo9fGv3sABZ+dfyNEtcr4GTqe/G5v02ZDeLBkds7lYrhDetYKv4s5vTKw9OsXriOM6eV
	HmXudcG3S1sCkGCFK1jrrtE=
X-Received: by 2002:a05:7301:460f:b0:36a:15ba:43ea with SMTP id 5a478bee46e88-36f76d177bdmr646010eec.5.1793917266455;
        Thu, 05 Nov 2026 14:21:06 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:44::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922b205sm39909eec.11.2026.11.05.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:21:06 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	sdf@fomichev.me,
	dimitri.daskalakis1@gmail.com,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 5/9] bnxt_en: set the netmem TX frag size limit to 32KB
Date: Thu,  5 Nov 2026 14:20:54 -0800
Message-ID: <20261105222058.944293-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105222058.944293-1-sdf@fomichev.me>
References: <20261105222058.944293-1-sdf@fomichev.me>
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

The TX BD length field is 16 bits wide. Set the netmem TX frag size
limit to the largest power of 2 which fits, which keeps 4K aligned
frags 4K aligned.

With 4K pages this raises the PAGE_SIZE default. With 64K pages it
lowers it, 64KB frags would otherwise wrap the BD length to 0 with BIG
TCP.

Tested on a 50Gb/s NIC: devmem TX from a 2MB hugepage-backed udmabuf
runs at line rate with 2-3 frags per 64KB skb, none above 32KB.

kperf output (sender side, 1 flow):

  client: == Source <sender>
  client:   Tx 46.358 Gbps (174483046400 bytes in 30110590 usec)
  client:   Rx  0.000 Gbps (0 bytes in 30110590 usec)
  client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
  client:           729   153 599     48    0 13893632 3147
  client:   net CPU 71: usr: 0.03% sys: 0.06% idle:67.62% iow: 0.00% irq: 1.12% sirq:31.14%
  client:   app CPU 72: usr: 0.16% sys: 6.01% idle:90.66% iow: 0.00% irq: 0.83% sirq: 2.32%

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e7a4190a8c78..c8a887facc20 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17439,6 +17439,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	dev->netmem_tx = NETMEM_TX_DMA;
+	dev->netmem_tx_max_frag_size = SZ_32K;
 
 	rc = register_netdev(dev);
 	if (rc)
-- 
2.53.0-Meta

