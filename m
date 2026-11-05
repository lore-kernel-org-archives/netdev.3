Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920389;
	b=eRzqlsTm6Wduenv4Wo/bVYnr72y03Br9AJ6ygmyzw5fJzJPSJ20ax+DNJjoOtO+rdDCt
	 x6uqwNAmxlbO0/COVznS9vVUdHme515axUhqMDiydiFKPLwz01uVc/gZo9j/J/KK5uQ6S
	 CjpQPTu3eEBYMm4tcENPTkXc48AJk2KngrUOU7sZ7ceBTbTSWkot87g3/BzvxzzNzdYcK
	 r59s3AhFeaTXOs1yLbCnIYbqgAy+OJrIyoa2yltPxjS0W5qDuRbfHOoVIDTIWh45d4/oP
	 m1esTwRIvRR1/JWCs0ArtdynWhRh0kMlVS6BNeV5BrEeaznoq5plM5fxy/CtXaWU56w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920389;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=G00XMFjLYaB9VFItG/BBnhmh4XpZNeqXdvOF+bu96pc=;
	b=jHxYkYOPUC4UG1ZUJRJXv5LRo4cwuvc1kTOywl65Vl1npI9xrNxKgS2xfSxnUYuk7so4
	 ja74mn/GMFQZu8K0Gs5mUmNUyNgIGiO/35VtmFRoLRs+ZhS0gVCkgRmCnm1VYYl30l5IT
	 FxQUvayh3nhyscYZ6oLcGHWvlQm0C/SWd644SK10dfr+aUUeoG6Ozx6Y2Wl/hac4Ha+P9
	 D46IDAUhzhAMqgmgs0RTDJNNKo7rop2J1Se1SO8CfdHu3DsULCQ+Xge8/KMzalcndC9z1
	 JD/eJ3LD5XJp4S5vdZXm43HEFwCMZGg0+hsUcs5aRGXZG6gfydvntLXGmBt0HcQc+eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767D9606A31B;
	Thu,  5 Nov 2026 23:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 767D9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 4609192009E; Fri,  6 Nov 2026 00:13:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 3FC0492009C;
	Thu,  5 Nov 2026 23:13:05 +0000 (GMT)
Date: Thu, 5 Nov 2026 23:13:05 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: sb1250-mac: Add ethtool link settings
 support
In-Reply-To: <20261105193435.2050321-2-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.21.2611052107110.6502@angie.orcam.me.uk>
References: <20261105193435.2050321-1-f.fainelli@gmail.com> <20261105193435.2050321-2-f.fainelli@gmail.com>
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

> Use the phylib get_link_ksettings and set_link_ksettings helpers, and
> provide ethtool_op_get_link for carrier reporting. The helpers return
> -ENODEV when the PHY is not attached, as the driver attaches it when
> the interface is opened and disconnects it when the interface is closed.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

(I should probably list myself as a maintainer for all the SB1250 platform 
stuff since I've done most of the updates in the last two decades or so.)

  Maciej
