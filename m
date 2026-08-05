Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A343B486;
	Wed,  5 Aug 2026 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927988; cv=none; b=BClA8d5oXBCWP3uXpqUPRvjlh1WWPX5lTOFa2L/Z++YDk8t1qiM557V/YNwdPYDwGdjBxyZiVExIV2rptozmwBiJvUIlgOmKpRfa/rFys5bgksNsA6FfkYqm2p5mq+UzrpPzeax0f330K5s48ZcuFaCTSX1xciMP94eyqEb9WOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927988; c=relaxed/simple;
	bh=5oD1KGRZDqGOnahSZUKsxHN2Wk/ZQ1nwiKE2/WuFzVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHJW8UtmbB1DZK77NRDp+dbmH9SY8jsfBWb6t8VXEIznjr9pfpxBGMm26rNMEHa3m3Tj+ANbGZmqOIIdIvFDkAwdWlFSDzYOjZN2R2IVoHH0eVvGWUamzDETC6AzKRWK+2+SzleBhmP4B3Qr6mJcFESkHgZj46vYIY6VQijzwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz5t1785927880tc42198f7
X-QQ-Originating-IP: aoM8ez5vTCN40p44Tq7dOFWURS9hhXeEo7DuFS4FnHg=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Aug 2026 19:04:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9454275783155653639
EX-QQ-RecipientCnt: 10
Date: Wed, 5 Aug 2026 19:04:37 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v8 1/4] net: rnpgbe: Add interrupt handling
Message-ID: <E26C0959D6DFC1E7+20260805110437.GA91397@nic-Precision-5820-Tower>
References: <20260731120322.895955-1-dong100@mucse.com>
 <20260731120322.895955-2-dong100@mucse.com>
 <20260805093428.GN51943@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805093428.GN51943@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OdBzWRvjigAZx1uU0tl+iM3XMTbcfOzVHb5Jce2KN2GbCXm3tSDqdCMb
	mSQC84Fg6vG2NmOCCKhM3aZvpUg6nDDMzS2tlRsnPpuzyNHD5XWqkv0iA6NllRG9Tj3TsbQ
	2OOwcnq2xYY8fM9vVuNCe/9mQAhafBaK22rLMYqu9a3zTtC8kCtRFOuRH2k2HwODIbLKAFl
	OyEW5sHA5SulwYMqcX7lrCiNChR8HvCyVVhgZ2LD6ma6B+v68qkGsZSF25roBtGJR9mKJ4o
	59VnUZZu+v6DNbkAXGYGyesM5Xrd6oUue5lY7sOF3OmpmNS14X6NmYa8OYCyrwNC4Pj5Ysf
	uKimYznsXi+9gq9Uu4mBgMaHDFMfyAMf/xAHDaWntHpJD4jRmuT/xG2XIgDeQn0cI47rq4V
	+/AxjwHp71Vlw3bKkhoQfPRO/BsP2bRbMGGt32y6I3ART54gx53youooApBJPI+bbR3pj8I
	ZncHzua1ebm/FJLITuXjkjG2+eQuJhj7f/CX8hTSr9nrpjcByESRWiapi9IjGlSxIKrI+ik
	8dYijTttLNXBuKjJIMprQvcRChZ5DzwgMc+NQi9TsVmH4h6t5m/EsQ82k4ubX9e615ef6Xc
	Pbh678LG5UlaotNcfnAKMeCl9Rwb6joVBPE6AmNG7n4zYlA2p6UbRQIw63KPdDGR/sxf6Ch
	iM1zJBQtBayX/WQQYjm3qjYdpH9XkJF2VVtJXQ9moOjWVm3nZuOG45Bue9bZAxD2ZSA+v1Q
	6Kwop5xHtIj58gxhh8evy1fXJefW6Ymry0TaPaSrJCaHKbpcOi2mQ016mtwwr3f3UTtxxOm
	/q0tVlZwIjHYDy5w/4LlPre6L8Mt24D+hUzHQGZhdqKEOI+O9cnEcWJK9cj3bNySbGPy0qQ
	1BbFTYrAcUS12mD4et6Qw7R1dr0kglLBKUHNBxyPFpfddi18mT+onMVRJr5h5NQnOch4fKy
	zfCoTkZaAzJWn9KYUo8hTsxh3bvsqWo8zAxQXSB57lg48Jzdr3nzzEi4cgGyjw52qoRoQnC
	rP8fcdKAsHF9HyrVmdQJOZ8YAG1LZPXt0uX0GNQf5y4XKcJjGZRiB5RWs+Mf/gAkUJNcX+k
	9CyYn3QAGSuCzaqK2GCTopHth3xIi56HCGVhDiwtBXnpFYU8m02Srw=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Hi Simon:

