Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A13314D2;
	Fri, 14 Aug 2026 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738321; cv=none; b=Aoxn+zWM20GzrggQcxqy/9pmhwi9NVfTiY/rOIcpzbXRKf/5TAghndImsWXIzKzyt/wI8xGYHs/5T6UpgmEG8SA4PacoWqHEWo2mOAu7bVUyFA9t4luhjHiVFIxCwqrXUS83qVxtU1B6bypVAE4KGo98oiTliyHhyFwHhWN3I3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738321; c=relaxed/simple;
	bh=wnvQzKguxPov0pXd/96m+nYEqJuD3W4fY7K+WrCiZWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkmtSj3aie7+2RXblhAeotqzE42yWtN4Rp6qTIq6mVCbE3cVA4+OXT9OCwASuukMhfC5hwp7B0pBPn2MExMx21Q+Ef5rOMlYcfEuxTnAV7AQK1tr2h67xWn1UwF0T5sJLcHKihnk86rrwzjQuQBLrvByRIFLJpapTWZOEOWpujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i+2V4XGp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i+2V4XGp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PxpdOmXm8nHLvIh8dI4mjC2w14RXShnV3+KF8Fge3dM=; b=i+2V4XGpn7JwTaS+sSwfT1hO2m
	KASgnVVLspqnTMwhNC6I4+UM3fJYo+k92RGuN+fPQwJCOVFgFdBzhIaRAqDuMEDxTGCGmYtx8yIh8
	O1ZIikVQ71Wpvb4IOxiSjpYEeelS8tEOyKDbQYPy54HeOKYa29lml7ZVMHidHtu8Zyh8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuyFw-0002b4-Jp; Fri, 14 Aug 2026 22:11:56 +0200
Date: Fri, 14 Aug 2026 22:11:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Winter <jjx@live.nl>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@rainbow-software.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH net] net: usb: cx82310_eth: bound partial-frame remainder
 by current skb length
Message-ID: <dfa12d31-275f-426f-8cb2-594a823dbd82@lunn.ch>
References: <BESP194MB28324DC870B7DE2E694CCEEEB8DA2@BESP194MB2832.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BESP194MB28324DC870B7DE2E694CCEEEB8DA2@BESP194MB2832.EURP194.PROD.OUTLOOK.COM>

On Fri, Aug 14, 2026 at 09:08:14PM +0200, Jason Winter wrote:
> When a frame straddles two bulk URBs, cx82310_rx_fixup() stores the
> number of bytes still expected in dev->partial_rem and on the next call
> memcpy()s that many bytes from the new skb without checking that the new
> URB actually delivered that much data. A malicious device

So this is somewhat theoretical. Maybe less so than average, since
this is a USB dongle, but still, does it bother people?

Please drop the Fixes: tag and post for net-next.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
