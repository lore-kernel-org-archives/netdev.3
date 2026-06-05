Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235E40E8FF;
	Fri,  5 Jun 2026 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668776; cv=none; b=gWEGedTMOOOfO9FoP7Um9HP43zgNYccaqhbDxF8SWInJHaU6jBbzTWON5pR4A2htElNH3O6RM4L4oq3Aqhl9XQ9q33sjjPK+krxz/hN82z4xE2YAfzraBSISX7t95awI4sDWH5mVjfUvCuzM5xmpIgAPwNdUcl7sCLh9rBrKJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668776; c=relaxed/simple;
	bh=8kte1jYsfpJ+YdWvrUzTLwzEb6GY+7W+zz0SvAjs9RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Egr1gDLkoC/1qwmtj33TBxw39oHVHyvV8LeViNklgTFJK0b8yf8jAvq4cA9Vw0CQCLOrcX7k0bsBvJJbD3odYyMQV0KsOuYYso8is5kTFhY/BVn4cUdmZ6/UGLZqo/lW/GHtMklKTDSfb1RYZapVsZsHiiSKk2rhI6j86MCY6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y8xS4wKU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y8xS4wKU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gwZpFcQuVSep5h2JfBZIsItjVotlQ0g44gywc7q0L44=; b=Y8xS4wKUwI9UtNLzhFo1rIXGQb
	ID7ZHfXz9oSRBBQFP0TfI1kMEEPON7JahkxHrpMpfJl+yL0XCOr0svzp8Oektt3eyLNKf2k/HCWO7
	YzgPU6Z36X7alXcHCOt2xtvePAxOu22dgr2Tb0XDmMFTaRFVwLQ8FAIXlgXxZLSYKNWY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVVI3-006F2u-0F; Fri, 05 Jun 2026 16:12:51 +0200
Date: Fri, 5 Jun 2026 16:12:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net] r8152: handle the return value of usb_reset_device()
Message-ID: <839beccc-165e-4f60-9c23-ccc8e4f205ed@lunn.ch>
References: <20260604092247.27158-450-nic_swsd@realtek.com>
 <c1ddf8f3-71f7-434c-ad10-64096b65fe51@lunn.ch>
 <ce2651bf86fc401b9e1e7cc29b5a6c22@realtek.com>
 <3e108daa-7913-4890-8331-9761a4654b1f@lunn.ch>
 <19bdb89de51c46408b7e7d7cdeba8e4d@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19bdb89de51c46408b7e7d7cdeba8e4d@realtek.com>

On Fri, Jun 05, 2026 at 06:26:46AM +0000, Chih Kai Hsu wrote:
> On 05/06/26 12:04 pm, Andrew Lunn wrote:
> 
> > On Fri, Jun 05, 2026 at 02:42:34AM +0000, Chih Kai Hsu wrote:
> > > On 04/06/26 8:54 pm, Andrew Lunn wrote:
> > >
> > > > On Thu, Jun 04, 2026 at 05:22:47PM +0800, Chih Kai Hsu wrote:
> > > > > If usb_reset_device() returns a negative error code, stop the
> > > > > process of probing.
> > > > >
> > > > > Fixes: 10c3271712f5 ("r8152: disable the ECM mode")
> > > >
> > > > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.h
> > > > tml
> > > >
> > > > Does this bother people?
> > > Yes, it does.
> > > If the driver does not return early when receiving an error code from
> > > usb_reset_device(), the subsequent execution will trigger a kernel call trace.
> > 
> > Please include a link to such a bug report, kernel call trace etc, to to show it
> > bothers somebody. Do you have the hardware and can trigger this?
> 
> If the driver ignores the error from usb_reset_device(), I get the following call trace.

O.K, great.

We have had a lot of AI driven bug fixes for theoretical issues, which
in practice are unlikely to happen. We want to consider such patches
as just ongoing development work, and merge them via net-next, and not
backport them to stable.

From the commit message it is not always clear if a patch is just
fixing a theoretical problem, or a real problem which bothers
people. So sometimes we need to ask....

Including in the commit message a Reported-by, or a link to issue
report, makes it very clear it is a real issue which bothers somebody,
so we don't need to ask. Please consider this with further
submissions.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

