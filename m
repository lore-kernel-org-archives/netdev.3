Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA851C331;
	Tue, 29 Sep 2026 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686826; cv=none; b=ctg0fldkofj087gwE7Eou9qx6mYCtFMa87ljhCibXtX9FzwOoDvtcXASSk4lv7PMn1DlqShQfvpwiYxmsM4DMXws2zus8F6Bbs4KsI3K5oZIRORdlxuJgGqDF0otlJQApz3/sVy1GXxWUpSGfqfUgppmdTpFJ6JhJaFetpcmNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686826; c=relaxed/simple;
	bh=tnRVbMFjVHnMi4GM2FGEjW3vI3oqDfVuL7/o+RpLgDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXNn/x/GexEsqOdYl/3/kDLHiJUchkD/R+RIDK+ep6157ZtKHl7sBTFkybvB2L3a2srXV/SjtFPCxnR2eRrnNL7kB3ke0wdYfuRf0PXCwgF4pkSkfBKDkET9fM+i7P3rXvjagmmZ/hQcPCPACdrr5myn4GrDdMu4UhbahLXDVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=uIpWDLlA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tfbXe/no; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="uIpWDLlA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tfbXe/no"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 70165EC05AD;
	Tue, 29 Sep 2026 09:00:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 29 Sep 2026 09:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1790686822; x=1790773222; bh=rxZ2xVXpHDE7yPB6wIvZqz2OGFEty91V
	JWNn9ZY4UOs=; b=uIpWDLlAHzb0qVrPQX0kzcc2u9h/NmYiSx39Y/Gr15WPlzDM
	nsH3Fa1ijOMKCp/txlccsOWAzLQIJNcAPPci96ZnRk+2XaBsXMtRpjk90duVjyWk
	Io9krtWkesoHyUgMMQ6MqMCFubS4YDgL2PopoXCb1cJGMSUHNszo4CkbLFH8UWiR
	D5+NgLwCKJqjHVSNnrlN2UyDP7MBXYQoP7tAd4tAGhtzomdlGatOBHkDDHeHrlhI
	RUajnYjCgfMdMAujH3m3RzhukMLvQ/Zzx8t5PPUC3+X+CLnLL4OWGeae8i13lxV7
	8oF8js0+ZYhte5FN8gsPqeAfLwwWKTjous+NKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790686822; x=
	1790773222; bh=rxZ2xVXpHDE7yPB6wIvZqz2OGFEty91VJWNn9ZY4UOs=; b=t
	fbXe/noCJ0TijdKnosxiCNKhFj/Mj6OPR891YZnM0D67ghDr/qUDcAClCvisvC0l
	bFshYgQgS3OKYc3rTIznsdRNSRdBq0Y+OtZk2RV8BMyX/Whb/ven9V3XqkfQ0Oj4
	J2ag3iLg0i8BodJluBI34TqAyAaq4H6oLdZx+yNKg81fw+Do7vedEabKM2pjPEca
	Uz1burZTC+FS4FGoUW19VjRY7wZn9aJyWQLpyKzKQ5zfeJAbEM4bQJQ0UP2LtuIe
	6uCqk317cSMQ0hjliPNYdiWom5l2hBnmQYml8YJOPKop9v8xlovj+qNTRzOCEq8s
	Mlm6pZeKevitwLx+boekg==
X-ME-Sender: <xms:Zba7akuw1XfmxYiIlpNaDoeZ5Wl93ZCxXT0ZJNPTNWf87O_7Y67Nhw>
    <xme:Zba7arjR0OMeJiEIFN3LdyMt8pkxqb3CaycFdoqcVa_e2f-RM83k3cMO9wHd9vT89
    Q7mL5-S1s9sS-XNX5nXGOcH76trdYIDOjbPbzvjaIA44_HrEu0YQHCZ>
