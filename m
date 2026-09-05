Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655EC3515C8;
	Sat,  5 Sep 2026 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571428; cv=none; b=DQaBQ/qFqMetPitwaWww6IkeHqzgj7uMxcLQy2xMuYuJ7R2QEnAG1GaxBMy04nnPN4/mhWY3JrzmQ5S0iFIhJC90PPbJNfrIcp5ePJwayNerTFcxO7M7O5jJOQPqDnjqbxCgKNZqTr4rIwIJjlSpsis4YaYWsq9uyBEGxF50sj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571428; c=relaxed/simple;
	bh=y4MKsRuquLutAa46iPPVz/iFmNG4ysJlzvZls5UYYNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNo3C36BLJyS/A+U5t4H1MMYSz6zwVKHi7eexiPMGMaaCNn9y3y8ma7Z63WaeGErK91fWyNTLWOT/7G/i64GdEsR0feHE//7y+mS9TnKHw8PGx1fxmV8zyrhbuBeLRkxc/qN0R1BDCqaWBJvvxanq0Gp5uil/3HFzX31eRmOFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/i5FMFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/i5FMFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08701F00A3D;
	Sat,  5 Sep 2026 01:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788571427;
	bh=BgRLy42KDMCRsmSF2wlE+sRMMvVYMqhAUYDo8bPgsFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P/i5FMFqgooKMHlaq+kkOC+fCnRzNbZrMbOwKgUtIoKtJiMLktEeAWscESNYkRylX
	 9IFDejiGwR502VhUvP0KVvKYZNF+DJLcMog7dzlmvAowpibq9Y236QTsg+CkOUpVc/
	 u+L4n6J2Tnjx1q0LRb+IwyemS2TvubfMP1YM/GbWnzi7xeh9IQIlVyflxOWKp2ntNt
	 sP10fWlfeCBBL8za6QzDgSySShuJxndpilOVMMRLYaZVRF5Fm7+TxBbgbuTgED114u
	 M7aGicfaWBc0U+otStlw7dcfXfCNtQfiWH0Gk8cwUKVLIS2ZiE+8LqB+gDwTYTSNK5
	 02SDVnaC8R2WA==
Date: Fri, 4 Sep 2026 18:23:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net-next v2] net: dsa: offer a flowtable to the switch
 before the conduit
Message-ID: <20260904182346.2940a049@kernel.org>
In-Reply-To: <20260904092719.534318-1-julius@bairaktaris.de>
References: <20260904092719.534318-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 11:27:18 +0200 Julius Bairaktaris wrote:
> Tested on IPQ8074 with an out-of-tree DSA switch driver that handles
> TC_SETUP_FT (openwrt/openwrt#24806): three flowtable unbind/bind cycles,
> hardware offload of routed flows after each.

We don't accept patches without an in-tree user.
