Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C5402B9E;
	Tue, 11 Aug 2026 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480425; cv=none; b=kv+3mRoojDDHx/hjluDQH8WsFA2gwX4jo3VSIrQ8nB2DuiTzsT8Z31+RerInftZQulu0Uej9qPkOt9HmBIjEazPz0LQVr+FC/g6FlefH8t2oP5n42RezzvqqwPRIDW0mffPO1GUHskFnE0mpe5gYv5YzNG0vK86IsaxXzGamUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480425; c=relaxed/simple;
	bh=e0epG0zthLx3vz5Fsxg1fUceXMjB+hIkz1K1ncsMA2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4WmhZW1I0ahRCp9f0b6pm1QT4V3/p26MAAvYPDe5RM81YuUsvmM/1qIXzvDVN7+7EDQvx/tzwpJNWzAW0ErtTCJrMHgl3Nb7ocwoPqlMJk98UlnzEUKSDNVUAWNw1SGRGSHxIqTgb25qG6HaO//Tg8T4YHlxVLCvHMinY5zmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lbZ+RsQZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lbZ+RsQZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q58NnluEd7Mdf1XEgaOf4Q0TW7uWRgkIuWPlNMdzkuA=; b=lbZ+RsQZGCcQBh5XXCpSZvo1/n
	bufOcQurq8OHVcTaEIcSCmvU32eFJx7dSAUsIQhVDijjOQKb/IuGzNMbGa85WbG5nrV8yuove+bSu
	fR8eftzawHZLSe7cx8s6guUBdrBGSKwj28ncTVAUnhsXbOtFOe0/idmjonZGuDoZ6kk0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtt9w-00H98L-7M; Tue, 11 Aug 2026 22:33:16 +0200
Date: Tue, 11 Aug 2026 22:33:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 RFC 2/2] ARM: dts: BCM5301X: change Luxul XWR-3150 CPU
 port from 5 do 8
Message-ID: <74a83203-9acb-4413-8952-9182f02d1e67@lunn.ch>
References: <20260811193658.14304-1-zajec5@gmail.com>
 <20260811193658.14304-2-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811193658.14304-2-zajec5@gmail.com>

> Change the choice of "cpu" port to 8 and make the third Ethernet
> interface (connected to port 8) use MAC designed for the first Ethernet
> interface (connected to port 5). This makes Linux use switch in a
> feature full way.

> This seems to be a slight abuse of DT. Instead of describing hardware we
> make it steer Linux into using a more appropriate switch port. This
> isn't strictly a setback on its own. It's a change from one choice to
> another.

It is a bit fuzzy, but the hardware of port 8 is better designed for
the function of being the CPU port. We are expressing this hardware
property via actually using it as the CPU port.

> I'm not sure about that MAC however. We say that the third Ethernet
> interface should use MAC that was designed for the first one.
> 
> Is all of that acceptable?
> 
>  .../arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts | 9 +++++++--

Is this the only device in mainline which is affected?

   Andrew
