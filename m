Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15964F3938;
	Thu,  8 Oct 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483801; cv=none; b=ukGpuXs5KkGnaODOXTBwvF8J4pxwPSCqOLRgjtOs/yux7A5BTokWSxQ8Lrnkgub7E9YeMNRl6+VEdrM4eC21CeTuVUPzMlfnIHUxRVE+5A5uk7SnDnUORS+su/hDbUNJyp2ZXLdXuNgXm+YBhXWM9qbCKEHs8nPBp77ONGhdy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483801; c=relaxed/simple;
	bh=voJiBKDo6TtLO+YJAosyPC30c8P4HYREUemQBZdTb8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FciryHIK9ht9iyRhJF/9CrSr/E1WKqgAeTZOGPhj66JdyM9tKrMdQg3/5bXMd2MOfzTgsALCBOJTXBJ8RbY2rKoowOCx112R389UwtkvwKJymsvrlSDBOE9Pu9TzEVn2h5wQgkW5GpVf+urGThVfmgK5BIgH5lFtTKdN/GIVUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XGr/rzFk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XGr/rzFk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wq0FegSrzp/3imzFWJvCAVCalZW0JrXU0E954419sPE=; b=XGr/rzFkf1pHzA2G2/ykP2+JET
	94pd12J3hx3ceJFyhWO/nqivUA3kctWRJw8GZmDOlTFP1AWzvfhl74+YuY0jqrTE6vH+cBsMx/uLy
	+C4o9Q5OowPSBGYp4bOiK5n4dRNAgDrl4ZIBnBl51USU/EpqgCPqH+ommTRP5hjTLj4E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEsll-009fsi-LK; Thu, 08 Oct 2026 20:23:05 +0200
Date: Thu, 8 Oct 2026 20:23:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Daney <david.daney@cavium.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio: mdio-mux: fix device_node reference leak on
 success
Message-ID: <ed1aa3e6-05a8-4843-ba32-8b2612099b00@lunn.ch>
References: <20261008175612.2748920-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008175612.2748920-1-vulab@iscas.ac.cn>

On Fri, Oct 09, 2026 at 01:56:12AM +0800, Haotian Zhang wrote:
> mdio_mux_init() obtains a reference to the parent bus device_node with
> of_parse_phandle() when no mux_bus is passed in. All error paths release
> it through err_parent_bus, but the success path at the end of the
> function returns without calling of_node_put(). of_mdio_find_bus() only
> takes a reference to the embedded struct device, so the device_node
> reference is leaked for every multiplexer that probes successfully.

What would happen if the parent bus was to go away?

    Andrew

---
pw-bot: cr
