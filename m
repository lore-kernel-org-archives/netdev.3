Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A533937F;
	Mon, 21 Sep 2026 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959237; cv=none; b=sM4nX7CODGOI1w5tTT3ZhxlH2THu7mkW7WY/nBT8rys49epOTR26KpdA5ZZIPkecqZu9TlZ0FAfDQZy7qSV2kOjBcs560kbBGFsI5CXuCWbigFsMmggz1+XoiAhSjI6fVv+DjMl9GNW0oJ7QWQtTgVBXGp4JpZrJb+THq7hyca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959237; c=relaxed/simple;
	bh=hPmMXi3DIwHejYR6KZDF66L7tN963ysxO89JlXIjB7A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSqNhcUSVypNiMlZXTWXanSO4Vk7bNWogKs6K5v/ssatn82S3DsSfRYeHDcsL6PzTTx7JlEkDfTLME8+7O9u4Lv6RN06n8OeImONHnHJbqTmUT4KVqG0vA9ZeFTM+cn+2LJOVr1aRzes+adXphcH49izyLMSJuSN6NAMwnWfzMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoyMqjir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoyMqjir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49CB1F00899;
	Mon, 21 Sep 2026 02:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789959235;
	bh=WQXDAUzizbrL4Dhi7hzmeIYNARQ4ZiKmlqe6VCGycP8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SoyMqjirH5ReH63LZHlHziK7xmNy+n1oMr0/vjhVrtX6cMUw8eBKt7kWAVq5PhrXU
	 nX16JZ0W+/m0TILjy+NdNxLtcUTNT+97p0qmXhdjSjDjzdAxoNZ+nJxoaCWw3bucwx
	 3F4b1Afzk5QM0TbNn61GVC9hcobJDRCtvVYVAVNZZB5VPnsDSim0uiHlVClcqJDE82
	 z2SQOcwYXxcfQ2xSDbLanno3+kXdtqvpncWzfuV9mJn6d+sLFuXt7ylKjS2pDsmwLs
	 WCBJw7KrG90LtEb8AU4I9zwL6SEeGMFVwAEeQaWQxR2xsOjmpf63Q2mmx1wL8MtUCW
	 doa8BSXaOJxQw==
Subject: Re: [PATCH net v2] net: tun: fix race condition between tun_attach
 and tun_get_user with XDP
From: netdev-bot+sashiko@kernel.org
To: xietangxin@h-partners.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, huyizhen2@huawei.com,
 gaoxingwang1@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 02:53:54 +0000
Message-ID: <178995923435.2160803.18166174326002943726@kernel.org>
In-Reply-To: <20260920030240.443223-1-xietangxin@h-partners.com>
References: <20260920030240.443223-1-xietangxin@h-partners.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the new "publish tfile->tun last" ordering is a
  no-op on the TUNSETQUEUE/IFF_ATTACH_QUEUE re-attach path, so the…

Pre-existing issues:
- [Medium] Mirror-image ordering problem on the detach path is untouched
  and reproduces the same netif_get_rxqueue() WARN_ONCE.
- [Medium] tun_set_real_num_queues() (drivers/net/tun.c:526-530) is void
  and discards the documented error returns of…

--

net: tun: fix race condition between tun_attach and tun_get_user with XDP

This moves the rcu_assign_pointer(tfile->tun, tun) publication in
tun_attach() to after tun_set_real_num_queues(), so that
dev->real_num_rx_queues is raised before a concurrent writer can observe
the newly attached tun_file.  The intent is to stop the WARN_ONCE in
netif_get_rxqueue() that fires when a recorded rx queue index is not
below dev->real_num_rx_queues.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68a..2dfca25b86e9 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -811,11 +811,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  	 * initialized tfile; otherwise we risk using half-initialized
>  	 * object.
>  	 */
> -	if (publish_tun)
> -		rcu_assign_pointer(tfile->tun, tun);
>  	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
>  	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
>  	tun_set_real_num_queues(tun);

[Severity: Medium]
This isn't a bug introduced by this patch, but the new ordering guarantee
now rests on tun_set_real_num_queues() having actually taken effect, and
that function drops both return values:

drivers/net/tun.c:
static void tun_set_real_num_queues(struct tun_struct *tun)
{
	netif_set_real_num_tx_queues(tun->dev, tun->numqueues);
	netif_set_real_num_rx_queues(tun->dev, tun->numqueues);
}

For an already registered device, netif_set_real_num_rx_queues() returns
early without assigning dev->real_num_rx_queues:

