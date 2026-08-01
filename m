Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5F3CA491;
	Sat,  1 Aug 2026 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785614238; cv=none; b=naU1i/9sObRFSCRP8qu4v1gTahcAJpw02YYREZ5BviB6tvEpeCAs1wgaqqMZL3rWspewxXD5g9pB8cz/z2ra+mU1aDP51Xsb7Xv5MiJOTeTygIgnHrJ6kEoW9t5dOn5Fkr/r5PYzlQ3iAQkvDfwL6xjgNbp7KM15wpZRt1/6IhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785614238; c=relaxed/simple;
	bh=7YzByDeDwfy1oCkA4XWwIGYYzx8uIIGGG5ebfgDp8VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRMFSMvQbmDZzIyjEjNri8qtvNoCs09C3ttOUCwv/eCPFbqS679sRYYkzxdRbURAuJqf0EeN/XlUuRCwCmCQqf0rmaaOBeuEyyb33nerF9HO0hjTJ/zrVGdNxoE707vsWp4Xayu9M7/SGhxOauaVQYh4KVQen19Ug4s1C/sYd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NxHypoqA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NxHypoqA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xb/urTpnzm5JoYoECLFkeAftdKis9kjvktyD9YpaF1U=; b=NxHypoqAww9nO5Eu+LZ3jckQ74
	uVFS/aIgQeF3hpIyN5/ngyqjlcTekN/i8mRLrnbO015jQqsD05JtgvxrU6Yp3KZAM/DACFgCMDPNc
	etacymxwAshwgCDAUmnt5ut/FIcjV7qeBFlY9rwM9+KJ0TEDDq+/t/Im6zmkMeQjnVls=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqFpH-00FPiI-QL; Sat, 01 Aug 2026 21:56:55 +0200
Date: Sat, 1 Aug 2026 21:56:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krishan Singh <krishanmohan298@gmail.com>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: fix hwmon_name leak on hwmon registration
 failure
Message-ID: <66ac9090-fdb6-404d-aa75-bd3adf8578ea@lunn.ch>
References: <20260801065703.43896-1-krishanmohan298@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801065703.43896-1-krishanmohan298@gmail.com>

On Sat, Aug 01, 2026 at 12:27:03PM +0530, Krishan Singh wrote:
> When hwmon_device_register_with_info() fails in sfp_hwmon_probe(),
> the string allocated by hwmon_sanitize_name() is not freed, leaking
> memory on repeated hotplug/probe attempts.

Have you actually seen this, or is this theoretical?

I'm not too familiar with this code, but what i find interesting is
that sfp_hwmon_probe() is a void function. It has no way to say the
probe has failed. So how does the caller know it failed, and it should
not call sfp_hwmon_remove()? I suspect sfp_hwmon_remove() is always
called. So sfp_hwmon_remove() should be changed to release the
hwmon_name if it is not NULL.


    Andrew

---
pw-bot: cr
