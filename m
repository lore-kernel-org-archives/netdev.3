Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABB446C1B
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833492; cv=none; b=R+WpFBlCCB2Mk9dLQ1NWTXu2hhrFWyJMFDkq3px2jyX3bzwsnSzVJCbUNA/adAT3aGF3ZX8b3KN1KWkB77HbDpVxAxezyyBGQShTrPdwPzu5RD/vooQKcX61lR+G1BaOixgETxqFukYyH4NZ449kKRO6Dtq59xSKyougvXeRRgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833492; c=relaxed/simple;
	bh=8IF4CdIH3KpfM2ZLXcbf0RgQMlb9Gx4haSOXuH/u4ag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qL3NYD/lkAQAaGZrUmmakXf/UI/u8rpaGyWMfWbaLKPI3rW9DAd5p/zEJ0ipLmsZlAj04mH6etXc1Bbwx1IcWxuz0iVzHaj1A43044ApUtgHb0QCbJMMetdR2bKkVevIOtkxYfEcSDfsv9j3fXksuwpV3SBYuLlBfVhmie8Fg/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QaM43rgy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QaM43rgy"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso3457454a12.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 05:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787833485; x=1788438285; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VwE4FUlUwYF4ltlFELh7b7kth2ENOgg6lcHSlnMrQXg=;
        b=QaM43rgyECOmtbBOhUK6HWJu1D81ce2CX/3mAfOLlo6egxWheaI2/V++8CiBE2dS6n
         dXBpwyivoZXdUGTkxkhyE4wc9JqqGV7gZfqAcOVm6a8dRO3tdvPuzMVHpISrhK4KHDOl
         XvN5sijoyYEyJBen8yhIuBAu+45e9IrlltIVX40T6h0SCoq1YsaZeK4AJOtmetUnyCmW
         Mh8rpa+HLmaB/GKzM74y5GDWCXkJ9zPqMNvolX92UpY4siojFUJwQvyLuyucJSvNZFHY
         68iKJM/cDk7a1qLtZ5WdlNE8Q5nDNLJdci2SDoA7cVUBLc0wx/ybXRTiKjjydxGbykUB
         qSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787833485; x=1788438285;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VwE4FUlUwYF4ltlFELh7b7kth2ENOgg6lcHSlnMrQXg=;
        b=fonDa2LHgPCvzfU9mGf2p2PfB37ulALoPauAZzDc3czx+TbKZqF/ZuLNODVurHtKMe
         viil+Q2S5dCRGYlzZrstJFajzFtLb8qx4q2RQwM5CTafDciwJe2Cg0ib2sFlTaQaza3m
         tLd7wlabRI1YZCE/at80AXK8kEzPl4ZC9lIIl5dylnxMK0G4gVdoF/MNFbFS6w9inFUe
         bG6bYth1sDs1CUbVh+HCM2ebCWMi9k0CkGU2PhOfz2AYlWlS04/QLpIlxnT9LJl8Pal+
         doKi5AWzyi4o7OSUuYsE4Tr0LeIEhJoYt1RGzv4FzF/VMPD4BwKVNVvcDfConng9Y2zH
         nDOg==
X-Gm-Message-State: AFuF++lbdjr4w6pog1Kiw1PrEEFiloK3FIEP3a31Yz61RJabIJai0fWa
	eehQ5d243noEHKaayR/KRcJPpyksbSqex4wcP1wPgXI9GzE7tzlPwKDaqhHSwr3EPo8=
X-Gm-Gg: AR+sD104XkgZ+eMtJwyGiXmWo3GjQwwk49rwuBu5AC4wJop4udypnF0Pw9TwBAVU+h5
	pWR5BBrxuBgCWXSv3uAEI2Ix9VQOpLoCJhLJD0gLDce0VAY5TwnT6KjxowAs7J/f9/ZJekXUqD0
	d+OXzsSynnd34UACshVaFCGPNBzvbgC/a/UK+cHP2UlqkFOl+IMmGoyoqh717ZMHRRUl+CkAeq0
	fmxEK97d8ordH/MSmeiuXtAyzdzNgWSs6v2SmVRbN+YIIu2yeWpsR+kSmLkt10M5Z5kyEASv4TK
	fU9vGY8gfrjtA/UTTTC45EjEOp2Z/rNEKwBThUuvFdZnlMdwY7FEJSzcWJx8DfEO8gzQxaB3Xhl
	QbKTN6W/ERiNp1mLPTZbCIEpkrq5FdiPq0jPZIw8c/h6OVA5DN+0+OP6tfIs3bbQVszoVHykysK
	zGiWwommsPZgWzlwvef1BmncsOsS4IEIT/V24w5NJMGBzzwB9SZnb4uZcDEnlOooE=
X-Received: by 2002:a05:6402:5057:b0:6a5:dd97:23ea with SMTP id 4fb4d7f45d1cf-6a5df65b681mr14671525a12.11.1787833484885;
        Thu, 27 Aug 2026 05:24:44 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5deae179fsm8256557a12.26.2026.08.27.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 05:24:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,  Steffen Klassert
 <steffen.klassert@secunet.com>,  kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next] net: Use fixed slots for skb extensions
