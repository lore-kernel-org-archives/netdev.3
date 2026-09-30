Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2D3C4577
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753744; cv=none; b=XklVO1U3Fi8q4gqkWFFwmeAlueh86Lq2h7wTdPhXpge8TYnWmYqpQZgKAgs+Q7FH3WlDDfASA05fSgeFvBXY+PX7n4rxIfkawP0bgiuAuwf/yThp06zviNO88mHjBxYWNyKq30c1zA07cojWwTB5xj7APaSG6xctzVDlrMEKNx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753744; c=relaxed/simple;
	bh=VWBd5CplSC+1wa20471jJKLYXciPOZAapL6xAGX/9eQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEwNZ6QiAo5P2L5UWxSbnAZK+KDYDC967BKtn7WNKaOvgZJqAJSXZmy+nqE+2fA/I+tF0aG2LstEOoQXhxBY8n4N1cZ/i50gJ7hVMyDo7QwjUbN7iJeLwp71nlFL9JpC49/yXHqmYMCTmOCKF35Wxk8yS54q72fUeWtYQaU/uQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=MiR5MXq1; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="MiR5MXq1"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 792CC20520;
	Wed, 30 Sep 2026 09:35:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uYkw1Dg1JQTF; Wed, 30 Sep 2026 09:35:37 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AC4BA20184;
	Wed, 30 Sep 2026 09:35:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AC4BA20184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1790753737;
	bh=1+5ZQUaub5/QGnJiyEsRA5/K+amkbXuxDLjETtx7lIU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=MiR5MXq1RChJQu4zhdRaNd+3kQMc7Wi0eK9XqUFCDSii0RKeqx5L5UxYCNOZkKlcN
	 XiIWxwSUQwV+rwErNUsc0+2XnpR4KxHan2zT3PMKKR2AtT65mlR/FZDEw4YFtwzUNE
	 2yPco7mcFfjmmyR03GwMITEdy5i1ZX31gT58sS7sluT/vcmeLkN9Apc9EMytwIsUmC
	 5WWVSbNVxAVKBBel/VKQIT1747vdxBd4noo8bYF9KQtS7SKuvskRlDQUjHmNPawiOG
	 /KKZTgox/UdfZ15ryMtak/uXbdoWSvnBEpRRRQd5mZxE9wJDJuosuHjZc9MjoyuTnR
	 Hw1MCa2glAYWg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 09:35:37 +0200
Received: (nullmailer pid 3835312 invoked by uid 1000);
	Wed, 30 Sep 2026 07:35:36 -0000
Date: Wed, 30 Sep 2026 09:35:36 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dawson Kraai <dawson@getanp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [BUG] xfrm6_tunnel: failed module init flushes every XFRM state
 in every netns when IPv6 is disabled
