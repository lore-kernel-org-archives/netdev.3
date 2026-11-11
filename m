Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362375;
	b=PfS/ve0nymTK8BDlZVFwVen/zzgMVstxFL35oQ0lfECIhXrTRDC9EHV3HdkR954Ziw+L
	 3vptqj4FyFI6gowbHwlH2XHOxpLS+W27hLic/701r9AmgemFZJOC3O6g/thfXWhm7nk4Y
	 ly1XxEIx33Au6nFGJSY+yrISP8sQSWwVuLigW4V1OCzlSzF4lM5a4OwQ+PvvAvzGkudKp
	 r9mimol0Lj/F7ula9BtHwuOQU8UqfjS0d8UiaKZzq0DkOQ1Ixct1bOnSWASTeP4UaHID7
	 fYqRac9id+yS9/VVZbkx0n9Su/OfDy2q0mbB86foqmFkI1wf8QTxA/AZQMwdOqEqdOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WzryhHStuQlBVjCAYw0PiX7ovDnbv3qfhee+mFhRhaQ=;
	b=ZJ/LK7Z6e1N9B3VAKE21tauqcOW/45asLnFdGBOV0HA/MScENd+ErZbjwwqetHvl9OVw
	 v2acS3gYbpgBq0OeFiROPsz8ppTRxw+B0Z9XyEhgOGPWAkDgWDnLjzkcOw5Y1buSking8
	 rMn3LkLrW0R3MX35YhE5myFHmBOiBFu2LnRT7/7KP+3ZA0nH3390PfRUdVoAaOHLuKOlt
	 T6IsDUhhUvE7RTemc1Kb9wMa4oaniUsgfebR9JyyB1Bd9CrqCdNtTnP9vlrtcY/lHkyqv
	 DXeijbds2Rfon+LtQtSqCUYIUnl2IjvRgXhy/iA/4o556gPTrXZXBJNGoX3TiTyj1Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=T0VRk9cy;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D731B606A32A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D731B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=T0VRk9cy
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c3fd91337baso457113166b.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794362373; x=1794967173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzryhHStuQlBVjCAYw0PiX7ovDnbv3qfhee+mFhRhaQ=;
        b=T0VRk9cyW5oSeiYyDz+wV5NVJ8rOFF1fugEdBoGMZNcYyTJVuzZdhlSKnDfVTGOkY7
         WxQ1c4TjxwX/TMvf3XvADgIt1SncBkH8gXxclu47MWVegv8Ds/763QcTVVLQsGvTliiF
         tSWtnZkGcwJbQu1JOwwFkMFM+HRoDxf9w809+So7raMfWDcKbbVBOntah8IgCv4MvsLd
         hdkxpovNIpy5NkEsEm9gvLwxHlbhDrQNmbaBvUCxW/S35LCX/3njQc2Z1w1t8779fjUI
         aq7th/FeAW5qHAFZGXSFfYJfDzyf8aI+gLMLlBrWHKVFmwKeOlim3nnk4hJRG72eULY2
         qWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362373; x=1794967173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WzryhHStuQlBVjCAYw0PiX7ovDnbv3qfhee+mFhRhaQ=;
        b=Q1JBa51DXF/bh6n5/3SfjY7lAXf7kJ9eeOWQboQeyLLZijhhP7iS8eCgBBlGy0YYPv
         FD6XxYSvbLtaGT+Cn/MMbX1vcg5YguX6W1J59ggiA98JXYrWCwFymrhnr/VGJ171byP/
         hJ1CSQ4vJU5PiqM5e1ZHRTcBjPNDO1fEwD4N6qMBrKLD124W3SyG7wQo5ILWa5vlt0vk
         sObWJXKu00AmZJUo0NWIKyR7W21yOrNvxdhjRUwozO84S2Ip7DwBGr3W4Ky6jk+ZXT/Q
         gWOvP/W94hl3XWy6EVh72Lo76SrlOCwGFU/fdrm7LqhV4rGyELDAIjXx5/+hIan+rSOW
         7dAA==
X-Gm-Message-State: APuU4Z+/Yt73DkZxdlqZrxNsuMcR4wfDMOdlvPMwvctp6eDSj4Xg+xWl
	7P0c3/z1hOZIeVROpvB/K8F0XtDgZL/gOucMI1OIQYaVRmXT1v+qhCpIjXQF5FdWeW6blOssYqU
	z9RD7TY0=
