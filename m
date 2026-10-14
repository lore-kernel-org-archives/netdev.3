Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8195326939;
	Wed, 14 Oct 2026 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965951; cv=none; b=eDmfRwJVQ8MvFUF9RwHSN63JL1cTvFfLzj3x5TDm6jDUF0K3gR2wYCBOmlW6gcvzK6cujhNnEWmp3hltUOqIAfVZuwb5dyf4k2zWtbeHZNxA0pfZYU2Bwzs4TwfYTsDvGjI7HB2Yy7p+/8h8xjJcx9pWjBfusQSa26RZgoyLVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965951; c=relaxed/simple;
	bh=SjSJw6pCZOUJ2X1r7t82P0Ce4PxeltY7O18RlWItVf8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glfjn32wYwCSagw4e02JRHO/cWuof/eFG3r3+u9Dg7QsVdso1P0mMUD2AAss0O3BjTYf3peHv94f6qnhru7vYJdzHvPeooM61zjZsBmlISFsrXNR3fVKAMvPByAysl6/ChhzQ3YI/a8vR+OEKZQ4yTD47lp8BZJi7GTTExkdVnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd6ey+Eu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd6ey+Eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA201F00893;
	Wed, 14 Oct 2026 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791965947;
	bh=vZRN8NGEDolZMnq7JpZse7Ya9jmA+E9xdQtZneRt9VE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zd6ey+EuUCm9L1iMT2+ExQeNLBEczm5dU2aenYH0LgmivkV+z4LPFmDW3SpZ2NE5n
	 4lirQDBlApEwswzXSIqCOvVJNWfnRYQr1bE1pYSirnmgI9ht0tgavMJBPTj0p5TewY
	 ORCSILL3Flne3i+7G5iHjF4804L2gXRUDkul7hqh/2qs0F2XyJ5s2/t4EZIXVMjbd+
	 0mIdO+KmJGs208QCeVmImJ4SZulppG/hanM0nyeJfM5Fr/bvMfe+mYv7MLPmq3VmRE
	 9SC7z6zqIS6F40+ytgHqwfpVkLBWFnp1AMCaveImwLXvq4pS+vbGjdFgVDejLQ7gDF
	 CY4a90nEQ7jMg==
Subject: Re: [PATCH net v2 1/3] xfrm: set the address family before the early
 invalid-state drop
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 08:19:05 +0000
Message-ID: <179196594590.434549.16209535905677172012@kernel.org>
In-Reply-To: <20261013074610.17808-2-q.h.hack.winter@gmail.com>
References: <20261013074610.17808-2-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes the early invalid-state drop in xfrm_input()
  (net/xfrm/xfrm_input.c) dispatch the receive callbacks.
- [Medium] The Fixes: tag points to 5f24f41e8ea6 ("xfrm: Remove
  inner/outer modes from input path", v6.4), but that commit did not…

--

xfrm: set the address family before the early invalid-state drop

This patch moves the family = x->props.family assignment in xfrm_input()
above the XFRM_STATE_VALID check. The early invalid-state drop then
reaches xfrm_rcv_cb() with a real family, not AF_UNSPEC, so the
per-protocol receive callbacks get called for these packets.

> Fixes: 5f24f41e8ea6 ("xfrm: Remove inner/outer modes from input path")

[Severity: Medium]
Is this the right commit for the Fixes: tag?

5f24f41e8ea6 only changed one line, from this:

    family = x->outer_mode.family;

to this:

    family = x->props.family;

That line was already after the invalid-state check.

The ordering that leaves family as AF_UNSPEC on the early drop seems to
come from 4ce3dbe397d7 ("xfrm: Fix xfrm_input() to verify state is valid
when (encap_type < 0)"). That commit added the AF_UNSPEC initialization
and put the "x->km.state != XFRM_STATE_VALID ... goto drop" block ahead
of the family assignment.

With the current tag, 6.1.y, 5.15.y and 5.10.y have the same early drop
but would not pick up this fix automatically.

A later patch in this series, "xfrm: transfer the skb->dev reference to
the input path", is tagged for all stable branches. In that patch,
vti_input() and vti6_input_proto() take dev_hold(tunnel->dev). It relies
on the receive callback to drop that reference on every drop path,
including this early one.

In a stable branch that gets that patch but not this one, the early drop
would skip vti_rcv_cb() and leak the tunnel device reference.
unregister_netdevice would then wait forever.

Should this be:

    Fixes: 4ce3dbe397d7 ("xfrm: Fix xfrm_input() to verify state is valid when (encap_type < 0)")

and also be marked as a prerequisite of the reference-transfer patch?

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 5ed87d51392a5..ddf8fd75fd207 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -487,6 +487,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  				      encap_type == UDP_ENCAP_ESPINUDP))) {
>  		x = xfrm_input_state(skb);
>  		xfrm_proto = x->type ? x->type->proto : nexthdr;
> +		family = x->props.family;
>  
>  		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
>  			if (x->km.state == XFRM_STATE_ACQ)

[ ... ]

> @@ -500,8 +501,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  			goto drop;
>  		}

