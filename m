Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749917;
	b=MznhPjmEufzp/9PpOwwQsyv+21Ys0huGmZSzqVjSS4dqe0cUT4MQ7bYkKESYSnQaTVv2
	 ycbfRxnw8iPjgnsae38fENj0GJTy3lPWfnCXYIuS9VkT2yYPKB2P+rm/NGI3CHkMNtNWf
	 pzBMsqgmx9y2E8uQw8avYWztpoGyfnIYNs0DlLTlWnYwuYOE9REDZD69CmU85xRw/qRdg
	 sqbdvguMrPtiQyRBQRtWycM+xCW1xXYr1Emjlwo7HaJ9jA3J+HPYOWTuNqyoWCdxhymNQ
	 PJFtxUc+zmGe0T0jq4nLRVcjM5NgnmQiD04DMsLM8ideRa1OPVb/UDcoMkJkhY0iNjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j2ho1C5cLiBr/3aZdyT0DQh3Y6a9MYv3XZDcIqBQFTI=;
	b=Y1NlOy9D36nnFIicf+G4Jba+Y415YTajGncZI3rtgjAB0Y2bYsd5k1ct9rkTYKTRIf2y
	 91h2/MvbRHsV8jWIxIh39ScScyt/0yqkB+cM04C4cdPJu5qfIYTrtWTA72XW3F3Ao+f8g
	 tjpcS1b7UXleDiH6foQQ4oEuyV3nDgsl2dt/EJpyrlegJIhAHi7gXfuVNNNErEXvlZAwf
	 Hngv5OMlWQKteuajzHk44iEctxMaPBaVbIYHUeU5Rl//kF+zmCLmsVSRQTwoKSmsnISm2
	 w5GNyvypuAJGPBrTBVatSp+94vvapTznq3TNvmqAt9q35DuTnfV8ZPDaUwwWtazBTbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ymIuamZd;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82626606A337
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82626606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ymIuamZd
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so101786eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749916; x=1794354716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2ho1C5cLiBr/3aZdyT0DQh3Y6a9MYv3XZDcIqBQFTI=;
        b=ymIuamZduOqjQP+JlREaO486TG55zElM5UJP0I+Z7Srd38FOkvIVfnj0cQ19vFaX8T
         vbW1UjHBuM3xOXLeE0vqO7dMUwNoQ8T1pdUy7Su39nL+CjrnAoND3xnXyWjPBrEeQ6ay
         XiGoBmRKi65wZvpxF4WB6wv2tJd6RuAWTpXy+/uWGZzlqO6u4XSV96XvYBl6EdXOfIe3
         yB9H0TjCH0Johjhyr+V+LleBKot5OGITADugJg/+iJZAhZbI1DjgR9th6PXnL7tSCyfL
         ZFJzvNcbRauR4GYj3uHb6VOPD6t9MB2XJHyiK/vAtqMQX+NRxJT62oGDmHNQCG8zJGbt
         W/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749916; x=1794354716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2ho1C5cLiBr/3aZdyT0DQh3Y6a9MYv3XZDcIqBQFTI=;
        b=YqBxlrpdcmHK+nVZqEuMd7kMPY2Q83k0nQ94tilivA6+K+InW1G23IgAi0BWhwRTTX
         v7Uir2CMFnW6Wc/VT3znFFks3N3qkGs1MLBpu/enfGM+7M81tzqorddW1T2JCBTxwvTp
         H7BNOu2EJ7W7k4hWfQEZCxz3BT3EL5iPxzG+JCP7APeIwoi67vHQpkPoqv5b9dwJloXY
         LHYfO1Yv169OSs+vzNrtnH80ayk0PgwsqxCAFIioiHWAGWW8bszg5EhdFsLep5v9Fdoz
         S+YBQWJWBbNW35pmn9cAqYFfsWu+mtdvPH/bA3iOUXg7mgQs0H0QDOYbo6WqHGVBYysE
         1+FQ==
X-Gm-Message-State: APuU4Z/W2eRYRPhr9HJQKqHfY66a6vppUFaH9RjEUCL0yqQo0rUerGYR
	2TWWNYBbYTK49L0iOZ87dwnPxnAMMKr66UuCm6rbxcMlvQWoKVlOwochoYHHBK4m
X-Gm-Gg: AYBFou1Egp09sTkT+mgrM3lWdZSaWfYrqZN9ED5HIMO29FAfKjLvViX9PiBDs9Vt+vg
	W9+x2BuvFrsIDsJL80Kcj3a2NMjLfIMRqi9OrMZAPGaaslWnU21hPD4SvpHWGmmo7Ln86p+UKx7
	SdjZ+g6eoBtYfOp5u0Bu8Iyt3ks6hx5lz1cBO3aIeiywL4RzhsKBBlEqxi6S9HykH5wgwZ9ggOF
	LUyuVt4cMuTcDFT3Zb0CsWj28hUGekJ6qxg28R9o7/m5v/YeYCBDtVE+Yx0fDNsSKlo33YtOces
	7nqSMVNABq89brQ2qPS8BpcPcb5gY8PFXhSOBB45QSYFAX9wtahkiYETJChx2CT1HXEen4uhMcn
	ubUUp1pdu2iEhPke7jhAWqzwUkoHNgRkOlkY/YE2YcU9q4Q2oUp2NkuzzZlDN3A755ha5GtvGU3
	vJAuWFFpJkpcJN+Ooe4fi+vkK5cRDYVSOftfxjTziTeRvR3FD1ATGNuCmIaDKfzILfOWaycFbhh
	C1qm1ofDamaAMM/jZkrBPWLL8zgsHdOKtx/6bRU8B3+LUxkPrIvlnXCGv++qN12boblaxzpAOlx
	lnBTyI5JmkMFeHiaCMrNFeM=
X-Received: by 2002:a05:7022:e807:b0:1b2:4188:840b with SMTP id a92af1059eb24-1b2418884a4mr4392819c88.25.1793749915551;
        Tue, 03 Nov 2026 15:51:55 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:68::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4f83fsm3165448c88.17.2026.11.03.15.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:51:55 -0800 (PST)
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
	sdf@fomichev.me,
	almasrymina@google.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	razor@blackwall.org,
	daniel@iogearbox.net,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 1/7] bnxt_en: let the stack segment GSO skbs with too many frags
Date: Tue,  3 Nov 2026 15:51:46 -0800
Message-ID: <20261103235152.1904727-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103235152.1904727-1-sdf@fomichev.me>
References: <20261103235152.1904727-1-sdf@fomichev.me>
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

