Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02C3DAAA2
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738001; cv=none; b=I0ogP7sntqW11+gMikYK4I1bEbvsaBOwAb6KmpyHiU0GBD7vUpt5BGXGYSNPpKzZfGqkHdDCPU8KpteDdC20FOFqGKYaB5Y5siup3h4bmXp+EISKvWQhkx/MvgDYPOL80NsasxQwtMow3ORI25wR5z6hmqjSrM7OJMtrddltApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738001; c=relaxed/simple;
	bh=mpbFj2r0z/E1QNW8/rhK9v7LbxrzPYqIkUrx1DgaYYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be0tIGC/fpeAPjvrDRIxK1sQBsRwyXarUbLnavW4Jd9kleOABQNrH/CN/SGocfw87SozH2/HdNCDEAjgfvf/ucfhMPPc1M2yiKa4ICSRHIv+E67YE3jsmKwORk669RjychvjEgFkf12bjttJ50vfdziyslcP4QpEbA1kkW0awHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gn7dNpnv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gn7dNpnv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hcrdaci5hS2hw23Uq9BZr1xIhJcfi6AeYKiDrm+tVMw=; b=Gn7dNpnv86WIeujJoHL7gGsnnt
	k8UsiKyE1u6EpSMwB2l/9p869UfBekBwM4oXD5W0j47FqFgxQCSF3xchTaa7gTV4dEgZHs6nDAVby
	2FFxfMTv60GEWg3PmeK+w1b4vvHC4CfK5rRCiAw8FGAM8ZVZCi76djcIyWFesi65n5Q4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuyAi-0002Vc-PL; Fri, 14 Aug 2026 22:06:32 +0200
Date: Fri, 14 Aug 2026 22:06:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: manushprajwal <manushprajwal555@gmail.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ti: netcp_core: fix device_node
 refcount leak in netcp_probe()
Message-ID: <948c88a2-d8ef-420e-a862-10487d9f0d50@lunn.ch>
References: <20260814190453.951-1-manushprajwal555@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814190453.951-1-manushprajwal555@gmail.com>

On Sat, Aug 15, 2026 at 12:34:53AM +0530, manushprajwal wrote:
> From: Manush Prajwal <manushprajwal555@gmail.com>
> 
> When netcp_create_interface() failed for a given child node,
> netcp_probe() jumped to probe_quit_interface, which released the
> "interfaces" parent node but never the "child" node that the
> for_each_available_child_of_node() loop was iterating on.
> 
> Rework the loop around for_each_available_child_of_node_scoped()
> instead of adding a manual of_node_put(). child is only read inside
> the loop body and is never used after it, so the scoped macro's
> automatic cleanup on the goto is sufficient on its own.
> 
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
> ---
> v2: Rework using for_each_available_child_of_node_scoped() instead of
>     a manual of_node_put(), per Andrew Lunn's review.
> 
>  drivers/net/ethernet/ti/netcp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
> index eb8fc2ed05..a888aa35fa 100644
> --- a/drivers/net/ethernet/ti/netcp_core.c
> +++ b/drivers/net/ethernet/ti/netcp_core.c
> @@ -2204,7 +2204,7 @@ static int netcp_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node = pdev->dev.of_node;
>  	struct netcp_intf *netcp_intf, *netcp_tmp;
> -	struct device_node *child, *interfaces;
> +	struct device_node *interfaces;
>  	struct netcp_device *netcp_device;

Reverse Christmas Tree

Please also read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
