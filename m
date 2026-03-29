Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD33B36214D;
	Sun, 29 Mar 2026 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787570; cv=none; b=XH3nwAo7MF4CWN5in+J8vSFSISwNYrmoPIXQ1FSK2qg3hhQ4H1ol3z4sQ2r5KFBeKNYhzIX+C/zI3d8Bc+nkdkou/3u8yNHTvVal1NetwXjXdFcmtuJD2A2ItlKCQtka4HiTjh2Zj3PPuTOYeidrV7aVW7fxUXiSs8NWIPu/4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787570; c=relaxed/simple;
	bh=KdRpglc4rYbUge1GsbYtBnFLM9nn+7hGXCgcit3Uwjg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=qCZFrmPOrVICQ1DGGywJ2PyjMnb/CSumpitxY+rhZSkh7vh/jtEvQFKQerMgreGF20ZjgeKoFyOZsAHTHwI78MTDsz2hj5VHwrc9a+CUHSeTCCVsHmjZOw4ijsaLEOECM03Vi5NGluY3FzcBTgoRL7aXzZaOG2Ceutbqo//bJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 41EBE92009E; Sun, 29 Mar 2026 14:32:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 3BAF892009B;
	Sun, 29 Mar 2026 13:32:47 +0100 (BST)
Date: Sun, 29 Mar 2026 13:32:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] declance: Improve DMA error reporting
Message-ID: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 Inspired by a recent discussion[1] I have come up with this pair of 
small improvements to DMA error reporting with declance.  Please apply.

References:

[1] Sebastian Andrzej Siewior, "declance: Remove IRQF_ONESHOT",
    <https://lore.kernel.org/r/20260127135334.qUEaYP9G@linutronix.de/>

  Maciej
