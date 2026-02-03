Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C11F4C8C;
	Tue,  3 Feb 2026 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081531; cv=none; b=SstgR0mm6R04GZDhJ8pwSEDpQ2r8Avt0BIZL5P9jjK/5RRWJpflt4ZtMlI0yZTQgl5Kr49wzkmsLZCdwseDCUVNgzwncwgf6WBY8edjpy7jh+SKoLLBbaaQ7H0cRbYsP0T5KyKnFQLybC3tL1WBAXnpowBK1BNt5IAKWm6HKNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081531; c=relaxed/simple;
	bh=2dcAwA4ngQH884BWykAAsd0RSyHh9e4cDiFC06OQjIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULrvfFh/RzdF0OW5YgrF2GBnPNPtHt0K7VWEUlDoEGVH3DYeA3TTOX7QtUkIjm/qNHJxNotevViqyak/EjoSKME8y+I7mL7SBpeUNz4oo4g4QRa8YstxQNMi+texkzq9tdb0xEXLhRaZrEYhtPKvlD2yE2q4pyZUeHhCRTJrdh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6CdICsd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6CdICsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16845C116C6;
	Tue,  3 Feb 2026 01:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081530;
	bh=2dcAwA4ngQH884BWykAAsd0RSyHh9e4cDiFC06OQjIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q6CdICsdKn2CEIXt6mOkECsNoG1EmCWwh66w/zYxUTVcOKvazcEMHIb79jf6HIwQC
	 71as6el/TUycXIfjWB7agsikcs/BISHrtSnu2W3jnP770yNIiYOKKQqcM3LzdGssFv
	 xn5X7GQoqCr1g74+22RvXOw22XpctU3A2VFyKKG+0qJ/T8CF2gFVI4ouSS5GGWUBb0
	 yxDonRrWIzOZeQuBVdAHOPDcuwSdC5yarhv/OZLgv7T2t+rSFO2AXeS2KEM1m6jymR
	 IvNMkcbo/Nb+iQ99W4r8AAdoNCf7q5KKGJ/Vc4HT1+nyMTfu9WUHWtYqfrIetODuft
	 roqVLB8Emp9Ww==
Date: Mon, 2 Feb 2026 17:18:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Peter Korsgaard <peter@korsgaard.com>, Steve
 Glendinning <steve.glendinning@shawell.net>, Oliver Neukum
 <oneukum@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Max Schulze
 <max.schulze@online.de>, Krzysztof =?UTF-8?B?SGHFgmFzYQ==?=
 <khalasa@piap.pl>
Subject: Re: [PATCH net-next v3] net: usb: introduce usbnet_mii_ioctl helper
 function
Message-ID: <20260202171849.2e7076a0@kernel.org>
In-Reply-To: <20260130073810.29090-1-enelsonmoore@gmail.com>
References: <20260130073810.29090-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 23:37:49 -0800 Ethan Nelson-Moore wrote:
> Many USB network drivers use identical code to pass ioctl
> requests on to the MII layer. Reduce code duplication by
> refactoring this code into a helper function.

Does not apply
-- 
pw-bot: cr
