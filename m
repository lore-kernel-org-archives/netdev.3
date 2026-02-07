Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67551224B15;
	Sat,  7 Feb 2026 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770432774; cv=none; b=ZGJ+BBeyfaCnsVWFkaxZIqOdOTGT6QSnuRBLMI9a4fNK8pZqgIDCJDkKgHJFT56xvaMrhjib/AVH8LZ3+SdIVl7HLtMzCjwkOm1a40y6fxgaXv2Hk/2kbxlz0ZwmzZn3PT66H8/iT/RUoVz6T00jBpc0lqtH4cMJs1VnB6PjxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770432774; c=relaxed/simple;
	bh=kxjun1BWNuFXLpEBFc0Ir8jkJxWfvTdKLQC2FCip3h4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcwHZSULH4UwGLPqIlTVO9+nJHcaAjVZDVGkS6F/zeOXWKqs+pi6darwahrZNdBB+ZdW4g6GQaZJblXidsVcF1ypxNj3uKYnzBGr5kmNSvXWWN2S/ZkS0Z4DZ+OtqV038b+w01qZTk7Gr6CFqlfk/8nIOduHlR7A3fgFj9Of6mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NixxRPmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NixxRPmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E882AC116C6;
	Sat,  7 Feb 2026 02:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770432774;
	bh=kxjun1BWNuFXLpEBFc0Ir8jkJxWfvTdKLQC2FCip3h4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NixxRPmkCoAnRXXR4/pBuDVY+9/bych7yVCeqk+uvjV1daAhAbaNYcQU+suQjvvIU
	 RjavF9nZ+KXEqLhkJBO7vgzDj3te+mPvcRydeMemPrvtjyEZm0zsqOoIJAGvgsdCUB
	 x1b5k/CpOmpjCwBZihpU2P+W2DuHPFEe9+yUz+9tBnvF5B+QiOFDNGdN+JC4QHMXaj
	 j3usHcsSYHY3gWWYxoJk9tPMvGSUGAENkxj9KrtCW0p4wG1xzmjFUtv31+XhK/HcpO
	 3qYXkoIjiA1uXyIyIU97krRoovX/aBDzTnzlPBry+P/R0daTyLaeUWvb/W23+iK3lQ
	 WCHlyTaSnnlqA==
Date: Fri, 6 Feb 2026 18:52:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>, Chad
 Monroe <chad@monroe.io>, Cezary Wilmanski <cezary.wilmanski@adtran.com>,
 Liang Xu <lxu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v13 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <20260206185252.77cb182b@kernel.org>
In-Reply-To: <aYVckqToPwzR75EO@makrotopia.org>
References: <cover.1770211259.git.daniel@makrotopia.org>
	<2da8267175bfe7b8ff92d67ba5aa88755fab1710.1770211259.git.daniel@makrotopia.org>
	<20260205182117.41618f8d@kernel.org>
	<aYVckqToPwzR75EO@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Feb 2026 03:14:26 +0000 Daniel Golle wrote:
> Other drivers which operate on similar APIs (many GPU drivers, for
> example) also use #pragma pack(push, 1) in header files defining
> external API. Also there all external API definitions are kept in a
> separate file, away from any of the datastructures used by the driver
> internally at runtime.

No pragma pack in networking drivers please. However, well considered
your application of it is the next guy will sprinkle it randomly
and argue that it's already used in other places.

GPU folks are special, they'd probably write their code in C++ if they
could?
