Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431542;
	b=Suz35VDAzLYH3Opa7nLigFS0K4XcqiM36sPxXhQ+C3oQ0W+4NrAm5BLEX5XsxjmGu+x6
	 x0F4mqt455ayvwdIAH6KfkIBW5cIx6qfBNykFV1GaLRFeHB5BCIejQuhzfDFqHqJw0Vhs
	 3MQzr5lWrHuzpZw98uNI5v6lokBRIZE3eIb0a9iv8jVh/xJPLQcmUjoW0z7ZPrP7Nk40s
	 mtdBu1zv1JDjensdYwRaTZ5+PRHYnU6nZYtm6ijrKBYu/gwCM52SXdAIbthbd8xddKWsM
	 eDLzpD0g9kT8vXM0btXBSDGNlqZhrRnDc+tyZanlAxCnY+Ynde78Un+1JXr1VNmiQ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431542;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vZ5HrND8CS4+mH0yhzF8VKU6zP4UFihCMIaIm9EFpvI=;
	b=j2vCsbcelVxuwZoUsblW0ZkMaJVfK3V3Gi1WM2blKXPozDEZ8t3YFYoDQFcND2r1nWdV
	 9Chj3u6AjVkgmyqKZbK6NJkCCuCbVli2i06F/rFEphICzssL4Pzp3gAmHBazP9+mcFriO
	 AiABXn0Shb8tPnK8jhcJplTbc8yXf0KOVQdgO98M+UVap6N5bydLNVStG+tgv37gbQ/Vi
	 TRIHEQ1AM5TB7VHaaNiTDCqPOohJOT7co2Z01GkGJ9TNc6c6mvlGSiUMWWN6Mzp05zHPP
	 UOjlzQQ7bx1Vgpqsk8nOTwcm6+Um5s5XNVGCpsmAy1C1NAzOlQ0HwSP43+J2BlsgxDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjCuDQEY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E72606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjCuDQEY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A491F00A05;
	Wed, 11 Nov 2026 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794431541;
	bh=vZ5HrND8CS4+mH0yhzF8VKU6zP4UFihCMIaIm9EFpvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KjCuDQEYtUUhJSVeVT7hW6tzTd1MJBF2WP4KTyjrIPzya3opyufU0uTGNQEwKHRx4
	 NVKdklnX3M+rZxrDXUSGuTqyqdKeOOVQfwpLPwzNxecMu+3X/NLPwXzi5+quc+zuf0
	 wrh0czNGIeytnZpVoZCWqOlCSsjeeHAg7cLrzWril4fvXlOzLPcBRepn0CF0IjQIP+
	 zRtDp75S6sRjbA/iieEIYCtUivm3n1FbBb1d2q583UYDSNTrFFZvLPgmHfFuYWz43Q
	 K7MAaj7bMrTp0jYFAdyZIwS7iDvKPWXOcUi+B9PNWx2r1SN8+1VeO9DEZ+OxPDOPhz
	 OjaneWAKvnLBg==
Date: Wed, 11 Nov 2026 13:12:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Florian Westphal <fw@strlen.de>,
 Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net-next 2/3] ipv6: add ip6_dst_lookup_flow_cookie
Message-ID: <20261111131220.754a6048@kernel.org>
In-Reply-To: <20261111073009.18754-1-ralf@mandelbit.com>
References: <20261110152928.4ef1bf6b@kernel.org>
	<20261111073009.18754-1-ralf@mandelbit.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 08:30:09 +0100 Ralf Lici wrote:
> > Warning: net/ipv6/ip6_output.c:1325 No description found for return value of 'ip6_dst_lookup_flow_cookie'
> >
> > You need to use the appropriate keyword (Return: or Returns:)
> >  
> 
> Yep, saw that, nonetheless I was hoping for some feedback on the general
> approach, but I'll respin with the kdoc fix.
> 
> BTW is the kdoc error the reason why netdev/contest reports "Failed gate
> checks"?

Yup. We just to simply not report checks that didn't run but someone
thought that was "confusing". So now we report some stupid message
which pointlessly doubles up the errors.
