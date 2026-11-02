Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646881;
	b=27r+5jBGJryQdcL62tK7Uio3zwcgz+ajf1hqzzdjW/hq5iBLQqtbxYoCl9Dk8pVfMk47
	 8lWYAaszdpTNJTU9udZYMpkmFt7iS2kc+3ZkuyM+IPn9cb5TeKx5STEBdwzXY/IuJEnhi
	 mF7FVzlEfBq0ZCUo40S2gSLyVNWe/qYA60TJ1h/sev7ZQt25mvZNsScwqu6vRuutxcfxw
	 C2ANFADZWlbTocK6ArrE45qwjRjeKmAVhzDGt16UTXdrtshZZSmzl3Ooy5JbqkxnUSGr6
	 XTWEiEoHcePOmSXl3f8hrfl/aHEgoHJMO2bc+0dUJFrlZYv2tWDxdm0GLQ1GNoIvHHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j2ho1C5cLiBr/3aZdyT0DQh3Y6a9MYv3XZDcIqBQFTI=;
	b=1GViDPxHrZdjO3EkUOyp6atKiJfw1Zd853SByQWxRVGMJTh1q0B+DQDQQBOEss7a2qRX
	 XoWjsPLOaaPdT9rJhMbxWEbzTfhS1jw6ZZDU6NWk6ukN856vRXjL53Jr4hMy9tdskjQRg
	 B4vb4CJFKoycphcdzFffVjQMOCbffUr6xHO0R4mXKWzFEkGoRd4nk0Gw6fg9eb/JHDIZA
	 eX1tVrQfYZ1gTzfOTLLuRwzwXv7WviKlwsHsiEHuSPfBKZ3rUVd2tqsfKBHZr8mNVDw+M
	 znG3lRoGTb95h5HWvAgrmcjHB/kp4P0OCDG83pIV2YPnsBcIwocgi9hNaDdnqocJdNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1pyNmTK;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52039606A335
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52039606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1pyNmTK
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-14345ae29c5so1391985c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646880; x=1794251680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2ho1C5cLiBr/3aZdyT0DQh3Y6a9MYv3XZDcIqBQFTI=;
        b=h1pyNmTKcYcQnUiwUTUVjsqTy0kaz03M4BfbS/GlAuNuz+KfHvuLTfOEYvXGI94d8f
         mgxcWfCy4TxFZT/E6tvueuMo1h0KNnkcD0qVDqdv8OtZBnhPoVxWI63l2B0uQSmpe+O1
         gMsd1rTaRUkDE93+77cEJSqmfKefeSX1f9DTlEPuq0PHainXMPJHlJ86zYUq+AKO44MA
         FDFugdFz+CKDPm3z6Ze+stKoZjGNnFlMMGX6mXCskfH6CvSS5RQdUIXRK+utpSa/B2dw
         qDCxwytTP3hJcWgQvdfc9UhEYO4rEHkSUXQ0djJNa/9puuJC81CBPEPvGwnWuKJSE46K
         Bmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646880; x=1794251680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2ho1C5cLiBr/3aZdyT0DQh3Y6a9MYv3XZDcIqBQFTI=;
        b=wzOzsuqQKNIj+Gj3djAdiJgfEemhN+RzCKacL+CxYysgXMcg3zR32wESI9gW9DpekV
         Ml4a8VZeD/PSCO19chzqXtwqQoCkQPLXa0JMDirnDE4uBv1PHfcBbsotKm6mREfBOrky
         2r8vO3UUaEXhiQZ/0asmeGfaRoKwcw60h7kmfYk0t7WpslxW+UocTl+kHHC9CItnSKCR
         4D3SWFkya6RO22lzCiyvgCV9o9d/xosftFYB8SIbltQYeCM/9rdYpH5w9VIOq7BjRfsG
         p1avsJycv/3T3sJSD6PbE7VNXMHM/WnDclKodS4dMjdeU0YHYosb4X5HlPcbVb1WplY7
         KmCg==
X-Gm-Message-State: AFq9FYIPdEDDQyEINntaYmTv9dGp+6hEKwNp7frfO0siMpNEfKk3tP37
	LtPR8qjzvDhNZyGJlLQ5yeBlRtHUaMnjE4PRE/RBMica5o2LIetaB9HfO6eEwVPR
X-Gm-Gg: AYBFou36WP2KiWPbrXpPXZdRHpDeBKrfpEVE2FcSTTyVCyuH2bfxTGAsQJ2u2DgFHCI
	IsJSBY1vwb1rItrl4bgQvbI+06LY2mN/VhtYCW/RhJnp0sHt3HK6vYVz6ixnmUT2y4tBt8CM3dz
	8HNcrgW1SXCOQnFCfwbf4sUPwVz1K280Nzt48QzvKodOnlqAuuuFdCDpsSTNgtfeSyyzjkjsOBy
	mTw50DDVKFdJ19vCvE/aUlaO3BKiQaC96M/+uCXBrLlgT+dbmvpGj+kOXkKBQKrqJ6GwiPsEWQr
	qpsVd+8kbHqLOSLb50Mrlmj7nS7vLIjI95CWleUR08BkWF5S2WBU/R1GxeIdYaeasa1ltg0W8pf
	1frnG8n7BKLZmYo0PMGus5a2GfVPFcTrkeIxCyyFLsyoY2z4wiv7F/fTH2vNOIrOXLjOkHO85TT
	242AvoLOCXo3nkSECVLMDhLcu0Z9s43QJIHaYXPpTZ4wBN7qc/RtTGnVNFoQOIzPVBjk/PWCwlE
	YEcdo7+JfvmIZwC3KmgkQi3CVkX5hTp95NL5xOTDm7U8ADtEM6l+EepZGyamRCOE3SDGnFyI+zU
	gOCfjsy59qJxmCvZ3DL1Ens=
X-Received: by 2002:a05:701b:4213:20b0:16c:4eef:a526 with SMTP id a92af1059eb24-1ac5a0b430bmr17520345c88.15.1793646880369;
        Mon, 02 Nov 2026 11:14:40 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:69::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm62825489c88.7.2026.11.02.11.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:14:40 -0800 (PST)
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
	daniel@iogearbox.net,
	razor@blackwall.org,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/7] bnxt_en: let the stack segment GSO skbs with too many frags
Date: Mon,  2 Nov 2026 11:14:32 -0800
Message-ID: <20261102191438.1059771-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102191438.1059771-1-sdf@fomichev.me>
References: <20261102191438.1059771-1-sdf@fomichev.me>
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

