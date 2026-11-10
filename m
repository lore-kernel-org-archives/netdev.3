Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283049;
	b=B/Du2KfBNuQG2rDktwHaqV6FpVHLScLYxBveCjlCEsAkC9/7xPKjLIStf8M9yyLjdSeA
	 61kTMcOF4bGHFkjPkv8X1hUSaTcf+23m2+pPpC9vwbDZV6lf4AU779wtFHW6XbhyYkyoN
	 0BXG+/Xg9XFUSWOVTZcGbv9GtR1D16kLDJVh3YYQOjqTR4NMcuAqzCwBPgQlnUSWdXDDm
	 8LNF6A38sRsVGZ4tBTMMdd1JgVKKy2hSbaB2rG2VxOMK/YbPTGJC0jJZar9C/b7hzjobQ
	 TPcrB4gCks7nHz2QVPwC6DTNBrEBo9IJMIx7jv27vTO91EPR6D/NdcOYzLNZVHQ+qWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=L0xaW/62AQgxFhpajczQ88yBj65kDwjYHTXkn62rfdI=;
	b=wRqpVKiyBLU16usbkCWycViXQ4w3I6x1YdH65MABF/N9kmsJbdKIMzEWws2gBRg0J97f
	 +/JjP6d7G1W3feyPGg4gU/sbJdl/SswsCCzTgH6B4DsBBazfGI0N0ScQ3qGHwuyU9kbmu
	 4UG6K3rvfxbED5hT9opFFqj/sIhkywWPDEQl/vRslClv/PQgwlVsQMFrPw+VwpmrnTocB
	 acTgFITw4PKTA8aKB6xY/8hCZp4Y4Zl/NeMc+2sHMiCbJe2ZSG/vj4AOkamA/AUGo3Ana
	 IEdWv4vjhXvi4bGidPIQyOfjqi+LJJznMyBPxVMNBJG4UlSqut4x28BxAKO9eqYdZ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=B3UO6mYx;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE46606A33E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE46606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=B3UO6mYx
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so1828415a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283047; x=1794887847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0xaW/62AQgxFhpajczQ88yBj65kDwjYHTXkn62rfdI=;
        b=B3UO6mYxBrwbI4EnQx2MJCfYep/7lzLJy9J27S0G6O4GvtAuldRznLGKrqfTHxZKwy
         8pAtP29K6ylA0zEHKeGYXZl1w2XVzbwIam1ss5NxCX8JGel0U2a4/TGaXtIpR0G132A3
         SIjYqB5LYtz5aXQMa7VQHXjfgmJr3DFNg2bM/m4fG7KjNqLt2FW6m7RDwNDQASs5rDSZ
         kXe3in7HjpLK7qHJkb78nOsZ3g1a7uDFw77n7dsnwPZbZ1CFq2cf20jyuaq6hsoc83El
         MitOrxLYK+ko289aXFEf6w8Z4VKwqe8agX/YQQyNSRqsQLap+MgSPkjtzgAl0JWzJaWj
         k/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283047; x=1794887847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0xaW/62AQgxFhpajczQ88yBj65kDwjYHTXkn62rfdI=;
        b=tJlIEiZ7PrLoXrEPHcAA1Zj6Gc0toPPHM5NTrgnejkEhCCh+3oTrO65rQEzyxt61fA
         R1o1fiSXusdLgkXlq8Zr+/2PN7scAVLPmgo6/cNpfh7nXd1o8H2PO5HpiGH59MpZr9Jq
         vdlMgMhFx/UMnUVdOrlbFJVsrn5+ultP2Rtvac9CYYdrv+7nsJbriZuV7UW0QHm77v6Q
         f/kdVUM+5H5SnZq2Wv1bNTgXY8eP7bMX5EHPiDBQ+0kCEV3B6CpgXT1oUtLBWPB3izEr
         bTMPPH59L6rCFBFUHYvhywCotmOtCcW2LgIgM+VUR1qUuF1CFZEjGEgvVnvjZZZSPwX3
         xH8A==
X-Forwarded-Encrypted: i=1; AL+hErGlHiqroInDzKydVwKkNvWpt/8xxjv3xbkcZjEaEJ9GKC8ZAaRMJNpkX7vIsL6mGFz7HVR6I+o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PRJ/mFW+aIhqtOpAvVLj9GU6lNQOT7wjSTOKlOAaRcLm65MWh
	pTC8CBhUA0mYXucR2wD3++GLD5zaQ8kR7u9sjDPSM/xu4JjRKbncfsRkVavAu3nEHHw=
