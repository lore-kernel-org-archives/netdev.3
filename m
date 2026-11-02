Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646885;
	b=23GC3aIancarp466w8ZzapfrPosB59rfZgyihKmTDDCHtFK3Pl3QOVdKRTMgUC3n4AcD
	 uvIecdRpAAzuUiyv1Xjz824GfkBksPLWfT6Hvtoy8NIr5UwqplF7PQYNtsXdLIgTHtxsT
	 809mnmc8JWN3fnrQ4G8qMPylX9blsD/UALO+Jb3A117vhjn/ZtBDcYmb8jW/vJckf8AXm
	 vQFLaFjBDw+6bzHvFpOBtVxDGmmm0yB3A5DZ/pUrovtS2OG5xsU1BhcdVDU7j0rlv79zg
	 cLNW2wKJsToGc+dm011cKLeRJXa4F/a8B8XBsD8z32WwLUTkSK691hBePl2sny8u0SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ebj5WEXuQbI24aZxPiirAFW91UeqhX9/gKfZ+31Y7fw=;
	b=OElLAhntMl7enEzOz6jS+BBXRcWmooPQrTrmju6igsXeWP4mI9DEX0B404Vlo4nwkgtZ
	 biaVmY/L/Uvr2A5CctrFJ5o2RTgLW49YiBygg+KnoXzxC93WgI6zEp5GBcub1Y25cy5AW
	 B5WaRHTXZ3U46gD3eIMNNb6N+N9stVTp2XHQPlG41OmqZJh47gVdgNuY5JXVAcjHUIU1+
	 IKwWy8meLauA8u1LLDAth6oFcG1ZPjFr9RH1KhGvwRmmbZdhCgRwYswIOuCbHiV5Qzf4N
	 XapaVGz7fwnTF0kzVUEGyaFHzdF9aGzHliwIwjs4iKaQ23VA5uUcXPbPcwDCSyvMqgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=olswBHUo;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B8606D838
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC7B8606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=olswBHUo
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so757102eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646884; x=1794251684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ebj5WEXuQbI24aZxPiirAFW91UeqhX9/gKfZ+31Y7fw=;
        b=olswBHUoRGSS8folG1C3MfrCz90MbZhfMECYSpiKiG5MuewonhIp6YTa+5eVZW4Q99
         X9ZI5fUIBYHxQV3NfYx6IYr1JUWf1o6ougG5/3HX0zs0bY0OQJE57qir7bp4ZjQPpL1R
         0etCiZ3RhDTmGwFZCQuwpNB8+ZN4BiF045u3p5/H3R56t/Ztod+3iSCUyLhYfGpQWs8u
         8M5eT2GtiYSrx0uA/WyCUzWk0cQoXZtYIQvlM2x9Vph0vVfH2XQ6lfjUVitRc5G4EwBc
         5DPbizvxZUmNneEgLbDxyTeEVDV60nBRKdxGtxsolDQIlB6AGz8Fi0PbfJyyJhzTfeZh
         eGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646884; x=1794251684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ebj5WEXuQbI24aZxPiirAFW91UeqhX9/gKfZ+31Y7fw=;
        b=IuyHuHSpP6PM84L1JUB3r/xcZ3CXvZMzFOpgSTjc81KFb0aGyYhV3lmOsU4qYdDgZC
         0yd7+gcstqdE9bH0Chr/tQak5x18aSJy0j23Xp4RuQ9+yqpkshAj6yv8uQufHbjPGRyj
         rUt8zSJ2fSW3HoKxz2ca+Tb4rkY2kh32pcfdhjFGtAbd4CdDQ4dEYsom62B1rROjCNeb
         zC+x5NLLBvsNTRX8ypL2a2zXD2Izqupg0rHK/1qeIHEoGn6zrgBrzHBpf00FljvwHJLS
         T1CA3EHmQoYhVaRgo3gYPkCP7BQ4izSmmWtvaKXfg9zDnn/ChXlsiK6w3W5OE8OJg1wQ
         fCpA==
X-Gm-Message-State: AFq9FYKxqve3KTVO2jn8srN98tt6eAxkStIfJ+UmyhFt1jSWqjRGEIKW
	e9/t3PoBi8kbXhzxQXm0BW8jxpJkszkQsViTCP1rh9JTAkOVrmL2oHwkgPE6ULZp
X-Gm-Gg: AYBFou1f+UUWxEv84pEr/aEO/t1HvbpAboGTFv83qWMEnG3DBOt4E3IOBkyo76Nl8WY
	tKUoFzzfZRF3/IGr01R9drKVe6NJ8rZTdSAy3Ot8WV26YqgO3iXemEarQKlc5dhhMngfq8kfHQS
	jHlw8OmRzFNB69IyTzcEFp3EPqB2s3edwM3zwf9C9dXEQMBdORC/ySchIfr0UTUc8VwMQd5oRc7
	yJngY0gUAoqe84Omb9bSJlz2tHItcK1MTZmLy/m3reMPybzXwL6MJtVE1CrPMjksJ98l3pG9Uo5
	sZ95M3qgu+vkmZdWXGPvdq7nTV5AlXMSK2HADNX0/iJlK2ekvysryrjqkx4JkiJGEPW3FDnMzdK
	yYmgnNTcipOuBoB+zySpTTe/rWB2uaBpOfv2y1qgAxY9CCREufMnv2Byebj0Wv9bfSLpGNrz2/P
	IMqjswEuZZqQGUqTM4AoDauboBXcTYnYkh83UcW1OiyjCuBqPe0xHkoNjqdOkflBfXcUXk25SrM
	uBruV6Ono1cAWNbgUIwDbZJ8YyP6OSY/yk/+tNUPvDMV19UdkJZVortEutSQ2vuuQZGbnQ3Y1RO
	UAnf6J12XmN8DQ2AINx4iUg=
