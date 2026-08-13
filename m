Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400B468C2A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634399; cv=none; b=uD4RqY+ZnP6G0aY+pOvi22HlSSaKI3vNVwGXCEc9weDytkQ5jqdnPgobS7H+bZy1Krof1r/OdOLN/DzBsTiCEINpHr5N2BxUB2IRCmHHBdBDj1PIaiDJxmgftJ//SKy9ah7elCOTuwS1LrfBPRLA6cnqBm7C6/jaoxQte4Y6TYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634399; c=relaxed/simple;
	bh=8k61t7R+V1FgEev1BiktbrBgC8DuHXv8bEqMvOdvlQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGpoftkaZQ+GFj2Bb1tARdcPBExPAo56x9irh8ZByf2GKtosv8IlnY3SnyGRjIZDiV4q58chmLIyUHgUH16Y4V6ed4ROPvLABv28MsA+ffi8kuFEopo+ZvGHZGYZMcy2x8HGX+StzY6GWl2ASiwiI1dndwvYnQnkFrCaOZLcmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AmV9zIlQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AmV9zIlQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LxuK3RHX6dzbXXjbTcCmQ7PaI6foA5pgSVZ0vR34Nv8=; b=AmV9zIlQPCQdfRjYr0fICUbgcp
	FSuFGCxMAchTIsssBO724W7DwDIycxiG30EcG83TA3NC/XzyEMdC59S6yFrSX8vJqkG/yOJgK/uEt
	7qeb7AeHGnb3G6+4kiBV5cuTJMITel1YvTTBmZminD8W+wTJfhxUkKB9gEoOxKzKEoCo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuXDf-00HRro-Sa; Thu, 13 Aug 2026 17:19:47 +0200
Date: Thu, 13 Aug 2026 17:19:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: netcp_core: fix device_node refcount
 leak in netcp_probe()
Message-ID: <0daf39c9-d2de-46da-8cd4-09de13096f56@lunn.ch>
References: <20260813111058.500-1-manushprajwal555@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813111058.500-1-manushprajwal555@gmail.com>

On Thu, Aug 13, 2026 at 04:40:58PM +0530, Manush Prajwal wrote:
> When netcp_create_interface() fails for a given child node,
> netcp_probe() jumps to probe_quit_interface, which releases the
> "interfaces" parent node but never the "child" node that the
> for_each_available_child_of_node() loop was iterating on.

Would for_each_available_child_of_node_scoped() work here?

      Andrew
