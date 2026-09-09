Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8839CD12;
	Wed,  9 Sep 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979389; cv=none; b=S+ApEevb6mp9dAT7LocgCmXj/bAFuByPapaRQOP9jKmyFSDW9RlDBIueQ6Zj4wkWaoanjLo780jdKMcvBFxDGAEbeJUJcunS0iGVrMuveZMHooFPyX56fbJieZ92704wmPbGgpHxqwpFIiTM7VUuFTQ1JNTIpcFGHwCJ54aqULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979389; c=relaxed/simple;
	bh=xD5y7y1l9Mqr/TBbQ7bGejvagY3t+8gWX0MLHWCuMDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5+0FIumfoen2gDFZIhGA/qu1wlx6NfJfmeEkMlffjXjLyg0JO6IQ2ReGPrZcHfdFA8Q7Hd0VaaPuSD/++GvA1tUoqBmfkmgVcTwGxAzhx6Cd/cdZc6M4UtkJodwo5/+m/ugi8/2AMv9et8NnxQngXrbJzzdFAG1nuzgg6ZE+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AuECV7Qv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AuECV7Qv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JSaz+OvzDYSq8/CrBzpIBZ76d3+JBQCuLA+7/pAS+bs=; b=AuECV7Qvr3TOndclz75aWKPKfF
	mRkBjVxcBTt3TwW2HQPK2GKJ3euC7D9GlSpIDO26klwT3TPKgUskVQf5ujiOtYl5BTWI4ig5pU2EQ
	33v3vPeXwOxg8Ss8l2Z9wdCZ/RkgD9iEQoq4kO3FzLnD+fKNIMr3i9Gu9DLo9+RIFzWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4NG2-004MUZ-89; Wed, 09 Sep 2026 20:42:54 +0200
Date: Wed, 9 Sep 2026 20:42:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oliver Neukum <oliver@neukum.org>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Mike Hsieh <Mike_Hsieh@quantatw.com>,
	Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Subject: Re: [PATCH 0/2] net: add USB CDC Ethernet NCSI support and fix
 unregister UAF
Message-ID: <aba31684-fdd8-4ece-bf77-51aea4ac4bcf@lunn.ch>
References: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com>
 <1db2f8a7-6a17-410e-be1a-e9ac0b91e6d3@lunn.ch>
 <CAGfYmwVUg-Tm42WeEAaG8bKrKp1Tv+08vvJVnmwk8+BeQ1j0Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGfYmwVUg-Tm42WeEAaG8bKrKp1Tv+08vvJVnmwk8+BeQ1j0Ww@mail.gmail.com>

> Hi Andrew,
> 
> Thanks for the review. To clarify the architecture, it looks like this:
> 
> [ BMC ] <--(USB)--> [ SMA Controller ] <--(Internal)--> [ Shared NIC (CX9) ]
> 
> 1. The USB Interface: Between the BMC and the shared NIC, there is an
>    SMA controller. This controller emulates a standard USB CDC Ethernet
>    device facing the BMC.
> 
> 2. Passthrough (Bypass): The SMA controller acts as a transparent bridge.
>    It simply passes through both standard network packets and NCSI
>    control packets between the BMC's USB interface and the actual
>    shared NIC.
> 
> 3. PHY Management: Because of this architecture, the actual 3-port switch
>    logic and the physical PHY management are handled entirely by the
>    NIC/SMA hardware firmware on the DPU side.

This is the first time i've seen this sort of setup. You should
explain this in the commit message, because it is probably new to
others as well.

> >From the BMC's perspective, it only sees a point-to-point USB CDC Ethernet
> device. The BMC driver does not have direct access to manage the shared
> PHY's link state.

So why is the SMA controller emulator actually reporting the true link
state? Since it is an emulator, why not just say the link is always
up? And ignore any requests from the BMC to change its state? You then
don't need any quirks in the CDC driver. It seems silly to emulator
something and not actually use the fact it is an emulation to hide
away differences to a real device.

      Andrew
