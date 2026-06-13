Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8532C11DF;
	Sat, 13 Jun 2026 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781383122; cv=none; b=OIjBJ3befYtU8g/C9ORXo7Mjqv6X69jx2KwBStTKQ5Dt1F4Kz0R/Vz2Qo2DKFJv24FC6/0nszfS+TDOYeInivpItNTFUD0s4+kMdGt4eEnJu++S3JwfcyI/+89TA7gjtFrSC5fC4TkliIQNOdVoA+OoTSYjMEZ9lDLpBTc4KTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781383122; c=relaxed/simple;
	bh=TMcFnPdnw3SYsADReoQJoyHz6z0B0k3u/pVjFIqAqkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1f3ihFpalCWXH6kS2DBNxgmGMYQQKlIvbw1HXnURXQQb2YdTVFJWcQAenZMCNOQVU9acFx5rALsBY3KrP2QoAuiknys9KxKWV6Ff53BsQplMQamH6HVYaEdrl0cwY4qtRjyoFZSNkAOse7A+HQe2wkPxgvaY9ToM/YTIyfeexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaNVDPLs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaNVDPLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125EB1F000E9;
	Sat, 13 Jun 2026 20:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781383120;
	bh=yAfmC+aX1bZveUBO4giQMJshYhR58JyfWmxpjWM75Pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UaNVDPLs4S38PEJb5MaNt4CnxQRTtN2wwd0/OCh0ncEbnLndlZPylw9trPIMeB8F0
	 qC9rmwN8Kzt+R8znR8mg5D9lA5dTxmvkEj5opmF/DZ3sS22SctVfzrMZO8Tt26ccH0
	 hjsYIWSHBbCpnvKp1QeGciz+8Hh+jHgeOgvJySOv0AIcZqwYGKzahjrLGVtT0R17G/
	 MpYAKpw6b2eCzJtslGWfDox38Lfz7dRFBeOwgOUiIPYhYkNDUniZahBKgxs6kUHDrZ
	 WMATMM+M9rOep8AS0PFpgn3L1fTMXiNgTbEAKGpiEIjpTFzIrtt4cIZJ40i9R1Ez3J
	 cnJjSwBdUTxdA==
Date: Sat, 13 Jun 2026 13:38:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marex@denx.de, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 nb@tipi-net.de
Subject: Re: [PATCH net-next v6 3/5] net: dsa: tag_ks8995: Add the KS8995
 tag handling
Message-ID: <20260613133839.6877ed3e@kernel.org>
In-Reply-To: <CAD++jLnuBv97nUW-EdZXiLmgsUSiVLgkB0R=gKB0zYtr8JN7xg@mail.gmail.com>
References: <20260608-ks8995-to-ksz8-v6-3-d91eb43edcc5@kernel.org>
	<20260610153952.1685895-1-kuba@kernel.org>
	<CAD++jLnuBv97nUW-EdZXiLmgsUSiVLgkB0R=gKB0zYtr8JN7xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 18:56:03 +0200 Linus Walleij wrote:
> Which is what I do.
> 
> So yeah. skb_free() will be free:ed twice. The code in tag_8021q.c will
> also do that. But what do you expect ->xmit() to return on error if
> not NULL?
> 
> When user.c does this:
> 
>     /* Transmit function may have to reallocate the original SKB,
>      * in which case it must have freed it. Only free it here on error.
>      */
>     nskb = p->xmit(skb, dev);
>     if (!nskb) {
>         kfree_skb(skb);
>         return NETDEV_TX_OK;
>     }
> 
>     return dsa_enqueue_skb(nskb, dev);
> 
> The only way to get clean out of this branch if you run
> into an error in ->xmit() is to return NULL!

Yes, maybe DSA experts remember the background here, and can guide us
But from a fresh look this and ->rcv have very odd semantics.

  nskb = func(skb);

should assume skb is either freed or returned. Freeing the input param
on failure of func() is a rather strange pattern.

I vote we drop these kfree_skb()s (both xmit and rcv) and fix up any
driver that depended on them (if any)?
