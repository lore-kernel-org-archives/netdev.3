Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761078;
	b=cmRt/bH+CiPW4eN2+U3ko0/H6KK5xhcbUJxPiPX5K2w5d6kLiHI2reasM2CTUIrWtba8
	 +La2HI790XlDMJoGOglOFzrPetm1Qc04WfR0stP1wV9x5/ihPm7/7jfHXG12cOJpDI43E
	 2G8AvHHG/r2Wp7Hh/Fb9CaHEM+upzAs6c+OkbdkxEOzEow9mx74agPyFPAi2ZU4T9x3/4
	 bC/ppdx/63PQN5Heqi4oK+RUMIkoFA3Vy+xGwHqMu1UWCFtiORg50B7uolHlgnFPEED9O
	 hp/3KkmybjvBQEWatuRlz5lyol3JFVWtQVsp1/E9NuHNjYSWeY7jy+j85fLxq9E+aYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QxPkYmlqBpasJs1WNWIGsKH6gd/q8cxBmo1mIv7+8yI=;
	b=q9bmjQf9HZfYawPg/Yux39jciT72VeXEu52fbWvU1RbY2Vjdph4BQwKlazQqyE1eSQK8
	 dyo3Egc1J4xi16+XlmqJKGXHQiZoLtRhPFSHW/4HMpXPBYNK0q6b7kl0L4IIg+09o5Wz3
	 /PdtYioOhh3upfnbWASsQwMLPgddxHUHFCwUo8VrYC2z/HjlEQc7z8Cuxa2CYCPYAdWle
	 Ke98ztuohZQeMCIJzP+nR2bFAFl7GTDkKa7w/N25SL7M0ospxD729iHcM95M0w/XMsdQb
	 hI24ydFeuc5ia4K5xTDenQKASpPZoFY/I7mwO94WyJp3ETPnhNzFiAZE6+HsjKvAxrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzGhqyFu;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD0606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2FD0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzGhqyFu
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-98febe968deso150155241.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 18:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793761077; x=1794365877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QxPkYmlqBpasJs1WNWIGsKH6gd/q8cxBmo1mIv7+8yI=;
        b=bzGhqyFuCIXCI0/3pOA+aFEpc6RuNGXb/lg2KpREMuIOg17ECJbjM6qTFAnSsRM4/5
         cxWn7qbQvdlWOD2dvIFdMg6ymScNRWJmuzAtPmssGx8AmhIT31Zgv2EkKnyao1gRCnCQ
         QBnfdMXopU0Zlpcu7Wg90ZGWxHQeatXIs27/mShpFEvE3ILq19kcchKpqniXpyUKGj7S
         0K/777U+SZir9PxaWUtpSh157nHleH92xvoqkYrnq822wBq1qI6rn/eU6LZ8LkWpS9IV
         bpq2r95PjSYx8euCbch47UBHt+AsP3vaHCsUw5D/5CCtsZlhpPPCzot8wYFiWDRy3ien
         Dc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793761077; x=1794365877;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QxPkYmlqBpasJs1WNWIGsKH6gd/q8cxBmo1mIv7+8yI=;
        b=C43Ycqn+RCyrFr6MZkTXIVB/o2dkPU5I/Y7oioKw0FouV4Ardh0N2o52wjiyfaFhEo
         ZkF9AnWp8kogwRXkEeZCu4TvRYGP/yqFWvshR+bVXXF5esESeIZe54+5epZk2ARez0gx
         Di/UieH2NjGcsZdWsUp6bKGycsMbDdL0XWfq/fFVvQ37JQkN/Abe7gM1vkq803VdKwiX
         3tXs7Li48JUcibSLpV96GtjmsklnFTKFRjaxGAPe/zrhvDLFz+XtQe2Rl9MT5+rnGGk4
         W/jj9rkIbiZucaNFKyUN4A4O/zzpvIACUKQaudLX8UDUCxc/D5QPBWtzC8e17aMp5Bpf
         P0lA==
X-Forwarded-Encrypted: i=1; AKwUvByYIT0DDYod4VsQX8MDxTlygDaHSy+5NGv0x21MdLfb22C0Hlq4C/tjNpdyZYnbmoqi5MLexoc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j5Pa4SeBr5i4vOFtGmih5fLGjk5CSzl5ZonyJHpSDTS7XgXTH
	vLp1qsGcWSazaYKk1YHba/hhbgbBOBMKcQEPgRAbM6xS+rOJpVaxjWgU
