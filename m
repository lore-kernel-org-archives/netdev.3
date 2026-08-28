Received: from mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185A30C171
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787880505; cv=none; b=qkOKLJKOtPJ1QxephD8DIcyiM3gIowsRoYmQ1TBhHDjbopaimtJ+7eyZy4tnPAqQF6feRQ3j7ZHO7gE/01M62LJvI8GBCb+grUHPNYcEr6X9WocnJ38ZwmVilHEN78HEoMWkRR33HWU5+VsG3h9lwdstAyeavwMqt0zLm2l75H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787880505; c=relaxed/simple;
	bh=ju+6gtsA7pTTbXuAoUHSFVHHz1C7YG8+BAOEUMHtmyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+zbpWkoMTHuVMhEoxXijD8cN518ZT/vPl1VSPnRjb9dP4EfGhb36/f707OjQVeIUnbEVPENdIvR9x7q0T4k33XyfLwHcsbw3VwN26QxhAIhxy6iSoP1Tb2WrlpotOhAMLL2XFcy7LScfTvP8Bd7lOZVWjzYxo9iAZDzXBSkE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NQW0PQHu; arc=none smtp.client-ip=91.218.175.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NQW0PQHu"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ju+6gtsA7pTTbXuAoUHSFVHHz1C7YG8+BAOEUMHtmyg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787880500; v=1; x=1788485300;
 b=NQW0PQHuVwhxO2KEGjSspu1e5nMbhIiHyTCpUVYuNHIstVPQ/CEuqLHYxQXbkX0I5Aq2e1fl
 QyTQFOns1FrHy86tG/WJBV6Otk8m/IFDIqtrry4Pq70+YMcGkmpQSHbPz9WXCvDucPcMLoujzFk
 l/80nU1kqYXPLXwp1hV1c4Vw=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4426f3ea3515209d;
	Fri, 28 Aug 2026 01:28:20 +0000
X-Mizu-Trace-ID: 4426f3ea3515209d
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 09:28:12 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v5 2/2] bonding: fix u32 overflow in compute_gap()
Message-ID: <apDkLDjq7atCR97E@fedora>
References: <20260825-bond_overflow-v5-0-7a800de133f1@kylinos.cn>
 <20260825-bond_overflow-v5-2-7a800de133f1@kylinos.cn>
 <d045bf04-be89-41ad-bd0a-b62fe4de8dfe@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d045bf04-be89-41ad-bd0a-b62fe4de8dfe@redhat.com>

On Thu, Aug 27, 2026 at 03:42:23PM +0200, Paolo Abeni wrote:
> > @@ -170,8 +171,14 @@ static void tlb_deinitialize(struct bonding *bond)
> >  
> >  static long long compute_gap(struct slave *slave)
> >  {
> > -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
> > -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
> > +	u32 raw_speed = READ_ONCE(slave->speed);
> > +
> > +	/* It's meaningless to compare gap on unknown speed NIC */
> > +	if (raw_speed == (u32)SPEED_UNKNOWN)
> > +		return LLONG_MIN;
> 
> Sashiko noted the above could entirely disable:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825-bond_overflow-v5-0-7a800de133f1%40kylinos.cn
> 
> I think the v2 code for the above should be fine.

Thanks, it looks like I was over‑thinking this.

I was considering a case with two slaves: one at 1 Gbit/s and another at
10 Gbit/s. Once traffic exceeds 1 Gbit/s, `compute_gap` may still select the
1 Gbit/s slave, which leads to overload.

In any case, this behavior is still better than no balancing at all. I will fix this.

Thanks
Hangbin
