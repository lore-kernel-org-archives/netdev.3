Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A6D328B7B;
	Wed, 14 Oct 2026 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965952; cv=none; b=ZyEL9Bvl3j0fDcIb63xWGbPIZjb9/XlYFITAcuf0wT3BDchcPYejU7/V50lwDvuI9Z+9K2Jdmf8mpywkxrTTmid4HRJw+02X+xGyXizHrtdWLzF9D2osNiC4njqwLXFXuJL+/2rMC7yC8DpoQt1c/4bkqGdO4MNqp2Qdj3JM2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965952; c=relaxed/simple;
	bh=MOTXdEXKbLS6PTHDQsxFNQj1jdGYsDtIQ4OmMQvYfeo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qCF/0JsOX1FqrHAS2BUly67MyjAahR6Ul+ERNA3aDgIbEWQYQW7Fd0bP1IvGe7U3Ie8zF8LBRPjHOyoNDfy8aLsGAWkCaALsJPpqMSnvznqxm+j2ufnJ0UpvZ34vK5F+pdnjw/7hFV7785LAFDRSjpB3XfjE3iHYErzR94qN0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQi8pTZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQi8pTZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFB71F000FF;
	Wed, 14 Oct 2026 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791965948;
	bh=3KS4ev/rtlfIGYSsC3d7hX48ktuhT+vRtKtrFW4p6P8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YQi8pTZLILL0/KdmeKQ9Ke/y0va2/4m5xjdSaE0hwpwPNO610tmzhCKSxjYQdmi0B
	 /K4Ni4hTDKuwJpfhpg3qBAVDQ7tiL4ImSmUMwk7s9+O92/EHtd964MyV6BR0MXkMAu
	 uR73QW54v4cnUZsANwy0AWTbhkJ8RfAdI4Od5IzUoM8nFysMlx8x3mEDdYJAezWU5G
	 qIJQXW+Lu+HGf/cRQCLowy5ptkkMG0mgOgvTF1qyIURK63ahjlP2uT+giRqT/NGC1p
	 LGd1cw4MqVBFMp+y2d8//IrPYVqoUe4Vh8KtVmovGX7JxfRu3H6vYQjK2/X/Z+ZNJ1
	 P5AqFvRXVi7Ow==
Subject: Re: [PATCH net v2 2/3] xfrm: iptfs: run the receive callbacks before
 freeing the skb
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 08:19:07 +0000
Message-ID: <179196594727.434549.2968330822013273555@kernel.org>
In-Reply-To: <20261013074610.17808-3-q.h.hack.winter@gmail.com>
References: <20261013074610.17808-3-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch converts only some of the IPTFS paths that free the
  outer ESP skb, so the bug its commit message describes is still…
- [High] xfrm_input_drop() now runs the per-protocol receive callbacks on
  outer IPTFS skbs that may have been parked in the reorder window.
- [Medium] xfrm_input_drop() always calls xfrm_rcv_cb() with err = -1.
- [Low] The commit message says the receive callbacks must run because
  "whatever they cached in the skb control buffer is never cleaned up".

--

xfrm: iptfs: run the receive callbacks before freeing the skb

This patch adds xfrm_input_drop(). It runs the protocol receive callback
with err = -1 and then frees the skb. The patch uses it in three places
where IPTFS frees the outer skb: __input_process_payload(),
iptfs_input_ordered() and the reorder-window freelist in iptfs_input().

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index ddf8fd75fd207..f293d5e124d47 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -120,6 +120,25 @@ static int xfrm_rcv_cb(struct sk_buff *skb, unsigned int family, u8 protocol,
>  	return ret;
>  }
>  
> +/* Finish an skb that is freed outside of xfrm_input()'s own drop path, e.g.
> + * from IPTFS.  The receive callbacks must still run before the skb goes away.
> + */

[Severity: Low]
The commit message says the callbacks need to run because "whatever they
cached in the skb control buffer is never cleaned up". Is that accurate at
this commit?

None of the cb_handlers release anything when err is nonzero.
vti_rcv_cb(), vti6_rcv_cb() and xfrmi_rcv_cb() only bump rx_errors and
rx_dropped. esp4_rcv_cb() and esp6_rcv_cb() just return 0:

net/ipv4/ip_vti.c:vti_rcv_cb() {
    ...
	if (err) {
		DEV_STATS_INC(dev, rx_errors);
		DEV_STATS_INC(dev, rx_dropped);

		return 0;
	}
    ...
}

A later patch in the series, "xfrm: transfer the skb->dev reference to the
input path", adds dev_hold() in vti_input()/vti6_input_proto() and
dev_put() in these err branches. Once that patch is applied, the
description is accurate.

This patch carries Fixes: and Cc: stable. If it were backported without
that follow-up, its only effect would be on device drop accounting. Could
the commit message mention the dependency, or be reworded?

