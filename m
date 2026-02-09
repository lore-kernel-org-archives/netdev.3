Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B72550AF;
	Mon,  9 Feb 2026 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644182; cv=none; b=mkXk9/47Sgimp+XA94/seMRPE1WuoLrGS6wVlNFStOrSIhsduZSXOzfFw+LN2KPIGbzq95dbOYRpRMfNZlkv56xm8MOeEdHxpeBTxyX/l8DyCFm3L+HbiLVC/iuuZTc0MKCPB+46UaUz56PHWPNzTqFwgjr16ROS2Y2l/XjXhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644182; c=relaxed/simple;
	bh=+cjP80+a8dgdsdn2M4849gSykOJt0JIj9XHlLmO0zd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzqiA7g1ymSYmTpWmixktoPzQ4DGRx8qjYwrP8eMcPX1K9jgNjILlrsc1F34hMaStGxj8s4q64y9cKp7YLwhUbk6UGJvS1dLGZhMK0I33Yr71jLOwQMSDOajEORVLhxxRiGLeFFG85xi0unf5mEodfkZSrwvjTfizL8qFoCZP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5KfIBeHa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5KfIBeHa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UuNDF2Ns4f45baWz3NNbya0FvbLHCGIo26nT626VlzY=; b=5KfIBeHa12eR9WST/i3dzJb3w1
	trBUsYby0QvUmhsY8JnlwBB1x0eL1byvWGyXwPtC7FVz8DZMYcs/+XqYWfYZPod3T6i8AhLKv2tQv
	wJQ4C9LUBsIjXfW3+rCDAX96gGgs9PIvUAsgHbdEewsMGMJNtkPlgkE2KMly63kzblPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vpRQx-006j89-8v; Mon, 09 Feb 2026 14:36:11 +0100
Date: Mon, 9 Feb 2026 14:36:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH v2 0/2] net: stmmac: eic7700: fix EIC7700 eth1 RX
 sampling timing
Message-ID: <64bf6b40-b947-4ffa-8d48-4d6341931327@lunn.ch>
References: <20260209094628.886-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209094628.886-1-lizhi2@eswincomputing.com>

On Mon, Feb 09, 2026 at 05:46:28PM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> v1 -> v2:

For version 3, please include a patch to the SoC .dtsi file adding the
Ethernet nodes. We like to see users of code being added.

	 Andrew
