Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217638911E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404661; cv=none; b=OZzlwLe7kkjzzBvdjge6g4XjqrJ8PzbztK6o4yc32AhJ0Z6ogATBBEk9PVzaRPicQC0Cs3lawWF39CQJffsF52yCv4lxGyxxV53V0JySgzgwjNESRQLBk6GVEdUFvGD2PVaD/1YqToQukRsW4lQgYUuNMF+SlBMbI5Yr90NI6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404661; c=relaxed/simple;
	bh=KdPsukPOjhZ2FXSvDmayJ4LjEz5qmYgAur6pLF6ZhMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWaUicDSeIfLHUsN7bVF3RIu2L2rSd6fPeee3utNyvahw0z7iqUB6jTi/QxTKR0kh0Va+g/uFV3NVqND5OzWWRAroOXHOlHo49iZ4D3TdcrvJm4wbAAR5300V5NwxAOA/4f4pK5MzUz+7JXyPKBsm9XPxge2XhPavCKwdXbyYfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IyUKeYZF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IyUKeYZF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pG7HUrAUTDx39Xaw4AN8KuESL2B22Hci2e/DT7Kf02U=; b=IyUKeYZFpRMgKJBR8OBFecMrDP
	TnWjpO3kDWdjSB5JCpvCDFtQ6CBJoJnT7mf1kBAZletouW2VxUDGz72nO+5nJVsop2VRodaU9WBDc
	Cc3WsMwJ1cwpFesbEPKu+raV901qNxhL0aJEIAHpBx8EoMqfXWBNYVGSTREFvhsPcVIA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOa3-005gmQ-8U; Tue, 02 Jun 2026 14:50:51 +0200
Date: Tue, 2 Jun 2026 14:50:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, mensi@mensi.ch
Subject: Re: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to
 fwnode API
Message-ID: <8c2ef5ad-62a9-4cea-8be5-d2ef49389ca7@lunn.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-2-markus.stockhausen@gmx.de>
 <3b54c1f3-b60c-4e97-8e14-fec10cb1030a@lunn.ch>
 <027401dcf28b$760ad6b0$62208410$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027401dcf28b$760ad6b0$62208410$@gmx.de>

On Tue, Jun 02, 2026 at 02:29:23PM +0200, Markus Stockhausen wrote:
> > Von: Andrew Lunn <andrew@lunn.ch> 
> > Gesendet: Dienstag, 2. Juni 2026 14:06
> > An: Markus Stockhausen <markus.stockhausen@gmx.de>
> > Betreff: Re: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to
> fwnode API
> > 
> > On Tue, Jun 02, 2026 at 07:26:33AM +0200, Markus Stockhausen wrote:
> > > The driver still uses legacy "of_" functions to determine the port
> mapping
> > > during probing. Convert this to the modern fwnode API. With that also
> fix
> > > a subtle lookup bug in the original code.
> >
> > fwnode does not exist because it is modern. It allows you to have
> > other bindings, like ACPI binding, using the same code. Do you need an
> > ACPI binding? Have you documented this new ACPI binding? Has ACPI been
> > tested? Are there any OF properties which as listed as deprecated
> > which have been converted to fwnode? A new binding should not start
> > out with deprecated properties.
> 
> As I'm no firmware expert, thanks for the note. 
> I came across this mix in the old code:
> 
> 	err = fwnode_property_read_u32(port, "reg", &pn);
> 	...
> 	err = of_property_read_u32(mdio_dn, "reg", &bus);
> 
> So I decided to get consistent and opt for the 
> fwnode version. To be precise: We are using 
> device tree only here and we do not need to 
> change any structure or properties. 
> 
> Leave all as is then? If yes, do I use "of_" or "fwnode_" 
> for new functions? E.g. for patch 2/8.

Please use of_

And in this case, i think there is a helper you can use. In general,
take a look around and try to reuse as much existing code as
possible. That might mean changing core code, making a static function
global, etc.

	Andrew
