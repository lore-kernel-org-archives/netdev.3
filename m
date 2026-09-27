Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4037C0F5;
	Sun, 27 Sep 2026 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790499162; cv=none; b=p8gFyykFtthOYCUQv/MnvaR9JG3U9gFj+DkOTOb6i2O9VdI7IX5tg95arr7Klg7zcWC9nMIYnralOM41RaxYK+uXJ6MOEjBQcuoGzNlVH2MhAe2zmjnBA8lqgpq1M7COyd2qZcSTmXhfsvwhdLrY9fh+wPeKSTJv2IILGTpc7GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790499162; c=relaxed/simple;
	bh=uz+D8o6qdCG1HZC8SiOAvdc5oR9IuHYyw1tNOT6dRAo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OVNjWn6Itx7zGvqqZZbFUnwJcw8eh+IrhUB+UHTUTtGEV/GulKHdJ+MtMx9pcWtCcpHHIOwQEE1ZyW2OJ3iuXLWg47vya8Eos0hrj7eIRw0C0Tu7moW0QFGqdDS+5aaqQioPlyw+EAcHzhm9GCq+L0nMcMjndtzWCVwVbpjDeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgV2BHBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgV2BHBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163FF1F00893;
	Sun, 27 Sep 2026 08:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790499160;
	bh=1mAQZhudpBAJi8QsiH96d9smQR5Gmr4hB+ueh9j2UOY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YgV2BHBFwIDe4NFDBtot7AcetTxiQ8AqWInfGZOtWNQ0nnjcgAMulfTCQoAOVJqkS
	 QzZEbm/NrzUP3JiH/XxDQJU5i2yMOwHQqYytvAwkLBTbbG19agqKsLaGr5arTqElPB
	 nWDrk5PW7777y3rcaENpDr4v9STDf2VSZ2eSvfejQJHTe2TIIc10swKeuzx+73xkF6
	 eV7HyzE8AATdez+3wzimx05K8czc+JRhCBMYDVCO9qilZ3hMCT032Qm61C0YUKHfE8
	 S8VgLqkU5YoEgN61Kd18mrk6FUkab6+wRbwAr7VEjRxXr50NCnxysShW3vfG83F2tk
	 FBifYjAal+5RA==
Subject:
 Re: [PATCH net] net: dm9000: Fix a recursive lockup in the TX timeout path
From: netdev-bot+sashiko@kernel.org
To: ginger.jzllee@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 08:52:39 +0000
Message-ID: <179049915962.2160803.15902785609696334931@kernel.org>
In-Reply-To: <20260923084055.65091-1-ginger.jzllee@gmail.com>
References: <20260923084055.65091-1-ginger.jzllee@gmail.com>
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

- [High] In drivers/net/ethernet/davicom/dm9000.c, dm9000_phy_write() now
  decides whether to take and release both db->addr_lock and db->lock by…
