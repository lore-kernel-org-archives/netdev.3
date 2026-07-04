Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43523FC41;
	Sat,  4 Jul 2026 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783175586; cv=none; b=VeoLsN+oMeVxFAXCtf3k1JBNsm6gkUL9/DTZblRgLzCL+cQm1kQo7yyywV5ZrQhMCYtXUtMHnQb+Ah+Tn5qVa9xLMdUhVNMcrh0E8UYfMXLmtkUhesUVlGM9n7bIaFmT6OvFUjGK0MKBWGgse07dIlMST/QaZLt6tKXGZPOYetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783175586; c=relaxed/simple;
	bh=tvI5JOsvpDRmCWWyARj2I37gEvj5kUG9aFrEUSVvt0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sarXB4u7JtLw8unh3qQKVnMsiZMCIj0DOw83XoRGzPklGaAL9xTEaWaCduejQ17xZkx1sKvQxvQLa6XiOxwrVkwtekzsWyD6+EDIIgyznDUDOn4apEbsDsxPHYVl0j1gn+gEbc1NgIoo+3L/TedfZXZfDuASGSMiFnlnxE1fEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wz4MjcxG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wz4MjcxG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yW5k92GuanvOc/spliKd4PBqyruUpvA9bFqK5s+OfrQ=; b=wz4MjcxGnqSVWlQt6GtY3OFLKT
	dQyEOunAkVmFU5Lu+fKu1F6f4hanPmD0woI5fTP0NDsLwVQlY20Ax4y7G8uRxQzQQsYrcdDnb/NDs
	LeVdorUbbOfgLso9QI2ejww+8xgkxNo+8kOk4Jia7PrXY6GWyBqneD1Sj2h34yh1mo7Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wg1QR-00AhhO-B7; Sat, 04 Jul 2026 16:32:59 +0200
Date: Sat, 4 Jul 2026 16:32:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com
Subject: Re: [PATCH 1/1] net: usb: aqc111: fix set_mac_address return value
 for bonding
Message-ID: <7417ea73-879f-4b50-8736-805080c51f49@lunn.ch>
References: <43a0904c-de59-4b40-b186-edd130f6c0cb@lunn.ch>
 <20260703073936.462231-1-hanson.wang@ugreen.com>
 <20260704084258.3513069-1-hanson.wang@ugreen.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704084258.3513069-1-hanson.wang@ugreen.com>

On Sat, Jul 04, 2026 at 04:42:58PM +0800, Hanson Wang wrote:
> Hi Andrew,
> 
> Thanks for the review. You are right that this is not bonding-specific -
> any caller of ndo_set_mac_address() (including netif_set_mac_address()
> and "ip link set address") expects 0 on success and treats any non-zero
> return value as failure.
> 
> I audited all drivers under drivers/net/usb/ that implement a custom
> ndo_set_mac_address callback:
> 
>   aqc111.c        - BUG: returns usb_control_msg byte count (6) [this patch]
>   ax88179_178a.c  - OK: returns 0 after ax_write_cmd()
>   asix_common.c   - OK: returns 0 (async write to hardware)
>   ch397.c         - OK: returns 0
>   dm9601.c        - OK: returns 0 (async write)
>   lan78xx.c       - OK: returns 0
>   mcs7830.c       - OK: returns 0
>   qmi_wwan.c      - OK: returns 0
>   r8152.c/r8157.c - OK: returns 0 on success (via usb_autopm_get_interface)
>   rtl8150.c       - OK: returns 0
>   sr9700.c        - OK: returns 0 (async write)
>   sr9800.c        - OK: returns 0 (async write)

Thanks for reviewing these drivers.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
