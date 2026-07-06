Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F32381E94;
	Mon,  6 Jul 2026 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351419; cv=none; b=AFPKwp3la4gdkTnNYDISLWd5i0PEBzwkuXTE0uPMTCAJhdU1rcU5zHsN0xKF+4jgCk/GW4DyY7SsHldHXEtcgupl6O6j2k2+j38Ka0KLsYu6GGcD2LLaCmmiaab78qwnsbAnXBKHH3S9mUdMulPk3NkL+LrajUvoVFV54bwDMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351419; c=relaxed/simple;
	bh=aTEQdYRiers3Kfhih/eYjqt7M+krnpjzeE9hZlJGsdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITtDfbmXc2T0xcF19jZuklnsiqydpOnM1Fyidkt/NLxESFJNWFriBiaGipmm1PC/vJxhGFc42aOxFFxBUfcU3hWXC/f7cfEbg4gIbEVs5krNyDM3DO8cjvTD1qsrJ5pARTgwgrrUEQi9gWMs15gazsPra/0TYjpQN3WEtJmYUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kqByXTKS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kqByXTKS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j5YDU06awu/88x1ckbis+drv6y95uQODUXrYr1SJYKc=; b=kqByXTKSNbqG6fye6Sd6os+9BM
	bFQzByWe8YqhbnZ/2+Oj20rty5CAa4nMLsTfceVYb0TLEfJPaPq7OwLZdsyXM28y5U8EM8gEZyzuK
	PRXbgle8/eOSxe59nT6ubcU8ZqZJdZ39sSBXotLVMUAdCliLvmCVZSaIpY7x0Bja337c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wglAF-00B0pn-VT; Mon, 06 Jul 2026 17:23:19 +0200
Date: Mon, 6 Jul 2026 17:23:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: zhangzl2013@126.com
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianheng Peng <pengqh1@chinatelecom.cn>,
	Zhaolong Zhang <zhangzl68@chinatelecom.cn>
Subject: Re: [PATCH] bonding: fix devconf_all NULL dereference when IPv6 is
 disabled
Message-ID: <9e960cc8-d6c8-4f7d-9922-8d0201791ba7@lunn.ch>
References: <20260706084530.447402-1-zhangzl2013@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706084530.447402-1-zhangzl2013@126.com>

On Mon, Jul 06, 2026 at 04:45:30PM +0800, zhangzl2013@126.com wrote:
> From: Zhaolong Zhang <zhangzl68@chinatelecom.cn>
> 
> When booting with the 'ipv6.disable=1' parameter, the devconf_all is
> never initialized because inet6_init() exits before addrconf_init() is
> called which initializes it. bond_send_validate(), however, will still
> call bond_ns_send_all() even ipv6 is indeed disabled. It will lead to
> NULL derefence of net->ipv6.devconf_all in ip6_pol_route().
> 
>  BUG: kernel NULL pointer dereference, address: 000000000000000c
>  [...]
>  Workqueue: bond0 bond_arp_monitor [bonding]
>  RIP: 0010:ip6_pol_route+0x69/0x480
>  [...]
>  Call Trace:
>   <TASK>
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_ip6_pol_route_output+0x10/0x10
>   fib6_rule_lookup+0xfe/0x260
>   ? wakeup_preempt+0x8a/0x90
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   ? sched_balance_rq+0x369/0x810
>   ip6_route_output_flags+0xd7/0x170
>   bond_ns_send_all+0xde/0x280 [bonding]
>   bond_ab_arp_probe+0x296/0x320 [bonding]
>   ? srso_return_thunk+0x5/0x5f
>   bond_activebackup_arp_mon+0xb4/0x2c0 [bonding]
>   process_one_work+0x196/0x370
>   worker_thread+0x1af/0x320
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xe3/0x120
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x199/0x260
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> Fix this by adding ipv6_mod_enabled() condition check in the caller.
> 
> Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
> Signed-off-by: Zhaolong Zhang <zhangzl68@chinatelecom.cn>

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please set the Subject: line correctly.

    Andrew

---
pw-bot: cr
