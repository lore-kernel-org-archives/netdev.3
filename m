Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82613955EC;
	Fri,  4 Sep 2026 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526226; cv=none; b=hQl2y+9IClxw+a+2ft7lOi9SypPOX1pITACM3ZxZXOQajncjsTsKssR/MXf2RP0TXHvn+tT52AX1nZUxUWIk0Nzf/A0yfRoOr+4E9ICT1T8DNSVA5lj0Vuw9xWocaBVoL5Chd3CuTuRP5Z/QhU5CMjaKxvFS0wDm3nCs559OM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526226; c=relaxed/simple;
	bh=G81joPHDQa6zazcKVT6iVyrHBcF3QYziAiZ7676HgoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDSVQw4yQHnpQLRYBgqHC1vw+R7NeoXk4IB+LEioYS4MJVzjtdhgj6KiFfiSVMODsUup0dSTilkw36WyS8lOpbc527Cr8jAMIHWLu3PLGoWRAxGH4gtPYjNTff5ch3iW7dL1U9rwOka5r9QBH2SvAHzGKsaKZ/CpSstAvyvjcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MFJ4ZzOh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MFJ4ZzOh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3yAn3kbsFoIm608A9M/Uf1F3WYIQG3X//USFhPDHvo0=; b=MFJ4ZzOhejmX+088Y3ofbbmioA
	M0QeyMYnafGPTF0VYKpprxs6LJjFslZu3gZysd/rv9sq0DtjgLNGF7rM9KKyM5agoGD8DEzckcCNE
	Nxt8/kx1U5eeBpgRdS41WGaHyQzG0Fxz7g4OWWtW0U2/bmxL+ReA4//Z1VzBkT9zzb3Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2TN7-002yOm-Bw; Fri, 04 Sep 2026 14:50:21 +0200
Date: Fri, 4 Sep 2026 14:50:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mitchell Blank Jr <mitch@sfgoth.com>,
	Chas Williams <3chas3@gmail.com>,
	James Chapman <jchapman@katalix.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>, Felix Fietkau <nbd@nbd.name>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>,
	linux-atm-general@lists.sourceforge.net
Subject: Re: [PATCH net-next] ppp: pass private data to channel callbacks
Message-ID: <d051ed66-255a-4d25-961e-6229aa34f791@lunn.ch>
References: <20260904031153.30304-1-qingfang.deng@linux.dev>
 <927e0f8f-a656-45e4-a937-9de88b783073@kernel.org>
 <a8497c0e-94be-4cf9-ab64-0402c48c3a88@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8497c0e-94be-4cf9-ab64-0402c48c3a88@linux.dev>

On Fri, Sep 04, 2026 at 01:39:49PM +0800, Qingfang Deng wrote:
> On 2026/9/4 11:57, Jiri Slaby wrote:
> > Hi,
> > 
> > On 04. 09. 26, 5:11, Qingfang Deng wrote:
> > > PPP channel callbacks receive struct ppp_channel only to retrieve the
> > > driver's private pointer. Pass that pointer directly instead.
> > 
> > We had type checking at least. What's the purpose of this patch, actually?
> 
> The goal is to unify the two channel structs and make it owned by the
> generic PPP layer.

The commit message is about "Why?". Please add this to the commit
message.


    Andrew

---
pw-bot: cr
