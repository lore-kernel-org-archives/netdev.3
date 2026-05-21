Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB3346A19;
	Thu, 21 May 2026 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386515; cv=none; b=Zquf1UyJ1zVumTlHIvwGe24TFGMXv8/f/c9SD3z47zlNgbejgnDBSCpIF5EFxcHNeNDM+PsCdLfcXZMcCFQhCAkhHH91C5cx16vJ04uisPJdGJsAylqWG8JP4+4SrjHPjSn1faNRJp9qZXvsA76czaY3FkxGGZAQdfuHOCT2Q2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386515; c=relaxed/simple;
	bh=+xbAVLZiOSsjyGKDMEB4SOi95TYgYdHobC/UWsau8Ys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jCyHaq+TH/FFly+DbMhzMjUw9Tg85FenQoRYbuD96kA9tN+WWKpKtoCHUs7/X6FhmMvlFjzn/CJxq2P6wXMA0V+Jp9/sl2537N19L8aUTr0KTdVO3AlUhmFjbHzHT1nhe3ILLzv2eZn96eWYpGbxbmDjii9d/pI7SYQnJAGeQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 92F2192009C; Thu, 21 May 2026 20:01:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8CFF692009B;
	Thu, 21 May 2026 19:01:51 +0100 (BST)
Date: Thu, 21 May 2026 19:01:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make some
 fixes
In-Reply-To: <20260521082827.279e640b@kernel.org>
Message-ID: <alpine.DEB.2.21.2605211855470.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk> <20260521082827.279e640b@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 21 May 2026, Jakub Kicinski wrote:

> >  The remaining patches of the series should be obvious; see the respective 
> > commit descriptions for details.
> 
> FWIW sashiko points out a number of potential issues:
> 
> https://sashiko.dev/#/patchset/alpine.DEB.2.21.2605201115010.1450%40angie.orcam.me.uk

 Thanks for the heads-up, I'll have a look, although it won't happen right 
away.  I may actually be able to verify SMP operation of this stuff even, 
as I've got an SMP box with free ISA slots at my remote lab and a spare 
3c509 board.  We shall see.

  Maciej
