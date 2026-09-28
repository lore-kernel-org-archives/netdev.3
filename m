Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E054915A0;
	Mon, 28 Sep 2026 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790639312; cv=none; b=M67C2aKRAMnFPbFhUNt5XNoFkIzJq1max141HtZGVSSHXM6QKczRO/7Xe/qxJUFWVPiK1TrJ6P3SZ5OxO5bVRiC+PzLvCOUx4yaDdtVWi3Y/eQXT3musvPWb12cdmY8EfY29djgEAj72FrzfUHVm84dPcRagDiqosp0wLGRXUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790639312; c=relaxed/simple;
	bh=u2L4I9ls9fqhodjGeRwrNu8STpkn6Q7ciISU01WaIig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAbeIoD18TKQe2wHIYwg0AOZtB9DtcKUIyr1FxBXSoqa2uRb2/91da82Vd+/oyBhbClQU4MrzX0kAE8MNVbSbX445xSXllsBoPcVvgyzSdBksx8TrT+ugRcC/3Ni3q/4UXVtzMzTHPn+Y9rYhiWPsvIdwWTnt2QVcI5Y8y+OzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CnurNAfI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YIwVqipS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CnurNAfI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YIwVqipS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F34F1400067;
	Mon, 28 Sep 2026 19:48:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 19:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1790639308; x=1790725708; bh=PHc340C/0RqxgJEdu6mza0gSoVBGf47y
	Y8pgWaWeaw8=; b=CnurNAfIvtzGpbeyD/IDt8lyUxY3gUPmFI41Qffp+OJp3EGS
	y/+4GOC0FzRMjDM3gWy9AEqrNHO1L8CYAnSnzJHSy1HEbd3VZT6ST0Pgt6cXO7qI
	NhfLtIvU1srEioF5sw8PGOLEle2wIsBh3yygB+6cYfQU5xjmyLAgZMmeNcHl/yfW
	AAlTiNnkaJymasYL6zfOGewl6oj8HkHfl2VdhpZlWf9HNNL2nkYCC99gCa/OGFsD
	BipNkLvBv95uBOKWZdderIslROGDern2uZbLMNa6ff8Sii3J2XptvXd1zjUfNCeI
	LwQJ90k+CkYmI0oJB4bMa6KDMOTd4gCnuwugSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790639308; x=
	1790725708; bh=PHc340C/0RqxgJEdu6mza0gSoVBGf47yY8pgWaWeaw8=; b=Y
	IwVqipSMYFIDoxvkjPJat1or8rZ4kPgLu4E1zAzQ2evpjOcZcv6uuTJTSuVV6ySo
	ZSKMeMa48+3z0ruh5FShko7tl2M6BF5lXRGjRfg5cgJs0PLRxwLaTWBntzoXCLIb
	PszN3znFV+qZS9pfrjhDkdSmE0j6+oTrEolefhRQlg1iqYGpSBVPdi6i1i9qQwpi
	85Z0Hza3v11gwdgFo6WNbdrIghhRZVdl76IHnGqC9VnQbAbqVptgvK5S2w+/GqiJ
	4udE51Rmz/xe1oTHIX7rbHsm+vmi7+8mYK0gsTgMTMrPY0Q1ymzpcDWn0S8brWpj
	c3mbmkqeDBmC9B8XgaYfg==
X-ME-Sender: <xms:yvy6au5C5wnKYlz6sjzDAmdhgSpakUvk7UVtlrUi0bE2UL8LIrvOdw>
    <xme:yvy6ah-zTmfwTZXhKokR79TzLofR4R4f6KQAyGG9A1lSsy7XFhmZDmJGVHOzZdpBQ
    mmhKRvLBEvKLiQ3MT-gfvsPA_RmvbPdaYjLZ4yUEJFQtQOgM8vFU1JI>
X-ME-Received: <xmr:yvy6atV53iffwnO6xc8WwOENCAr9vMHalIQ-NfgaE-FD8rXeAz1JviFR6lWH>
X-ME-Proxy-Cause: dmFkZTE7D7OQUEfd0QuENU6vRNXRggQ5ZujLkrqjuYUFhDJpZyOL5+Hh6JkNCdmsGKSa8Z
    tcOvgUwt9PnAeQWoPjp8NF2ijYHaiiLhDcOuuhxjTxbhxZyigkf94/mg6hj2bmVN9jGxLz
    OvKKmu073HxKpUVVTQgaT8PweQr+ONu3P1gvCNojENpDUCg6l/0hOVNeuR75JtG2sGlSqw
    lexxnc47ai0Xuqdp5xHoBZT9KVZdFgdXGhLBQNymOUMCPB72hzziJztJfiSNdnauruLa/L
    pojKJ5msFndPBQLoAJTjWnw0LfnTfHR7rdR2ULS19sogb+D3q0oL12nmHobUDIYl9jRTNW
    0tENKq+E1BX51Ha+yAWvjYFjNODsVQH0kMimk3SZ3GA92VaMCjut9BwQfNF87aafnYfWxt
    8atPrkX9MXk3tqMxXh1NJodfi7eyeCR1laCHmdHe/6u4mwwY9DH2VkPyCuua8hMpMAarYc
    0+Zdw8NYsSsBx2bJffDvAKYiORFsIJYqXeLyyCEGcczbGHlMtbVkHt24FC6T1QGBeWoSo3
    9U5OhxKqek6pu7UvezG5Nyxjzr8dvBS29E1HbVMODAKg3QHSXChxDloZtyH+Ly2Pkh9Vxu
    pKsnJJIXenVl7x4fY6hw6/eZKehLU1nnCwD6eckudsR4Fgykszm2hMR1YV/Q
