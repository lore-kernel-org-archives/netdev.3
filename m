Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437264;
	b=o6Q1NTHBb/SDx/DabKpte/s9bCV2bE2hxhM0sO3TUITZY+p0xf5OpjWlRaxoQgK9BYgM
	 yCaD+5xKb2XlfAkzr3CCScK9GDN4xuBLQPAD0M+woqf7rb8mhjcbL7gbSEW/l/+L3pFd1
	 bmOmOHa/U2BXQEpo8v3l2EcDns6P6JwNRbuxOUhJTSK7USE/MV/flm7hh4uiI29kntq8J
	 J2YwcI7qeg+sl8PjNkQKXO88uns0H+xKCmadtfQwNgPVyRJNtw1S/crqIFdmBCRqiykSn
	 UF40nA8pZx8sOM/ikcX7ro8eIXkzIqp8t+4gwDCL4Mc73rZYrFFL1IXE/+osKdQz06A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v7W0xNYpiy5LlSzPIX4rQ16P/K0fxOUo2Bge+Pct8Kg=;
	b=lZdIf2zz/wl9PEhBSXUdx0xLs0C9rfNuhSShz6oRYMpTArkDfV3alokjaj8JZ5eEAxIv
	 PELDIV1mk8lXBCt29fRGqipd+9P/3PJ0Ng2hyWT+wIYlKcfJ/NM16aXuFc+X1yH+3lKb/
	 89nVM0okkciXqYHGHSSjTntsyFRpuPuPqrmE+hFw9orYo7sVaEtGs+43yWjVB0Qr7pk50
	 K98C7FJbH/fNN2xOhofTwwAPGAK+6JISQ9oLuQmgDYhpsz0Gts17T0/fnhO4R2649m7tB
	 mLU6mR1CWrVr+RmSkEXXNcoeC4lTKu0kt2SBuNFKUwFp8U2ioDtYc4zrG7dUpno89Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DTooIN3Q;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48736606B74F
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48736606B74F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DTooIN3Q
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36f2f262b19so2553093eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437263; x=1795042063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7W0xNYpiy5LlSzPIX4rQ16P/K0fxOUo2Bge+Pct8Kg=;
        b=DTooIN3QoP8/9pVMHn481N0AQOgxeEutkom8yEbz05kzxThTnvfycNhmfLfhQr+4dC
         eaAxuGYTj19ii0QDr6qYhgUoC1FKGTPnT6NHD5aeIJcvGpW2+UqzXBLAhCGk6TxkXdem
         WKqVGf802TMuZjVAyE+woEqFEUws+x6LIQaZyZxdurSz6eMIV9OMhpoI2gj/EKIVqpAL
         i7FiXALbuSkKCmV/104GLFgKiYV+qyckq1eXXTA40fTxCuSa3p3VGAIqbyxAkNk/wQAq
         xVNKdz2XxvSnZgFI2fjksYnkgdPpFY9eQZUa4LjT998m5MmMyjdtUuOCKRPK9hJPuHZu
         RCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437263; x=1795042063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7W0xNYpiy5LlSzPIX4rQ16P/K0fxOUo2Bge+Pct8Kg=;
        b=AaXJjI+YEzuOBiJF+FJ61k8wbt1UwvhM/2N8mmkDSwMpsXl9vvZ0dENsUwF8217o51
         S2shJgeoIlI2CmlW9zrgE4k9PkWO5mDDLRdgB7jSiAdhU8a5MG0li3SRqZiidxifr5pA
         5U9Nj3e1cI4CbSsOpovcqNdYOgG1KTuvkh4hiRIh1gSzxDgK3nm6fiFBBdrtsFo0hNJz
         HapAj8yoY4UvnHIT0yn3i9Zn8REjbcL5vFVHRnDvxdz3mv4mCqrz0A1agDBhZQRmiecs
         n59z9BD2ikvKVH6GlWmSXis3a6aBIJonjWbn2wHpC2JOWpsQwd2v7ObRTD4bwLXJexCr
         3eLw==
X-Gm-Message-State: APuU4Z/L/Lv7lU67JYpa44ZVyfnvPJ6vu6PhSQqK1UdZOSWzys2xPxI1
	QgzpnNUqMwATegZfdgAQO70QyIXYe2wyq4GFsLXKaMsrtBOHT7fObNXRcVHG1ViIpYQ=
X-Gm-Gg: AYBFou2f1xuU0m+t8dX0x2ucZQtl88BdjdTckqSSFvkiT2N/Rs5y5p5d0hcklW9XmBU
	d/3gqlEeHZCOgFhLmJk5S++E2ryL6Swlwsj87j2Eb9k4XnWO2zguNQ8gMyQf+RZambSQSr7Cfci
	O4+SezrPI9Q+ijaYJ2Q/+fp6NUVl8kPVC24iSNdSKoQFub8DcRgVJ9vY0kCRW4ov5ohYpKtw8jR
	K9FWjChbFXrxTyBj6I6gC+gZ1e2AtSPhzF0sDh1d+CUxw5j24yIuZXXTcK60jkUqotxQZpDDAWp
	lr6BXh33lXWBBuuxp8LwzLLecQCDYnllHm8e+GsbXIZS1pRmxCLATuxHP9IRmRagVJxz0Is6ZTE
	XM5jxtiXxfyBkm1kAIrSwuE/Hic9+vv/6EL1SPu8W2ICygMcK/E7jymtArMJMM36o410WvamE5t
	f9v67pzEJ8eG8VC+It+3mpbQaUNRdmRan2s/uvtr4fkxEYQd9w0a0Hy59aqJ/EVRSbBe2x2HO36
	ENMMbFOEBcU4JHxhVeDQsKjYuSXk4VklAZ4gAs2lGcbAWeQ5AhVivGL4XgeDHhNisSonYBSp/iy
	iviO6gwkSb4RE+clLBkdJMqqV/1uBgOtbAuYV69xwnAg
X-Received: by 2002:a05:7300:aca6:b0:36a:15cb:30bf with SMTP id 5a478bee46e88-3768579fd19mr5751002eec.13.1794437263206;
        Wed, 11 Nov 2026 14:47:43 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:66::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm20685173eec.7.2026.11.11.14.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:47:42 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	leitao@debian.org,
	dtatulea@nvidia.com,
	asml.silence@gmail.com,
	bobbyeshleman@meta.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 1/5] bnxt_en: let the stack segment GSO skbs with too many frags
Date: Wed, 11 Nov 2026 14:47:36 -0800
Message-ID: <20261111224740.2744522-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111224740.2744522-1-sdf@fomichev.me>
References: <20261111224740.2744522-1-sdf@fomichev.me>
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
index 33c4cacc8ffe..f20b61180ab2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14320,6 +14320,11 @@ static netdev_features_t bnxt_features_check(struct sk_buff *skb,
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

