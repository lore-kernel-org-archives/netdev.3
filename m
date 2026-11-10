Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283095;
	b=NqXGtrfga48GFJekA+k1sP6CGlwID9qnAgUuWcFI+rhpN6Sz4iA/ZvGynM1+zjFlo1cX
	 Q4ONCFx2KwJCuUNcSHCUOT6F0kUMrr+BfXeX4I5fD79oO3N/OwpPVGexE1FxJB336HzsZ
	 bOHmxRwrYV3lMMGDK9SZKbsJv30s4okrfPfQq4858oJPNM5F3zam3ujlhSdUPLVSSmhUX
	 mz1PLTwdp4O4xjF6Njqbd3HFOBAS2+Wu0GjNqDB3p7NwkJc8ZaMvogEjYTfSph7cmXRJE
	 kNn+HqsAilr1XFPvxDBIMg7Jd574t2irF4pPQj4WHLLmsTA12jv/IgoeLhH77z+Yktw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PPCb0t5/Stvq5DGUybTkkPxJ34Zyvu9vKlrhKMaUpac=;
	b=234lCFHUZSFMXfm2W+tIsnNQJPT5d6nH28CcrB3JySf2jFHo127DM338HlPfoY3KjtmQ
	 ix/zo2sdtPPaFfWu/Quzyz1KzA/xw/4qmOr71/yaTNaBLQS20bqLdthiUkwMrfoLC9zFi
	 AGVULqi9fzt5UFvj/PWnEa1fJUNvjzHBEy0hxHY9tYNjHoW8+/8KNoH6cXFyCb72Q93Pt
	 SbEHE7owJwXqZMpmIgTxgoLX5HnNiX6NDwSik9amSgw0rRjWCRbJTZMeFDsqbWoTL2Mmy
	 MeohcuD69JNKBg6nCRGEZq42tAbxIJs15BQAWKrv4TptyUEMd9OESarJzNuSOCHSMlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=epYqmSL2;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1260A5BEB
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBC1260A5BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=epYqmSL2
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso2135586a12.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283093; x=1794887893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PPCb0t5/Stvq5DGUybTkkPxJ34Zyvu9vKlrhKMaUpac=;
        b=epYqmSL2vWrGoFjGFxabanfoHEXe7nv2vpNtVRACJTJ6wqZxQWt+2heZo69c0F4jyx
         e+ygwBb+KACLks7keDyjQlLFpX8oUVXmZlhqMXN5BX9b74LhB7if0ol2xpbylIlSNLAW
         VZLAbFp0ayiqJNcpn9lGL/zkO6qAvIumosm8ob4c3nNisY7qZWd+pSXPHUmOuymt+fJs
         ld0wrDgvuobGrmcAmHFuGZvs18EE1Hq0nexMKwACwTIQR8rAQ7mYiT228ch+jpAqBNpj
         6wEgmNFbNU7nBYD91g5dQe6S5lsjvipX0yNt0Y1JeJ7AQ6tLQSeite62+1P5S++B3U/5
         d8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283093; x=1794887893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PPCb0t5/Stvq5DGUybTkkPxJ34Zyvu9vKlrhKMaUpac=;
        b=XQwBzW5/Y8QMsfLySAXBciS83asdBMT8Zyv9QR2pNY97dPBaHDdQiI3R6QdZ7yR6t+
         4KeLboX9bNQf+5bchCRv81mBTVyenvzvpmZbk18nRl5ccxX+Ga1XbJJ6usDVPv2DaI02
         9fraeMsW4bmGmSJMFZZHeRKuhRiOa2Z1NBrSf8bYOsGRj07Eo2RPDt4tPkrFqxesof3q
         T0rK98+DZhFNk1ls87CTKGQmlOuXqGEWIkobokiV3eeaVR3/tpOcVHDAt9BbYuDMTpDu
         MVEpPAkxe7NRK6OXFsvRwTkesApv9iZu/MeoNyUU/dj5QQ0SM5CE5/hlvfBSp5MA8yKl
         6Brw==
X-Forwarded-Encrypted: i=1; AL+hErG6MITzvaOeAHnPc5leYuwOD1A4F+8MkBS9OcCEt0CQvWgwYQ9DIPo8en7omV82M0h44MxDbb8=@vger.kernel.org
X-Gm-Message-State: APuU4Z969ZxEkA5Zag595bJVF7XJ9W6DBjv59DUcSscbMscHc//m5+q3
	NdjTYmvOl4VhLb7PBQ1RRdvohmGllqlxRzBxYaUNxjSXnobxq4Pddided3CNVoWGAds=
