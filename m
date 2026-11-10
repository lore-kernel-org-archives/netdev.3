Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283089;
	b=u2DpL5VtwPwi2MKfheWsFUUtftqIf2KVMyhySJrtzjQGp6ptI69YHzo+5mH7gu5a27Fr
	 sbxF/LEGSGINjYtnudAy76TYORAatNhSEdubNkOHjQFvOcOvUrnMUeAnescbEYsqTAYcX
	 UvmfhO4IsmMhMf+K4meqQmPAB2Jjw4+LJy/THPJIuHnCrfWAaWSctVxGcjN6avCJ5+wtM
	 5Gnrt8mJdRKSIXw0TtGDnLxMo8Z7f5fw+ZOyH5szbz7MWcCozN4hvCMKNkSk7H0uhAgrU
	 2vChGjsehdzGjig1GloTAq/NBvSn40AG7s3KVFDxaXxAxZtLt7WHiGFOLqDrflVIKJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PKtp2J/LvdqcfkW+9WIXUeirxII9N+NyVOA5Mc+RvFk=;
	b=IvhqyuaXvsmTmiBUgxk5UXQCGqSkM+trSJDRkocASbPH/G5OucnYq+7KVDs0T8ICHvLN
	 ljv21WIQGuIq6mCHjzwV6cty1eFNixrUWxIs5y5z7UQRrWafoDQf0IZnGMLtM9xxQBmKE
	 txgZXZLIOgTC9Dy/aEptWC2XUHfhtLwz5PFD6uiolYrY/PLy8DrNh7v1phyQJkHaJZJyU
	 r/lQze+OP3Micm8C6IHZJxVmMU8Ej6QrndZle+Sl4ME8n2IvRQ1UKtP10R0xc+kjWExlf
	 rB82DbYIrJ3rZ7LpXLwE92piJUrzM5bRvKtlOJqhEwrGqL2WNVKo23lKDGASJ4YJlQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=MO78JhEH;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F224060A3836
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F224060A3836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=MO78JhEH
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so846421a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283086; x=1794887886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKtp2J/LvdqcfkW+9WIXUeirxII9N+NyVOA5Mc+RvFk=;
        b=MO78JhEHetkUvtt/6xyBQjnilRZP+k7gGuu9WX8QvZ4DVL0ayH+WQNpr74gYEvW+4c
         AtcaROKUnVLZ6FL1X7rJMU5IkYsy5V0UdBICmHkqypaUDdNboFMD2To1MpsEdzyegEIi
         F3oZMw4O7Jq9vtjT271TEXv/5TbzMvzuAo85uoXkeS+7T0rtWdZqSWZ295ytdWRLiv3I
         yOKdjNMbHOR59Xdj95N/cTu8Q2+muwsVs+V7t11FyaZvUuYZ8CY1fIp/UDxLYcph2A85
         1c8AtrvfLj4sy27ii6kr4HreZa8DOtcggqE6zM0RfIW/PcQOeQqTGkNI5B87TGM2QIxT
         TXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283086; x=1794887886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKtp2J/LvdqcfkW+9WIXUeirxII9N+NyVOA5Mc+RvFk=;
        b=sVv0ZKQeTQJgvOZ3v/RJZ7JQemK6q1K7TJ17zq4svZjEphvIPGjxiauKW8W9aQDVHV
         tidYWPKWlqk4IM7DA5rrudohG99aimf6TOz4DFaDA/ZjHaK4AGUbFUzImg05TKAgzpWO
         Zs0Eqwq1hvpOzIk8ysRDtN9+nK2LmCHW3MIzf+xz0hDHtLwow/oixLJHnGvcB9QmsRgp
         9E76ar9Q74kXZvJoZiIV2MwEIrceMfmg+BqyaPo7pRd1fGrB394dJjSFBSJZ9d0vwrDe
         S4msrWbiQm1dMQdhOpjLw4jQHejDICF9fTl+DHkpBlxQS/ar4kUhaZn9kN7fzMEF0UT/
         r8MQ==
