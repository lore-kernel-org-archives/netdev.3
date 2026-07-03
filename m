Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB2380FD1
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060872; cv=none; b=qZuuLgCCBvMKtihK/jBLLy2VQlyI1dxFmc5EuOIiPhw33U2bQqa8qlyo0mkSpMHdLRT5A/Usu+PgAFo5zBKSqmwzxSKQIHH4KH3z3bzBiDTpy2iAwmFa3vonDZKmOQZ2v+tetydpbo75Umq4scXE227/VsE+GGQiBO1qq375nnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060872; c=relaxed/simple;
	bh=++q6XaBXe7wgaCVoeq3lcGF1qzvDfgWiiemhywD8qaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B1eGHu1SvVtZmimXO8QtEi2D86vlW6gV3bqu9Y0Glt38EU+4Q84zwlHWXJ1kGRB9cfZudi75HELwp1uUUV+rdXk9e0dmKwP+TwBxq9cAdLsikiltDVZTaAwdek0+ZDgsJukTun2d3rbAjshL58pViI77r3nddSyNg8dp5iGGprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUBrOwzz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUBrOwzz"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8894570b58so237659a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 23:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783060870; x=1783665670; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1HmvWkxk6N+YA53uVqd5+yjqIl+LiU06WsEqplBXZ8=;
        b=LUBrOwzzhwxn868rkk8fwSK/drOyQrH7jcLNxS4oep4FYH7VoTu7sggVu52dZPXTBQ
         FOUIPRhSQadEqEjY+wOW4WfTL5dAMfRt/quXIcF/YqRe/MujUxyDIygBV+sR/D3ZePe2
         O+bU69xLKj4gJKAqQyjUxwcHtHHbppwYx24PMphZS7KPq49yi3/loDpE0f2WR+UFANct
         iuhM8xs7y44Km/cZgjRyTpZ2OUWAfeEXxAPSIn6kWdEe8Am+TfpV5A9rZli5JK09CDJ2
         viiMPAO1mm5s7zGxPU3oLALCDW9Gimr55c+up4mehmwOvZjYPJ5OQ/utItB3gEJtWzl6
         pwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783060870; x=1783665670;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B1HmvWkxk6N+YA53uVqd5+yjqIl+LiU06WsEqplBXZ8=;
        b=YFGZCuSASikyocWNJWY3xMoJ3j0J3WwM3mWdL3+NLDX0l9uK+q6Pq2pEDOiOAV+B+5
         CTfplyUiFxLq0UmoM5/czCe5ZWLdBKzwaXCbA57NTQd8JcuVrscGo7dbppawQC+8IyFS
         qmlk1FM03ajul07wUsnf3z8xBjH/AXkl3KyUNgLmWDi2Wjowxk77VpYENl+FU6NFCT4j
         b0k3rR0PwmK2iRjXNAsmk6NNf3dv1+nH0vuMm3oy5P4yAVeZPTvGs7KrtR9alZnPRD/U
         RsFcaH+wTwMBj4MpXbKApVvxlKyiGjH8WapMVRjz3+zI63C7+Seqt0GT9y8Zzj7X9Wu8
         ycYA==
X-Forwarded-Encrypted: i=1; AFNElJ+oqutQAjccU3CiAmxGP7eIKnADvbYg7brX8ZKNz46mPCgfwy6IIN8jzNNeOOqDb2yNbVVBbGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJKG+fICO4LxeEYV/IuhgDVW+H6weFFf2xQUFjcP6loP9Mwkt
	2GAD2OSZ8kr7hg8nqwK2K2HP8zWcZ7yrjydsYPZoA3bVv28ERdMqeG3OmDhTlmhkGArYR7Cl+qs
	M1tCELg==
X-Received: from pgbfm10.prod.google.com ([2002:a05:6a02:498a:b0:c9e:28e0:16dd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a26:b0:3bf:a698:ce4d
 with SMTP id adf61e73a8af0-3bff42ef857mr9796827637.54.1783060869774; Thu, 02
 Jul 2026 23:41:09 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:38:52 +0000
In-Reply-To: <20260701081602.3185086-3-paritosh.potukuchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701081602.3185086-3-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703064109.1836070-1-kuniyu@google.com>
Subject: Re: [PATCH v2 2/2] bonding: reuse neigh_setup from slave neigh_parms
From: Kuniyuki Iwashima <kuniyu@google.com>
To: paritoshpotukuchi@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, paritosh.potukuchi@amd.com
Content-Type: text/plain; charset="UTF-8"

From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
Date: Wed,  1 Jul 2026 08:16:00 +0000
> bond_neigh_init() currently relies on the slave device's
> ndo_neigh_setup() callback to obtain a neigh_setup() handler.
> 
> When an initialized neigh_parms instance already exists for the
> slave device, reuse the neigh_setup() callback stored in it instead
> of invoking ndo_neigh_setup() again.
> 
> If no neigh_parms instance is found, or no neigh_setup() callback is
> present, retain the existing ndo_neigh_setup() fallback path.
> 
> This avoids unnecessary ndo_neigh_setup() invocations while preserving
> existing behaviour.
> 
> Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
> ---
>  drivers/net/bonding/bond_main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e044fc733b8c..d2e4dae4e97c 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -4719,7 +4719,7 @@ static int bond_neigh_init(struct neighbour *n)
>  {
>  	struct bonding *bond = netdev_priv(n->dev);
>  	const struct net_device_ops *slave_ops;
> -	struct neigh_parms parms;
> +	struct neigh_parms parms, *p;
>  	struct slave *slave;
>  	int ret = 0;
>  
> @@ -4727,6 +4727,14 @@ static int bond_neigh_init(struct neighbour *n)
>  	slave = bond_first_slave_rcu(bond);
>  	if (!slave)
>  		goto out;
> +
> +	p = neigh_parms_lookup_dev(n->tbl, slave->dev);

This introduces O(n) list traversal while it can be done
with fixed costs (3 dereferences + 1 call).

Since neigh_table is global (arp_tbl or nd_tbl), the O(n)
list traversal could take longer and rather de-optimise.


> +
> +	if (p && p->neigh_setup) {
> +		ret = p->neigh_setup(n);
> +		goto out;
> +	}
> +
>  	slave_ops = slave->dev->netdev_ops;
>  	if (!slave_ops->ndo_neigh_setup)
>  		goto out;
> -- 
> 2.43.0
