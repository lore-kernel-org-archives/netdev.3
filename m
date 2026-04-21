Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9F2773F0;
	Tue, 21 Apr 2026 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801227; cv=none; b=CMlBh6I/KhGWzi4uOV3x0B6gsf1dWLDMmFRRIXH4XN4JstHgLwm8xLYAraehDows1q3Vmx8+hndbuqy7E/tmkuJv4Rrqj1cRtRO7hMwMIhqoFtS20iCgx7ie66prMZIKFHkixEeNni2ueEy0dNNOPCHLZWSrE/lpBDXGSn3pQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801227; c=relaxed/simple;
	bh=FaFB+DFyDWRWp5z+fgy1T/7I2LSiLos4OcuENnmIcUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O920TPk4rn0o/vsmmJQQG2+44zC7c58WqOdPAFWpjaRN/nGxM50q3wUiwqe2vbj9OTS6TkRIQTnLN6OW8IxUpmcAhweh5Gc8oPwQqkp19afGQaXV4vX4dDXW2LXEjHQ77bL8dCJ2VBI4GMg6HQGk5Bg+t0CRy0GwijBUBmacqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N4tTsZ1H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N4tTsZ1H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cwTGCdWh4RgUZd0GLY5pjfI07uMKtrCjhIjcs2S8+1M=; b=N4tTsZ1HVZKC1WFCoJ5mOaY0W7
	6HHo7selJTlKeBTU2zlkfgR3M57zKU20BN1a+/gU2/cg3FVANXfES2IWFfMXWM+fwCIlZ5zG+PUFP
	fSeSmbqvcGwOQ65G2Pjeqd1xYhlUe13F6jnT0Axfc8DkNNi8VISLpGK9lOdjnIJz1LO0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFHAA-00Gwfb-86; Tue, 21 Apr 2026 21:53:38 +0200
Date: Tue, 21 Apr 2026 21:53:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
Message-ID: <87441489-afea-44c4-afd9-8f1693b32ce6@lunn.ch>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>

On Tue, Apr 21, 2026 at 02:31:03PM -0500, Andrew Lunn wrote:
> These old drivers have not been much of a Maintenance burden until
> recently. Now there are more newbies using AI and fuzzers finding
> issues, resulting in more work for Maintainers. Fixing these old
> drivers make little sense, if it is not clear they have users.
> 
> These are all ISA and PCMCIA Ethernet devices, mostly from the last
> century, a couple from 2001 or 2002. It seems unlikely they are still
> used. However, remove them one patch at a time so they can be brought
> back if somebody still has the hardware, runs modern kernels and wants
> to take up the roll of driver Maintainer.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Andrew Lunn (18):

There should be 18 patches in this series, but it seems like b4 send
and exim are not working together too tell and have truncated it to 10
:-(

I maybe have a fix, but i will wait the usual 24 hours before
retrying.

>       drivers: net: 3com: 3c509: Remove this driver
>       drivers: net: 3com: 3c515: Remove this driver
>       drivers: net: 3com: 3c574: Remove this driver
>       drivers: net: 3com: 3c589: Remove this driver
>       drivers: net: 3com: 3c59x: Remove this driver
>       drivers: net: amd: Remove hplance and mvme147
>       drivers: net: amd: lance: Remove this driver
>       drivers: net: amd: nmclan: Remove this driver
>       drivers: net: smsc: smc9194: Remove this driver
>       drivers: net: smsc: smc91c92: Remove this driver
>       drivers: net: cirrus: cs89x0: Remove this driver
>       drivers: net: cirrus: mac89x0: Remove this driver
>       drivers: net: fujitsu: fmvj18x: Remove this driver
>       drivers: net: xircom: xirc2ps: Remove this driver
>       drivers: net: 8390: AX88190: Remove this driver
>       drivers: net: 8390: pcnet: Remove this driver
>       drivers: net: 8390: ultra: Remove this driver
>       drivers: net: 8390: wd80x3: Remove this driver

You should be able to tell from this what is missing, and i would like
to remove.

    Andrew

---
pw-bot: cr
