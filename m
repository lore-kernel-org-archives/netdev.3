Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B0A379EDA;
	Thu,  1 Oct 2026 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855368; cv=none; b=vCigo7365Y7eU+ANZnl94PNWA49yyQRrGO+ChwGbI5fr3D1Iv2p7xk4bh+r9zZ6mm2mlh7ey6Ohqa7yPXt8+t5lAnf9+HsrfBxWHcYs9Ycu7dD4XIyB9RdUeWQ9+e+qgA5/2UHt0VRGbocnzn9BAdyFo4ZqedylUm0zndK1IGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855368; c=relaxed/simple;
	bh=oSurIycWFJu5mYdSyi3k9h1p3i/2qt0KW0D+rzArpJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOyj01bmMfGSLg7aPRO4UnXJ4wXsiac3URk/HL85Qyy3HYvtych7EwOJ2Lb2mBF1LqcpbKP9iesa4eVe0oUS+fXbtojyQrBDfCeBFSI0hh6qkyyFCrdZQCmWkrKA2tR0xiQ0R9eNwvV0tmmio9K6SAcOUQ4p3g86bpKHvH572/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xCFHp-000000003yB-08ah;
	Thu, 01 Oct 2026 11:49:17 +0000
Date: Thu, 1 Oct 2026 12:49:09 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH net-next v18 0/6] net: dsa: mxl862xx: devlink flash and
 rescue
Message-ID: <ar5ItRk_FL1ZJGBj@makrotopia.org>
References: <cover.1790426599.git.daniel@makrotopia.org>
 <80fdcb30-be96-49da-8499-2c673e95b75b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80fdcb30-be96-49da-8499-2c673e95b75b@redhat.com>

On Thu, Oct 01, 2026 at 01:19:01PM +0200, Paolo Abeni wrote:
> On 9/26/26 15:48, Daniel Golle wrote:
> > This series adds "devlink dev flash" and "devlink dev info" support to
> > the MaxLinear MxL862xx DSA driver, and makes a switch stuck in its
> > MCUboot loader recoverable through the same path.
> > 
> > The switch is flashed over the loader's clause-22 SMDIO download
> > interface after the firmware API has rebooted it into MCUboot, and the
> > driver reinitialises through a deferred detach and re-probe once the
> > new image runs. A switch found in MCUboot at probe registers in a
> > reduced rescue mode with firmware version 0.0.0, so the same flash flow
> > recovers it; an interrupted download is drained in the background
> > first. The deferred re-probe comes from a new driver-core helper,
> > device_schedule_reprobe(), which the bound driver calls without a
> > module reference; it also replaces the open-coded self-reprobe that
> > iwlwifi, hci_h5 and btintel_pcie carry, whose work function frees its
> > own module text from under a racing rmmod. fwupd's devlink plugin
> > carries the matching quirks [17].
> > 
> > Patch 3 is a driver-core change and patch 4 does not link without it,
> > so the series needs a driver-core ack before net-next can take it.
> > 
> > Tested on an MxL86252C switch of the BananaPi R4 Pro 8X: an upgrade
> > through fwupd; an unbind and a reboot issued while a flash was running,
> > which wait out the transfer and announce the wait; a host crash and a
> > power cut mid-transfer, recovered by the background drain and by the
> > rescue path on the next boot; and an unbind and a reboot issued while a
> > background drain was running, which abort the drain at once and let it
> > resume and complete on the rebind or reboot.
> > 
> > Changes since v17 [23]:
> 
> Out of sheer curiosity, what represent the number in the square brackets?

Those a are classic footnote references to the URLs listed on the bottom,
below the (lengthy...) history section of the cover letter. Maybe I should
move the URLs above the history section?

> 
> More feedback from clashiko. Requests about comments clarification
> are IMHO mostly pedant and could be ignored, but AFAICS there are a
> few actionable items on patches 3 and 4.

Yeah, I saw that, was about to prepare v19 and go into the next round
of mecha wars[1]. Patch 3 (the device-core one) should be perfect before
going in as it's (hopefully) about to become core infrastructure.


[1]: Fighting against Sashiko reminds me a lot of
https://en.wikipedia.org/wiki/Neon_Genesis_Evangelion
