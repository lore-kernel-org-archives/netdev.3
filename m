Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0746F43F09C
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213261; cv=none; b=GuTyQCMTu3ugECGfpn2i4NtFA79iM1qVXkOyY+Q+JyOV0/2VxYEf9SOe1iw4LNL5gzetnNaQGdGdpHdtJT35CdzIOYf3NJ0DARnB3QDY4hrdU/iVY3m3wVRF77VA2P3szC4MmjFnuXX+uTYhTRk1GM7PFP0DGAqFyDbePpR/bbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213261; c=relaxed/simple;
	bh=GAyqNpZOEveX2MDyJxpB/uv0xZcCCOeeqkn5i2fuiPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AurC9CGpdVlJNv2G7QTnqQ1KumxsES/Ye1xwAlytp+P/IQGuC4gidJ8BfFI/prHOdxhMjqb234PJ1/Mci7QxgQV/cdlkxI+I5f6CN7RFiPe88FsdGBSRqQZd8cEdBUyAqXO+ldNsJpBTjR+bysvglF8pNXBkEgkIJ4AFmdpkMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3Uy6L2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3Uy6L2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DA91F000E9;
	Thu, 16 Jul 2026 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213258;
	bh=WA7wUnZjrYaG9/m0fUTQizHLhkivefMVjaWXWQs+wkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3Uy6L2XNLpml+f0sz9mb1K6+JNsOMFkTxGJk2gVFA3bLdBb0aMcl8KdUwNDvFIOK
	 6b3OEO1ydoGag+gb3jiQ6Q8a9ouw1Du+QC6WS3zxJyRTJ+oQfB+NEtnR5QdXlsOPhs
	 q9LtbahTtJjTl8pH8Ivb4sgi5lKKYga+xHXf34wAtqSJcJmKliwgphi2QvfkMGsMxZ
	 O0aSwJmVb3qWgX7ZSWmzsbgaFOc6PtHPAhs0B8ydoihtAm3hg9Cp+k98hONzMCJCBc
	 PRJMO8Ss5pBGrQEJCnHqB20t7LkHlCn5Q/rZIJWte8ywWEVV1XXyPrnWhUIXZsiINx
	 0+Dnn7wF6bUow==
From: Simon Horman <horms@kernel.org>
To: alice.kernel@fastmail.im
Cc: Simon Horman <horms@kernel.org>,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lucien.xin@gmail.com,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	dsahern@kernel.org,
	razor@blackwall.org,
	shuah@kernel.org,
	stfomichev@gmail.com,
	andrew+netdev@lunn.ch,
	fw@strlen.de,
	netdev@vger.kernel.org,
	alice@isovalent.com
Subject: Re: [PATCH net-next v9 2/9] net: Enable BIG TCP with partial GSO
Date: Thu, 16 Jul 2026 15:47:25 +0100
Message-ID: <20260716144724.333095-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710134242.216538-3-alice.kernel@fastmail.im>
References: <20260710134242.216538-3-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [2]: [PATCH net-next v9 2/9] net: Enable BIG TCP with partial GSO ---
commit b8199f77774400021642eb53bd60ec1a062a54ef
Author: Alice Mikityanska <alice@isovalent.com>

net: Enable BIG TCP with partial GSO
    
This commit removes the 65534-byte clamp on segment length in skb_segment
for partial GSO. It stores the gso_by_frags flag early to allow BIG TCP
packets to use larger lengths without accidental resegmentation.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 18dabb4e9cfa0..6ae4c2b205f2e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -4852,9 +4853,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  		/* GSO partial only requires that we trim off any excess that
>  		 * doesn't fit into an MSS sized block, so take care of that
>  		 * now.
> -		 * Cap len to not accidentally hit GSO_BY_FRAGS.
>  		 */
> -		partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
> +		partial_segs = len / mss;

[Severity: High]
When removing the clamp on partial GSO segments, mss is scaled up without any
upper bound. For BIG TCP packets, could this construct segments that exceed
MAX_SKB_FRAGS?

If a 512KB packet is passed to skb_segment() for partial GSO, mss is scaled
up to the full packet length. When attempting to build this single large
segment by flattening the frag_list into a new frags array, it appears it
would hit the fragment limit and abort:

net/core/skbuff.c:skb_segment() {
    ...
    if (unlikely(skb_shinfo(nskb)->nr_frags >=
                 MAX_SKB_FRAGS)) {
        net_warn_ratelimited(
            "skb_segment: too many frags: %u %u\n",
            pos, mss);
        err = -EINVAL;
        goto err;
    }
    ...
}

Does this deterministically drop BIG TCP traffic over tunnels that require
partial GSO?

[Severity: Medium]
Can the partial_segs calculation exceed 65535 for malicious inputs and cause
a 16-bit truncation?

If a crafted packet with a very small gso_size (for example, mss=1 via an
untrusted packet socket) and a large payload is segmented, len / mss could
produce a value greater than 65535.

When this 32-bit value is later assigned to the 16-bit field in skb_segment():

net/core/skbuff.c:skb_segment() {
    ...
    skb_shinfo(iter)->gso_segs = partial_segs;
    ...
}

Could this silent truncation corrupt hardware engine programming or Byte Queue
Limits?

>  		if (partial_segs > 1)
>  			mss *= partial_segs;
>  		else

[ ... ]
