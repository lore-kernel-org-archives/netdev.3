Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920408;
	b=aJw+XLHv1/ffsu5L/WYWGbTd3tQs0jgYOfLYkYDo6Ee1sOJLuqX1cgvocytVPS1UPoZV
	 2IBIFzwnIUG+3cwvBN00IIMFAgEhBJ55Y8y7gDV3zt/H5h7mMJoG3kVIJq6+54Pg31gan
	 jNW9oqjj+E/qOZiiubINqCxPSjRu8SmvkPYDqEb6ivfhjhYm4OOutiPYCXqHQX3xzLhCs
	 DRLs7DZ6NBaGmq9Tp9fXmzQvQ2aQZKxpCRsksIsGlWaGkYY7npoPaGFErauqKeYZL2exH
	 6fm3SFVNrPadjHxCibQPE1BY8s3fvigkzfJYkB1g6hduFlEW2t67f1+4AVh4lsyiPUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920408;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=m9L7knHlh4M2/ofZSgnhHZa00Ugsy13H1Sy6ijjUUes=;
	b=OesngxUE2DHLK/d8sLAtt3B4dBrTl4ZKWCvEDuxS0R09olMTzn3GFbCJztOivhJ/u6s8
	 DWMCAQwWIgeOKpIX5YO2mULZyb4/tQi9BvNg1f0LixmDYMgcz9/K7iCb5s5G74doqhA8N
	 lJdPdZDB1ilJ8y6HrSGJVQ+4OdQ3kHnR1EqtN0yU2U27saKY77JnQNhB9hHLbXwI7IrbD
	 kfoUJhsActPM8EPg6SAs//NlauKe4KnUtOXQwyBb14roE8tMFHPuetVyTBVLERxqxu2Az
	 En+oyBIpS3MFVMXtdxzidCq4gh67AZQatICBluP08ObCLb8aw5rmGoWcA4te3yGWSeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0F2606A31B;
	Thu,  5 Nov 2026 23:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A0F2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id CE9BE92009E; Fri,  6 Nov 2026 00:13:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id CB3A592009C;
	Thu,  5 Nov 2026 23:13:26 +0000 (GMT)
Date: Thu, 5 Nov 2026 23:13:26 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net: sb1250-mac: Add ethtool autonegotiation
 restart support
In-Reply-To: <20261105193435.2050321-4-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.21.2611052111570.6502@angie.orcam.me.uk>
References: <20261105193435.2050321-1-f.fainelli@gmail.com> <20261105193435.2050321-4-f.fainelli@gmail.com>
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

> Wire up the nway_reset callback to phy_ethtool_nway_reset() so that
> ethtool -r can restart PHY autonegotiation. The phylib helper handles
> PHY locking and returns -ENODEV when the interface has no attached PHY.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