- [Medium] in_timeout, in_suspend and wake_supported are adjacent 1-bit
  bitfields in the same unsigned int of struct board_info (lines…

--

net: dm9000: Fix a recursive lockup in the TX timeout path

This commit fixes a deadlock on DM9000B. There, dm9000_timeout() holds
db->lock while dm9000_init_dm9000() calls dm9000_phy_write(), which takes
db->lock again. dm9000_phy_write() already skipped db->addr_lock when
db->in_timeout was set, and it now skips db->lock in that case too.

> diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
> index b87eaf0c250ce..328043056ec48 100644
> --- a/drivers/net/ethernet/davicom/dm9000.c
> +++ b/drivers/net/ethernet/davicom/dm9000.c
> @@ -325,10 +325,10 @@ dm9000_phy_write(struct net_device *dev,
>  	unsigned long reg_save;
>  
>  	dm9000_dbg(db, 5, "phy_write[%02x] = %04x\n", reg, value);
> -	if (!db->in_timeout)
> +	if (!db->in_timeout) {
>  		mutex_lock(&db->addr_lock);
> -
> -	spin_lock_irqsave(&db->lock, flags);
> +		spin_lock_irqsave(&db->lock, flags);
> +	}
>  
>  	/* Save previous register address */
>  	reg_save = readb(db->io_addr);
> @@ -344,11 +344,14 @@ dm9000_phy_write(struct net_device *dev,
>  	iow(db, DM9000_EPCR, EPCR_EPOS | EPCR_ERPRW);
>  
>  	writeb(reg_save, db->io_addr);
> -	spin_unlock_irqrestore(&db->lock, flags);
> +	if (!db->in_timeout)
> +		spin_unlock_irqrestore(&db->lock, flags);
>  
>  	dm9000_msleep(db, 1);		/* Wait write complete */
>  
> -	spin_lock_irqsave(&db->lock, flags);
> +	if (!db->in_timeout)
> +		spin_lock_irqsave(&db->lock, flags);

[Severity: High]
Can in_timeout change between these checks when dm9000_phy_write() is
called from somewhere other than dm9000_timeout()?

in_timeout is a device-wide flag. dm9000_timeout() sets and clears it, and
it runs from the dev_watchdog timer with only tx_global_lock held.

dm9000_phy_write() is also the mii.mdio_write callback. It is reached under
rtnl through these paths:

  dm9000_nway_reset()->mii_nway_restart()
  dm9000_set_link_ksettings()->mii_ethtool_set_link_ksettings()
  dm9000_ioctl()->generic_mii_ioctl() (SIOCSMIIREG)

None of these paths are serialized against the watchdog. So
in_timeout == 1 only means that some CPU is inside dm9000_timeout(). It
does not mean that this caller holds db->lock.

The flag is now read four times without a lock, and each read decides
whether a lock is taken or released. Before this patch the relock after
dm9000_msleep() was unconditional. A caller would spin until
dm9000_timeout() finished, so the final check always ran under db->lock,
where in_timeout can only be 0.

Consider this sequence on DM9000B:

CPU0 (ethtool -r)                  CPU1 (dev_watchdog)
dm9000_phy_write()
  in_timeout == 0
  mutex_lock(&db->addr_lock)
  spin_lock_irqsave(&db->lock)
  iow(db, DM9000_EPCR, ...)
  spin_unlock_irqrestore(&db->lock)
  dm9000_msleep(db, 1)
                                   dm9000_timeout()
                                     spin_lock_irqsave(&db->lock)
                                     db->in_timeout = 1
                                     dm9000_init_dm9000()
                                       dm9000_phy_write() x2
                                         mdelay(1) each
  in_timeout == 1, relock skipped
  readb(db->io_addr), iow() ...    iow() ...
  in_timeout == 1, unlocks skipped

CPU0's index/data accesses then interleave with CPU1's iow() pairs, and
db->addr_lock is never released. Would later phy_read, EEPROM and
ethtool/MII callers then hang, often with rtnl held?

If CPU1 clears the flag before CPU0 reaches the final check, CPU0 instead
calls spin_unlock_irqrestore() on a db->lock it doesn't hold.

The opposite case also seems possible. If CPU0 enters while
in_timeout == 1, it takes neither lock and flags is never initialized. If
the flag then drops to 0 before the first unlock check, CPU0 runs
spin_unlock_irqrestore(&db->lock, flags) with garbage flags. Later it runs
mutex_unlock() on an addr_lock it never took.

Would it be more robust to stop inferring lock ownership from in_timeout?
For example, the timeout path in dm9000_init_dm9000() could call an
unlocked __dm9000_phy_write() helper (or pass a locked argument), and
normal MDIO callers would always take both locks.

> +
>  	reg_save = readb(db->io_addr);
>  
>  	iow(db, DM9000_EPCR, 0x0);	/* Clear phyxcer write command */
> @@ -356,9 +359,10 @@ dm9000_phy_write(struct net_device *dev,
>  	/* restore the previous address */
>  	writeb(reg_save, db->io_addr);
>  
> -	spin_unlock_irqrestore(&db->lock, flags);
> -	if (!db->in_timeout)
> +	if (!db->in_timeout) {
> +		spin_unlock_irqrestore(&db->lock, flags);
>  		mutex_unlock(&db->addr_lock);
> +	}
>  }

[Severity: Medium]
With this change, in_timeout effectively means "the caller already holds
db->lock". Could a stale in_timeout value leave every later
dm9000_phy_write() running without db->lock or addr_lock?

in_timeout shares a word with in_suspend and wake_supported in struct
board_info:

	unsigned int	in_timeout:1;
	unsigned int	in_suspend:1;
	unsigned int	wake_supported:1;

dm9000_timeout() writes in_timeout under db->lock. dm9000_drv_suspend() and
dm9000_drv_resume() write in_suspend without any lock.

In dm9000_drv_suspend() the store happens before netif_device_detach(), so
the watchdog can still be running dm9000_timeout() on another CPU:

	db->in_suspend = 1;

	if (!netif_running(ndev))
		return 0;

	netif_device_detach(ndev);

dm9000_drv_resume() likewise clears in_suspend after netif_device_attach()
has already re-enabled the watchdog.

Suppose the suspend read-modify-write loads the word while in_timeout is 1,
and stores it back after dm9000_timeout() has cleared the flag. in_timeout
then stays at 1 until the next TX timeout.

The lost update itself predates this patch, but before this patch it only
caused addr_lock to be skipped. Now these later dm9000_phy_write() callers
would skip both locks:

  resume, via dm9000_init_dm9000() on DM9000B
  ethtool and MII ioctls
  dm9000_shutdown()

Their index/data register accesses would then race with the xmit and IRQ
paths.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923084055.65091-1-ginger.jzllee%40gmail.com
