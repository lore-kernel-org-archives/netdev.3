Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F9315D5D
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021020; cv=none; b=e1Ag8P54DA23Q1JonPBE1gKPDmbGRlhWAHBi8I3uBxN3JV7ACWHLsq8TnEj3vAG145BahYUr7wq56OfukHewLRJzkNU5dbHiotTO/bS+T5Yuzd02jnesWWRGaHu1k39NUQixQIIGrmugNU3XmTWV2Ls+N6xGbXg2hUXC8TYeFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021020; c=relaxed/simple;
	bh=6tXAxd+v2xAxNlhZghAK8+uFxmiYIhqZUqHW8zggfOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgYZdbFzlDvUAidtrKC1FxKoZ4VQuSBXy0+i5ElII+jqmycA6E3uWnx7qY0K3dCzayUHPvTplmhVByY+9r8z3VXrUD9H80nIDU0G+NR2tN8Tc1TC/7qVn3uTo5kDONn/7Yr37IvCIpRI/WCGV4+FOAAK+HUTn3Hlgp0UegLPm6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBxGf7IB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBxGf7IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DD41F000FF;
	Mon, 21 Sep 2026 20:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790021018;
	bh=sMv2oSUP90aqZS/zVaf1f6IcxV9zhziENpChuW292Oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jBxGf7IBEjVtUtdFR968gzqZnmVG6yjLy8IfBJoyPWvgSOSZdONfeDC6gAN0eles6
	 zG5WRRl+t8pyGfww9iTb4t0d4qiAzPiXzUeXYQTdxRewn43R/FtL75QFyDdoRMiscO
	 dPCg+yGYdA237xWMfdRiSdIpKRmd1/P8aNVGo6yPfqD897V/Ftwl0iNP8DHDYl7MC5
	 01UQIrs56NfCRIO8YzluA5GFMNx9v0YgB1ZK3VkrqiB8Y2l17FP6cyfaDtixeHpJt+
	 MUSInP0Q1WoZr1CBY/JgtgY/krCMcenRBhTAEkye4ASUDYhfI/CNGSCLYpKbBz1hwL
	 h+Km+gPDDUvJg==
Date: Mon, 21 Sep 2026 13:03:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/5] net: ethtool: add KUnit tests for the
 generated RSS key
Message-ID: <20260921130337.57d93c2f@kernel.org>
In-Reply-To: <20260921183758.1812310-4-edumazet@google.com>
References: <20260921183758.1812310-1-edumazet@google.com>
	<20260921183758.1812310-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 18:37:56 +0000 Eric Dumazet wrote:
> Check the property from the definition of the Toeplitz hash, independently
> of the way netdev_rss_key_init() achieves it: an aligned block of 2^q
> consecutive values of one field has to land on the 2^q queues exactly once
> each.
> 
> Four checks and a control. rss_key_property_test() does the algebra for
> the named fields of the usual hash inputs, rss_key_grid_test() sweeps every
> 16-bit aligned position of the key, since the generator does not get to
> know the layout the hardware uses, and rss_key_spread_test() hashes the
> inputs of an actual burst and looks at where they land. The control,
> rss_key_checker_test(), feeds degenerate keys to the rank check so that a
> check accepting everything cannot make the others pass.
> 
> rss_key_alias_test() covers the other half of what the generator promises,
> that no two input bits read the same 32-bit key window and are therefore
> indistinguishable to the hash. It sorts the windows instead of comparing
> them pairwise, so unlike netdev_rss_key_init() it looks at every distance
> rather than at the multiples of 16 alone.
> 
> The field table includes a PSP over UDP over IPv6 layout, whose inner TCP
> ports sit far past the plain 4-tuple, because that is the case the offsets
> of the standard layouts do not cover.
> 
> Commenting out the fixup makes three of the five cases fail and leaves the
> control passing. Keeping the fixup but skipping the redraw fails
> rss_key_alias_test alone.

Is this AI generated or do you think there's some genuine value here?
I don't want kunits which can be trivially re-generated during
development to be merged. But perhaps there's some genuine value in
this one?
