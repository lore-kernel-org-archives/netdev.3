Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283082;
	b=RQJvNeJ/fsPYiZKw34GxCip3C2F5PtnUeSGuZi2yXpEEnA92Fu+hG7m5HM/prHHKpIg6
	 3v+pdGbGZotXOuLCbXFkeTXBvI1D43hDxQPAC6fPx1E4lTI6RnSxvdOchVLiji4Sl+LZp
	 boFr5kp7rP0NDkNqsx7MnVHNEeQtsAtjOzPDtTtEnFXu5DqHCr9l1f3LodIaA7ZaxUVvD
	 CsDxjtzcck/8qJa97dCCQGYsZX7QkrYqhrlSIwL1m/v7DKiU5iwfhKwzwmW2wfecF7lKN
	 qHJpJ5NUsTzv95N3rz+VjmNyWh7Wjx56wVVZQtvX1KiLZJMmefqkZg3VUisBCEIYt9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y1n75dlSKXk28YfIHQIdOaiTcHKQaKmSFDKJym+w+lI=;
	b=FxQ7k/tWRIcFgAXnwAoXcR2+WKT0KrggXuxqQp7ztfrAwQpMhh2XYWhOqNjvGuqTSxER
	 JAgj4a9SkXLXDaxvfrxPYbbzVuNbbppgnd9zyaww+ym/4cRdZzwEw2fWLLwvVkLxB2DxP
	 ZGc32+QfdhmwhhoAFVj6RW56XfXYRn8j6UYY606eSPnRtRRU16wdogfvg4+WZsIcwZih3
	 HAzgzQQdOHZVsfESl+NW3vfZki0yMVYLTgorHhhGkQA2j2Jon0h4qZn4tXW3ZYt5YA6/V
	 AuGB4rYMmMqrFzCG55eUdLwtDjECE61aUuCF6L/8X43BHTO7NQY5mJBc0/ChfWSdIRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="Zunm+lH/";
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA060A261F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95DA060A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Zunm+lH/
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b75712fb57so693494a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283080; x=1794887880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1n75dlSKXk28YfIHQIdOaiTcHKQaKmSFDKJym+w+lI=;
        b=Zunm+lH/GCbrTUEtY30BW+R2BvU+2cGVOn79diffD/96JVNfHqCMaR5Gvvf1gsiQR6
         8K76zX1a8+Yh0L2CwsGxZPV8nUAMB+5w5Mm2MCgUMZlSCAEOfZgTki5qqXCp8mJUi8H3
         LuogYuTe3LX1ZCf6xxr7jaIlq6UqvCIrssX2U+lTHLsDy96Ui6AqusBcWrPzeruJ88YR
         /WMhErncCHO3cb8+1zwRpUullxN4yczarlTpXd5JcivujI0fDeVcEqJNPPwMrN68pevA
         Lx4AkP1fiMtHSuXKIJJQw0iIts5da1+6sBlWiXD7EvGQiIWRqgKUOxZqBjj3SECm1nA3
         YVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283080; x=1794887880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y1n75dlSKXk28YfIHQIdOaiTcHKQaKmSFDKJym+w+lI=;
        b=xYHsMOIlc8j4eXhMT6ObDicS3Ol60ylSs347STY9evbMi9OKHjnG7UCwqG/KMXYJRr
         oGwf78p+BluZ0QANeDp3wJ5JTp3c5sajzXf26tVu3xZEzHChY6E55rggytEnX8LCbSVr
         iKhH5cMpy7xtj6JjDkQAPrf7B4LnK+oVSV2D+O6GQ1Fg9Go41+dsd7u9m26zhfXA/gxW
         4SObD2ujVqUT2nnWviYiIh9iF1akiup2UNtR39X+XWHtDBezfTSjJ07a9Q4hgD4zmmh7
         gQrLtmf3vzbYLQFyuhc+sW10+8exRuUjvubuJf9VQ6Hwl61ikZcxG7++tRr3UsT/b6KW
         MH6g==
