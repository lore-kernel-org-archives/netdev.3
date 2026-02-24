Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A227F195;
	Tue, 24 Feb 2026 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954558; cv=none; b=RkA4WnH2D13NP8xMvYlivszScotI1bTa5JsVfGFW1Tw7k10+hL5deiz94wkxIxvjCW2shuLpLYgw7X65uNLOMNmewEiIxzshppLfYlfVzRERiu+smU4CcoGwv0XK9S3p7rNnrOncURLt6CyTG1wEP6PYmmuJTaje60bCdY33/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954558; c=relaxed/simple;
	bh=FANanv60YdJdTgmgZVSFI8cwXQJOUroiY4SelPO6sOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI0vRFRyuNC1jr2sSZ28AkLm4N3CUBcDOkfNnXb7TwSU5hQX6ES6MXs5vzyNBSkwhGbs9s0z9rtx3G/dulwItVjwNF6IQerhogAjzVSF7SsQcGS7u4lnZQr6El9YvdvPMK4lVFZE3tS3ri7MD6eqBsClXKtEcW4THyFqIQj0HGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=34+3n7Bv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="34+3n7Bv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qbE0xjTqfcKiqtqbVBu1tzAoErqu/IOiLVqQbElaH1Q=; b=34+3n7BvkImara/zAH0UxjSOh1
	iNJvkhrQlHnoxn+9bKXdrAxUDGns8m2ZCmsVvtRRxeQZYPfDQWmzTV6OxT2rXjSgj2zhK98qoEEen
	OC3Ath1NqgiuMmUJ9qxFk2qLYWcDL/RSXcRRcx3WtcEDWLXzdyk8PzChRTF/J6E4wi7o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vuwK0-008dQt-7J; Tue, 24 Feb 2026 18:35:44 +0100
Date: Tue, 24 Feb 2026 18:35:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: phy: add Rust reference driver for
 ET1011C
Message-ID: <f968578d-0e3a-404f-8aa7-6a8852e9a134@lunn.ch>
References: <20260224043211.1747-1-iprintercanon@gmail.com>
 <20260224164926.1760-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224164926.1760-1-iprintercanon@gmail.com>

On Tue, Feb 24, 2026 at 04:49:24PM +0000, Artem Lytkin wrote:
> This series adds a Rust reference driver for the LSI ET1011C PHY,
> following the pattern established by the existing Rust Asix PHY driver
> (ax88796b_rust.rs).
> 
> Patch 1 adds a speed() getter to phy::Device, needed to detect speed
> changes in read_status.
> 
> Patch 2 adds the Rust ET1011C driver itself, implementing soft_reset
> and read_status callbacks.

Please don't post a new version within 24 hours.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Also, each version should be in a thread of its own.

Yes, the code is the easy bit, getting the processes correct is
hard. But given the volume of patches, you need to follow the
processes otherwise it does not scale.

There are also some unanswered questions from the last version. Please
don't post a new version until the discussion has come to a
conclusion.

	Andrew
