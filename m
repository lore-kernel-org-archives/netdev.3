Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC133BFE42
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153493; cv=none; b=UOgUipQpc+mGQQrZfigcMZCKzO1gl7JGED0CNbk287U5IDPE9P82UrWIQDVe6sntpsl9BWRZqDFV06nvBwIMzsINrrcHl+Z/s0RxrvUqANf3oYlmZNlBSUEsdxmEXb6tlKupUQ8WwAajunrZ0Lu1mH9N4I5GLnrWUeIGm7qgKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153493; c=relaxed/simple;
	bh=rYJMS4o6b5/cMnYPf22M8gMEK9H2Nko0D6IHlPtRChE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaLRWTorJ+bqWRKzf6tu8HWVolw8P7l2Ve6VTbxrXLZYq8eAe3zBR/+Kz8EBMXzWKlEYf5bmf3xClhX1ynHttyN7Kjq5Y81uc6F1EwUNER3+l+pBwx4tYs4NUoF65KgPeX+tI27Yf9eFRIy3DgEwuWnVIjdBR8sqOaLSRll0+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZedUE8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZedUE8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD421F000E9;
	Wed, 19 Aug 2026 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153491;
	bh=q1YXb0DOdApJVq5eL8myBWPjrVzx+2F9Uw/eqwaUskM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XZedUE8Gq5VL3anjQVsWVXAQSJ9bZyJ5GuHSodFSb8QTulE62TOB8/cPIsjoqcl5y
	 oU00SYLM+ymnyhhAqWR1o++rrKoDEUZlZWY2HxoKuSyH5NrkCgAlNqWwdQNmvOJl+g
	 Fr3xJfDIh93l1vj0ltyAJmpWegGc2K1HqnXzYNgcj0d/XWOEg+GxZC0CEPblEDpYai
	 pm7G5403DCBoqH79JB9FHt/L9C8BvfZ2W+2bEeXthjx3r1HqO8nQw52du0FnSWpwMe
	 9XUU+aVtaRh0t+g+tHztLXuIpHsCv9taViGtdu6xFPsccedbD/8ouwc6bXS4oVq+Tq
	 rye0FnNYC73+A==
From: Simon Horman <horms@kernel.org>
To: wongboonjhee52@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net/ncsi: Fix Use-After-Free in NCSI channel and package removal
Date: Wed, 19 Aug 2026 16:31:22 +0100
Message-ID: <20260819153122.752138-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816084403.295808-1-wongboonjhee52@gmail.com>
References: <20260816084403.295808-1-wongboonjhee52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260816084403.295808-1-wongboonjhee52@gmail.com?part=1
---
--- Patch [1]: [PATCH net v2] net/ncsi: Fix Use-After-Free in NCSI channel and package removal ---
commit 561a5dfe41dc86345568df7d58a77bbfbca0c53d
Author: Wong Boon Jhee <wongboonjhee52@gmail.com>

net/ncsi: Fix Use-After-Free in NCSI channel and package removal

The patch replaces kfree() with kfree_rcu() in ncsi_remove_channel() and
ncsi_remove_package(), and adds a struct rcu_head to struct ncsi_channel
and struct ncsi_package so the objects unlinked from the RCU-protected
package and channel lists are only reclaimed after a grace period.

A few questions on the change below.

> diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> index adee6dcabdc3f..19785ca2392ae 100644
> --- a/net/ncsi/internal.h
> +++ b/net/ncsi/internal.h
> @@ -239,6 +239,7 @@ struct ncsi_channel {
>  	} monitor;
>  	struct list_head            node;
>  	struct list_head            link;
> +	struct rcu_head             rcu; /* RCU cleanup */ 
                                                        ^

[Severity: Low]
[Finding: main-1-3]
[Sources: opus-5]
This isn't a bug, but both of the new struct members carry trailing
whitespace after the comment terminator, in struct ncsi_channel and in
struct ncsi_package below. scripts/checkpatch.pl reports "ERROR: trailing
whitespace" for both lines. Could they be resent without the trailing
space?

