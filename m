Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662857;
	b=NQBKTW4WDsabZRV4ZGXkqFEPco3YnYDObC0GfdyXt4cOgwvR0MBdhDmvIzrVzTpaQ/mP
	 kyMrLF2wtxJygFRIshY7dprMs9MDSyP48LVQPmNDKZAjNgvpIHjT1kdnA6wg0mbOE/t+g
	 MHMTMvwbhhTyVU9ciGjQrHdspu7a4omq9N/vtR6dsgLt2W7H4p+XW4yeyMqOkzomqdk75
	 mI+TpcARNoVPFkH7KP95VrYdYBL3VvEp/MD65Cg5ao3miC+aERU6OAfbYhE0OHOsHHg+k
	 InlefC6tjjqx8jNnZ2WrImZDLfAG9NJ+lPpllukA9hzK1tm929sm47TLGp8XBqW6NYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8kP2bh8OLzoj43YL1NHpZyuOIvZ9wkudBB2G5sKl/Fg=;
	b=QZKTR69rVSEqalppFlahsr06n7Lu9qHuPo68om2vr5FCQ5KmSS7YMcg6J/aU0YDikfmr
	 T0LnaPrkVRZEZcgj66c3TQLuuwEpBB5MqvWe+PDmYVCMHDE2RnP2AS3CvTz8bIsnhZkan
	 jTGozHcDUXgg+F9+yX4ncW9m3spaSYi0rJoywgCoe+g6O4t3ECdimGb93Qq/e99I4c3ZI
	 r9UyCPLMsPnRCF1wtwb17phZN1ePsqebADiC4zerT2GDVHIsBqHrOZaVg6n/FRPdFDmF9
	 g2Cjo5WcvQaJj46ouE9S913qxU5JhnooMAN+Mso3h2YMyzCLbcvW2MTEBLljoJfBZvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MqhbyFcX;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01319606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01319606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MqhbyFcX
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so9774375e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662855; x=1793267655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8kP2bh8OLzoj43YL1NHpZyuOIvZ9wkudBB2G5sKl/Fg=;
        b=MqhbyFcX3D4AT6K/CyQ78y1CVUg+FKMdV7sOEA/IsYc+dXlQEbbv0LabydLI+YvCuq
         pBO0DJHEGEFZd1ATNqhFdvebei4D/ksdnXfLZP9TBRPleKgbbHJ+6r3WytPJ45PXMBpf
         +6RxZNQ2ytDUWWXb88a3UcPgDuHCp9uhFkgrvdV8q3T7i3Dn4l2VO4SMeDV9HurB6b+N
         pztBsBZuEjkHATOPBxhp3dj7spX5Woy828urlDxpPtVZKUycQjKIVLpBEL/EJDYQFbQJ
         DRuBjiXszcFYJwESgCo4jFG5k8/a6ITAH/lYGXfDvf/9fq5gObTH5SUOOdAy5Por08gF
         EYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662855; x=1793267655;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8kP2bh8OLzoj43YL1NHpZyuOIvZ9wkudBB2G5sKl/Fg=;
        b=hgOJab8IF/mqWRJfWj0TblmbrvoshvvHnITFm+X4q05x7enLj/Ansx1S+R53Ibeqbf
         XRyeKksgZMDu5qBl4KhP+cH8WPtjVr+Cm5ydTfFo4tRzdASG+N+vYaC9GfXaGtAWVwyW
         9wTw9zjMCHGPgYoTb1nHMeGLwnpaErd8XY1SxBsGdy1cjWkPDOur+iXr1HBI4QbhQpWd
         OFKWWpOonp84Y90mtJMrv/3DrBpRj5hN+JOML6k//47brUGpcfegZMYOjNcrz9g4mEGf
         gVWr8VsvDly92gpJPFf2OtbLo2hZ4ovVVBHODfIE4mehKN+B0wOwmsrfjZJwJwNr/Rat
         h1Kw==
X-Forwarded-Encrypted: i=1; AKwUvBysiXT3o66sRzM5qBKTh22jm5h3sZClNvenT+7PRlNAH3VJRkTG/WR5UnHidRs9A+Mhg3FGpts=@vger.kernel.org
X-Gm-Message-State: AFq9FYLY1VhgqiksqlwsyJxHuIAg7X2AzvLsJKYk05d8uYl5c+bBDFJX
	b4Hbr8pBI6yd0ONYnO/KLuwWr2Dym3oyA1Xc00kwut3/lHPJUAyQL9jvd1qmaSd4
