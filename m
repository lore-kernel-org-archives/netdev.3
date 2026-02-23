Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76343502BA;
	Mon, 23 Feb 2026 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888348; cv=none; b=Ea6sebHm545j54w2si6NdY4vHX9yUZR8IGCzpVaaurLr+yNsgWoEaerHYCa/UTZh40/l3WpGZcb3E+vFdydku3KJulJ62vb24+uwpCrmU/8G+H8s2bVAKG9XF9zzc6VkQ2nNodqeoydPi6T0hWY4jXo+jZjZzr/bdqYFeLFAdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888348; c=relaxed/simple;
	bh=pnvJv1+/1g6KH6AlmPTZRGIvK0vkhCQ0O1avFyhYKUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTmO/075GEoo1BOiXbWBZI5OaqJeK7KCghIIF2YNgas3klGqL2RA1Vn97E+NGm3Jq8pb1GSU2jcuXr1ggt0E8WjTwLg2XyrpvF7VBkVbTHjPHLrPbElm+GiUBH7NihX4N1AFlWjQl5QwiLK+hEgZPPcMVejjhP6F6LRjZX/Drk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vuf61-000000000yO-0Opd;
	Mon, 23 Feb 2026 23:12:09 +0000
Date: Mon, 23 Feb 2026 23:12:04 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Bart Van Assche <bart.vanassche@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 23/62] net: phy: mxl-86110: Fix locking in an error path
Message-ID: <aZzexPsIeNh5yVdG@makrotopia.org>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
 <20260223220102.2158611-24-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223220102.2158611-24-bart.vanassche@linux.dev>

On Mon, Feb 23, 2026 at 02:00:23PM -0800, Bart Van Assche wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> Only call phy_unlock_mdio_bus() if phy_lock_mdio_bus() has been called
> first. This has been detected by the Clang thread-safety analyzer.
> 
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Xu Liang <lxu@maxlinear.com>
> Cc: netdev@vger.kernel.org
> Fixes: 3d1b3f4ffc0a ("net: phy: mxl-86110: add basic support for MxL86111 PHY")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/phy/mxl-86110.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
> index 42a5fe3f115f..d010b023f7b9 100644
> --- a/drivers/net/phy/mxl-86110.c
> +++ b/drivers/net/phy/mxl-86110.c
> @@ -891,7 +891,7 @@ static int mxl86111_config_inband(struct phy_device *phydev, unsigned int modes)
>  			       MII_BMCR, BMCR_ANENABLE,
>  			       (modes == LINK_INBAND_DISABLE) ? 0 : BMCR_ANENABLE);
>  	if (ret < 0)
> -		goto out;
> +		return ret;
>  
>  	phy_lock_mdio_bus(phydev);
>  
