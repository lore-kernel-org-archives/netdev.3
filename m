Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E24CC28E;
	Mon, 28 Sep 2026 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612393; cv=none; b=Lespv7r+PyNKORAlBIwPTwVwj1RdSpGAdjKBhW9RkGAqMCF9szV6rRwjURfWMSLA+S8iqtK2cKWg2f9EFTcfJ60MRJlDPzbx0M1wq6uWPOYL/9n19UCIMjQwS8zx/1beX2YxPNByP7yf+k5UF8X31tDQ0mT+lORCpiIwagcLNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612393; c=relaxed/simple;
	bh=yYp5cNpz5PUJlVY2FeZV6LwZCwiiKi3/QRuJB2IWDY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB71OM86cFQNKiR0cPzO2rKMMe/dlaWEZ45gLIAqaqhtbh5H1e0veK0EDVW+s0AIxgldnuRsynqRjoSo0s44YRKqxWjrV1qlNXdw71CBq2hjY2a5ZsSUbNhLXPbqV9PNbz+OrpQfYcX9duIDFH5s/tkwp8QaecSuLJD25Qyo1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Mb5HDv5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nloeQVgi; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Mb5HDv5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nloeQVgi"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD84F7A013C;
	Mon, 28 Sep 2026 12:19:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 28 Sep 2026 12:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1790612388; x=1790698788; bh=DAOUi7GOni8Cdt13HRrVrHIrYtOcSvfh
	HmGjs3zaKgo=; b=Mb5HDv5kyhfrbVzvfOLW+XIIVMTQL+yR00BjcDBa46oMJNQ6
	sRE1ZYJ9g4F25wHkaC4Il6adqzmKqzWfizi/dOJ03OnrhbfAOyklCXHRujQEqEJ2
	npmRudNFGJm6WAIGlMkchDXzDEM/zexOzApqkupSGSqAhUKziMJzzUGgqQzVTPw0
	7XlBRJggps2rSrT/NuiuWviAr0Tw1z9vBrHXlCMC9nl4AGxtaemdoFWiMb2LDpvF
	GDH+Nd2wE1jhLyRKDR2xT39bxfd5dKCqlKsyfgRSmw1aY+bxesbKfdd4Q46s7YMt
	TZ8skvBSb1MMRSECEDbR9jHWBRM6AWIDN5dXrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790612388; x=
	1790698788; bh=DAOUi7GOni8Cdt13HRrVrHIrYtOcSvfhHmGjs3zaKgo=; b=n
	loeQVgit0lxbnAs8lbTIP31qnytuaxfDLpGjU3jl9yBMWmn0Mhj3HbzQYF2RIlay
	ynA9jZHL3/CYQ1vCPTmV+xHA46gjoYqsXUF5m0begPd3OcVQanCZvMsVln+LcyaY
	IJ1JlhLTo+eof0rl5TwXRXAAY/9xSHqU/VdGMGFNpeWXCyBDnv970w0CQ5QQj1ek
	X3UBhQjQbM1amtWDPDrP9G6XzeB/KCOD3ecg7bFeeVGOzMLbj+WDWTL7VFtHWnYE
	LvNZrPqgWQKwWVz2I1ao2zrIRjCDUSzC+NdvXXWyIZcZIgNA64sGT7RmThVl7yh7
	lNTYBl5sLrfrCV60pjRuw==
X-ME-Sender: <xms:opO6auFOuAlQs-0rOx45PFDNyu0fYRca7mS_Ymi--wMOvm2rsZ4LRw>
    <xme:opO6apYbEeIppsWeIzs3qp0OZuP1VlSzg-FF8r3QKUtAsZtGmXW9hqf2b_TOeXfNu
    904DT56YKqbBmV9byYQiLqLLtqPk4fagR5qPdCqntm86xVMQdop36nc>
