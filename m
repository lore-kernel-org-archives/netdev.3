Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B2285041;
	Sun, 31 May 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240864; cv=none; b=sH6dQixscCMgrQu/01IiVvqkdetKuevv+2mQqCDRR2ThxJgrCjH6CUH/59LB9yk4GRhMsa7DJIzWzNaoUx9yERaUd7D9Z7K7/p8LLp2VrkooiODgFecAABUJjMsNjGS69LaiMFo8F09p7rBAYtAMPWqEHs0jNAKL0/mJftaCNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240864; c=relaxed/simple;
	bh=OhndFhI3gP/dMr+K6awLqr5oGW2ribS/BsY/r2Ah8KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD5htPAkEen3p9fIijvJfcYKw0/iw47FJC8hBVZCjREcLoAPBL+0CXazzE5Rmh9r9YRfGuYhEag58NHKM+6D4jkfpCsGZueEpTkN2Vbjm+SL2vBidIx2D5ZGOWB3RtDxX/IlzYeaH9SJjiEoHg49rpzSb4ZEYjNbtehTUZF81dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1IsK53pK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1IsK53pK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=anvg7U9xaJ74/ZYkCOiQzomNkqrIwtUtLP+Q8XvFzc8=; b=1IsK53pK4orWyiRJKNTE6On8fx
	XEZof4i1rBK7+gQK3JW1ZaA5iXe9QHeYfnvi4JMoWy3OC6eLHnQgYSqaNKZolNzNDwe2tdHwKpnnf
	PcLplN3BRdJLbioqcIu9Qf7G9JRvRrIqFUxMkeB5GhK6pGUIxrL99tyK412jYHuvym+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wThyB-005N4j-05; Sun, 31 May 2026 17:20:55 +0200
Date: Sun, 31 May 2026 17:20:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 12/14] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <9f9cece5-3755-4c8e-b3a6-e3ad26b5ba70@lunn.ch>
References: <CY8PR02MB92499D69207F6CFA01C196BB83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92499D69207F6CFA01C196BB83162@CY8PR02MB9249.namprd02.prod.outlook.com>

> +static void s2500_self_test(struct net_device *ndev,
> +			    struct ethtool_test *eth_test, u64 *data)
> +{

Please could you move the selftest code into another patch.  Also take
a look at net/core/selftests.c.

      Andrew
