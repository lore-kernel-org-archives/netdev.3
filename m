Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71A26B742;
	Fri, 23 Jan 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197474; cv=none; b=q6Knafv8LvZavAaItEmdldl5sMrN12kTWsrJrUnhk0OJTbEmQct0TuURtSY96j5IePY+J/ZJGqLj8F/CqY0Jxo5jylJxQs9UPxYEeIObulf52wxicaKUGcRGxNIrgkQDJkSbH565p7qr2daD1yH/SZwPrOhMDFkFIpO+iOR6pTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197474; c=relaxed/simple;
	bh=31pGCydMtJqGJEd+d/Gzfci+FTlFq3ciMVkFLAfrlzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbJNviZ5KwUo3KBToBEoFt510nU7tCegwYvC6+KsCaLhLStw6TM8k817a8ewCdWe0cnyZqNcNlOvKLDMLRaI8VKzSa56FQyIGE7hm3L6o4SJzU+bggBrBNICZESChSCF4ZlA1tyxqjzkJ4KMv6FILogx+enXiYPAjeNFRW3c3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cq9wDqCD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cq9wDqCD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UdHU+h4uxwUHwXuGJdbHXVZDG3Y6hphAfDb+gNrUSBo=; b=cq9wDqCDZDx2hy2F9WZ26yxe6y
	dCVE39MWlIZBcV3/34KOvVX2pL+B/99mbLhs/TlH0+AGotLu0BHMHWQJV0B1JZdnOo3P6QbJ9PFoI
	ixVQtrwQ29nQwBfUShbJquE2Lsqg4a1OjWkVKER9zFV7gxLHpg6UO91lH+UIULdIfYHY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjN54-004JWI-Qk; Fri, 23 Jan 2026 20:44:30 +0100
Date: Fri, 23 Jan 2026 20:44:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: usb: sr9700: rename register write
 commands for clarity
Message-ID: <8b818341-10ed-4d4a-9555-5731d2bd4a14@lunn.ch>
References: <20260123080409.64165-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123080409.64165-1-enelsonmoore@gmail.com>

On Fri, Jan 23, 2026 at 12:03:58AM -0800, Ethan Nelson-Moore wrote:
> SR_WR_REG and SR_WR_REGS may be confused at a cursory glance. Rename
> them to be more easily differentiated to prevent this.
> 
> Suggested-by: Andrew Lunn <andrew+netdev@lunn.ch>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
