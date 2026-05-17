Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F5310785;
	Sun, 17 May 2026 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051707; cv=none; b=pCBIlQNWL45Ij8+VNvcw9EWtuJB4Fm/q1k2YYuzI3AJkgbXEXNgo76Gh3yIbqxqQWLj0yc4lcJu0m/dzbeysrqL4PGM6r94IRcUdzP5ZJXMvx+AH8m7KjeuyQkuvmpp04zVSv9tLjAF77W/KGHocwa2Y0/RGgz0aym8U9pwQeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051707; c=relaxed/simple;
	bh=zYOKqXUVsTIdaSzWdZPQYqVTG4D+zpixB2jjPdfr+4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPgpDNpYNGyuWHV2JZ7w4GKZcsGTykR0TuI6T/QrBY2faFQ/ktzg35edyIJ6dSLXPHa63E5xdglm7yvOiMhGLq86POQx1MBKFx6ZMopycvkVBtDNRWPO4h3XPmCKu5444gv011GIdxiKyumBPLKgPhFPceANyDV9yQQ7VGfVR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g7tWDi06; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g7tWDi06"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=kD9WaT7LsOXwx3sJohzw9Q5hbHB01HbTUMrgACPB4m4=; b=g7
	tWDi06DL7X6WwF5Ic3FM2gcis0NemQ0qyT2X5KFcMTBnCPfv91VDS+oKFnCIJLdE2DLwdy/OYZ/t8
	NwXoaZ5fgllxn1fCSjd4xGzQto400LwqjSvMIaZiQxtstxeAbQclCj6+pLw/+vo6YLviooji61FZu
	66RdjU68DHrwC+M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wOicD-003Mvv-Hj; Sun, 17 May 2026 23:01:37 +0200
Date: Sun, 17 May 2026 23:01:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack
 handoff
Message-ID: <ad7c3caf-7947-49c0-ad43-22085f9bb9ef@lunn.ch>
References: <20260517192856.3925-1-rosenp@gmail.com>
 <5ac9f5ca-4706-4617-a5fd-d3e6dd3b254a@lunn.ch>
 <CAKxU2N_SygFAKQuhwnZG7SP7jiRdkmwS_R+VwHap33UUfbQmAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_SygFAKQuhwnZG7SP7jiRdkmwS_R+VwHap33UUfbQmAg@mail.gmail.com>

On Sun, May 17, 2026 at 01:44:40PM -0700, Rosen Penev wrote:
> On Sun, May 17, 2026 at 1:24 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Sun, May 17, 2026 at 12:28:56PM -0700, Rosen Penev wrote:
> > > Collect received skbs on a local list during RX polling and pass the
> > > completed batch to netif_receive_skb_list(). This lets the networking
> > > stack process packets from a poll cycle in bulk instead of handing each
> > > skb up individually.
> >
> > So my first through was, why is the core not doing this? The core NAPI
> > poll code can initialise the list. netif_receive_skb() withing the
> > driver poll would see there is a list and append to it. And when the
> > poll finished the NAPI core would pass the list up the stack? Maybe
> > this already exists and this driver is just using the wrong API?
> I do not know. I know several drivers are already using
> netif_receive_skb_list, some even which support hardware checksumming.
> See 0a25d92c6f4facaf2852f1aac4cebfe01dd57a91
> 
> The core seems to use netif_receive_skb_list_internal. I do not know
> the details.
> 
> Anyway, the performance difference is real.

I'm not disagreeing with that. But can a similar performance
difference be made for all drivers by doing this is the core?

That is the interesting question.

     Andrew
