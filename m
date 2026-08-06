Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E0A3D8121;
	Thu,  6 Aug 2026 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025106; cv=none; b=R/JDD5g68Jv4FMNB5iMdgtq76GDnm4Ikd4fr1O/lAnIkv3MqO9PbTHswGIuHDE5pxUx95WdKKKctupQgP02YT0YrHl9c3DqMqgV8aNmOBQR9ZzZB/CR6mFupdvZx5PytoC5JAnHU4+8F3r9WZGmO5xV47es/xcMAhbyCFXyWrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025106; c=relaxed/simple;
	bh=wZW4I0x4EPg5zB1FMyMommNDV5q3CIKAaT1lgdEdKYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hejgjzaY028xIwIMQehWFSuezSslv9adVmuCQhyBIWzRcuqBnBcoGn1AE64IpO54FiS+93Evz2ph/zOQINyZFPCNNUF3Cc+kwF0oLlLfI79St8u0zeCjQH6G0veRmN6zS0ix905hF3EVbfM23PQyLCupx+FV854vqukopg5MpCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot6DbSk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot6DbSk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B071F00A3A;
	Thu,  6 Aug 2026 14:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025099;
	bh=wZW4I0x4EPg5zB1FMyMommNDV5q3CIKAaT1lgdEdKYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ot6DbSk9yBUJwUrgiDktpRbnmBehYKXWQYT2PnmF4v1M5QlMxUgJ6YBnh8jBAtXLy
	 +0KBoiZ33Z6VGqo2DvP48xCM9On1uAMivKytnwyQRMMU7e3x8p4EngwfH9pRys8FyR
	 K2l6VPRuavsGKfU0oz2f24sdPoKo70btFaY4HNSEDH2zRyt3kY3Vb8+ZsmT2rArBR7
	 9jTpC2PLaSdflQeK5hMQX0OrkbbT/fv7bRbCBz+26P7r8CmiN4J7Ymn9dSwg4eADRk
	 Z2y7Qub41nSAjtrf0VrqystgYtclvNRLVKrDP67rEoN4xWV+vJnX1Fe8dGmx4VEC0u
	 CCJZsj03TqO0w==
Date: Thu, 6 Aug 2026 07:04:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Polak, Leszek" <LPolak@arri.de>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "Conor Dooley" <conor.dooley@microchip.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: macb: fix stale data returned by MDIO reads
Message-ID: <20260806070458.171e495b@kernel.org>
In-Reply-To: <DKHQITXDJJRP.3MD70TXXL2516@bootlin.com>
References: <PA1PR03MB110596D36E77DA32E1FBD9099C8D22@PA1PR03MB11059.eurprd03.prod.outlook.com>
	<DKHQITXDJJRP.3MD70TXXL2516@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 06 Aug 2026 10:57:42 +0200 Th=C3=A9o Lebrun wrote:
> Have you yourself read it and understood it fully?

I'd venture a guess that the answer is "no" since the author also
didn't bother reading the welcome email we send to newcomers.
Telling them not to repost rapidly..

But hey, why would they read things, we can have reviewers do the work!
