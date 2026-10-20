Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524508;
	b=t1Jt2lPn2F8hgP6is8a2n3WiTvHm5IruNnxvYWOjoLMC+eClF+zu0Xxbu5Xs9yib+sr9
	 zONkx8SbJoH9qSDLR0HdKGUMl7mOSiQ1AXrYK1PCCU80i6YpeKNVAdXJ1fOGyqhK6tF3g
	 1SRzqG5XahDU9gLaFnqGMYfHpXRP9VUzoH1F1p+MK/WWX6LlcrTTDIXDFfdzFejj7h3BG
	 6oykTMZmUTjyZQSYYQvekXWtLJymOP1DZ/oOwPOu5FgIFTGPcBr7ChznsWljFcSK4jmN6
	 81iOnuEg3uJOwH8w7J5awHIMDYjSloQXXgwI/Qemm6IBELxlTZcLiK0L262Sj7xhrfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uM5DkyTcQcIY9+zos5+5Y8SpLbQKEPMCEH5xBlRrlEY=;
	b=yfOKdcRAAt1MEH7T8ugqOgZgXtbTd8YgKa44Inw84Z7DJRqGn6LAHFFbIK20sh7LmGTs
	 3S2ER4uxfC9qe5zhyHPtwPPBNAE++hEjwh0CfdzZHyzRDQzQNmUG+rAd6ZaghywUGGBTH
	 O8snxkJ92t9dFjylo8ZmohGFzl68/1zyIYEiflgE0kgG3eTKcRkgviR74C/OuwpwQnWhk
	 mHxDGNQmw1ghf9miJOu5Wf4Qld5ECVpE0mk7Glm3IPaDAtqBJ0gAPH3ie2DZSBr/yYF/2
	 NSRHkdPC3NJQHB1RlPl3/xqsWUhjg83YRbvswVvQhaOv9Oumg3Bl5XejyyyuPqoM+VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a2E1ue5H;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B123B606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B123B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a2E1ue5H
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7bec5112765so18219137.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792524506; x=1793129306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uM5DkyTcQcIY9+zos5+5Y8SpLbQKEPMCEH5xBlRrlEY=;
        b=a2E1ue5Hg5bqgPpmq5nvqEsF82upQOZJBFhKzHKklpzQNWSNnH04NyUDBNxhLCO8C0
         P1cPq2mGkloCSOsEXUNAo9h4DtNZm46J4JIJPEY8A9rckYylLP8KCZnaoJahMS2qjYUk
         p1JTU/h4WJeZ1Mbs7eRYVx1cqpMMW8Lix7XS8t1hoPdYgFXygYSMP27xEMgv31afbZU0
         CHi2TG1s3mmfcKCH2XU0VEd2jRjooPty9d4De50P2qqqvCkPnShpUdD2oVeG6FR5O2Q3
         LzWHcJM2nhzrbO2EKhPwPms2iztwlVGQgL5eR5M3YDlqulMQzEe6Yl1wS5hdiS80xUP9
         1VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792524506; x=1793129306;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uM5DkyTcQcIY9+zos5+5Y8SpLbQKEPMCEH5xBlRrlEY=;
        b=0FthUYx/erlz+ernq/r7irZYXQ63110hO2Ghoy3lfDdHDrCeX4ye+de1xL8RDDd51X
         EbUm1qvnzcHG9Hdh0soLafHxyYaXCWjvtzbgaTfFQj4cbqgNX5e16ll3wqMForCoaAf9
         PLejsvhh8Sbs+gfa0VGT/jjjMhnYVtx0ibYfPH9Yt8grmoV9cjeGKKXfpfusVC8IbY6R
         mQJXuhqLsWg79WibagvUFz6n75TS9u7egp2InQ38uFiylMN8AF9PcG2BO0u/SHjdOMZt
         dWl6aDvL5lUqaR1ij5lc0JCiIq4wmU7dYcmR/zOYvuX1Bt5HPnY3UUt7uV4kl/PH/g68
         3EtQ==
X-Forwarded-Encrypted: i=1; AKwUvByx6hUpj3tO2CEYZWTIvky6lETPKVyDEzZoKrWdhBrwjepLJhIcc6y3QVNBzwHo1DaAbLTVOkU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8vYTG6VcriQJAg+5Z9L280EVUx86NRjGs82OMoYobdBQRgsJe
	QIkhF0uuaUchbPtW7cinCYLpszAcer2EfpEAZXPkT9HPmre2O0Z1Smqq
X-Gm-Gg: AYBFou3/sEJxbLCX1ieMoWZUt7sQ4UiCrBAx+bg8bxstdGAUunc3xKJ8asH/82hs2lH
	q/LBwt5CRCDPRt4tMG90iIpz6L85Ro8LnEBrJ+MPr+1hTHab3/bjSwS+lsEsfGRRioBhbDulWRQ
	5VVMa1AWXZTh20JrxLjhDSCQCCAiR7nfvjhvLhDuCYM6CJ6q7nB39gOFiF/16mBwROJ/ZUjdA2I
	QyIS3SeFx9PTKdhx70SxV35ibdcW6V59FIXQnbNau+FOtFeLn2IdPhE8+vnwfUH5ub3jr6OwaAW
	KqgskEyTu0M2HJjpRqPVgt66hUTX5fnrycRLSQFrePScK6QFold8fXmVNG3ESzSL7v63mLnfleg
	UmVJMe50CAqjbHEz6aqkL4RrAFBz04Q1GvFFqaCnu4AarUN8YkLBgOFBuFK5r3JFb3i2MJKNLSZ
	pS2rM3JEqNia45BKYfCgf0xFDGfM4R4/E4INm/SYrb+SCqkn62tOAwoOnytMgClsSIkJ8rkYtOr
	dNtVl/+Q0wl6DCrHCyRfwc8ow8EaOCuGow/+UbrQNaL7MzA5UDZ+Ro1+2iuOAytqsgU5wK45hFf
	4CE+68E8RMIbcvxJbme/JUOMtWh13oXzYOYoYg==
X-Received: by 2002:a05:6102:5348:b0:7be:3766:9062 with SMTP id ada2fe7eead31-7cc9271c22bmr70477137.27.1792524506671;
        Tue, 20 Oct 2026 12:28:26 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc924348c4sm207823137.11.2026.10.20.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:28:26 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:28:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.317e66c2e17bb@gmail.com>
In-Reply-To: <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
Subject: Re: [PATCH net v3 2/8] um: vector: honor virtio net hdr conversion
 failures
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> it cannot make sense of, but the vector raw transport ignored
> its return value: rejected packets went on into the stack with
> their metadata unvalidated.
> 
> Propagate the failure.
> 
> Note that a follow-up patch will modify virtio_net_hdr_to_skb()
> to return a negative value on error and a non-negative value on
> success.  This is why we don't just propagate its return value
> directly.
> 
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/um/drivers/vector_transports.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index e1fb2a76fdff..8b7548458663 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -210,7 +210,9 @@ static int raw_verify_header(
>  		return 1;
>  
>  	skb_set_network_header(skb, ETH_HLEN);
> -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> +	if (virtio_net_hdr_to_skb(skb, vheader,
> +			virtio_legacy_is_little_endian()) < 0)
> +		return -1;

fold into the previous patch? It already mentions that it covers all
cases.


>  	return 0;
>  }
>  
> -- 
> MST
> 


