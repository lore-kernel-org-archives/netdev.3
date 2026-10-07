Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D937F01B
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399086; cv=none; b=cKFonELwN4xRxN4XE6eabzu+FT6/cBHou2RdCk1LjrzQ+UoL/1jnFqexzWdPVwJ5NExmaddqtXCnpkuuP3UmG9KDGyI9aLsCcZFG4d6cg9fGQMmVREsy5d+OVNffV3FYLpQOsXU5pEcQUvCSpiKb01yqp4LRCwBa//yMU2/0rm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399086; c=relaxed/simple;
	bh=ooFE7wgNH86QzW50A74Hxs0eR/QZYfgdmjGkzqzYeSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2JIU6zS2ak3Q7xD2d8yQ7MJwQKl3DlDQ2BEjua9uCcVcVbibrD+eIFwZrnRkDr7smnomNG92LxLwGtjUNYcx14JnflEoyoy7tfLGGm5JJ47BbgsBPq81F/0haPRpzO5/TM+Ihs5X2OGsffS7Rvffxdn0B8CdPoI9D82l+vKtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYU9wJxU; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYU9wJxU"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso1544658a91.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791399084; x=1792003884; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X71f5KGOL/rbhedaUKsgXlp/Wmx4B13NNF0vqiORCgc=;
        b=UYU9wJxUW8RQY34jHuYGL+FPkvRW3Y1QTJlT6kUlCrIKZ33cSWo37k3aZJPIEtPbcS
         iw31KIb2d+7FQI6Q+ZziZA55y7RM/YrMwHbRxH8BqMBoyUcShZ4ZfkMWHVbQ+XZpRnO7
         M/0YLM/npZ2WdSIoKh+PS2kUsACPPJ2gqrCKu2b9ItB+d5Z9UiM2tk/t5feiZX86VWDJ
         /29KL+C4+nsdKLD4pRCtndiKyMRN0640JoEA2+ShJ992wRIaEvV5kw2v2J/Vh2uDfxq5
         REn95bUX+yA8WeYzTuZseAyGP+ynjCnUpz61kzeLC+LQ2odxjZQXnB/6ug7iF0uI0VUG
         j1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791399084; x=1792003884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X71f5KGOL/rbhedaUKsgXlp/Wmx4B13NNF0vqiORCgc=;
        b=vYaXxLspC27tYRD4392V/B2xuWZLtmGKKJ1AzJ3EGRWbJY/73XUNhpuIzbqsRGM3fu
         X4QA23ycQS1EyPemTx104vWn+8g1F1+lWBcPBuYMEEv71K03vKwlsDqD0vn2d7W0vuLj
         Peshr/Kzl9T23wpGNOY6ToZoxGkT/DTtG5jACktBT+lIhvHQ/LAI6PMeFsx5KOw2fVD4
         dmwPkTgM0eeRs8zlBfM+btgQ1zifJTtMw0Nug1QyZ1HZStbr3vojomJ7OJEzS2JC6B4X
         wRcuEKKSqho3wWiDrNKjBVtDKp9cbP9U/AqRebM/Kg39uNRuOGKcZlo2z7EM+YLX2EuJ
         5v4w==
X-Gm-Message-State: AFq9FYLVU5vvx1q0AzKdWDN5VB3UgfasK89m4ioPY2udJJC01hjXBLCu
	1Nq7UlpO4pynJbrn9W8wQT1i11vEzkPzQvNpPwGSY8rFw96aS9S0TqXQ
