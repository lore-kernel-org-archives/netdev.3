Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357442BEA9;
	Fri, 17 Jul 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300047; cv=none; b=QSeLC80hVYTiOjp0RQo0//7hroWfdZBURN0I0Zbcdjap7iJRlHZPmj0g0twM/CAgGeEe0ydreb0iw2/l0GP2ydxGZ9CvXlCdI+rFClbovdSe/5hzTHruHyC1k61/MIqsNfN1EH/ziLA+tLOlIweSiVkWshMGLVAIN9+5z5Ua8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300047; c=relaxed/simple;
	bh=s4Z+Bv1QIf/hgVA+HnUZMlniQL17dV6XY47NmY8b6FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsDdhE+sAeQmXUYx6ykjAR1Kj4pakZLxa6aR5P7ToUmU1G4bLZzv9xat8VrUVaQa+KYJqua6k0RlmEjbgUs51jq7xsYCM1klVf0Nz/bHKCdFFiwgJvJ5UdR2tPgQkdkfWGduJjvVu6X9WIa6Qr+ZEm4vyuNzRpD1twYaTz8vK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qWlM66jq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qWlM66jq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1iwOL73M04ZPsa8c2OY8QySkEKZOZ/KgOVSBMSFiR2I=; b=qWlM66jqyNJoT0dbXh7K8xUVLU
	PwEURB/UqYTwGzLQhQ5xvHsT6F7zkoxxYi8RK3XCrOfz0Ji8cHoD2QXGRKcS4z/eqB4YFxP8EmU8s
	34pSMj47OZYG/CwPWBEtM9BB7Exo3XJykS38Dduh7N0Bd2eOgB7nNX9Picq02uNxW1Yk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkjwj-00CpO0-FH; Fri, 17 Jul 2026 16:53:49 +0200
Date: Fri, 17 Jul 2026 16:53:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [Patch net-next v3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <3a576b50-f2be-476f-b702-964a8158cf1a@lunn.ch>
References: <20260717054807.1321374-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717054807.1321374-1-kyle.switch@motor-comm.com>

On Fri, Jul 17, 2026 at 01:48:07PM +0800, Kyle Switch wrote:
> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
> 2.5G/1000M/100M/10M speed.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> ---
> 
> changes in v3:
> 1. Using common apis defined in phy_package.c to handle shared top
> extend register space.
> 2. Add dts demo in motorcomm,yt8xxx.yaml.
> 3. Fix unnecessary redundant judgments.
> 4. Fix BMCR registers operation using magic number.
> 5. Rename funtion based on its approximate functionality.
> 
> changes in v2:
> 1. Remove duplicate code and replace it with existing api. 
> 
>  .../bindings/net/motorcomm,yt8xxx.yaml        |   30 +

Please put binding changes in a patch of its own, in the patch
series. You also need to Cc: the DT people.

    Andrew

---
pw-bot: cr
