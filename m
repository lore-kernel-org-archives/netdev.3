Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726DB364022;
	Thu, 28 May 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003813; cv=none; b=BiorlO4qxhYJndl42Uy6uZQVohApbBlJA4z4psp1fvA+hEad7w58RM7zrHMrXgq9TuWldHrGNU4fPryt5I6+Q09A7t26GgoEml3+tkabq/iE/cbktPc7AKKzrEo2NgK+VxyyBU0DV4sf1YqaXzz7pHVoho5O3RNZXamT34cyc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003813; c=relaxed/simple;
	bh=PMxoEY+yXfJ4Msi1ZL7wF7oTms+dQ7BiO1PjkryUM0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1nX9mftQ5W0xFSiCL11xor60EpYveYSDftoXwTlt+AlPwmdpZUxVwsUQY7l1tnL6SIaYM23WKskj34c583wyL6FXCMjUIv7O33QwquatncQtRQy3SV2ECiXOgv+xbXImhpa3b5NuQ04a3oKR+F5Uzfu2oRrf3jaRT+kbXSMV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P2UPRa3B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P2UPRa3B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6eMnXfUEpVzDphp9R5mh5ZyfMJt/2A+hyIB5ygWYQDk=; b=P2UPRa3BxosPJVjdAaFzpiyo8h
	GBTjUCGc0xDaeeLWs/DvMplBI0Lclo0T3QYi68PktIoC1YEGjffQOEoTpK3r7Az/cjt42jnHnzTpz
	uaC7bIwRCesYSoWQunqJWUR3M+M/YsXV0pDrWz7konH6nr+LsOk8fHwdpethJ035uYis=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSiIj-004xv0-A3; Thu, 28 May 2026 23:30:01 +0200
Date: Thu, 28 May 2026 23:30:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, marek.behun@nic.cz,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Subject: Re: [PATCH net-next v3 3/3] mv88e6xxx: Add SERDES Support for
 mv88e6321
Message-ID: <ef4f5a26-0abb-436b-8c62-3c7d58d17e8b@lunn.ch>
References: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
 <20260528210310.1365858-4-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528210310.1365858-4-fidan.aliyeva.ext@ericsson.com>

On Thu, May 28, 2026 at 11:03:10PM +0200, Fidan Aliyeva wrote:
> Add serdes and pcs_ops functions for mv88e6321. In mv88e6321
> 2 ports support serdes functionality; port 0 and port 1. These ports are
> serdes-only ports.
> 
> Changes:
> 
> 1. Add a function support to return the lane address for the port based on
> cmode.
> 2. Reuse mv88e6352's serdes_get_regs* and pcs_init functions for mv88e6321.
> 
> Tested on mv88e6321 switch port 0.
> 
> Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
> Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
> Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