> +void xfrm_input_drop(struct sk_buff *skb)
> +{
> +	struct sec_path *sp = skb_sec_path(skb);
> +	struct xfrm_state *x;
> +
> +	if (!sp || !sp->len) {
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	x = sp->xvec[sp->len - 1];
> +	xfrm_rcv_cb(skb, x->props.family, x->type ? x->type->proto : 0, -1);

[Severity: Medium]
err is always -1 here, whatever the reason the skb is being freed.

In __input_process_payload(), the else if (!first_skb) branch is reached
after real errors. It is also reached after valid outer packets that were
fully consumed without starting a new inner packet. One example is a
pad-only payload:

net/xfrm/xfrm_iptfs.c:__input_process_payload() {
    ...
		} else if (iph->version == 0x0) {
			/* pad */
			data = tail;
			break;
    ...
}

Two other valid cases also end with first_skb == NULL:

- A continuation-only payload, such as the middle fragment of a large
  inner packet. Here iptfs_reassem_cont() returns data + fraglen == tail.
- A payload whose only new data is a runt saved by
  iptfs_input_save_runt().

For these valid packets, will vti_rcv_cb(), vti6_rcv_cb() and
xfrmi_rcv_cb() take their err branch and bump rx_errors and rx_dropped on
the vti/vti6/xfrm interface? Before this patch, these paths ran no
callback.

The later patch in the series still passes -1 here, so the counts would
still be wrong at the end of the series.

> +	kfree_skb(skb);
> +}
> +EXPORT_SYMBOL(xfrm_input_drop);

[ ... ]

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 6920940a35b49..4b3d04e531a51 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -1211,7 +1211,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
>  		 * either be save in ra_newskb, trimmed and sent on as an skb or
>  		 * placed in defer to be freed.
>  		 */
> -		kfree_skb(skb);
> +		xfrm_input_drop(skb);

[Severity: High]
This converts the !first_skb branch. Does the branch next to it still free
the outer skb without running the callbacks?

	if (defer) {
		consume_skb(defer);
	} else if (!first_skb) {

defer is the outer root skb whenever the first inner packet can't reuse
it. That covers the skb_has_frag_list() case, the head_frag/fragwalk case
and the allocate-new fallback.

defer is also the reused outer skb when pskb_trim() fails:

		if (pskb_trim(first_skb, first_iplen)) {
			/* error trimming */
			list_del(&first_skb->list);
			defer = first_skb;
		}

In both cases the skb is freed by consume_skb(defer) and no callback
runs. The inner skbs come from iptfs_alloc_skb(), which zeroes cb, so no
callback ever sees the outer skb's cb.

Other outer-skb free paths also skip xfrm_rcv_cb():

- When the reused outer skb becomes xtfs->ra_newskb (first_skb_partial),
  it can be freed by iptfs_drop_timer() via kfree_skb_reason(skb,
  SKB_DROP_REASON_FRAG_REASM_TIMEOUT).
- It can also be freed by __iptfs_reassem_done() with free == true, via
  iptfs_reassem_abort().
- It can also be freed by iptfs_destroy_state().
- iptfs_destroy_state() frees the outer skbs still in xtfs->w_saved[] with
  plain kfree_skb().

The commit message says IPTFS "frees it directly on several paths, so the
receive callbacks ... never run". The new comment says "The receive
callbacks must still run before the skb goes away."

The last patch in the series adds dev_hold(tunnel->dev) in
vti_input()/vti6_input_proto(). It relies on vti_rcv_cb()/vti6_rcv_cb()
calling dev_put() on the error path, and it doesn't touch xfrm_iptfs.c.

At the end of the series, would each outer skb freed on these paths leak
a reference on the vti/vti6 net_device? Deleting the device or its netns
would then hang in netdev_wait_allrefs().

>  	}
>  	return true;
>  }
> @@ -1298,7 +1298,7 @@ static void iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
>  	if (!consumed) {
>  		skb = skbseq.root_skb;
>  		skb_abort_seq_read(&skbseq);
> -		kfree_skb(skb);
> +		xfrm_input_drop(skb);

[Severity: High]
iptfs_input_ordered() also processes outer skbs that
__reorder_future_fits() and __reorder_future_shifts() parked in the
reorder window. They are drained later, either from another softirq or
from the iptfs_drop_timer() soft hrtimer:

iptfs_drop_timer()
    iptfs_input_ordered()
        __input_process_payload() / !consumed
            xfrm_input_drop()
                xfrm_rcv_cb()
                    xfrmi_rcv_cb()

Nothing holds a reference on skb->dev or on the cached
XFRM_TUNNEL_SKB_CB()->tunnel while the skb is parked. With synchronous
crypto, xfrm_input() calls dev_put(dev) right after x->type->input()
returns -EINPROGRESS.

xfrmi_rcv_cb() dereferences skb->dev before it checks err:

net/xfrm/xfrm_interface_core.c:xfrmi_rcv_cb() {
    ...
	link = skb->dev->ifindex;
	dev = xi->dev;
	skb->dev = dev;

	if (err) {
    ...
}

If the ingress netdev is unregistered while the skb sits in w_saved, can
this read a freed net_device? IPTFS has no netdev notifier, and
unregistering the device doesn't flush w_saved. Before this patch, these
paths only called kfree_skb(), which doesn't dereference skb->dev.

At this commit, vti_rcv_cb()/vti6_rcv_cb() also call DEV_STATS_INC()
through tunnel->dev without holding a reference. If the vti device was
deleted in the meantime, that would write to freed memory.

The later patch "xfrm: transfer the skb->dev reference to the input path"
fixes the vti part with dev_hold() in vti_input()/vti6_input_proto(). The
xfrmi_rcv_cb() case still looks open at the end of the series.

The success path, xfrm_input(skb, 0, 0, -2) -> dev_net(skb->dev), already
has the same dangling skb->dev problem. That part is pre-existing, but
this patch extends it to the drop paths.

The freelist in iptfs_input() only ever holds the current inskb, so that
hunk isn't affected.

>  	}
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013074610.17808-1-q.h.hack.winter%40gmail.com
