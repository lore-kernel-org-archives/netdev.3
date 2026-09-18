Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562783B95E0;
	Fri, 18 Sep 2026 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756931; cv=none; b=gjrD083mBva3Qx131UtK07KEG+1eX9xXz01MYPWvu9nz6XJzH15klKdPvjauKery+yLwhT/dwgYRoYYS+Tqf1PWGCrEzciwscw7xiA0UxFyEMY2j0Ka7gX2tKu2AE8Nz5U3XFqhhRpDe+HJM5DIK/OJ9YvB9tK7ZehLerr/837g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756931; c=relaxed/simple;
	bh=yRtXZoYoH7DLf9DFZ/GfyScpg4JkyCqCyFHXJ69FqR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFYiTrt8hw9beIs80OasZ1QpQ4p0+gdMTfG08CWbsyweKjb+sPoHJLxmqMpgPJMJro4Dy0J8S9jwIRA+cRvkEAHXSDwEWtiyKgiKP50G0TSdtLCFfkzYRdElscqU6r6N/jnO6U5xM6dJqY6uddpzf1toCkqQgLozTzPW7fbzvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGsvJzUR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGsvJzUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F2A1F000FF;
	Fri, 18 Sep 2026 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789756923;
	bh=5sY2K0NFqeHlnnXVJj9mphRlP5+qDd3iUqsbcAY+xNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dGsvJzURnx4P2I2ySeknphYi171fhnjGzSiD1bWzXoT3bnkbdVesM6rLQImvP+Rng
	 Tk1LDa0FfDwc1zq+cR9oPuMBlf5PNOSu1W9pnXJDcJW6IXEHDGGCxqoXWF39997mPF
	 i3qD1PswT/s8eLDbaIRPOaUTvyvWttwc0L6vTjqrP25zlQnG1durEI9UZxpQTYY0os
	 vk0kMkn1GVD9F5rorzOzFa6GQZZYfGSyX7bngD2cTHwC8fDlNPbvQmNo7w3bQWLNSn
	 dV+HPLPKau1h2cPRnbjw/Sf4SAsgpxD7Vud+vm+C8T/WeoUk7J/5pRO7XygeqBHBqw
	 WecR2YK94mx/A==
Date: Fri, 18 Sep 2026 13:42:01 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-sunxi@lists.linux.dev, Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Richard Cochran <richardcochran@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: sun8i-emac: Add A733
 GMAC210 compatible
Message-ID: <178975692133.1355528.3349670401889953428.robh@kernel.org>
References: <20260910-allwinner-a733-gmac-support-v2-0-4f4a1e520c23@baylibre.com>
 <20260910-allwinner-a733-gmac-support-v2-1-4f4a1e520c23@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-allwinner-a733-gmac-support-v2-1-4f4a1e520c23@baylibre.com>


On Thu, 10 Sep 2026 12:25:26 +0200, Jerome Brunet wrote:
> The A733 GMAC210 is a DesignWare MAC 5.20 close to the A523 GMAC200, with
> the following differences:
> 
>  * The glue configuration registers are a dedicated MMIO region of the
>    controller instead of a syscon register, so a second reg entry replaces
>    the syscon phandle.
>  * The DMA channels and the LPI event have their own interrupt lines.
>  * A PTP reference clock and an AHB reset are needed.
>  * Unlike the A523, the controller does not appear to belong to a power
>    domain.
>  * The TX clock delay field is 5 bits wide, allowing up to 3100ps.
> 
> Add the new compatible and describe those differences.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 130 ++++++++++++++++++---
>  1 file changed, 115 insertions(+), 15 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

