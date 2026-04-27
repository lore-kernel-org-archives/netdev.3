Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2F334C20;
	Mon, 27 Apr 2026 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303535; cv=none; b=mVDR4AVuWzd7sSEv6R9DXMIH4DppWgQIbWconHQpnprMyFXIfH0pigj1zttZDRyISo1bC8QONhUBQQnIlupH4snZs8NOEZggM5eugDl8kjxYchRyxrjHamB01fheeCLQ/6jjaJu+0VFJUAHVsAYWWJ3wG58lEB/23GzpM0D1JR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303535; c=relaxed/simple;
	bh=5eGJRBHsry8VLeF9PsLXNzqWC87KtCD87UrBpwfeRG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPv4ykedtoiJQyeDbshsfNDHFV9QEY08C+AtMef1CivI8Ljt8UlInTLxuzpdJ05LqbLMzEm9It1dRxLYqf3QZRSwC3dcvYitl6hKletioWfS19GJk1ID50WMUkwkI6+BTMvmrec816lNz8Vx6KCclJseap5IUHAweam+bWGBeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tE8BUc9F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tE8BUc9F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VLUeEUxHsvQjbEylxIKcyrfUDtvJeNDxCc7Z5Zfd5yc=; b=tE8BUc9FTlXsdeIjq04yFee+zA
	2G0Vv9L3FMf9i+K7vtJmHXhMn/4K6A8TJNevJm11U5Qvt0E5wSGUno14Mm5gTHXp7Ruo2MDu2Pskn
	lvf2IdG0jdHd2Co8ErqUga6Vllm1ichZGDNpzgAiYEskGOrsxOvZFP/SgKpO+XmmlAr4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHNpr-000BP9-8e; Mon, 27 Apr 2026 17:25:23 +0200
Date: Mon, 27 Apr 2026 17:25:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH] [v4] wiznet: convert to GPIO descriptors
Message-ID: <992f111e-febc-436d-b7ca-fa167a858e93@lunn.ch>
References: <20260427142924.2702598-1-arnd@kernel.org>
 <20260427145010.GA2502144-robh@kernel.org>
 <57297b41-0f08-43eb-a73c-21a5461a4eb4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57297b41-0f08-43eb-a73c-21a5461a4eb4@app.fastmail.com>

On Mon, Apr 27, 2026 at 05:17:24PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 27, 2026, at 16:50, Rob Herring wrote:
> > On Mon, Apr 27, 2026 at 04:28:29PM +0200, Arnd Bergmann wrote:
> >> 
> >> The CONFIG_WIZNET_BUS_SHIFT value was apparently meant to be set
> >> at compile time to a machine specific value. This was always broken
> >> for multiplatform configurations with conflicting requirements, and
> >> in the mainline kernel it was set to 0 anyway. Leave it defined
> >> locally as 0 but rename it to something without the CONFIG_ prefix.
> >> 
> >> Acked-by: Rob Herring <robh@kernel.org>
> >
> > Well, 3 years later and I'm a bit grumpier seeing .txt binding 
> > additions. A new compatible plus new property we generally require 
> > converting the binding first. But I'm not going to revoke my ack here.
> >
> > Is there even a known user for this new compatible?
> 
> No, I'm not aware of any users neither the old nor the new
> compatible, it only popped up from my backlog of patches
> because of its usage of legacy GPIOs. From what I can
> tell, the only users of the non-DT MMIO interface were
> out of tree arch/blackfin/ boards.

I would suggest giving Nicolas Saenz Julienne time to speak up. If
Nicolas does not require it any more, i suggest removing it. That fits
with what we are trying to do at the moment in netdev, remove old
drivers.

	Andrew
