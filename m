Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2C4BB26E;
	Thu,  1 Oct 2026 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895092; cv=none; b=O9+Bg21wLO31R0utc4n7nz4k6u4rxJGfnve4tmoIx+kFe83DRhyFQFltTakSXuCm8jDnfEUG5eWhC9Mpy9l6xYh2RFQj6WJ+0jZgJNV7Zhok7VycPs6rNbdE1YXnPpcrS2a+BL+ujAQHKy4aeo/I30lgKzulIVBSCPIvAffLdwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895092; c=relaxed/simple;
	bh=n4kx9jeehwxg2SXhnRjk2B0JeREdKHfzS9FXM+qPXRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av2mvKP1H8xtQ/AgJzpiTY1GZjB+trlowdULQ01D2gsWAp9OM/4QdjLqsieujj0zZAeRTW/f01mrofM4TOFWYINNVJiB304g12rDG5kPRrqK/PjmQ+hy7ghcOscLGeWhLw0zwY8b32y/dpd5nOwWVoAim5nRb4awlxoWM3fE+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldjR3A7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldjR3A7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2581F000FF;
	Thu,  1 Oct 2026 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790895090;
	bh=n4kx9jeehwxg2SXhnRjk2B0JeREdKHfzS9FXM+qPXRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ldjR3A7pnRAQQQFSIBCDJJfOnukvn+v7m1w0K+PrOV6TNV4OjKiPT7LKDO51fHQOJ
	 FY/caVymwUjpkuqIPLzfNEzQtGREVRdzVjAzyiivRzzzgJYkdtYUrz7ZeNDDwY7/ta
	 +jorPlh1ihquMjgiT8Oo4S4O1a1KoZD61GqsLiBC33v57DyrohNTfx9py5F6KHPYcW
	 yAZVVmNShu/kMpJDaxJueguZpb8bAkqfTnC1kq0+n+nlsXQf3nROy7Z/kdbAF/4/k+
	 A/pK112Jz1v+DnCrUyNkocodGtiRzqRKw1Csyh++yeZ9dZWckrxZW+owUtITFxOYzj
	 saGY9SWkuv3eA==
Date: Thu, 1 Oct 2026 15:51:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Message-ID: <20261001155129.51ea9930@kernel.org>
In-Reply-To: <e7f574ab-5fcf-484a-a5bf-fc94d45b2311@nabladev.com>
References: <20260924180607.60932-1-marex@nabladev.com>
	<AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
	<af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
	<AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
	<b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
	<AS4PR04MB9338E76DB4A59D70F1D6AB2F888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
	<e7f574ab-5fcf-484a-a5bf-fc94d45b2311@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 03:34:09 +0200 Marek Vasut wrote:
> Jakub, do you want a revert of this one, fix, or follow up patch ?

FWIW the answer was follow up, thanks for sending it!
