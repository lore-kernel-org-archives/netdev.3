Received: from mta1.migadu.com (out-101.mta1.migadu.com [95.215.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CA36A34F
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787101916; cv=none; b=LUEBWH18joYvhZbnSwWcF29+iOsEcfeUGWiTouI/kMViMyg8yoYZ504GV9cR4TuvfOg0IA1UYHAFuoYbT4gqh03+Vg5iKk9Tv6toVwCAHNQFyq0Gky9jN33MHgDmxPfAK9/HV8YONuSWeO2X0Y6jAvqHZ+Lnn38f2xZTYobvb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787101916; c=relaxed/simple;
	bh=yQ+o8E9qpgHmSFZBwKXv12LUWNIxh8f0ja14toYHFXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7kAjNvZLtTh4EmO9rGP3DVuK2JDAb0KytAchrdfmV8jvVMhwOVVxbh83x2a7CyjjY4YUbNtVnSm4VyeQ3T19SxF+X5bp8K5LVEdi4NoK3qhleVT+JoXdIbhUs8M0oEE0Ve2KrddTfFDa0ZqUfHkn5/wY+Us3Hr1VxIdgU/QWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QoYC8C3u; arc=none smtp.client-ip=95.215.58.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QoYC8C3u"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yQ+o8E9qpgHmSFZBwKXv12LUWNIxh8f0ja14toYHFXA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787101911; v=1; x=1787706711;
 b=QoYC8C3utdM8crQeV3EbHgBeIRRsAcO74BNnDpPbLamNWST5kHX26CttHVHulKfgiDHq14bF
 b9bGhcNj3e6npTdywgA8P3LMQTqDiwD398E5pEac/4cL4/O6Pk6tMPzccoG7J4OYuKddS6L9pLm
 ZhkH4yy8bP3p6mrcjDJm7V04=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.241)
	by smtp.migadu.com with ESMTPS id 2fdf873d03b45299;
	Wed, 19 Aug 2026 01:11:41 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 09:11:33 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v3 1/2] bonding: convert unbalanced_load to per-cpu
 state
Message-ID: <aoUCxTFtxSjW6zZv@fedora>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
 <20260818-bond_overflow-v3-1-e05d4dbc2fd8@kylinos.cn>
 <fb48d9f3-f0f8-4532-aa4f-de8fa1a13f6a@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb48d9f3-f0f8-4532-aa4f-de8fa1a13f6a@blackwall.org>

On Tue, Aug 18, 2026 at 12:42:10PM +0300, Nikolay Aleksandrov wrote:
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index 522eab060f9e..9fb44e0031c8 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -5995,6 +5995,7 @@ static void bond_destructor(struct net_device *bond_dev)
> >   		destroy_workqueue(bond->wq);
> >   	free_percpu(bond->rr_tx_counter);
> > +	free_percpu(bond->alb_info.unbalanced_load);
> >   }
> >   void bond_setup(struct net_device *bond_dev)
> > @@ -6494,6 +6495,10 @@ static int bond_init(struct net_device *bond_dev)
> >   	if (!bond->wq)
> >   		return -ENOMEM;
> > +	bond->alb_info.unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
> > +	if (!bond->alb_info.unbalanced_load)
> > +		goto wq_out;
> > +
> 
> The bond doesn't generally depend on this struct and shouldn't fail to init
> if it fails to allocate and the user hasn't chosen alb mode. Also here is too
> early to tell, the netlink mode hasn't been applied yet.
> Maybe the allocation could be moved to bond_alb_initialize and the freeing to
> bond_alb_deinitialize?

Makes sense. Let me move it to tlb_initialize/tlb_deinitialize.

Thanks
Hangbin
