Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959147;
	b=u9Yw1vFytkRSin4NI1CjrcsxjQ7QuqdVPMjXVsbq8ifl2w09JA8X8hizZX8wXXe7Bgvh
	 NU8KVJxhks3KZu5h8Q0FfypkRoLVK51FY6YzsA5TlBNYzDrslAXJ3G/nADXe3VNbLbMt4
	 bMC0TzOF3/G1d+M+wA++dMr99rrNCBdToY8/B8xTlP5ispuv68Ueyuxhdzaq7UbZmHN4f
	 Q8uu09aH1W9/JHTcLv6NCqWpOniwAvLQFj5SDEgyr1heQUWOLUv+7b9YVIaaU7q78NDjs
	 h5yR/u59zzCtk/LbOCqNxr8aaS9xS+9CMYNKPsMVVrTlD7GyuHqAaCRLsk0NAgRq1yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959147;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6Z4qm8iGrcg0h1wWqhDGb3PQdYmH33RZGG9ZTChRwd0=;
	b=ezBAA20Dr904dqOOkfIut8jSVfc34nlCjpE9ThQQd3rL1drCOuYtEx7tcFFqmKBZO7hi
	 Aec2qZPxw5/a6SlnCaQUeu1NNKygTWFOWyaHSD1ILEkKG7uLEDjMevv+E1NhampC7yJ5U
	 5NICw8oSSyMeeplk3vEDZ5mcx6VTTWX6DHWVTrRb+1tOpeKWaoNrvyHG0z4Sc90VzNn+4
	 lZ5XHxH5fP3vpFuYH/5YucDR8rUpgjIS8jMzGP1lDdH9FECsnwrsQyre7gcOIq8rMc8wY
	 hxZirWVQhOZ5N12uoQED3BgL855VtAxoZEuW6MIchW90KKaDMXk6jAMC0iekdlg+1Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcTBi0Ka;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB62E606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcTBi0Ka
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183841F0089F;
	Fri,  6 Nov 2026 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793959146;
	bh=6Z4qm8iGrcg0h1wWqhDGb3PQdYmH33RZGG9ZTChRwd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gcTBi0Kak3cWqjM4MQ4BfWPcXmCeSd63AwW/p81yRqXqqHDP82cnMlt6t3PJ/beRk
	 LMuqGCn/6jHhmhvZs7O+emLpEWTGPlfStn3cTrSzCgpmk/eGg00ICKAZBndiUwmjpg
	 afmGRXu8bjyOChWMhKZGHc2X5qfoK/Q1dZz3R7F+PAFTafiJJFUpIqCV6DY4NWlChX
	 5gst7plg84SV7TmkyFJJ+LILABziR0e86q2kAdr9H/6SSmQ3SyWPGsi6pg60/LbToF
	 k0zLeMqd+GkdP2zqHZbraZ89Ldwcts0+5ptzmojVJie0awcXEdbOt6cHpxLQymAmzH
	 HlSlKANFEh23w==
Date: Fri, 6 Nov 2026 09:59:02 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: Shrink skc_reuse:4 to 2 bits.
Message-ID: <20261106095902.GE865646@horms.kernel.org>
References: <20261103044213.1336347-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103044213.1336347-1-kuniyu@google.com>

On Tue, Nov 03, 2026 at 04:42:06AM +0000, Kuniyuki Iwashima wrote:
> skc_reuse now consumes 4 bits.
> 
> However, SK_NO_REUSE, SK_CAN_REUSE, and SK_FORCE_REUSE
> are mutually exclusive and fit in 2 bits.
> 
> Let's reclaim 2 bits.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

