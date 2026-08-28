Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56402339382
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922625; cv=none; b=GbZZOULzi9DhYC8aBO2jUxnVvWfX9gs+I84noqt9/VE8jfoZw8UTnX3sKTcZzfK9Vu5iVE5Uyr8JW4fgQWMpgmPHIB0h12RjaErEVo8vl6Ek/QebjUlSJ7WfgHDSoXoiztQk+Euw4J0N1552g7a8ASbJc8GjqzYWk5+HTN6TC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922625; c=relaxed/simple;
	bh=/eRqEKr8BlTyhendci50QDMK0j4QDp2Qh6uK8/pb1Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBQ0ze8GbuntSGRo7k44326enc588PAxSTGOrmS5xqIMFbGJ5rEV5Kt63OwKGIU8eSPxHYv1M2B+SoWwroZBG3EiV5FQuSkiztgWAXqvmUc8Q1kIJZpE8JDTkHsDZfiK/HHDzYu4O1ksZ+vu6rH+Mhr/d+Vm/5Fe+mwB4uv2e+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5Ah1RtwK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5Ah1RtwK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ciWd6etVDkdAQlVVu4SiJZ9mWM6ih1hN5sdcKd9/l9A=; b=5Ah1RtwK6XRRqDnOpJRSVAoa5a
	HQW9qngfZz0EYymDPxPmpAKkhHCH2kvXP+nPOc2pIPHMkFTCvHxMDaKo7ejpQVesGE0m2Cg/i3OfO
	QGRBtyVdKy/IIYt1C5mSEniA6se8HrB8AeIjeHtSz0D37d4BNElhl6PWmWZ+HuQcNKWw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzwLY-001oed-SF; Fri, 28 Aug 2026 15:10:16 +0200
Date: Fri, 28 Aug 2026 15:10:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ti: netcp_core: use
 for_each_available_child_of_node_scoped() in netcp_probe()
Message-ID: <2be39105-f434-442f-88f9-cc676e1c30ee@lunn.ch>
References: <6a914d3c.018c0331.f1305.be74@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a914d3c.018c0331.f1305.be74@mx.google.com>

On Fri, Aug 28, 2026 at 02:26:27PM +0530, Manush Prajwal wrote:
> Rework the interfaces loop in netcp_probe() around
> for_each_available_child_of_node_scoped() instead of adding a manual
> of_node_put(child) at the probe_quit_interface error label, so the
> reference on the current child node is released automatically on
> every exit path from the loop, including the early goto on a
> netcp_create_interface() failure. child is never used outside the
> loop, so the now-unused outer child declaration is dropped along
> with it; no extra of_node_get() is needed.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
> ---
> v2: Rework around for_each_available_child_of_node_scoped() instead
>     of the manual of_node_put(child) from v1, per Andrew Lunn's
>     review.
> ---
>  drivers/net/ethernet/ti/netcp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
> index eb8fc2e..fbc011f 100644
> --- a/drivers/net/ethernet/ti/netcp_core.c
> +++ b/drivers/net/ethernet/ti/netcp_core.c
> @@ -2204,7 +2204,7 @@ static int netcp_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node = pdev->dev.of_node;
>  	struct netcp_intf *netcp_intf, *netcp_tmp;
> -	struct device_node *child, *interfaces;
> +	struct device_node *interfaces;
>  	struct netcp_device *netcp_device;
>  	struct device *dev = &pdev->dev;
>  	struct netcp_module *module;

Reverse Christmas tree. You need to keep these sorted, long first,
shortest last.

	Andrew
