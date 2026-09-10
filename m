Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D10479870;
	Thu, 10 Sep 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041502; cv=none; b=KrSgNCatLTy9Iz9Zb9MHxoAU4NmejxUSlcx9w0sT7KeLZzvHVtL58jj3AeRaKrUUSGlqdacAaRSintg1fBDuQUdNG8dtazsYXnL5YuXfdLhTimj7g2fZfrqc6eGL6d5I2FkhyckfuE1AnCHuY9b16rD+Bz6GP8i5CM/YeI7tPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041502; c=relaxed/simple;
	bh=j/bjW2TIWsKODP1pogSe5emK5LwuN8+lFqfm0mS3YmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8fsKEvlyT4g54KqNV4X2hfQr6mj5CjpBTkf0ax4mIbhdsOkLb/6yGHzbRGNp8co/xZ+M0+VA5bcZkhc8NnSBS3QjAcUhHiMKlLJfOLf4rKzX4K1Y2DwrqwUHTl+BprzEGUzw8Zq+IP8DwhBbMFSsGGcqwgSPPZpjk98JTONB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k4TxumxW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k4TxumxW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=A4kiQ5NfZMOzoOeiqxJe61PF4dKEVvxAWz6BI7ncqc4=; b=k4
	TxumxWbUxhbZs395QjwiHAYbtwLxO0/HehoiM8OcALuKQXLxG87fNR79yBn4rgniRZXq2qeL1Qb/Z
	aetO80zHh6zuQiqhL5bHibp60OBvpBi8xfCJiMqMLRweKiLc3BbhlxhbP0+bkuOSvh9S42rR2lrmh
	iEefW//Rfw3oAiM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4dPo-004Ug2-6w; Thu, 10 Sep 2026 13:58:04 +0200
Date: Thu, 10 Sep 2026 13:58:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: David Yang <mmyangfl@gmail.com>, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v6 6/6] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
Message-ID: <1f5b5a50-abcc-440e-88b2-54a4cb8b8092@lunn.ch>
References: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
 <20260908083614.2210505-7-kyle.switch@motor-comm.com>
 <CAAXyoMMLpaD5B4QojC0OKHxOFfPfFGpsS2nxCMT9e=nJeo8beg@mail.gmail.com>
 <0aa20394-2042-4c52-b30b-cdd742d4da65@lunn.ch>
 <5e492c8b-1afa-4af8-8f66-9b50799911e4@motor-comm.com>
 <0ad7cd3b-006f-41a0-9d58-5f6dad9c22e8@lunn.ch>
 <1bd79ceb-4abf-49e3-a441-7c026a89d220@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bd79ceb-4abf-49e3-a441-7c026a89d220@motor-comm.com>

On Thu, Sep 10, 2026 at 11:23:03AM +0800, Kyle Switch wrote:
> 
> On 9/10/26 09:57, Andrew Lunn wrote:
> > > > > No one else, except you, can maintain this stuff. Drop it for now and
> > > > > discuss it later.
> > > > There also appears to be similar magic in the PHY driver. Can this be
> > > > consolidated?
> > > Ans: This part of the initialization is for the switch SerDes, so from my
> > > 
> > > side it may be hard to consolidate.
> > Is it the same IP? Same configuration? Or totally different?
> Ans: They are the same IP, but there are the following differences:

> 2. Another point that I think is difficult to integrate is that the phyID
> 
>     of the switch serdes (defined in USXGMII reg space mii 0x2, 0x3) is
> 
>     inconsistent with the phyID of phy8824 (defined in UTP reg space mii
> 0x2, 0x3),
> 
>     so phy8824 cannot be matched, and therefore two sets of initialization
> 
>    configurations are required.

Having different IDs is good, because they are different, as you
pointed out. But the shared USXGMII part should really be shared.

For the switch you are going to write a PCS driver, which might live
in drivers/net/pcs. You can split that into a library for the usxgmii
and a driver wrapped around it. The PHY driver can also use the
library.

Does the switch have the same horrible paging design? I really hope
that is changed in the next generation of the IP.

     Andrew
