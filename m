Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5534307AF;
	Thu,  9 Jul 2026 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605124; cv=none; b=uGtKSHEbJvV7bl/oIkQXe6Yt2/CthTS3nOP85KVx73bzlPwkvUhosBR058y6kmaIDije3g8shSFEtrXThER8uSiTk/JM4JshmYqTL4yq5D+tF+obF786J+JbC6zx2a+ZQztS+U9y4DqA5AnQCiV6d7RmWi+Wn5ktMiRVT3I+QLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605124; c=relaxed/simple;
	bh=vIP86y/YdGdhqTR/3LfV1pIiY8TvIOPYkdwfsqMbOlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd3MgGMosnWGIn0LadrQhH9OEYKgvwcaDnEVeLdvesUUkip+8ZKoFW14kCjY5s+aJWfwkhi9E2PrX6j/tsgC5C4jt1J74Azkco9lJBBjzLczQ5/nOhsKeq1uBx6Q0wCJaMg0tAnMZ51gV3Y6a2fAKSPa5VVh+iqxWcqa8h8ixdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SrXeO66Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SrXeO66Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=r6VXagpqivlHcQANt0Pntcr59R+0Qn2UapydDdYhYwA=; b=SrXeO66Yvq9ylN4M4latN/eR+f
	7wR9vc13lWg3O75+V5WS/ZQ1WxgG1A3/sZ86zDpBjbArnAOo+F40R5q+AHdva24SN+0I9DP4re5v9
	xuvoBDWlolQY2RsmtaiWcTfCbLg+7RUcmMKqe7XatGZ2b+gog3tBz2DI9xFKby9LSS0U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whpAS-00BVFG-OG; Thu, 09 Jul 2026 15:51:56 +0200
Date: Thu, 9 Jul 2026 15:51:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Subject: Re: [PATCHv2 net-next 5/7] net: usb: move exported symbols from
 cdc_ether to usbnet
Message-ID: <5c65a66f-0a7a-4ad6-b0ae-e68a2fd16184@lunn.ch>
References: <20260709120116.1423033-1-oneukum@suse.com>
 <20260709120116.1423033-5-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709120116.1423033-5-oneukum@suse.com>

On Thu, Jul 09, 2026 at 02:01:14PM +0200, Oliver Neukum wrote:
> Move the rest of the symbols to usbnet, so that the cdc_ether
> driver does not need to be loaded as a library.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
