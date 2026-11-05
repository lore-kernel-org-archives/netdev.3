Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917262;
	b=bMwWpahES6Opxq1j/+EnI73gb2dN5N0kOyarltr6f3fdt/DFFjE2SMvH0A9/QJFjp5bF
	 5IyMBzb0mFXlPiLrhbngno6H+rxQAw6qER3aGT22CclN/OTk0cZvj/WppI9uDFsOJgF8K
	 CYGd+ir2YmNa/6Ix3q9gVgn/IcAzAGJwzJETVwkwgnxIHO4YqxTHqZ1o2HSRyb+s3dNFn
	 62OQbUrSGvkqomQICvM2S3XDGIUuRmdnUHWQym7vsQgQGEi1taKnHzVx0Cf71qhjt0dWb
	 N78ofUlPZVpwBX88MOFMLObb/poukenmTLwQcYaSr1F4aAbjo+ns0QuG8ppmGZA/RWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BAX35U8nNHwzvrvZe/2+mPjA18tDD45pOn0BmV7GNC0=;
	b=y2e/mwzruGCB1czDP3btBSfqwtf9FAMtyKbY+4TdNek4b/TIj4xrggUpEac99chaCrH5
	 ucZfm39sXt9MFEdVuCrI8ujoBxlBo7K99lCTRg84Eki/TqF0HLrQvJ/tdnN+xcaJDM3PJ
	 UkIhqca/IGfYSZsyB5N85tlscS7YxnaKkG3Q8DC/vlqGzSUNnZrCOZkv1W0O2Mnxdsxjq
	 ZBIxa43LX0fWO0ogjgQaczGKUx3r9MQaPBsCHFr7T4OFbhIqcK9b+2y943Y84PzLD3CsF
	 t8hAKit1ZM28UhEuZ92XFY1UQLr40ExOj9nRmC2E3fJ8n/9I3W6DhnJxe5w8lpNxSig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e+KzCRPw;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D7606D806
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 573D7606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e+KzCRPw
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-1397ad3d891so39008c88.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 14:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917261; x=1794522061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BAX35U8nNHwzvrvZe/2+mPjA18tDD45pOn0BmV7GNC0=;
        b=e+KzCRPwGRMk1BKNG+tsQfz+EP0W1rS4Z26bw7m+52ZDtQj2tRPd8kF2bk/cIbpAng
         oGqnOFDZLoU/JqjgFICwTFI1ou/Nv3AnHlnTGRyo8K7mbaGg9wvwossPFQhXfa6VqkZG
         8UlgrnKuX+60euKUPpM1cQwbJLyxunEH1kaU6zYvGzoKEGDA6PTH/YT2PGCENTQkLofL
         OBryTBIZs6DNLJSHweKDiqBC+plTqFqp2ifPBhB6qvV7AQdDT9oB2lBU9Z2XDQouFnAM
         3YZYRzJTaJWSxCbyV0BBHUU02ueo+SWcZesSKmd1c94t74F6KEoYeVRccSoDXKRF3F45
         lnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917261; x=1794522061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BAX35U8nNHwzvrvZe/2+mPjA18tDD45pOn0BmV7GNC0=;
        b=n4wwVdbKRCf/w6bdfoFD5EMh4KYnkqPtaXdkElEknTcD3/qUWvq26Z/n8k6q+FsOON
         lQOcqo5EZCrl0qMyR3jcQFz6pZwGHFqFqOADoHFQxyvh8z66s3GxKLmFeGXTd6xbi7Xc
         kRpVkluiZR8obi8o0SIC/JRkvZY+ygjDR4Rc1TQhT/hwFMLHj6GdhMTIih3AwTKWTlD6
         gpaDyNjWLStGCiieO5Rth0d64qEGF6ExS0CDz4fkERS/nFelziJXVdstEurCbYl/7u5q
         STMmatEoSY0YB48+/hTAuznIvOjGIXfU0kQBI7r3R7IqdEoBKKg/fifpmzfYnuXFRTT1
         04tQ==
X-Gm-Message-State: APuU4Z8BO+53NdjsILzQzbPC7E7OUoeuohASEVIly4KsgcocQG8UIxop
	xcP+MleHZjPh3gbpgEtszPSckwkgcIYEiEjHLCSzwYvXbojBlrCbzexDDH14b2JNsHw=
X-Gm-Gg: AYBFou2fEYmO0eCnvHSEmFJ2OWeK0j2SdckRe7vkMfV28ydXyB93dxbhSc3wfKRUMdY
	7Pfux+1PBBeo0efH1amQ1dBytlyYHIf6nRuxJVyPVIVTLzC9+UdcbHaV40PyXWKVyyIU9vDj46j
	18buijnhRDLw6yCiA35rVUhW4iB4XMjD7azKb5dTATZnHkwYIxynNbXNf9zvdU1oQi18qq2mnlK
	DW1hVhJUod9T9xpndGf1tZycOHVRXH0lTCcQ+a3P2DJh4DTwsXWUPi7ik9FJmY1nVJfEW1aHgQF
	7DEx0+E1ZmPo1qW/LiSPAQ8E3lMDPUUI3LTfm7WnZagUvHtxl6CnZcMtf0V4x6JiYqtsIX63T58
	8V7/toD1JRdz5wRkueY+/NzoI7WOfQ4EuJpYKfwOpwwO8kkZjXOzUI8Wd06sQZ4qmLEPnPnEZgl
	hGgDJi55oy0TOzQQF6F6jJ21Vsq07pOE8Dh3OcQhwi1v8OoVu2CLJGeCYh0IusAGqU6Y3vlmr15
	CkOw0cNMwS98ZCozngR1P8bOmZjX5S2UTyseCZLFlXO5lTFTVYXfMLCsYce3yWCgnA6J0vXBNd3
	UG4dfMzr207tCGb5VXAIPqXPPdpmbUL9MdxbTbZ+CVYv
X-Received: by 2002:a05:701b:4346:b0:18d:9eec:e0be with SMTP id a92af1059eb24-1b25d286bafmr512275c88.2.1793917261068;
        Thu, 05 Nov 2026 14:21:01 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:68::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b86fbesm20396895c88.1.2026.11.05.14.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:21:00 -0800 (PST)
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
Subject: [PATCH net-next v3 1/9] bnxt_en: let the stack segment GSO skbs with too many frags
Date: Thu,  5 Nov 2026 14:20:50 -0800
Message-ID: <20261105222058.944293-2-sdf@fomichev.me>
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

With MAX_SKB_FRAGS > TX_MAX_FRAGS, the xmit path linearizes skbs with
more frags than a packet can have BDs. For GSO skbs, linearizing needs a
large allocation, can produce a head which doesn't fit in a BD with BIG
TCP, and always fails for unreadable skbs. Clear the GSO features of
such skbs in ndo_features_check instead, so that the stack segments
them. Non-GSO skbs are still linearized.

Suggested-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/all/CANn89i+ps_CozfOyRnKav0_LUmSekJ9ExB5JkDbTAVf_ss_98g@mail.gmail.com/
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 757c7266ce15..e7a4190a8c78 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14300,6 +14300,11 @@ static netdev_features_t bnxt_features_check(struct sk_buff *skb,
 				skb_shinfo(skb)->gso_size))
 		features &= ~NETIF_F_GSO_MASK;
 
+#if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
+	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS)
+		features &= ~NETIF_F_GSO_MASK;
+#endif
+
 	switch (vlan_get_protocol(skb)) {
 	case htons(ETH_P_IP):
 		if (!skb->encapsulation)
-- 
2.53.0-Meta

