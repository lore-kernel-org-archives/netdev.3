Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E040D574;
	Tue, 30 Jun 2026 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859377; cv=none; b=qM77HRUBQpoKm83jHKnM3w5DlThJtxb3RkLgywyCjSHoKq5Nluh9UCc4l3KrvLuRZkHUv1fZYjMahay6Vw5u6I+FgbYZ11vwyWEoPllYQuUv6vOoGin/9PpiMJG5eyxHQMigePFYWG7JHxn9VjEQZ75Eksc7kATApeSv+wslYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859377; c=relaxed/simple;
	bh=luNVmqhdNWNPyAJ0G9onacvp8OC3uiAo1Jp3h3h/H7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oA7pu7kivJd8JJcJeGxrO8iugGiUdvaDbruJdwcaNvBw+cPbZmtjrCtujNNQP3AVYxbDKYCN+lFxOsqzoaLBHfFp3Ws/XWJSMzZfvKUUumAoLrvO55u1v9jzxE2mlk5J3Zohgn0A82Jfffo4C2cwYevI6GLNFMBr1laSDFvJZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiGzyGF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiGzyGF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10471F000E9;
	Tue, 30 Jun 2026 22:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782859376;
	bh=kGD5WRMQdZ0R+3egv71JkQENkPVVjj9qHKXmH1pqyNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QiGzyGF6P7Iuj+S3oUqZ8t96qYBQszc+u7XoKV1SPrGYJG73TtkADOMrh7VfonEpT
	 KgCYhOUEUjIeSm7r5IzOcxZKnFe+zzdPqzcY7aaBU4NwV1lWkMZGX3NH5S4ndXDsq2
	 yaFLhDtlc+ZhQ6t7Ibha5528oMpD/bsvtRWc6uQ7iwvnuqPt+6S2NkDNxJ/g9VTFkZ
	 LypyibTSbTu0nEb53RpRH4YqReCXtqtklKyC8TVwMjcUToJl1HRU2upqIm+LHxYTkW
	 6zC3tSz30EKthKaIUx+BT1YmMmUnmb9vY7h+8jApw/e81R+1KFtLPvbAOOFfJ6+Nb6
	 qHmUICs7XUcQw==
Date: Tue, 30 Jun 2026 15:42:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Tianchu Chen" <tianchu.chen@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: usb: cx82310_eth: stop parsing reboot marker as
 packet
Message-ID: <20260630154255.2954c33a@kernel.org>
In-Reply-To: <e87b8ecf4bbcf87635d144508bf35377dd5397b3@linux.dev>
References: <700e16e9523d7f1299b00df75b13a3c66b6e517b@linux.dev>
	<20260629174458.6ebf647d@kernel.org>
	<e87b8ecf4bbcf87635d144508bf35377dd5397b3@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 10:30:53 +0000 Tianchu Chen wrote:
> June 30, 2026 at 8:44 AM, "Jakub Kicinski" <kuba@kernel.org mailto:kuba@kernel.org?to=%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > wrote:
> > On Thu, 25 Jun 2026 15:32:04 +0000 Tianchu Chen wrote:
> > > From: Tianchu Chen <flynnnchen@tencent.com>
> > >  
> > >  Discovered by Atuin - Automated Vulnerability Discovery Engine.
> > >  
> > >  cx82310_rx_fixup() treats an RX length of 0xffff as a device reboot
> > >  marker and schedules work to re-enable ethernet mode, but then continues
> > >  processing the marker as a normal packet length. This is an out-of-bounds
> > >  heap write controlled by the usb device.
> > >   
> > Where? Can you be more specific in the commit message? At a glance 
> > the accesses seem to be bound-checked with skb->len.
> > -- 
> > pw-bot: cr
> >  
> 
> 
> The "len > skb->len" check bounds the source read, but the overflow is on the
> destination buffer.
> 
> The buggy path is:
> 
> 	if (len == 0xffff) {
> 		netdev_info(dev->net, "router was rebooted, re-enabling ethernet mode");
> 		schedule_work(&priv->reenable_work);
> 		/* <- BUG: missing return; 0xffff bypasses the oversized-length reject */
> 	} else if (len > CX82310_MTU) {
> 		netdev_err(dev->net, "RX packet too long: %d B\n", len);
> 		return 0;
> 	}
> 	if (len > skb->len) {
> 		dev->partial_len = skb->len; // skb->len is bounded by the USB transfer size (4K)
> 		dev->partial_rem = len - skb->len;
> 		memcpy((void *)dev->partial_data, skb->data,
> 		       dev->partial_len); /* <- TRIGGER: can copy 4K bytes into 1516-byte partial_data */

If skb->len (== dev->partial_len) is not bound-checked to the size
of dev->partial_data - aren't there more paths that could hit this
overflow? Are you fixing the right thing?

> ...
> ...
> 	}
> 
> For normal oversized lengths, the len > CX82310_MTU branch rejects
> before this copy. But 0xffff is special-cased and falls through. With a
> 4096-byte RX URB, after the 2-byte length header is pulled, skb->len can
> be 4094, while partial_data is allocated as dev->hard_mtu
> (CX82310_MTU + 2, 1516 bytes).
> 
> So the source read is bounded by skb->len; the destination write is not.
> 
> I am happy to send a v2 with this spelled out more clearly in the commit message
> if needed.
> 
> Best regards,
> Tianchu Chen
> 