X-Gm-Gg: AYBFou0fv9FqQUVCfO5NGeQ95p3rDwW58LzLuHSCVWyaph0PZ+TtzEEejPb2fv+zKyX
	BtRunjR+TzP2t4vHP5zUrgrdjNNQQvPwpOcx/ff2o/1mZYwfvn2fmwWB2SKDfRGob8W55Fx/AAH
	GHtySuhjPQHtwceMIwgGntTmZhw8/eWJxZOrm1b7ZLC47/HwxT+O8G+wUu3ylXF1np/rlFZdSc5
	chbIX1qUMx6AyJUxP3WHg5+zLDTcMxEkjWQJAnNgJx7S7sdTvW9zRReFQ7czk6OxxQgzjWesdm6
	owAoays0wlrSAQbn6sdDPbcy5QDBiY1wpHpnO5egxxVggFcVIN3LUnOeRESrKK/CKZ1vaF0ATc9
	fDw+POw1qaQMvHMI6okQiq9jWk9yyGlmQsLku548op96hIdZm8vk3MZL7nzo6L22BE0oY4xDSKs
	0YuYbssrKChvIvwOmG7YM19a+6I9TAQ0jFtPyR3j6PjBjmH6tuL1QcEmoehA+rab9Y93NbPHlW/
	mosMRpCEQ78SQNdW/CtEsJlmoWcGIuCrosjlkiXeFSUnkbZtqc2udnzauxi9xr4msAqgLnzvATA
	bNMNHMCnmdCoe62+yk644bW4z70QK9Z3xWNo+OP29nowrPi4Q5b9cxR7+5SKq9z2b+haR15nU3o
	Tkv2dqML2
X-Received: by 2002:a05:6402:3603:b0:6b6:ee00:aed9 with SMTP id 4fb4d7f45d1cf-6b756adfec4mr1037528a12.44.1794283093331;
        Mon, 09 Nov 2026 19:58:13 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.58.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:58:12 -0800 (PST)
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
Subject: [PATCH bpf-next 15/15] docs: net: document the skb core extension area
Date: Tue, 10 Nov 2026 03:57:13 +0000
Message-ID: <a37a908598e396446c1a389e3a58a1fe44a514ac.1794281983.git.tianyi@cloudflare.com>
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

Add a section on the skb core extension area to xdp-rx-metadata.rst.
It shows where the area is in the headroom and lists the store, delete
and load kfuncs. It also says when the kernel sets the stored values on
the skb. The Supported Devices section names the skb-ext-pass XDP
feature.

Update the XDP_PASS, bpf_redirect_map and bpf_tail_call sections,
which did not cover the area. Document xdp_skb_ext_to_skb(), the
skb-ext-pass XDP feature and xdp_build_skb_from_frame() in the driver
section, and point to the selftests in the example section.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 Documentation/networking/xdp-rx-metadata.rst | 127 +++++++++++++++++--
 1 file changed, 116 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index efdf5eeb49e7..61dcc24d7342 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -54,6 +54,83 @@ area in whichever format it chooses. Later consumers of the metadata
 will have to agree on the format by some out of band contract (like for
 the AF_XDP use case, see below).
 
+SKB Core Extension Area
+=======================
+
+An XDP program can also store RX metadata that the kernel sets on the
+``skb`` built from the packet. It stores and deletes the values with
+these kfuncs:
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_store_rx_hash
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_store_rx_vlan
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_store_rx_csum
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_del
+
+The values are kept in the skb core extension area. The area starts at
+``data_hard_start + sizeof(struct xdp_frame)``, right after the room for
+the ``xdp_frame``::
+
+  +-----------+-----------+----------------+---------------------+------+
+  | xdp_frame |  skb core |    headroom    |   custom metadata   | data |
+  |           | extension |                |                     |      |
+  +-----------+-----------+----------------+---------------------+------+
+  ^                                        ^                     ^
+  |                                        |                     |
+  xdp_buff->data_hard_start       xdp_buff->data_meta     xdp_buff->data
+
+The area is not an skb extension (``struct skb_ext``) and needs no
+extra allocation. It takes no space until the first store. It holds a
+4-byte header and the stored entries. The header and all three entries
+take 20 bytes. ``bpf_xdp_adjust_head``, ``bpf_xdp_adjust_meta`` and
+``bpf_xdp_pull_data`` do not move the packet or the metadata into the
+area.
+
+The kernel sets the stored values on the ``skb`` in these cases:
+
+- When cpumap or veth builds the ``skb`` from an ``xdp_frame`` after
+  ``XDP_REDIRECT``.
+- When ``BPF_PROG_RUN`` with ``BPF_F_TEST_XDP_LIVE_FRAMES`` builds the
+  ``skb`` after ``XDP_PASS``.
+- On ``XDP_PASS``, in a driver with the ``skb-ext-pass`` XDP feature,
+  see `Supported Devices`_.
+
+On ``XDP_PASS``, the stored values replace the values that the driver
+sets from the RX descriptor. On a native XDP driver without the feature,
+the kernel warns once when the program returns ``XDP_PASS`` with stored
+values. When XDP runs on an ``skb``, in generic XDP or when veth receives
+an ``skb`` from its peer, the kernel does not set the stored values on
+``XDP_PASS`` and also warns once.
+
+The program that stores the values can read them back. So can the
+programs that run on the ``xdp_frame`` after ``XDP_REDIRECT``, on cpumap,
+devmap and veth:
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_load_rx_hash
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_load_rx_vlan
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_load_rx_csum
+
+They return only the stored values. The RX metadata kfuncs above still
+read the values from the RX descriptor. Unlike those, the kfuncs in this
+section do not need a program that is bound to a device.
+
+On ``AF_XDP`` zero-copy, the store kfuncs return ``-EOPNOTSUPP``, because
+user space can write the headroom. The area would not reach the skb
+anyway. On ``XDP_REDIRECT``, ``xdp_convert_zc_to_xdp_frame`` copies only
+the custom metadata and the packet. On ``XDP_PASS``, drivers do not apply
+the area.
+
 AF_XDP
 ======
 