X-Gm-Gg: AYBFou3fxelGxAVm1Y4EaGI1TuiRgW9+DEDBSlUy48qnisXW/ELWxIiCGDs3jvqggyo
	A/4J8ws+udIjKyipXeHwZoYjioLeZMgO6Dz7dp6KBVOEIHPctYFNWm+d8mkQtvW1JXf8PZhrV7x
	3/ODfYTh3orvXcr2zPKeBWBQnCV51/Eg0WK3AsHGiGP0USHrQbiTotub7GiDR9IHx3X/Huyicdn
	b1IpEI7fnsXwBY3YhrvRkBm37xd3ojy1JfE/zmZHwgM3ca70dYybCr6K4D+Kl+ucrry1WFytRcM
	l1syP/HjU5svAX+3JaUX1jb2xN7vwUdZLsTvMwbXI4NdfyugjDT/9mo3YSwmJAs2Fbijbcf2C+t
	OaF9H/hmVQ1+ZSMAHEPJCx9wS+2WrpPn0d1dX/1B1+2eoaJMgPFW/nwOcgYywFRS10UaYC0bWku
	gnIy3f8RldogbCVGVw1j8NPmZH8KiqqZrNLt+m8kPcJobNUSJ0Y6IVM9v9/Rh6E+RsKocg5tUro
	BDs0QttOXvI+rcYSnoa4Kh7htbITNjcB/cv0/+een/2ojbUwNKbwP/6UMnj3TxOAMkOeaLbOmAP
	cWXja9yE2kiOgFm726nRgxDzUguRWp9ZpIc1MQ==
X-Received: by 2002:a05:600c:a215:b0:4a1:fcfa:2a07 with SMTP id 5b1f17b1804b1-4a1fdd395bemr65253455e9.30.1792662855163;
        Thu, 22 Oct 2026 02:54:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b3a4eesm54187115e9.7.2026.10.22.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:54:14 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:54:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, Stefano
 Stabellini <sstabellini@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Fernando Fernandez Mancera
 <fmancera@suse.de>, Mina Almasry <almasrymina@google.com>,
 netdev@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH net-next v2 01/15] net: skbuff: make
 skb_copy_and_csum_bits() report unreadable frags
Message-ID: <20261022105413.348a2585@pumpkin>
In-Reply-To: <717ace2e-18b2-4df5-848d-5757c01ee5de@redhat.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
	<20261021-b4-skbuff-bug-on-followups-v2-1-2aa780a03524@toxicpanda.com>
	<717ace2e-18b2-4df5-848d-5757c01ee5de@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 10:21:26 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 10/21/26 15:46, Josef Bacik wrote:
