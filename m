Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99A44CF37;
	Wed,  3 Jun 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490253; cv=none; b=hJqJXhBT4OGJLI3cUX4UVT0nwWw6tF1hpjpGf8L+8GWuQK/eynYiFHGICOsOCEN7Vqwtf/a8Cax6nBXaYtyhWUPcBcFUTlt4YmnCBqVsFUxqopIXIQml3AOJ1eRbri8sWH2OW3KsUbnA5qFJqxr7T165zGUM5qnj810h9NFtBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490253; c=relaxed/simple;
	bh=dmLgLi8ZDMr6EmeUTTc1Y7QlkjRpKa4gBjT/RKWcmY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MquXoPKhwcNvEOPoRITsGS5R5rqGI9X/agS4/AYRM7oKDDrhef8A1N9KvXfbFN0utmJu7qjdiZCrU3qbNU5OTuVj1/k16x4+xkc7K2JjdVFMt6T2Y6589zpiRXBg0iS7xlY6tlCmqFapZVYaT2D0i2vVoZfmXe+9R9zf30rajEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RFkaesgk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RFkaesgk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=PfMdahfdPFJt7R+zmXS3TZF8dVFifIUBiuHxwzkrLis=; b=RF
	kaesgktMgBcLm0WERNfCTvj0qJJWwEfHPom2IYZ+a8+/jAK5OUuYHUSLfMBzl96Ha2QHnwBMOPKOS
	Bo7qc9DLcyjnWQy6163wO+OYCkpKro5vAVZML/7FpH1qs+ST7b7yWTuHnFpjVLPLP4VA3bIjGvBaT
	epz/9ay7FRygRVc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUkqQ-005sNN-4p; Wed, 03 Jun 2026 14:37:14 +0200
Date: Wed, 3 Jun 2026 14:37:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/9] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Message-ID: <d4fa4e93-9373-47a9-aaa9-e3d687c58d82@lunn.ch>
References: <20260603-dsa_lan9645x_switch_driver_base-v7-0-b2f90e676707@microchip.com>
 <20260603-dsa_lan9645x_switch_driver_base-v7-4-b2f90e676707@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603-dsa_lan9645x_switch_driver_base-v7-4-b2f90e676707@microchip.com>

On Wed, Jun 03, 2026 at 09:25:23AM +0200, Jens Emil Schulz Østergaard wrote:
> Add the LAN9645X basic DSA driver with initialization, parent regmap
> requests, port module initialization for NPI, CPU ports and front ports,
> and phylink integration for MAC side configuration.

A terminology question. How does a NPI port differ from the CPU port?
The datasheet defines NPI as "Node Processor Interface", which sounds
a lot like the CPU port.

  4.18 CPU Port Module

  The CPU port module (DEVCPU) contains eight CPU extraction queues
  and two CPU injection queues. These queues provide an interface for
  exchanging frames between an external CPU system and the switch. In
  addition, any Ethernet interface on the device can be used for
  extracting and injecting frames. The Ethernet interface used in this
  way is called a node processor interface (NPI).

	Andrew
