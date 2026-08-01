Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F12F7478;
	Sat,  1 Aug 2026 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785543401; cv=none; b=DTHO2eBOKWc/vzJGsJfPsSc3VUEAQBPw8l0uvBJwz/10weTefjCzD7TiFxS2ZuT/tIjPw4dkXcGFhhnm5gstqOSAASdpxx+wjYRhlsXcxIJQj68Pyp/XK12YBpIyNcWAU28dXkaaXcXkO0q1U90DHdevPFtYErHo8ALShpy++JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785543401; c=relaxed/simple;
	bh=5ympF4m57kediFqkdLx+xv+HBkW0kxLLtwV+MP/ZGrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZaVobzVZjnBur4J5KJBOKbKne8d3glofRELyCRc82dh2MgVzUeK+OfYSolc0Y0mJ3G0tC2S3Xk0CCp9gOmQM9beZUMzYfdwhv+pMTAux6sBu51q4f7iAC5t5LSKmzBnC6d+FOBs0WVOHvdedQiG+xjipSNOUGJHBl9FRh3Mkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xle3Senn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xle3Senn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B2F1F00AC4;
	Sat,  1 Aug 2026 00:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785543400;
	bh=ggfiduJULkwHSlvhD0llWVjFB9n9+YZkRsTBXCYfNxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xle3SenngOCjCXMFLagXxV6Xl8GVw+jsn+SQgq5kMqq12hpEunsxSLDD37cHuLxTh
	 K41y6Pte6CH5xFyx7jXkwuRhoA9g9q8imzNVWIEqaSoYLbUXupboJ6UIDYvJ8FW2ye
	 /1H+f9So/VcbbuDIT4xxpwhFd1hHDCSnCmXB7NwaXnVMOgSMsVve6S2CUSISlgIOQ9
	 dnKz2v/d8QB/sZP/dPpC4txyLz2h+atW8zGxGTLUYQo3oXclpgnly8xDKC3tPZC5Q1
	 moJCKZluH3GI4iq0TzlnrlUUdiHqntX0HRJF7O11Ju8c8wn+II6RMiinjGsT1qWxLD
	 TBkhdOhBFm4vg==
Date: Fri, 31 Jul 2026 17:16:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v10 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
Message-ID: <20260731171639.1baec9e5@kernel.org>
In-Reply-To: <20260728084307.2129515-2-jelonek.jonas@gmail.com>
References: <20260728084307.2129515-1-jelonek.jonas@gmail.com>
	<20260728084307.2129515-2-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The second patch conflicts on MAINTAINERS so unfortunately a rebase
will be needed.

On Tue, 28 Jul 2026 08:43:03 +0000 Jonas Jelonek wrote:
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml 

While you rebase -- the AI points out that the binding is called
...-gen1 but it documents gen2 as well. Should the -gen1 be dropped?
