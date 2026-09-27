Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C728505E;
	Sun, 27 Sep 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506181; cv=none; b=K22t7JHDhT4G99FuEL3/rhL93Qz0UO8XUD+2mDvH//iSzIpEDN4/eSHuDM2OcMIowEFD8rJ8Db/o/MdOoWIB2x2p1C8Mzw1A5JFqQLcpZWzVl5Afs6Pv0MF+XSHMawko+CEcF0oQFtT8e4Ibb9iJ4Cemk9W6nDC5uIfznih2v/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506181; c=relaxed/simple;
	bh=UyoUiXZabuIJ4XJ+VrfhUjReKoDViHsoCybaP7HS3qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G23VD7c0/5vLLxftXd3NcBUSLqdqIEbB/gbceEJH4WE0lP0lS0Cr8SCWEDU+Nmv2TkgiGkuqmgQYQOwH6Gd7IuZ7h/6QPJ29KmxMOYk8+vYUAsek0aPqFzdWm7TnKmmXStDjG/HeifHeuXWSKIV6btfZNk9V0tihw1W+0XRzpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+oJem/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+oJem/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0831F000FF;
	Sun, 27 Sep 2026 10:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506179;
	bh=B4PHMYQKOohn2doSN+yTKT6+Y2m9WsZpN5ypKkE1J9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K+oJem/Yl07m2wJPoBgtvKm5SQbnhFYxSbkNPF00d1NVWDohI7oi1KVw5CfnDyJzf
	 WN7wwGR6Uxd4whM6X/qoaYk8tWXamRQRZJY3JmkIXCks2ZKI+QyXdiZg8+suvNhbiZ
	 5uQ/kwg8sw1Re3abGEPYJH/g6/y6njs3+abqYKX2IEPuCFe7ke8uA5wu/PoTeDVUfp
	 PMDaBniq3I4ptZbYBy8teU/MtYmurrwqTpkrBnb6x0sYXUBJuTo5ZlxeXZqi/3hdca
	 AzXbhAErCBhc7AKG35Oxcz7vInZEs01y73EnHozBZmFx8y2NoIDsiO3fpuOF6snye5
	 EsGVQjw8XAqtw==
Date: Sun, 27 Sep 2026 11:49:35 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next 0/2] net: broadcom: Couple of minor changes
Message-ID: <20260927104935.GF13925@horms.kernel.org>
References: <20260922222525.3992167-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922222525.3992167-1-florian.fainelli@broadcom.com>

On Tue, Sep 22, 2026 at 03:25:23PM -0700, Florian Fainelli wrote:
> The first change makes sure there is proper reference counting handling
> in case of error/removal for the bcmsysport driver.
> 
> The second change removes duplicates definitions in the ASP2 driver.
> 
> Florian Fainelli (2):
>   net: systemport: Fix missing phy-handle parsing for non-fixed PHYs
>   net: bcmasp: remove duplicate MDA filter register definitions

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

