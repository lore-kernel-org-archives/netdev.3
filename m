Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0155820C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925032; cv=none; b=NjW7d0RhJ6HGWKz6LzpTaiRe/TW2FVXFkmDvOmj7FqOVQlY8XMJBs7n1mbgcAU/H7RY7U1qO3jcuEHMsR//7LL33htg+4Cp3WxCk181PfrBRhBIfObOzv9E6itNPCJ7T0IjrHM0Oh0+StlXi/Z5L0iZJ/rBARTEuXHG6Vz0GxXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925032; c=relaxed/simple;
	bh=4+SSE6EU8udPXmhUPtFyuoXGs8hahHA+j3OUghNKKrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFo3GvHpYK8lfVhqSiZ+IWlEIYKdaoVHrNgdT3MihW9jgrXaGIFkh14p5R2ZrlSnB4K7qKb2b7H90uuxT8DEZ8q6PiXvQd3jkPrZeMnVYfar0gM5xWiNAelZX77uHsIZoJj23AaMI0PX5mGzYJJAROF32wlzuDC3m+A66Lxj4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDtRQ+Ot; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Es9kdRrw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDtRQ+Ot";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Es9kdRrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791925027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwPXkeY12Wi/XtJvw9dMwqYtHY2GvFteBkFGECaSB9k=;
	b=MDtRQ+OtdDH+ta7d+Yd7wu9kCXKAEicnuwqstvd5CG+umqvYMZbHvNsjV1a2LmG4cWr0/R
	RWCsTDc9mSerrNtiWEUgL8MFqcPIZ58evKklgubzKq0omtYP5tv9v9VsuKcF/+NIkVe1fw
	xLhL6K5DkDmTwuAylLvjp+pZWFShNwM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-MXmK73OhNfG5eu6lpuoaaA-1; Tue, 13 Oct 2026 20:57:05 +0000
X-MC-Unique: MXmK73OhNfG5eu6lpuoaaA-1
X-Mimecast-MFC-AGG-ID: MXmK73OhNfG5eu6lpuoaaA_1791925024
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1b11e7837so3221815e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791925024; x=1792529824; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pwPXkeY12Wi/XtJvw9dMwqYtHY2GvFteBkFGECaSB9k=;
        b=Es9kdRrw4alxCUhRxpTs73zCHO8k08cY3qvH0QCs/o4l2A0D1On6iT/bWP6AFnu7Ar
         caEUcKW95Q4UE5Ei5N/24yug9rIEGBm2Ib8mQapksInFjX/h1PI1r3axEnEFrCNj+9Uh
         Vaqw2G1yd8Co7RC/3g3mJf9QuD6Zj+HCc22W9cTdkok7vIfgeGjyH2TToiKXUoHNp8ok
         oZ1yiFyhvN6UWnyDPxz6gHzAnSFNMzE/u7CQU/H7S/LkT8i7gcc5PoClmHklJ8+EUBjP
         78gnyhNS6kncpIG4I8d9SZ1DPjNaooKEDfgkuvnWa4KNEt2gu/vzmWisp8agyEiSMtNx
         VBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791925024; x=1792529824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pwPXkeY12Wi/XtJvw9dMwqYtHY2GvFteBkFGECaSB9k=;
        b=EjwPc/UsGHFDWYe0bsUOY0ovPq3uns5zyKlYdzODd2WkRgqaTfC0zV513a0SUrPqym
         d51XlciECBo0qFr+efNyfB0pLzW6rh7wTxER7wmCGtN+syUN50UiZ/L2E7FLZDNH13Rt
         ikqoPO3PXJOC4Ovwdn+qI3XsO3LVU+ODOCDJSTyFGzBzgPxgx8bYJMAwOs6z5JlAVXYE
         FzqkX4jx4W4PnbHiGwujUoHMOJUC2w1QcVYERhdUa36gJrUnZIpvwOjQ9H9sJNqPB5Fn
         uaR67ouXzNkTuTiKbvr5lkfGXOksfG1B0nqZwtlrZBcYa6dGnWkelJDyTysWsvPyz9PI
         OzQA==
X-Forwarded-Encrypted: i=1; AKwUvBxp24eYbYgaYUZ5YL2aeG2GPLcgJWxV0S98v+itTXhpRfruPMABKfwnyzn3HdR4KpSBoLNyI6g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLK5iC4293jySsWcOLRJNaQAHHmYqDmz4IeW5JLVGRmHXWTOWL/
	PvmKRxi61/n+bD8MXbK+vQrV+yIofoB/zsC9/J8CGdismMX6hQFcIvYO3lOigiowKlvpG9EcZD6
	IrABA4dpPhaTflKEHqwuaTjckeReR21qU0NFyhzMxH1GCqbs4Qw8KKgEM2A==