X-Gm-Gg: AYBFou2LS7EsSKsgAFmhtmQSbGXUrYqsEaUxlzECLnxycVix3gRWw7v2lDRxuaX62W0
	kv1++3GLUr34RLal3kzdZ8lfgHb/MLJBRGbBz67NcHCCtJvD+dswfqag+AaG0ijAv9XPQsP7/ri
	LJnKjQgeh3Eddj59SNOBUAKATlN/6wxtUA0rlWeuo5TqwGMPOgloc/4EliPajsmbi+xx3kmlZlS
	ZaAH4Jbt3S8DQN87Q/Ydh2VMPtPvKtCXE+FX8ZAU+d0InOM9AhILLUyiZ2Mb6xHrt4+W0H42S5P
	1OnIHrzwTqUxH8odWpEKZZ4xjRkA/HwoX1ptiYMjWI2CVY17R5PFfVh6iv/Bt3frQIkeRrE1SF7
	YXKmxbkMONdCxIwJ7A6bQmEqpB0b6Jj3D/AsdkEVpMg4YSlKzpgeIwjnXL6knpm6nn9zXQ3zuF2
	VD1FO1WTTGdh2JVDya6+9P6ixR8JWx1I6dJiyv7RdzHVmGu8/0e6oTGFc94HeP6H2eb49Xvi/Oh
	g91G+bhkHHeTHOjHXoMzJ6kPetQ+nmsz2LpFK9KF2SnfgF/oveICcJGONufTvPM2v7IQD0LBRTt
	u8d7N2j2FL3kJSTSZF5k9Mb9zUs2b7gnAL2QcBtU5OGW0RZtq6gGGzuSi3mTr/VxQ1FPi1r+6cP
	iylyh+n0pk9okByelBJL26tIMOwplbRwWHz10tZX/5gayWDAmNL17VyB3LZDAqTCFjr9Q/1g=
X-Received: by 2002:a05:6102:3706:b0:7bb:c382:2ff4 with SMTP id ada2fe7eead31-7d0726ca2femr5422927137.20.1793761076663;
        Tue, 03 Nov 2026 18:57:56 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d277d13753sm62688137.10.2026.11.03.18.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:57:55 -0800 (PST)
Date: Tue, 03 Nov 2026 21:57:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.2b23680b4ca01@gmail.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-12-54ad0ab57614@toxicpanda.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
 <20261103-b4-skbuff-bug-on-followups-v3-12-54ad0ab57614@toxicpanda.com>
Subject: Re: [PATCH net-next v3 12/15] net: test the skb layouts skb_segment()
 refuses
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

Josef Bacik wrote:
> The GSO KUnit test only checks layouts skb_segment() can segment.  Add
> the ones it has to refuse with -EINVAL:
> 
>  - The non-uniform frag_list with SG on, which used to hit the
>    BUG_ON(i >= nfrags) the existing test steps around.
>  - A frag_list member that has its own frag_list.
>  - An skb whose len counts bytes it doesn't hold.  The data runs out on
>    a segment boundary, in the middle of a segment, after the last
>    frag_list member, and with GSO_BY_FRAGS.
> 
> They warn on CONFIG_DEBUG_NET kernels, so run them with the warning
> backtrace suppressed.  Also update the comment on the non-uniform case,
> which still says SG would hit that BUG_ON().
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> -	/* TODO: this should also work with SG,
> -	 * rather than hit BUG_ON(i >= nfrags)
> +	/* TODO: this should also work with SG, rather than fail the
> +	 * i >= nfrags check in skb_segment()
>  	 */
>  	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
>  		features &= ~NETIF_F_SG;

The previous patch also addresses non-SG.

Do you want to run the new tests in both SG and non-SG mode?
>  
>  	SKB_GSO_CB(skb)->max_segs = tcase->max_segs;
> +
> +	if (tcase->err) {
> +		/* the suppression block doesn't run if it can't be set up */
> +		segs = NULL;
> +		kunit_warning_suppress(test) {
> +			segs = skb_segment(skb, features);
> +		}
> +		KUNIT_EXPECT_EQ(test, PTR_ERR_OR_ZERO(segs), tcase->err);
> +		if (!IS_ERR_OR_NULL(segs))
> +			kfree_skb_list(segs);
> +		goto free_gso_skb;
> +	}
> +
