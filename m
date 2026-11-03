Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723012;
	b=VL9OMj00HZFi44yE32wYBPuw99zuyo3u3w8Rcf1t8VuIjwXoHgHu1p48z0eFn+E9SvYr
	 Cs3YTrC419Z2TH0sZ6o+WgLPXGdhxNdcnfJzJ/e0GnbyN3w8tV7FtT5sxAY+3BABwyNGI
	 LBuM9D+E44D6uxj6Q/qTrQD7mSi3AS2AKemBg/4FcX81RbcZcgxl7mDAorYqvB4BtEbqf
	 /MP7WZQGQ65gVUXTilpVCCWGtikxJroNolDvVywwWALtwJ/WJS3H9hyIcosS/wR0MboPR
	 eX3kWPsqbaTJ8AY0HtgoUAITxqwO7SDWgVR5pA4/Ag2OXT/yruqyij/NFC/SAMKDGwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=9VsMG0ZVwtVW7+osviETCc9BDdPpuMXt1m2c2HzrSlg=;
	b=hh93OUuedjR9sd5eitHEnhLEz4H3OooBsXRxHOszYPxGWW0GeINskpJuzeoMD5CSd7AG
	 1EIipI3Z6DBK2hCA2j1vOwXxIyIZjwN2H70FV9CjQ4Wq9ayjz020OotIDSPjYm2hFtvXv
	 MnFJJlnBZNtkB3AiaL7l+RQCcmb+PPnboKii0yMXs/eRsSGIawOnqpo/x0gb77crvoRdI
	 p3+fVZxbuhxLHDnt97s8KqBdHI5aL5NPVsv9NKQu7OPytdZMCZH2vvIvIrvs+9xgdUy/8
	 WZGeh2Z3HU8E+lYrv0+l+P0H1pSkgQV7FE4sa6vXtihiQgxOXeEkxeSMGpaW/8/nsaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="YW/pKNRw";
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C4606A32E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6C4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YW/pKNRw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c25edb54d22so567936366b.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793723010; x=1794327810; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9VsMG0ZVwtVW7+osviETCc9BDdPpuMXt1m2c2HzrSlg=;
        b=YW/pKNRwSm5tGIE91eH6g8zAz9IXBaDjjoJBQr8N11TFOP4YzESNOBkHYtRzxCq2ow
         KZhRYnPhQZfPKcLYUnGPXYod4oEQ6eI29VBoWuXLR/cVfKBDlPBYCSlNHs89Odjq1sqU
         0PTFreFsAAOfEno+C09cvb+XCJGDbDEIV8+NYp/7I89KC279HZKqugZNe4a3bwQkytj3
         XQh4lyJGnAbq2MWNU+6H3F6C9eBuVShjltWv7KmsdRr0gQfvp7F9hcQlwi+SdILlDQKh
         kgmTEFHmsOHUZOq8OelYq1baf0v2qUGKM23PV9bRIQ8sOlDcuj48RwGM+KHi0vEwXkxj
         06CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723010; x=1794327810;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9VsMG0ZVwtVW7+osviETCc9BDdPpuMXt1m2c2HzrSlg=;
        b=L7MEWUqL+Z9AxMeZ8Kq/SOAHnwfAgem0L51fuN7tkjPEZ8cu+VY2Y6dmkV4E7gou7I
         eIMnwRqiz3iMhlKAU4fbTRhkckulfmTr4vP8pujMFYXdpg5+HlwS1CYTDDmAJUTtS+cH
         Qhaukf70TRFF104J/oUB4T4S/yQbn9WLVYN2cB1DliBnHz5T8ySAAdIysO5jN3HYOq56
         B49t0aUQJ5AqF1VxazfA33oi4vXFengywd06qZOahT5Ed62hMbtW8dRHHTUk4ZtnXwKc
         YVTHX8dU2SHH6luufUoWeFySsZFPy3uWWpHofqeg1sw99wlEeORN0bej6oDBsS4ke5T1
         +Lbw==
X-Gm-Message-State: APuU4Z/WDTZ+JUosEMLamWKkAnvWxupPScy0RWWCSpAvRmWiy+GAV95U
	mggh1QxvffCbzEFosbAeKFHtykOLvb0MB9g6grR1TScSCLJyfcKANUu4RR3UeH3Jb5N7b1RLYBp
	IXgvZIg==
X-Received: from ejeb13.prod.google.com ([2002:a17:906:194d:b0:c4d:5f4:bb5e])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:f582:b0:c34:e9fe:82ed
 with SMTP id a640c23a62f3a-c4ca7aac4f0mr1166497966b.28.1793723009807; Tue, 03
 Nov 2026 08:23:29 -0800 (PST)
Date: Tue,  3 Nov 2026 16:23:24 +0000
In-Reply-To: <20261103162326.3615979-1-lrizzo@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103162326.3615979-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103162326.3615979-2-lrizzo@google.com>
Subject: [PATCH iwl-next v3 1/2] libeth: add __libeth_rx_alloc() to specify
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

Add __libeth_rx_alloc(), which takes a gfp_t parameter and passes
gfp | __GFP_NOWARN to page_pool_alloc_netmem(), and make
libeth_rx_alloc() its GFP_ATOMIC wrapper.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/net/libeth/rx.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 0e736846c5e8a..1333850f421a3 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -96,20 +96,24 @@ int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev);
 void libeth_rx_fq_destroy(struct libeth_fq *fq);
 
 /**
- * libeth_rx_alloc - allocate a new Rx buffer
+ * __libeth_rx_alloc - allocate a new Rx buffer
  * @fq: fill queue to allocate for
  * @i: index of the buffer within the queue
+ * @gfp: allocation flags: GFP_KERNEL where the caller may sleep (e.g. the
+ *	 initial fill of the ring), GFP_ATOMIC from NAPI
  *
  * Return: DMA address to be passed to HW for Rx on successful allocation,
  * ```DMA_MAPPING_ERROR``` otherwise.
  */
-static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+static inline dma_addr_t __libeth_rx_alloc(const struct libeth_fq_fp *fq,
+					   u32 i, gfp_t gfp)
 {
 	struct libeth_fqe *buf = &fq->fqes[i];
 
 	buf->truesize = fq->truesize;
-	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-						 &buf->truesize);
+	buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
+					     &buf->truesize,
+					     gfp | __GFP_NOWARN);
 	if (unlikely(!buf->netmem))
 		return DMA_MAPPING_ERROR;
 
@@ -117,6 +121,18 @@ static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 	       fq->pp->p.offset;
 }
 
+/**
+ * libeth_rx_alloc - allocate a new Rx buffer from NAPI context
+ * @fq: fill queue to allocate for
+ * @i: index of the buffer within the queue
+ *
+ * Return: as __libeth_rx_alloc().
+ */
+static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+{
+	return __libeth_rx_alloc(fq, i, GFP_ATOMIC);
+}
+
 void libeth_rx_recycle_slow(netmem_ref netmem);
 
 /**
-- 
2.56.0.385.gac671c819a-goog

