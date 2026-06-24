Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9D302742
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315958; cv=none; b=hDJegVSal0P5EnSZ0gpg7Ox19fdBz6HEEEw5w2OmZIYuwVlv4gyug3xw1pRQx+hrEnmN84QZqzvpipcZr9GDJSa72FVMmZFD/Ku9z/6FnNdi591/Jr+XeW7mMfBvjddNWPk22DuFO4iwpLv/zHEg38WnEh94pS5wPs4XrlCX4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315958; c=relaxed/simple;
	bh=XS4cXPoFYvBnGja9W7ZfoGm9rgCHoBtJF3SZvGBRGag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrjT6Y7Abvo5oP+PiiWbdz3Msu9JekjK4rQAHkzwREoN8uYir5Lsj61NcNBliM4btNa1YI91nOpedjL8IDOpTWDEv7enTb+IBEthWKztm3HPjo9giK2iuVCtf7pPb7zbaBCKoaDen5QlqXhvpTi0urSKvzuCiCSe1jx9cAmiDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C64OKh33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C64OKh33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356F81F000E9;
	Wed, 24 Jun 2026 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782315956;
	bh=5raUOPHCS85WUgQHYMDf0LuoM3ZQ2QYkF6jPBJ4qiTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C64OKh33mZ6EORsDD7WBtCyXRckNlNqFsMCbxBD1MiVAAnaNOvSkEQldjiRPXGoDN
	 tJiGvVyOqiNoTXTeCxfTPGrrldCcIAVoRyfVac3gn2JUKa2qdl4YLFBJzAWLFQ8bDD
	 NTzCoRQSUdQd3P3bJGMcTizlDG7rCHGP3EMs1PRIv/jNqxa9Jfo6iPSBJ5iFpXL7t8
	 uIjMtb22cOUeH2Y6GM9JrG5QtuZLX71RzMMSWE2aOR+R5HDI5yj7O7pi+wgL1uzZXh
	 PJnchlJ5IWP/G1VyQDmjYfPS8Uerbul2pwE9bUmAxGUXc5XRUZJwJcwuQL+UHZV/Oy
	 rFjMBgTYa0g3w==
From: Simon Horman <horms@kernel.org>
To: 635381823cyj@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	moomichen@tencent.com
Subject: Re: [PATCH] xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()
Date: Wed, 24 Jun 2026 16:45:31 +0100
Message-ID: <20260624154531.1140374-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623092258.70507-1-635381823cyj@gmail.com>
References: <20260623092258.70507-1-635381823cyj@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()

This patch sets SKBFL_SHARED_FRAG on the destination SKB after
iptfs_skb_add_frags() transfers frag references from a frag walk, to
prevent ESP's no-COW fast path from decrypting in place over pages still
referenced by the outer IPTFS SKB.

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index ad810d1f97c0..0e0dcf47a470 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -496,6 +496,10 @@ static int iptfs_skb_add_frags(struct sk_buff *skb,
>  		walk->past += frag->len;	/* careful, use src bv_len */
>  		walk->fragi++;
>  	}
> +
> +	if (skb_shinfo(skb)->nr_frags)
> +		skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
> +
>  	return len;
>  }

[High]
Does this placement cover every path that adds frags to the destination
SKB?  The new assignment sits after the while loop, but the loop has an
earlier exit that returns once the requested length is satisfied
mid-frag:

    while (len && walk->fragi < walk->nr_frags) {
        skb_frag_t *frag = &walk->frags[walk->fragi];
        skb_frag_t *tofrag = &shinfo->frags[shinfo->nr_frags];

        *tofrag = *frag;
        if (offset) {
            tofrag->offset += offset;
            tofrag->len -= offset;
            offset = 0;
        }
        __skb_frag_ref(tofrag);
        shinfo->nr_frags++;

        /* see if we are done */
        fraglen = tofrag->len;
        if (len < fraglen) {
            tofrag->len = len;
            skb->len += len;
            skb->data_len += len;
            return 0;
        }
        ...
    }

By this point __skb_frag_ref(tofrag) has run and shinfo->nr_frags has
been incremented, so frags have been attached, but the early return 0
bypasses the new SKBFL_SHARED_FRAG assignment.

The caller iptfs_pskb_add_frags() typically requests fewer bytes than
the current source frag holds, so this early-return path is the common
termination of the loop.  In that case the destination SKB still appears
to ESP as having privately owned frags, and the nested transport-mode
esp_input() no-COW path described in the commit message can still
decrypt in place over pages referenced by the outer IPTFS SKB.

Would it be more robust to set the flag immediately after
__skb_frag_ref(tofrag) / shinfo->nr_frags++, or duplicate the assignment
before the inner return 0, so every path that attaches a frag also
propagates SKBFL_SHARED_FRAG?
