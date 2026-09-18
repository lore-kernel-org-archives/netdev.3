Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ACA48E0D9
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714288; cv=none; b=CeczoA/prl+ZyAln5BApLbNX0CLN6zxmpvnI78kzNWQiIa38Wm7ZcUR7ruI6A3l/CTHbKsDumZqt3Z2L1PG4N2CV7IfR/TeToF6wgkqwADLxTFSCPOx0r3Ek1e0k6QTrCvWCPCZZp0l/cizLp/DMzo4qDH9IhXQmchOEfqvblYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714288; c=relaxed/simple;
	bh=RHtzJR7WskfdjVof3aPbjbXcWE4vjmhx37iZ6kmmDtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqpj/KUc0WhkM6XFSU5G644TrqQC9I1VzSAOira1hG1UHbNem9xAc8NpBy+ll93UCsRw6yKr1nszUqW8zx++9gpD5wNcQdIaIXI8d3PjQzkLzg7V09Z4a2tk1Dma6spTw3CB4Y36hjkurQwqpYgU03qu2l5Q1ofJEC8KflKs8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=GSryW+kJ; arc=none smtp.client-ip=195.10.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="GSryW+kJ"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4hmNZB1PXZzKnnH;
	Fri, 18 Sep 2026 08:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1789714274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlFy7Bt1NG013BI2d1YwG67HMU9z0civ++3vM8YPt9A=;
	b=GSryW+kJR2+UH05b4Jc8DKjVRoc1Ji9CXEObB4nZKucSRYcPpGQD4qEjam39m7B0P+dSUu
	dM5UTg813pvxnEN3JJR0+eYhFDUZ/+ZyuAQdcKTB73zrXCc7EGN8Z08apmqXaORC2SFN1S
	0TsOGCU+OqOiTaBHtbNSpQOwV5hfZZnAzd4+YakvKp/pHsbMfUXQiolb3rn1Bk9Yxk6jUe
	pkaLdBJM2eFTmU6eRdJmpZt1ny3oG6W1QZPJakFS7JH/PuSsTfIcnYeYVPT87FNnWENezZ
	JxsPdsiSyB9ZFty7kNEw2u0ftdYbCVBn9oltQFR1kxtNvnY6TqV4GEZOdFcR+A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB changes
Date: Fri, 18 Sep 2026 08:51:03 +0200
Message-ID: <20260918065103.28295-1-ralf@mandelbit.com>
In-Reply-To: <58147155-1763-4e10-a3af-f8751c1505d5@kernel.org>
References: <58147155-1763-4e10-a3af-f8751c1505d5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4hmNZB1PXZzKnnH

On Thu, 17 Sep 2026 13:09:10 -0600, David Ahern <dsahern@kernel.org> wrote:
> On 9/17/26 4:09 AM, Ralf Lici wrote:
> > diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> > index 7f69e8890b5b..a28974cc36e8 100644
> > --- a/drivers/net/ovpn/udp.c
> > +++ b/drivers/net/ovpn/udp.c
> > @@ -250,7 +252,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
> >  		dst_cache_reset(cache);
> >  	}
> >  
> > -	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
> > +	gen0 = rt_genid_ipv6(net);
>
> this detail about routes should not be buried here. rt_genid_ipv6 really
> should be local to net/ipv6/route.c
>
>

I agree. Keeping this detail inside the IPv6 routing code is exactly why
I sent the RFC linked from the cover letter, and I would appreciate your
thoughts on the proposed approach:

https://lore.kernel.org/netdev/20260901122501.482920-1-ralf@mandelbit.com/

The pattern of obtaining a dst and only later sampling its validation
cookie when publishing it into a persistent cache is widespread in both
drivers and the networking core. It is racy for IPv6 routes with
rt6_info::sernum == 0, because rt6_get_cookie then reads the current
fib6_node::fn_sernum, not necessarily the value corresponding to the
lookup which returned that dst.

-- 
Ralf Lici
Mandelbit Srl
