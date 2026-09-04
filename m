Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915513BB40
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562869; cv=none; b=uZrOi/sqSUOJIsQ+nJkdCVBxsGBhYaSSDobQxmhC3LC3pCjNRVKXeEA5oalLReel8Y0MQZZC1vcczuCEP3ro27i94gjYI6xJ8zRuYIVvLZr8ZK1GRYULbCWoCZTPCh/vd1Pd0LSo288vk7pFUseC4oXXf37aJ5djFtr2QF94TD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562869; c=relaxed/simple;
	bh=e2U5ud0mkMnQRgIXafS8d7Vpi76p3vb1xtXcY4b5eFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHvLG9YsZnjuFRg4XnnzcYVX53gJ7mCn4D0ld2PgCw+n4NuNW4l9IQ6ToPeHa+A24FhlHw4q7MSbVh949KDVb5fjrkTdE0k1oW4OBc7YGdEoIpdBDZFUKMLcvOnCbyG5D43BBba196xYATTDMO9ixIcbUK4XqWXYbIcNP1BDcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCAtlWRC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCAtlWRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735F81F00A3D;
	Fri,  4 Sep 2026 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788562868;
	bh=KSI0e/lEtQcZ8qkH34rDYDnw9Jdey6r2iU99XTGuYtY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RCAtlWRCjcGq5ycCEz/1UKHe78rLP/ZtGepesRQyPXUSGV/CuGB6xK0HmgAusWlrL
	 VQe9iBIgW//6peGrmozoQ7Ubv90i6AnkmDY8GFGAOcPoT5JkhvtR0MO25Z6nMgQNFf
	 PMV6xkTlcW5KzWrDx7GGqwKrBHIXQLCRJTi9TD/mY2n1cmRteEUF/KxMqTFZDRhjdd
	 dE1RvvivMuWrNu3KXNc+rxQ+MJxRCztTRDGx2HXMfoDhviglxi6e07hz2ZuBtQaBNg
	 cq7QJEdfxZ96eU+92R55SAM+wCDb2X12aLeHdCysIXfMg5rq2jjT1DoQbUZ08owKmO
	 avleUW7l6WVBA==
Date: Fri, 4 Sep 2026 16:01:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
Message-ID: <20260904160106.08acccb5@kernel.org>
In-Reply-To: <20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
	<20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Swapping in the conversation from v6, sorry, not sure why I missed your
reply..

On Mon, 17 Aug 2026 22:44:30 -0400 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Wed, 12 Aug 2026 22:03:56 -0400 Willem de Bruijn wrote:  
> > > The 'max_pacing_offload_horizon' field of 'struct net_device' represents
> > > the maximum pacing offload horizon supported by the device.
> > > 
> > > Add a new field 'pacing_offload_horizon' to store the active pacing
> > > offload horizon.
> > > 
> > > The new attribute is initialized to 0 (disabled) and can be set from
> > > userspace via RTM_SETLINK up to dev->max_pacing_offload_horizon. This
> > > new default off behavior does not cause regressions, as no driver yet
> > > advertises max_pacing_offload_horizon.
> > > 
> > > The attribute is omitted from the newlink request spec, because the
> > > value may need to be bound by a device maximum that first needs to be
> > > negotiated with firmware, as is the case for the idpf driver in this
> > > series.
> > > 
> > > Make both fields u32, to maintain net_device cacheline layout. This
> > > expresses up to 4s of pacing offload, which is sufficient.
> > > 
> > > Update the YNL specification ('rt-link.yaml') to add the
> > > 'pacing-offload-horizon' attribute and include it in link-all-attrs.  
> > 
> > Forgive my slowness but I don't get how the new param squares against
> > TCA_FQ_OFFLOAD_HORIZON. IIRC in v5 review I asked something like "should 
> > this new option be a boolean" because the exact time horizon already
> > exists in the qdisc uAPI. As AI points out (among other things),
> > the two params are not synced in anyway. User can configure qdisc
> > offload higher than the device level one.  
> 
> They cannot. Or at least that sure is the intent.
> 
> After this patch fq tests against active limit
> dev->pacing_offload_horizon:
> 
> -               if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
> +               if (offload_horizon <=
> +                   READ_ONCE(qdisc_dev(sch)->pacing_offload_horizon)) {
>                         WRITE_ONCE(q->offload_horizon, offload_horizon);
> 
> A manual test to replace the root qdisc with fq offload_horizon 50ms
> seems to verify this: the command fails unless a device limit of >= 50ms
> is configured.

The other way around. Configure the Qdisc and device to horizon of 100ms
Then lower the device horizon to 50ms. Now the qdisc has a longer horizon
than the device.

> Perhaps I don't understand how dev->pacing_offload_horizon
> would function as a boolean.

The only uses of the new value are:
 - as the qdisc bound, replacing the max_ value
   -> Leave the qdisc as is, let qdisc config define the active horizon
 - in the driver

+static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
+				      const struct idpf_tx_queue *tx_q,
+				      struct idpf_tx_splitq_params *tx_params)
+{
+	const int offload_slack_ns = 400;
+	u64 ts, now, horizon;
+
+	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);
+	if (!horizon)
+		return;

   -> which already functions as a boolean, hence my suggestion of boolean

> > In fact any non-zero value of
> > the device one acts the same - hence the bool question.
> >
> >
> > Why do we need both? How are you going to use this new knob?
> > The commit msg explains the what not the why.
> > 
> > My naive understanding is that the main missing piece is a handshake
> > between the driver and qdisc to tell the driver that the qdisc is
> > indeed offloading pacing on queue X. And therefore the driver should
> > pay attention to the timestamps. This does not require uAPI changes.
> >   
> > >  python3 tools/net/ynl/pyynl/cli.py \  
> > 
> > uber-nit: python3 tools/net/ynl/pyynl/cli.py -> ynl
> > (the CLI is named ynl when packaged for end users)  
> 
> Should this also then point to the (default) installed spec path:
> 
>        ynl --spec /usr/local/share/ynl/specs/rt-link.yaml 

Use:

  ynl --family rt-link

The expectation is that the person copy/pasting from the commit message
already has the kernel and user space updated to include your changes.
Also it's easier to read the shorter format..

