Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65131328B;
	Sat,  4 Apr 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775295204; cv=none; b=Fq+znMmpYFNipPKDY5pHX625uRDbSbX5Z6NyPynSSQhSWAaMT9J8FL0/WfTzhilsblPibJIXKPi+csMxwtmwg55tYM7gVM3oWAYt2WymbJQqwKyyO5h1VyktAhZTuTNlMR5ABLYVPQeqH8idMPM5fjl734Nhoi2nvkXNc68zEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775295204; c=relaxed/simple;
	bh=ihml30L6IwTRwoewdtG8cCQ/NY3VaFhw1i/mpS3mqsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQopWD7V0hS1dvrvfuD/GmwvGhSLTMdy8xK3B7I2QrVquzYvIpIjjMLVl/WZma1+efjt3p62xCj6UQr8FdlJCs3xBOTET3ZjEXlXWi1NDy6XRAMnxdRdSXhfb8YAeLMhowxYxJAR7SlV4guqtUMlfsekYcsC30lkxgFTmjOAyIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 724366079E; Sat, 04 Apr 2026 11:33:20 +0200 (CEST)
Date: Sat, 4 Apr 2026 11:33:16 +0200
From: Florian Westphal <fw@strlen.de>
To: Kotlyarov Mihail <mihailkotlyarow@gmail.com>
Cc: netdev@vger.kernel.org, lvc-project@linuxtesting.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ipsec] xfrm: fix refcount leak in xfrm_migrate_policy_find
Message-ID: <adDa3Bn-7J8zUQda@strlen.de>
References: <20260404090525.105083-1-mihailkotlyarow@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404090525.105083-1-mihailkotlyarow@gmail.com>

Kotlyarov Mihail <mihailkotlyarow@gmail.com> wrote:
> syzkaller reported a memory leak in xfrm_policy_alloc:
> 
>   BUG: memory leak
>   unreferenced object 0xffff888114d79000 (size 1024):
>     comm "syz.1.17", pid 931
>     ...
>     xfrm_policy_alloc+0xb3/0x4b0 net/xfrm/xfrm_policy.c:432
> 
> The root cause is a double call to xfrm_pol_hold_rcu() in
> xfrm_migrate_policy_find(). The lookup function already returns
> a policy with held reference, making the second call redundant.
> Remove the redundant xfrm_pol_hold_rcu() call to fix the refcount
> imbalance and prevent the memory leak.

Reviewed-by: Florian Westphal <fw@strlen.de>
