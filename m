Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144990;
	b=1ZS3HfQ59U58vfOw2YYIHt7C6RgKyZulxWs8UHhkjrlb5J4k1r1e2bzmZqSHwhVLO12i
	 k+YMVatmc4NHjGpF8Je3/JxxuZ/5Vm7TyyGysG/wAt9PJhHtE6I2853LDvxyXslyn68OY
	 GNHbX00dSoiidH7d6nAm6K5tmQn8VleEtm9vGLi/xRGfZiSfUB3quF0/ynUGC2DfDXlwQ
	 R32MQFhvsGcmGe1FzK6UsMp/VVyzhe/AWwh/SEQqHloR+7jJWysXg8dGaTRGwMic+W7xK
	 VO+lBghB81SVtmMpakzNYLCb8ZvMs+bXOeSsdvCz6I8RXvd0KzOTiwidV7oY6OzFlkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144990;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ShbOX/cjqpDQHsFAgVcnNKlAvBdTBnGGbBD6Ol86WBQ=;
	b=DFV89eRwu7RHchsi9fSSaEkPfA5Sb1GsyWatoDy5eLb0iNF1Oj+ldIha71jWZGtdK3wM
	 PO1sc82ZD0BOteO16I9nfWBnBt3W3+FUKtzoEhn/OvjAtYGY0S4yIcWF3jgEelyvDPX1T
	 327USNpjCZEG0nC8mFInkc38dP/WerzhI6b7AnU/aQXOk45EGbE9ZlUzv4SmnSSDpLj3+
	 QCxih/H6lJjlBwjopoX+Dlv2NqTpKyD/L1R+m8Z1T+cPXC8mS8W0N2YvYIL8KYd6mYEKg
	 PzVdHjF8//VTAJKx4YottAG10bOcmZgT/g3qXtKZiQJh/O/dR+KmiUF3mlIFZ86DTHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWOocQMF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AC606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWOocQMF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C041F031E1;
	Tue, 27 Oct 2026 23:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144990;
	bh=ShbOX/cjqpDQHsFAgVcnNKlAvBdTBnGGbBD6Ol86WBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cWOocQMFnz4eh6JpsrlbOXN6Geysf9Oyw3FbndhFX8ylMbSnddgUjUTcX/+VRKLuI
	 L5oWhy+TVon3F+QW+mxIUS1R/Ul1oZ2/ik7Zft9DwJqlQ3QsD9aLwPpozpHuyjnc5i
	 rWMQ13Wjwg5j8cjoVwenZplnG9NL0iNWEIsKbcKmkS/u7KVHTXgNO1dB6UWM6L2Fhv
	 tmnThchiNYw3ylsykPkhjQVIPhI5obAqwEYDoNjkGuf99OJkIruIL3R+6Ff+wVLVHc
	 JHR3PmG95KdoCam7HG12ZXUqhM+Pwy9pUjoNxYSoL7bKiBRkN0AFqrxg47WRpvd3EM
	 /51ZUMMtZsXBQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	eddie.wai@broadcom.com,
	prashant@broadcom.com,
	huangjw@broadcom.com,
	gospo@broadcom.com,
	brett.creeley@amd.com,
	ap420073@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 5/5] eth: bnxt: hand XDP frags over to the copybreak skb
Date: Tue, 27 Oct 2026 16:49:40 -0700
Message-ID: <20261027234940.1267225-6-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027234940.1267225-1-kuba@kernel.org>
References: <20261027234940.1267225-1-kuba@kernel.org>
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

With a multi-buffer XDP program attached, a packet only has agg
buffers if it filled its head buffer, which in page mode holds most
of a page. The program can still move the start of the packet forward
with bpf_xdp_adjust_head() and leave at most rx_copybreak bytes in the
head. bnxt_rx_pkt() then copies the head into a new skb, puts the head
page back on the ring, and calls bnxt_xdp_build_skb() on the copy.
bnxt_xdp_build_skb() only sets nr_frags and the skb's length
accounting, because it expects an skb built around the head page,
sharing its shinfo with the xdp_buff. The copy ends up with nr_frags
set but no frag descriptors, and the stack later reads and releases
whatever its frags array happens to contain. The real frags leak.

Copy the frag descriptors to the new skb in bnxt_copy_xdp(), so that
bnxt_xdp_build_skb() finds the frags where it expects them. The frags
now belong to the skb, and the head page goes back on the ring as
before.

Pointed out in LLM review of the first patch of the series.
Confirmed by reading the code, the unfixed kernel was not run with
the reproducer below.
Tested on a BCM57504 at MTU 9000 with rx-copybreak raised to 1024
and a frags-capable XDP program moving the start of multi-buffer
frames 3000B forward with bpf_xdp_adjust_head(), receiving 8000B
ICMPv6 echo requests (a head and two agg buffers each). All 60k
frames took the copybreak path with frags attached, the sampled skbs
reached GRO with len=4998 data_len=4492 nr_frags=2, and were freed by
the stack with the page pools' inflight count staying flat, no KASAN
or DEBUG_PAGEALLOC splats.

Fixes: 1dc4c557bfed ("bnxt: adding bnxt_xdp_build_skb to build skb from multibuffer xdp_buff")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4607c31eedf8..757c7266ce15 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1511,6 +1511,14 @@ static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
 		__skb_pull(skb, metasize);
 	}
 
+	if (unlikely(xdp_buff_has_frags(xdp))) {
+		struct skb_shared_info *sinfo;
+
+		sinfo = xdp_get_shared_info_from_buff(xdp);
+		memcpy(skb_shinfo(skb)->frags, sinfo->frags,
+		       sinfo->nr_frags * sizeof(skb_frag_t));
+	}
+
 	return skb;
 }
 
-- 
2.56.0

