Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1080248F66;
	Tue, 30 Jun 2026 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857157; cv=none; b=M+MPUWvLZu5TtshusF7iiuoYnVdkNPHBU+n74X5oEOfDRfacuebjwhio2PBQfQ2Wsw0B9G+tgb/VD25b3oFokBmUi7vR2xRbz7T/iuVBXnT4IbRpdQ+440VNEpFzTrACVN3KGSJayuGDqfWLwZVXv2yZPBJPiyRK1H9Nw1OTeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857157; c=relaxed/simple;
	bh=iZY/SN5neogzI0BGV6RQH7zuMkhmWhthxtKeNKWqXNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ6qVfRuO59eiIXlAVgGy0qfb4/yMbuREnRjI9IhIcL0jLpZe0mSOeA0EAqLRe//io6WcNzsFbTxngYty2xu2ys0Vrs9rHroMF5QPxVM2+Ddc+RO+AgCLQb2MhiAN00+QxgnTJNzZYJI7nCajXoSoNEV4/4WS0SgEivF8ztf9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sXJ0p2Tt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sXJ0p2Tt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5AWjf6/VDgEl6krgDa0UEq44NylSD0Tc3uCkVdGyjws=; b=sXJ0p2TtdOshibb9LBgWjhaiMb
	+aXbSKgB8iWtGdXH1iSlqTCUHXssbYR1UPo+8sqZrzig1L0B8o6YTW7+BqRVLnjw7Qi0hkUrCVRKR
	xH5FqQADVH+J4Ys+5NzfMweu/vqR2gWsbi2L61OFRr/izQi9W5mPmiA5DeZgs4HLkf24=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wegaQ-00A3BT-Ly; Wed, 01 Jul 2026 00:05:46 +0200
Date: Wed, 1 Jul 2026 00:05:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com, nic_swsd@realtek.com
Subject: Re: [PATCH net-next v7 3/4] net: phy: realtek: add support for
 RTL8261C_CG
Message-ID: <2e36dae2-36da-4390-b4a9-6736871715d5@lunn.ch>
References: <20260629064718.1349-1-javen_xu@realsil.com.cn>
 <20260629064718.1349-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629064718.1349-4-javen_xu@realsil.com.cn>

On Mon, Jun 29, 2026 at 02:47:17PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
> 0x001cc898.
> This patch introduces a distinct family of handlers (probe, get_features,
> config_aneg, read_status, config_intr, handle_interrupt).
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
