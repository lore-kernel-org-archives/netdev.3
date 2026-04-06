Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152B331A7B;
	Mon,  6 Apr 2026 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775481445; cv=none; b=r7u22F433u4aqvXJc9TklkLp04fVY32+B7PYoG8zZwjP0Kt9hGX07lcmhnZxyAihNXbB7tUGlOBdd/VCjEU9z9cN83bYlNeCgX8Rl5n5KZFdiOQgzDnAumt36P4pWJCRr1U3RkzAYNLSuZTSVgs/hINyhzU9ov22cgnSftk3ET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775481445; c=relaxed/simple;
	bh=BxMACDMMeuacwkeGLY7NTnC3ktQAleSul3SYePOTzVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwedGx597AHW2eWpT2z1GZ8SBg97EVW35QutKiw8rtLy+alB/eCN1fBGd1WYKhgc/PxYlxgdBzDnqpEi4mdh+bJEU2aCAQUWbV4oNaBq48EYUKNB9p2Xh/kLZGOIR2Zbm/RyOKUdkpca+nT7QNHzusjUnMpjPn68kj49JZINXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E6wWw5vx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E6wWw5vx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7pZ/1KLPYFhenL27zqqx1fK3cX48z44gdDlJPnod7fo=; b=E6wWw5vxLfDdThDXLcMtIWzk14
	onFFAyPOzn2co3XohwYR/okVfjc6uogLAATNWuK0ourVglpHaC5qseeV/sfLPp5aKKxX6EWN213PG
	K6gV/QojJpFJPFPVQc2qjAgisSxyWTSuflZVcphmRkyJ37XJMQ8361+gHd/ls9HdezNE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9jpI-00EzO6-Nf; Mon, 06 Apr 2026 15:17:12 +0200
Date: Mon, 6 Apr 2026 15:17:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
Message-ID: <a1cf8f6a-b338-4dd7-aced-7e19e4d0fdb7@lunn.ch>
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>

On Mon, Apr 06, 2026 at 09:13:06AM +0200, Nicolai Buchwitz wrote:
> Some PHYs implement autonomous EEE where the PHY manages EEE
> independently

I suppose we should discuss naming. As far as i know, IEEE 802.3 does
not include this feature, so it does not provide a guide to how we
should name it.

In the past we have used SmartEEE, but that is Atheros's vendor
name. Broadcom seem to call it AutoGrEEEn.

Autonomous EEE seems like a reasonable name, and appears to be vendor
agnostic. Are we happy with this?

What i guess is unclear is what part of the network stack is acting
autonomously. In the context of a PHY driver op,
.disable_autonomous_eee is clear. But when we go further to actually
making use of it, do we need to report to user space if we are using
IEEE 802.3 EEE or "autonomous EEE". But i guess it is no worse than
SmartEEE or AutoGrEEEn which also make no indication where EEE is
happening.

Thoughts?

	Andrew
