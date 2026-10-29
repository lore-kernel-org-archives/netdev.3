Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.70.137.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279958;
	b=TEvIPeYIz7a7ji5dChiqrvW8iZEdX0jPyqLpz9T+aOVE950g2sQ9PRufhhYZSu8Cg/ow
	 n/mRFKD2s2wFBs8sHzIPsbt8RCi3wzx1gWlE4aecb8flBU8wL+YuXLzTk4+kmnkxXTRIO
	 OuNrQeOfhDoTGmDfqXvfh9Mx+/daym7pDIyrqeQbkesjqJEAM2l05S03c6yGdRNvNJQYA
	 z3tH5ZXJd7qxh1YUs5zV6P8XBcTfxDjmSJ5974F31AGoJCh2CnqV2YTjD5xRGnoZtqhP6
	 thtGH+v0ke0k0AZPBGj0gLcmpVEUFBds928iP9nDuwjeip1Ow4p7vmTNgyEHCW/yOsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279958;
	h=DMARC-Filter:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UXvEJnKvKqZF/UKJ7kehn91spShPrqv39DmSh8tgJCQ=;
	b=st/5BrPjRxoYWN4XQM0XVc4V9rsvrDBgADL8Q+YWCEqJ2GQCM0gTSO3DS3CB8v7bipao
	 pFKRltYwJg+EV+ydVS99IpK9sLuXH+t+2POCNy9PpX27MOII4RJ8ScTVXbzVjzGQeBRWN
	 umWmJmVE/Wqvws/jDTzcOVnyM155pYRoVzm+BT9ABFw4V7v6LJWDQd6U32W5W2r9bC42n
	 uNeQ8vFXrveDyvfkbHunUaQUFpWvCmfT+rUGn5zlNCCk56IC0AJJHcbWenItladQDbunY
	 0vNJAsHWVwsviPQSutQ32DnHPLbRCesS4n2HoKnUdqe2erP65aFMf49HlyYo2Pjj74g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=techfak.net;
	spf=pass smtp.mailfrom=techfak.net;
	arc=none smtp.remote-ip=129.70.137.15
Received: from smtp.techfak.de (mailout3.TechFak.NET [129.70.137.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA73E606A321
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA73E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techfak.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techfak.net
Date: Thu, 29 Oct 2026 14:19:06 +0100
From: Sascha Frey <sf@techfak.net>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, qotmddnjs@ajou.ac.kr, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com
Subject: Re: [REGRESSION] vxlan: duplicate ICMP replies with nexthop FDB
 entries after 3fa64d86fc64
Message-ID: <20261029131906.GB8406@techfak.de>
References: <20261028142928.GA8406@techfak.de>
 <20261028150824.GA992905@shredder>
 <20261028175710.GA1116088@shredder>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028175710.GA1116088@shredder>

On Wed, Oct 28, 2026 at 07:57:10PM +0200, Ido Schimmel wrote:
> On Wed, Oct 28, 2026 at 05:08:24PM +0200, Ido Schimmel wrote:
> > I believe we need to relax the checks to allow "extern_learn" entries.
> > They are not subject to ageing (vxlan_cleanup() skips them), so they
> > cannot trigger the bug that commit 98fc57d16744 ("vxlan: reject dynamic
> > fdb entries that reference a nexthop id") fixed. Let me do some testing.
> 
> Please test the following fix:
> 
> https://github.com/idosch/linux/commit/8d98fad34ed4ec2b5e0253a68ead7e436ceae6d6.patch

The fix works for me.

Thanks!
