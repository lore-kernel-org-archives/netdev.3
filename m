Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C908403AE5;
	Wed,  8 Jul 2026 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500169; cv=none; b=uScEPpzI46r++uCet7W6gD9/O8xEWrvHv4ChgDMQfjXCErWP4XLbTkU8KEtql6nSt6KJKnLhMXHhUdeRexxn4QFr8e5gJgM0NbadW1r1xcxsppX9YDHGdmL2zhWn6W/5q0cvI3ksM+RmkzVb72K5+O6Gkb4VBdGQAtZFCaUKigc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500169; c=relaxed/simple;
	bh=Q4AzakSreRmBqZMHj7yI29C3WUnQuxxYE3n9JDNM+lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX/SN0YmyGZBY0WGNicUbORx4rhkXRM2tOMgFqG8YtYp5PFXxjsaU7FeuK9trNFQ+M/mq4rnmCmTFtAk5wvl5eXmgntOQA9gWGGykmpl7UHwVyR/IYu7LxOTFQiXYlNw6XAfpFrRNOmLJCfwBkZG99vV6HweEshq12WGc/kFt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=VQFPRF75; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="VQFPRF75"
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 2155960195;
	Wed,  8 Jul 2026 10:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783500163;
	bh=WyZC4VZNLAyINCvHiu8v7Zo1G7GXtuJPqXKag7xhzsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQFPRF75I4pcJJK5OHe5FnZJOKfeDIW7PQrOoPPGRm0eMNdDhpXyA/QQcU8LsNPxh
	 jDApmBd3Pu18OiEo0TKTAn4ZgquZf3tFwuZpvJjfbZ9w1fURXGafVKwuUkaR1tTTZH
	 Fy2ikQKypjm6pUvJlmBjNyALBbUQSFyGZaI0ae53ZfnI0sNd2N/5PPCQZGC++PNxEF
	 chJozOJ7YeauBcnU6F56y9LzqoJQ0naQlIVuPvzo4bOFJzC4/6IUq6zh0RceUqEFy9
	 RaG7oXiQ5nlY9k/3VbmhJ3AlP6P+KUxRZqIsF+s3M0mq3nRF/l6vOsAe2Yk+L2q30m
	 I2cuWPFPKbeSw==
Date: Wed, 8 Jul 2026 10:42:40 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, laforge@gnumonks.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net-next] gtp: annotate PDP lookups under RTNL
Message-ID: <ak4NgOrro-4OZjz3@chamomile>
References: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
 <178349880988.2367097.8758757633307166154.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178349880988.2367097.8758757633307166154.git-patchwork-notify@kernel.org>

Hi,

On Wed, Jul 08, 2026 at 08:20:09AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
> 
> On Wed,  1 Jul 2026 20:39:25 +0800 you wrote:
> > The GTP PDP lookup helpers are shared by RCU-protected data and report
> > paths and RTNL-protected control paths such as gtp_genl_new_pdp(). The
> > helpers walk RCU hlists, but they do not currently pass the RTNL
> > condition for the control-path lookups.
> > 
> > Pass lockdep_rtnl_is_held() to the PDP hlist iterators. Existing
> > RCU-reader callers remain valid because the RCU-list macros also accept
> > an active RCU read-side section; the added condition only documents the
> > non-RCU protection already used by RTNL control paths.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net-next] gtp: annotate PDP lookups under RTNL
>     https://git.kernel.org/netdev/net-next/c/0be5c3f0fbef

For the record, I think this patch was not OK.

PDP context hashtable is protected by the genl_mutex, not rtnl.

If I'm mistaken, please let know, thanks!
