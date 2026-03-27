Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445A2D1913;
	Fri, 27 Mar 2026 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582391; cv=none; b=UIpPnh7olJ7YNji4D1/MVpYx4uBoPvBsp4lnpsqOiYyGMHOFnjXoJuHBRDPfQq9OXKn0L8qAk+hCQPC/YbMtPkEvhGeYxv08CU51HDjE7/yp2JXIxj2JhwPZaMC9qrbR9DommP4a7dGdYuxcyPh5tsb2LDjjW4k+EpRPLscRHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582391; c=relaxed/simple;
	bh=Ahes0bRVeMeX0ndgrm2OFvt19SDC8aoxqBIwwYN0JDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwRBJKuYTgzKgmoqsv03qEOdBU4crhF6Bnte8cLG9FjTAGfQIr7aIFjGQkcJhdS0vuuiSPyKcx07AE302BxGfVznaECJOtjSvhPbAiRhwUAjhldMrwU23BV0NLE8ADEOCnhEHnVba0ak50zzH/ibElQf23GssC0Bn9WgLx/g9qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWnVqUfT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWnVqUfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2136C19423;
	Fri, 27 Mar 2026 03:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774582390;
	bh=Ahes0bRVeMeX0ndgrm2OFvt19SDC8aoxqBIwwYN0JDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DWnVqUfTVXU8yKycykz1liEjBjX4FR8N8yvr1Rjo3gme/oWSCUgLuZdMtCWv7euYh
	 xf5CPnx26w3FLpCsJ/ltB8LMTr43S1IWwuL4srVfIVKZuIGpocsdyOfLf/L0nFrkfq
	 QjLn87FA4EFShHcg4GHtWdZWvaGbeNbDjJQ/P5/uLhRQf+hV8q2FK1JeNw+rkdjZgW
	 ikBz/H6AzKNCstlffxKjXJWOkEgMp00PCHvGiH5FjJG+6MNHehQuJ2HmLvYMBoCH8Y
	 /bgr1l9ScOK3aR2cc3m5kDdUTLo68EXfzdlPAaos+FFzAfjQPgt2/2he6mWNcKPZ79
	 DrZBTf3AzceFQ==
Date: Thu, 26 Mar 2026 20:33:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] Add support for PIC64-HPSC/HX MDIO
 controller
Message-ID: <20260326203309.7154152d@kernel.org>
In-Reply-To: <20260323220254.3822444-1-charles.perry@microchip.com>
References: <20260323220254.3822444-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 15:02:52 -0700 Charles Perry wrote:
>  .../net/microchip,pic64hpsc-mdio.yaml         |  68 +++++++
>  drivers/net/mdio/Kconfig                      |   7 +
>  drivers/net/mdio/Makefile                     |   1 +
>  drivers/net/mdio/mdio-pic64hpsc.c             | 192 ++++++++++++++++++

Speaking under correction from PHY maintainers but I think we need 
a MAINTAINERS entry that will cover Microchip MDIO, or at least the
files you're adding. Important read:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
-- 
pw-bot: cr
