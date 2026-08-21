Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70B2931DB;
	Fri, 21 Aug 2026 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320397; cv=none; b=j2qI+GKqPQNdMAihIMzGe2INOm8DlzAEpPLMV5jS4Qa0IVVyt+5WrGz/E7fHABLKtBo9ceW40svgR/fVPicIrvLYhIOvl3JimC4GaNfBOPCj1kM12sGkvQkh0EeUzYR3HZ796kTKrsqjZpyS2l/ZvPOrhwh17jvXj2W46yMgb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320397; c=relaxed/simple;
	bh=zGcO+L1Pk8dO3rgHd2CbuSVQ8L8RvmqTg+i1g+mTfDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax1+Y4LahTspHdvlhi8XOBcLUQ7CGcnFyriBowXjGHGVwdHO4cBm4YCBwFLY3tWn0lLg02B/bMCCWtJr4JvLBFwhOCKXu0NIR+VUBsdGgTjHdwnhofTze/scZpEw3TahporgQPDsV3nxd0ySmh8YlWejJSsX7rQH/31pA2CFRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+Djd46I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+Djd46I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374AB1F000E9;
	Fri, 21 Aug 2026 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787320395;
	bh=3EwZwba2KvS7lqR6qEy56HRAq7I15MGhFbxl+rqc+AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G+Djd46ITu/kdJZm7Mpmgj9Iobosase+8V8UtGgCVyHEmGgDD3ho1Yyr2yewnrsgo
	 i5E7V+b3YoA7pedIEcPAqoegcko+3w3QCKihadZvUQQzy1dEHrZd5XO8vXu1YEu/o5
	 Aj6TTZixYo7I0FcKCYnfKYN40K3HBbY4N3SzevXKv3BD5xl9T9bSor4lo8TzloobjP
	 4V0R82tpxtup7pcmF9HpupcaiSdvHpGV1CoLP9Cfzo2RTTUAH+IBQfJuA88LQYHedf
	 6dTXhrVkoDdIwDtgezvMkVCYtI3g2zgoegi99ZuRaF3GNp78T8JXvsguczQ1f6zVvN
	 CgAw51SP/k8Mw==
Date: Fri, 21 Aug 2026 14:53:11 +0100
From: Simon Horman <horms@kernel.org>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v2] gtp: add synchronize_net() in gtp_newlink() error
 path to prevent use-after-free
Message-ID: <20260821135311.GJ265046@horms.kernel.org>
References: <20260820020735.59474-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820020735.59474-1-blbllhy@gmail.com>

On Wed, Aug 19, 2026 at 10:07:35PM -0400, Cen Zhang (Microsoft) wrote:
> gtp_newlink()'s error path frees tid_hash and addr_hash without
> waiting for an RCU grace period after clearing sk_user_data. A
> concurrent gtp_encap_recv() in softirq may still hold the gtp_dev
> pointer obtained via rcu_dereference_sk_user_data() and access the
> freed memory.
> 
>   BUG: KASAN: slab-use-after-free in gtp0_pdp_find+0x1f6/0x200 (gtp.c:152)
>   Call Trace:
>    <IRQ>
>    gtp0_pdp_find+0x1f6/0x200
>    gtp_encap_recv+0x527/0x24b0
>    udp_queue_rcv_one_skb+0x75f/0xc10
> 
> Add synchronize_net() before the kfree calls in out_hashtable, which
> covers all error paths from both gtp_encap_enable() and
> gtp_create_sockets().
> 
> Fixes: 459aa660eb1d8ce6 ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v2: Add the net tree subject prefix.
> 
>  drivers/net/gtp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 9a12cc53da00..f11bcc0c0ac4 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -1543,6 +1543,8 @@ static int gtp_newlink(struct net_device *dev,
>  out_encap:
>  	gtp_encap_disable(gtp);
>  out_hashtable:
> +	/* Wait for RCU readers that may still reference this gtp_dev. */
> +	synchronize_net();
>  	kfree(gtp->addr_hash);
>  	kfree(gtp->tid_hash);
>  	return err;

A few thoughts on this, because in my opinion synchronize_net() is
a heavy operation.

1. I think it's good to have a simple fix for net.
   But I do wonder if there is some value in making the
   call to synchronize_net() conditional. Because it seem
   to me that there are failure modes where out_hashtable
   is reached but synchronisation is not required.

2. In the longer run, I wonder if it would be worth
   looking into re-ordering initialisation so the
   problem described cannot occur.
