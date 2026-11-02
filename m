Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646887;
	b=M4yAWDYhnyJS9jPkRJd/+b302Ee3rE5u1KSt9Jmuh88G7Whs2LP2NtmqvLIp01kITv61
	 E1fCRISALEoKs2YRU6rGZhS/c2L03tX6jQ2A+Ky4pJtupB8IWOAiWduTFdGxmu2UC2V37
	 2ZVVxCwZXbwGujG/4hwPRIMrO6Agg1cpR5bZmYLPPgGWPfvf+UFbSdI873u2ZD76PsZpe
	 8ZLo7qXkfER/BS7G9wjvVBIO8H0Q1JNxoopYnHWMxlCq3OTsiGix6aDExDwBpbKpEANOQ
	 OzPq+3pDtVfxJGrdOC+frlymDsUChkM7nLKNFy0I6fqBu+LRlyVn3QDicG32d1seZsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x5vucs4W796ZHC+npd6ZnayJC+IA8nom1dy9O9U2Tu0=;
	b=gZE8xiRYguKYhUtlh/3DbAjCT8nRsSuZyWNCnFoq771HXKtppgXZtsGIIUqkekPA0KDZ
	 tfvm3nU5ZyVlx7NZBGj5lHGf7F9ZXClpM2TxfmlPtN5KoM7OEV4Z5Jc+3Q66u4+j7tY3U
	 fNHEkZsm3s80X4pUNe0bsLhTs/RJrbh9A8J5oVzb1juG89eZL2aSRcVLLK/72Nx+CRdFM
	 6ufoI1h3+wnAOg+6z4Kiq4HFqKCzyFaFOvM4NPmb27ml/XZv78/4KkD7wT6989RDxHq5D
	 2ZIi5LIc5QCpX8jqO3ZwVobA54nzzukHYPcLsDnIHqKdlrjUVEY40EfFJIvTaitsB9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fvBS6lME;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5AD606EE9A
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F5AD606EE9A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fvBS6lME
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-164f08a9e84so784312c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646886; x=1794251686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x5vucs4W796ZHC+npd6ZnayJC+IA8nom1dy9O9U2Tu0=;
        b=fvBS6lMELxvPUr0t9WppDBxoZ3YyYAaIn0kwnnJ0T1cQMEU6EHFjYMH4dElyrFVU5H
         oeH0YlKYaZ1RO+vZCTK4pMgcXVpvIVpwKzkboXMjdim7hCZGLPfjKvxuBCZNnRgOYNxV
         jfBSfCLum1ZHzk42Peda6hJtD2KVEdtyQK6ftkL8Acpwdleq5KTpfjjpIOSsHYS7r6Or
         hCz5sq9YL8xFycVBZPLC0KZZOhbjzis9byKNUidkJw4GejbZNz2PxdhWMC1bZ4Wygrg4
         e2HXMEEhQS730SOZNq3nHadFxd9P2R+AH0lrgqxidRc5bN2/Wji7L+XR2WOMRxezaakg
         brGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646886; x=1794251686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x5vucs4W796ZHC+npd6ZnayJC+IA8nom1dy9O9U2Tu0=;
        b=hteBzGLNL9aihVpQMvky0Zjk54mBKvEgnbGPQA+mRn9tpbFExTruETY56ufOFpTLQ/
         yy7jmXjQOP/fVC+H31kAlr7AYexrAv6e6oYvr7/vXw2rGCmdnAIdBVGnyrpe72Trp7Jd
         qDC2MLFlxvlfgLMTbq74qJA7LxVL8EdDMY/CPd9BTYTIVAQE04kn1/xvpINgXhDpLmB5
         yR0NcGZvifavEbG7eIZYHtug/rYHQK95UT1q3QB8+RAQJVE+AsNRh64Nuq9tkNwFUKce
         nJvPob4syOSP3iNqyl3VDBNRawi4WamibUBWTSwmx51ksZJvdPcZqiSraWEDJr0EQE37
         Ldrg==
X-Gm-Message-State: AFq9FYKD+vbUaBMoJTF9LtwxWCEPaQAavNGf/EP0EyjeBrvIcbx3/Dqd
	IS7ke3+nbrKXXsxuHU8wCav8QT+rFUQi1WbAu1EngcciGeCoEQFEbgwrv52Nadck
