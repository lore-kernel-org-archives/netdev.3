Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327558;
	b=IbD0gpyTOorBL33wqpc9MIUQMoACWU+bnQphpCm6h3CCpGUf9Jc8IfHtOGKKpCv6YWfL
	 G5zKpKdwvAJeoZu4xACurshXmhVQbmjGIJKKcxD6GrZEkFORwAY5cpyDw4Kj9D/ebc9xJ
	 vSH+kfqgqMzFoGM41Me6clGFQfT/sWl0hQzhniJ97ISFO0uyzityUu7Tn3RvGtKBNMh+8
	 bBVv8hjqs2T0GMJSTVXIfYnBQjqmD8x3vytdY3n0DoSbdWhKEyUxEi9XXPfTZiDBM0lPi
	 8hSmb//FGqXuyIRyV/SqLy0797NpBpzac2sKVd8Hm5lylW+y4doWUVeF1/Zbi6cnYWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327558;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CMIr+VCnk2q/SbsJ+ylDwFn/B1xVmtQwCO7UAjPLoPI=;
	b=vMynfeA7rILD5yk3266A6hN70oZkEF8dpuPkhG3YuqxXhpUmGtoeljoUJiNaEneLuoEY
	 CcQBKTYxT04ALocg7ALDwruq+gb/CJQLWs1twL74xafAB1aNzaDYcsL1lt1+aquJro3dj
	 K2cYWf4WAvpFkfU2bclynBKEzZQE3UUSqFYXRfI8jeGLV+xPu3GzChzeoauz3RtO9H5z8
	 tMsCckwcOq81YE/4OU+Bh40CmNKnMV9wE+k76vJGh5XcBLCC8ciePJmp/YqJo1NIH1bIA
	 u9I+0SYe45H9twmkZrlM5SnFy7+/LZ64hisqbX1+ISNY/149slpVqa4VV5sGvFtm9HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XkJphtGT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91C606A331;
	Tue, 10 Nov 2026 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XkJphtGT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114AD1F008A1;
	Tue, 10 Nov 2026 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327557;
	bh=CMIr+VCnk2q/SbsJ+ylDwFn/B1xVmtQwCO7UAjPLoPI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XkJphtGTssJycmUoAy8KQDpEqq3EVFJZ8MaHMVTN44+aC9u52kYu6k9O42Al6WlHL
	 T9Q3ofoW6pWTHtoRckl7nkOD/Zqi+rmzV7gzlXumCbvWGTcUzsf/Bj6fxywzhtG9nK
	 6p+1phrTIwUxVyUUleK5+MBZP3OvU0mBMSXReBW/TJSEReh4YSi054+5lt5KUHIEaU
	 uB00XcP+yeQIoWiiZnLv8PFj1mKyADUmBGgNtdFwnt8rZts3sZcah4Vl/eg6SCYGvL
	 +oMsah1A1H31VLZxT5JemS6M2O1yL1JGuzE//SwiZJsGQ4EKd5K51gRVGVxY5DaYeq
	 IbIy+ZJu9F3+w==
Subject: Re: [PATCH net-next v6 06/10] bnge: remove refcount from L2 filter
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Tue, 10 Nov 2026 16:19:16 +0000
Message-ID: <179432755662.994134.8228412732049021470@kernel.org>
In-Reply-To: <20261106093524.838341-7-vikas.gupta@broadcom.com>
References: <20261106093524.838341-7-vikas.gupta@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the patch only removes the L2 filter
  refcount, but the patch also changes what bnge_alloc_l2_filter()…

--

bnge: remove refcount from L2 filter

This patch removes the refcount from struct bnge_l2_filter. From now on,
only the context that created a filter will delete it. The lookup helper
is folded into one function that asserts the netdev instance lock is
held, and bnge_alloc_l2_filter() now returns -EEXIST for a duplicate key.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> index a8bb441ebef9a..6316f75ca36ea 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c

[ ... ]

> @@ -75,9 +63,10 @@ static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
>  
>  	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
>  	      BNGE_L2_FLTR_HASH_MASK;
> +
>  	fltr = bnge_lookup_l2_filter(bn, key, idx);
>  	if (fltr)
> -		return fltr;
> +		return ERR_PTR(-EEXIST);

[Severity: Low]
This changes what bnge_alloc_l2_filter() does, and the commit message
doesn't mention it. Could the changelog describe this?

Before this patch, a duplicate dst MAC/VLAN key returned the existing
filter with an extra reference, so the caller shared it. Now a duplicate
key is a hard error.

bnge_hwrm_set_vnic_filter() passes the error up to both of its callers.
In bnge_cfg_rx_mode() it gets treated like any other HWRM failure:

	rc = bnge_hwrm_set_vnic_filter(bn, 0, i, vnic->uc_list + off);
	if (rc) {
		...
			netdev_err(dev, "HWRM vnic filter failure rc: %d\n",
				   rc);
		vnic->uc_filter_count = i;
		return rc;
	}

In bnge_init_chip() it would make open fail on the dev_addr filter.

As far as I can tell, nothing can request a duplicate key at this
commit:

  - the unicast address list is already de-duplicated
  - dev_addr is skipped when uc_list is filled
  - there is no ndo_set_mac_address
  - bnge_hwrm_clear_vnic_filter() removes every tracked filter on close

So this shouldn't change behaviour yet. A later patch in the series also
seems to depend on it on purpose, since it adds explicit -EEXIST handling
in bnge_cfg_rx_mode() for addresses "Already delivered by a user L2
rule".

The commit message only describes removing the refcount, though, so
could it also mention that duplicate keys now return -EEXIST instead of
being shared?

>  
>  	fltr = kzalloc_obj(*fltr, gfp);
>  	if (!fltr)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106093524.838341-1-vikas.gupta%40broadcom.com
