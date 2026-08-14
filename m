Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A44908A7
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734325; cv=none; b=TveC1qGHfi3hk28ivS+kRVSm5ZiN9Onl/MQ2ytFnCqHRBmLoOIcRVtGwra31YgP20Y9/AAYtInhtIl7/UaGpSY6iOsvLLrtTVydXT/9MD83GDhVdRByjKPgLhWpUzUgDNh2NJZX5D2+U5kg9GKupc9WdAWkSokO08KmcufoCVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734325; c=relaxed/simple;
	bh=FiP6phE00NmG96nm2t73r+yx6vzPtrcJKqL87LPboiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFSqEpSA8wMvv64gH4Rt+21fTBGaM+zWuHScba7R3LIkciEOeBoWKT8UtlbblI+kVeJVpqP8vgmIAdSPl5drfl+nwYgfjDUHY+q8JaJmTsmOn3RiWQN6XCNgZVBF3PAD6Rx9GhsXa9RGljgiBVyuIxbTfngcqhPIaI65DX/MnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3FiBirs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3FiBirs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0CE1F000E9;
	Fri, 14 Aug 2026 19:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786734321;
	bh=FiP6phE00NmG96nm2t73r+yx6vzPtrcJKqL87LPboiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R3FiBirs1Hw1AwyE0+Ivt6eq3KscQuVlAJZJzRQ6ZxZ3nUbNNiohypfgPkM1tz58q
	 pZgolGYK6Absaik8eUMZzDIkBUu3s9KHwV8K5g881aCMQJI/fbkA26gBiP5Sg8Xx4i
	 hrR2+/QyfLksmAR3AJHOEQcHm5WbedK9o/Fk4YL1nsHIWc7BCy0MUNpbpBR1zSfNn7
	 +mOhAv3vXI2kKDXFqm4p35Tw1uGN463cGya8VKOVaWol6CoV9ySV/nmD7U8IEFZgv5
	 Z0qFB7AoA4qcWEnf1g23CvZjU+81Vc7JWNZmbKkNLhI/bOkeLxLEJHafACBVYSkNHx
	 USVJjKHwumVlw==
Date: Fri, 14 Aug 2026 12:05:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Nikhil P . Rao" <nikhil.rao@amd.com>
Subject: Re: [PATCH net-next] ionic: Add .get_fec_stats ethtool handler
Message-ID: <20260814120520.11e24409@kernel.org>
In-Reply-To: <20260731214021.15279-1-eric.joyner@amd.com>
References: <20260731214021.15279-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 14:40:21 -0700 Eric Joyner wrote:
> Reports FEC statistics totals and an 802.3ck FEC histogram. Per-lane counts
> currently aren't supported, and the only expected histogram format from
> firmware is the one with 16 bins from RS(544,514) FEC.

To be clear this patch is now too old for us to process, you need to
repost. Before you do - double check the 'shiko, it has things to say:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731214021.15279-1-eric.joyner@amd.com
