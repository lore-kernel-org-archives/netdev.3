Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B2319859;
	Mon, 27 Apr 2026 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256401; cv=none; b=PjGE1YwPaguVQNTHgyeAk4sWUuiFV0NrDfQsYN2SP48oB9eb8ZQjXLfvTyPETKDD3eGy4khgenIdz2LilIKH6n6k13G5ACMUw9DdHwIC1iYYdBvm3s1L94SB2aEMmXH8tjMaagd0PmX65PmsSMxqfo/ee74sT8GtbtdqbJm68bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256401; c=relaxed/simple;
	bh=ekgyFmTE3uQ4qIU6YOOeQzkNGMU36QMODYbmZGLrsVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqxmYS1gYlEAKQsqbJPMOE4TnyUaOXgIJwJE32D94C3is9Ac00xf8i8ClcjQCNKaqvbjnDRGCwFeCdbavk58LJVEf/p0yq3bWS5EcJtxKUCC2oLztMEBps0blg6b4FW16KHCmvPh4lHiza/1PrAprmuFP0RobubSE3/AYrMF4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s6TbGvW3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s6TbGvW3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AOulUeHP5Ci+n8zBfrYIFWyRHmjtsZNm+1rVDSKrcF8=; b=s6TbGvW35g1K2+R9rEK/v/7aPG
	Dk4vksgNIG+g7arZlNVIEV9tJQ4pOc/AGv1gItxRrQply4Tt8JbNHWh83xQ++6NKHR0cjMst3NDOg
	54WdgfXRmkWkUpVXszjqemgTtRO9NnSyHQ0KerCmUhUxODaEfR7SYJFw4XwU882+7bww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHBZe-0005c5-Td; Mon, 27 Apr 2026 04:19:50 +0200
Date: Mon, 27 Apr 2026 04:19:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM ASP 2.0 ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: bcmasp: handle EPROBE_DEFER for MAC
 retrieval
Message-ID: <0b183711-7e3d-42da-b605-d81c9bf1e730@lunn.ch>
References: <20260425013734.436147-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425013734.436147-1-rosenp@gmail.com>

On Fri, Apr 24, 2026 at 06:37:34PM -0700, Rosen Penev wrote:
> of_get_ethdev_address can return EPROBE_DEFER when using nvmem. To
> handle this, encode the error with ERR_PTR for minimal changes. Adjust
> the only place using bcmasp_interface_create.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c      | 4 ++--
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> index 972474893a6b..31a9560c4aee 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> @@ -1333,10 +1333,10 @@ static int bcmasp_probe(struct platform_device *pdev)
>  	i = 0;
>  	for_each_available_child_of_node_scoped(ports_node, intf_node) {
>  		intf = bcmasp_interface_create(priv, intf_node, i);
> -		if (!intf) {
> +		if (IS_ERR(intf)) {
>  			dev_err(dev, "Cannot create eth interface %d\n", i);

Idealy, this should be changed to dev_err_probe(), so the
EPROBE_DEFFER case does not spam the log.

    Andrew

---
pw-bot: cr
