Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060843BDA0
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833744; cv=none; b=sA7R2NzzZW4vJ5tYG8RGZLtfQs2OMWag7VfResm/6Rca2S/sKmWx/JQSJzIu0v6BuTX4kWUTERWbM7zbnYWzM5OhDFLJW773CyOJE1IjhrBMAsRFrI/dljJeNrzfSa7KqS5tpUHxMhQQzdPUhdJK6aIvCj9ZtsSXMPuA4ZuQD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833744; c=relaxed/simple;
	bh=A5kDTX7QRULsSEmc6xlLT9Yg1TWzT0aGjfUb6+7N8yo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KUrwBZTr3aMF8HvhfRTPYQaO3UtrLKwj4duvv7rG3PLEdwVEaXOxlxCHjiNN4EwjcaDicUMFH7rGO+4ls3M4f5kwIyFJz2gJzfdvBQrhsgf4UyPB33XhZ+wrTdsOgnGyezJir8x7Hn/YpsvFvcLhHLM76508rVCI8B//ODksIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RSNSj4AB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RSNSj4AB"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2544ff970dso77395266b.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787833741; x=1788438541; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C4vW8joM12ZI5kJwRNqCM6Ouo6Ne5zWZolmVNsCgVe4=;
        b=RSNSj4AB5FsR25V+SXL3GrPFWPk4oqOFnZmx93Z8rzxGSs/yutnRf3yrT9Kpdgrl2a
         TB4+OMDdeAvuk6/rTqUZWQGgVDlcBsuJDImbaTPO8Bg6tbKrymPNVUIlsqxa4a6hK2NT
         OXIh03VE5gNR1zr75BR0LZziZ0ylQx966AXpni9Ebb6e0qNlYEqIbdr0Odv/UUNT3gR3
         kvtHr4A/IShI0JvksFmn3RIBhtWntKPHQgaZUBwWOsXGCRhQC8oo/9Ys0bHb/DpQqreP
         NieVUfGGRF/5RxxBkc51kIb9wszNNoHYEGIgU0mf2D1AhzcHdzeziIdWStJXPU1Ac0qO
         /L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787833741; x=1788438541;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C4vW8joM12ZI5kJwRNqCM6Ouo6Ne5zWZolmVNsCgVe4=;
        b=eOEf/fF4D2uhZgKYyNMza91D2j5lzf7DqbystCFE+eknBBE+iXjwwr4B3CNvPbEQ9P
         Sk63PIc7WMujXwZc8GnWEWRaTUh9vFBpsJPXFj+1lnKZ+g4GXtLWRPbWzfQSxhAW7rDJ
         Aq/sBxH/9nN3+0Csm93XXcq2zCLR7c8XjhgwFtxSsoSiXR2O+v37gLsneko4lI2QEefL
         yZCy7cakNGlmqwB+S6txc3JP66sUXEqSI7ZmVWIPa5L4Cf+nrQDYWrQd4n3uO92SochY
         ZmcKtWKkcUbszSkYAc2cTlE37qqSOMUe7gyZ61uz0SAJLC9LvGrqcFjPfdR2884dCpTM
         LEQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpV8LuQCoDYvrw30xWxkPZxJDgJoIab4QSvgn3z6Uafnzs/90X95jnxblIvM+n3fCVlm8mPwGo=@vger.kernel.org
X-Gm-Message-State: AFuF++lo/YwMpjU30Ea6Z2yYj8aoP0SjGmJANI94fdcuzPL0H7l0K7aI
	tMUTrad/bj05ITsOvUh3LNdqiVoIwnCh5SyuTJhaScNo+l5XHqrr0E9YDibSTyzFbsZjvK9pabF
	bNhde0T8=
