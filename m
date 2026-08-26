Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3AB40911B;
	Wed, 26 Aug 2026 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746832; cv=none; b=jX+feuUS3lZ0MCfhiOpmVXNOnmo0eeG3WNk8rQMkRKTmOj1JBTI54cgqdcuzlF2T5sJ84/a3IoYFxnnIzBLjUcdAIoirHhB15nWTlMB+VQoeY6sXpqoYZ6Ny/d04KoWdZ7M+gNU1rdB4BAIq/iY9eFCVJsp1KnG5MkykIdMUZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746832; c=relaxed/simple;
	bh=u/ZbgQ6YVEFMOOVjQF3TVQ9zgDAloA+CQ3E4MRezZF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODafAY5NQumPnNxtZfKLOP2RbXABwKNLIVriN+mh23Bjzziqd9JdP+6To8y+hnoer30+xdky2hf3L9voJqsRgJjGhanevbRxUQ5CoOBEvvFQWWkBtZpVFawxIEj2bBaExeqhaADwjSLJcU0dWCLqdHlmPwVhVFzxNwg1mqi/zyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=o0U5mNBa; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="o0U5mNBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1787746824;
	bh=efcHY6AB8gWuYLRRYFwXZGJx8iSndRdJFmvnMuALy4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0U5mNBaQc88RRPOPM9HI6HiSKtyGpZQo+jvTTP6+sGMqGaM3VC+rWenewJMznGAz
	 J22OOukcN/3KIinJs53ySKf+XZXIMxqoGN8IrLlwoUTEbDjiwEGz6SY5+Twd5PL+gh
	 3YsKnrpJ2j7264jmiDoH5Br1YDy1cqM9JZWA8MBH00cnGUUSlAvN4EjcLWU2T6QfVb
	 Dby3ijfQ64aPIZasrtPebloGVpkL/S/VY3MjKKDzIHcWIcdMsW+zs/47RLNXVDhFp5
	 M1PHGnZMTsu5w8blOVzzVp/NNimo7sOkSzyPutFCPmYg0kI4pNsoN32/Zm5Qy4FnZU
	 yOg32YR/hswag==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id A49CC60090;
	Wed, 26 Aug 2026 14:20:24 +0200 (CEST)
Date: Wed, 26 Aug 2026 14:20:21 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: laforge@gnumonks.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com, osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v2 0/2] gtp: fix sk_created race conditions
Message-ID: <ao7aBWwaGNCwnEQv@chamomile>
References: <20260825052404.45665-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825052404.45665-1-blbllhy@gmail.com>

On Tue, Aug 25, 2026 at 01:24:02AM -0400, Cen Zhang (Microsoft) wrote:
> Two races exist around the sk_created flag in the GTP driver: an
> initialization ordering issue where sk_created is published before the
> socket pointers are assigned, and a teardown lifetime issue where
> concurrent readers can still use the sockets after they are freed. They
> are split into separate patches because they require fundamentally
> different fixes -- memory barriers for ordering vs synchronize_net() and
> RTNL for lifetime.

May I suggest to partial revert of these patches?

 d33bd757d362 ("gtp: Implement GTP echo request")
 9af41cc33471 ("gtp: Implement GTP echo response")

I don't see a use-case for them

I can see a use-case for:

b20dc3c68458 ("gtp: Allow to create GTP device without FDs")

for testing purpose, ie. allowing to create a GTP tunnel without a
userspace program which deals with control plane.

As far as I understood, the reported issues are all related to them.

> Changes since v1 [1]:
> - Use smp_store_release()/smp_load_acquire() for proper memory ordering
>   as suggested by Simon Horman.
> - Add patch 2/2 to fix teardown races in gtp_encap_disable(): reorder
>   to clear sk_created first, add synchronize_net() for softirq paths,
>   and hold RTNL in gtp_genl_send_echo_req() for the process-context
>   path that synchronize_net() cannot protect.
> 
> Patch 1/2 fixes the initialization ordering race.
> Patch 2/2 fixes the teardown lifetime races (softirq + genl).
> 
> [1] https://lore.kernel.org/netdev/20260816035205.57966-1-blbllhy@gmail.com/
> 
> Cen Zhang (Microsoft) (2):
>   gtp: fix sk_created publication race in gtp_create_sockets()
>   gtp: fix use-after-free during GTP device teardown
> 
>  drivers/net/gtp.c | 70 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 51 insertions(+), 19 deletions(-)
> 
> 
> base-commit: b70b7b71561f2be1183b6046964d950c2b203bfc
> -- 
> 2.55.0
