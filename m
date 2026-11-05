Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920399;
	b=S1ObAe9wZqmNxg9mOuH3TxlXDs3q0zvbMmnPCc0Muh0xklM3qLKPvr9hYMHfiJjEX0LL
	 aGXOHckmpafk4k3/LFxU2qQ85amyF/7Dfi52j42qd8DKMFdU7yHQH2KI+8ki383jAQnQd
	 idvOLz8zDUylJ4egddaxX4mO22iJG31Amre9ML0D6w1eE60YDhxRGd8ypQPa25DEaM1rK
	 e+SsQRMykIH/x8ZfmegkhyyR6P8+z8OL8TdUK3WmWGLCgUXGOvVt+pkIBPSg1RVLMWS2G
	 CSxBkjifk3AYVxBz3C+PXj+eSDIu/XUK4m7MB4fpYNPISrLBjxFDwf7UednGB2cKUIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920399;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=sXXPocxjf3ddUMpd4Eavavf/5ezd7VgNevUFYFTpMaU=;
	b=peliUmFn8f+KL8nervPhP0HUONn/ZIAXSH/2EwTFJBfK6tlYIE9vp0asDctL+edbqAeo
	 n6b1SNcjsVyMFOLd891sJsS1ZZRrntRKC+Fcqvp2QhSv7/eKv5/l/WjoCoIl0R9G4C3Oi
	 lN6sCzxP3qR8YEiLHNIk6THdWoZitLEQxXleIWwTNFVMunnH8opDuvoPcSN/50WwtmVwQ
	 /mp0JCjzvWnQa3GSETCMA/09ymvqGwTXSrzqXKAXxKCvj5q9z3qWcN1EmIIuleGoZ52lJ
	 pa8vM2G0ur/CdidaPCz1sf9k1XsIKUoPW6dyQ3CC7K6XY1TpEJ3M9+iw1bnOUfQatuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D03606A329;
	Thu,  5 Nov 2026 23:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19D03606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B83649200B3; Fri,  6 Nov 2026 00:13:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B237592009E;
	Thu,  5 Nov 2026 23:13:16 +0000 (GMT)
Date: Thu, 5 Nov 2026 23:13:16 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: sb1250-mac: Advertise and honor RX
 checksum offload
In-Reply-To: <20261105193435.2050321-3-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.21.2611052110340.6502@angie.orcam.me.uk>
References: <20261105193435.2050321-1-f.fainelli@gmail.com> <20261105193435.2050321-3-f.fainelli@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Nov 2026, Florian Fainelli wrote:

> Advertise RX checksum offload in hw_features and enable it by default
> when the existing hardware revision check reports support. Test the
> active feature bit in the receive path before marking a packet as
> CHECKSUM_UNNECESSARY, so disabling RX checksum offload restores software
> verification. Hardware can continue computing checksums while their
> results are ignored.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