On Wed, Aug 05, 2026 at 10:34:28AM +0100, Simon Horman wrote:
> On Fri, Jul 31, 2026 at 08:03:19PM +0800, Dong Yibo wrote:
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> 
> ...
> 
> > @@ -50,6 +68,11 @@ static int rnpgbe_open(struct net_device *netdev)
> >   **/
> >  static int rnpgbe_close(struct net_device *netdev)
> >  {
> > +	struct mucse *mucse = netdev_priv(netdev);
> > +
> > +	rnpgbe_down(mucse);
> > +	rnpgbe_free_irq(mucse);
> > +
> >  	return 0;
> >  }
> 
> Hi Dong,
> 
> There is an AI-generated review of this patch-set available at
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731120322.895955-1-dong100%40mucse.com
> I would appreciate it if you could take a look over it.
> 
> In particular, the following issue does seem to be of concern.
> 
> I take the last portion regarding ixgbe to be a template for a solution to
> the problem raised, not that the __IXGBE_DOWN bit should litteraly be used
> in the rnpgbe driver.
> 
>   Is ndo_stop now safe to call twice?
> 
>   rnpgbe_dev_shutdown() in this same file calls rnpgbe_close() directly rather
>   than going through dev_close():
> 
> 	  rtnl_lock();
> 	  netif_device_detach(netdev);
> 	  if (netif_running(netdev))
> 		  rnpgbe_close(netdev);
> 	  rtnl_unlock();
> 
>   netif_device_detach() only clears __LINK_STATE_PRESENT, so IFF_UP and
>   __LINK_STATE_START stay set and the core still believes the interface is up.
> 
>   A later dev_close() (device_shutdown() runs before migrate_to_reboot_cpu(),
>   so an "ip link set dev X down" on another CPU can still get through), or an
>   unbind/unregister_netdev() after a shutdown, would call ndo_stop again:
> 
>     dev_close() -> __dev_close_many() -> ops->ndo_stop() -> rnpgbe_close()
> 
>   On that second pass rnpgbe_down() runs again:
> 
> 	  void rnpgbe_down(struct mucse *mucse)
> 	  {
> 		  set_bit(__MUCSE_DOWN, &mucse->state);
> 		  rnpgbe_napi_disable_all(mucse);
> 		  rnpgbe_irq_disable(mucse);
> 	  }
> 
>   With plain set_bit() there is nothing to detect the re-entry, so
>   napi_disable() runs on an already-disabled NAPI.  In napi_disable_locked():
> 
> 	  while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
> 		  usleep_range(20, 200);
> 		  val = READ_ONCE(n->state);
> 	  }
> 
>   The irq is already freed and NAPI was never re-enabled, so can anything
>   clear those bits?  That loop has no timeout, and it runs under rtnl_lock().
> 
>   The second rnpgbe_free_irq() would also call free_irq() on vectors already
>   released, giving the "Trying to free already-free IRQ" warning.
> 
>   Before this patch rnpgbe_close() was just "return 0;", so the double call
>   was harmless.
> 
>   Would the ixgbe guard fit here?
> 
> 	  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_down() {
> 		  /* signal that we are down to the interrupt handler */
> 		  if (test_and_set_bit(__IXGBE_DOWN, &adapter->state))
> 			return; /* do nothing if already down */
> 		...
> 	}
> 
>   Alternatively, should rnpgbe_dev_shutdown() call dev_close() so the core
>   state stays consistent?

Yes, it is an error. I will use rnpgbe's own __MUCSE_DOWN bit to make the
teardown idempotent. rnpgbe_down() will atomically report whether it performed
the transition, and rnpgbe_close() will skip IRQ and resource teardown when
the device is already down. This covers a later ndo_stop after the shutdown
path has detached and stopped the device.

> 
> ...
> 
Thanks for your feedback
