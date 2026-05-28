Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E01AA1D2;
	Thu, 28 May 2026 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003578; cv=none; b=Nfmc/157yu7H4hKlD0hmI7K1+Wmrc5KNmRsds3I73Zc0XcdxDLdcQg1fhZN9cj7KFXOhFjl+EJSX61AIT+9w89kfg+9Jq8hLnLgpGoueH+QbIm+FG8u7R2rrjNHcoDOFkSetYBd7L7regMnsupzZu7T+uCJGVIIQn80zv22VW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003578; c=relaxed/simple;
	bh=S98SDO0f+qJR7ZqRLSy/M0Ouv7PvcgrKB3dYMIaLu2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUGQ28m+HUl5MZgCV+vfOG1T32h8aio0ZwCCiN7CoujB50w2GQ0a6BWyBX6p3jxjch9qI0fbFd3WAq7TOnnRJQowV1aB7r4SQE+lx4L4Tho+Uuevf+Cr2coqhV0pa32J5OTZnMOTq4OloMsd/OAZbPu3+OI39tw3ikdJRvle8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ovujxswl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ovujxswl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rr+MRh041lkmNv/9tr/XvEVM86YHXbcseFG44X/WavI=; b=ovujxswlhjmGbV3v0IySIDVmvC
	/ll1hu7t04vi4SH4hxvSvXRJAFuVurWgJM/D+xJKiVk06/yMDMtINQgZvEC5tfTgMNbuY4V5hSPiM
	C+EfoJkKehDDcYuDDhBIwz8NQ3BVIBXhvmYgl/wNum/UMPGIqy/Bhu4/9z0MWKhAgePM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSiEu-004xtA-4I; Thu, 28 May 2026 23:26:04 +0200
Date: Thu, 28 May 2026 23:26:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, marek.behun@nic.cz,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Subject: Re: [PATCH net-next v3 1/3] mv88e6xxx: Add mv88e6352_serdes_get_lane
Message-ID: <f72a700f-76a5-40ee-a24d-ecc8b24af290@lunn.ch>
References: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
 <20260528210310.1365858-2-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528210310.1365858-2-fidan.aliyeva.ext@ericsson.com>

On Thu, May 28, 2026 at 11:03:08PM +0200, Fidan Aliyeva wrote:
> Changes:
> 1. Add mv88e6352_serdes_get_lane function which checks if the port
> supports SERDES by calling mv88e6352_g2_scratch_port_has_serdes. Then
> returns the address of the SERDES lane.
> 2. Add this function as .serdes_get_lane member to all the chip
> versions which use mv88e6352_pcs_init.
> 
> Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
> Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
> Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
