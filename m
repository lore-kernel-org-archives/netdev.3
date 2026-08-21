Received: from mta0.migadu.com (out-112.mta0.migadu.com [91.218.175.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0585447DFA7
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317142; cv=none; b=tEPDQtYZkaaSyqUWjO78GZbtjiL+Tw0+Y/kyx4SOF36hiE7cR/mhspH4pMuvPhZHJk5EWxxnK02xhUaDaggdZy/aVZLMWZ4GHQqYhVDJCQx9tf2txOtzJHpmJROtQ+ztkSWFwbrzqWuX86eDsA48253TqanVd2u/IDCc0KUrqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317142; c=relaxed/simple;
	bh=XSBAtx1grct/NmYgSc99iOucl577ZNb+QXtIoh/UM34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNYOSSt7vkv1myHy2+VnVkOl4p+yrMY7WQ4aGE2/Oi2MlAaK0g+enjYZ07FDMvZEL9TuY33ls+CcGslA+vmuN1ehtnwarRZKxpejreEEu7I+BCN2dkL21zrUPKMaKPvv5g36jOqqLlML22ubccjzED3Ml/WBppBRaq5c6nvF4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cEwrUO5p; arc=none smtp.client-ip=91.218.175.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cEwrUO5p"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XSBAtx1grct/NmYgSc99iOucl577ZNb+QXtIoh/UM34=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787317135; v=1; x=1787921935;
 b=cEwrUO5ph8geC3F0UxRh9j4Bm16C0KF8bOLTJphkMCh56WhXCd6vLpqZfu8l69p6xHAlAuSe
 T3ht7BWLUcok805k470VThDNSlVJju/8V4ZMxqnCjcWSWR4LCvEFvNi+iyAMynMBqst6KrAod9G
 oPqQto3ySC6n9wKryPTV1vSE=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.242)
	by smtp.migadu.com with ESMTPS id f9f482a4485e5deb;
	Fri, 21 Aug 2026 12:58:55 +0000
X-Mizu-Trace-ID: f9f482a4485e5deb
X-Migadu-Flow: FLOW_OUT
Date: Fri, 21 Aug 2026 20:58:44 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v4 2/2] bonding: fix u32 overflow in compute_gap()
Message-ID: <aohLhGviyByk6T1-@fedora>
References: <20260820-bond_overflow-v4-0-805ba0d3efb6@kylinos.cn>
 <20260820-bond_overflow-v4-2-805ba0d3efb6@kylinos.cn>
 <b63cb237-8bc0-4c95-820f-d004433f5577@blackwall.org>
 <aogrnqQ0c077G4-B@fedora>
 <d6c8ec4c-ab28-4d7c-ac26-414b94352c10@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6c8ec4c-ab28-4d7c-ac26-414b94352c10@blackwall.org>

On Fri, Aug 21, 2026 at 02:33:39PM +0300, Nikolay Aleksandrov wrote:
> > > I think Sashiko's review has a point here:
> > > "Does clamping the gap to 0 completely break load balancing when all interfaces
> > > are overloaded?
> > > When all slaves are overloaded, compute_gap() returns 0 for all of them. Since
> > > max_gap is initialized to 0, max_gap <= gap will evaluate to 0 <= 0, which is
> > > true.
> > > This means tlb_get_least_loaded_slave() will continually update least_loaded to
> > > the current slave, ultimately routing all traffic to the last slave in the list
> > > instead of distributing it across the least overloaded interfaces."
> > 
> > Yes, I have thought about this question. Previous code set max_gap LLONG_MIN,
> > so there always has a slave assigned. Now we use u64. If we use (max_gap < gap),
> > there may return NULL pointer.
> > 
> > > 
> > > That is, compute_gap makes multiple different scenarios look the same:
> > >   if speed is unknown           = 0
> > >   if exactly equal capacity     = 0
> > >   if overloaded by *any* amount = 0
> > 
> > Yes, if there is are 2 NICs with 1 Gbps and 10 Gbps, but both shows as
> > unknown. There is no meaning to compare the gaps. Because they use the same
> > speed value (u32)-1 << 20.
> > 
> > If two NICs both overloaded or equal capacity. There is also no mean to select
> > any devices.
> 
> Well that is debatable, to be correct you'd like to choose the NIC that is
> least overloaded, one could be at capacity and the other could be 10Gbps above
> capacity and you can still choose the second with this.
> 
> If you make it a signed comparison then you can choose the least loaded, you'd

Oh, do you want to fallback to use s64 (long long) in compute_gap? Then
all the counters need to using s64. The same with unbalanced_load, and we
can't using the "delta" anymore. Do we need to change back to using spin_lock
to protect the unbalanced_load writing.

> have to mark unknown speed with S64_MIN but it will compute the correct numbers

Here do you mean
	if (raw_speed == (u32)SPEED_UNKNOWN)
		s64 speed = S64_MIN

? Then the 's64 gap = speed - load' will overflow, which means a 1Gbps NIC
(shown as unknown) will have more gaps then 10Gbps NIC (correctly shown speed)

> and you can choose the least overloaded NIC, which the current code actually
> does correctly.
> 
> And most importantly - you definitely want to differentiate between unknown speed
> and overload, these should not be the same.

If we use s64 and all slaves are overloaded, we can compute the difference.
But once there is an unknown speed NIC, we lose visibility into the real difference.
Such a NIC could be 1G, 10G, or 100G, yet we set its speed to `(u32)-1`.

That is why I believe comparing gaps for NICs with unknown speed is meaningless.

Regarding overload scenarios: do you think this is a common‑case situation?
Because in practice, we rarely hit the theoretical maximum link speed.
For example, a 10Gbps NIC typically peaks at around ~950 Mbps.

Thanks
Hangbin
