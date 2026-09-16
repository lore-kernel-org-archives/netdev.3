Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF04E4301;
	Wed, 16 Sep 2026 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593312; cv=none; b=KJVo+/aoLG4zQARJn2jl/WT2CEEaDG7nrW77QwusfsbhDZy4zXnWQyUWKhGD+8de7X89YxnCotLMPBsmjPVRE3CggPW3oFqiuAmWpzxrQxv48BswtugIE2Sq92eZx1wbZ6NNBhMTLSIZK2mY1tdy5wtDYJrtDHscBhSs9mTGtsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593312; c=relaxed/simple;
	bh=OyM+ZdokiTzY7j11LQGuGCm5swbny8Cc0eXrzRW0z/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClUnTsmLxHEUPxxYyIV9PXBOIiMsiXdKvGyAW4yGhEgETbihLdlPP1meRb28Ex4nXUZ+7XgNzmIrEKtBm4yRzlmu4LR549btiHOf3mdu+vtNetoK96U6EzqD906eG2Ye6gOowwYD/YkBPATSD0FayNzqfekJdQEygEavRgEmpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ypczfxXQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ypczfxXQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5jT32W4CYr4ePoMb2w/E2RgECnSEZ4gn+H7zgaLjoTY=; b=yp
	czfxXQOBR+vdFN4g16AolySCiGMsLTMp2tzckx7ovt2RY8kk2EK8x2iaPD8nVnLTz7laSI1pBoRKt
	b/tPLibwbJSW1aFAozb3IeL5eAES2Gqm7p/yUPQ51yfHGvOVOEO31oS0kdqBj0WBZwPf5mjTgcI3N
	k9R5ZFproj3g9Tk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6wxg-005YG4-Ac; Wed, 16 Sep 2026 23:14:36 +0200
Date: Wed, 16 Sep 2026 23:14:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] r8169: propagate errors from PHY write
 operations
Message-ID: <4a9c817f-e8b5-455b-8e78-a57cb6bcdaec@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-2-matheus.aalmeida@inf.ufrgs.br>
 <f4e563a9-5c25-4026-853f-5d5d30f5a0d9@lunn.ch>
 <02943cee3bbe56fafe76a98eeb78c682@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02943cee3bbe56fafe76a98eeb78c682@inf.ufrgs.br>

On Wed, Sep 16, 2026 at 06:10:00PM -0300, Matheus Alves de Almeida wrote:
> > Maybe rewrite rtl_loop_wait_low(), _high() and rtl_loop_wait() to use
> > iopoll.h?
> 
> While I don’t think this fits the scope of this series, I’d be willing
> to look into it as a follow-up.

You trimmed too much context.

The nice thing about iopoll.h is that they all return -ETIMEDOUT, or
some other error code on error. So your current patch looking at the
Boolean return value becomes redundant, you just follow the normal
pattern:

       ret = rtl_loop_wait_low();
       if (ret)
       	  return ret;

So i think this is in scope, otherwise you are going to rewrite 90% of
this patch when you do introduce it.

     Andrew
