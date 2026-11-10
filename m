Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283078;
	b=Jzn2L8P4B2n+/rKn/Mgjhf77cJ2G/OCCAQAd7nSg3nprV1EZTWTzY7N1ksdFG0AY2Cil
	 FFBkfeF6v0WIpmwnDnSPSxcLan4UaVUUSFPP7RvSzCAtZXwER4c0iEOid0OetbqbUC+fp
	 rlbLvh9tSeykZk/GhDoBp5oNtgbn7rsRGbN1LCCR9g1ViFasWRhhXkmDk13VL18u28VJf
	 ch44Euf421TwGXGpgd89oF6MGIMq+GmvEsFGgcVDC/iVlQgd5tcdL+pCk4eFTckAE0wGu
	 ofEEkpn5eJxA1AdzygNjxA+NCkOSi15x6cVr7EzPPA0q8OyAGtHU9dpTA3gMRYsl09g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6mXUjSsb+h9m7vI0sEcfo3uXfUjeQTfFxyZorh+4fbw=;
	b=c9ZYrTHlDFyYdUM2ubDy9XTW9pILPuv0qcdFqHtgZpUDmepajxD5ZLguoIVQ+U/bB1S7
	 6w3d0iL1kWuOzJzeTm4s0dolmf+FfNwKB8LeoS4adTivD1yUOD0/ywDxrBubdqEotrXGX
	 nsTAtDdutTsi3EAB/zgVLOlc+/uDXZK0PLoCs7kZR8aNJanz8m00JpMmfBXczUU8yPB/y
	 8zLDa4KM1tZrcq9pA5CHx+NvMvtrhAcmnBDrwiVbwKB6UQL7oVCtpeVy2myFqsb//Mq5k
	 N5cgX7reYItl7MRj/jnbsf4Bb5cHXwqoVZoiU8HTdspAgq0P0PztGml5CgALTtonUHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XC8BC+yO;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DBB60A2639
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10DBB60A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XC8BC+yO
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso321980a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283076; x=1794887876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mXUjSsb+h9m7vI0sEcfo3uXfUjeQTfFxyZorh+4fbw=;
        b=XC8BC+yOwXmRJEMz+SM144v83trM0hc8QUlojPPlg5jn8c13A/9q5ZCk/vIzUT+F25
         DWvg8DJpjS8mDFhVpYJUyE+t6CDTvsIgpAITPaN1+ke7wDqVgQWIi394d+qZ3VZn3mR9
         Leih8+JD2KIGKLtFyQRNUpOBj7iVjdfXO9Ifmhcd8F1Dle0HFGmWHpXyG1NfEqTAOo8H
         1rbygOI8fumV3nvSGGQMCf0ZRWrwvb9oTZWI7hsjSAHJ0AHX0OCN/ziEzFqWvPUSHj+/
         oUMOv8OpT7GMGQ1i/eTLCoyR0xW29XxQugD8wBBLBfIUrptzTyjEQCqk/L1DEfmmUH5v
         JrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283076; x=1794887876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mXUjSsb+h9m7vI0sEcfo3uXfUjeQTfFxyZorh+4fbw=;
        b=l/TaxdoUoxzd5XpsTavagplzVoCBvRPVcMXVAiq7uEFm9pI9VJd5gOJIRd0iVLpEn8
         0PE1skjZVrfm7e1q7dOSMDhIw+wln5OwHe3w2O5MgfsGdX0hD0ASAm2e4twbMKM/9j1c
         hPmsLoPCi74PO60c/wln78FcC/aZMkFAENMhLEAbXCyDQFeRtLW1c1SjO6BdUG9GPh6P
         SK3EDr6pFLCDAQ6lFsBSy+r2ilRZoN7fHlu+Z2lP6I58DTvFvXimrYjJniDzdycrxjI7
         IuPIz7YANWwLP8JMK5TMs42gky4L4/xz36itE23LSHTS51xUnPMVtyLdIlZ0dllu5A5K
         8V1Q==
X-Forwarded-Encrypted: i=1; AL+hErEKnrNnaGW1bpwllacLaJGqBOjzZuWiLRG4AdIBZTx/rAILBTpIj3qNVjxhFJmjqUCvyhlD9nE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PchTX5IIMMH3+1LE0aL0W21sGSyMo/fPNYjrhtgTbY2oCDnaP
	vYyKf6kb+oJNQLr1/O7OJ7r4X5XPn9FknAsjJXFEAPH+1iA5iO5UT7BgqierV4IwjQE=
X-Gm-Gg: AYBFou3hT7dsrglEl0Si1+wGUm2SgqCVApipEbTe7PB5l34S2rtOmD9CPGpnqd8TUjd
	A/akrIPnY1SzY9qKi0w5ZW2aKKkd3qeVvOftf9u5lal2cm2zH8oCoiiWMT70UTOULJoAaNf6PIu
	BRd1GaFf+oJ/8Q12tBN9zihBYEMaxsqPlUehiX4Ns6vd+C6erLK1iqslx23PwS7cfs8jrt3eH5d
	/0urBU2p9jP1cntATLRj9AjzB/tWHnhhGHaG8O0r5gquDzgTPXAgEro0GYXHd40lNfpDbIP43lu
	jWVh6LrG0ArzssJ7nU4pjV12dUlFkkX7FaUgZxyOB6V6kNRKiCxQvkvL5gvmBmQAla5wQSRjgYQ
	wNxEGhZLk0m4PB1MhQL8nDrwAjv5lrk3zFXWkkK7p5GU/VML/ErYWg9/eBSpwteZcFBamAs98mA
	j4M1IX1fniS924eG1wGrJwUVguO1mKtjNs6iL0qKYb3gLEhPc0RvKHey99lBbsZeNGJdEvr1Dtm
	9c5sZW13i5o9t1xn7nueyBCdqmvqPEOruF0Ob9HpuoCT90Og2bPv+zTot4QfWepXvuXKTdWnQKc
	nJbu5nLpYrCzJx8LP1v9z0ChyG21WmSiF+ac5c6hNfkx1FJzDbQTcr3eBaGFKxE=