X-Gm-Gg: AYBFou0H5lZMdM3BVr0fbHCZ8AGQAPnIXRw6dpUWSUn1+fReuapUDKRzgzON4iwGqt3
	GVCVd/342Ca/BFus8td1rebyHq6Aaa2th4Ds/T1hjeWLHy95KDyvdEhNn+7Wq9v4hglBM7CmaDq
	mMwFyP2piv0UEQ4AtXRbXfwDSxv+98KpX6UahbQbwXok27gkTkEY/fCiJ/ZI3DD0Yi6lyEq2nJd
	LceAydfBUv4J89B1+hb86YMvfxC1IckYX/CQHFXFyGJQATlZ1397PY9EDq3L9R9Ixw589mgQ8eP
	JcJI9EI0UlzC1bmaFCge2KY8SKPskkPmwWwNstRf2Vc1fDTGcrt44dk+e+BZBclA8eUV0WIZuhv
	fr7DOAsAymYK8kvIW2pPii/UADm5hTYIPabL+D88s+c7I3exbjkwvkPoqlGFm6eTNNO2yvKnO8h
	tWJxBldFqDLW3Ykh4rkLtaP0ldPo1n1zW5/hadQ18OY4n0YJXI9vMKXKh2gs8DR2LFV8HXxszCs
	acra94hEoO3q7XUP58fdbrMNFXjyEWRFDOUEMYc/sQfCKTassd2bVsOMjHsDX/WkO2VyNdjcoqp
	BqBlaKCx4weY0N8/3W+JofqbSr91jgph7qjqsY6erw2z
X-Received: by 2002:a05:7022:7f13:b0:144:eab0:9cbc with SMTP id a92af1059eb24-1ac5e8dea62mr15143041c88.37.1793646885926;
        Mon, 02 Nov 2026 11:14:45 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:43::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm62826454c88.7.2026.11.02.11.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:14:45 -0800 (PST)
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
Subject: [PATCH net-next 6/7] net: devmem: size TX net_iovs from the dmabuf sg table
Date: Mon,  2 Nov 2026 11:14:37 -0800
Message-ID: <20261102191438.1059771-7-sdf@fomichev.me>
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

PAGE_SIZE TX net_iovs cap devmem skbs at MAX_SKB_FRAGS pages (~68KB),
which makes BIG TCP ineffective.

TX net_iovs only need to be DMA contiguous. Use the largest power of 2,
up to 2MB, which aligns every DMA segment of the dmabuf:
- 2MB hugepage-backed udmabufs get 2MB net_iovs
- no UAPI change, TX addresses are dmabuf offsets
- skbs are still bounded by TCP's size_goal, only frags get larger

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/devmem.c      | 28 ++++++++++++++++++++++++++--
 net/core/netdev-genl.c |  2 +-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 19c039ed2cb2..98c9594dbf99 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -181,6 +181,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	return err;
 }
 
+static bool net_devmem_sgt_aligned(struct sg_table *sgt, size_t size)
+{
+	struct scatterlist *sg;
+	unsigned int i;
+
+	for_each_sgtable_dma_sg(sgt, sg, i) {
+		if (!IS_ALIGNED(sg_dma_address(sg), size) ||
+		    !IS_ALIGNED(sg_dma_len(sg), size))
+			return false;
+	}
+	return true;
+}
+
+/* niov_shift == 0 picks the net_iov size from the dmabuf, TX only */
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct device *dma_dev,
@@ -191,11 +205,11 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
-	size_t niov_size = 1UL << niov_shift;
 	static u32 id_alloc_next;
 	struct scatterlist *sg;
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx;
+	size_t niov_size;
 	size_t niov_idx;
 	size_t i;
 	long err;
@@ -221,7 +235,6 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	binding->tx_max_frag_size = dev->netmem_tx_max_frag_size;
 	write_pnet(&binding->net, sock_net(nl_sk));
 	binding->uid = sk_uid(nl_sk);
-	binding->niov_shift = niov_shift;
 	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
 
 	err = percpu_ref_init(&binding->ref,
@@ -266,6 +279,17 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		goto err_unmap;
 	}
 
+	if (!niov_shift) {
+		niov_size = SZ_2M;
+		while (niov_size > PAGE_SIZE &&
+		       (!IS_ALIGNED(dmabuf->size, niov_size) ||
+			!net_devmem_sgt_aligned(binding->sgt, niov_size)))
+			niov_size /= 2;
+		niov_shift = ilog2(niov_size);
+	}
+	binding->niov_shift = niov_shift;
+	niov_size = 1UL << niov_shift;
+
 	if (!IS_ALIGNED(dmabuf->size, niov_size)) {
 		err = -EINVAL;
 		NL_SET_ERR_MSG_FMT(extack,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 384fdc5ae514..bfd229bd31ca 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1261,7 +1261,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	binding = net_devmem_bind_dmabuf(bind_dev,
 					 bind_dev != netdev ? netdev : NULL,
 					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
-					 PAGE_SHIFT, priv, NETLINK_CB(skb).sk,
+					 0, priv, NETLINK_CB(skb).sk,
 					 info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
-- 
2.53.0-Meta