X-Gm-Gg: AYBFou0od1kLyPnzEPgUPHCGZkS8A68PguwETil+no4/B7cDi16OA63+3uGSCuhVO0l
	yIsL5l5uumijff3Vkb8AbsTyDSdd4GuAhXaJ1JRi7iQ2VaxoKOrMrh58YTGchkLbzouf3kiJsoG
	MwPQvjHFQR4vTYgVly1DBsDtiblD8saW6q33r5Tpt9ASO15agOaNcV7gs18LNdAXpc6p6bVXoTZ
	S2CcoDkSuSnc7KAfXwY+kxzV+Cq5E9fBj5IvofK7xwpBSnhuU+ag5SUytCx2VdImsSvBIROxvrg
	0mtSosyNj6KWT00lr2DDshEm8+t0tLZ3RDNjkv8PoF7a8fn3Soufr0KZGpelG1NgRPUyQKox+4i
	4VYA0LEOebZPKmq3wERrod0Rn3hwR/QJeFQLo2z2PAo66WMlzQ8uu5lJPinjTLxcs7RvyWJCDmt
	tL/BT2lqbrP6mu59Yi08TMYwz8Awn19sl+JOaU3NSPRo5ROUSP8OvsSN4bJu7r/ZFQTntnQxq0Y
	7dV1XwE4as/d1nmceMikyZafHBDArzUgSzY2Jc4dpZ5kl4gsa6gjReaAGl5ct8WIY8RULI+E5fH
	rKzsW9BklNcuVWWBL+cgWvtd/6+JMVDWIPBpzqpJ8DwRYwaU5MqRBlTE4Q==
X-Received: by 2002:a17:907:9289:b0:c2b:4142:2db1 with SMTP id a640c23a62f3a-c5066cf5ef5mr59870266b.40.1794362373265;
        Tue, 10 Nov 2026 17:59:33 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7834cdc23sm147498a12.12.2026.11.10.17.59.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 17:59:31 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 2/3] veth: link RX queues to their NAPI instances
Date: Wed, 11 Nov 2026 01:59:21 +0000
Message-ID: <20261111015922.67745-3-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111015922.67745-1-tianyi@cloudflare.com>
References: <20261111015922.67745-1-tianyi@cloudflare.com>
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

veth does not link its RX queues to their NAPI instances. queue-get
therefore reports no napi-id for them. napi-get lists the NAPI instances
of a veth, and their thread PIDs when NAPI is threaded. It does not show
which RX queue each instance polls. Userspace cannot tell which NAPI
thread to pin for a given queue, or which NAPI to change with napi-set.

There is also no way to busy poll an AF_XDP socket bound to a veth
queue. Since commit b95ed5517354 ("xsk: Bring back busy polling support
in XDP_COPY"), xsk_bind() takes the NAPI ID of a copy-mode socket from
rxq->napi. veth never sets rxq->napi, so the socket gets no NAPI ID.

Call netif_queue_set_napi() after napi_enable(), which assigns the NAPI
ID. Call it again with NULL before napi_disable(). veth is not ops
locked, so netif_queue_set_napi() requires RTNL. veth enables and
disables NAPI only in ndo_open, ndo_stop, ndo_bpf, ndo_set_features and
ethtool's set_channels. All of them are called under RTNL.

Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/veth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index f5097696df15..c04277186405 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1062,6 +1062,8 @@ static int veth_napi_enable_range(struct net_device *dev, int start, int end)
 		netif_napi_add(dev, &rq->xdp_napi, veth_poll);
 		rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
 		napi_enable(&rq->xdp_napi);
+		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX,
+				     &rq->xdp_napi);
 		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
 	}
 
@@ -1094,6 +1096,7 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 		struct veth_rq *rq = &priv->rq[i];
 
 		rcu_assign_pointer(priv->rq[i].napi, NULL);
+		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
 		napi_disable(&rq->xdp_napi);
 		rcu_assign_pointer(rq->xdp_prog, NULL);
 		__netif_napi_del(&rq->xdp_napi);
-- 
2.56.0

