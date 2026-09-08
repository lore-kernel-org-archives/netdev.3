Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A7549382
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875401; cv=none; b=P68ijD50q6NID7v1rlo09wB3rxvafYuiZ/v0K18+lEVmaCJr86/DUwQyd30a/rJitQZZApJ95W/fPjLO2yized/V5nrTDIHrrh5ncBhPjlWqB9y+xPQJlWkQBy2007XVI/5ql6NH9Tqs4UbSWjnmF9BYMW56MgxyA4aa9aYfPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875401; c=relaxed/simple;
	bh=ivgoK4PdARDnWtOv68lsyVWATqKAyFBgRinajTq7XOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoqR/BQRbCoc/trxbEzx6xZTFF2GLW1G+R/Zb3JHQE68Z5LghmVmgSFfbl0vJ4ahRSo/IU3pyW05hh7xCbNIgDUq4DBIFoFSv6A0VXVFltaOCrq5RCqNgUl8xf4IZBNKZRKOKyeuobSBN1xG1qCq0wm6uh3WWuw3U5MfWgjuZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjcnccdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjcnccdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFA51F00A3A;
	Tue,  8 Sep 2026 13:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788875385;
	bh=w8kzWLALhsbdQD3m28BU/Wq3NkCvRI1faK5Tz8hfzuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cjcnccdIVGK3RfydycfM4V4HJGPW5z+ZkhAVfzdc77PRIsyxPbTufc+FWEIA3Ey3y
	 fpS0SUBUSDowoqCaQmQy1xaZg3cCXrLrgtueszESrr1eJsXebhN2uKyfEjyXAAjK1l
	 lr+EClHElvItsceiXyQauD7DZTUYo02BYr/KAuDlEeyi9TIqEHKduE6povkhEeMqpx
	 fb9dV5qFyHIxwLlM5HNoLYid0LKx2FlK/Uya4o6ehs/YTx0pVgp59lamfeA+0pJwNS
	 6bHr14kUYX/9aTZe+ZDiVuup+9ETn6QoXrBYFkX00ZqAofvSpM5RhUVGhnFuJ/B/Ve
	 JiFZhH8jYABag==
Date: Tue, 8 Sep 2026 14:49:42 +0100
From: Simon Horman <horms@kernel.org>
To: Wong Boon Jhee <wongboonjhee52@gmail.com>
Cc: netdev@vger.kernel.org, sam@mendozajonas.com
Subject: Re: [PATCH v4] net/ncsi: Fix Use-After-Free in NCSI channel and
 package removal
Message-ID: <20260908134942.GZ40544@horms.kernel.org>
References: <20260905145902.345090-1-wongboonjhee52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905145902.345090-1-wongboonjhee52@gmail.com>

On Sat, Sep 05, 2026 at 10:59:02PM +0800, Wong Boon Jhee wrote:
> In net/ncsi/ncsi-manage.c, ncsi_remove_channel() and
> ncsi_remove_package() remove objects from an RCU-protected linked list
> using list_del_rcu() and immediately free them using kfree().
> 
> Because there is no call to synchronize_rcu() or kfree_rcu(), concurrent
> readers traversing these lists under rcu_read_lock() (such as Netlink
> dump handlers) can still hold a valid pointer to the object. When kfree()
> executes, the reader is left holding a dangling pointer to freed memory,
> resulting in a slab-use-after-free.
> 
> This patch fixes the issue by implementing a proper kref and RCU lifetime
> model for NCSI objects. It replaces kfree() with kfree_rcu() / call_rcu()
> to defer memory freeing until all pre-existing RCU readers have finished
> their critical sections. It also introduces a kref for ncsi_dev_priv to
> prevent the device structure from being freed while netlink handlers are
> still operating on it. Concurrent lockless readers are now explicitly
> protected with rcu_read_lock().
> 
> RCU read-side critical sections are added around lockless package and
> channel traversals that may race with object removal. The KASAN
> reproducer no longer reports the slab-use-after-free.
> 
> Fixes: 2d283bdd079c ("net/ncsi: Resource management")
> Signed-off-by: Wong Boon Jhee <wongboonjhee52@gmail.com>
> ---
> v3 -> v4:
> - Reworked NCSI object lifetime to pin the underlying net_device using
>   dev_hold()/dev_put() inside ncsi_dev_get()/ncsi_dev_put(), preventing
>   UAF if the driver unbinds while netlink handlers are active.
> - Moved package/channel destruction and request sweeping into the
>   ncsi_dev_release() kref callback to guarantee all asynchronous
>   producers are fully stopped before teardown begins.
> - Fixed pre-existing get_net() namespace leaks in all netlink handlers.
> - Fixed RCU lock leaks on early returns in ncsi_check_hwa() and
>   ncsi_set_channel_mask_nl().
> - Unified channel_queue semantics by removing incorrect RCU usage and
>   protecting traversals with ndp->lock.
> - Extracted channel IDs inside the RCU read section in
>   ncsi_update_tx_channel() to prevent pointer escapes.
> - Fixed memory corruption in ncsi_vlan_rx_kill_vid() by using a
>   temporary pointer for the freed VLAN object.
> 
>  net/ncsi/internal.h     |   8 +-
>  net/ncsi/ncsi-aen.c     |   2 +
>  net/ncsi/ncsi-manage.c  | 260 +++++++++++++++++++++++++++++++---------
>  net/ncsi/ncsi-netlink.c |  69 ++++++++---
>  net/ncsi/ncsi-rsp.c     |  17 ++-

Hi Wong Boon,

I am concerned that as a fix this patch is quite large and complex.  And on
the current course likely to be come more so in order to address concerns
such as those raised by AI-generated review here:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260830064337.327128-2-wongboonjhee52%40gmail.com

It does seem to me that while the architectural direction this patch is
taking is the right long term solution. But, given it's complexity, I
wonder if it would be best to implement a simpler fix for the bug, and then
follow-up with the architectural changes.

Reviewing the problem described in the patch description, I see that
ncsi_remove_channel() and ncsi_remove_package() are only called during
device tear-down. So I wonder if focussing on tear-down would lead us to a
simpler bug-fix.

For example in ncsi_unregister_dev: stop the producers; flush the readers
using synchronize_rcu() and then flush all the callbacks using rcu_barrier().

I'm no fan of synchronize_rcu(), but this may lead to a far more compact
and thus less risky bug-fix.

LMKWYT
