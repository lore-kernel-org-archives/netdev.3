Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F2A3515D0
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661330; cv=none; b=HSZDphWNHsBRHHOdXhPT787LID6k9+SnPM+SEb94wDgTtBUTIYCf/Mt7wMMu6ErTQipKG1INPrVZ37pm3Z7vxqz2NUvgfSyQeSiGI2z7BgRb+WZYsE0kCR/7FpQebgB4BM8M1v44pg5162JQ1BPyE32UkRJ2kGhKUD6GBjZE8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661330; c=relaxed/simple;
	bh=AbUr52z8qfvnHQn5fsMaa+O85h6jBNDfkB+FAhEaN+U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rNpiWJvdWm3EpIBMw+HCe2Qk51oj7rSU8uaudDdJ6zuoVXuyy2urSeuwQG+jvV6vQuXjh8UoyRGfCpGoUzwZnk/6iOrXcHgpeb5sO5HMVGGJ+Kdkrtj24rPek7kBiqEmT5zJ+XS9bDBXV6Z/4BFTtG3wTCbdKsAG6LKxR05xIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyoIaBjj; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyoIaBjj"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-855de2d0d4dso25882497b3.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 19:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788661328; x=1789266128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=STkYn2o1kvXNd3ECyvegYTHBM5QZV8fd00NTzzl1czw=;
        b=JyoIaBjjNTM1mcHhPjf6Bg4Oqy9JPVmBIwH+UXQk9VWSPrgC4iOs21fU8aZ2+V5Ni6
         isSN+FEhDkNDHbUQNXBqBV/PrEfqac0gYzJTlGTXVr4QUUsUa/p9GNiLwHOkSFMWFTiU
         C3GIU7WS5U1IyapXd0kuR2ZnjDQvitUehB1lJXh8Gw8q54XZ7vs/uwuqpbov8+jdT3BZ
         5JZIyeEzyBw0IFqsmcivAk3AdBqfRif4Ibokol8fAyLGKhhAkYapxgtgJP1Yv/aBuY4U
         JJvbOl6KrIvp4oKw7Iy1hs26S5K0AzjwW7OtRev27kg7rEoclOOQM8tLJNGOrIaO7daB
         3g0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788661328; x=1789266128;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STkYn2o1kvXNd3ECyvegYTHBM5QZV8fd00NTzzl1czw=;
        b=Z8Vc/YRC153QQ9Ify3HZsjZyc3Y9DwYr38K+ANtzuorfa71fqDADJG7TskXUTwPLeP
         pgIeJYJLgH7zfn/TXqoQBNfLJXF91vGWX9CTCvJQtlPFFRuZXgnRVxNcGJ/YsnIlFBoY
         jIRVa3P8gyg2EUGJyr9PQ7CABiKtLf6GdNt6znd6MHx4/sESyre4QW8H022YemLOOPuK
         4uszmw2Aj939AHO7FC4vnTfDRQM4czNgee2CvOwO7AMj8FUtBq6vwCGTBuRPQLysQ8wX
         LULPxBCKDEt3idiTHRfFjuP78HIgfPGe/xzjHgK6JfX8P9tMQ2t589jLLA6ll+bMzCNK
         tR9w==
X-Gm-Message-State: AFuF++kXrbADjnTAE5801MVlwHrXZrjLiJ2JQkGkdQ4nPAIoEFQSpu92
	qnx0oFCgJnJm6YIUeUy4keGV8VxDZhS5VNBNbu9Q08+6cGFH5557t1qy
X-Gm-Gg: AYBFou2EonHh/vpaJt3k+17c/I3aTc6w2kV6i6kEIyrGnQUOt7VOm3fduH5JDOjP0Bg
	JnEBmo9kfPCpjMbT40QvGCua+6JnCZn46etQ+UQtuJsz7ggxlDPvI+5fLeBz7OGK2lxB8dDG4Yn
	WEZ3RvdBeH00nymkGXn+ioeBEayiKO3qPEmMom0UaVHRgeTvZ+8eMy05FzFvwsG6PRkIdsifYxH
	QKZg4D+KdOKcTbksHD/JDxv+ASB/e2lOZT1RXY7A8K02rvG1o9pMNTVQ+gWWpvQd08mPCbHo5QH
	H+P4zbwhVSySvBMURw/qTiyU7/KtGl19WHMiYLf24dJCJ/31XfzaXJFM39tzUykCo4UxS1yePsj
	OuRkj3baSm/xV2iJqPbRZqlQ44Qh7+EMku9nELwEiyPhsKewaTiUV44Wf5uen2wu+VRhcdVwLTa
	NiOMPM2yo18a9KHQuBTsJjPr2Sgr5Xfxy1DR+JUJOGHNiP7M5QNAN7aDyYx2Gf/TskC2qB9kYZo
	WHsnYbsb5ZVnyzjkNe2gggt8MPadslXPcfAVHDV3g==
X-Received: by 2002:a05:690c:660e:b0:873:5c6b:a319 with SMTP id 00721157ae682-8735c6ba785mr22366747b3.19.1788661327683;
        Sat, 05 Sep 2026 19:22:07 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714af5581bsm48233437b3.36.2026.09.05.19.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:22:06 -0700 (PDT)
