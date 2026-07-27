Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306842089D
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172515; cv=none; b=iW3K1bk+eDV+T3x9pCguveQq5+xsdm+lAWW2Qj1pf6a8HEL04mf0jqnU9F2ByyRN+iboxhbCz/dLLOGZwjax1/nz+VX43X4jJ5IH5EKjwVwHW3HIzzO+Rks3UbnBY7yM7bTnXqAtJUsYVHbyjQnNTt/FbxBO4x+PcztBkYFIAFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172515; c=relaxed/simple;
	bh=ldlj4ezw82X6YR0y6+gUXPGaio9f0a4M+Ie61LMPdqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkAP8pII0UUk33acuQq04mhaiOVnGY6rGINeeVz1iEGBvVAUJfenytbs0ZcuX6So7urupAMBgvhsR8I5fOEHqN/YczS0PsSOJH2wP2t0s7/Dmw0G1n+/ZeCtNu9+HKzeUiZvNuQ7z9nxyfjbWHbQ9abh6UZeWeFgbAo3OfGe7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaHTdzNS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaHTdzNS"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so1736929a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785172504; x=1785777304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WmLwOH1t9L9a9hMVDIlvfVARjK3db7S1gKMJQ441q0Y=;
        b=aaHTdzNSFuH21R4MV4sQdOW2PbIBs63ZhVY8R6RH1i+fmh9s1+WEoUmamfMezqC1kq
         Cbb8icQE+zTXuIY1RJUoXRjOr2s85AwEk3AGg1UbMWlNZdjrQwAl7XqJTALa/JHwcwSS
         IMww+0Y78g7SvV+3/4ZzalJCOMH7qsC3PTy+jk/TQfgCrT1kjjlYnLMjhU4BBRE8RKak
         7+PX9W69KcIHpg82zdllt+fACUqKGSYsd2PXFHlC9VpjYGFtHgir6mXixDg9NUWe11tP
         +6gHvrDixZJcmzXWlGbc4wHmL5Hgopmy+fUpCK+Kb32bFtZp+uK7/mVT5WBINTMaxtHb
         EftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785172504; x=1785777304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WmLwOH1t9L9a9hMVDIlvfVARjK3db7S1gKMJQ441q0Y=;
        b=ooU/FgUrLqyWuFRXHkbiUtF39ZQIGOgQdr3geD3HdKKXPpX69QyxkaPwYrZX+syEkn
         0t2O9kBuUejZaLvbQkmL91WqgmjjjIwPnGYThNtxlsZhTpctjH3rzFnda+BhbUXV2gEc
         umVjXRyVrp7PqmW8iJnRD0Ynw/huDXyxE/NJbsyURJWIR8Yhc6r/8t6YV4zFHdiWuZTE
         UnRTfP56jp342snk1uqFV2WP8dbYByaGMLzCW5LLcD2kVu76+Hxea9a7YcBCCdpdog2I
         UbhMlHHVkSZHvEEoisEthVREnCzqv52kOH4c+s/bLtup8JzNyP/3GettIT4i9TQ6LAjB
         L92g==
X-Forwarded-Encrypted: i=1; AHgh+RrYY7uSPThMwhn26uz8fSUWByOKjL/T3L/fod/kvZfmNy7L6dNNg0n2blvvHeMQu7k/o8ompb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26BMTDRrWhV+UvPFkvVbmhOEbe1uXGXsmwG11JXhyqJsZNP7P
	ZsLVdvLMrhIe4ycLZnZM2OciB1lkxd/rUoebcb5lvdsCFC+Lkhb5E63q
X-Gm-Gg: AR+sD109BRmluu5rXEVQzA/A+Xl4fXJWrRSmF9uojfLfP0PWP8NHMlg5G+/8DfGMAU6
	JbID/lm49X/sp23y1UGe3joNensvZREG2AfYZWyhddiKqsrcOkNOZlx8a9mBmSkVYMvMMSmg6Hy
	vCWPXKKyrdkR7b3c7QG/0stZnaU8XwAviNfjaH/Bs95IGDZoCTLxe4AyqMp98OJ7OoiQfWC6pnC
	TBZcKP9Hw3ZtfJEn5/7GEaErF/4xHCL1w6Nh81fh4EXMmpvLDaNDZwAw4dxJU8DDqjS+at1knx2
	avV3H9M0PuUKnNWJLwftc3b8TP73FIR0t/gcxQDqZvBvEpdOUgldM/Ltx4Z7YuCgj1c8yoWmdkP
	JhL9ODqedx6JTccx+yZRLE6nL/TksFQJc4B2H82UtnYmt7YxoixwT4oSlDtriLbyaJOviyaUwFR
	IFpdzhSV4g4a86lThBYMhoiCc=
X-Received: by 2002:a05:6a20:aaaf:b0:3c3:a20f:f729 with SMTP id adf61e73a8af0-3c67d9b3d44mr6780660637.7.1785172503549;
        Mon, 27 Jul 2026 10:15:03 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb6632810sm3496276a12.13.2026.07.27.10.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:15:02 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:15:00 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net v2] net: devmem: prevent net-iov / page mixing
Message-ID: <ameSFFGrRefzNQKI@devvm29614.prn0.facebook.com>
References: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
 <ameCMuhluA6j21mL@devvm29614.prn0.facebook.com>
 <9d8eaf93-9d2d-46aa-8f12-ecfde1a906f2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d8eaf93-9d2d-46aa-8f12-ecfde1a906f2@gmail.com>

On Mon, Jul 27, 2026 at 05:39:11PM +0100, Pavel Begunkov wrote:
> On 7/27/26 17:07, Bobby Eshleman wrote:
> > On Mon, Jul 27, 2026 at 12:19:37PM +0100, Pavel Begunkov wrote:
> > > We should either have net_iov or page backed frags in a single skb,
> > > otherwise it blows up down the stack. Don't allow mixing in
> > > zerocopy_fill_skb_from_devmem().
> > > 
> > > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > > ---
> > > 
> > > v2: EEXIST -> EFAULT, as skb_zerocopy_iter_stream() doesn't handle
> > >      the former + for consistency.
> > > 
> > >   net/core/datagram.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > > index c285c6465923..173b5d97bd40 100644
> > > --- a/net/core/datagram.c
> > > +++ b/net/core/datagram.c
> > > @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
> > >   	size_t virt_addr, size, off;
> > >   	struct net_iov *niov;
> > > +	if (i && skb_frags_readable(skb))
> > > +		return -EFAULT;
> > > +
> > 
> > Doesn't this still break the allowed scenario where the user does
> > sendmsg(not devmem) before sendmsg(devmem), and tcp tries to append to
> > the write tail skb?
> Considering that it crashes the kernel, no, it doesn't.

Both are broken IMHO. Before this patch, the kernel crashes. After this
patch, the socket errs out to the user under a condition that it is
supposed to just handle. Why not just propagate up an errno that
triggers new_segment so it gets handled? 

Best,
Bobby
