Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80437363C63;
	Fri, 14 Aug 2026 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737950; cv=none; b=IItBHUzjJFYBciWgiqBK8WYCfh2t47OPCm7dIuk+9Pl21lt65xVsouumpF1ghEKoiQf3PEjX9I1LdJsIEVhekJeFRXuu9oMSDJJDWjg8t8RH79zlBtVh6+G9xHze6kNtb4mizxBLOUZ3IgMPhpURBYRyLTrrGI8Ar+EfwOq8VVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737950; c=relaxed/simple;
	bh=DfRmGwwhWA+PDT9H2T5WgzBgB2msEY0/Noq1YWZ8rY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNGiSMQB3Z72kHvmAxhMt5myoSwqCrnRelgmr6F0RI/zQ6Jc/cDnxVJ81GLwD1HrVkex+7YGiR1POu5u+sCpnKpLIT3ruabGYUhSd7oXbfC0/D493KjTEJIE+rrahHeFWiEerAoJGGqsTwE8R6dL5/LQNTGA9MKlRkR0g3RPswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pxW+mPWd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pxW+mPWd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R0Z7G9sdQmKFAKT8myKnZjHkurnu+Xzu3iiP/oFOmb4=; b=pxW+mPWdxyEONJEWwQgJUDpdt4
	UvWMOe4XgtGTGp5dCJcn/nnRzrkaT8g0/9yd4vYcLBvrid4r6q0U8WkJ4B96JOmbNwoQMbmT1hwcD
	ETkYWQf3fvzUWWsAEWmXjIKApphiJ0LAVGDcdnOn35/M44LVUCZ037QfM0lRDuiGFI+c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuy9n-0002U8-BV; Fri, 14 Aug 2026 22:05:35 +0200
Date: Fri, 14 Aug 2026 22:05:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: manushprajwal <manushprajwal555@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Message-ID: <bf97ed42-5a1c-4c90-93dc-808f43b4be06@lunn.ch>
References: <20260814190423.933-1-manushprajwal555@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814190423.933-1-manushprajwal555@gmail.com>

On Sat, Aug 15, 2026 at 12:34:23AM +0530, manushprajwal wrote:
> From: Manush Prajwal <manushprajwal555@gmail.com>
> 
> On an of_property_read_u32() failure, rswitch_get_port_node() set port
> to NULL and jumped to the out label before releasing the reference the
> for_each_available_child_of_node() iterator was holding on it. Once
> port was overwritten with NULL, that reference could never be
> released since out: only put "ports", the parent node.
> 
> Rework the function around for_each_available_child_of_node_scoped()
> instead of adding a manual of_node_put(), so the iterator's reference
> is dropped automatically on every exit path. Since port is the
> function's return value, take an explicit reference with of_node_get()
> on the match before breaking out of the loop.
> 
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
> ---
> v2: Rework using for_each_available_child_of_node_scoped() instead of
>     a manual of_node_put(), per Andrew Lunn's review.
> 
>  drivers/net/ethernet/renesas/rswitch_main.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
> index 6fe9648163..ffdc42f430 100644
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> @@ -1303,8 +1303,8 @@
>  /* Call of_node_put(port) after done */
>  static struct device_node *rswitch_get_port_node(struct rswitch_device *rdev)
>  {
> -	struct device_node *ports, *port;
> -	int err = 0;
> +	struct device_node *ports;
> +	struct device_node *port = NULL;
>  	u32 index;

Reverse Christmas tree.

    Andrew

---
pw-bot: cr