X-ME-Received: <xmr:Zba7avr2zvWlsih2Phvfhi4kTZvxnIQdGh32vzG2OKiaeY3cMjKsuLiguyp9>
X-ME-Proxy-Cause: dmFkZTEt0YXDcI7osdiiMyGjH2AhCsHjHK9ziJRdT8WP0eyjC//TY7aVudGVc0xynXt+r5
    cDpwS3l1+50AxiIUfwTn56bvEUDeY3/KL1xR47HjtfllbCtQ8GlbR1VEBJGp5qT84XFEWn
    TVu2jVDHixhmOZgP2rla6BKUqWfFc1o862KP2B1OBWjZHuEltqSnUcwCoarjkHkmc4u3oK
    L8rr3/z6YL8E55YuqJxk8eF5xQDz50WcbshcjVug6dj4UNrhUC4XhsYM45G1FI8GgbAe+n
    YNa/9rUlTMqefLPUOcHyMgUw6KrWLA7+dLsr0NmGXSwLND5BKjgbIRMwvAnowJTUNM7uZn
    T6O3gI+bblzwg1LnFaIKnAYbUwgMFEdIVNpv8eXowvGDBsUS7nQTlQFlpA6rqJ2S/MGJfh
    /1+8aeFCQuaBM4rf8o0a4amnfFfN9vxuHcOxRypxDpXn86ZrdSxGMiT5Apq6SJhhxhCtl6
    ifd+m5dl97ML6msbS4eNpZPDhKcR46BL7zRLtt+SIVyECZS54Y3YRk9L4nlQq58ACHtR5h
    i9FNkaZxEjavri3jNaVDt25rWo6z1JgdoCKDNetHbnkqAfcpvXcq4kTOawmnoRv7dmacXC
    WZwAlxomvO5f9XsJV8mKziIxfj0ACgAo3nHpIZlbF47n9BgglPRE/PqQ1bVA
X-ME-Proxy: <xmx:Zba7aou_5KO03ea5jMsGJ-nET7topc1akhYKpeOqkn8RWytBiT_kmg>
    <xmx:Zba7aiYuLf77hoQ9ExgE6CmhD7XKwtdLIXfd6wKfxBv4z24fm97ClA>
    <xmx:Zba7avbno8QhRxGYkKVzQZ4V29Cb8Crpb4PYM9w1TC4Uym5MAKfDaA>
    <xmx:Zba7ajlWN0_KUAzo5fx4AUWCMDd1qVsDXiYKGSKgsnUmigx0klD4_Q>
    <xmx:Zra7at4J2ruC5vh4YEbrV-P6XHRado6NeTnivBFFT0bkepcsGDxxZU_v>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 09:00:21 -0400 (EDT)
Date: Tue, 29 Sep 2026 15:00:19 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: esp6: fix off-by-one IV counter causing AES-GCM
 nonce reuse
Message-ID: <aru2Y-gyrgcZsyUD@krikkit>
References: <20260925095105.446269-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <arqToNCxIwi9CZ--@krikkit>
 <c443bad568f4e03d05b848b1b245707d@oss.cyber.gouv.fr>
 <arr8x3a9Vqkg-ooM@krikkit>
 <29a10d01b87fb1c5f9af445aa7864351@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29a10d01b87fb1c5f9af445aa7864351@oss.cyber.gouv.fr>