X-Forwarded-Encrypted: i=1; AL+hErF1A5Lchf37Mz+gDPtgFnTXjYvy4YpIlDFCYZipYX/p/EtJJp7gaWm4uLDLBLd139pR6Hl62t8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TAKZSZliK/Usi3ezwJvTdB/O4FdC6zbmlCA1AmgFku1XW6wTu
	NjfZnmjWstnc1hJ09ziZCPrZkc225s2ocoIFn6MPX2SGFsM4oANOUcRhWfkeWcNnqig=
X-Gm-Gg: AYBFou1iRlpLAV3K+W0IBxJ4AebIbp7rCxH1JSj5n+uB9C5HrCal8rjjA5XrTPzIwU/
	Qn0aJdzxt9wnmJZqu+hIA6xygvw0exVnB+QE1W69je+gmirFtdA2za8OEd6ogy4A4e+izEAgyDT
	+xT54oqgyLK3JV7jR4wQvZ+3Fq+JiMMbLT33JqnywJloGfqSCL308zMBRzaPYQ/KQTbF13RUvUM
	a+3AiPzwklZ0FkrmIa076BkyexEKr2LyScnzvYiBrxM6f1C6pkn7jERcwyA2B/qIgOnphw1y3Vz
	ZC3J+Wt7rS44dGGvPkCGhJsr+k7Clpy2o/zgP7N6/iK6imJPfjAbkPQFe19qjPUMh1IpKyuWbRD
	IBH3k1QiaxXcEPId32T+uTHNabJFN2KTrT6dMqoWto8X3s5QLv+HKmPtznkFn+Wc/R5zuRzDab3
	p1fIFgQCJzsr2C9kutlHBl+o6n3EePSbxg/w7+gmk0VoFqbZbXBD8gtQXyfS4goypNXXXvxN4hA
	1N3hrMJnTVAFsBVt85/WrQNAavuttKekHJmvlQviL/GVm11c8/zVVHyUCZnhJZpebJE4Cy275Cw
	A9UDJujKhbrrnu5ZN9iRh2j52uHkPnGF4zw0FC0fbS8Rm2UkUmnk0BzknRFmQbc=
X-Received: by 2002:aa7:cd92:0:b0:6af:a64f:bd44 with SMTP id 4fb4d7f45d1cf-6b756b0d218mr745095a12.45.1794283080043;
        Mon, 09 Nov 2026 19:58:00 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:57:58 -0800 (PST)
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
Subject: [PATCH bpf-next 11/15] ice: set skb RX metadata from the skb core extension area of xdp_buff
Date: Tue, 10 Nov 2026 03:57:09 +0000
Message-ID: <ae488c057454cd57fb01ac01aefc3e97d6271ada.1794281983.git.tianyi@cloudflare.com>
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

On XDP_PASS, ice builds the skb with xdp_build_skb_from_buff(). Then
ice_process_skb_fields() sets the hash and ip_summed from the RX
descriptor, and ice_receive_skb() adds the VLAN tag. The values that the
XDP program stored in the skb core extension area are not used.

ice_clean_rx_irq() takes the skb core extension pointer from the
xdp_buff before it builds the skb, and passes it to ice_receive_skb().
ice_receive_skb() calls xdp_skb_ext_to_skb() right before GRO. The
stored values then replace the values from the descriptor before the skb
leaves the driver. ice now sets the skb-ext-pass XDP feature.

Zero-copy is not supported in this patch. ice_clean_rx_irq_zc() passes
NULL for the skb core extension pointer to ice_receive_skb(). Hence the
skb-ext-pass feature does not cover AF_XDP zero-copy queues.

Export xdp_skb_ext_to_skb(), because ice can be a module.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c     | 3 ++-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 3 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 4 +++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 7 ++++++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 3 ++-
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 2 +-
 net/core/xdp.c                                | 5 ++++-
 7 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 454fba07d4ec..cb619689d11a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3461,7 +3461,8 @@ static void ice_set_ops(struct ice_vsi *vsi)
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
-			       NETDEV_XDP_ACT_RX_SG;
+			       NETDEV_XDP_ACT_RX_SG |
+			       NETDEV_XDP_ACT_SKB_EXT_PASS;
 	netdev->xdp_zc_max_segs = ICE_MAX_BUF_TXD;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index a730aa368c92..90f2ce5da022 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -52,7 +52,8 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
