Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58243E06B;
	Tue,  4 Aug 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850364; cv=none; b=EtyiMy76RzBNCG9DH/1Wnx5kERjDRpuvHKwGpBg9ZfLz7A19durL5XZX+3sQQJZyKvekAFoMAxadrvJMqJjWuotk1ocDfnZ5pZQig4atlwtTzJOBaW/lnPxhIcYYLp96bZ85rItEMGcR5HzWt1zd5V0m83Mo78a4VXaGTDqKWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850364; c=relaxed/simple;
	bh=66Uo5oVfiXXzFxsNehM/YhZeuaTU5TO94LE6RMVTxAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKc7lJBFP2d2nK/jlxkewRIYjycuVRtVceTIxKyCe9MZcbB9f39SmJZvAdjR1zMJVa5oQUzgoR2BxnmL8tEPAjYo2jWVtzAhEP5Y92YWHFeCqpoAv1NioKDCvhQW36Yu+Cz05OfBFBJEElhgxjALS8daoEh0g5JA79j3mZbkpB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AHokJneI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AHokJneI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Nfnur+IUZy2CwactjuIuBWskKhF4Pw83xKbF6zpXBtA=; b=AH
	okJneIoWpVqvEb9u1rJc4AJcPF9/lS2u7lgCh1DzM3/Mi30zCLu1fkfFjD5XEJTc9lXaoNNBfbkMF
	WZysDsAFtUagd+WIH6A2MadgdsLLMDwx6b3bAtk7FnLCcU+89JuQDvkwPRm/j90SfNUIqF8LJ336M
	bvagdgCA3IqkSqo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrFFy-00FzhU-AK; Tue, 04 Aug 2026 15:32:34 +0200
Date: Tue, 4 Aug 2026 15:32:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/3] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
Message-ID: <2ccd6223-dd40-406b-8869-021881755f72@lunn.ch>
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
 <94fb1a6e-71d6-42ae-b221-cc03a820d2e0@lunn.ch>
 <CAOPX746ZFCE1XwXJ1H0gEaBvdvq-4GAiPTKkT-3XvZi0n_f73A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPX746ZFCE1XwXJ1H0gEaBvdvq-4GAiPTKkT-3XvZi0n_f73A@mail.gmail.com>

On Tue, Aug 04, 2026 at 10:03:30AM +0300, Artem Shimko wrote:
> Hi Andrew,
> 
> On Tue, Aug 4, 2026 at 5:32 AM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Is this a random example, or what you are actually using?
> This is actually the configuration we're using on our
> hardware.

 phy-mode = "rgmii-rxid";                                                                                             
 phy-handle = <&phy1>;                                                                                                
 ...                                                                                                                  
                                                                                                                      
 mdio: mdio {                                                                                                         
   phy1: ethernet-phy@1 {                                                                                             
     ...                                                                                                              
     compatible = "ethernet-phy-id0008.011b";                                                                         
     rx-internal-delay-ps = <1050>;                                                                                   

That is a very odd setup, half the 2ns delay the RGMII standard asks
for? Do you have an explanation for this?

Have you verified the writing of the delays in the PHY register don't
have a 1 bit shift error?

  Andrew