net/core/dev.c:netif_set_real_num_rx_queues() {
		rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues,
						  rxq);
		if (rc)
			return rc;
	}

	dev->real_num_rx_queues = rxq;
}

and net_rx_queue_update_kobjects() can fail on rx_queue_add_kobject():

net/core/net-sysfs.c:net_rx_queue_update_kobjects() {
		error = rx_queue_add_kobject(dev, i);
		if (error) {
			new_num = old_num;
			break;
		}
}

In that case tun_attach() has already published tun->tfiles[] and bumped
tun->numqueues, and then publishes tfile->tun and returns 0.  Does that
leave tfile->queue_index == dev->real_num_rx_queues permanently, so that
every write() on that queue going through the generic XDP path hits the
same netif_get_rxqueue() warning the commit message is trying to remove?
Should the error be propagated and the numqueues/tfiles publication
unwound instead?

[Severity: Medium]
This is a pre-existing issue and the patch does not touch __tun_detach(),
but the decreasing direction looks like the same mismatch.  In
__tun_detach() the surviving queue's index is lowered and numqueues is
decremented well before the real queue count is reduced:

drivers/net/tun.c:__tun_detach() {
		spin_lock(&ntfile->tx_ring.consumer_lock);
		ntfile->queue_index = index;
		ntfile->xdp_rxq.queue_index = index;
		...
		WRITE_ONCE(tun->numqueues, tun->numqueues - 1);
		...
		synchronize_net();
		...
		tun_set_real_num_queues(tun);
}

The moved tfile keeps its ->tun published, and the queue_index sample in
tun_get_user() happens before the rcu_read_lock() around the XDP call:

	skb_record_rx_queue(skb, tfile->queue_index);

	if (skb_xdp) {
		...
		local_bh_disable();
		rcu_read_lock();

so the synchronize_net() above does not fence a writer that already
sampled the old, higher index.  Can a write() racing with
TUNSETQUEUE|IFF_DETACH_QUEUE reach do_xdp_generic() after
dev->real_num_rx_queues has shrunk and hit the same WARN_ONCE?  Also, for
the clean == false case, tun_disable_queue() never clears tfile->tun and
the stale queue_index stays in place while the fd is still writable.
Should the commit message scope its claim to the attach path, or should
the detach direction be handled too?

> +	if (publish_tun)
> +		rcu_assign_pointer(tfile->tun, tun);
>  out:
>  	return err;
>  }

[Severity: High]
Is this reordering effective on the TUNSETQUEUE re-attach path?  A queue
detached with IFF_DETACH_QUEUE goes through __tun_detach(tfile, false),
where clearing tfile->tun only happens in the clean case:

drivers/net/tun.c:__tun_detach() {
		if (clean) {
			RCU_INIT_POINTER(tfile->tun, NULL);
			sock_put(&tfile->sk);
		} else {
			tun_disable_queue(tun, tfile);
			tun_napi_disable(tfile);
		}
}

So on that fd tfile->tun stays non-NULL and visible.  tun_set_queue()
then re-attaches with publish_tun = true:

		ret = tun_attach(tun, file, false, tun->flags & IFF_NAPI,
				 tun->flags & IFF_NAPI_FRAGS, true);

and tun_attach() writes the new, higher index long before the queue count
is raised:

	spin_lock(&tfile->tx_ring.consumer_lock);
	tfile->queue_index = tun->numqueues;
	spin_unlock(&tfile->tx_ring.consumer_lock);

Since the moved rcu_assign_pointer(tfile->tun, tun) stores a value that
readers can already see, does it order anything for them on this path?  A
concurrent write() on the same fd still passes tun_get(), records the new
index and calls into XDP:

	skb_record_rx_queue(skb, tfile->queue_index);

	if (skb_xdp) {

reaching net/core/dev.c:netif_get_rxqueue():

		if (unlikely(index >= dev->real_num_rx_queues)) {
			WARN_ONCE(dev->real_num_rx_queues > 1,

which is the warning quoted in the commit message, plus the silent
fallback to dev->_rx[0] so the program runs against the wrong
netdev_rx_queue.  The window is not small either, because
netif_set_real_num_rx_queues() does GFP_KERNEL sysfs work.  Would either
clearing tfile->tun on the non-clean detach, or publishing
tfile->queue_index only after tun_set_real_num_queues(), close the attach
path in all cases rather than only when tfile->tun transitions from NULL?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920030240.443223-1-xietangxin%40h-partners.com
