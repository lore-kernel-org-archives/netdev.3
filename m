Received: from mta1.migadu.com (out-132.mta1.migadu.com [95.215.58.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2F3B636C
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787105411; cv=none; b=hTO/qtlTcc8iznL/f/HU7VAOe84bs04m5kUCu2SKD+iWD5KSsqshckjQk7FYLRoTOQf0gjzN5gXTJ/DbRV4vV4zcckf3Wi7ix3+Xzzzh2PeT3OnzEFQkd9Y2yj6eLDlWyhJeNu+VZ6yGu0uBdHpmInJcTPLCG13UKtNJME314LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787105411; c=relaxed/simple;
	bh=o1LoRlE0YyphJUHG0q2ZhhRJxZbQ/wkpMRa3tSTs/l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFp/qj6PXYnEUJOoOKTlXZCXcH9BK/hPU9zix+cGR2Pj7lxAGnJFV+2/rNokq+mRd6fXtbq/Avj/IHbxgJMCizzv/cDQnRDi4F9vGB1+KUCgwMdX2gkRT6CgVqrYse6dlj8hdB7rHxvKaEuKB6fI01UVQ1hWQmUfk1HsxFO6v3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=An316DI7; arc=none smtp.client-ip=95.215.58.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="An316DI7"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=o1LoRlE0YyphJUHG0q2ZhhRJxZbQ/wkpMRa3tSTs/l8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787105405; v=1; x=1787710205;
 b=An316DI7wppJc2h8XbWJ/mjjDQh00EbSiS1GToetZ7UpRlppHor/EVqlrqrf4R13T11bnK7B
 LPE4W6c4RPu7WqvTx2kz2beKEqycECIEVsiWe6RG1QJgmFCCrpm/8SMUnO6JCZzu7HqRJCcvEu+
 G4fNormIZ7PhV29Wscn5ExS0=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.241)
	by smtp.migadu.com with ESMTPS id f6aa9a1541af4b74;
	Wed, 19 Aug 2026 02:10:04 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 10:09:58 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v3 2/2] bonding: fix u32 overflow in compute_gap()
Message-ID: <aoUQdublxcfZzqzE@fedora>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
 <20260818-bond_overflow-v3-2-e05d4dbc2fd8@kylinos.cn>
 <d75e0db1-e129-4a9f-a103-889827948de1@blackwall.org>
 <80d704a8-aca6-44f8-8933-eb0cf14ecf3b@blackwall.org>
 <bf56ea5d-a0d2-40f9-b8d5-73d8c54ca32b@blackwall.org>
 <aoUP0sLeEhCPxukB@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoUP0sLeEhCPxukB@fedora>

On Wed, Aug 19, 2026 at 10:07:22AM +0800, Hangbin Liu wrote:
> > > > ... this here, as u64_stats_update_begin doesn't provide exclusive access, so writers
> > > > must do that themselves, so you can't be sure what value will end up, the zeroing
> > > > might not work at all and can get overwritten
> > > > 
> > > 
> > > I meant - it doesn't improve on the current situation where it can also happen. :)
> 
> Ah, yes. I forgot this. The reset_unbalanced_load() could be called on any
> CPU, which conflicts with other writers.
> 
> I re-checked the code. unbalanced_load is only called in two situations:
> 1. To rebalance the load in bond_alb_monitor(), which only executes once
>    every 10 seconds.
> 2. !tx_slave in bond_do_alb_xmit(), which is only for multicast/broadcast
>    traffic. This traffic shouldn't be significant.
> 
> So looks using spin_lock here is acceptable. What do you think?

I mean, drop the per-CPU design directly and use spin_lock to protect the data.

Hangbin
