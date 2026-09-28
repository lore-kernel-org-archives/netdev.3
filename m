Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3D5111AE;
	Mon, 28 Sep 2026 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624034; cv=none; b=baJk8Kj30GZDjI2hzOOp1yoD3/m1LSzlF2U4Q3+eP3Esi99SwaWblErR7RfPqOtVKIWgYp4Jq5uq+1IVn05YwXcuA40R6n1ew8N1AW+BUXJEKE50mXzT/vYofyGx2FMD+PzdpxlGwqYI5NwktbSksUV/6s1gjdd1HvyG0xt5eK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624034; c=relaxed/simple;
	bh=TZXUc+JXs+gAQXSDuFsSXyssJ3RIo/BWk+GJU57jzGU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qNGFJ8/wUecPjVNd6rZXUK/J1nEpN8pOrrpW4CIhCHeOboFb93uf+ExKvCTizHA+7YTcKo11zHiSp1TfJ9yBSPPFENRyFomKSSMUeOM5YhDDDqPtNTn6ljXsN7VCCEnqBUB8ZRfPHjn6MJrUJ84QPZa2cOy+LJ/A13TubezpCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=UOoV6Jae; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="UOoV6Jae"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rrDUFU2JQNcEGVGD0hIJffQpe0lrlcdkz1a7QhdkYVM=; b=UOoV6Jaew3ZXqVFSzrERR6EgcM
	ajckqdQZVBGYdXIQdvGvRLlejW/Ye4XzAUR/4KA3UerQiT8dIzea9g+ZeLP+t95itoKa/K/5lqmeN
	Qlma393Gex90P8omqNE52O3HkFfwV6XUNs3y95yplW2Ww524tL+zXdICCaKAXruyZv/IX/wlZANtT
	nf1UY/FjtdJHr5KT05TSC/GaZE5FNxg2uW/hmRY8vHz+SDPdc7zjnyyiEIdcKjwTqX38Nd9DsJs6v
	nA5JMf05zgTiH4tSGnj0lOhkDKm1ngcaDqNQL4soLls+U+JSsMdDXJLGFyH2U6AzUBJOy4Sl/JzQC
	twRKQqXA==;
Received: from [::1] (port=54962 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xBH6e-0000000DOy3-0r31;
	Mon, 28 Sep 2026 21:33:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 21:33:41 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: esp6: fix off-by-one IV counter causing AES-GCM
 nonce reuse
In-Reply-To: <arqToNCxIwi9CZ--@krikkit>
References: <20260925095105.446269-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <arqToNCxIwi9CZ--@krikkit>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <c443bad568f4e03d05b848b1b245707d@oss.cyber.gouv.fr>
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

On 2026-09-28 18:19, Sabrina Dubroca wrote:
> The subject prefix should be "PATCH ipsec" for IPsec bugfixes.

I will try to think about that next time.

> 2026-09-25, 09:51:06 +0000, Jérémy Jean wrote:
>> An off-by-one error in esp6_xmit() advances the IV counter before
>> encrypting each software-GSO segment. For N segments with sequence
>> numbers X through X+N-1, the IV counters are therefore X+1 through 
>> X+N.
>> The following non-GSO packet uses X+N for both its sequence number and
>> IV counter, repeating the last segment's AES-GCM nonce under the same
>> key.
> 
> I find this description very unclear. All I'm managing to understand
> from this is "there's some situation where a packet isn't getting the
> seqno it should". I don't know where the "+1" comes from since for GSO
> the function does +N (xo->seq.low += skb_shinfo(skb)->gso_segs).

I tried to be as explicit as possible, but I apologize if it was not
good enough. My understanding on the full GSO processing isn't as
deep as yours, so here is another try at explaining.

The bug happens after software segmentation in GSO. When a large
amount of data needs to span across several packets, software
segmentation splits it into N smaller skb. After this split, each
smaller skb holding the individual packets has skb_is_gso(skb)
returning false, yet each skb keeps the flag XFRM_GSO_SEGMENT stating
that this skb resulted from a segmentation. Consequently, the skb
goes through the increment below in esp6_xmit():

net/ipv6/esp6_offload.c:
    355		if (xo->flags & XFRM_GSO_SEGMENT) {
    356			esp.esph->seq_no = htonl(seq);
    357
    358			if (!skb_is_gso(skb))
    359				xo->seq.low++;      // <<< increment here
    360			else
    361				xo->seq.low += skb_shinfo(skb)->gso_segs;
    362		}

There are N calls to esp6_xmit() for all the smaller packets, and for
each of them, the current sequence number is first written into the
header, and then the shared counter for the next packet is
incremented. However, the value esp.seqno used to construct the IV is
derived from the counter value _after_ the increment. For example, if
the last packet produced by segmentation has sequence number 100, the
IV is constructed using counter value 101. Then, a subsequent
ordinary packet not going through segmentation is allocated sequence
number 101, yet since it does not have the flag XFRM_GSO_SEGMENT,
there is no increment, and its value is constructed from value 101 as
well. Hence the nonce repetition.

The fix proposes to move the computation of esp.seqno _before_ the
increment.

> Anyway, one process nit and one question on the code:
> 
>> The repeated nonce allows first a passive attacker who knows partial
>> plaintext from one packet to recover corresponding bytes from another
>> one, and second, an active attacker to recover GCM authentication key
>> to forge authentication tags without recovering the AES key.
>> 
>> Fix this by saving the complete current sequence number in esp.seqno
>> before advancing the shared GSO sequence state.
>> 
>> Fixes: 3dca3f38cfb8 ("xfrm: Separate ESP handling from segmentation 
>> for GRO packets.")
> 
> And if there's a crypto leak, this should probably have a "Cc: stable"
> tag.

Noted, thanks.

>> Assisted-by: LLM
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> ---
>>  net/ipv6/esp6_offload.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
>> index 2289552..05d13cc 100644
>> --- a/net/ipv6/esp6_offload.c
>> +++ b/net/ipv6/esp6_offload.c
>> @@ -346,6 +346,7 @@ static int esp6_xmit(struct xfrm_state *x, struct 
>> sk_buff *skb,  netdev_features
>>  	}
>> 
>>  	seq = xo->seq.low;
>> +	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
>> 
>>  	esp.esph = ip_esp_hdr(skb);
>>  	esp.esph->spi = x->id.spi;
>> @@ -364,8 +365,6 @@ static int esp6_xmit(struct xfrm_state *x, struct 
>> sk_buff *skb,  netdev_features
>>  	if (xo->seq.low < seq)
>>  		xo->seq.hi++;
>> 
>> -	esp.seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));
> 
> But then esp.seqno can have an inconsistent view of xo->seq.hi
> compared to what esp6_output_tail/esp_output_set_esn will see
> (xo->seq.hi++ just above this)?

This looks like another bug, similar to the boundary case I described 
here for ipv4?
https://lore.kernel.org/all/20260925095128.446450-2-Jeremy.Jean@oss.cyber.gouv.fr/

Regards,
Jérémy