X-Forwarded-Encrypted: i=1; AL+hErG61WDzL6JwtPPB472I1LUxcTAvLHKl+T+vN8d/8CA3VOgpdWKZivhVYisGDcHP7GKOgu2ByJ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JzHIowN/YAKV0Osx8y2Zd6rLF0JfLGphG+8C70Osv6NrLm+H7
	REhakgNkGtrZShQ9VVEXm9i5PuhHE2P1GFQNpk26QDjVJM9Gm6HxUhop5B+kCU5sg6s=
X-Gm-Gg: AYBFou11YwfUicQOh1183ycfQIDOelDakWHhi+PQQ1hcxIKLzBO2wMtEpSSe8zGow9p
	NlknHKPi0QLJOpwtTA2c+O93Oo14i8SDVF5exa5anB0+LPUPAsOiYqXqGV9sOLC5zpirPZIpHgw
	jOHtQlEcuQyy0NlKWZHSITZA9ie4AmcEEYQO0hPdNDHvHo+9DlcrD8wWuH07K5hJD7bM0Ltf27a
	ppiFQuFg/FJiYJka3P/KSiWC/fRpF6J5IlCexEYjQsE0wXY5m3HaEA4IM1YoRWdYqpKVVnksYHT
	oI6nK4t7b17cEdbDi0BlWNfRWeICAjpRdR0kVZDBmwP357uRBo6Yw3R1RS1N31G+vfy1OY+FjAS
	lAC7/J5rLexEIkPK8T6prpU41Wmq5MQBoXM36NMsc18FwA7pc1InurDKNd0OPnMd/KvVxYqnQnx
	DlT7xNdEZLqKOjyoyh4eRWa1+GWpSn57Jf0ltu+tYBmvKdEHybh2+qxUHWuTP6Fg7ozSKz3GRx2
	fIxhveO5WDiu5uBnyNg4gB78iwfcfGBzuLF/4PeBv3Z2ZocwVaBsF5PzK7LVW4z/rM6ysP32j0E
	lEhjJJTGcyOhmVms5sxoV9uVyShyNYmrW3jWFJGqN18SlKrThdQwCl/gHKqhA/U=
X-Received: by 2002:a05:6402:22d0:b0:6b1:b97b:745 with SMTP id 4fb4d7f45d1cf-6b756af0889mr755303a12.29.1794283086393;
        Mon, 09 Nov 2026 19:58:06 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.58.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:58:04 -0800 (PST)
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
Subject: [PATCH bpf-next 13/15] xdp: add kfuncs to load the stored RX metadata
Date: Tue, 10 Nov 2026 03:57:11 +0000
Message-ID: <1985183a511a2217fe0f42582cbd16f023d8991e.1794281983.git.tianyi@cloudflare.com>
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

A program on cpumap or devmap cannot call the XDP RX metadata kfuncs,
because they need a device-bound program. A program on veth can be
bound to veth, but the veth callbacks return -ENODATA for an
xdp_frame. So a program after the redirect cannot read the values
that the program on the NIC stored.

Add three kfuncs that read the skb core extension area:
bpf_xdp_skb_ext_load_rx_hash(), bpf_xdp_skb_ext_load_rx_vlan() and
bpf_xdp_skb_ext_load_rx_csum(). Each returns -ENODATA when its entry
is not stored. They are in the same kfunc set as the store kfuncs, so
they are not device-bound and need no driver callback. A program on
the NIC can also read back the values that it stored.

The RX metadata kfuncs could return the stored values instead. This
patch does not do that. Relaxing bpf_dev_bound_kfunc_check() for
cpumap is not trivial, and it changes these kfuncs for existing
programs, which read the values from the RX descriptor of the bound
device.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 net/core/xdp.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index fdda072a5858..4df3984479a7 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1081,6 +1081,15 @@ static const void *xdp_skb_ext_get(const struct xdp_skb_ext *ext,
 	return (const void *)ext + off * XDP_SKB_EXT_ALIGN;
 }
 