2026-09-29, 11:47:47 +0200, Jérémy Jean wrote:
> Hello Sabrina,
> 
> On 2026-09-29 01:48, Sabrina Dubroca wrote:
> > 2026-09-28, 21:33:41 +0200, Jérémy Jean wrote:
> > > On 2026-09-28 18:19, Sabrina Dubroca wrote:
> > > > 2026-09-25, 09:51:06 +0000, Jérémy Jean wrote:
> > > > > An off-by-one error in esp6_xmit() advances the IV counter before
> > > > > encrypting each software-GSO segment. For N segments with sequence
> > > > > numbers X through X+N-1, the IV counters are therefore X+1 through
> > > > > X+N.
> > > > > The following non-GSO packet uses X+N for both its sequence number and
> > > > > IV counter, repeating the last segment's AES-GCM nonce under the same
> > > > > key.
> > > >
> > > > I find this description very unclear. All I'm managing to understand
> > > > from this is "there's some situation where a packet isn't getting the
> > > > seqno it should". I don't know where the "+1" comes from since for GSO
> > > > the function does +N (xo->seq.low += skb_shinfo(skb)->gso_segs).
> > > 
> > > I tried to be as explicit as possible, but I apologize if it was not
> > > good enough. My understanding on the full GSO processing isn't as
> > > deep as yours, so here is another try at explaining.
> > > 
> > > The bug happens after software segmentation in GSO. When a large
> > > amount of data needs to span across several packets, software
> > > segmentation splits it into N smaller skb. After this split, each
> > > smaller skb holding the individual packets has skb_is_gso(skb)
> > > returning false, yet each skb keeps the flag XFRM_GSO_SEGMENT stating
> > > that this skb resulted from a segmentation. Consequently, the skb
> > > goes through the increment below in esp6_xmit():
> > > 
> > > net/ipv6/esp6_offload.c:
> > >    355		if (xo->flags & XFRM_GSO_SEGMENT) {
> > >    356			esp.esph->seq_no = htonl(seq);
> > >    357
> > >    358			if (!skb_is_gso(skb))
> > >    359				xo->seq.low++;      // <<< increment here
> > >    360			else
> > >    361				xo->seq.low += skb_shinfo(skb)->gso_segs;
> > >    362		}
> > > 
> > > There are N calls to esp6_xmit() for all the smaller packets, and for
> > > each of them, the current sequence number is first written into the
> > > header, and then the shared counter for the next packet is
> > > incremented. However, the value esp.seqno used to construct the IV is
> > > derived from the counter value _after_ the increment.
> > 
> > Ok, I see now. One call to validate_xmit_xfrm() that calls
> > skb_gso_segment() and feeds those N non-GSO skbs to ->xmit one by one.
> 
> Yes, precisely.
> 
> > In that case, the seqno used in the IV wouldn't match the one that the
> > peer will reconstruct using the bottom 32b of seqno present in the
> > header, and it would never manage to decrypt anything we sent.
> 
> I don't think the peer uses its internal counter to reconstruct the IV?

For some reason when looking at this last night I thought it was
rebuilding it from the seqno in the esp header.

> The IV is part of the GCM ciphertext and the peer uses that value it
> received to decrypt the payload. AFAICT, the decryption is ultimately done
> in seqiv_aead_decrypt(), where one can see the IV copy (121), and the
> actual decryption call (123).
> 
> crypto/seqiv.c:
>     99	static int seqiv_aead_decrypt(struct aead_request *req)
>    100	{
>                 // ...
>    116		aead_request_set_callback(subreq, req->base.flags, compl, data);
>    117		aead_request_set_crypt(subreq, req->src, req->dst,
>    118				       req->cryptlen - ivsize, req->iv);
>    119		aead_request_set_ad(subreq, req->assoclen + ivsize);
>    120
>    121		scatterwalk_map_and_copy(req->iv, req->src, req->assoclen, ivsize,
> 0);
>    122
>    123		return crypto_aead_decrypt(subreq);
>    124	}
> 
> > But luckily, it seems commenting out the memcpy(iv, seqno) line has no
> > effect (I think that's because all algorithms rely on either seqiv or
> > echainiv).
> 
> I may misunderstand, but which memcpy() do you refer to ?
> If you do not memcpy, then IV is always null, and the nonce reuse is even
> worse, no?

Yeah right. I thought there was something dodgy there.

> > > For example, if
> > > the last packet produced by segmentation has sequence number 100, the
> > > IV is constructed using counter value 101. Then, a subsequent
> > > ordinary packet not going through segmentation is allocated sequence
> > > number 101, yet since it does not have the flag XFRM_GSO_SEGMENT,
> > > there is no increment, and its value is constructed from value 101 as
> > > well. Hence the nonce repetition.
> > 
> > I don't think that happens? The other packet will go through ->xmit
> > too and use the wrong seqno too.
> 
> Which "wrong seqno"? The other packet will indeed, go through ->xmit,
> but its lack of XFRM_GSO_SEGMENT will make it skip the increment and
> reuse the previous counter value.

Eh, ok. I thought you were saying one goes through ->xmit (with the
wrong seqno because it has been incremented) and the other through
->output.

Then I guess this makes sense.


Could you:

 1. fix both bugs you found so that the code looks similar, probably
    bundled as a small series (this stuff is not ipv*-specific, so
    there's no reason for it to be implemented differently)

 2. rewrite the commit messages based on this thread to be much more
    precise and also less verbose

I'd also reduce the amount of crypto detail about GCM, I don't think
it's super relevant. Or move it to a cover letter.


Thanks.

-- 
Sabrina
