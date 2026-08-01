Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F91F3D56
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545424; cv=none; b=elFsVa1p1sEzZss9UdQfzTPlV/VR6QYJ1Acp5c2DvNqF4KQbQXn6G+oOzkTBSEr2Dp2Z/ubnGxkiOVLdYsrsLNmUxx5+OPWmBQ0W3aKwFTLKdfjC8R0CWf8aVlbCs5GZe8Bt0K7jcn8fgTmqobzlfANhv/kC+g9CUrNYbAZY8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545424; c=relaxed/simple;
	bh=DMnNk8HsoP5r+FxJwap9HXgCg5vNbkb1ZsqnRAyp2lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vmct6Uh8mEgDbiLsv7GGA6fXgEMBYSnY6RI37Mig5Qu14FKbIl3Sf5fBcq8DJNycJUJE+JgO5bAEl1a5E5dXX/bqNDoEt0eaDnM7xKdO/B5aXg19e3BYBVHve+0QqeCgv9UEqgxLpY0BrySBajDGyMkXT3v2sp2aroyhQPeulbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRpMoJgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRpMoJgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0C11F00AC4;
	Sat,  1 Aug 2026 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545423;
	bh=7hGY500+XO9Sn2Zp+cLtzFuE92laInSNH7+h7KTvv+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lRpMoJgRIzDXDJtzZcnb4Ni0Wb/pXUGDEigZRt3hccNltU/Nog9A+DQLBMKPprzo2
	 b00iHJizVrQYMI9eGi9FVqnajxBpYKDbpoCDaChnwGTCutOojKavxCBf3NXTjcNIub
	 shX9soZIzfVaqAqKltkmD8Xjr1OYDyax2TYalgjbp1B+PwgfwiHWjTX11dtXVbLMNs
	 q61hQvvY8UCGtaudCuih8H3lKMI4fNy8YAz9xPJ6dL+xPQ568/2XyKc3BJybHYRERX
	 HKMpBrYbHT42HUB/gc5tztiRsMrBZn/m6a2lRxgSCoY9yEgr7DLMRXS5zv4tAKDY76
	 Q8dWKdcDMX3NA==
Date: Fri, 31 Jul 2026 17:50:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, vega@nebusec.ai,
 bronzed_45_vested@icloud.com
Subject: Re: [PATCH net v3] net: loopback: ensure Ethernet header is linear
 before eth_type_trans
Message-ID: <20260731175022.18fd8744@kernel.org>
In-Reply-To: <2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com>
References: <2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 23:04:14 +0800 Ren Wei wrote:
> loopback_xmit() passes skbs to eth_type_trans(), which expects a
> complete Ethernet header in linear data before consuming ETH_HLEN
> bytes.
> 
> If an earlier path stripped or shortened the Ethernet header, a
> non-linear skb can reach loopback with skb->len >= ETH_HLEN but fewer
> than ETH_HLEN bytes in the linear area. eth_type_trans() then triggers
> a BUG in __skb_pull(), causing a short-packet handling crash.
> 
> Check pskb_may_pull(skb, ETH_HLEN) before calling
> eth_type_trans(). This also rejects packets whose total length is
> shorter than ETH_HLEN. Account rejected packets as tx drops instead of
> crashing.
> 
> The analogous VRF path is already protected because its IPv4 and IPv6
> callers pull the Ethernet and network headers before calling
> vrf_local_xmit().

How are we getting the short frame in the xmit path?
Please repost with the repro like you do for other bugs...
