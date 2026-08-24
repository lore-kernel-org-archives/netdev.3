Received: from mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F31990A7
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787535254; cv=none; b=tWCiCLTQbPQLd/rHNHK/ubrFbPpdXDg1BJiBpVHKlLn44h3nUbLUYH9S6OBxzC3lZMdfT4k/lWf2Q1EdAT+FEhPRM2EHQPdxlrjyE4pRivbhYpQgPQybjTI/5rQngRnBgki8a5vfKn70jNkvSsZ4fyHnHIg/OFRqBLlyyx1BVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787535254; c=relaxed/simple;
	bh=+No1hTfbrcIhWY5jWR+1vFIfuDqvsIjriS5i2p59EfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhuCt8frWoAT8Y2rnSnmpr4tvkTl94y9uUMUy4nD1GU/akypOKJSbs6JCH0T8Fa+BzyIQuS/4kCd6nHbfX8HxfUeCE1WYtZ314Y7+nGJe7klarEm/eD30rwonteMkhKGYBcqUBhYQRI8vDXKwhZhSNpAgNCpIMqYCpizq0IFkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N4FldY3w; arc=none smtp.client-ip=91.218.175.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N4FldY3w"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+No1hTfbrcIhWY5jWR+1vFIfuDqvsIjriS5i2p59EfE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787535249; v=1; x=1788140049;
 b=N4FldY3wDbtPW/opkwbfWek0ZkClsGELDktY4A8bDMpVsIRUUr1dxj06HUP2k79eK0gTGXBA
 JMB3BKjIJCGn4QQO5o67JEZM8QRTBrbEpJXuwOZDsTSx31OXsPm5E3ezDZ5tV3oRPyMi2sljUNg
 zzCMBjbcASATpmgRZo9yJB4k=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.242)
	by smtp.migadu.com with ESMTPS id 0ab54891e4b8e38a;
	Mon, 24 Aug 2026 01:34:09 +0000
X-Mizu-Trace-ID: 0ab54891e4b8e38a
X-Migadu-Flow: FLOW_OUT
Date: Mon, 24 Aug 2026 09:33:50 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v4 2/2] bonding: fix u32 overflow in compute_gap()
Message-ID: <aouffvAgf9fK-Sfd@fedora>
References: <20260820-bond_overflow-v4-0-805ba0d3efb6@kylinos.cn>
 <20260820-bond_overflow-v4-2-805ba0d3efb6@kylinos.cn>
 <b63cb237-8bc0-4c95-820f-d004433f5577@blackwall.org>
 <aogrnqQ0c077G4-B@fedora>
 <d6c8ec4c-ab28-4d7c-ac26-414b94352c10@blackwall.org>
 <aohLhGviyByk6T1-@fedora>
 <d9b218ed-b7dc-40d3-90a2-24b5cdbe8f73@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9b218ed-b7dc-40d3-90a2-24b5cdbe8f73@blackwall.org>

Hi Nikolay,
On Fri, Aug 21, 2026 at 04:12:31PM +0300, Nikolay Aleksandrov wrote:
> Completely untested, but something like:
> 
> -static u64 compute_gap(struct slave *slave)
> +static s64 compute_gap(struct slave *slave)
>  {
>         u64 slave_load = SLAVE_TLB_INFO(slave).load << 3;
>         u32 raw_speed = READ_ONCE(slave->speed);
>         u64 speed = (u64)raw_speed << 20;
> 
>         if (raw_speed == (u32)SPEED_UNKNOWN)
> -               return 0;
> -
> -       if (speed <= slave_load)
> -               return 0;
> +               return S64_MIN;
> 
> -       return speed - slave_load;
> +       return (s64)speed - (s64)slave_load;
>  }

I get what you mean now. I think this is a boundary‑choice problem.

I reject all unknown‑speed and overloaded NICs, while you believe we should
keep overloaded NICs. What if someone argues we ought to retain unknown‑speed
but non‑overloaded NICs (though I do not see how we could compute that)?

In any case, I am fine with your design. If there are no other objections,
I will resend the patch following your plan.

Thanks
Hangbin

> 
> Then change the selection variables and comparison:
> 
> -       u64 max_gap = 0;
> +       s64 max_gap = S64_MIN;
> 
> ...
> 
> -                       u64 gap = compute_gap(slave);
> +                       s64 gap = compute_gap(slave);
> 
> -                       if (max_gap <= gap) {
> +                       if (!least_loaded || max_gap < gap) {
> 
> This should choose the slave with smallest gap and put the unknown speed behind all
> slaves with known speeds.
