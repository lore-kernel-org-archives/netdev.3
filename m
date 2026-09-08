Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5C582B93
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907750; cv=none; b=ZDJ5jrWdXzGHmuDKZEDjgokmR9DanycZAIuoZljqlG5XbL4FKyx0GjH1zbWv7hoBcjjWhxNc9XnHq9pmrObvypGSucFIr+Xh5+YS4O8wv6IHibTcBISjBgxn0U0HozvKmvv/LFjzZ88Svz9mij3GBX30lm2S3I7rYaxvbf8V1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907750; c=relaxed/simple;
	bh=ku+e3bL4x+lBaR38skWN9xOr6YJV5nqgmOXTqVqgzr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ4BSNQy7XQhwXDkxC8uSzQbuk2L0y1uP2igKb3/gDdE69mM28Y/WUhggu0LSMhDNAmvaXsnE05vEM6R801CwStPXstGiC92s0jqLqF5ItZU30kJGzvPNSsb44B4OTW3jxvC6yXEX8qwxQG7IF4ze8P8CF3RwK2T7F9SUhNgGrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEg/RN3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEg/RN3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C191F00ACF;
	Tue,  8 Sep 2026 22:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907740;
	bh=rNFZWPUX7VzhiE7GiFS3Bc2KDOzjY6DHV7+CQNRJXyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aEg/RN3d97Op9GBwrscRBC46boXETZgiFI4vHRGQ1jGNUHS0yvJ6qMiySVS8lx565
	 1H4MuuzYXoySh/FHndngs31/ek/HSYli4OjOxyT6CtrBNearqfDfKqOPp0ulyx6P1O
	 UG5iCXaT1eif/RrQvkjQaBAjGZVeWZj8brxjPpV853czfZXJHbh8ccWltOwkuCgB8r
	 TI9+cfNeX3Ci+/XL3SKPPOhXEHtdUqLodPl6HGvFNdPfu2NJOceXzMHoLp++ii60aR
	 wcSA8mXiJIL9PQjdR5CmmD18hzoyYC9CB8Gt5O4/zFJ1Kys9thu4ivR7baIqC10Ahx
	 8GjSmiIxmSwQA==
From: Jakub Kicinski <kuba@kernel.org>
To: steffen.klassert@secunet.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	netdev@vger.kernel.org
Subject: Re: [PATCH 09/12] esp: downgrade zerocopy managed frags before mutating skb frags
Date: Tue,  8 Sep 2026 15:49:00 -0700
Message-ID: <20260908224900.1591301-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907093020.2228346-10-steffen.klassert@secunet.com>
References: <20260907093020.2228346-10-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
esp: downgrade zerocopy managed frags before mutating skb frags

This adds a skb_zcopy_downgrade_managed() call to the out-of-place ESP
output path in esp_output_head() and esp6_output_head(), so that the frag
array is no longer mutated while SKBFL_MANAGED_FRAG_REFS is set.  Real
page references are taken on the existing frags before ESP appends its
trailer frag.

> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index a6c18aea7498d..e76db5817e78e 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -441,6 +441,12 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
>  
>  			esp->inplace = false;
>  
> +			/* Take real page refs and clear SKBFL_MANAGED_FRAG_REFS before
> +			 * we mutate the frag array, so the per-frag unref stays balanced
> +			 * for zerocopy managed frags (see __ip_append_data()).
> +			 */
> +			skb_zcopy_downgrade_managed(skb);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the sibling xfrm
transform need the same treatment?  ipcomp_post_acomp() in
net/xfrm/xfrm_ipcomp.c rewrites the frag array too, and there is no
skb_zcopy_downgrade_managed() anywhere under net/xfrm/.

ipcomp_setup_req() has a fast path that deliberately avoids any cow, so
the implicit downgrade inside pskb_expand_head() never runs:

net/xfrm/xfrm_ipcomp.c:ipcomp_setup_req() {
	...
	if (!skb_cloned(skb) && skb_headlen(skb) >= minhead) {
		if (!skb_is_nonlinear(skb)) {
			nfrags = 1;
			break;
		} else if (!skb_has_frag_list(skb)) {
			nfrags = skb_shinfo(skb)->nr_frags;
			nfrags++;
			break;
		}
	}
	...
}

ipcomp_post_acomp() then drops the old frags and installs its own pages:

