Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35C41167F
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789422157; cv=none; b=IqPXedKTfPlWMwP1IE8q/Co1+3StbpFZ1pg9eeOntzmSo5HNK4PhlZkoqb9yTCQqrDkasJj1hVJm1F/wo/HKhevPdu07ugvZmKy7ISnKpZqiBd2y5OYAZgJr/vAvsqkcyblqdiQswRfylYrZCpklvdxPyp3B/xxrL1GrPKgOmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789422157; c=relaxed/simple;
	bh=zM/5sCogXE0YOG63To/lzdc1QqgX00LZ1grZde3zn50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJOxZglF1WriG0CEkgS5cO5b2gOYx2eA5pr6Brvil9k8mq0/pMFjxwL1ClNF+htvQNi30lXao9JL2tC2Z9ozgMIQ5oxCS0K78LkQnWkNd4vhQF5CLzbOmMEbyx5l2TV7VDMA4A7N4Umwk9ODfVtE69djlErbQSM6LkmQfc76zHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhAQMywD; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhAQMywD"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66f8053e7afso2065355d50.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789422155; x=1790026955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1kaT/+Urj02Jq9w2IAQAcv6O5zq4BSwo1l2yqqveMaw=;
        b=QhAQMywDQi51sykbmEvfyCqLzjt+stvxOtDdYwIeikf8RCfrtVZE/QZLGulXiYzhQs
         DETYeV5X88nMUquvQ5W+haFstF7zs7mvBqgrk0Sm+FOPaWW6+EnZogZgkfH1gx99DXuv
         4oRgFtQdK4j/KHp8M9KU4FMx1R/AWImGct13wCKvgH1mfGKMlSQKiC2h8oKtKNquueVU
         228CYDQr6296dBw4GcDC5+qwT96SOHQoVDhUND8Ssh8PbKkDWnFSLWgNYcoy6fuGvZ6J
         GgLC9FIlKGugxYLY2AYLP+nk4u+DxDHzEPkDWqv2P/ZmaXz9QRDRb59puw/vx2ji3csu
         +VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789422155; x=1790026955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kaT/+Urj02Jq9w2IAQAcv6O5zq4BSwo1l2yqqveMaw=;
        b=KQDZcWkWajOndM4V0acGQ/PmYMsuG/u55T6qiYj5fTMr32ZeK5u5Pg8sdXAxEts7hd
         FE3+m5JM1NmWvgUfJsLE+1Rc4XKGxuDgCDoC4vfabf86NyMMJMdrp0+ssIrBKLztZOmR
         Nk2451n+UUO0el3PxsyWodSkUIhlPQriIf42xKoIDwNq/6OdIcpan0QjwQs3woywZe2/
         4E6AIkaDxtlNsuoA87Vh81ylfs1oz5BVQp8ZqjIBZEeCshs+ucU1xSaqkNFsyKEQVAzU
         ehPD0g2hZSC+sH+autmYJsyrdnCyuVs81Ke6jjQN37ijNwOIQYLwJNgNjAzhPCPPXHes
         C9Vw==
X-Gm-Message-State: AFuF++lLXKzWHIOhadso1+8Aes/BInGHvXZJBqaoowMG8943Oe2bulPH
	msEI4/cMyP0ywA8n13XjcSbGfWxl1ecrxNbWSzRmt9kiSOSKLD7XYegsO/lHFg==
X-Gm-Gg: AYBFou1JQkTu7lur04gelheL//aOSFezwYTDkRRSYzxXpJLS7wenqac8ct5q5Tc79HE
	DqKac0S9+C/4rQ79cKSZhMgzILsTGmKVg2Er+vfKrmcHq3LOx01YZIEjSqXmeSnVlRxGMkRjufq
	eG6YEtRpFfGsQV0dBM18owN+zfUEBckV9QBq6em1Uxq/JS0WeCIV0IX+BIaGliVOBDJZI6B+yXF
	7ehxZq8H7XdprAgIITFZk35aKfbLzuAECNi3k3UnvoFoRzwlBsXfPnqztisvmUXDBf3Q7Sn3aOx
	F+1uVTuwTHWBaWf5Eq9vSeELp2TREuntJUoMYVQCsQ3GOG6frQoMlv3BJ/df60zDm5jrVBzvDB6
	A9cdqzBa4JOLrHZqV7p4RORcI4MDih8oq3OdlqH2RTd0qopngETcKEqO3En/iT2afaGU817QiWG
	bzrmix80evYtcfJ406n32c1h8T7tWJKWjV3GO2k74FaMJruam/N1MeUoJbdbAAdV6xN1vex2rW+
	Ll12RFAvVAkG12EdjfY3iGUD/03AgXcDRBeeD8nWP33O1ns8d7G/VsndSnzvRk++xGP3RtYyvQ=
X-Received: by 2002:a05:690e:4419:b0:66f:c1be:a645 with SMTP id 956f58d0204a3-6714e076e39mr862992d50.55.1789422155378;
        Mon, 14 Sep 2026 14:42:35 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88486086224sm41718997b3.10.2026.09.14.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:42:34 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com
Subject: [PATCH net 1/2] virtio_net: copy zerocopy frags in start_xmit without NAPI
Date: Mon, 14 Sep 2026 17:37:42 -0400
Message-ID: <20260914214229.1674102-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260914214229.1674102-1-willemdebruijn.kernel@gmail.com>
References: <20260914214229.1674102-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Virtio-net without NAPI frees completed skbs lazily on the next
start_xmit. Senders waiting for in-flight zerocopy buffers can
deadlock if they cannot transmit more packets, as then no
commpleted packets will be freed.

When !use_napi, virtio-net already calls skb_orphan to avoid waiting
up for transmitted skbs to be freed. For zerocopy packets that
require deep copying on orphan (i.e. those that do not set
SKBFL_DONT_ORPHAN, such as PACKET_TX_RING), call skb_orphan_frags
before orphaning to release the buffers.

This fixes the tpacket_snd slot reuse bug on skb_orphan for
virtio-net, and prevents PACKET_TX_RING from running out of slots.

This fix also touches vhost_net zerocopy packets, which also do not
set SKBFL_DONT_ORPHAN. This is fine: vhost_net packets only encounter
virtio-net in nested virtualization, and only if napi_tx is
explicitly disabled (it has been default-enabled since Linux 4.12).
In that rare case, copying the frags is desirable anyway to prevent
holding guest descriptors pinned across unbounded intervals.

This is a prerequisite for the next patch, which converts
PACKET_TX_RING to standard zerocopy completion. Without this patch
first, a bounded ring sender can stall indefinitely behind a
virtio-net virtqueue that cannot reclaim.

Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
Cc: stable@vger.kernel.org
Cc: mst@redhat.com
Cc: jasowangio@gmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e34c52d059d3..1ce528c18f9e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3349,6 +3349,13 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	else
 		virtqueue_disable_cb(sq->vq);
 
+	if (!use_napi &&
+	    unlikely(skb_orphan_frags(skb, GFP_ATOMIC))) {
+		DEV_STATS_INC(dev, tx_dropped);
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
 
-- 
2.55.0.1032.g73a4cd73de-goog