X-Received: by 2002:a05:7300:e9c5:10b0:367:3d68:8480 with SMTP id 5a478bee46e88-36a4206d82emr17568099eec.0.1793646883870;
        Mon, 02 Nov 2026 11:14:43 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:72::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42952e1csm42105061eec.20.2026.11.02.11.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:14:43 -0800 (PST)
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
Subject: [PATCH net-next 4/7] net: devmem: add a per-device netmem TX frag size limit
Date: Mon,  2 Nov 2026 11:14:35 -0800
Message-ID: <20261102191438.1059771-5-sdf@fomichev.me>
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

Devmem TX frags are bounded only by the net_iov size, which is about
to grow up to 2MB, more than some devices can describe in a single TX
descriptor.

Add netmem_tx_max_frag_size, U32_MAX by default, and cap devmem TX
frags to the limit of the device the binding is attached to.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/net_cachelines/net_device.rst | 1 +
 Documentation/networking/netmem.rst                    | 6 ++++++
 include/linux/netdevice.h                              | 2 ++
 net/core/datagram.c                                    | 1 +
 net/core/dev.c                                         | 1 +
 net/core/devmem.c                                      | 1 +
 net/core/devmem.h                                      | 1 +
 7 files changed, 13 insertions(+)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 8eceaa80b686..4f5fd5b99154 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -76,6 +76,7 @@ unsigned_short                      dev_id
 unsigned_short                      dev_port
 spinlock_t                          addr_list_lock
 int                                 irq
+u32                                 netmem_tx_max_frag_size
 struct netdev_hw_addr_list          uc
 struct netdev_hw_addr_list          mc
 struct netdev_hw_addr_list          dev_addrs
diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index 6871dcdd700c..04861c60cfa1 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -155,3 +155,9 @@ Driver TX Requirements
 
    - `NETMEM_TX_NO_DMA`: for virtual or passthrough devices that do
      not DMA, but still support handling of netmem-backed skbs.
+
+3. Drivers which limit the size of a single TX buffer should set
+   `netdev->netmem_tx_max_frag_size` to that limit. Devmem TX frags are
+   capped at it, otherwise a frag can span a whole net_iov, which may be
+   much larger than a page. The default is U32_MAX, the value is read when
+   the dmabuf binding is created.
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442c4344..4453b80bf7ea 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1845,6 +1845,7 @@ enum netdev_reg_state {
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
  *	@netmem_tx:	device netmem TX mode
+ *	@netmem_tx_max_frag_size: max size of a netmem TX frag
  *	@pacing_offload: enable EDT pacing offload.
  *
  *	@name:	This is the first field of the "visible" part of this structure
@@ -2342,6 +2343,7 @@ struct net_device {
 	unsigned short          dev_port;
 	int			irq;
 	u32			priv_len;
+	u32			netmem_tx_max_frag_size;
 
 	spinlock_t		addr_list_lock;
 
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 489d92fe6dae..a8d3f87d38c5 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -734,6 +734,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 
 		size = min_t(size_t, size, length);
 		size = min_t(size_t, size, iter_iov_len(from));
+		size = min_t(size_t, size, binding->tx_max_frag_size);
 
 		netmem_inc_ref(net_iov_to_netmem(niov));
 		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ac700d37e59..ba2f887dcd39 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12350,6 +12350,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->gro_ipv4_max_size = GRO_LEGACY_MAX_SIZE;
 	dev->tso_max_size = TSO_LEGACY_MAX_SIZE;
 	dev->tso_max_segs = TSO_MAX_SEGS;
+	dev->netmem_tx_max_frag_size = U32_MAX;
 	dev->upper_level = 1;
 	dev->lower_level = 1;
 #ifdef CONFIG_LOCKDEP
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6339f221bc82..19c039ed2cb2 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -218,6 +218,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 
 	binding->dev = dev;
 	binding->vdev = vdev;
+	binding->tx_max_frag_size = dev->netmem_tx_max_frag_size;
 	write_pnet(&binding->net, sock_net(nl_sk));
 	binding->uid = sk_uid(nl_sk);
 	binding->niov_shift = niov_shift;
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 8fa089776610..97ff1f13fb84 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -79,6 +79,7 @@ struct net_devmem_dmabuf_binding {
 	struct net_iov **tx_vec;
 
 	unsigned int niov_shift;
+	u32 tx_max_frag_size;
 
 	struct work_struct unbind_w;
 };
-- 
2.53.0-Meta

