Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B66376A0C
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308980; cv=none; b=nzjX4328ir2DWVnp//JaKa1YIEgYC5moGobTicGHKrKnc4p08Rnipkm8R66++89U8jlLjHzXFQsMGMLaVfl6AJRvd6LXONpBxyOEDN2TH/ofx1CowMguk7sLQOGLkvuysuHWu2z5/t0PHHnuGfcah2oFIkYGDQRM+wEdtoW2bPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308980; c=relaxed/simple;
	bh=HIJtjC+DGHEiaopHeYxaIrtkuNdtQ2BjdMUGtvCpRkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6wWCtQ0JBf0oEpA8sfFGKdGW01jysp7bZQDPgeMPl8i9Q8ht6kQKRsYxTGmhY+Xzr7BBJrSN4Iso29Em8uK8Fzol+aDLJavpWedYnQpxey/rQCyqPrzvSzY38luINM2jCRTG4hXcQbdOBTIakBpM67jPl6Qm5cFeadYji/avvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kje/0qFb; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kje/0qFb"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HIJtjC+DGHEiaopHeYxaIrtkuNdtQ2BjdMUGtvCpRkE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787308965; v=1; x=1787913765;
 b=kje/0qFbqzz4ZquQJQn5qq22kNUSoioRSzy3kY6iqWxaWXAi6pJFDHxKIyFa06GksWRkK7H7
 PRN4MOLdrKjRvAxtpT3DOz7cXMDNQiPdBL6K4+jHgrLDxDbk9FOggvKoh8VqQyx4uTgGdQRooQh
 fH+MN0HuayXrq+xH0ffOYf5g=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.241)
	by smtp.migadu.com with ESMTPS id 2a6fe22ca90daeed;
	Fri, 21 Aug 2026 10:42:45 +0000
X-Mizu-Trace-ID: 2a6fe22ca90daeed
X-Migadu-Flow: FLOW_OUT
Date: Fri, 21 Aug 2026 18:42:38 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v4 2/2] bonding: fix u32 overflow in compute_gap()
Message-ID: <aogrnqQ0c077G4-B@fedora>
References: <20260820-bond_overflow-v4-0-805ba0d3efb6@kylinos.cn>
 <20260820-bond_overflow-v4-2-805ba0d3efb6@kylinos.cn>
 <b63cb237-8bc0-4c95-820f-d004433f5577@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b63cb237-8bc0-4c95-820f-d004433f5577@blackwall.org>

Hi Nikolay,
On Fri, Aug 21, 2026 at 01:16:20PM +0300, Nikolay Aleksandrov wrote:
> > -static long long compute_gap(struct slave *slave)
> > +static u64 compute_gap(struct slave *slave)
> >   {
> > -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
> > -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
> > +	u64 slave_load = SLAVE_TLB_INFO(slave).load << 3; /* Bytes to bits */
> > +	u32 raw_speed = READ_ONCE(slave->speed);
> > +	u64 speed = (u64)raw_speed << 20; /* Convert to bits per sec */
> > +
> > +	/* It's meaningless to compare gap on unknown speed NIC */
> > +	if (raw_speed == (u32)SPEED_UNKNOWN)
> > +		return 0;
> > +
> > +	/* Skip slave which is over loaded */
> > +	if (speed <= slave_load)
> > +		return 0;
> > +
> > +	return speed - slave_load;
> >   }
> >   static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
> >   {
> >   	struct slave *slave, *least_loaded;
> >   	struct list_head *iter;
> > -	long long max_gap;
> > +	u64 max_gap = 0;
> >   	least_loaded = NULL;
> > -	max_gap = LLONG_MIN;
> >   	/* Find the slave with the largest gap */
> >   	bond_for_each_slave_rcu(bond, slave, iter) {
> >   		if (bond_slave_can_tx(slave)) {
> > -			long long gap = compute_gap(slave);
> > +			u64 gap = compute_gap(slave);
> > -			if (max_gap < gap) {
> > +			/* Make sure we have one available slave */
> > +			if (max_gap <= gap) {
> >   				least_loaded = slave;
> >   				max_gap = gap;
> 
> I think Sashiko's review has a point here:
> "Does clamping the gap to 0 completely break load balancing when all interfaces
> are overloaded?
> When all slaves are overloaded, compute_gap() returns 0 for all of them. Since
> max_gap is initialized to 0, max_gap <= gap will evaluate to 0 <= 0, which is
> true.
> This means tlb_get_least_loaded_slave() will continually update least_loaded to
> the current slave, ultimately routing all traffic to the last slave in the list
> instead of distributing it across the least overloaded interfaces."

Yes, I have thought about this question. Previous code set max_gap LLONG_MIN,
so there always has a slave assigned. Now we use u64. If we use (max_gap < gap),
there may return NULL pointer.

> 
> That is, compute_gap makes multiple different scenarios look the same:
>  if speed is unknown           = 0
>  if exactly equal capacity     = 0
>  if overloaded by *any* amount = 0

Yes, if there is are 2 NICs with 1 Gbps and 10 Gbps, but both shows as
unknown. There is no meaning to compare the gaps. Because they use the same
speed value (u32)-1 << 20.

If two NICs both overloaded or equal capacity. There is also no mean to select
any devices.

> 
> So Sashiko's comment seems correct, it doesn't matter if a slave is overloaded
> with 1 gbps or 100, they will look the same.

I've thought like:

  if (speed over load)
  	return 1;
  if (speed unknown)
  	return 2;

That sounds reasonable: we could select an unknown‑speed NIC that is not
overloaded. However, this does not work.

When performing the `speed <= slave_load` check, the speed value has already
been shifted. Unknown speed is converted to a very large value, so the
calculation will never report an overload condition — even though the actual
hardware may already be overloaded.

This is why I end up returning 0 for all such cases. Hope my explanation
is clear.

Thanks
Hangbin