>  };
>  
>  struct ncsi_package {
> @@ -253,6 +254,7 @@ struct ncsi_package {
>  	bool                 multi_channel; /* Enable multiple channels  */
>  	u32                  channel_whitelist; /* Channels to configure */
>  	struct ncsi_channel  *preferred_channel; /* Primary channel      */
> +	struct rcu_head      rcu; /* RCU cleanup */ 
>  };

[Severity: High]
[Finding: gpt-5-6-sol-1-4]
[Sources: gpt-5-6-sol, opus-5]
The changelog says:

  "To support this, a struct rcu_head has been added to struct
   ncsi_channel, struct ncsi_package, and struct ncsi_dev_priv."

but the diff only touches struct ncsi_channel and struct ncsi_package.
struct ncsi_dev_priv has no rcu member after this patch. Should the
changelog be corrected, or was a third hunk intended?

Related to that, and not a bug introduced by this patch: ndp is freed with
the exact pattern the changelog calls a use-after-free. In
ncsi_unregister_dev():

	spin_lock_irqsave(&ncsi_dev_lock, flags);
	list_del_rcu(&ndp->node);
	spin_unlock_irqrestore(&ncsi_dev_lock, flags);

	disable_work_sync(&ndp->work);

	kfree(ndp);

ndp is published on ncsi_dev_list and traversed by ncsi_find_dev() through
NCSI_FOR_EACH_DEV(), which expands to list_for_each_entry_rcu().
ndp_from_ifindex() then drops the net_device reference with dev_put() and
hands the raw ndp to the netlink handlers, which sleep in
genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL) while still holding it.

Since ncsi_remove_package() and ncsi_remove_channel() are only reached from
ncsi_unregister_dev(), isn't the window in which a channel or package is
freed the same window in which ndp itself is freed? If so, does the claim
that the fix "completely eliminates the crash" hold?

There is also an asymmetry now: packages and channels survive a grace
period while their owner ndp is freed synchronously, so np->ndp and
nc->package->ndp are guaranteed dangling for anything that observes a child
object during that grace period.

