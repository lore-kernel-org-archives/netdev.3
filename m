Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382233;
	b=pBq4p0Ac/wZpWfWG8Kon3h4AZpxU5NFqHLV0afMZD701Lkalyq/LfI9c7fu0Fs30l2We
	 RBDk7RG09JA8ZcU19DuF8Gk+Bw+Ta0XvhnP/cb0+qVJECG/TwujmHmO/jAwkIFExUmzzW
	 /Lv5vJpkdK5oJmNPRxj+2Qu3N18eNxIK9GmBcRhaHerAUcPn7k1rl6tf2aKgu+fFY/NeB
	 sJ39oD0daF28whufNxPPxPHPE1rqptyZMEidSJODb6DT1D+l/S7spqAIaVgFf8pFxHPf1
	 9gTg33hnJdB8DdVwCxP7sQyGD86bi4xEPyKkrU5IX4EaKLyfygyugW/f/qFlUVuVbXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382233;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=vZmhzNJgV5CAL9JNozhDRi5mRDcMfAzNPj0gFy9Ckfc=;
	b=wOC3j8lOKNy+ZcOe9amV9S6bPBy6C6TdxQtdgkF5gzjuSpkFweJ2R+449YUU8Pk4U+S2
	 TNJS4d31/S9LjWcJbPjqJ4JOhQC+83Uza3+uX/XPBrPCH+3mOKApGun7Tt5JY0w2h7U5I
	 Ntd9JjDdSmFFXu0T6Ne12gDzF1cOnbQaqu0IAVu1XKwmBBXQDRfV1TBnykzvD9qF1ecO4
	 ONnK/yCd/Gef9Hpkj5iGj4OPM1dARX1FQeJ0MYVEbsITx/M0C3Wv9t+5pK3VMhdDOL83h
	 c1wTLq2AxdO1InSK46Gnj7qyVYVyvRpapsOKycAYUM3AyZGUugMUGWQ88c6JFXYkD7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=glOqB8QV;
	arc=none smtp.remote-ip=195.10.208.62
Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93137606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 07:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93137606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=glOqB8QV
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jPZtQ1sJ8zKnlY;
	Wed, 11 Nov 2026 08:30:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794382222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZmhzNJgV5CAL9JNozhDRi5mRDcMfAzNPj0gFy9Ckfc=;
	b=glOqB8QVMfd3uxkpuR4to9uGzjHvX65w77N0OW6jitWBiyHYx75DFujyhA3YCnryJwQEum
	uusPJqHRqWC92WKmgWIwt8782SXY3IKnvxLf4gbVUejC+ATeOuMUAQmx9PWdOvgo7Ilynh
	D0QMyNyqvr1QC5VRGkLNFeS02PVvMPtxh5wsibPvc3D97CdXTGY8DGNyrwccHkcuBuspPs
	OfxRvQ2t01MzuTZttPEvKwcvf0/igYhMXlXaks1v3meTZT45dAhWI65nf7C77jOnwmhAQp
	PYYXEYOOU77/LI4av/CuGiT23LHRn5M3UaN5rqgkA5iDV5K59aTSX92craTeeQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net-next 2/3] ipv6: add ip6_dst_lookup_flow_cookie
Date: Wed, 11 Nov 2026 08:30:09 +0100
Message-ID: <20261111073009.18754-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110152928.4ef1bf6b@kernel.org>
References: <20261110152928.4ef1bf6b@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jPZtQ1sJ8zKnlY

Hi,

On Tue, 10 Nov 2026 15:29:28 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed,  4 Nov 2026 16:53:30 +0100 Ralf Lici wrote:
> > +/**
> > + *	ip6_dst_lookup_flow_cookie - perform route lookup on flow with ipsec
> > + *				     and return the matching dst cookie
> > + *	@net: Network namespace to perform lookup in
> > + *	@sk: socket which provides route info
> > + *	@fl6: flow to lookup
> > + *	@final_dst: final destination address for ipsec lookup
> > + *	@cookie: where to store the cookie for the returned dst
> > + *
> > + *	Same as ip6_dst_lookup_flow(), but also returns the cookie describing
> > + *	the routing state the dst was obtained from. A caller caching the dst
> > + *	should use this cookie when validating it with dst_check(). If the
> > + *	IPv6 FIB changed during the lookup, a route dst no longer validates
> > + *	with it. An xfrm bundle is validated by xfrm and ignores the cookie.
> > + *
> > + *	It returns a valid dst pointer on success, or a pointer encoded
> > + *	error code.
>
> Warning: net/ipv6/ip6_output.c:1325 No description found for return value of 'ip6_dst_lookup_flow_cookie'
>
> You need to use the appropriate keyword (Return: or Returns:)
>

Yep, saw that, nonetheless I was hoping for some feedback on the general
approach, but I'll respin with the kdoc fix.

BTW is the kdoc error the reason why netdev/contest reports "Failed gate
checks"?

Thanks!

-- 
Ralf Lici
Mandelbit Srl
