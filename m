Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306017;
	b=I1oYpU87wcilRZOlmf0BNK1lczHYqg99I+rbLUznykIoqra2uMAuowUlUsHUSF22VmUG
	 WlwokW5LKAah/mEBKNT6/WjBLA24ltVv8qU7U4WttwtP5pJDW6Ao9B1mzd9xX+FWwRM89
	 e2GcRNOO7lw10+sZPBKo/IBMqcdaoXznjqkTPdj/rTjTj3bJWN/ahDcEN9MvkXU4TmszU
	 MIhLIBNv7rL/VO4MK54Mc+jTfTezCY6wNrN2RTyBeeRHuoLKzmFCQIdBXv/iY+qcH5kPb
	 OUvBkxqOISvsxo6ORBkI2jUid/i45DDWujdjVMEGt05r8MdG1LAk+85SGH9XNbEngdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306017;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature;
	bh=t6EBDerPEShbrpX5uNn+8UklubrqlD5rwGGgrRVNe5U=;
	b=ZPbkLRt9LHvlJs7jb4XKHl5BrNBEM61fH19LSO5D776NDD7XoMSp6f4pKDwV55ulp/jZ
	 um0lcC9tcm4ADb+6SD7mgd5etjAozw9NXT/aqEUfezXzBBMI5Y4G7GYeoBEmsvU3j8tZC
	 ujbICHLrsuDbKaIoKy2vLhB77dxDSaZPQpWnKlg5zENhoOL0I0Kc9k1My6Dpb7Go6i2AP
	 v1x1Xqg9uwrDvQCLOTQF7wjrYAd3w55SKew9njRl+v5Ho9Wu0CveKNlk9h6BLxEgqcq3v
	 0UiMi7RPhvti7tDS/2XYMnS9uG358Ys8dC7rahmeuB/s5PCNKqdNw1j01BHDJL3wzOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=ij3MHchZ;
	arc=none smtp.remote-ip=217.74.67.49
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEC60A2600
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1FEC60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=ij3MHchZ
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Tue, 10 Nov 2026 11:20:05 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"huangjie . albert" <huangjie.albert@bytedance.com>,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH RFC net-next v2 2/4] xdp: return status from generic_xdp_tx()
Date: Tue, 10 Nov 2026 11:19:39 +0100
Message-ID: <20261110101941.1059662-3-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110101941.1059662-1-sst@poczta.fm>
References: <20261110101941.1059662-1-sst@poczta.fm>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1794306007; bh=t6EBDerPEShbrpX5uNn+8UklubrqlD5rwGGgrRVNe5U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ij3MHchZg1GjDQchEWpuHCADRgE0Yz0N386kAfvyUuGgzd7bvFhNOHb8TgtTGT0zP
	 ZUPE5aYqg+CkqxQMGoW+p7sk/OH/R9vtwf/pBtHhXraawK5ASQgrb1jYqyVxO5bbty
	 XwQiAo9Kv5NWZuFjN0/mycy4Q5e9o4QrV+0+h38M=

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Once veth will start to use __do_xdp_generic(), this will be helpful for
correct stats values being incremented - otherwise we would not have a
knowledge whether XDP_TX succeeded or not. With this being implemented we
will only bump xdp_tx stat when actual transmission happened.

The generic redirect callers in devmap and filter keep returning success.
generic_xdp_tx() frees and accounts a failed transmit itself, while the
caller of a failed redirect frees the skb again, and in devmap the
original skb may already be consumed after skb_copy(). As with native
XDP, a redirect succeeds once the packet reached the target device.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
[sst: drop the (void) casts and explain why the redirect paths do not
 propagate the transmit error (Björn);
 rebased onto Vladimir Oltean's "net: pass the XDP action to
 generic_xdp_tx() for tracing" and "net: validate xmit skbs in
 generic_xdp_tx()": keep the act argument, and return 0 only if the
 driver took the skb or every segment that validation made of it]
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 include/linux/netdevice.h |  4 ++--
 net/core/dev.c            | 16 ++++++++++++----
 net/core/filter.c         |  7 +++++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f18bafb4efe2..b251c4b5c9ce 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4357,8 +4357,8 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     const struct bpf_prog *xdp_prog);
-void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
-		    u32 act);
+int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
+		   u32 act);
 int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index 6e330fc415cb..12595f6b9eba 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5854,13 +5854,17 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
  * that XDP packets are able to starve other packets going through a qdisc,
  * and DDOS attacks will be more effective. In-driver-XDP use dedicated TX
  * queues, so they do not have this starvation issue.
+ *
+ * Returns 0 if the driver took the skb, or all segments that validation made
+ * of it. Otherwise returns an error; the skb is consumed either way.
  */
-void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
-		    u32 act)
+int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
+		   u32 act)
 {
 	struct net_device *dev = skb->dev;
 	enum skb_drop_reason reason;
 	struct netdev_queue *txq;
+	int err = -ENETDOWN;
 	bool again = false;
 	int cpu, rc;
 
@@ -5869,14 +5873,14 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
 		trace_xdp_exception(dev, xdp_prog, act);
 		dev_core_stats_tx_dropped_inc(dev);
 		kfree_skb_reason(skb, reason);
-		return;
+		return -EINVAL;
 	}
 
 	txq = netdev_core_pick_tx(dev, skb, NULL);
 	skb = validate_xmit_skb_list(skb, dev, &again);
 	if (!skb) {
 		trace_xdp_exception(dev, xdp_prog, act);
-		return;
+		return -EINVAL;
 	}
 
 	cpu = smp_processor_id();
@@ -5888,6 +5892,7 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
 		rc = netdev_start_xmit(skb, dev, txq, false);
 		if (!dev_xmit_complete(rc)) {
 			skb->next = next;
+			err = -EBUSY;
 			break;
 		}
 		skb = next;
@@ -5897,7 +5902,10 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
 		trace_xdp_exception(dev, xdp_prog, act);
 		dev_core_stats_tx_dropped_inc(dev);
 		kfree_skb_list(skb);
+		return err;
 	}
+
+	return 0;
 }
 
 static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
diff --git a/net/core/filter.c b/net/core/filter.c
index aca8160b26a1..b7241cbfd8f1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4883,6 +4883,13 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 
 		skb->dev = fwd;
 		_trace_xdp_redirect(dev, xdp_prog, ri->tgt_index);
+		/* generic_xdp_tx() consumes the skb: either the driver took it,
+		 * or the transmit failed and generic_xdp_tx() traced the drop,
+		 * counted it in the target's tx_dropped and freed the skb.
+		 * Returning its error would make our caller free the skb again,
+		 * so report success, as native XDP does once a frame has been
+		 * handed to the target device.
+		 */
 		generic_xdp_tx(skb, xdp_prog, XDP_REDIRECT);
 		return 0;
 	}
-- 
2.56.0

