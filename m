Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3173F927D;
	Wed,  5 Aug 2026 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922474; cv=none; b=jm1XmsebRqFejag/CUDrJtyJuFjPU8NQyrU11BdgyZMDC6yz8HKb0U2dpX3eBedrA+Kkls5wp4jKHUqLVArGLst9Qw56USqDfbReGa572dgVQyCtl5iyP+6dpDr2l9SUWwXlOPkvK5COuoO7XAwopci0cCrkqVbanDO62II1Ipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922474; c=relaxed/simple;
	bh=vV5OO5aMm1VuXpWSl38B+4IH1o9YaA1Dl6CXRTdJBSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfs+p0XBIpUcpiIQpFWhZ2XzG5vj+yEhepwQm5A7QGG1VBFBLSlo/1yr/XciEBZ72nhDyIlOipRW6f7ejt65drRfZHGPglYYLZ+6eSnIn1cLaJtnBmc++pbqvZMqkjU/td04/pFEhykZrUlA+xpMEs8GGJKjH4UzYaLsZJ+MH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv5hApi9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv5hApi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CA11F00A3A;
	Wed,  5 Aug 2026 09:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922473;
	bh=+fu4flaUdexOtkZYArfe9zKk4GYC+H8ojvniT0HvNrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zv5hApi9y1Cwltj5abK3Lb0eoHg7MqspaktoPCEFmiOqvRBhB/5VTyu/Lac4r0l8W
	 78/7u6y2LFOT9bIfY2M6WjptjWT+u3Lw2wTRByfFP20WsDG6BFtl0R3SmT80hQWM0U
	 ziTAXNBt3tlTAHRbTMTURYkJhCFS+7gKD/cz4QDLqsqJOxuTPUpAmEhQ922rxsbbL8
	 VJUrlCtG6etFiKFbRvLDLxOdmWi8Eh3QMY8kWVjCOZLSDsW9ZXegfXeWntY5gt3XwT
	 K/eBc3hn0yrAeZ9V5yfbnKIufEeRhNjnmG+hrWFumK/e2gYB+vyoFcJx3x3MsNcZoa
	 SntbC12rywHGg==
Date: Wed, 5 Aug 2026 10:34:28 +0100
From: Simon Horman <horms@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v8 1/4] net: rnpgbe: Add interrupt handling
Message-ID: <20260805093428.GN51943@horms.kernel.org>
References: <20260731120322.895955-1-dong100@mucse.com>
 <20260731120322.895955-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731120322.895955-2-dong100@mucse.com>

On Fri, Jul 31, 2026 at 08:03:19PM +0800, Dong Yibo wrote:

...

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

...

> @@ -50,6 +68,11 @@ static int rnpgbe_open(struct net_device *netdev)
>   **/
>  static int rnpgbe_close(struct net_device *netdev)
>  {
> +	struct mucse *mucse = netdev_priv(netdev);
> +
> +	rnpgbe_down(mucse);
> +	rnpgbe_free_irq(mucse);
> +
>  	return 0;
>  }

Hi Dong,

There is an AI-generated review of this patch-set available at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731120322.895955-1-dong100%40mucse.com
I would appreciate it if you could take a look over it.

In particular, the following issue does seem to be of concern.

I take the last portion regarding ixgbe to be a template for a solution to
the problem raised, not that the __IXGBE_DOWN bit should litteraly be used
in the rnpgbe driver.

  Is ndo_stop now safe to call twice?

  rnpgbe_dev_shutdown() in this same file calls rnpgbe_close() directly rather
  than going through dev_close():

	  rtnl_lock();
	  netif_device_detach(netdev);
	  if (netif_running(netdev))
		  rnpgbe_close(netdev);
	  rtnl_unlock();

  netif_device_detach() only clears __LINK_STATE_PRESENT, so IFF_UP and
  __LINK_STATE_START stay set and the core still believes the interface is up.

  A later dev_close() (device_shutdown() runs before migrate_to_reboot_cpu(),
  so an "ip link set dev X down" on another CPU can still get through), or an
  unbind/unregister_netdev() after a shutdown, would call ndo_stop again:

    dev_close() -> __dev_close_many() -> ops->ndo_stop() -> rnpgbe_close()

  On that second pass rnpgbe_down() runs again:

	  void rnpgbe_down(struct mucse *mucse)
	  {
		  set_bit(__MUCSE_DOWN, &mucse->state);
		  rnpgbe_napi_disable_all(mucse);
		  rnpgbe_irq_disable(mucse);
	  }

  With plain set_bit() there is nothing to detect the re-entry, so
  napi_disable() runs on an already-disabled NAPI.  In napi_disable_locked():

	  while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		  usleep_range(20, 200);
		  val = READ_ONCE(n->state);
	  }

  The irq is already freed and NAPI was never re-enabled, so can anything
  clear those bits?  That loop has no timeout, and it runs under rtnl_lock().

  The second rnpgbe_free_irq() would also call free_irq() on vectors already
  released, giving the "Trying to free already-free IRQ" warning.

  Before this patch rnpgbe_close() was just "return 0;", so the double call
  was harmless.

  Would the ixgbe guard fit here?

	  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_down() {
		  /* signal that we are down to the interrupt handler */
		  if (test_and_set_bit(__IXGBE_DOWN, &adapter->state))
			return; /* do nothing if already down */
		...
	}

  Alternatively, should rnpgbe_dev_shutdown() call dev_close() so the core
  state stays consistent?

...
