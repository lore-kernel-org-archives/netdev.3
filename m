Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92952F8EA8;
	Wed, 27 May 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899389; cv=none; b=GbW+TmrYM7HLDg9O5lxNG3ErhEH3EGSwd21hJRyEB01GtB1eAr2Jc0MqcOUiMTkle9f2vv1IP5xrNz6Ga77Oj2/QQovEz+t2l+CNdlBweflAXyHXqFxWtNTIfuL8c/FmKyXHg2Y+2fmrVVA4TABNpliYtU1kAO8YfaaMhkGT4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899389; c=relaxed/simple;
	bh=6LszrVPxGQMkHALIowwsfV8GwP26coKLtL1i0Jfx14w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ3eZPJ5q2ucPX3TzypmuDR1HCVFHxB1ILfwqlZHCgBKOVbGQrfos/NZIyGvDBRXyA5GB5O0ewK8vroSDEUnGoAX+hkt0H0AufHz3r8bHJJ2IazkDFDG5jFYSLDwofcARUNgmrK9qzEHKAEWHEfNnJL/tvW1BUkLgNKbSNOsqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D/zrKw1J; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D/zrKw1J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=azqyREQPUhZp6WexCnHwC8ZHeJG3nsxqW9ASbvoFfTw=; b=D/zrKw1Jdd+piVkXNeiIVXTB6B
	NKdV23L2cOSucXEHu1tyqUY1fE18k79y9xEFBQDtyiyr4jz23NGl6XR/7RgeQfMaTEldanBwV/YaI
	4GfGZwR1TGCrB6Iz6fmchXtFipgnHITi8boH2Ukd8/EpO+1XH7cQ2oCwkmp1Vcbw9hzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSH8V-004mFb-F0; Wed, 27 May 2026 18:29:39 +0200
Date: Wed, 27 May 2026 18:29:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	USB-ML <linux-usb@vger.kernel.org>,
	NETDEV-ML <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: usb: asix: ax88772: identify 0x2001/0x1a02 correctly
Message-ID: <38d43d09-69cf-4c17-9e03-a47d3fcc3eb7@lunn.ch>
References: <20260527090816.100854-1-xose.vazquez@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527090816.100854-1-xose.vazquez@gmail.com>

On Wed, May 27, 2026 at 11:08:15AM +0200, Xose Vazquez Perez wrote:
> It's 88772B, and s/spaces/tab.

ax88772_info -> ax88772b_info is a bug fix. Please base the patch on
net, and include a Fixes tag.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

A more verbose commit message would also be good. Because of the
space/tab change the added b does not stand out, and it took me a
while to understand what you actually meant.

    Andrew

---
pw-bot: cr
