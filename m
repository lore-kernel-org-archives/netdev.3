Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200629D291
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769652; cv=none; b=L0+4h2TX7P6RKgTqakFUPOM1AOynWssh3UVxe3CSqXHR+yWNXlUjIecB86MMVke1ZDIWqUlGjVas8Xzlwpm92YYySKwficxIyyUXoVobsWl1+ha94AcBE9hD9jyFjpfigmUu2tar1q8qiC3iM0FYFFYb6hW8KgznxdcJTc4c1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769652; c=relaxed/simple;
	bh=d3yPia8FijYOUtgo78zzby96UQObBNqO2mADu4oxM6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGgKWTJWo0oEt09eqntfygAKlCqggg9zvf4CCI/okcym8YzsTU40hYLYtx7wONkVV8X73Fbm8rM5sQvX7rOelNWlsM++f1Fd9WxFgUW8XRLnj5PjxihZNeBRx0i/Dk0Wyedaf6YJO8LXltTcKsY3lZtofZsGMYsLBEQs/EleBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CJzy/xQJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CJzy/xQJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ps8iiPhPlmUrtlssabp4trhpxrgmEsOSB7XVfDBh4UA=; b=CJzy/xQJ6XmhnH/QnQQci9nbXP
	pnpznFCtnInbZKLdpDBoWDMJPOIq/YXfWqZ74+rPFCV2p9eHs7PBWw+mHRUHu+DfAesIw/6GRrbwf
	pE1JKCgEZ+qVCzrJcZajO2w/+5WEG2FTiY0A7MYiUCNOp60ANBDJUp1Z/aoNzi1JfZOI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmi7D-00DijE-Uf; Thu, 23 Jul 2026 03:20:47 +0200
Date: Thu, 23 Jul 2026 03:20:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
	conor.dooley@microchip.com, charles.perry@microchip.com
Subject: Re: [PATCH net-next v2 2/2] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
Message-ID: <a75df33c-e5fb-4980-a9e8-024ea89f8634@lunn.ch>
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
 <20260721180158.13014-1-nwhitehorn@pa.msu.edu>
 <20260721180158.13014-3-nwhitehorn@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721180158.13014-3-nwhitehorn@pa.msu.edu>

On Tue, Jul 21, 2026 at 01:56:02PM -0400, Nathan Whitehorn wrote:
> The current PCS code unconditionally uses SGMII autonegotiation, though
> the hardware supports both SGMII and 1000BASE-X modes. Decouple the
> choice of PCS enablement from use of the SGMII mode when running at
> gigabit rates and announce to phylink that 1000BASE-X is a supported
> operating mode. This enables direct attachment of the PCS to e.g. an
> SFP.
> 
> The 1000BASE-X code in phylink also sometimes calls the autonegotiation
> restart method, so add an implementation of autonegotiation restart.
> 
> Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
