Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655916;
	b=2ZYbIiGWv/IqDyI2nRb8c154/iZAWR7aVYPpSWyVMSL+nX0wK6wYd6o1W+X0QpAd0TrZ
	 HAIpuNg8kLqsZycINp3ILAPfHmN7yR4gpdphGVIfqgQOXCAIHGl0Tex5UfGGT0WdYOSb7
	 N2yqqhte6fS/Be6WyQ71E83A02gFeGVHGQWLCOMq0P4WB6ZoeplqXqgDeejAyw/9w3U56
	 x7DUq9JGEhdV2wD/ARrZiw7J25EFbz14hSd/C2LP9ZtNb0QeMrglnScLUdooh3L8OzoiH
	 A50LaFQRtGIZ4f1ALR3MYz37zNVL6johsyqiLnS3OyHcAAYe//OTqjUytzHbvgeAP1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e9QupjioPz5jmuw4QB1bwofY1LQtoFeM5H2RCzVGzzs=;
	b=qDe7twxyDHCun/FDBGQTKEOQBehbKS07HHfO9uT8L/PevJFPFrmLE7vkDsQ/h7UVZ4rA
	 vzdSluM9+Mk69PLp7XVKoy5YWjPYh8s7ug3eH1nx/UqWJJl4dGFCcUAvs2+aOtOtZlB7R
	 +LTf/4Q84qFxkDgv3mek7nz7TWNQY4VybS5DzGCKKUc5EBG9wwnKe6cOm+Dw60k2bQvnl
	 wFqL+q+WgX/lRPbMDo8V8ZT6KvWLTMk0j7VMjbPqzP2YLftKCXDujHuYOpG+0zT4ab5cT
	 SfgAhcP373TE6RnK/mqy7SP6pjXVIMnOrsGNuMxuagruKgPIvqAOIsobiRA6Ap3JJ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=MOmCpHLf;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A778E606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 07:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A778E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=MOmCpHLf
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3550c917fd3so2146490eec.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792655915; x=1793260715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9QupjioPz5jmuw4QB1bwofY1LQtoFeM5H2RCzVGzzs=;
        b=MOmCpHLfRrRxszlWMesw7LXP73FvKUuNJxjueJUh2GP5Lgp7c5W8XzEplOmlpKpIA/
         /qlAYztRwYP3FRv2mx89p65O2EvkFDvJCJLvjG2G7YbY1hEUnEsV+UDK9ZAL8bPFZsQT
         Eua8a0evDCZik0BxnMzYAWL42v2cbNMKQgSLGsFhgbKvORaq+hhSHPK+HZZ2kOqWSaEr
         Xgn2tQI2xGP7HvdvmmcJNxkyZYuIJZPKB4fw1kplAfWVj6RgWwVdRHkyWCye0vDJJNks
         FrG/CdvprlxFfY56PCXF2KT477CJ4EmMIc/Ky+4OEzA60dDj5Gz5DJi7v7tnPE8Q3hB5
         Ckbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792655915; x=1793260715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e9QupjioPz5jmuw4QB1bwofY1LQtoFeM5H2RCzVGzzs=;
        b=daknM4hSRvWOcpJnxv767/v0Gh+F6XbE68as679dM1t+mmbZZ9+UF5H1AkZX4YZbBW
         wh4AFGAvSkJXWPQWi0NLVUKXylSoZl6ce0qSIsvQKuCpkTRi0ml+iYcIiMV61iiPFOJp
         oAtqcOM5AJgIDgaX8cta9LI3JAdPK5kWekJ6qjbRqdvfL7AFDyCyNLCS3xHNPTuvwQpc
         QFtCoyF9dGUyFJ6P0CjSn5DAXAXCfj0MKtmuiUTExeO2BDmKM3mMAYdfB91MRg9kDYqK
         m9jFGsS265YcEkI5RRGYA7iNP/2yye/1qpS2Ebah6eEHMxZCyPTOC3m4WW0LYBLRI8tZ
         +Wqw==
X-Gm-Message-State: AFq9FYKAaA1RosAkzZemrpJOS8OR+pkeYYRsU3FnsMAhZqju8P4yGHUk
	hBOGnsSF96Fe35GxsLqxPq2DSb+mVvYq4dvFOTfhdhN8F7YrYDBzmJ99bt3lUwIUn+aGZk9R29n
	FJb+tGLka
X-Gm-Gg: AYBFou3PD4kCmsj5PnXUI03H0/PaUuoMRpECtsMIFxEwKZsmkH+CoV53iGcbK4k/JBA
	07w7bnYUDgDB0kquIV9Nbmwmw0ea0TwY+8hxingOEO9eNk4jGrTqkhiU56/vd/sp8yjKwXn7kge
	Px9VSBHgLAcvoYdF3IxzOmuwVEn1BAKdDDA06hMf4G1YDoa7M3/ngFgHG1sB4dLRAlUAjgd8kgx
	Bl2LLH6r/LjVnD00bYj3HfFvTHBqTAbr8/Lkjnp/guG/uH/U4u5r4hgA6ajZ1DNIPjjFApwbI3h
	ywIFdU5jUpeVKz6hH8ju+hGB3JvjsIt3y5X5TW8s1soO8zzKEhhjwyqGupWj+DO2QVbcUX/HZRa
	UPZ2NGQi48WmdU2bNra1KydwJ5N2oVsxbA72Y+DatEmS24OMVpLtMNNEg099B89OxOWsyj86ExS
	dhJITy6Lkbp8rCwXXP0k1I/Wxx1a2ki0rke8wpQNSXMMcmQLQgKIYgl69z3ObMBAWfqBpH8rFah
	9kk593xKW1Z5/n4U+TNacQkwS5Is1ICrXoDXw0xogBIL8RflLPszBrLAztiPQdK9E4tp88=
X-Received: by 2002:a05:693c:42d9:b0:367:e68b:c047 with SMTP id 5a478bee46e88-367e68bc08cmr5101290eec.40.1792655914708;
        Thu, 22 Oct 2026 00:58:34 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367417a2fadsm13580451eec.21.2026.10.22.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:58:34 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] xsk: validate consumer ring producer index
Date: Thu, 22 Oct 2026 15:58:18 +0800
Message-ID: <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792654486.git.zhilinz@nebusec.ai>
References: <cover.1792654486.git.zhilinz@nebusec.ai>
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

__xskq_cons_peek() trusts the userspace-controlled producer index without
checking that the producer-consumer distance fits in the ring. In
__xp_alloc(), an invalid fill descriptor is consumed one at a time until
the cached producer is reached. A one-entry ring with an invalid address
and a forged producer index can therefore keep the kernel in this loop
for billions of iterations in receive context.

Treat producer values beyond the ring capacity as an empty queue. This
bounds the consumer to the userspace-provided ring size and prevents the
long loop.

Fixes: c5ed924b54c8 ("xsk: Simplify the consumer ring access functions")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/13760
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/xdp/xsk_queue.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1bc42c8902f4b..315b656534749 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -344,6 +344,9 @@ static inline void __xskq_cons_peek(struct xsk_queue *q)
 {
 	/* Refresh the local pointer */
 	q->cached_prod = smp_load_acquire(&q->ring->producer);  /* C, matches B */
+	/* A malformed producer must not make us consume beyond the ring. */
+	if (q->cached_prod - q->cached_cons > q->nentries)
+		q->cached_prod = q->cached_cons;
 }
 
 static inline void xskq_cons_get_entries(struct xsk_queue *q)