X-Gm-Gg: AYBFou3LjZ+QkqS/r+u549HiPUXiSPqNCHW5vKooxyNNY2/xzUZNn5dRGxeMlmZ40yb
	PPxcBBP1mY1kYQBMR/Mir+v6Byjzqtpws4Wcif9aqfPg7Os5djaLNZruatSkT2Ysdf/1PTMGUME
	Q0h1uXG152LZAcS5J3fpIAhj+ChhFPMVLgu7Cpe2HRHHuTKg1vrEeFjzjK9r6q/nR1B3At1bkfB
	MqqSIRlkjoakylwC7ujvxJF//L9M6gCYsZhrSPTSPfFgVLBO73W++WN5JPab+tS4GODK+/hEbqV
	lIEQEp4OCJpITkiixKij3d7e4COP1SPMAoWQm/Rr+vhaf/CFNybY8DVvQNsz6QjSIoqV8A==
X-Received: by 2002:a05:600c:4e47:b0:4a1:813f:2a65 with SMTP id 5b1f17b1804b1-4a18e4b1a6fmr240281455e9.15.1791925024460;
        Tue, 13 Oct 2026 13:57:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:4a1:813f:2a65 with SMTP id 5b1f17b1804b1-4a18e4b1a6fmr240281265e9.15.1791925024016;
        Tue, 13 Oct 2026 13:57:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2387988f8f.29.2026.10.13.13.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:57:00 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:56:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
Message-ID: <20261013165547-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
 <20261013143716-mutt-send-email-mst@kernel.org>
 <CAF=yD-LLNm1K5r37-y2thyvLJN58ruffUUHy-6BUh1CGVmep0Q@mail.gmail.com>
 <20261013163109-mutt-send-email-mst@kernel.org>
 <CAF=yD-LtGVWrGzs2shhfxzDdwfid=1=TYBcOVQ8Nt10gAHpjWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-LtGVWrGzs2shhfxzDdwfid=1=TYBcOVQ8Nt10gAHpjWQ@mail.gmail.com>

On Tue, Oct 13, 2026 at 02:54:24PM -0600, Willem de Bruijn wrote:
> On Tue, Oct 13, 2026 at 2:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 13, 2026 at 02:29:53PM -0600, Willem de Bruijn wrote:
> > > On Tue, Oct 13, 2026 at 12:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 13, 2026 at 08:41:19AM -0600, Willem de Bruijn wrote:
> > > > > On Tue, Oct 13, 2026 at 4:58 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > Allowing untrusted hardware to specify csum start/offset for
> > > > > > CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> > > > > > outside the actual checksum, and depending on the setup, the networking
> > > > > > stack could be looking at the packet both before and after the edit, and
> > > > > > seeing different results.
> > > > > >
> > > > > > Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> > > > > > completing checksum") validated all known instances where this
> > > > > > causes the most grief, but the real fix is to make sure
> > > > > > that either only actual checksum fields are ever edited,
> > > > > > or the checksum is completed before the net stack looks at it,
> > > > > > so it is always consistent.
> > > > >
> > > > > +1 on the general approach of performing the checksum offload at
> > > > > input, unless the input can easily be validated to be one of a few
> > > > > common protocols. That greatly reduces the risk vs my previous attempt
> > > > > at trying to drop.
> > > > >
> > > > > Since we do not know the full extent of grief, I think this too should
> > > > > go to net and stable.
> > > >
> > > > I think it needs a bit more testing to be frank, I do not see it
> > > > wait months out of the tree. So if this lands in next before the
> > > > merge window, we are good I think. If we miss that I will target net.
> > > >
> > > >
> > > > > That would mean initially a single patch that
> > > > > touches as few files as possible. The helper function in
> > > > > include/linux/ip.h and conversion of existing open coded parsers to
> > > > > use that can follow up later in net-next.
> > > >
> > > > I don't see the value to be frank.
> > > > What moving code between files accomplishes, I donnu.
> > > > Squashing things surely makes review harder?
> > > > Does your backporting system really struggle with trivial
> > > > dependencies like this?
> > > >
> > > > I can drop patch 2 and will if I am targeting net.
> > >
> > > Good. This is not about "my" backporting, but upstream stable.
> > > Refactor patches do not belong there.
> > >
> > > Since patch 3 might have to be backported in the future if a serious
> > > abuse surfaces, even if you now land it in net-next, it is better to
> > > not depend on other patches.
> >
> > Right. While this is targeting next, I will reorder it last in series so
> > it's obvious for people it can be dropped.
> >
> > Thanks a lot for the review!
> 
> Of course. Thanks for the fixes!
> 
> I would open-code ip4_parse directly in "net: resolve uncommon partial
> checksums at ingress". It's not a lot of code. Then that patch stands
> on its own.

Ok if you prefer, except I'll make it a small inline in the same file.
Easier to then dedup at the end.

> And then optionally squash patches 1 and 2 and place them at the end
> of this series as one dedup patch, or send that separately later.
> Personally I would drop that entirely and leave the existing code as
> is. But either way.
> 
> >
> > > > >
> > > > > > This basically does this: checksum at ingress, except in a narrow list
> > > > > > of specified known good cases.
> > > > > >
> > > > > > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > > > > >
> > > > > > Michael S. Tsirkin (4):
> > > > > >   net: add ip4_parse()
> > > > > >   net: use ip4_parse() in receive validation
> > > > > >   net: resolve uncommon partial checksums at ingress
> > > > > >   net: account for ingress-resolved virtio net hdr state
> > > >
> >