Message-ID: <ary7yDhqYVD9Rpu4@secunet.com>
References: <DS0PR13MB7311F1363647131E596CBECFBC802@DS0PR13MB7311.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS0PR13MB7311F1363647131E596CBECFBC802@DS0PR13MB7311.namprd13.prod.outlook.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Sep 25, 2026 at 05:27:34PM +0000, Dawson Kraai wrote:
> Summary
> -------
> On a kernel booted with ipv6.disable=1, loading xfrm6_tunnel fails (as expected,
> IPv6 is off) - but the failure path deletes ALL IPsec SAs (IPv4 ESP included) in
> EVERY network namespace on the host. The module never loads, so the flush
> repeats on every load attempt. Load attempts are triggered indirectly and
> routinely: any "ip link add ... type xfrm" makes rtnetlink request_module
> "rtnl-link-xfrm" -> xfrm_interface, which depends on xfrm6_tunnel. strongSwan's
> kernel-netlink plugin does exactly that at every daemon start to probe XFRM
> interface support.
> 
> Observed on 6.12.107 (Debian 6.12.107-1). The code path is unchanged in current
> mainline (net/ipv6/xfrm6_tunnel.c as of this report).
> 
> Environment
> -----------
> Kernel:      Linux 6.12.107+deb13-amd64 (Debian linux-image 6.12.107-1), x86_64
> Cmdline:     ... ipv6.disable=1
> Config:      CONFIG_IPV6=y  CONFIG_INET6_XFRM_TUNNEL=m  CONFIG_XFRM_INTERFACE=m
> Workload:    ~60 network namespaces (containers), each running its own IKEv2 daemon
>              (strongSwan 6.0.1) with IPv4 ESP tunnel-mode SAs.
> 
> Symptom
> -------
> Every time any strongSwan daemon started anywhere on the host, all IPsec tunnels in
> all other namespaces went dark within ~1s (kernel SAs gone, SPD policies intact,
> XfrmOutNoStates climbing). Nothing was logged by the kernel. Recovery required each
> IKE daemon to re-establish its CHILD_SAs.
> 
> Root cause (kernel function trace)
> ----------------------------------
> ftrace on __xfrm_state_delete / xfrm_state_flush during one daemon start:
> 
>   modprobe-4042214 [000] ..... 1654071.342931: xfrm_state_flush <-xfrm6_tunnel_net_exit
>    => xfrm_state_flush
>    => xfrm6_tunnel_net_exit          (module text, resolved by address)
>    => ops_exit_list
>    => free_exit_list
>    => unregister_pernet_operations
>    => unregister_pernet_subsys
>    => xfrm6_tunnel_init              (module text, resolved by address)
>    => do_one_initcall
>    => do_init_module
>    => init_module_from_file
>    => idempotent_init_module
>    => __x64_sys_finit_module
> 
>   66 xfrm_state_flush calls (one per netns), 267 __xfrm_state_delete calls,
>   all within 1.08s, all from the modprobe task.
> 
> The sequence in xfrm6_tunnel_init():
> 
>     rv = register_pernet_subsys(&xfrm6_tunnel_net_ops);      /* succeeds */
>     if (rv < 0) goto out_pernet;
>     rv = xfrm_register_type(&xfrm6_tunnel_type, AF_INET6);   /* fails */
>     if (rv < 0) goto out_type;
>     ...
>   out_type:
>     unregister_pernet_subsys(&xfrm6_tunnel_net_ops);
> 
> With ipv6.disable=1, inet6_init() returns before xfrm6_init(), so no AF_INET6
> xfrm_state_afinfo is registered and xfrm_register_type() returns -EAFNOSUPPORT
> (xfrm_state_get_afinfo(AF_INET6) == NULL). The init then unregisters the pernet
> subsystem it had just registered, which runs the exit op for every existing netns:
> 
>   static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
>   {
>         ...
>         xfrm_state_flush(net, 0, false);
>         xfrm_flush_gc();
>         ...
>   }
> 
> xfrm_state_flush(net, 0 /* IPSEC_PROTO_ANY */, ...) removes every SA of the
> namespace, regardless of protocol, family or type - including IPv4 ESP SAs that
> have nothing to do with xfrm6_tunnel. Run for every netns from the init-failure
> path, this is a host-wide IPsec wipe as a side effect of a module that never loaded.
> 
> (The flush in xfrm6_tunnel_net_exit was added to avoid a panic when unloading the
> module with SAs still referencing it. That is reasonable for a module that was
> loaded; it is not for the init-failure path, where the module owned no SA.)
> 
> Reproducer
> ----------
> Boot with ipv6.disable=1, xfrm6_tunnel not loaded. Then:
> 
>   # any SA in any netns, e.g. in init_net:
>   ip xfrm state add src 192.0.2.1 dst 192.0.2.2 proto esp spi 0x1000 reqid 1 \
>         mode tunnel enc 'cbc(aes)' 0x<32 hex bytes> auth-trunc 'hmac(sha256)' 0x<32 hex bytes> 128
>   ip xfrm state | grep -c spi        # 1
>   modprobe xfrm6_tunnel              # fails (EAFNOSUPPORT expected)
>   ip xfrm state | grep -c spi        # 0  <- unrelated IPv4 SA is gone
> 
>   # or, without root in the init netns: create an xfrm link from an
>   # unprivileged user+net namespace; rtnl_newlink() auto-loads rtnl-link-xfrm,
>   # which pulls in xfrm6_tunnel:
>   unshare -Urn sh -c 'ip link add x0 type xfrm dev lo if_id 1'
> 
> Note: the stand-alone steps above are the distilled form of what we traced in
> production (strongSwan's XFRM-interface probe as the load trigger); I have not
> re-run them on a scratch machine.
> 
> Impact
> ------
> - Any host that runs IPsec with ipv6.disable=1 loses all SAs whenever anything
>   requests xfrm_interface or xfrm6_tunnel. With IKE daemons in containers this
>   happens on every container start; we saw it several times a day for weeks.
> - Because rtnl_newlink() calls request_module() for unknown link kinds on behalf
>   of any netns owner with CAP_NET_ADMIN in that netns, a user namespace appears
>   sufficient to trigger it. On an affected host that makes it a local denial of
>   service against all IPsec traffic. You may want to treat that aspect via
>   security@kernel.org<mailto:security@kernel.org>; I have not verified the unprivileged path myself.
> 
> Suggested fix (any of)
> ----------------------
> 1. Fail early: at the top of xfrm6_tunnel_init(),
>         if (!ipv6_mod_enabled())
>                 return -EOPNOTSUPP;
>    as other IPv6-dependent modules do, so nothing is registered before the check.

I think this is the way to go. Do you want to submit a fix?

Thanks!
