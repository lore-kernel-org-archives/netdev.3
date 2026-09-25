Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2A509EE5;
	Fri, 25 Sep 2026 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377539; cv=none; b=m0S56RFsV61/Iq4+dLgUCYgOXoy/J+vCWNtxLKbHMTRlPiAOBLIquf9fKmM5lwnXDvZUVtAO1I2FIRSBi0IIWr/n6zipFQ581rBNDgUyXAveQrp61JHOxfWqQWBxiluB3Ma5lvqIDObD5ROXpYwZI0A66PIlV+EizsGFsmGtfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377539; c=relaxed/simple;
	bh=LMwUrexg5MYp8D4MWw5WQwWioeeqPlbIybHckuzqhpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTiSV39zGjqxxsFFJdEc4IUeZz7W5U5cpgPyIjVMos+iTxXNM9IXPLAEaxBnAwRmtxLKFT+jXlatUruWm1lsSR8ZJt0SLtJ2OIg02GqF7mz9oDxYdADm/U/0yD3oSchD3m1zi5bzhpAtpvOgwZZlDmao1BpyaHmJT3g93FWdHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXL6gupj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXL6gupj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1EB1F000FF;
	Fri, 25 Sep 2026 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377537;
	bh=/nqerLrI7D/LhfSEE/uJgIk4FS5q/5uc+1kXdZYr28o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AXL6gupjn5+z0W8t9ES2zL1x098MaWNMPZKvfCGy+6oQu9peMOAHjMAvOeXlqHH58
	 AVng8w51272KdNa5kPpN/4FWPHWkFlfgp4Xtj4S8y6SbrzTnod/vkQylczCg+BbHNS
	 NwgSZwZf4f/v4b+roRLwAEhLYUucLLVOczSMq7otAQm8virbo465hzhWN0ftXMhLF0
	 y8UHpU6pyhuW02EC1co+17sOohVl72mGohhY3Ihg4qYg/zHUpq2Vm6VikdemZx9J8a
	 S0GySSoKfU+ewibwyBsc8q+ZvtIapeYYcaOQsgbqvcVn111pL2+5xdER/F9IHq8oiA
	 cPxcqSR5ibX4w==
Date: Fri, 25 Sep 2026 16:05:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli
 <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: Introduce a selftest
 for ethtool flow control
Message-ID: <20260925133144.71edd8b4@kernel.org>
In-Reply-To: <d06c0f50-777b-4ffb-a3c9-affde5bb5030@bootlin.com>
References: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
	<20260920164732.349744-2-maxime.chevallier@bootlin.com>
	<20260922194251.06e00e2e@kernel.org>
	<72bdfa09-34ea-43ab-88ad-b3c64c7e1f70@bootlin.com>
	<20260923201051.66e9bf14@kernel.org>
	<fb18618d-6402-4f7d-b318-1872570ceb27@lunn.ch>
	<d06c0f50-777b-4ffb-a3c9-affde5bb5030@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 15:59:27 +0200 Maxime Chevallier wrote:
> Some side question, as the whole thing goes into the same file, do you
> prefer that the series stays split into 3 patches, or do you prefer
> the whole thing in one single patch ?
> 
> The diffstat would be :
> 
> tools/testing/selftests/drivers/net/hw/Makefile |   1 +
> tools/testing/selftests/drivers/net/hw/pause.py | 998 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

You can still split by functionality? No strong preference from me, but
I think you were asking Andrew.
