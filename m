Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309930;
	b=Dsf0I95WdSFHBoa8Q3LJegOpeYiMFkyprj/wen8xz6ezeZDPM8CsG9WDAcRjwpktpCMo
	 cQaT/bwT/4w2xMOZKf64LUMWMdnq6ws/cDFiuHjL+/Fr1aP8Kshdjs+3r3IBTBhHOs3tA
	 YexNAUMJnKQvpYeDXRqkCJKzz3IEuqYO/fcv81ASKk+UTtrcXxg59XZfjedDx3e1vKXqQ
	 +N+xL1Yv1LxLhLySh4iF2smFk81A9TzBBqWR1cCMSkYfQPufc0/XzZnRyXimy3tF4/ZW8
	 8ubMIzZgToUxOFtdzNbMU8zmKXiXyJn/RE0CrARW3I03YWrSuBOE5ID9AW4qQum3cLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309930;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=CceT9wfX1vncgrV/RpW14a0VXPyngwYFI/tpyYB9VI8=;
	b=g6lKJ8ZDLryE5b+zxoHhMYnBvOLQJzvGo/jAK1aRjGhQRThwPwUEqHLGrEPm5XxuFxKy
	 x1Mryg1c0gXtiaHj28WDHlFkvU76wOKztIXvgKdMAqa4FyBj2UP/RfAQ2WoU08L41MkK9
	 hN18JaRbM/5mitKiTHlAzqvtlWdiM313xvKmiA5sKKCRV1C75JY9o5PZPYKG6k/EFzaor
	 y7z17trSXqEQodLlWUlgUPoYS6MsZVVYxors4fvEIBsyMjD3vccqRcAghW7J6ua2LZJip
	 MbkySmzOjGyitEOa5G9lQtNxhQSFSqSUFLqN+b5Eens8BGizTZPMsTBXZ/NQWFw7pew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=E5uYlpKI;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA471606A32E;
	Tue, 10 Nov 2026 11:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA471606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=E5uYlpKI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CceT9wfX1vncgrV/RpW14a0VXPyngwYFI/tpyYB9VI8=; b=E5uYlpKIS6IA7v3LirY3PfL+wX
	90Gxhwb/2LRBIJ+TMvUu7simix86z7VbHXwnQpHzN1rBn26y1Kcghm8s+E+Rd5gSsflUTYDCq8SEx
	EJGkr5IUhVqLeCysI0Ka1xE3ZR+c5bC5kRADsJHkVVxDawk/VYYZ+SaYDBsnn1PgG5WYkeoIwLUKe
	5GsjEOfI6gulJjo/jOfYDB87pAvm0dX6NtT1pW4oKotRd68s/p047rsWzDQFu4Tm1A4kNPVldVzCT
	d0LqLR32AqcWdqvZVPTHLAtzaC9i9Sc/trAaHe5KjmGU1r30B7T4fXYnjEf/YXmRBJ/MdL3VsVeKu
	BakJpGtA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQjyP-00CMot-0u;
	Tue, 10 Nov 2026 11:25:09 +0000
Date: Tue, 10 Nov 2026 03:25:02 -0800
From: Breno Leitao <leitao@debian.org>
To: netdev-bot+sashiko@kernel.org, gustavold@gmail.com
Cc: gustavold@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, john.ogness@linutronix.de, 
	pmladek@suse.com, samuelcrossley@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] netconsole: register one console per target
Message-ID: <avL-47QDYmOHN9Pv@gmail.com>
References: <20261106-netcons_one_console_per_target-v1-1-c29dacdb9c1f@debian.org>
 <179427493788.994134.10458088525635523245@kernel.org>
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
In-Reply-To: <179427493788.994134.10458088525635523245@kernel.org>
X-Debian-User: leitao

On Tue, Nov 10, 2026 at 01:42:17AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> [Severity: High]
> This isn't a bug introduced by this patch, but this patch now registers
> a console right after this lockless store of STATE_ENABLED. Can the store
> overwrite a deactivation done at the same time by a NETDEV_UNREGISTER?
> 
> By the time we get here, netcons_netpoll_setup() has published np.dev,
> dropped the RTNL and waited for a grace period:
> 
> drivers/net/netconsole.c:netcons_netpoll_setup() {
>     ...
> 	err = __netpoll_setup(np, ndev);
> 	if (err)
> 		goto put;
> 	rtnl_unlock();
>     ...
> 	synchronize_rcu();
>     ...
> }
> 
> The target is on target_list during that window, so this sequence looks
> possible:
> 
> enabled_store()                     NETDEV_UNREGISTER
>   netcons_netpoll_setup()
>     rtnl_unlock()
>     synchronize_rcu()               netconsole_netdev_event()
>                                       nt->state = STATE_DEACTIVATED;
>                                       list_move(..., &target_cleanup_list);
>                                     netconsole_process_cleanups_core()
>                                       netcons_release_dev()
>                                         do_netpoll_cleanup()
>                                           np->dev = NULL
>                                       target back on target_list
>   nt->state = STATE_ENABLED;
>   netconsole_register_console()
> 
> The next netconsole_write() would pass the state check and call
> netif_running() with a NULL dev:
> 
> 	if (nt->state != STATE_ENABLED || !netif_running(nt->np.dev))
> 		return;
> 
> process_resume_target() handles this race with the reg_state re-check
> under the RTNL, but enabled_store() has no such check. Does it need one?

I understand that this one got fixed by Gustavo's commit f94b9640bcf22b
("netconsole: finish enabling the target before releasing RTNL")