[Severity: High]
On async resume (encap_type == -1), can this new callback dispatch touch
skb->dev after its device reference has been dropped?

On the first pass, xfrm_input() takes a reference before calling the
type's input handler. That reference is the only thing keeping skb->dev
alive while async crypto runs:

    dev_hold(dev);

    nexthdr = x->type->input(x, skb);
    if (nexthdr == -EINPROGRESS) {

When crypto completes, xfrm_input_resume() calls
xfrm_input(skb, nexthdr, 0, -1). The SA may have left
XFRM_STATE_VALID while crypto was running, for example through hard
expiry, XFRM_MSG_DELSA or a flush. In that case the early branch drops
the reference:

    if (encap_type == -1)
        dev_put(dev);
    goto drop;

The drop label then calls the callback:

    drop:
        if (async)
            dev_put(dev);
        xfrm_rcv_cb(skb, family, xfrm_proto, -1);

Before this patch, family was still AF_UNSPEC at this point. The afinfo
lookup failed and nothing touched skb->dev after the dev_put().

With family set, xfrm4_rcv_cb()/xfrm6_rcv_cb() now walk the handlers.
vti_rcv_cb() returns 1 when there is no tunnel, so the walk reaches
xfrmi_rcv_cb().

The resumed skb has a secpath, so the "err && !secpath_exists(skb)"
early return is not taken. If xfrmi_lookup() matches the SA's if_id,
this runs:

net/xfrm/xfrm_interface_core.c:xfrmi_rcv_cb() {
    ...
	link = skb->dev->ifindex;
    ...
}

At that point the last extra reference on that device has just been
dropped.

The rcu_read_lock() in xfrm_input_get_afinfo() does not seem to protect
this. netdev_wait_allrefs_any() goes ahead as soon as the refcount drops
to 1. netdev_release() then frees the device with kvfree() and does not
wait for an RCU grace period:

net/core/net-sysfs.c:netdev_release() {
    ...
	/* no need to wait for rcu grace period:
	 * device is dead and about to be freed.
	 */
	kfree(rcu_access_pointer(dev->ifalias));
	kvfree(dev);
}

The success path uses the safe order: callback under rcu_read_lock(),
then dev_put(dev). The commit message says the early drop now dispatches
the callback "like every other drop does". The drop label's order is
put first, then callback, so this patch adds a new reachable path with
that order.

The later patch "xfrm: transfer the skb->dev reference to the input
path" in this series fixes the vti/vti6 side of this. It adds
dev_hold(tunnel->dev) in vti_input() and vti6_input_proto(). It leaves
the early-branch dev_put() and the drop label's dev_put()-then-callback
order unchanged, so the xfrmi_rcv_cb() read of skb->dev->ifindex is
still reachable at the end of the series.

Would it work to let the drop label own the reference in the early
branch (for example, by setting async = 1 instead of calling dev_put()
directly)? The drop label could then call xfrm_rcv_cb() before
dev_put(dev).

> -		family = x->props.family;
> -
>  		/* An encap_type of -2 indicates reconstructed inner packet */
>  		if (encap_type == -2)
>  			goto resume_decapped;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013074610.17808-1-q.h.hack.winter%40gmail.com
