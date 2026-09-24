Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9147987B
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790247198; cv=none; b=EvSivd0xYUSg2GMs7vvzWKG+trHcINIeNsN+iJAbZnyUgiNmEZ+AHiw8QGZn87PVn8tB0ZBNyHjMoF+JiN1FfFEpSOeKtfEoySg09HBECNDt6ba4gVCDqN5tlcyNQAuQH4VP8uuXQW9UZKr3nLGL+p/kRPYlBe/NNQxVXDE9BIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790247198; c=relaxed/simple;
	bh=ZNlS2VW362ezBBZp//m0P1zzdKRCpxSiyx3mlYG3naM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUu3YmxOVcm/aA+6s9Yre/dk/20LsQehnVNBfk+paLetJphYDXFVbsZx5Do+O7egppwvoF0YuDoaT01dJsJqF5wDl/cq+CboqZ/gxe0sr/k5fsovC0M8GzlnNeG38ALxDiIoxNY7CA+u1Clq5Xc5kpngN+bJoWUXJPpdgLauIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meveuyyl; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meveuyyl"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso10696965e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790247194; x=1790851994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aO66w+0+GR4OMLqnZwveMtiQVAxTOUEKgF3Bwr3C71E=;
        b=meveuyyl12waWtdqCnN4IbHPHwpofKJhNEqA5qH3g5Ch1oyoDi/JHk8A5fWV1R46Im
         /+BN0SE5lnu9GBN95nlvbAxVmZFsHC/gG7AkmaXHmeUIe6U73W7XXMOzHXAjff7XElkK
         tQ77pgNIRjwZEQgSITO0c0mau/App1HJep8vUyJW8dAQdJo8TYFjM4iEkSaoldcPHPG4
         wchUmqzoqAAlMmoN1Xx3ZNOdjQPzIdIOBwkMDZ6HyQgX1AhwTFM0fZRO83oWSgLSFry9
         r/6iTw4gKc8c9mmV5epO1J81J6aY6UQGt7WjqOSA5xQj6Qwr1wsw58QlagE2+9pDa13E
         bOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790247194; x=1790851994;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aO66w+0+GR4OMLqnZwveMtiQVAxTOUEKgF3Bwr3C71E=;
        b=wVB5HrPtZ+SL5yWw8X61XAW0PQ3bsXYnMEPd4+d6aQ39gzGaRpYuhqg8FSTkc28vsj
         bEk9J02ZloacaB8rY5C7KYc2d/rnhAYbh256fjqHihtcPc+BlLlTzkEsqZY5423PjubO
         maSFmQpeYSAQrVCemFuyqx12TmjLUhBOnUwI1IeHjBWvwcNmq0iJnQF0675BMnvCvJ3z
         b9dtJ4uzK9fJwXVztE109CF0dfbo6Kx6E/+6D9BRhxAzPsykuSJJHiGX21yTkfXREmln
         ugrAgvs/br3l6/hb9j0X4BVWXxHUZ6sgS4kP6NQmOjKEYkpEjSWEqoon+GJulJiix68v
         Cd3g==
X-Gm-Message-State: AFuF++mXDo/mg7K3UIfaaMs4cassEb7i+vCMqbBa4v+b615Ma1DTbznU
	L615/X7VZGw47N1kcDEjtBOnQY4bM7PzoF2Z1UbhmorcPnjLdhil55OX
X-Gm-Gg: AYBFou12BOuO7BmTVT94BQkx8sbCitV8tePWlwenoApr0XCAv4I5OvSY8Cfr8D/FPVo
	81U1QvacCHarJsaq/tTY9gwBrI6dnk21xG1kpLX9PxQp+A5Fr2ok9PcOzlgDa0tC/dIjlc8SUbh
	ulqh77IRKOp7dGOd6l/HyEnJZJ1NevDFgAsrPRg3V7tLzEsSXVLydKVYt70j4Lx9EocPw5DgSgi
	/3gv0tes6wk5r8MxlUiv8GQy+FA76kvPF8ONSs5M2i/dr48Qd7NmjU6ZJ3X66THYFcUEe7R/XCY
	l3RA2GI0XflZuxhRN00JMd7qmhZ2AmpR5faKEVWwSnS9hg/Jdg9d/xA8KfVXtlL7AdssSMpPjup
	oObeI3G6o0HjOJQfnWE4ZdDW3xzPoYRMJw/MpWJ4X5cHKFZpTsdwygLZsN8FJ0ZOJQdMGqqYF41
	uSSVu20Ex0YDKJ3cHfoG/vn7+HaPLNLoL6id/BcjKcIZsLJOk88gqd+Uy7WRrPM2La93y79IFLQ
	oPnwvhNUoPjvv9YDhiT0K/GOzurxnbAVlWQ
X-Received: by 2002:a05:600c:83c5:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49fe66c8623mr32047335e9.1.1790247193865;
        Thu, 24 Sep 2026 03:53:13 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf158147sm109924915e9.0.2026.09.24.03.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:53:13 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:53:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 keyong.sun@smartx.com, Ilya Maximets <i.maximets@ovn.org>, Aaron Conole
 <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Wang
 <jasowangio@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Alice Mikityanska <alice@isovalent.com>
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP
 segmentation
Message-ID: <20260924115312.505d89fa@pumpkin>
In-Reply-To: <20260918084651.3022878-3-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
	<20260918084651.3022878-3-wang.zhan@smartx.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 16:46:49 +0800
Wang Zhan <wang.zhan@smartx.com> wrote:

> The bounded resegmentation added by the next patch splits an oversized TCP
> GSO skb into several GSO skbs which fit the device limits. That needs the
> GSO engine to group several MSS segments into one output skb, so let
> callers bound the number of MSS segments each output skb carries and pass
> the bound through the existing __skb_gso_segment() entry point. Ordinary
> callers use zero for no limit.
> 
> skb_segment() only groups several MSS into one output skb when the device
> advertises NETIF_F_GSO_PARTIAL, or when the skb has a frag_list which can
> be split into uniform pieces, and falls back to one segment per skb
> otherwise. A caller which passes a bound asks for that grouping
> regardless, so the frag_list check is skipped when max_segs is set. Every
> other caller keeps it, and the bounded path is only used for skbs which do
> not carry a frag_list.
> 
> The output stays a GSO skb: gso_size is the original MSS and gso_segs is
> the number of MSS it holds, so a downstream device can still perform
> ordinary TSO. Store the bound in the existing skb_gso_cb scratch context,
> alongside the call-local data_offset and mac_offset fields, so that the
> segmentation methods keep their signature. A zero max_segs value means
> that no bound is active; it is not a persistent skb flag. Clear the value
> when each output skb copies the input header so the temporary limit is not
> propagated to the next GSO call.
> 
...
> @@ -86,7 +87,8 @@ static bool skb_needs_check(const struct sk_buff *skb, bool tx_path)
>   *	Segmentation preserves SKB_GSO_CB_OFFSET bytes of previous skb cb.
>   */
>  struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
> -				  netdev_features_t features, bool tx_path)
> +				  netdev_features_t features, bool tx_path,
> +				  unsigned int max_segs)
>  {
>  	struct sk_buff *segs;
>  
> @@ -117,6 +119,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
>  
>  	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
>  	SKB_GSO_CB(skb)->encap_level = 0;
> +	SKB_GSO_CB(skb)->max_segs = min_t(unsigned int, max_segs, U16_MAX);

Why min_t() ??

David