X-ME-Proxy: <xmx:yvy6aso49G9HW69Rr00fFudxOzkbhM6eyKgFRlMvC8WD_bINqY42Og>
    <xmx:yvy6avlnxi_aC2jP_yq_nh9I0Pigzb7q4bHf1x4OXMFaBVLKBxJ7Mw>
    <xmx:yvy6as0YWdVyjV0HCrwcX0X_GM76gzC-rzMVMXW6l9fq5_EtIIqo-g>
    <xmx:yvy6asRLcq4p3mbsQv6TwOVWrabBfHlkzmP0oYMzyh3b3FWgQM9g2Q>
    <xmx:zPy6amkCNSjq7oKjMI9fXHNKTK0wPf9Owa6eY5dJKqsLaR94sDL1Bz9N>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 19:48:26 -0400 (EDT)
Date: Tue, 29 Sep 2026 01:48:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: esp6: fix off-by-one IV counter causing AES-GCM
 nonce reuse
Message-ID: <arr8x3a9Vqkg-ooM@krikkit>
References: <20260925095105.446269-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <arqToNCxIwi9CZ--@krikkit>
 <c443bad568f4e03d05b848b1b245707d@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c443bad568f4e03d05b848b1b245707d@oss.cyber.gouv.fr>

2026-09-28, 21:33:41 +0200, Jérémy Jean wrote:
> On 2026-09-28 18:19, Sabrina Dubroca wrote:
> > 2026-09-25, 09:51:06 +0000, Jérémy Jean wrote:
> > > An off-by-one error in esp6_xmit() advances the IV counter before
> > > encrypting each software-GSO segment. For N segments with sequence
> > > numbers X through X+N-1, the IV counters are therefore X+1 through
> > > X+N.
> > > The following non-GSO packet uses X+N for both its sequence number and
> > > IV counter, repeating the last segment's AES-GCM nonce under the same
> > > key.
> > 
> > I find this description very unclear. All I'm managing to understand
> > from this is "there's some situation where a packet isn't getting the
> > seqno it should". I don't know where the "+1" comes from since for GSO
> > the function does +N (xo->seq.low += skb_shinfo(skb)->gso_segs).
> 
> I tried to be as explicit as possible, but I apologize if it was not
> good enough. My understanding on the full GSO processing isn't as
> deep as yours, so here is another try at explaining.
> 
> The bug happens after software segmentation in GSO. When a large
> amount of data needs to span across several packets, software
> segmentation splits it into N smaller skb. After this split, each
> smaller skb holding the individual packets has skb_is_gso(skb)
> returning false, yet each skb keeps the flag XFRM_GSO_SEGMENT stating
> that this skb resulted from a segmentation. Consequently, the skb
> goes through the increment below in esp6_xmit():
> 
> net/ipv6/esp6_offload.c:
>    355		if (xo->flags & XFRM_GSO_SEGMENT) {
>    356			esp.esph->seq_no = htonl(seq);
>    357
>    358			if (!skb_is_gso(skb))
>    359				xo->seq.low++;      // <<< increment here
>    360			else
>    361				xo->seq.low += skb_shinfo(skb)->gso_segs;
>    362		}
>
> There are N calls to esp6_xmit() for all the smaller packets, and for
> each of them, the current sequence number is first written into the
> header, and then the shared counter for the next packet is
> incremented. However, the value esp.seqno used to construct the IV is
> derived from the counter value _after_ the increment.

Ok, I see now. One call to validate_xmit_xfrm() that calls
skb_gso_segment() and feeds those N non-GSO skbs to ->xmit one by one.

In that case, the seqno used in the IV wouldn't match the one that the
peer will reconstruct using the bottom 32b of seqno present in the
header, and it would never manage to decrypt anything we sent.

But luckily, it seems commenting out the memcpy(iv, seqno) line has no
effect (I think that's because all algorithms rely on either seqiv or
echainiv).

> For example, if
> the last packet produced by segmentation has sequence number 100, the
> IV is constructed using counter value 101. Then, a subsequent
> ordinary packet not going through segmentation is allocated sequence
> number 101, yet since it does not have the flag XFRM_GSO_SEGMENT,
> there is no increment, and its value is constructed from value 101 as
> well. Hence the nonce repetition.

I don't think that happens? The other packet will go through ->xmit
too and use the wrong seqno too.

-- 
Sabrina
