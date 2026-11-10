Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283056;
	b=Rd8bBoUdwD3MZ7wRDQw9PgHDIHyeMg2eWWTspTsgB37dAkAWkB3va47fuDfOadkJ7Eqj
	 34YmwRoi+c7AGdYGxfKNV3newZ8VMKWgUYSUXiUA0LkMjzEHrGTedyOMhTieRHV2xdlwc
	 bZU/XG7XysGyyRBExodcMlmzIrYmlniOtOSeZJ9alG8bYipxSaSG3NTZbNtl9979m27CE
	 1fmmlwsgpWBxgT9WUBvTBA84WwjeAa0WuuusZDR4aYPqGjtMKUnCUkHDzgVgPbwGF7Yr6
	 2rxzd0F9q4bln8LD8UExNjUwGczA91Vb23qxe12uyPfhDDODQ/4G1u7Ewdb+xOqS90A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EC2CxfAA6gR7S2oAAPp+eS1dDml83jpwhvD444kpRqo=;
	b=zJOQw3ZAEI3rQPiTJHbY5EcmjpEUJhte6ZetR4eduQQtbOAPm+tAF/8NpFKzkCB+6TYy
	 +i3jjW02Kq7LHP8qIGS7LKp2AdBNJv1erCwo55C3tADH8XBNq9x54ALJcWm9Z7/APOne3
	 wDRNDaKPSpzDlAa+j83TO9YVJRZlCa1USiwVOzsze+19wr/JV3pxuJKG1IojWbg1Sd0jn
	 b36eQNgcG5zq8bxZHyQ9E6cmST2fxNT4GwWLuxtycRPNwS4vwcz7EWjjNm/x+NYuV8w2O
	 cmeUckug8ntMa49FxQOVzcGTWZCMsrwUIQcJdAEPz4Hi4Iqloir6SzulLEqaEVJxGeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=doJtRZHT;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5E606A335
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E5E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=doJtRZHT
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c247f6687dcso266587266b.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283054; x=1794887854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EC2CxfAA6gR7S2oAAPp+eS1dDml83jpwhvD444kpRqo=;
        b=doJtRZHTNbnpgwY0Tk0QABAt2OJ4W+o0eKi+YWqBAxLx0axLIIEdnuobt4IeXlgIWE
         ITthrLWGQp3Qff4FnMSUWWMW/YsigFzb/d3b3ddZBxAWfbgsU17JxO+UYSa+IyHxuD2X
         zr/rJSKY1isl/vKP32lbRu88ZwvOxVaqBgFgEkYzqQhtg1z49MD5EtVbQCRGP8HdiJ43
         dEEBVvvp29r4yGqP6aBpbKGaFq/8OTOQWdKcKr7Os5OpAdRrGUqg48/3pDEVhSElID/5
         ji1nW9x+H9xk9Oa/a24heU8amtkcVtMEV73aIyT+bjvpB90Zeb5tsLWkedaEE5UoGzRc
         MRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283054; x=1794887854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EC2CxfAA6gR7S2oAAPp+eS1dDml83jpwhvD444kpRqo=;
        b=zZRywz7+wtwb/9gsXppUmOK242QOsttriyQHIntUzLPgiHbGi4d/FkMd4ilzNQz2cp
         R1xLWicFJS6urd9SHMno+8GEp4b8Vo9KCRX89C9LbxhupMgBbaIItGHe3aTH5Rp2oj1C
         PbpPqenmELTn38ZCaZzsOXJxkRdmvi5XDRiivWiQKSLln8E0+yQj0TfLZywAH95jGorK
         Bgs5NwK7hyyB8PfhQnYiSH6cRCqtVUZaV/8OW0sh5brHQ193ErhJFfR4HmeqWU8ZTMk8
         /o7kv6MVu6qsN/udfucGODKndgeIazCU5dzzpvYRXmlvktOOxK7zdh6w37xZEyn7PyP9
         NAQw==
X-Forwarded-Encrypted: i=1; AL+hErF3L/1I34F355UpkyzNho8m1l8+NFdvYvC991uSjsSVhTtSi8F95MxzuDhz6ZcIvRkfxT1lxPs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AEzF8TKhBT5DNFkTv2v+wcXApOJGmSWcdXeP8rPJgNW65GOgV
	WGG/tUJKOow8erzn2rA2Pqg+3gLoxQjAoSs90TkbIg4sNlarH06TN7xoFTeCgN1QNbI=
