Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E64749D5;
	Tue, 18 Aug 2026 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057790; cv=none; b=Ky73nr1Al1GOugYve5CHkAl1X24//zWl8ZZi7A0Jd/6HngPdhHL9x4kPMSb5BO76FJ01Hv4X2/a9pX2QdvljDxhYlPwSqFdUSCTyMDmks2GydH/QN2XbjTukDjupGWgfLsUuw2A7VwaGn25+TQQx2xUPJqMrQffcoMmDFrizf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057790; c=relaxed/simple;
	bh=DOPq80cBsvVhChvsLsqYIhzON+VjqGSyvXXlgxdQzdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgE/3N1vajsWKRQTbtXWdqfsQWbEGz7YLRfg8Dj/KvLyzicm1vSc9yRadWnIsjz9rVCiho116AJexTsyl7wZl3hBV9SYaI5R4FCB9KmTN0Lh9vDjDB1KgAEmhnZPwZl23W+nNAZ+DiBTcM5iJYRSd2sQ8ok3PNdV8libB9W32bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dj6aiZch; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dj6aiZch"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pzGhfyGKCTcCAI1esMUGVzqsdQ1GfC1ZoHKfgE71dGU=; b=dj6aiZchFzgYrS0aTNg2WjeDlg
	CsvyF5YkVOLnZGgkp9DStjfdAvcYGktShS4SFrF5iAgwuqWvZ0PJDaaF3xjSWfaQ8W82L600IKNxZ
	KHFFMwyEbOp5wCgci/tXJb/LDBGDMVYMmeACqUCQtsKlX302wTbOGMXrFaMvkIvxZhbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwJMU-000TGP-H9; Tue, 18 Aug 2026 14:56:14 +0200
Date: Tue, 18 Aug 2026 14:56:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v7 03/14] ax88179_178a: Split driver into
 library and device specific code
Message-ID: <5eda66a7-2b37-4766-a9b7-04d3d421b1a6@lunn.ch>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
 <20260810-ax88179a-v7-3-da633191c129@birger-koblitz.de>
 <20260817152800.3dbe9f55@kernel.org>
 <e72d0d5e-6368-46eb-8247-a760046cb8c0@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72d0d5e-6368-46eb-8247-a760046cb8c0@birger-koblitz.de>

On Tue, Aug 18, 2026 at 06:51:32AM +0200, Birger Koblitz wrote:
> Hi Jakub,
> 
> thanks for reviewing the code!
> On 8/18/26 00:28, Jakub Kicinski wrote:
> > On Mon, 10 Aug 2026 14:33:28 +0200 Birger Koblitz wrote:
> > > +static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
> > > +			       u16 size, const void *data)
> > 
> > Local netdev convention is to still wrap at 80 chars.
> > Anything beyond that is inviting laziness.
> > 
> > > +{
> > > +	int ret;
> > > +	int (*fn)(struct usbnet *dev, u8 cmd, u8 rtype, u16 val, u16 i, const void *d, u16 size);
> > > +	struct ax88179_data *ax179_data = dev->driver_priv;
> > 
> > Local netdev convention - please sort the variable declaration lines
> > longest to shortest
> Both of the above and other occurrences will be fixed in v8. Sorry about those, I was
> moving existing code and tried to minimally change it in order to allow blame to correctly
> identify the original author of the code, while still making checkpatch happy.
> 
> I was not expecting a review while netdev was closed for patches, btw. Am I right
> to assume that I should not send v8 during the merge window, or do you prefer the
> next version to be submitted earlier while everyone still easily remembers what this
> was about?

You can post a new version, but mark it as RFC. This should be
documented in

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew
