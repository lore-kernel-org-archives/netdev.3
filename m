Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781533DED9
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787778142; cv=none; b=KjRGWke9HXUsMO0lI2OU0Y1J+sSORajDFBs6ywpeOUmyMCsuU2onpUTvO+BRVSFvipmRgUFJqiQkR4/DNKZqsrNKapWBG62ixOx6Ac2SXw9MkrvdHsoNSwkUOk77ml3lrYChl8bvdArjVLLV+yK6pLJtZxcmUEqzbE2uz8JKPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787778142; c=relaxed/simple;
	bh=Os112OekQveuiNBU9YSj4VSTrtTEBEOdyrB8XR5AoXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmOP+MRYKylznvQAtmyABOc6kDtH8azUVW0CVn338I4to9wg/xo/bIDPockCHkO13fj/Wd900aC9ypUbpqYSUqooVS6W+6m8GW6LMkdmQpKIkEZ9EbivBt0P3Zkfi7S9RsdHlaJr4ib+fX8co9mCt6UPBd/o42F5e5RWjdPTuVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DF7D36032B; Wed, 26 Aug 2026 23:02:16 +0200 (CEST)
Date: Wed, 26 Aug 2026 23:02:15 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next] net: Use fixed slots for skb extensions
Message-ID: <ao9UV9S7rUkyQ8jv@strlen.de>
References: <20260825-rfc-skb-ext-fixed-offsets-v1-1-8050ff33bec9@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-rfc-skb-ext-fixed-offsets-v1-1-8050ff33bec9@cloudflare.com>

Jakub Sitnicki <jakub@cloudflare.com> wrote:
> Replace the dynamic skb extension allocator (->chunks + per-object offset[]
> array) with fixed per-id slots with offsets computed at compile time.

Why is that better than

struct skb_ext {
	refcount_t refcnt;
	struct secpath s;
	struct nf_bridge_info b;
	...

?

Yes, initially this was krealloc()'d area.  But the other assumption
was that most skbs will carry no extension at all, or, in some configs
one maybe two (IPsec gateway for instance).

Thats why the first added extension is also at the beginning of the
memory blob (that needs to be accessed anyway), regardless of the ID.

I don't insist on keeping offsets[], if you feel like microbenchmarking
different use-cases to see if it makes a difference to have a fixed
memory layout feel free to explore that.

> The runtime-computed offsets seem to be a leftover from the initial
> posting [1], where skb_ext memory was reallocated when a new extension was
> activated.
> 
> This can make extension delete-then-re-add unsafe, as pointed out by
> Sashiko [2]: with bump allocation, re-adding an extension appends a second
> copy, eventually overflowing the skb_ext chunks area.

This can be solved by not zeroing the offset[] area and fixing
skb_ext_put_mctp() to NULL flow->key.

SKB_EXT_SEC_PATH is fine because it sets sp->len 0, so a
skb_ext_reset() after skb_ext_del(skb, SKB_EXT_SEC_PATH);
doesn't result in any UaF/double-refcount-puts.

skb_ext_add() already re-enables skb->active_extensions if the requested
ID already has its offset[] set.

IOW, offset[ID] = .. reserves the space, it doesn't say the extension is
still active.

> While this does not happen today, because all extensions get dropped on skb
> scrub, the BPF metadata skb extension work aims to preserve an extension
> across skb scrubbing, which opens the door to this scenario.
> 
> [1] https://lore.kernel.org/all/20181210145006.19098-3-fw@strlen.de/
> [2] https://lore.kernel.org/all/20260815081452.0DB521F00A3E@smtp.kernel.org/

Looking at [2] and the original patch:

static int __skb_ext_scrub(struct sk_buff *skb, unsigned int keep)
{
	struct skb_ext *old = skb->extensions;
	struct skb_ext *ext;
	int i;

	if (refcount_read(&old->refcnt) == 1) {
		skb_ext_put_each(old, keep);
		ext = old;
	} else {
		ext = skb_ext_maybe_cow(old, keep);
		if (!ext)
			return -ENOMEM;
		skb->extensions = ext;
	}

	for (i = 0; i < SKB_EXT_NUM; i++) {
		if (!(keep & (1 << i)))
			ext->offset[i] = 0;

Yes, this ext->offset[] = 0 is a problem, but its
not needed, I think. This is enough:

	}
	skb->active_extensions = keep;

(or maybe use &= so as to flag something as active
 that was never enabled).

Regarding skb_ext_maybe_cow() in above function: Why not ..


- Fix skb_ext_put_mctp to be safe against double-put.
- add skb_ext_cow, direct copy of skb_ext_maybe_cow() sans refcount check.
  skb_ext_maybe_cow() retains the refcount check and wraps skb_ext_cow().

After that:

static int __skb_ext_scrub(struct sk_buff *skb, unsigned int keep)
{
        struct skb_ext *old = skb->extensions;
        struct skb_ext *ext;
        int i;

        if (refcount_read(&old->refcnt) == 1) {
		skb_ext_put_each(old, keep);
		skb->active_extensions &= keep;
		return;
	}

This is where it gets interesting.  As LLM generated comment
says, we can get here with old->refcnt == 1: other CPU
changed refcount 2 -> 1 right now (after == 1 was false).

But thats not a problem, since we own a reference, the extension
area will not go away and the likelyhood of this race happening
is rather low anyway. So AFAICS this is fine:

     ext = skb_ext_cow(old, keep);
     if (!ext)
        return -ENOMEM;

Then 'skb->ext = ext' and set ->active_extensions
to the correct value (i.e. clear non-'kept' extensions).

Then call __skb_ext_put(ext).

In case we still have a clone: COW was required, the
__skb_ext_put() detached 'our' skb from the other ext blob.

Other clone will eventually call __skb_ext_put(ext) again
to release resources.

In the other case, the __skb_ext_put(ext) discarded the old memory blob
and all non-keep resources -- the kept ones had inner references (xfrm
states for instance) incremented.

Did I miss anything?  I apologize for not reviewing the initial
patchset, I promise to get to it quicker next time.
