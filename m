Received: from sender-op-o18.zoho.eu (sender-op-o18.zoho.eu [136.143.169.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847494028FA
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526965; cv=pass; b=eQuxacpnk+KmZwyD7dwN7Z/AP8bBiTN+qYlE70eVZvGnq5b7BtoY0+nj2t7ST8Tk2kvrt6TaxJdmgY4xasxxPD8O7Aasdtp1LzKnrioKuXi/OmWezXRFRpsKC4MapBOJmiPhBVE9ZKcenwlDl8Ls4NEC/SSEMhlMDb+9ZzluTfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526965; c=relaxed/simple;
	bh=op2l1FLGt1TCVPhlrqxM/EWn3MHAHSWjkNZFecV0qN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMmoV7f91ua1L/F+w4mwv5C43uht5ayf+7vz0GCGnwJ2Nn/CcpH4Xo9rVvC7ENo3ZUBmESVLBu0nxg0+h87G7Q2JcmzLm0I+KWYPVEOP7QGRsUBBQl2XmGyWFPj/s6gJvE9h7b1H0h4k5SMHGucl8QnO684avhOegxzcEOX5MlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl; spf=pass smtp.mailfrom=kempniu.pl; dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b=Q6RWkY4N; arc=pass smtp.client-ip=136.143.169.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b="Q6RWkY4N"
ARC-Seal: i=1; a=rsa-sha256; t=1786526014; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KMnyFUeyPMxawtsNHeSJu7alaUKmoRYMKXIzyqsCGsQ2L/s9ENdrZkLxKDXOYikSEUQyibt2K6A+CY6ljNExArQcHpfFMTRcditte9A+2SmUQN/ba9w8C+DXbUa0nOP31OqYzmMLm1hemhrpHqZhR1/5uYFc4GYLlYg9SOAJZEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786526014; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0nmYbD/TbyvKQvUJxO+sF++yI7bidrbQlbWZ84DkjGI=; 
	b=R+BSQETslU143Bs/3z0tH4CdK74PRh37ZXduR2XrPJ9olRTo6MCvc9jY0esAyqw/NX/gZIYH855pxZNeGcBjfaU7lZ+70loV3z4OVcvEb8SmVitAk9QoPS6e6OVWYiOEJ+m2xPAZrU6M5snBoQfpcWDLT7rGaNg3FrQNa77f6RE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=kempniu.pl;
	spf=pass  smtp.mailfrom=kernel@kempniu.pl;
	dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786526014;
	s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=0nmYbD/TbyvKQvUJxO+sF++yI7bidrbQlbWZ84DkjGI=;
	b=Q6RWkY4NqNCma3TGIUhf7zdz/kOy48pz3SGak+RJBWJxpAdkLS/EOUZn41FFI6Bd
	JXI13f6XYECr3hPy3qiXSGum10HQNI+kycnUFjReqDhqvLa0qO7iJg2JQ17d1qRfXDH
	cLBzXCXHz3ZFsj+DSkp5X0iXbuv0J9VYs80Bgr3A=
Received: by mx.zoho.eu with SMTPS id 1786526012586133.65842691258308;
	Wed, 12 Aug 2026 11:13:32 +0200 (CEST)
Date: Wed, 12 Aug 2026 11:13:30 +0200
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: Disable mgmt Ethernet for qca8327
Message-ID: <anw5OvAxKh3pnezZ@larwa.hq.kempniu.pl>
References: <20260810061612.23745-1-kernel@kempniu.pl>
 <cc6d8243-e82b-4f1b-acf4-13ba6a74baaf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc6d8243-e82b-4f1b-acf4-13ba6a74baaf@lunn.ch>
X-ZM-MESSAGEID: 1786525177820015800
X-ZohoMail-Sender: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?=
X-ZM-MESSAGEID: 1786525783322015800
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.11.1.5.2/286.510.57
X-ZohoMailClient: External

Andrew,

First of all, after taking a closer look at this issue and the driver
code, I realized that the approach I went with in the patch stemmed from
my ignorance and that I submitted it too quickly - apologies about that.

> > While the qca8327 switch appears to support in-band mgmt Ethernet,
> > prolonged use of that protocol (e.g. for polling link state) makes the
> > device unstable: within minutes, ports randomly go down and no traffic
> > is forwarded anymore.  The same issues do not occur when MDIO is used
> > exclusively, so ensure mgmt Ethernet is not used on the qca8327.
> 
> Do you have time to narrow down the cause?

Sure, I should be able to spare a few cycles on this in the upcoming
weeks.

> I _think_ in band management is used for a few different
> things. e.g. statistics, as you said, PHY polling etc. Rather than
> turning everything off, could you try just doing PHY polling via MDIO,
> but statistics via ethernet, and do an ethtool -S every so often to
> see if you can trigger the problem.

Ack, I'll try that.

> Could you also check if the management packets are getting lost? Look
> at the results from wait_for_completion_timeout(), is it timing out?

Ack.

> If so, is the retry mechanism working? When i added the Marvell
> equivalent for in-band signalling i got the retry mechanism wrong, but
> never noticed because i was not loosing packets.

Could you please point me at the exact retry mechanism you had in mind,
either the qca8k one or the Marvell equivalent?  I cannot see any in
drivers/net/dsa/qca/qca8k-8xxx.c.  If I'm reading qca8k code correctly,
when wait_for_completion_timeout() fails, its return value is just
bubbled up the call chain.

Thanks,

-- 
Best regards,
Michał Kępień