net/xfrm/xfrm_ipcomp.c:ipcomp_post_acomp() {
	...
	pskb_trim_unique(skb, 0);
	__skb_put(skb, hlen);
	...
		skb_frag_fill_page_desc(frag, page, 0, len);

		skb_shinfo(skb)->nr_frags++;
	} while ((dlen -= len));
	...
}

Since the skb is not cloned here, ___pskb_trim() takes the drop_pages
path, and skb_frag_unref() is a no-op while SKBFL_MANAGED_FRAG_REFS is
set, so the flag survives the trim.  The pages installed afterwards come
from alloc_page() in ipcomp_setup_req(), i.e. they carry real references.

At release time skb_release_data() then skips the unref loop:

net/core/skbuff.c:skb_release_data() {
	...
	if (skb_zcopy(skb)) {
		bool skip_unref = shinfo->flags & SKBFL_MANAGED_FRAG_REFS;

		skb_zcopy_clear(skb, true);
		if (skip_unref)
			goto free_head;
	}
	...
}

Does this leak the compression output pages, one or more order-0 pages per
transmitted IPComp packet?  That looks like the same failure mode the
commit message describes for ESP ("leaking the x->xfrag page at packet
rate"), just reached through IPComp instead.

[Severity: Medium]
This is a pre-existing issue, but the patch adds a second irreversible
side effect at the same point, so it may be worth handling here.

esp->inplace = false is committed (and now the downgrade as well) before
the allocation that can fail:

net/ipv4/esp4.c:esp_output_head() {
	...
			esp->inplace = false;
	...
			skb_zcopy_downgrade_managed(skb);

			allocsize = ALIGN(tailen, L1_CACHE_BYTES);

			spin_lock_bh(&x->lock);

			if (unlikely(!skb_page_frag_refill(allocsize, pfrag, GFP_ATOMIC))) {
				spin_unlock_bh(&x->lock);
				goto cow;
			}
	...
}

On the refill failure, should esp->inplace be restored to true before the
goto cow?

The cow path calls skb_cow_data(), which pulls all paged data into the
linear area via __pskb_pull_tail(), and since the branch required
!skb_has_frag_list(skb) it returns with *trailer == skb.  pskb_put() then
only extends the linear region, so the skb leaves esp_output_head() with
nr_frags == 0 and data_len == 0.

esp_output_tail() still branches only on esp->inplace:

net/ipv4/esp4.c:esp_output_tail() {
	...
	if (!esp->inplace) {
		int allocsize;
		struct page_frag *pfrag = &x->xfrag;

		allocsize = ALIGN(skb->data_len, L1_CACHE_BYTES);
	...
		skb_shinfo(skb)->nr_frags = 1;
		page = pfrag->page;
		get_page(page);
		__skb_fill_page_desc(skb, 0, page, pfrag->offset, skb->data_len);
	...
}

With data_len == 0 the refill of size 0 succeeds trivially, nr_frags is
forced to 1 and a zero-length frag is installed with an extra page
reference, while pfrag->offset is not advanced.  Can this hand a zero
length fragment to the driver, and issue the out-of-place AEAD request
with src and dst scatterlists that both describe the same linear buffer?

>  			allocsize = ALIGN(tailen, L1_CACHE_BYTES);
>  
>  			spin_lock_bh(&x->lock);
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index 72ec0d7d11209..b1c9b36f76dc4 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -471,6 +471,12 @@ int esp6_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
>  
>  			esp->inplace = false;
>  
> +			/* Take real page refs and clear SKBFL_MANAGED_FRAG_REFS before
> +			 * we mutate the frag array, so the per-frag unref stays balanced
> +			 * for zerocopy managed frags (see __ip_append_data()).
> +			 */
> +			skb_zcopy_downgrade_managed(skb);
> +

[Severity: Medium]
This is a pre-existing issue, but the same missing esp->inplace rollback
applies to the IPv6 path: esp6_output_head() commits esp->inplace = false
before the skb_page_frag_refill() that can goto cow, and esp6_output_tail()
branches only on esp->inplace.

For reference, net/ipv4/esp4.c and net/ipv6/esp6.c are unchanged in the
rest of this series, so the stale esp->inplace behaviour is still present
at its end.

>  			allocsize = ALIGN(tailen, L1_CACHE_BYTES);
>  
>  			spin_lock_bh(&x->lock);