+static const void *xdp_skb_ext_load(const struct xdp_md *ctx,
+				    enum xdp_skb_ext_id id)
+{
+	const struct xdp_buff *xdp = (const struct xdp_buff *)ctx;
+	const struct xdp_skb_ext *ext = xdp_buff_skb_ext(xdp);
+
+	return ext ? xdp_skb_ext_get(ext, id) : NULL;
+}
+
 /**
  * xdp_skb_ext_to_skb - Set the stored RX metadata on an skb.
  * @skb: The skb that is built from the packet.
@@ -1296,6 +1305,85 @@ __bpf_kfunc int bpf_xdp_skb_ext_del(struct xdp_md *ctx, enum xdp_skb_ext_id id)
 	return 0;
 }
 
+/**
+ * bpf_xdp_skb_ext_load_rx_hash - Load the stored RX hash of this packet.
+ * @ctx: XDP context pointer.
+ * @hash: Return value pointer.
+ * @rss_type: Return value pointer for RSS type, see &enum xdp_rss_hash_type.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-ENODATA`` : the RX hash is not stored
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_load_rx_hash(const struct xdp_md *ctx,
+					     u32 *hash,
+					     enum xdp_rss_hash_type *rss_type)
+{
+	const struct xdp_skb_ext_hash *entry;
+
+	entry = xdp_skb_ext_load(ctx, XDP_SKB_EXT_HASH);
+	if (!entry)
+		return -ENODATA;
+
+	*hash = entry->val;
+	*rss_type = entry->type;
+
+	return 0;
+}
+
+/**
+ * bpf_xdp_skb_ext_load_rx_vlan - Load the stored VLAN tag of this packet.
+ * @ctx: XDP context pointer.
+ * @vlan_proto: Return value pointer for the TPID, in network byte order.
+ * @vlan_tci: Return value pointer for the TCI, in host byte order.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-ENODATA`` : the VLAN tag is not stored
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_load_rx_vlan(const struct xdp_md *ctx,
+					     __be16 *vlan_proto, u16 *vlan_tci)
+{
+	const struct xdp_skb_ext_vlan *entry;
+
+	entry = xdp_skb_ext_load(ctx, XDP_SKB_EXT_VLAN);
+	if (!entry)
+		return -ENODATA;
+
+	*vlan_proto = entry->proto;
+	*vlan_tci = entry->tci;
+
+	return 0;
+}
+
+/**
+ * bpf_xdp_skb_ext_load_rx_csum - Load the stored RX checksum status of this
+ *                                packet.
+ * @ctx: XDP context pointer.
+ * @ip_summed: Return value pointer, ``XDP_CHECKSUM_NONE`` or
+ *             ``XDP_CHECKSUM_UNNECESSARY``.
+ * @csum_level: Return value pointer for the checksum level.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-ENODATA`` : the checksum status is not stored
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_load_rx_csum(const struct xdp_md *ctx,
+					     enum xdp_checksum *ip_summed,
+					     u8 *csum_level)
+{
+	const struct xdp_skb_ext_csum *entry;
+
+	entry = xdp_skb_ext_load(ctx, XDP_SKB_EXT_CSUM);
+	if (!entry)
+		return -ENODATA;
+
+	*ip_summed = BIT(entry->ip_summed);
+	*csum_level = entry->level;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_skb_ext_kfunc_ids)
@@ -1303,6 +1391,9 @@ BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_hash)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_vlan)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_csum)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_del)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_load_rx_hash)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_load_rx_vlan)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_load_rx_csum)
 BTF_KFUNCS_END(xdp_skb_ext_kfunc_ids)
 
 static const struct btf_kfunc_id_set xdp_skb_ext_kfunc_set = {
-- 
2.56.0

