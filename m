Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443974;
	b=ATbfUFuMSSrDL8bcJGEILam/NZwPn3CPYymziX7dtzvhpQGgKKZqpCkqAXuRHrtnskMJ
	 5+N03aOiv/UoUaytV1ghjYV7whi3Y4F4shENRiq+Ps0DB43obxhV2XeqvxoMWCx/iGHnz
	 jZCKKVGKgkqmMTqxBbdjdufoaa6AUYkCz0Pu4+L4aZr3pUsdg5z6A+jkqu9XYWohb9e1H
	 HrAxW7YTaNYqizhxaUkqT6gP9Irz7WtNnPL7JXmLnkKSl+D3JWAe07Y+G3owuxk8Lmcs0
	 l6Z1O5TK6yQcfmamE9C+prcmYkkAF8FtkmUSEWoSlt8vQtdAP1i+vMf4jvjyoEEqBiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=WqVC5CFEQLN+eiA8h21jf2v2wQ711iAVIxvEEPes1m4=;
	b=umvGOUKERshWG3bXsdiLKC3uEQjfOuxnCYZs+ZQxRlHxde49zcFllj6J8yggZk1UDJHM
	 Tn3bl7PdDDmV0Cm6TNzegIyC48r9ehEZu7EPlVT9iC9mEAKGtLc3cuxx7YqvIDuS0UAVq
	 Kjw8zyGMHGAVjxyga6Uvk/3hozyLCJRwMgOGUsXkjzHBbFwCsfOLoRxN7i3qimdKyxcLy
	 mK6NAjsxIq+2ks3/b6P/p59kb728UN6bBoGDAN0maVwHpeZd5W6x77Hfmw37LkjK6DthP
	 rLJQXN4z2zprCjZhONiCxftlumcrr+HcstGVJIdFMUXDm1ztwZoLvO8/ES6fW6l/s4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dpX3I1Oc;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D2606A31E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B6D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dpX3I1Oc
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c3f8e149ccfso243360966b.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792443972; x=1793048772; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WqVC5CFEQLN+eiA8h21jf2v2wQ711iAVIxvEEPes1m4=;
        b=dpX3I1OcHLNS2fqeWjFDj9D8EkiAUIUv6c3JhQLfrP9NRsQwQDhxre0oALunj+W1Qj
         MvHuVfZ8jh4DTKEB4MHiHIG6d1eox/pz9VfwcEiRzcMeHJHObmKoJs65fuF7KkFMdLjr
         Kp9R+4WqfGEDy2eCzDLULeiORAlx/0MLHguWrRfonCYTHRwOVvfYgHcqlfkHPW5h7okA
         C10zp2HJUo/Wv1C0eI1aP8ljiklHTUUju6SLLga2rEiQ6ACrRiEMqlmosMv6RkvyGfZF
         pukj0x5Nrr3yCseyV8/w66P8b749eGWgh867q08+2h++RWXYK1y6ja9KWVmO7qRFSmvl
         SgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792443972; x=1793048772;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqVC5CFEQLN+eiA8h21jf2v2wQ711iAVIxvEEPes1m4=;
        b=H/ycpV8//j2f9P0olftrLW08Z9IN7rCVYDsomXIoBU6xa1G6tYQFUD58HbcphR13sd
         lMoc4DoITfHhSh9bSbiMTEC4BBM/r5FXWVve7uOgEQyEHyBpahBvVaW7GxHogMS8vgd7
         hMCnX7Zx/rlIF4Mm4T8Jq+AIpuxT84K5EB59djXBHtkgucgT65Mh5+HxCLEk0igJzL2i
         59n1nnJgAD7jIZUZj1eaDzqeFjKOIqMETT8cAEb6cbL2jwKYX1N07OTzmhfFlbABzItq
         UaZx+ZwBmTKKDQmmAZcKEliWMY4tS0Z5Vk0DGl4yIQQa59kNVn2Y9JjhvbJu/ksSb0pP
         QTBQ==
X-Gm-Message-State: AFq9FYImSKNhwrt4jGqwluZRfBWkt09BuYubAHhHQc6YHllcdXs/fDhH
	n0zm1ezACenvrH7dIduYnFAR1tNVpuKIqriBMOFk+q9zw1hB0PRrHqyKcDrEBhOLVTrHPNDYpWC
	C+w991Q==
X-Received: from ejbm7.prod.google.com ([2002:a17:906:2587:b0:c3b:6442:c974])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9617:b0:c29:d31f:7d73
 with SMTP id a640c23a62f3a-c419d83b528mr591194766b.9.1792443971745; Mon, 19
 Oct 2026 14:06:11 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:06:03 +0000
In-Reply-To: <20261019210604.2433620-1-lrizzo@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019210604.2433620-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019210604.2433620-2-lrizzo@google.com>
Subject: [PATCH iwl-next v2 1/2] libeth: add libeth_rx_alloc_gfp() to specify
 allocation flags
From: Luigi Rizzo <lrizzo@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, 
	Joshua Hay <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

libeth_rx_alloc() calls page_pool_dev_alloc_netmem(), which always
allocates with GFP_ATOMIC | __GFP_NOWARN. Drivers also use it to fill
their Rx rings at open or on queue reconfiguration, which runs in
process context before the queues' NAPI is enabled. There, the caller
may sleep and GFP_ATOMIC is needlessly restrictive: it can neither
reclaim nor compact, while the initial fill can allocate tens of
thousands of buffers across all queues.

Add libeth_rx_alloc_gfp(), which takes a gfp_t parameter and passes
gfp | __GFP_NOWARN to page_pool_alloc_netmem(), and make
libeth_rx_alloc() its GFP_ATOMIC wrapper.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/net/libeth/rx.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 0e736846c5e8a..14a528ea8a075 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -96,20 +96,23 @@ int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev);
 void libeth_rx_fq_destroy(struct libeth_fq *fq);
 
 /**
- * libeth_rx_alloc - allocate a new Rx buffer
+ * libeth_rx_alloc_gfp - allocate a new Rx buffer
  * @fq: fill queue to allocate for
  * @i: index of the buffer within the queue
+ * @gfp: allocation flags: GFP_KERNEL where the caller may sleep (e.g. the
+ *	 initial fill of the ring), GFP_ATOMIC from NAPI
  *
  * Return: DMA address to be passed to HW for Rx on successful allocation,
  * ```DMA_MAPPING_ERROR``` otherwise.
  */
-static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+static inline dma_addr_t libeth_rx_alloc_gfp(const struct libeth_fq_fp *fq,
+					     u32 i, gfp_t gfp)
 {
 	struct libeth_fqe *buf = &fq->fqes[i];
 
 	buf->truesize = fq->truesize;
-	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-						 &buf->truesize);
+	buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
+					     &buf->truesize, gfp | __GFP_NOWARN);
 	if (unlikely(!buf->netmem))
 		return DMA_MAPPING_ERROR;
 
@@ -117,6 +120,18 @@ static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 	       fq->pp->p.offset;
 }
 
+/**
+ * libeth_rx_alloc - allocate a new Rx buffer from NAPI context
+ * @fq: fill queue to allocate for
+ * @i: index of the buffer within the queue
+ *
+ * Return: as libeth_rx_alloc_gfp().
+ */
+static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+{
+	return libeth_rx_alloc_gfp(fq, i, GFP_ATOMIC);
+}
+
 void libeth_rx_recycle_slow(netmem_ref netmem);
 
 /**
-- 
2.56.0.212.g129ede20d9-goog