X-Gm-Gg: AYBFou2C+7P551HAws3Vx9Z8P49lyrIHIlN5k0gjYkEJBjfVTgI/KiNLuNYm5k6dM1I
	wpvtjOnvRNSWIsGexo474WS1h0Khmae9rzqlWeWgDffL4Mey3P/7z93cQZbAEvyfOWknf/XFpky
	xOryItUSHFaZENpdJMKdBWPwyh+r7X1t7yx0/S/EsDUoeyNALirSPwhjtWSfDTWn0HQG73hUBnq
	SgBNAKyf4r13gUNt+PaJoDxRM5ORZXzEprVtMxTFtJPsIN/aU+/tUPFXCA4kxnqrHGze1HXmUwD
	BhQc1lXoA+DgCpEllFb1MvIaNck9rRlkmrKwLBEN8Zr8Nw/dGa0BpuidL4R6VIWLdEIost/V8eu
	iiEik52e68QqvZAGb0W78Fs1rCcWoCM4n4Du5Uovr3dYhSFYvahgUEShmRZPCLw5/vjrpVSWGD5
	2v7QL4uQV7FKa9ELjiaoGQ3UY+au4TdrR6NeVtWP7j+wJpKXiy39mRNNHfXRjGTtE6Texq09l78
	UEP/FEcAhf6A8+Eq5jB6GnDMYWb60gGNpcEDgXQZrFOkI1gBcLVJqSFaZXy1Sie/2E4qOnUMmHH
	V3iThWWGoG9wainmJT5f0ZmIrWiSk24CRmoqHRsPRCC3wZAd/RSAcMlU4aCSweAFM5qdWAG7Bwd
	EWcbDzQN8
X-Received: by 2002:a05:6402:c4d5:10b0:6b1:d344:c62a with SMTP id 4fb4d7f45d1cf-6b756ae6169mr667065a12.30.1794283046684;
        Mon, 09 Nov 2026 19:57:26 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:57:25 -0800 (PST)
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
Subject: [PATCH bpf-next 02/15] net: dpaa, dpaa2: clear the skb core extension flag
Date: Tue, 10 Nov 2026 03:57:00 +0000
Message-ID: <bff7f72c7c28f67497e23a6629b9e4db74332da6.1794281983.git.tianyi@cloudflare.com>
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

dpaa_run_xdp() and dpaa2_eth_run_xdp() move data_hard_start to the start
of the buffer after the XDP program runs and before XDP_REDIRECT.
xdp_skb_ext() then returns a different address from the one used while
storing the entries. These drivers have not implemented the XDP RX
metadata kfuncs. Hence they now clear the XDP_FLAGS_HAS_SKB_EXT flag
before XDP_REDIRECT, and their redirected frames carry no stored entries.

With the A050385 erratum workaround, dpaa already moves data_hard_start
before the XDP program runs, so the entries remain valid. The flag is
cleared on that path too, to keep the change simple. This can change
when dpaa implements the XDP RX metadata kfuncs.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 2 ++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index ad2d8256eb8d..4cafc0b84dc9 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2654,6 +2654,8 @@ static u32 dpaa_run_xdp(struct dpaa_priv *priv, struct qm_fd *fd, void *vaddr,
 		/* Allow redirect to use the full headroom */
 		xdp.data_hard_start = vaddr;
 		xdp.frame_sz = DPAA_BP_RAW_SIZE;
+		/* data_hard_start moves, so the stored entries are lost */
+		xdp_buff_clear_skb_ext_flag(&xdp);
 
 		err = xdp_do_redirect(priv->net_dev, &xdp, xdp_prog);
 		if (err) {
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 7227a35dfaf2..fcefdc9daf2b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -472,6 +472,8 @@ static u32 dpaa2_eth_run_xdp(struct dpaa2_eth_priv *priv,
 		/* Allow redirect use of full headroom */
 		xdp.data_hard_start = vaddr;
 		xdp.frame_sz = DPAA2_ETH_RX_BUF_RAW_SIZE;
+		/* data_hard_start moves, so the stored entries are lost */
+		xdp_buff_clear_skb_ext_flag(&xdp);
 
 		err = xdp_do_redirect(priv->net_dev, &xdp, xdp_prog);
 		if (unlikely(err)) {
-- 
2.56.0

