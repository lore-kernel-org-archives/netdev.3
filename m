Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749923;
	b=ODubH3i1gdsTajCGtBNy4YhdprPkG/jxe9NhexrO5nKum4DJWdQ5ID6rqW6wb6Sf8V7Z
	 QbyUwB0w2VZkJGssRNnI/tgLA1vQkF5xP/GENTX35SQ8damuUpcmVj6USNCKFm0gPypWS
	 mzqUsWsVMrIhJzndGe2CeOo1/R9HFt3y7tYXlL3VHbiRn+boxG0hjwSE1WdqHe9aYyZa7
	 e8dOooGLgbwgRg4TMVTQpVOI63T5P5dBrKpLrh6I2IkLDCCPQfEvCLC+KmY0n6uDllena
	 lq62tETRAmtsjC2yiBwBlFVl8RPfErOhM9vArQRauFYRVwKx5+oAJA7ckgueZcSdbEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YK0Xr740yMaz303kQAw5xU/hri305+ZpCPlJBa3zu5I=;
	b=ZWzjr3p8i7aiKiufK/q9NxDq0K79p4ncg0r/rZUe77Kv7IU+6PlB3RrSrY2Yho1V8BrC
	 1K1G63tq3pkL/q498SMuz3A8ZTOga8AdxZN3EKvKE9rKup2BxsHDU2aHHMxrDq0hHEQIE
	 xl8xU6W1EtaNoNciS9N6xXb4V+OBX2q+qU9lCT3uDTRyZnNraYwbXjFmFHHHalyP7cZHC
	 l47zo8+5LXf025fWe5wxNimEAkA1rd0r59ZdpfGPTV1nDlHgmCrFy97wxSyp5ok3am4BW
	 /kdUBoi+lXPyOBuXiGL88nqlpMGGxi/DbJ0I6KayfNPuu+HMNTIMScWwBvG0XEGW9bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ibeH9DzR;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67334606EE99
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67334606EE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ibeH9DzR
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso60596c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749922; x=1794354722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YK0Xr740yMaz303kQAw5xU/hri305+ZpCPlJBa3zu5I=;
        b=ibeH9DzRIx4RfJPxFHevHlDLr/xdu4QlU9YCsTEV7vBw0l4zutu1+wX3cGgEFI0Up+
         CVu0HBGKpCLnauFhvNuKxdWvE/qXcbaTNrYSZKDwDqF/iH2b7xd0T5PgFqQwR7BDn0pa
         Rq1D90uB+attIqkpLE2zIEaD5/5JfR0laKPNMuYywldn2ktuZtRARf+yB6gMO6LqXH3a
         hEFFwo2eCeXcLrFsUYt0aR79LL7Zm/IG9nk+H074IXsetu1oYEevVpEpoge21ZwSDkZe
         UC9DLBOB+CdzmX6Wz71LszCuBKJN1fdZfHa9hb4u8IeSILYNKVjY8c97A8kW9FbNWbPl
         fWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749922; x=1794354722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YK0Xr740yMaz303kQAw5xU/hri305+ZpCPlJBa3zu5I=;
        b=EWUyn6kiVzwWnCSeSdL46snnfcGSFyVcTIGCtlPRkNH6aX349PAPlmmu4zhNaa/rT4
         9MJTXMPbz0PCy6J1d+lMAeWVl7YbQlfSQn6fen3a+oURVcmlnAiVqcnd1JhQ//RDW4YL
         vHL1E2RvOtiW2U2aY+/51q2sd3J67AFHYmzs4wCz3u2EXru8cs+fXyFmSY0bxo4XWkpx
         sv9dtaz7xcbPZNOs9+lrWqP7fUNSlGoKlSzh4IWCqWU74rUE/adv2dydIvU/h5ZxFJ1U
         HzvBveg25Q5rNSMWLh3o9qQx7wa3D0+BiV2WN6x9WCZbyMAOhN22cnEZWK9kwsVZ1c0E
         xU+w==
X-Gm-Message-State: APuU4Z961OSv4BsJkbwrawTgoE4dNS0iPHbLyBZDZ/ccwMa7Tk5lqgRr
	/+TVgbW02OuVlQhKYUUv7fmjTTQlHejcBR5K9qGpMUjF7ScACCWhrVBh10KjlIcu
X-Gm-Gg: AYBFou3v228Pgx0uWZ5K+CfVhL377F1JO8tIt/9TMwcZ2bGLJrCxVXOlg+XAU4wgzIz
	MZPCXIm9q3D6gjygiWmzu/C+uMMsxC1XJnL4gfL6DYPrar1K6sCZ0qzInTohJsqWJSw0I6KtBdS
	+EcKLDhHrsFxax88H9qNOeNEYzLbhnwvGOXvbMhhhACjrRpCvPCb0C1ddg5/p6XZcPSsGWeAlKS
	BwsZQtVnXDWBqtqOXiaBeaMLKu44ex1DzZ8ZaqlNchnYyjibaFd2PEmaW0dP17JRordt10vlJF7
	CThrCcYgnPnEged8ft/iMonGq0z1clQAtAUhvsCetI/mHNRsChcgMVk9Q1bniSbs3PM3s6Ljw9H
	EjfAH5qB9xJ7fgTF/3daY1JwMUsalRF7xMfoiNpGlCsiZ5sdZ1cPp7VmHCcLJcU5JoyAGF0H1kx
	HMpe14xixsRRFdbBXRgCjB4R9uEjkcarcBAsL11sFQOsktBDY0hiApu6oVPXbyDTmAsdlU1gYAS
	b7NrFO/a8jdv6BJHYIBF5WKIrt0lj8k08x96T5nPk+WXLDwXUCo3hLn+IInMhv8oF1AVoMusaoe
	i6uBdE1Jp0fE7tAvcaytWyOwqtqihViQbpTtlmyeVteJ
X-Received: by 2002:a05:7301:6405:b0:366:83dd:4704 with SMTP id 5a478bee46e88-36a423dc7f8mr22151511eec.17.1793749922079;
        Tue, 03 Nov 2026 15:52:02 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6d::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b3b7esm1439560eec.28.2026.11.03.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:52:01 -0800 (PST)
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
Subject: [PATCH net-next v2 6/7] net: devmem: size TX net_iovs from the dmabuf sg table
Date: Tue,  3 Nov 2026 15:51:51 -0800
Message-ID: <20261103235152.1904727-7-sdf@fomichev.me>
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

PAGE_SIZE TX net_iovs cap devmem skbs at MAX_SKB_FRAGS pages (~68KB),
which makes BIG TCP ineffective.

TX net_iovs only need to be DMA contiguous. Use the largest power of 2,
from PAGE_SIZE up to 2MB, which aligns every DMA segment of the dmabuf:
- 2MB hugepage-backed udmabufs get 2MB net_iovs
- no UAPI change, TX addresses are dmabuf offsets
- skbs are still bounded by TCP's size_goal, only frags get larger

The net_iov size doesn't depend on the device: frags are capped to the
device limit when they are built, and many frags share a net_iov.
Capping the net_iov instead would only split frags at net_iov
boundaries and allocate more net_iovs.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
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

