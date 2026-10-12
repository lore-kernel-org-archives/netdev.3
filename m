Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793B4A387F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822129; cv=none; b=HvSllnJoMSri4+gGHZ0IFhVAIcsvZQVyDFkcxw/1hS8JjDHhhRsmnfI9aODf2Wii1binntFPRkPsyFpHSAisAZksR6l1rz4EYJG2fgflIrGuuF8OH4OF0p5ImH06gduiYT693L2UtcMXfqhnOuyAYydxX07Tdlln3PRVCgkXJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822129; c=relaxed/simple;
	bh=FsERf/T3iBYqQtUkIqZLouugl2Noq6zQBtLWwwDU1aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVOPkFJVHRmWm161MrAvEFX0chwpneGuwXeW1KAO5Z4MKEjBsZpQg55ngiBKpCZ1WUCfBtKtqd0Q3kymQFfiBqqVaaBQtw/fTnXjW/kgJn53qF2g+9LvEa4Yy08lDAx6ERd5d2MFo4nxmY0ST0Z4hAhNFz7GBwf4wqhgOmnF9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeFSQK0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeFSQK0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894D81F0089F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791822127;
	bh=h5pWPwxzjVx8giAzDxfXw0gRk9haZQsRl5tn+dnJMtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aeFSQK0Vpz2JTuT8fsGB6CvNUesjOQUkJAPhn1n++zkt9nhYd5aQrtRl/UjzCXUqV
	 rsuLu7sQP8ibpehLvOpLptU11cZ+NVLZN42XoYOhEBiIabr9gGtZiOIxVZFTycpMMp
	 tw7CCUzvMTquvv+ijC3dv8nM6Vv+ASclccyvylPp+3ym0iSkDYAE2QTHwN+gC37XUo
	 dY0OtMAelk8MJFVRe7JpVe7us/eFJ5uPD7iFopZGUvc3WFPfZuKsbjPL6d8dUu/RND
	 IzMf9xbsrM9glSPD8xXuFtsApgH96E1+pzYMhbtWmwqETcUpeIQHFgXv6h/1uwBwUB
	 b6Et26KvjZA3Q==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6dddc514bcdso1115824eaf.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:22:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw3yCClnGMSsIyvlInJ5t5SGKpa4snvzY3x5SxicUNPN/v/Xxuld7YkJnve/u3t5nT91j9KoWY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlA+jpyn1tFoDyA6JQSJyaFshVQjlUXtO8jkUoBfiQ1LbOK2mq
	o4+hZHpyOThFps1GyDPM7002zt7ewACHFt7xJhkCZDKoAJyo9dVhp+a6LcARgDaxXP8C4mnK8ek
	fSz741MPGEa3X4tKjzVL4I6BxDkPRoxs=
X-Received: by 2002:a05:6820:f006:b0:6f8:ec2a:d20b with SMTP id
 006d021491bc7-6f8ec2ad2b4mr494521eaf.76.1791822126853; Mon, 12 Oct 2026
 09:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012124544.2018007-1-cjubran@nvidia.com>
In-Reply-To: <20261012124544.2018007-1-cjubran@nvidia.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 12 Oct 2026 18:21:54 +0200
X-Gmail-Original-Message-ID: <CAL4WiipS=-STbSFs6i_noSoop3EhUvqiHWaNUGEtZm-Zz9nT5A@mail.gmail.com>
X-Gm-Features: AclHuK9Chdog1HNVRg9XD0QxKY7jjo_Z3sUS9YdrSP79HE20S78AT8zLTJ4HurM
Message-ID: <CAL4WiipS=-STbSFs6i_noSoop3EhUvqiHWaNUGEtZm-Zz9nT5A@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: don't copy alloc_cpu in skb header copies
To: Carolina Jubran <cjubran@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 12 oct. 2026 =C3=A0 14:48, Carolina Jubran <cjubran@nvidia.com> a =
=C3=A9crit :
>
> Commit 68822bdf76f1 ("net: generalize skb freeing deferral to
> per-cpu lists") added alloc_cpu to struct sk_buff and placed it in the
> headers group copied by __copy_skb_header().
>
> This is wrong for newly allocated skbs. For example, skb_segment()
> allocates a new skb and records the current CPU in alloc_cpu, but
> __copy_skb_header() overwrites it with the value from the original skb.
>
> If the original skb was allocated on another CPU, the segment may later
> be treated as remotely allocated and unnecessarily deferred there when
> it is freed.
>
> Move alloc_cpu out of the headers group so it is preserved across
> header copies. Initialize it explicitly in skb_clone(), which allocates
> the skb object directly instead of going through __alloc_skb().
>
> This was discovered while investigating a throughput regression with
> software IPsec. The load used 512 IPsec tunnels carrying traffic over
> VXLAN, with 512 parallel iperf3 flows and an MTU of 4500.
>
> Before the fix:
>
>   16.09%  queued_spin_lock_slowpath
>              |
>              --15.90%--_raw_spin_lock_irqsave
>                        |
>                        --9.37%--__slab_free
>                                  kfree
>                                  skb_release_data
>                                  napi_consume_skb
>                                  mlx5e_poll_tx_cq
>
> After the fix:
>
>    6.84%  queued_spin_lock_slowpath
>              |
>              --6.57%--_raw_spin_lock_irqsave
>                       |
>                       --5.00%--__slab_free
>                                 kfree
>                                 skb_release_data
>                                 napi_consume_skb
>                                 mlx5e_poll_tx_cq
>
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  include/linux/skbuff.h | 2 +-
>  net/core/skbuff.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a3ff380d43f01..2d5277765939f 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -963,6 +963,7 @@ struct sk_buff {
>  #ifdef CONFIG_SKB_EXTENSIONS
>         __u8                    active_extensions;
>  #endif
> +       u16                     alloc_cpu;

spaces instead of tab here.

I had on my plate a better placement of alloc_cpu, end, tail...
I would move alloc_cpu _after_ headers group.
