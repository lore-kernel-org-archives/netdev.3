Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E933AB288;
	Mon,  5 Oct 2026 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233918; cv=none; b=meeJJ52WDZAz2/gXJv/HpQcO9D6jInWr72hxdMLqYRGlpVg9EznZrd/+vftSoeFIKBSziDh6LyUNxdB7vPBF5w9DqnFUKcYE4dXPZUOGL5mm4pYgJvvr+d1Purtz2LGGA2/rxF8XAXsOEpMWp4DMTnQwmbUfEiac2pXkgWRT+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233918; c=relaxed/simple;
	bh=NNpKODSv8cbaDOfghRaj6Q3Wssu5+yBBdBSPkeZOgVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXjX/hmvFkTfPKtn+NxyPhybb9BAFum5nHbNTYMctKrCnLQ/djT5w9mfPiMO+l4ljYkTOO1HZhlwO9hEC9oiBKGbCJlj7j4mM2yNfIMspiVCVLfs8HZu9PMAxT5d849u9DDjy1atWAo7sD7C4peHe9N7kJiIDhxYnUYFNNXhpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWJmXdjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWJmXdjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8951F000FF;
	Mon,  5 Oct 2026 20:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791233915;
	bh=NNpKODSv8cbaDOfghRaj6Q3Wssu5+yBBdBSPkeZOgVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JWJmXdjvkJLsj4FzNwydM9W+G7D089NS9WmoDLl4jIQZ2o6K2BRfhjIs62fp3ry9g
	 UtJg52BTRl368jxhDo0m/9gkQQ4iIZP8fpWEePEufdmCKmcpIdGF4wn2rjggtVXfFk
	 0ozyafbkSWKH5tmB4AgtCFh1EU7fy1f91mAXCU2GQq9blUH2RPRPtirhEz8kQLf5fF
	 8xLnRUpvu7sURoXENvhZPrh8NY5fDYOZ3xKhC3On/+MUMNZFZwXTpXFUDBVDctIQja
	 TIr5pzqBDgyJQxZuBtTgX1zAo9cPwgU3jlYdtQcENO29cvv2zLcuduYu0epu3gp5qQ
	 2RpBMcjCD2UlA==
Date: Mon, 5 Oct 2026 13:58:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Romain Gantois
 <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, David
 Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v10 00/11] net: pcs: add basic support for
 RK3568 XPCS
Message-ID: <20261005135833.37376f20@kernel.org>
In-Reply-To: <20260922200336.2201212-1-coiaprant@gmail.com>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 04:03:24 +0800 Coia Prant wrote:
> This series adds proper SGMII support for the Rockchip RK3568 SoC
> using the integrated Synopsys DesignWare XPCS, along with necessary
> fixes and refactoring in the stmmac core and XPCS driver.

Someone marked this as changes requested. Not sure who and why.
I was waiting for an ack from DT maintainers.
If it wasn't you, either, maybe repost to re-queue this for review?