> > skb_copy_and_csum_bits() has no way to fail.  When it reaches
> > unreadable frags it zero-fills the rest of the buffer and returns 0,
> > and since commit ab9414ed70bd ("net: skbuff: don't leave stale bytes in
> > skb_copy_and_csum_bits()") that 0 is the correct checksum for what's in
> > the buffer.  Its callers can't tell the copy didn't happen.
> > 
> > That matters in the !sg && !csum branch of skb_segment().  A devmem TCP
> > skb keeps its whole payload in unreadable frags, so every segment ends
> > up with a payload of zeroes, tcp_gso_segment() writes a valid TCP
> > checksum over it, and the peer accepts the zeroes as stream data.  This
> > is reachable when both SG and TX checksum offload are turned off on a
> > device used for devmem TX: sk_setup_caps() still gives TCP SG and
> > HW_CSUM, so the dmabuf send is accepted, validate_xmit_unreadable_skb()
> > lets the skb through for a NETMEM_TX_NO_DMA device or a matching
> > binding, and software GSO segments it with neither feature.  Before
> > that commit the segments carried uninitialized memory with a checksum
> > that almost never matched.
> > 
> > This was reproduced with a test module rather than on devmem hardware:
> > skb_segment() on a TCPv4 GSO skb with 3000 bytes of payload in a page
> > frag marked unreadable, with features == 0, returns 3 segments whose
> > payloads are all zeroes, each with a checksum of 0, which is correct for
> > zeroes.  There's no warning or error; the data is silently replaced.
> > With this patch skb_segment() returns -EFAULT.
> > 
> > Make skb_copy_and_csum_bits() return 0 or -EFAULT and hand the checksum
> > back through a pointer, and make it __must_check so a new caller can't
> > ignore the failure.  Running out of skb before @len returns -EFAULT
> > too; commit 417261779eab ("net: skbuff: don't BUG() on leftover length
> > in skb_copy_and_csum_bits()") made that a zero-fill and a checksum of 0.
> > Each caller takes the error path it already has for a failed copy:
> > 
> >   - skb_segment() fails the segmentation, as the csum branch already
> >     does when skb_copy_bits() fails.
> >   - icmp_glue_bits() and icmpv6_getfrag() return the error, so the ICMP
> >     error isn't sent.
> >   - __ip_append_data() and __ip6_append_data() drop the new skb and
> >     return -EFAULT, as they do when getfrag fails.
> >   - vnet_skb_shape() fails the same way it does when its skb_copy_bits()
> >     call fails.
> >   - xdr_skb_read_bits() returns 0 without consuming anything, as it does
> >     when skb_copy_bits() fails, so desc.count stays non-zero and
> >     csum_partial_copy_to_xdr() fails.  csum_partial_copy_to_xdr() used
> >     to checksum the bytes it hadn't copied before checking desc.count.
> >     desc.offset and desc.count always add up to skb->len, so that only
> >     ran when it was about to fail anyway, and on an unreadable skb
> >     skb_checksum() would WARN.  Drop it.
> >   - skb_copy_and_csum_dev() can't return an error, so it leaves the
> >     checksum alone and the frame goes out with a bad one.  Its callers
> >     are drivers that never see unreadable skbs anyway.
> > 
> > The zero-fill stays, so a caller that does send the buffer still
> > doesn't leak anything.
> > 
> > This was found by the Sashiko AI review of that commit, and
> > Mina suggested reporting the error from the helper rather than checking
> > for unreadable frags in skb_segment().
> > 
> > Link: https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/
> > Suggested-by: Mina Almasry <almasrymina@google.com>
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > Assisted-by: LLM
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   drivers/net/ethernet/sun/sunvnet_common.c | 10 +++--
> >   include/linux/skbuff.h                    |  4 +-
> >   net/core/skbuff.c                         | 63 +++++++++++++++++++++----------
> >   net/ipv4/icmp.c                           |  9 +++--
> >   net/ipv4/ip_output.c                      | 11 ++++--
> >   net/ipv6/icmp.c                           |  7 +++-
> >   net/ipv6/ip6_output.c                     | 11 ++++--
> >   net/sunrpc/socklib.c                      |  9 ++---
> >   8 files changed, 83 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
> > index 5cca95869052..4f229fcecc32 100644
> > --- a/drivers/net/ethernet/sun/sunvnet_common.c
> > +++ b/drivers/net/ethernet/sun/sunvnet_common.c
> > @@ -1167,9 +1167,13 @@ static inline struct sk_buff *vnet_skb_shape(struct sk_buff *skb, int ncookies)
> >   
> >   			/* copy the rest, with csum calculation */
> >   			*(__sum16 *)(skb->data + offset) = 0;
> > -			csum = skb_copy_and_csum_bits(skb, start,
> > -						      nskb->data + start,
> > -						      skb->len - start);
> > +			if (skb_copy_and_csum_bits(skb, start,
> > +						   nskb->data + start,
> > +						   skb->len - start, &csum)) {  
> 
> Recently Eric did some work to remove return arguments from the fast-path,
> as with some config it gives measurable overhead. See commit
> a02a765bd5c2ae7705144829b2911c96c29db6ba.

And, as soon as you take &csum, not only does the value have to get
re-read from stack, but the compiles has to assume that the address might
have been saved and can be updated by any other function call.
> 
> S/W csum should not be the fastest path, but AFAICS the UDP output path
> could use it when building the aggregate segments.
> 
> I'm wondering using a 64 bit return value and encoding there both the csum
> and the error could make sense.

That gets really horrid especially on 32bit.

That is why I suggested earlier that since csum values 0 and ~0 are
equivalent one of the two values could be used as an error result.
An 'adc loop' won't normally generate zero, but there might be some
code that relies on it - so would need changing before zero could
be used as an error return value.

David

> 
> Also currently net-next is closed for the merge window, and a bunch of
> changes in this series looks more like cleanup than fixes. Cleanup will have
> to wait for the end of the merge window, fixes can land at any time.
> 
> /P
> 