-			       NETDEV_XDP_ACT_RX_SG;
+			       NETDEV_XDP_ACT_RX_SG |
+			       NETDEV_XDP_ACT_SKB_EXT_PASS;
 	netdev->xdp_zc_max_segs = ICE_MAX_BUF_TXD;
 
 	eth_hw_addr_set(netdev, dyn_port->hw_addr);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a2c7c4962882..06a1a5fdc43b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -966,6 +966,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	/* start the loop to process Rx packets bounded by 'budget' */
 	while (likely(total_rx_pkts < (unsigned int)budget)) {
 		union ice_32b_rx_flex_desc *rx_desc;
+		const struct xdp_skb_ext *ext;
 		struct libeth_fqe *rx_buf;
 		struct sk_buff *skb;
 		unsigned int size;
@@ -1041,6 +1042,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		continue;
 
 construct_skb:
+		ext = xdp_buff_skb_ext(&xdp->base);
 		skb = xdp_build_skb_from_buff(&xdp->base);
 		xdp->data = NULL;
 
@@ -1061,7 +1063,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
 		/* send completed skb up the stack */
-		ice_receive_skb(rx_ring, skb, vlan_tci);
+		ice_receive_skb(rx_ring, skb, vlan_tci, ext);
 
 		/* update budget accounting */
 		total_rx_pkts++;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..85439853596f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -247,17 +247,22 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
  * @rx_ring: Rx ring in play
  * @skb: packet to send up
  * @vlan_tci: VLAN TCI for packet
+ * @ext: skb core extension area of the packet, or NULL
  *
  * This function sends the completed packet (via. skb) up the stack using
  * gro receive functions (with/without VLAN tag)
  */
 void
-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
+ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci,
+		const struct xdp_skb_ext *ext)
 {
 	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
 		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,
 				       vlan_tci);
 
+	if (ext)
+		xdp_skb_ext_to_skb(skb, ext);
+
 	napi_gro_receive(&rx_ring->q_vector->napi, skb);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index f17990b68b62..cfc77847696e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -133,6 +133,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       union ice_32b_rx_flex_desc *rx_desc,
 		       struct sk_buff *skb);
 void
-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci);
+ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci,
+		const struct xdp_skb_ext *ext);
 
 #endif /* !_ICE_TXRX_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0643017541c3..f64659dc8313 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -670,7 +670,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		vlan_tci = ice_get_vlan_tci(rx_desc);
 
 		ice_process_skb_fields(rx_ring, rx_desc, skb);
-		ice_receive_skb(rx_ring, skb, vlan_tci);
+		ice_receive_skb(rx_ring, skb, vlan_tci, NULL);
 	}
 
 	rx_ring->next_to_clean = ntc;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 984299199906..fdda072a5858 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1086,7 +1086,9 @@ static const void *xdp_skb_ext_get(const struct xdp_skb_ext *ext,
  * @skb: The skb that is built from the packet.
  * @ext: The skb core extension area of the packet.
  *
- * Call it only when the packet has the XDP_FLAGS_HAS_SKB_EXT flag.
+ * Call it only when the packet has the XDP_FLAGS_HAS_SKB_EXT flag. A driver
+ * calls it after it sets the skb fields from the RX descriptor, and sets
+ * NETDEV_XDP_ACT_SKB_EXT_PASS.
  */
 void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext)
 {
@@ -1115,6 +1117,7 @@ void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext)
 		skb->csum_level = csum->level;
 	}
 }
+EXPORT_SYMBOL_GPL(xdp_skb_ext_to_skb);
 
 /**
  * xdp_skb_ext_warn_pass - Warn if XDP_PASS does not use the stored values.
-- 
2.56.0