>  
>  struct ncsi_request {
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..368085627807b 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -263,7 +263,7 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
>  	np->channel_num--;
>  	spin_unlock_irqrestore(&np->lock, flags);
>  
> -	kfree(nc);
> +	kfree_rcu(nc, rcu);

[Severity: High]
[Finding: gpt-5-6-sol-5-23]
[Sources: gpt-5-6-sol, opus-5]
The changelog says the readers are "concurrent readers traversing these
lists under rcu_read_lock() (such as Netlink dump handlers)". Do such
readers exist in net/ncsi?

git grep rcu_read_lock net/ncsi/ only matches the ndp->vlan_vids loop in
ncsi_configure_channel(); there is no rcu_read_lock() anywhere in
net/ncsi/ncsi-netlink.c. The iteration macros in net/ncsi/internal.h only
expand to the list primitives:

	#define NCSI_FOR_EACH_DEV(ndp) \
		list_for_each_entry_rcu(ndp, &ncsi_dev_list, node)

so ncsi_find_dev(), ncsi_write_package_info(), ncsi_write_channel_info(),
ncsi_pkg_info_nl() and ncsi_pkg_info_all_nl() load np/nc/ndp outside any
read-side critical section, and even sleep in genlmsg_new(..., GFP_KERNEL)
while holding those pointers.

If the reader is not in a read-side section, every one of those sleep or
preemption points is a quiescent state, so a full grace period can elapse
and the kfree_rcu() callback can run before the reader dereferences the
pointer. Does this change actually close the race, or does it only widen
the window? Would adding rcu_read_lock()/rcu_read_unlock() around those
traversals (or another form of exclusion against the removal path) be the
part that is missing here?

[Severity: High]
[Finding: gpt-5-6-sol-1-5]
[Sources: gpt-5-6-sol, opus-5]
This is a pre-existing issue, but the deferral makes the exposure longer.
Earlier in ncsi_remove_channel(), before list_del_rcu(&nc->node) runs, the
sub-allocations are released synchronously:

	/* Release filters */
	kfree(nc->mac_filter.addrs);
	kfree(nc->vlan_filter.vids);

Both pointers are left non-NULL, and vlan_filter.n_vids and
vlan_filter.bitmap are left untouched. With the channel itself now retained
for a grace period, an observer holding nc sees a live-looking object with
dangling inner pointers.

ncsi_write_channel_info() in net/ncsi/ncsi-netlink.c walks those members
with no nc->lock:

	ncf = &nc->vlan_filter;
	i = -1;
	while ((i = find_next_bit((void *)&ncf->bitmap, ncf->n_vids, i + 1))
	       < ncf->n_vids) {
		if (ncf->vids[i])
			nla_put_u16(skb, NCSI_CHANNEL_ATTR_VLAN_ID, ncf->vids[i]);

ncsi_rsp_handler_gc() sets ncf->bitmap = U64_MAX and ncf->n_vids =
rsp->vlan_cnt, so the loop condition stays true after ncf->vids has been
freed. Can this read the freed array and copy its contents into
NCSI_CHANNEL_ATTR_VLAN_ID? NCSI_CMD_PKG_INFO has no GENL_ADMIN_PERM, so the
reader side is unprivileged.

Would freeing the filter arrays from the RCU callback together with the
channel, or NULLing the pointers and clearing n_vids/bitmap under nc->lock
after unlinking, be preferable?

As a side note on the evidence in the changelog: "KASAN confirms the freed
object belongs to the kmalloc-96 cache". struct ncsi_channel embeds caps[],
modes[], stats and a timer and is much larger than 96 bytes, while
mac_filter.addrs is kzalloc((uc_cnt + mc_cnt + mixed_cnt) * ETH_ALEN,
GFP_ATOMIC) in ncsi_rsp_handler_gc(). Is the object being deferred here the
same object as in the reported splat?

[Severity: High]
[Finding: main-2-7]
[Sources: opus-5]
This isn't a bug introduced by this patch, but the object handed to
kfree_rcu() here is still linked into a second RCU-traversed list. Channels
are queued with list_add_tail_rcu(&nc->link, &ndp->channel_queue) in
ncsi-manage.c and ncsi-aen.c, and are dequeued only by
list_del_init(&nc->link) in ncsi_process_next_channel() and
ncsi_reset_dev(). ncsi_remove_channel() unlinks only &nc->node from
np->channels and never dequeues &nc->link under ndp->lock.

ncsi_process_next_channel() then pops and writes to that entry:

	nc = list_first_or_null_rcu(&ndp->channel_queue,
				    struct ncsi_channel, link);
	...
	list_del_init(&nc->link);
	...
	nc->state = NCSI_CHANNEL_INVISIBLE;
	...
	ndp->active_channel = nc;
	ndp->active_package = nc->package;

and ncsi_channel_is_tx()/ncsi_choose_active_channel() walk it with
list_for_each_entry_rcu(channel, &ndp->channel_queue, link).

Because ncsi_unregister_dev() calls disable_work_sync(&ndp->work) only
after the removal loop, ncsi_dev_work() can still run here. Can
ncsi_process_next_channel() do list_del_init() and the nc->state store on a
channel that has already been reclaimed by the RCU callback, corrupting
ndp->channel_queue?

Also, ndp->hot_channel, ndp->active_channel, ndp->active_package and
np->preferred_channel are plain back-pointers that are never cleared on
removal, so the grace period does not cover them either.

>  }
>  
>  struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
> @@ -326,7 +326,7 @@ void ncsi_remove_package(struct ncsi_package *np)
>  	ndp->package_num--;
>  	spin_unlock_irqrestore(&ndp->lock, flags);
>  
> -	kfree(np);
> +	kfree_rcu(np, rcu);

[Severity: High]
[Finding: gpt-5-6-sol-4-17]
[Sources: gpt-5-6-sol, opus-5]
This is a pre-existing ordering issue rather than something this patch
introduces, but it affects whether the deferral helps. ncsi_unregister_dev()
tears state down before it stops its asynchronous users:

	dev_remove_pack(&ndp->ptype);

	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
		ncsi_remove_package(np);

	spin_lock_irqsave(&ncsi_dev_lock, flags);
	list_del_rcu(&ndp->node);
	spin_unlock_irqrestore(&ncsi_dev_lock, flags);

	disable_work_sync(&ndp->work);

	kfree(ndp);

Since disable_work_sync() runs after the removal loop, can a queued or
running ncsi_dev_work() -> ncsi_probe_channel()/ncsi_suspend_channel()/
ncsi_configure_channel() still operate on ndp->active_package,
ndp->active_channel or ndp->hot_channel, which the removal path never
clears? Should disable_work_sync() precede the removal loop?

Separately, ndp->requests[] embeds 256 timers set up with
ncsi_request_timeout() in ncsi_register_dev(), and ncsi_xmit_cmd() arms
them:

	nr->enabled = true;
	mod_timer(&nr->timer, jiffies + 1 * HZ);

ncsi_unregister_dev() never walks the request table to disarm those timers
or release outstanding requests before kfree(ndp). If a command is in
flight when the driver unregisters, can ncsi_request_timeout() fire on the
freed ndp and dereference nr->ndp, ndp->lock and the already-freed
package/channel lists via ncsi_find_package_and_channel()?

>  }
>  
>  void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
