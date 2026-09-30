Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5D35C694;
	Wed, 30 Sep 2026 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733579; cv=none; b=lz0jxCtqs4kqnkuDg+qIyR+JUZWXGJwXNmWyrpYRfvLFSo2xtcZirOkMk/a4FZPgQS9zUaEo6TF2MD6F/F4ab0Jwx8ojZVkbA8t4KqEWNR2hiJU0s/c9+mMJ2ZMNQT3r6zRPEC5J45IOEZobN213QkcvR1f2QtxC0MH8ptWKD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733579; c=relaxed/simple;
	bh=KFGeCKbg4CYXwolsSNFD4SjR0QSQDZ4XOsA3L5iCQR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQFxyXEgoebtmy6hyh+udj06i/jVLQhWNp/YYWSIqFNS/uzenTCPhz4XFb7ANfLnxQ6RHgevcxFSkODG8dpZEVIAyuU6Ow6GTW8CU7nSq36IO5lyVwUefja+BlxlfCEbXMGJUgogxeMR+D14cO4EA61qvsV42icxLeSVKouLBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REtHWVNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REtHWVNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031D21F000FF;
	Wed, 30 Sep 2026 01:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790733577;
	bh=0vLjdzZVo2qjctqqDpE5Ro7QbiQoISQRnLovdDe46Yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=REtHWVNLtp5xQUCYPa1SNv2wi1HPGDYr4bMdLX8DmmFWKRvTZO94mb+fuKwphevzm
	 BbuXAJo2x+BIfNeo+Mdhaa5263nz4Dae5Do+Q2P/a6KIGP6sBRc43sSthi2fu7/ES6
	 z1/1j6h1vUR1BRTIziw6vk0cQlhEMApW148dwC/60GAuofVdgWwGNjpH9vrgppHIH7
	 hNwkBH3uNN1S21RVOt4Mg35BzoN2ExDC0FRWHRoopz7DDuMMq5T155eVYmpGkjmsxT
	 dfxwW1uh3ubmIEZreQOlSP2EqGECgSqR42LCqVAUiwMr/d0MMqEhhTnzM6bT5TTywK
	 lWU7k4swLgxpQ==
Date: Tue, 29 Sep 2026 18:59:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Quentin Freimanis <quentin@q-lab.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Lars Povlsen <lars.povlsen@microchip.com>, Bjarni Jonasson
 <bjarni.jonasson@microchip.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sparx5: make ports inherit the switch base mac
 address type
Message-ID: <20260929185936.687250f9@kernel.org>
In-Reply-To: <20260928045012.30178-1-quentin@q-lab.dev>
References: <20260928045012.30178-1-quentin@q-lab.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 21:50:12 -0700 Quentin Freimanis wrote:
> 0 is NET_ADDR_PERM, so userspace thinks this is a stable address. 

Could you please explain the end-user impact of this?
Unclear to me from the commit msg if this is something that broke
your deployment / scripts or maybe you simply noticed it from code
inspection / LLM scan.

No need to repost, just explain, I'll add it when applying.

> Fix by tracking the base MAC address assign type in the sparx5 struct
> and applying it to each port's netdev.

Generally no need to repeat what an average reader can easily grok 
from the diff.