In-Reply-To: <ao9UV9S7rUkyQ8jv@strlen.de> (Florian Westphal's message of "Wed,
	26 Aug 2026 23:02:15 +0200")
References: <20260825-rfc-skb-ext-fixed-offsets-v1-1-8050ff33bec9@cloudflare.com>
	<ao9UV9S7rUkyQ8jv@strlen.de>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 27 Aug 2026 14:24:43 +0200
Message-ID: <8733vzvjhw.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 26, 2026 at 11:02 PM +02, Florian Westphal wrote:
> Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> Replace the dynamic skb extension allocator (->chunks + per-object offset[]
>> array) with fixed per-id slots with offsets computed at compile time.
>
> Why is that better than
>
> struct skb_ext {
> 	refcount_t refcnt;
> 	struct secpath s;
> 	struct nf_bridge_info b;
> 	...
>
> ?

Not better, just different. Header depenendencies get in the way -
xfrm.h defines struct sec_path but it also includes skbuff.h. Nothing
that can't be dealt with. Perhaps it'd be simpliest to move skb_ext to
its own header? I will have to give it a try.

> Yes, initially this was krealloc()'d area.  But the other assumption
> was that most skbs will carry no extension at all, or, in some configs
> one maybe two (IPsec gateway for instance).
>
> Thats why the first added extension is also at the beginning of the
> memory blob (that needs to be accessed anyway), regardless of the ID.
>
> I don't insist on keeping offsets[], if you feel like microbenchmarking
> different use-cases to see if it makes a difference to have a fixed
> memory layout feel free to explore that.
>
>> The runtime-computed offsets seem to be a leftover from the initial
>> posting [1], where skb_ext memory was reallocated when a new extension was
>> activated.
>> 
>> This can make extension delete-then-re-add unsafe, as pointed out by
>> Sashiko [2]: with bump allocation, re-adding an extension appends a second
>> copy, eventually overflowing the skb_ext chunks area.
>
> This can be solved by not zeroing the offset[] area and fixing
> skb_ext_put_mctp() to NULL flow->key.
>
> SKB_EXT_SEC_PATH is fine because it sets sp->len 0, so a
> skb_ext_reset() after skb_ext_del(skb, SKB_EXT_SEC_PATH);
> doesn't result in any UaF/double-refcount-puts.
>
> skb_ext_add() already re-enables skb->active_extensions if the requested
> ID already has its offset[] set.
>
> IOW, offset[ID] = .. reserves the space, it doesn't say the extension is
> still active.

That's a good point.
Didn't occur to me that we could think about offset like that.

>
>> While this does not happen today, because all extensions get dropped on skb
>> scrub, the BPF metadata skb extension work aims to preserve an extension
>> across skb scrubbing, which opens the door to this scenario.
>> 
>> [1] https://lore.kernel.org/all/20181210145006.19098-3-fw@strlen.de/
>> [2] https://lore.kernel.org/all/20260815081452.0DB521F00A3E@smtp.kernel.org/
>
> Looking at [2] and the original patch:
>
> static int __skb_ext_scrub(struct sk_buff *skb, unsigned int keep)
> {
> 	struct skb_ext *old = skb->extensions;
> 	struct skb_ext *ext;
> 	int i;
>
> 	if (refcount_read(&old->refcnt) == 1) {
> 		skb_ext_put_each(old, keep);
> 		ext = old;
> 	} else {
> 		ext = skb_ext_maybe_cow(old, keep);
> 		if (!ext)
> 			return -ENOMEM;
> 		skb->extensions = ext;
> 	}
>
> 	for (i = 0; i < SKB_EXT_NUM; i++) {
> 		if (!(keep & (1 << i)))
> 			ext->offset[i] = 0;
>
> Yes, this ext->offset[] = 0 is a problem, but its
> not needed, I think. This is enough:
>
> 	}
> 	skb->active_extensions = keep;
>
> (or maybe use &= so as to flag something as active
>  that was never enabled).
>
> Regarding skb_ext_maybe_cow() in above function: Why not ..
>
>
> - Fix skb_ext_put_mctp to be safe against double-put.
> - add skb_ext_cow, direct copy of skb_ext_maybe_cow() sans refcount check.
>   skb_ext_maybe_cow() retains the refcount check and wraps skb_ext_cow().
>
> After that:
>
> static int __skb_ext_scrub(struct sk_buff *skb, unsigned int keep)
> {
>         struct skb_ext *old = skb->extensions;
>         struct skb_ext *ext;
>         int i;
>
>         if (refcount_read(&old->refcnt) == 1) {
> 		skb_ext_put_each(old, keep);
> 		skb->active_extensions &= keep;
> 		return;
> 	}
>
> This is where it gets interesting.  As LLM generated comment
> says, we can get here with old->refcnt == 1: other CPU
> changed refcount 2 -> 1 right now (after == 1 was false).
>
> But thats not a problem, since we own a reference, the extension
> area will not go away and the likelyhood of this race happening
> is rather low anyway. So AFAICS this is fine:
>
>      ext = skb_ext_cow(old, keep);
>      if (!ext)
>         return -ENOMEM;
>
> Then 'skb->ext = ext' and set ->active_extensions
> to the correct value (i.e. clear non-'kept' extensions).
>
> Then call __skb_ext_put(ext).
>
> In case we still have a clone: COW was required, the
> __skb_ext_put() detached 'our' skb from the other ext blob.
>
> Other clone will eventually call __skb_ext_put(ext) again
> to release resources.
>
> In the other case, the __skb_ext_put(ext) discarded the old memory blob
> and all non-keep resources -- the kept ones had inner references (xfrm
> states for instance) incremented.
>
> Did I miss anything?  I apologize for not reviewing the initial
> patchset, I promise to get to it quicker next time.

Sounds sane to me. Or at least I can't poke any holes in it.

Thanks for sharing your thoughts. I really appreciate the input.