@@ -83,12 +160,13 @@ This is the path where the packets processed by the XDP program are passed
 into the kernel. The kernel creates the ``skb`` out of the ``xdp_buff``
 contents. Currently, every driver has custom kernel code to parse
 the descriptors and populate ``skb`` metadata when doing this ``xdp_buff->skb``
-conversion, and the XDP metadata is not used by the kernel when building
+conversion, and the custom metadata is not used by the kernel when building
 ``skbs``. However, TC-BPF programs can access the XDP metadata area using
 the ``data_meta`` pointer.
 
-In the future, we'd like to support a case where an XDP program
-can override some of the metadata used for building ``skbs``.
+On drivers with the ``skb-ext-pass`` XDP feature, an XDP program can use
+the `SKB Core Extension Area`_ to override the hash, VLAN tag and checksum
+status of the ``skb``.
 
 bpf_redirect_map
 ================
@@ -100,18 +178,19 @@ access to the original hardware descriptor and can't access any of
 the original metadata. The same applies to XDP programs installed
 into devmaps and cpumaps.
 
-This means that for redirected packets only custom metadata is
-currently supported, which has to be prepared by the initial XDP program
-before redirect. If the frame is eventually passed to the kernel, the
-``skb`` created from such a frame won't have any hardware metadata populated
-in its ``skb``. If such a packet is later redirected into an ``XSK``,
-that will also only have access to the custom metadata.
+This means that the initial XDP program has to prepare the metadata
+before the redirect, as custom metadata or in the `SKB Core Extension
+Area`_. If the frame is eventually passed to the kernel, the ``skb``
+created from such a frame gets its hash, VLAN tag and checksum status
+only from the area. If such a packet is later redirected into an
+``XSK``, that will only have access to the custom metadata.
 
 bpf_tail_call
 =============
 
 Adding programs that access metadata kfuncs to the ``BPF_MAP_TYPE_PROG_ARRAY``
-is currently not supported.
+is currently not supported. The kfuncs of the `SKB Core Extension Area`_
+do not have this limit.
 
 Supported Devices
 =================
@@ -120,6 +199,12 @@ It is possible to query which kfunc the particular netdev implements via
 netlink. See ``xdp-rx-metadata-features`` attribute set in
 ``Documentation/netlink/specs/netdev.yaml``.
 
+A netdev that sets the values from the `SKB Core Extension Area`_ on
+``XDP_PASS`` in native XDP has the ``skb-ext-pass`` flag in its
+``xdp-features`` attribute. The flag does not cover generic XDP or the
+veth ``skb`` path. An XDP program can also read ``xdp_features`` of the
+receiving netdev after ``bpf_cast_to_kern_ctx``.
+
 Driver Implementation
 =====================
 
@@ -153,9 +238,29 @@ xdp_frame. If these conditions are not met, it returns a negative error. In this
 case, the BPF program should not proceed to populate data into the ``data_meta``
 area.
 
+A driver that builds the ``skb`` on ``XDP_PASS`` applies the
+`SKB Core Extension Area`_ and sets ``NETDEV_XDP_ACT_SKB_EXT_PASS``. The
+driver sets the ``skb`` fields from the RX descriptor and then calls this
+function. The driver takes the area pointer with ``xdp_buff_skb_ext``
+before it reuses the ``xdp_buff``:
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: xdp_skb_ext_to_skb
+
+``xdp_build_skb_from_frame`` does not apply the area. Its callers set the
+RX fields themselves or transmit the ``skb``.
+
+A driver that moves ``data_hard_start`` after the XDP program ran calls
+``xdp_buff_clear_skb_ext_flag``, because the area is no longer at the
+expected place. The stored values are then lost.
+
 Example
 =======
 
 See ``tools/testing/selftests/bpf/progs/xdp_metadata.c`` and
 ``tools/testing/selftests/bpf/prog_tests/xdp_metadata.c`` for an example of
-BPF program that handles XDP metadata.
+BPF program that handles XDP metadata. See
+``tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c`` and
+``tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c`` for the skb core
+extension area, and ``tools/testing/selftests/drivers/net/hw/xdp_metadata.py``
+for a driver on ``XDP_PASS``.
-- 
2.56.0

