Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1942848F;
	Thu,  9 Jul 2026 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605026; cv=none; b=fXu0ey+ywKEyrW1fslJ0GdtvIwYyzE/TK2C+ny0nF8rcGGLml/NdBv6uj+uncxPRwKsko1FkwInxSYBgwpM2LTQP8y73hCS/FGd0db6Kq8JgqSy+1Y0Tn01OaQZjDJTpTEa3bjxIC0FmeQjMnGkIL7Dv1b7mTjY97OfummA0GSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605026; c=relaxed/simple;
	bh=xyTvNOaCsBw/CL10SIzB7HEGTW0o9ceXYVHnd5cHUBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzfWhdb/aYR9jaXPlNhERjZDx8u2dOJPF60nBfo6bfJjg2IZAi8/0GMAobKeeJwiuYtaspaH2LuloLScjTQ+pGnyUq7ScTx588jkN+E9nzSQJLvEAbCDJeEsPv5LHCKFWmZAx1hBNK01SvTIMtGHtBQTYV/HDPNac30YZmQrAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rsYXgrIk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rsYXgrIk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6Wcg+ldBwl6wwvVGYpvQMns6Q/59ECPDO4bDoPMkTQA=; b=rsYXgrIklt/SYzerXvsOuBnKnx
	zVCwEz6yM5lwS8UxGX5oxalaY8N4RuMIdsCWayBC+XRVPj17c28AkyWnogelkD6UaQRaVAi8RVBD0
	LMbzgmXE0aTbftPUbVVkul/+y63TLy4pZtSdkq6upQfgi13Fw434iXufPEMDu5QL5M90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whp8r-00BVEG-NC; Thu, 09 Jul 2026 15:50:17 +0200
Date: Thu, 9 Jul 2026 15:50:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Subject: Re: [PATCHv2 net-next 4/7] net: usb: int51x1: drop dependency on
 cdc_ether
Message-ID: <b29a4235-6f6f-4909-820d-93da9b28cb64@lunn.ch>
References: <20260709120116.1423033-1-oneukum@suse.com>
 <20260709120116.1423033-4-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709120116.1423033-4-oneukum@suse.com>

On Thu, Jul 09, 2026 at 02:01:13PM +0200, Oliver Neukum wrote:
> The driver depended on cdc_ether only for usbnet_cdc_update_filter().
> This has been shifted to usbnet. Drop the dependency.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
