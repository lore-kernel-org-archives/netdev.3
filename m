Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.245.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666097;
	b=U9rBO42PEssPSuSrVt2vMQMw5lKrD40iEvn78gVLIoNTweNBcdJhWxV8omv9VsiLYCZq
	 uNStCX1haINN3dTaBv6b/nrBJBlu3LjdOqA6agUkwncq1CE9qfwYRN96Mg04OfmsGIRkn
	 iaWNZLf94e7VpRCkD7CbITudbXb5gTDzejhYPbTwlllKsZxazvyNWectVWIAnIi4QZiW4
	 a84LqP5Z0ar997H+8z8VEm9OeyOz1sIeMb6+cHPh3aUcPXbVTiaPSJbdTIyAt4ROMCE4o
	 9FYaxs0zjfkLaPxl0VrKPzWAl+mqlrZLFXjJSzQJPU1Ck2V2WVPoS9oGz6M84y+DfRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666097;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gxHu+OsACNNKDOs52BFr5ziYno8vbDilu9o3NOvqrIs=;
	b=uoxtXfMW9hfhsQpoI38asms/mQccWyOPT2ED1GUPRx/XeUeaF6mDcNqt2RpOEjEuOwFf
	 WCChNY5HN1x0GsjXvWvUn+C942a5UmgQKh2cjax3xoC9pG/o58n45x+IPZeEKLeYK0uGq
	 8ZBTxTRPbZm9Vc/spkeNuRWs/0y6zlYDvJ3L6JxQgLMjbAtUm4STKjXUR8VY5ljwjj+qG
	 qjWEgECaLtzdv1N3u/hJhMizBN78mcSCGqDn7sp+oOs5Hlm1lniOUxLPG7rXjorqiniM7
	 FDyHz0sRbPj5cToRw5BORhoCYO7Js0VAZYsYmVFrJD7oNjn5oBWGUa77WoJymkzDqqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=strlen.de;
	spf=pass smtp.mailfrom=strlen.de;
	arc=none smtp.remote-ip=91.216.245.30
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A6606A320;
	Thu, 22 Oct 2026 10:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 325A6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D066D60F16; Thu, 22 Oct 2026 12:48:07 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:48:07 +0200
From: Florian Westphal <fw@strlen.de>
To: Eduard Zateev <hackerowskiy@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f3f4fce0609f8e91b540@syzkaller.appspotmail.com
Subject: Re: [PATCH] xfrm: disable state hash resize work on netns exit
Message-ID: <atnp52JxdGXixDge@strlen.de>
References: <20261022102641.1429128-1-hackerowskiy@gmail.com>
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
In-Reply-To: <20261022102641.1429128-1-hackerowskiy@gmail.com>

Eduard Zateev <hackerowskiy@gmail.com> wrote:
> xfrm_state_fini() flushes state_hash_work before it inspects and frees the
> per-net state hash tables. A concurrent state insertion can queue another
> resize while that flush is in progress. The resize worker may then replace
> and free a table while teardown is still walking it.
> 
> Disable and drain state_hash_work before flushing states and freeing the
> tables. This also prevents a new resize from being queued during teardown.
> 
> Fixes: f034b5d4efdf ("[XFRM]: Dynamic xfrm_state hash table sizing.")
> Reported-by: syzbot+f3f4fce0609f8e91b540@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f3f4fce0609f8e91b540
> Assisted-by: LLM
> 
> Build-tested: W=1 ARCH=arm64 net/xfrm/ (out-of-tree build).
> No reproducer was available to run the teardown race locally.
>
> Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
> ---
>  net/xfrm/xfrm_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index e45aa1ed5b9..8a2e465bd73 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -3392,7 +3392,7 @@ void xfrm_state_fini(struct net *net)
>  	unsigned int sz;
>  	int i;
>  
> -	flush_work(&net->xfrm.state_hash_work);
> +	disable_work_sync(&net->xfrm.state_hash_work);

This is already done in xfrm_net_pre_exit().