X-Gm-Gg: AYBFou2Q6klh+d6vaO8ZMyu3Uy7oUUVC1SJG1wyrWjb+GJkTUsNT7MhlxBIiK4JlEt0
	PPZiXKKPQzqvoPydCa/5sw4c0kp1+REaYhy5q0joCJ1i8BwAxQPl0sQKpb/LAUNrB8udMBO4Tf6
	WrOalht8kSAol0ThNh7AqvoAxLmr98WCRAf/25Hn0yCfiI0eXnrE+LFFCjrWYNbseph4bD+kn9r
	5/iIqW/6i3/5Bdx3Z1gTB4ot8DCorcgnuneiIZJ2cCWsv5PgxU8ME/MRNtOGoVWWk5/lem9v9Gx
	HWAdSkQEIhHo+NYACFGac4/+k4Aqz/s1ERo/5zN9aoTRN8BkFACablM9ymTmwfohDz43W4cgP1t
	Of47dylAL4/xLsvlQ0lHZ4YstmUBq4Vzopl5lTLJfo/qdIrOucjHOPTELZN5bK/yRhdbtzIdalf
	tdQapOAPXUzDO5FGeioXG/H9PI2s98uIVYCuOQExuf6xsSGmJV38CEx6U7imFIGuP8
X-Received: by 2002:a17:90b:1812:b0:3a4:b061:2765 with SMTP id 98e67ed59e1d1-3a8a072a80dmr2823533a91.15.1791399083918;
        Wed, 07 Oct 2026 11:51:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1a23c82sm754330a91.1.2026.10.07.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:51:23 -0700 (PDT)
Date: Wed, 7 Oct 2026 11:51:19 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net v2] xsk: freeze deferred pool teardown without
 blocking unregister
Message-ID: <asaTvPO05EpmUEgN@devvm7509.cco0.facebook.com>
References: <20261005-xsk-suspend-teardown-v2-1-2d87228f4329@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005-xsk-suspend-teardown-v2-1-2d87228f4329@gmail.com>

On 10/05, James Hilliard wrote:
> Deferred pool destruction calls ndo_bpf() under RTNL. system_wq is
> not frozen during system sleep, so that callback can run after a
> device has suspended and gated its clocks. Use system_freezable_wq
> so running destruction finishes before device suspend and new work
> waits until process thaw.
> 
> Keep assigned pools visible to NETDEV_UNREGISTER independently of
> the socket list. A released socket has already left that list, but
> its final pool put can queue destruction after workqueues freeze.
> A resume-time unregister would then wait for a device reference
> whose release cannot run until the resume completes.
> 
> Track assigned pools per netdev under RTNL and detach remaining pools
> after the notifier socket walk, including copy-mode pools. This also
> covers leased queues without scanning pools from unrelated devices or
> network namespaces. Remove the entry on assignment failure and normal
> teardown. The deferred worker still owns the pool and later observes
> the cleared device pointer, avoiding a second driver detach or put.
> 
> The lifetime problem was identified by code inspection of the deferred
> release and system-sleep paths.
> 
> Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from umem")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v2:
> - Track assigned pools per netdev instead of scanning a global pool list.
> - Keep deferred releases visible across queue changes and queue leases.
> - Rebase onto current net.
> - Link to v1: https://patch.msgid.link/20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com
> 
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@kernel.org>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: Magnus Karlsson <magnus.karlsson@intel.com>
> To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> To: Stanislav Fomichev <sdf@fomichev.me>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Jesper Dangaard Brouer <hawk@kernel.org>
> To: John Fastabend <john.fastabend@gmail.com>
> To: Björn Töpel <bjorn@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bpf@vger.kernel.org
> ---
>  include/linux/netdevice.h   |  5 +++++
>  include/net/xsk_buff_pool.h |  3 +++
>  net/xdp/xsk.c               |  5 +++++
>  net/xdp/xsk_buff_pool.c     | 25 ++++++++++++++++++++++++-
>  4 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 3cff2174dc03..72091938f6e6 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2545,6 +2545,11 @@ struct net_device {
>  	/* protected by rtnl_lock */
>  	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
>  
> +#ifdef CONFIG_XDP_SOCKETS
> +	/** @xsk_pools: assigned AF_XDP pools, protected by rtnl_lock */


Can we mark this as being ops protected (net_device::lock) ?
xp_clear_dev calls netdev_lock_ops, but xp_assign_dev
has netdev_assert_locked_ops_compat, so maybe there needs to be a bit more
care. We don't want to add new ASSERT_RTNL if possible (and extend new
netdev lock semantics).

The rest looks good.
