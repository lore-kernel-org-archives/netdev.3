Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73E2D3A7C;
	Tue, 21 Jul 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652168; cv=none; b=ruxZNewuRRV25qXjaiduBPxkLfnNbL/niQc3stURWJfnKYkN17NdaBsWRLy8CZqLS8Wn/dv3gLtx9m3xCZPBTTngfG/e2QHDtmgCJ9Mu21sFwA+PW4IpSdj/2z4V6PGfPHLvhNIHcH319hxepyEMtHJCG8bM8lgPJcF1BM2hu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652168; c=relaxed/simple;
	bh=HQUGBDFR1nv9TsBox3bGaaNweZhMIXs2dEs/QWbZJBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYXjU+iEIdgqUwcU0GoyYkSk42P9nD7/IQ0aD8JEJ8mR1P37g9DkailtQakmm0tbYaJFnz/teGH2T2wz7FQW3zyX6Ch57013gfvYcXYqkrpbMJYw3vXX4RFLIQYiGeFlEdVJYu8iiPNr8YcS5I71YE+br0L/NaDVxR7v39IUMIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEr+lfzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEr+lfzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC0F1F000E9;
	Tue, 21 Jul 2026 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784652167;
	bh=B5qM9chBCdVYWvuZvuUKvIvKfuTex0gYLfS3OQl7ilc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bEr+lfzHr9tBe8KVs+4dUMAA8Y8DzbSXuACDc+80BtqwzrrEkkvDysl32+0Ne2qSc
	 sCPcQrw6uC3ltYQ+72SZrlCKOAlqk38JGmlHfNCbXhuHfpFilXI6zRmfiKkAtGi9/T
	 7R4qZsppur1nLm7j0nLgidKDJNCoKsR8dFWRf6uP2cIZ2b+IcP50AIb59Hw3EVdBJV
	 d15Uge/sHXdAqkU23jfioEhGDN6fGYaJlCsvXNUPqv9CMMD7SABn1RfTVHFniRRIEt
	 6PjfNWVVx8a8gCKjFCT1BmgHlr4HBmCJXyd0SxvSDlzj/+FmFwcYQTx3OC6MjFI4H/
	 BwqjmhFtTEWAQ==
Date: Tue, 21 Jul 2026 09:42:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Russell King
 <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next] net: stmmac: Simplify ioctl handling
Message-ID: <20260721094245.1b6aab2d@kernel.org>
In-Reply-To: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
References: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jul 2026 16:38:47 +0200 Maxime Chevallier wrote:
> Now that timestamping is controlled through an NDO, we can simply
> call phylink_mii_ioctl() to handle ioctls.
> 
> The only functional difference is that phylink_mii_ioctl() ->
> phy_mii_ioctl() can handle SIOCSHWTSTAMP, but this no longer happens
> as this ioctl is not longer dispatched to the ndo_eth_ioctl().

To double check - the discussion is orthogonal and this patch can be
applied as is?