X-ME-Received: <xmr:opO6aoDeM5aEEoHW4kfB8zJDWiKgG4FovsIcjz87krbag77k1OebBEcsne4m>
X-ME-Proxy-Cause: dmFkZTEKrLlBov6TwZWkyHY7vVe3QYJBV7mCf6n//dlldHBQzDjnruk48aV/I7ITarStts
    qBU+DRF/WoOAKURQvN//n2ZCuoFOql/FGv9uyMPDXqEZHq9/OXnGMYkGVtN3/qIGVRkkC6
    jH6wqkc36JLxXKjiCntr52CVMxbuJdutf/C7JUYLoKW8wrRI74CQzZdSwkbZ7WkI0ac9q6
    TY6KQizdV2oliV4ZoMuZBPoMZqJNUNxPdgrfGTwg7nnECgYMSiMo1ubCmv3TfYehJTrfUz
    zMuYA+lGhfcbUQ51y4miIHcqcz2zZbpc4GHGhhBGtPopBMUykZ7wNa0OOPD5Zfz+QIrrFS
    QV3WJQ3CoSVs4q+h+zF+nTtaBl7sU76zvudxMC75kkbdCDOiHVty79+JbkSI/Udat2vUsG
    HsfL0nPStDqiBnbxDkAjvkabP5yI2T2umZ96rvFadvRXDJ4mRyyITbkDpIO7ZBlwcB3Tiu
    7yJO2/3p6+qXdp/tq6nKO+qTLj8LrLm+rKmvmrpcYjzx8kq4xOmAA/UBH0dRV+EmNutQA2
    wDr5icP2OqCD0vVEHbOw7fyzYMQgT8vAUkiCiikZgzSe0ZR1aBNeAM/KTdl3+sLK3cIOnp
    nC1HIrftSYO9XV1z0TO4Ml7icH6+mPlcszxkzT9L/hRKPyyfYOStHGJmWrUQ
X-ME-Proxy: <xmx:opO6apm3ZTqCUlFa8I2g34FeeBERBTp0cE5d5wg1kg7poDHeSMyYiQ>
    <xmx:opO6ahxg28IbescFX7o81v3W3RHb0Z3Z9pFUeJ-P7DLh27C6ApnwKQ>
    <xmx:opO6arQxemb7MECvhm5KXJd9jQv-olFKbeMuFC9p03txODN7DNvFTw>
    <xmx:opO6ah9w3Xx_vGkMdiOthA518U252SjmY-rCGl4FgAbyxZbQ1_40vA>
    <xmx:pJO6asR5U5GtQerjydBmhRxpB0aIWeQfDOGM1gekg9x6YnrFrnLytzsZ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 12:19:46 -0400 (EDT)
Date: Mon, 28 Sep 2026 18:19:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: esp6: fix off-by-one IV counter causing AES-GCM
 nonce reuse
Message-ID: <arqToNCxIwi9CZ--@krikkit>
References: <20260925095105.446269-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925095105.446269-2-Jeremy.Jean@oss.cyber.gouv.fr>

The subject prefix should be "PATCH ipsec" for IPsec bugfixes.

2026-09-25, 09:51:06 +0000, Jérémy Jean wrote:
> An off-by-one error in esp6_xmit() advances the IV counter before
> encrypting each software-GSO segment. For N segments with sequence
> numbers X through X+N-1, the IV counters are therefore X+1 through X+N.
> The following non-GSO packet uses X+N for both its sequence number and
> IV counter, repeating the last segment's AES-GCM nonce under the same
> key.

I find this description very unclear. All I'm managing to understand
from this is "there's some situation where a packet isn't getting the
seqno it should". I don't know where the "+1" comes from since for GSO
the function does +N (xo->seq.low += skb_shinfo(skb)->gso_segs).


Anyway, one process nit and one question on the code:

> The repeated nonce allows first a passive attacker who knows partial
> plaintext from one packet to recover corresponding bytes from another
> one, and second, an active attacker to recover GCM authentication key
> to forge authentication tags without recovering the AES key.
> 
> Fix this by saving the complete current sequence number in esp.seqno
> before advancing the shared GSO sequence state.
> 
> Fixes: 3dca3f38cfb8 ("xfrm: Separate ESP handling from segmentation for GRO packets.")

And if there's a crypto leak, this should probably have a "Cc: stable"
tag.

> Assisted-by: LLM
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  net/ipv6/esp6_offload.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
> index 2289552..05d13cc 100644
> --- a/net/ipv6/esp6_offload.c
> +++ b/net/ipv6/esp6_offload.c
> @@ -346,6 +346,7 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
>  	}
>  
>  	seq = xo->seq.low;
> +	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
>  
>  	esp.esph = ip_esp_hdr(skb);
>  	esp.esph->spi = x->id.spi;
> @@ -364,8 +365,6 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
>  	if (xo->seq.low < seq)
>  		xo->seq.hi++;
>  
> -	esp.seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));

But then esp.seqno can have an inconsistent view of xo->seq.hi
compared to what esp6_output_tail/esp_output_set_esn will see
(xo->seq.hi++ just above this)?

-- 
Sabrina
