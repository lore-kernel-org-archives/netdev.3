Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2F288B1;
	Sun, 29 Mar 2026 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807648; cv=none; b=Y4eX2OB08AFADcHuo+GhD5dQ/rCOBEATUf4bT63J/tpf31JxAipE6r0dM5ET1sZZmXPqAwC3H33rXWyr03MrAKCp9xequnut3LgiBms6NdlOt5P+UZTeP9UvVQmJX9JfS7aDKZDsysgKwo3Hz9/Y+06C8hqtISKgn2nb2g9l2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807648; c=relaxed/simple;
	bh=snyxFHIFoAzNkBHuCvSI8VBoNUXqNfnWI6qNvOvG09g=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=JcoYny0gfBYsRiHZj0OmKWvbO3SeujL2cDyj5Dg+n8YErVFEILI1Txv7wih5ck3vL3dMNzRnLr5m1rvwBy7vj27XWs2mrXED5nBIL0I+DNI8XU2bas6w63MJd+PsVsX19kUGkENEAg3zwg24QlShLQ8nNJZE9v3LaF+CDJFT8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7E14892009C; Sun, 29 Mar 2026 20:07:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7792392009B;
	Sun, 29 Mar 2026 19:07:18 +0100 (BST)
Date: Sun, 29 Mar 2026 19:07:18 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] declance: Improve DMA error reporting
Message-ID: <alpine.DEB.2.21.2603291835550.60268@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 D'oh, this v2 fixes a silly thinko in the commit description of 2/2.

 Inspired by a recent discussion[1] I have come up with this pair of 
small improvements to DMA error reporting with declance.  Please apply.

References:

[1] Sebastian Andrzej Siewior, "declance: Remove IRQF_ONESHOT",
    <https://lore.kernel.org/r/20260127135334.qUEaYP9G@linutronix.de/>

  Maciej