X-Gm-Gg: AR+sD13ybBjvQH4PdoI1NOoPOrgFkZT5xGyfre5KM7lghe3hO/J8CEzzzrnfcm3S186
	W8YwzctaAst69RYqceDWcdhjbe/1WdOaLt+4ymkH2TdIEOrWQ36Jo7aXqW6vkmVBQzTQGSGlkUs
	mi77weabKW9miLUr8D3POOawlqK4Ua9L7aiThB4+XGdLxa+hy0OcFofw6ixkuB+M1bwi3HA+osR
	wtNlpcfl0yBWIqm77QOW/hogo+Zsg4sgIlOovoPf8tAqWakEgP0y8L2lbM504pe/gA4EjTToJfS
	IZrxSuSKTnWU2bm5d2e/fpBrV8PTJ8a+1iJeyat6o3zWlKqedLApNdDCi6co7vx5QUOsKSGjd+s
	jC6hoW+2EKfKsaH/wgG6XFW1uKV4iUgbXwwWtUw6djAsd4E/4PwPrPDIXHSlu39F5ayjZQMILhR
	i0m1AWdgoVaRrTKcB+8T4P1xRFT4izRj8cbMx/77hNDj9fU5bZ4y7v0noAi8PFQw==
X-Received: by 2002:a17:907:c23:b0:c12:9b93:61fd with SMTP id a640c23a62f3a-c250bb76ecbmr1399435166b.6.1787833741060;
        Thu, 27 Aug 2026 05:29:01 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d68desm1062039066b.10.2026.08.27.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 05:29:00 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>,  netdev@vger.kernel.org,  Steffen
 Klassert <steffen.klassert@secunet.com>,  kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next] net: Use fixed slots for skb extensions
In-Reply-To: <73331a07-46a3-4349-98b1-b388bcd783d0@redhat.com> (Paolo Abeni's
	message of "Thu, 27 Aug 2026 09:42:24 +0200")
References: <20260825-rfc-skb-ext-fixed-offsets-v1-1-8050ff33bec9@cloudflare.com>
	<ao9UV9S7rUkyQ8jv@strlen.de>
	<73331a07-46a3-4349-98b1-b388bcd783d0@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 27 Aug 2026 14:28:59 +0200
Message-ID: <87wltbu4qc.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 27, 2026 at 09:42 AM +02, Paolo Abeni wrote:
> On 8/26/26 11:02 PM, Florian Westphal wrote:
>> Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>> Replace the dynamic skb extension allocator (->chunks + per-object offset[]
>>> array) with fixed per-id slots with offsets computed at compile time.
>> 
>> Why is that better than
>> 
>> struct skb_ext {
>> 	refcount_t refcnt;
>> 	struct secpath s;
>> 	struct nf_bridge_info b;
>> 	...
>> 
>> ?
>
> I *think* the layout above would possibly be better (with compiler's
> guard around each struct definition).
>
>> Yes, initially this was krealloc()'d area.  But the other assumption
>> was that most skbs will carry no extension at all, or, in some configs
>> one maybe two (IPsec gateway for instance).
>> 
>> Thats why the first added extension is also at the beginning of the
>> memory blob (that needs to be accessed anyway), regardless of the ID.
>> 
>> I don't insist on keeping offsets[], if you feel like microbenchmarking
>> different use-cases to see if it makes a difference to have a fixed
>> memory layout feel free to explore that.
>
> Both options for different skb ext layouts save a few bytes from the
> final `struct skb_ext` size. This is IMHO quite relevant as the total
> size is approaching the memory partition size (IIRC it's almost 256
> bytes), and the bpf ext could make skb_ext require the next one (512).
>
> That in turn should impact performances quite noticeably (IIRC we
> observed measurable regression for bulk transfers due to similar changes
> in the past), as the number of slabs required to support the same number
> of in-flight packets will double, putting more pressure on the memory
> allocator and possibly hitting the slab slow-path.
>
> Still WRT optimizing skb_ext size, I think that it should be feasible to
> optimize the layout proposed by Florian by taking in account that some
> exts are 'mutually exclusive' i.e. on top of my head mptcp and bridge
> should never be attached to the same skb, and I *guess* can_skb_ext is
> mutually exclusive with most of the others.

Right, we could have unions for the mutually exclusive options.

> The layout could be adapted to such constraints, and there could be
> run-time checks (under DEBUG_NET) to verify such constrains at skb_add
> time leveraging `present_extensions` and a static matrix describing the
> mutual exclusive status for all extensions.

Having checks like that that sounds like the right first step that can
be done independently of skb_ext layout changes. I can give that a shot.

Thanks for feedback.
