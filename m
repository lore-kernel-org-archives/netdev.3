Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2581389108;
	Tue, 29 Sep 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675274; cv=none; b=NRms8J4NiD2NUcqxYsoIHyXnXdfQXBtbA5ystS4PUeuMTCdWnYln+LuoOuo4zjYKZygXilfOcMFCSHofV6vcHG6Qs02+OJu9gX1xuLEFb0NxGNwogrtwW7s+MdyEdTZyIEeiNHxMSlszKZ9HmLqZ6tVp0sZpY/ogIKGOU9uGw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675274; c=relaxed/simple;
	bh=rEuxxfzkL9sm1FhKOTCvWx8YEdC1w32sHm+MkcqNlSw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=F6SQQ7zYyfvliXdWGQLtYCoJiMEO7ZwyiB50Os9VJUhSBW+ZHhskEmPovYg9T5xlQ1lZSSOfQK17xnqSOsv6jSwS6T8t0yCmtrZI9nEP5DeijFZQfVrfrLcR2D+6ONP4dZ9E2U34zrczeooNvDtlpZORlJaBAvztvoqHX2oMKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=b0QaBFJj; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="b0QaBFJj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LWPlVOc4u6RU9UGM4cwX/BHsN+66TqLVJJ0MfWKvl8A=; b=b0QaBFJjng7mxiv/rjeBj9LA/N
	iIv59cMwvPyxtu5FxE6Lg2EXi4g0AEcEKzHdO8tPdlVG+CuEASKhn6ZfMRED4WKyjp2nPpOCpU4ww
	iDpoSmWSrMN/3nLoCQOVP6xrqdXbW+KJuk34HmObQByoYaSa0VREMXbYLgMiHV0WibGW+NVOh50zR
	a7IQGIBk1hTqqN2iahYLrBQ9+sRGEdWYiFzFdr8xvnTxjea7CmVGO+zFDmffATy/vdefTOB4sXOP0
	XtOsHHe1wWze6QuBiS3P3dO/Mad201ZEX4Mw16iWjegc/7CQW9WhctNwYXVN0fbK0BYeGr5X8dO3O
	/tyaL9wA==;
Received: from [::1] (port=35718 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xBURC-0000000A3Qa-1QV3;
	Tue, 29 Sep 2026 11:47:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Sep 2026 11:47:47 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: esp6: fix off-by-one IV counter causing AES-GCM
 nonce reuse
In-Reply-To: <arr8x3a9Vqkg-ooM@krikkit>
References: <20260925095105.446269-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <arqToNCxIwi9CZ--@krikkit>
 <c443bad568f4e03d05b848b1b245707d@oss.cyber.gouv.fr>
 <arr8x3a9Vqkg-ooM@krikkit>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <29a10d01b87fb1c5f9af445aa7864351@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello Sabrina,

On 2026-09-29 01:48, Sabrina Dubroca wrote:
> 2026-09-28, 21:33:41 +0200, Jérémy Jean wrote:
>> On 2026-09-28 18:19, Sabrina Dubroca wrote:
>> > 2026-09-25, 09:51:06 +0000, Jérémy Jean wrote:
>> > > An off-by-one error in esp6_xmit() advances the IV counter before
>> > > encrypting each software-GSO segment. For N segments with sequence
>> > > numbers X through X+N-1, the IV counters are therefore X+1 through
>> > > X+N.
>> > > The following non-GSO packet uses X+N for both its sequence number and
>> > > IV counter, repeating the last segment's AES-GCM nonce under the same
>> > > key.
>> >
>> > I find this description very unclear. All I'm managing to understand
>> > from this is "there's some situation where a packet isn't getting the
>> > seqno it should". I don't know where the "+1" comes from since for GSO
>> > the function does +N (xo->seq.low += skb_shinfo(skb)->gso_segs).
>> 
>> I tried to be as explicit as possible, but I apologize if it was not
>> good enough. My understanding on the full GSO processing isn't as
>> deep as yours, so here is another try at explaining.
>> 
>> The bug happens after software segmentation in GSO. When a large
>> amount of data needs to span across several packets, software
>> segmentation splits it into N smaller skb. After this split, each
>> smaller skb holding the individual packets has skb_is_gso(skb)
>> returning false, yet each skb keeps the flag XFRM_GSO_SEGMENT stating
>> that this skb resulted from a segmentation. Consequently, the skb
>> goes through the increment below in esp6_xmit():
>> 
>> net/ipv6/esp6_offload.c:
>>    355		if (xo->flags & XFRM_GSO_SEGMENT) {
>>    356			esp.esph->seq_no = htonl(seq);
>>    357
>>    358			if (!skb_is_gso(skb))
>>    359				xo->seq.low++;      // <<< increment here
>>    360			else
>>    361				xo->seq.low += skb_shinfo(skb)->gso_segs;
>>    362		}
>> 
>> There are N calls to esp6_xmit() for all the smaller packets, and for
>> each of them, the current sequence number is first written into the
>> header, and then the shared counter for the next packet is
>> incremented. However, the value esp.seqno used to construct the IV is
>> derived from the counter value _after_ the increment.
> 
> Ok, I see now. One call to validate_xmit_xfrm() that calls
> skb_gso_segment() and feeds those N non-GSO skbs to ->xmit one by one.

Yes, precisely.

> In that case, the seqno used in the IV wouldn't match the one that the
> peer will reconstruct using the bottom 32b of seqno present in the
> header, and it would never manage to decrypt anything we sent.

I don't think the peer uses its internal counter to reconstruct the IV?
The IV is part of the GCM ciphertext and the peer uses that value it
received to decrypt the payload. AFAICT, the decryption is ultimately 
done
in seqiv_aead_decrypt(), where one can see the IV copy (121), and the
actual decryption call (123).

crypto/seqiv.c:
     99	static int seqiv_aead_decrypt(struct aead_request *req)
    100	{
                 // ...
    116		aead_request_set_callback(subreq, req->base.flags, compl, data);
    117		aead_request_set_crypt(subreq, req->src, req->dst,
    118				       req->cryptlen - ivsize, req->iv);
    119		aead_request_set_ad(subreq, req->assoclen + ivsize);
    120
    121		scatterwalk_map_and_copy(req->iv, req->src, req->assoclen, 
ivsize, 0);
    122
    123		return crypto_aead_decrypt(subreq);
    124	}

> But luckily, it seems commenting out the memcpy(iv, seqno) line has no
> effect (I think that's because all algorithms rely on either seqiv or
> echainiv).

I may misunderstand, but which memcpy() do you refer to ?
If you do not memcpy, then IV is always null, and the nonce reuse is 
even worse, no?

>> For example, if
>> the last packet produced by segmentation has sequence number 100, the
>> IV is constructed using counter value 101. Then, a subsequent
>> ordinary packet not going through segmentation is allocated sequence
>> number 101, yet since it does not have the flag XFRM_GSO_SEGMENT,
>> there is no increment, and its value is constructed from value 101 as
>> well. Hence the nonce repetition.
> 
> I don't think that happens? The other packet will go through ->xmit
> too and use the wrong seqno too.

Which "wrong seqno"? The other packet will indeed, go through ->xmit,
but its lack of XFRM_GSO_SEGMENT will make it skip the increment and
reuse the previous counter value.

Regards,
Jérémy
