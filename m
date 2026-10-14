Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B863FB7E0;
	Wed, 14 Oct 2026 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997843; cv=none; b=BieIb+lazRO0Jf1BytaXhkkuhJTfv+zdJiUaWnUii5OfB0/zM+KIiF/u78U1uxnhKcp7eeTQe+AxJTMcsbQg0h0Pmh+Isi1aGQ/U7ezG7eOtbJfygLs/SfFGd/LYQKiXHTunesOyN66mJ6/sjJpVvj4oq2mOMfnuw1Drf66ZO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997843; c=relaxed/simple;
	bh=ZcAlgZHFiRmVzmP4H64tEj7/iJeu8Ic2k+Xizy9UXd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLbAeAPQLKMdC/Zh2gXKPW8iRUHX7aNbx+by3OlIo2f24yjBW/Fdu4sl2swXpPuHmDLYEFi/5ADpa1pW2JG1NohYcSNZ7/AYEvr1fxsAZvsaPYojIivDFA5U8g/ra7WrWI4kvec+PJbDi7nmYJZ2jHw/Vmj8PVWLlcYWN7Uycg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lmnLOLmM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lmnLOLmM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xroLQRGFlVBdqILrwWhxRndvE/GU7qXvt3u/3iPUAeU=; b=lmnLOLmMv8N6XJzHwczRNtQcQJ
	rwcdD4fg3iW3B++JwobDzwU6XsLWC2ygRZIm+ag7ZTtLUEyCQKkc3ECF0ZYT3qI4J2fmzpvl4+S5b
	UykNPFNm4XlF7DtTLDwIActVpa1Xet/sYCIbC7oS1aQmmjUdTosn4STQbolQo6OFVKGw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xH2Ud-00AmlA-Rx; Wed, 14 Oct 2026 19:10:19 +0200
Date: Wed, 14 Oct 2026 19:10:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Aleksei Sviridkin <f@lex.la>, Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v6 0/3] net: phylink: wait for a PHY that probes
 after the MAC
Message-ID: <b175c750-104a-4859-a137-09de78a6d8bb@lunn.ch>
References: <aa01ab1c-da2c-4638-816b-f535b635379b@redhat.com>
 <20261013151233.2474217-1-f@lex.la>
 <3d3b9f10-e3e8-4d50-b543-0d451cb07598@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d3b9f10-e3e8-4d50-b543-0d451cb07598@redhat.com>

On Wed, Oct 14, 2026 at 12:04:36PM +0200, Paolo Abeni wrote:
> On 10/13/26 17:12, Aleksei Sviridkin wrote:
> > On 10/13/26 09:53, Paolo Abeni wrote:
> > > The above looks like a significant amount of complexity for OoT driver,
> > > and I understand it could be solved with a different kconf?
> > 
> > The PHY driver is in mainline, air_en8811h. Only the board's device
> > tree lives in OpenWrt.
> > 
> > A config change can avoid it, but it is expensive here. Building
> > air_en8811h in is not enough, since it loads its firmware with
> > request_firmware_direct() from the root filesystem, which is not mounted
> > yet when the switch probes. It also needs CONFIG_EXTRA_FIRMWARE with
> > 144 KB of blobs, in a kernel that OpenWrt shares between every board
> > of the subtarget.
> > 
> > Is that the expected answer for a board like this one, or would you
> > take a smaller change in phylink?
> To me this series still looks too much churn for something that has
> alternative options. I would like to hear a 2nd opinion from Russell,
> Andrew or Heiner.

I think the hardware design is poor, it would of made everybody life
easier spending an extra $1 on an EEPROM for the PHY firmware.

One alternative is to put the firmware download into the
bootloader. That means it is not in the initramfs, which seems to be
the major reason for doing this. By the time Linux gets to drive the
hardware, the hardware is actually usable. That makes our life
simpler.

	Andrew
