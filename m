Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99011239068;
	Sun, 27 Sep 2026 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790519062; cv=none; b=DFCxsKTWrrOWq8Z+ECb54KyRaqh2XPbMTtVrrFGXfW1sJtjy2zGAFWLBtaU8JaUsaoywa4hr8kd8h4IuCmj0cxwr2jceemzkSNDlmMjsT/YYlVjM3FgAEnMFLZmpdVz7+RxuIZbSOZNJoAqafMUEkeKs4KFbr1M5tnRuaVmM8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790519062; c=relaxed/simple;
	bh=IcSoJAc0uoXmVc71gAWhHhASwCqv+rTsfRuOofentWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcQbwNVPM15jcayDUqlW2N5y54taxGPJkh3SdDBWIE/Pz/0k3BwVCJPK8YhnLlsCnQb//Gq74IsHbxtW3aXhNNNr+RcsP0Yg9JWWOsXfQ0tyw360CHzvhy52pEyjLKHn3nvDTAZNuvMltVGGtjv9nix/vvcnMQEReppvX2lqRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W4nLojvQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W4nLojvQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GA2hUrkc8lTsQl4rvBCkFKw6kYz45j+l21TDu9L0Rrs=; b=W4nLojvQs+45Ob+mTiX/lLCQAq
	d1J5oNSeCbaCPuh0wGe7a7yYo69Te23ay1cE1rdfvr4HjB8RK9VAP+HEk0BWeBiVzO3vBTrg6hB5S
	YOnCN3Bq4rOoEXR3AhstwQUfL4RcWe0oPyoU5IBox04Syf3/XUlnFN1EkuzTJj3SDWuI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xApnX-007WMS-O9; Sun, 27 Sep 2026 16:24:11 +0200
Date: Sun, 27 Sep 2026 16:24:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, neuromoments@gmail.com
Subject: Re: [PATCH net-next v12 09/15] ax88179_178a: Add VLAN offload
 support for AX88179A
Message-ID: <f27b2a1c-afb7-48db-9682-acf6c0a83479@lunn.ch>
References: <20260916-ax88179a-v12-9-60c04c9924a2@birger-koblitz.de>
 <178968030096.22033.824447734953057557@kernel.org>
 <289700c4-8569-4160-97c5-2fc37a901a9d@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <289700c4-8569-4160-97c5-2fc37a901a9d@birger-koblitz.de>

> You ask: On a busy bus, or when a transfer stalls and hits the timeout, this
> blocks
>   all other network configuration in the system for a long time.  Could the
>   clear be limited to rows actually in use, batched, or moved out of the
> RTNL
>   section?

How long does this typically take?

And what is the worst case, if the device is hot-unplugged?

If these values are small, i don't think it is an issue.

   Andrew
