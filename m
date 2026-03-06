Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0BA3EFD1F
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826835; cv=none; b=St/ckZhG1NCHSqqje7YR0hsFsumJWow97s9teAl4xfKxeBkSrbKLez8x/3PV7eR5133U4CSL1iMbCrFfVGe9T/hXWb2A1M+TpRnwXpyeV0PtgbmGOATiP8/OJP1/mxGVy21TguMRYNZYfijFVv2j41JNvnkam+W1MXiVecPPL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826835; c=relaxed/simple;
	bh=eOJ31DGjCBhixVXnZC/VYjThTEkk0bey9I+ebZCYnUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUjs5bsQ33+cSgemROZilF9regdbxadRibAa9xVQLtsIGMtis+qyaTm+rX3hlrDe12klP7ad72GbMpwhF2IO7rMkRk7NXWdTdhXN7RMS2yWPqZ4NmvGGb2CV4PfyoCNg4Qg4Ax8b6qRsJ9dn9AUZS1muVAILTuH2GjIjUi34yXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRfT5CWw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRfT5CWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83520C2BCB0;
	Fri,  6 Mar 2026 19:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772826834;
	bh=eOJ31DGjCBhixVXnZC/VYjThTEkk0bey9I+ebZCYnUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fRfT5CWwacNU3Scm6FAkvHCT1/fbqKWjZW9IU0Qec22iyl53hcF+MuWxxlukveQVJ
	 0l/S0yqAnK9smIqFYjKSaAJ9ckaVGBMO1puZE6riPtREGjkZ9jKroSupxXVjqpbWNK
	 vOMvPA3qO3PG8j8PyyKRu7efQIjMa1LiClanG+xRxm6Am+3a+P9UtRDrBmZbmB6qwp
	 dc/GmbpGjcm9Ke7VRJ/EyNC6Qo0lRoacb6w12yUf1ftzRzu/fluBlf79O7Gy/jcLFL
	 bi4X1FfyErt/j18cpLJ50xn03QoLzA75KWQsNBCCOBHCYCVgYe340Wm7pmzKqILWM+
	 c1vZoeZ6lcWpw==
Date: Fri, 6 Mar 2026 11:53:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v3 0/3] macsec: Add support for VLAN filtering in
 offload mode
Message-ID: <20260306115353.28f322e0@kernel.org>
In-Reply-To: <20260306151004.2862198-1-cratiu@nvidia.com>
References: <20260306151004.2862198-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 17:10:01 +0200 Cosmin Ratiu wrote:
> This short series adds support for VLANs in macsec devices when offload
> mode is enabled. This allows VLAN netdevs on top of macsec netdevs to
> function, which accidentally used to be the case in the past, but was
> broken. This series adds back proper support.
> 
> netdevsim was extended to support VLANs and there's also a selftest for
> the new functionality.

I think it's triggering the warning you added, in most of the tests:

[   20.973710][  T194] WARNING: drivers/net/netdevsim/netdev.c:1234 at nsim_destroy+0x128/0x7b0 [netdevsim], CPU#0: peer.sh/194

Also please see