X-Gm-Gg: AYBFou3lwq8FHJJh40ucF+vkakNwk3Zojhp6cmw15FEC99gOpWGAeJMTAAFhG5GEWBR
	Vga8hd+rWIeEkbwhL78brzgY45/JniqlrvTR4ehS/Gmbr/VlgMxLivICyDiZH8Ts7RLIKwlSKVF
	sLWXGVWvhtJq16YBjBuryp+Xu9lWfpaIywbqw/aWYfrCfkBlZAHY1P0E5ihrqJ87IBWeRNkUEfy
	lHNKcIcBFCEfQG32Qb4EJvRk+h3BqRebU1T7RGbvEeMn2j8EvYSq/yJmA19l7O4AjWVaENYosD1
	bJocVDMlBRKB7HcPS6Sq6o+5rz9+cE9YvIUQFAkSICzula6IFk3Jp7KX184TAe1g4O4O/aUh7eN
	0uRoaICqbGi6WTNeS1Qocbdiu3ZFJy3WUgBnhishKE9Xo4P2T4i43B88qx8S6ahwEkmMArjVldU
	WrOis6deS40H7W2Pet2UZq1eegHZqLzyo1/G/ayfF3Mo0DHk+3nt1jzVj5wb9D5fzCJjjJ02K0h
	Nsh90GB6rZEE5yUZNhZ3m48lkBpfjeyPcnB0l+dBzxigvelSJtO+QWZ2tyykG6Is8euWUhnSnia
	In6pXyjEquAHhRFllrpR1Ya7hInjcPkM22Cv4IklSxlS/yRRsyI98nUY5lN6XcU=
X-Received: by 2002:a17:906:364f:b0:c2d:be57:f73a with SMTP id a640c23a62f3a-c504952c083mr70409766b.13.1794283054469;
        Mon, 09 Nov 2026 19:57:34 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:57:32 -0800 (PST)
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
Subject: [PATCH bpf-next 04/15] xdp: add a kfunc to delete skb core extension entries
Date: Tue, 10 Nov 2026 03:57:02 +0000
Message-ID: <2892d19e606e3809c268de0610a4ccc8bf68625a.1794281983.git.tianyi@cloudflare.com>
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

bpf_xdp_skb_ext_del() deletes the stored entry for an id. A program on
cpumap or veth can use it to drop RX metadata that an earlier program
stored.

Without the XDP_FLAGS_HAS_SKB_EXT flag, the kfunc does nothing, because
the header bytes may then belong to the packet.

The kfunc only clears XDP_SKB_EXT_ENTRY_ACTIVE, so a later store of the
same id reuses its offset. The flag and the size of the area stay the
same, also after the last delete. To give the bytes back, the kfunc
would have to move the entries after the deleted one. The cost is
headroom that bpf_xdp_adjust_head() and bpf_xdp_adjust_meta() cannot
use.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
__skb_ext_del() frees struct skb_ext after the last delete, because it
comes from a slab cache. The skb core extension area uses existing
headroom, so it is not freed.
---
 include/net/xdp.h |  8 ++++++++
 net/core/xdp.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index c888353425d4..23c976e92898 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -486,6 +486,14 @@ static __always_inline struct xdp_skb_ext *xdp_skb_ext(struct xdp_frame *frame)
 	return (void *)(frame + 1);
 }
 
+static __always_inline struct xdp_skb_ext *
+xdp_buff_skb_ext(const struct xdp_buff *xdp)
+{
+	if (!xdp_buff_has_skb_ext(xdp))
+		return NULL;
+	return xdp_skb_ext(xdp->data_hard_start);
+}
+
 static __always_inline void *xdp_skb_ext_end(const struct xdp_buff *xdp)
 {
 	struct xdp_skb_ext *ext = xdp_skb_ext(xdp->data_hard_start);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 97dc0e403a78..2c1d5ec3311b 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -991,6 +991,7 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)
 }
 
 #define XDP_SKB_EXT_CHUNKSIZEOF(x) DIV_ROUND_UP(sizeof(x), XDP_SKB_EXT_ALIGN)
+/* A deleted entry keeps its offset, without this bit */
 #define XDP_SKB_EXT_ENTRY_ACTIVE BIT(7)
 
 struct xdp_skb_ext_hash {
@@ -1119,11 +1120,36 @@ __bpf_kfunc int bpf_xdp_skb_ext_store_rx_vlan(struct xdp_md *ctx,
 	return 0;
 }
 
+/**
+ * bpf_xdp_skb_ext_del - Delete a stored entry of this packet.
+ * @ctx: XDP context pointer.
+ * @id: Entry id, see &enum xdp_skb_ext_id.
+ *
+ * Return:
+ * * Returns 0 on success, also when the entry is not stored.
+ * * ``-EINVAL`` : @id is not a valid entry id
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_del(struct xdp_md *ctx, enum xdp_skb_ext_id id)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_skb_ext *ext;
+
+	if ((u32)id >= XDP_SKB_EXT_NUM)
+		return -EINVAL;
+
+	ext = xdp_buff_skb_ext(xdp);
+	if (ext)
+		ext->offset[id] &= ~XDP_SKB_EXT_ENTRY_ACTIVE;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_skb_ext_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_hash)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_vlan)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_del)
 BTF_KFUNCS_END(xdp_skb_ext_kfunc_ids)
 
 static const struct btf_kfunc_id_set xdp_skb_ext_kfunc_set = {
-- 
2.56.0