Date: Sat, 05 Sep 2026 22:22:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.173115664f973@gmail.com>
In-Reply-To: <20260904160106.08acccb5@kernel.org>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
 <20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
 <20260904160106.08acccb5@kernel.org>
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Swapping in the conversation from v6, sorry, not sure why I missed your
> reply..
> 
> On Mon, 17 Aug 2026 22:44:30 -0400 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > On Wed, 12 Aug 2026 22:03:56 -0400 Willem de Bruijn wrote:  
> > > > The 'max_pacing_offload_horizon' field of 'struct net_device' represents
> > > > the maximum pacing offload horizon supported by the device.
> > > > 
> > > > Add a new field 'pacing_offload_horizon' to store the active pacing
> > > > offload horizon.
> > > > 
> > > > The new attribute is initialized to 0 (disabled) and can be set from
> > > > userspace via RTM_SETLINK up to dev->max_pacing_offload_horizon. This
> > > > new default off behavior does not cause regressions, as no driver yet
> > > > advertises max_pacing_offload_horizon.
> > > > 
> > > > The attribute is omitted from the newlink request spec, because the
> > > > value may need to be bound by a device maximum that first needs to be
> > > > negotiated with firmware, as is the case for the idpf driver in this
> > > > series.
> > > > 
> > > > Make both fields u32, to maintain net_device cacheline layout. This
> > > > expresses up to 4s of pacing offload, which is sufficient.
> > > > 
> > > > Update the YNL specification ('rt-link.yaml') to add the
> > > > 'pacing-offload-horizon' attribute and include it in link-all-attrs.  
> > > 
> > > Forgive my slowness but I don't get how the new param squares against
> > > TCA_FQ_OFFLOAD_HORIZON. IIRC in v5 review I asked something like "should 
> > > this new option be a boolean" because the exact time horizon already
> > > exists in the qdisc uAPI. As AI points out (among other things),
> > > the two params are not synced in anyway. User can configure qdisc
> > > offload higher than the device level one.  
> > 
> > They cannot. Or at least that sure is the intent.
> > 
> > After this patch fq tests against active limit
> > dev->pacing_offload_horizon:
> > 
> > -               if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
> > +               if (offload_horizon <=
> > +                   READ_ONCE(qdisc_dev(sch)->pacing_offload_horizon)) {
> >                         WRITE_ONCE(q->offload_horizon, offload_horizon);
> > 
> > A manual test to replace the root qdisc with fq offload_horizon 50ms
> > seems to verify this: the command fails unless a device limit of >= 50ms
> > is configured.
> 
> The other way around. Configure the Qdisc and device to horizon of 100ms
> Then lower the device horizon to 50ms. Now the qdisc has a longer horizon
> than the device.
> 
> > Perhaps I don't understand how dev->pacing_offload_horizon
> > would function as a boolean.
> 
> The only uses of the new value are:
>  - as the qdisc bound, replacing the max_ value
>    -> Leave the qdisc as is, let qdisc config define the active horizon
>  - in the driver

I see your point now, thanks. A flag NETIF_F_PACING_OFFLOAD?

The two configurable offload_horizon fields is definitely redundant.
I do not want to ship idpf with the feature on by default, because of
SO_TXTIME. But a boolean will do.

Plus, a netdevice_notifier in FQ to clear q->offload_horizon
- when this feature flips to off or
- when dev->max_pacing_hardware_offload changes to a value smaller
  than then configured q->offload_horizon (e.g., on device reset).

> +static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
> +				      const struct idpf_tx_queue *tx_q,
> +				      struct idpf_tx_splitq_params *tx_params)
> +{
> +	const int offload_slack_ns = 400;
> +	u64 ts, now, horizon;
> +
> +	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);
> +	if (!horizon)
> +		return;
> 
>    -> which already functions as a boolean, hence my suggestion of boolean
> 
> > > In fact any non-zero value of
> > > the device one acts the same - hence the bool question.
> > >
> > >
> > > Why do we need both? How are you going to use this new knob?
> > > The commit msg explains the what not the why.
> > > 
> > > My naive understanding is that the main missing piece is a handshake
> > > between the driver and qdisc to tell the driver that the qdisc is
> > > indeed offloading pacing on queue X. And therefore the driver should
> > > pay attention to the timestamps. This does not require uAPI changes.
> > >   
> > > >  python3 tools/net/ynl/pyynl/cli.py \  
> > > 
> > > uber-nit: python3 tools/net/ynl/pyynl/cli.py -> ynl
> > > (the CLI is named ynl when packaged for end users)  
> > 
> > Should this also then point to the (default) installed spec path:
> > 
> >        ynl --spec /usr/local/share/ynl/specs/rt-link.yaml 
> 
> Use:
> 
>   ynl --family rt-link
> 
> The expectation is that the person copy/pasting from the commit message
> already has the kernel and user space updated to include your changes.
> Also it's easier to read the shorter format..

Will do. Definitely a lot cleaner.
