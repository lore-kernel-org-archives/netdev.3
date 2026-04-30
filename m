Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6AB40B6DE;
	Thu, 30 Apr 2026 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558022; cv=none; b=WGpuXwADjws1jn3Ei5zkcELXESzpDd6/sTNr9XOn4yQ8FjFrasXubtSFZ/eYZO1cdhmyyDD9yhePK0C2n8xY4ErtyIudw8iJW7s54bW0gnHqLFUEr5IPO/IwlQXl6cOqfgv5HpxSs6ktaTEer7jzKF/UXKkKAKMVNqFCP6XI94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558022; c=relaxed/simple;
	bh=tU+0UxDytiVL+yVVVe0/BtP3SVKh0FV94j6KFD2OP/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk8KlQ4cPRgdV4ZXZkzrIdGlS0gvl86JHxLutoYHsSXrpLYNpkHSV7CwyTh71Q4tfl2Sq5mpiKtmXozPnYWIDYqvZE3tUqjLqCdoLznu4Jz/p5Qg0X9kEyxasYRYAcH04Vy4bho+armN1SaOqTFHR81JQeHC27UXFY5hUHrvx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XRqQ7vFu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XRqQ7vFu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=odfisOKLb+4yvBy7AJ37qHBwXC8cw5zHJIG7y4mEJ/0=; b=XR
	qQ7vFu0LANTE4mm9ix8Cgztidd9/ZquCyUK52yVFPuQkm5lA+iProb2QG98KcUuj8BRdUyali4w+T
	zG9zkQXaIC2wUnl+2rx33fzfb3xFiypXO6j5ybYInFDr+7zSh6p2Ise5RUbF307L3xY6+bXOi7Sma
	TbT+nrZPd4U9qIU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIS2J-000gvp-5P; Thu, 30 Apr 2026 16:06:39 +0200
Date: Thu, 30 Apr 2026 16:06:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Alexander Dahl <ada@thorsis.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Message-ID: <d0c9d2c9-3743-4ee6-a2d7-692118903141@lunn.ch>
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
 <20260409-imx8dxl-sr-som-v2-3-83ff20629ba0@solid-run.com>
 <8efbafe3-0a8a-4005-960c-e8fe62cee719@lunn.ch>
 <bd2e73c5-2e61-4ea1-ab3b-42a6573b31f8@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd2e73c5-2e61-4ea1-ab3b-42a6573b31f8@solid-run.com>

> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >
> >     Andrew
> 
> Thanks!
> 
> I don't know how to keep this partial review for v3, so I will send it without.

You can add my Reviewed-by. It is on record in the archive that it
only applies to a subset.

And in general, nobody can know the whole kernel, all the different
subsystems, and the details for all the DT bindings. So i would allow
some fuzziness for Reviewed-by: for a DT patch.

Interesting, an Acked-by: might actually be more appropriate.

    Acked-by: does not necessarily indicate acknowledgement of the
    entire patch. For example, if a patch affects multiple subsystems
    and has an Acked-by: from one subsystem maintainer then this
    usually indicates acknowledgement of just the part which affects
    that maintainer’s code. Judgement should be used here.

So how about:

Acked-by: Andrew Lunn <andrew@lunn.ch>

and you can take your pick :-)

    Andrew