X-Received: by 2002:a05:6402:214b:b0:6b3:c320:8858 with SMTP id 4fb4d7f45d1cf-6b756ae734emr681477a12.24.1794283076584;
        Mon, 09 Nov 2026 19:57:56 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:57:54 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	llvm@lists.linux.dev,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 10/15] xdp: warn on XDP_PASS with stored values when XDP runs on an skb
Date: Tue, 10 Nov 2026 03:57:08 +0000
Message-ID: <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
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

On XDP_PASS, when XDP runs on an skb, the stored values are lost, because
the skb already exists. This happens in bpf_prog_run_generic_xdp() for
generic XDP and for cpumap and devmap programs on an skb. It also
happens in veth_xdp_rcv_skb() when veth receives an skb from its peer.
veth has the skb-ext-pass feature, so bpf_prog_run_xdp() does not warn
for it.

Add xdp_skb_ext_warn_skb(). bpf_prog_run_generic_xdp() and
veth_xdp_rcv_skb() call it on XDP_PASS with stored values, whatever the
device features.

Generic XDP also runs bpf_prog_run_xdp(). On a native XDP device without
the feature, it would warn twice. So xdp_skb_ext_warn_pass() skips
generic XDP.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
Tested on virtio_net and veth: generic XDP prints only the new warning,
and BPF_PROG_RUN without live frames prints none.
---
 drivers/net/veth.c |  2 ++
 include/net/xdp.h  |  2 ++
 net/core/dev.c     |  2 ++
 net/core/xdp.c     | 21 ++++++++++++++++++++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index b402f8ed5096..f0d279e2da6a 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -826,6 +826,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
 	switch (act) {
 	case XDP_PASS:
+		if (unlikely(xdp_buff_has_skb_ext(xdp)))
+			xdp_skb_ext_warn_skb(xdp_prog, xdp);
 		break;
 	case XDP_TX:
 		veth_xdp_get(xdp);
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 7148e8ef00e1..596261ed9cca 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -511,6 +511,8 @@ static __always_inline void *xdp_skb_ext_end(const struct xdp_buff *xdp)
 void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext);
 void xdp_skb_ext_warn_pass(const struct bpf_prog *prog,
 			   const struct xdp_buff *xdp);
+void xdp_skb_ext_warn_skb(const struct bpf_prog *prog,
+			  const struct xdp_buff *xdp);
 
 void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		  bool napi_direct, struct xdp_buff *xdp);
diff --git a/net/core/dev.c b/net/core/dev.c
index 3bf00e7e1a85..e37c881d968b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5705,6 +5705,8 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	orig_eth_type = eth->h_proto;
 
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	if (unlikely(xdp_buff_has_skb_ext(xdp)) && act == XDP_PASS)
+		xdp_skb_ext_warn_skb(xdp_prog, xdp);
 
 	/* check if bpf_xdp_adjust_head was used */
 	off = xdp->data - orig_data;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 36d6bb38b719..984299199906 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -18,6 +18,7 @@
 
 #include <net/hotdata.h>
 #include <net/netdev_lock.h>
+#include <net/netdev_rx_queue.h>
 #include <net/xdp.h>
 #include <net/xdp_priv.h> /* struct xdp_mem_allocator */
 #include <trace/events/xdp.h>
@@ -1124,12 +1125,17 @@ void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext)
 void xdp_skb_ext_warn_pass(const struct bpf_prog *prog,
 			   const struct xdp_buff *xdp)
 {
-	const struct net_device *dev = xdp->rxq->dev;
+	const struct xdp_rxq_info *rxq = xdp->rxq;
+	const struct net_device *dev = rxq->dev;
 
 	/* The skb is built later from the xdp_frame */
 	if (prog->expected_attach_type == BPF_XDP_CPUMAP ||
 	    prog->expected_attach_type == BPF_XDP_DEVMAP)
 		return;
+	/* Generic XDP and BPF_PROG_RUN use the netdev_rx_queue xdp_rxq */
+	if (rxq->queue_index < dev->num_rx_queues &&
+	    rxq == &dev->_rx[rxq->queue_index].xdp_rxq)
+		return;
 	/* No native XDP, so only generic XDP or BPF_PROG_RUN runs on dev */
 	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC))
 		return;
@@ -1139,6 +1145,19 @@ void xdp_skb_ext_warn_pass(const struct bpf_prog *prog,
 }
 EXPORT_SYMBOL_GPL(xdp_skb_ext_warn_pass);
 
+/**
+ * xdp_skb_ext_warn_skb - Warn that XDP_PASS on an skb loses the stored values.
+ * @prog: The XDP program that returned XDP_PASS.
+ * @xdp: The packet, with the XDP_FLAGS_HAS_SKB_EXT flag, built on an skb.
+ */
+void xdp_skb_ext_warn_skb(const struct bpf_prog *prog,
+			  const struct xdp_buff *xdp)
+{
+	pr_warn_once("XDP_PASS on prog %s (id %u): dev %s runs XDP on an skb, the stored RX metadata is lost\n",
+		     prog->aux->name, prog->aux->id, xdp->rxq->dev->name);
+}
+EXPORT_SYMBOL_GPL(xdp_skb_ext_warn_skb);
+
 __bpf_kfunc_start_defs();
 
 /**
-- 
2.56.0

