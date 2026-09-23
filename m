Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427211A6809;
	Wed, 23 Sep 2026 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190123; cv=none; b=Fbml/itLRT1i09i9Y5pTcMiaNcru7aHAz3slUwn3YNdzuPRqvYN4WOc4d0GNnbbrmU8vpMj0W2e9h8b23+VT76St4EIz1kjwqr+urIsQ8UE/yeq46NjpcA4e90jugSm16yorXVXwuQ8qr/XC5mi8OlcvKgZWuo300nmKCAPICp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190123; c=relaxed/simple;
	bh=s/+0nb3O1T3yOXbmqEDcgbsTS+4UsZ20fVWwR0vd2RI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SEfU0Pvs+zyWtouqqLuyql9QbqEDynKpJQsMK0Mx2kyzfFk7g4tUDQP6FnDoTn583irOzLw88w4wJ/Ev6HTASfSQzDHTxEEN4jWsL3bDXPNxHeZQtxKG6NCV1axRfK3AMHjnaH0zPw/zzOmyTdQutwudIldEETzhILRPhe4qWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlU0VPnC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlU0VPnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322161F000FF;
	Wed, 23 Sep 2026 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790190121;
	bh=+8Sw/rOqgo8SDRpNG8SMic0S0ngCWUQ7HXsEYLpHeq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hlU0VPnCzKfnlTys/E135bK8UEiTz3i50Y2GM4ca6KVBT4Ib4v3G1JGQlR6Xdc8M6
	 tltjNM0mVNgCQV8CFiwJikKPzpw+ykFJ5iN4WWVtHdhpKO9XwoTZpnQaFEfte0aNiR
	 qCalO/8C4okV2A7qLEwh3PeIiKKuNqluhgsmb/dgoRCUtWeVDkpfhu4oNMPYosdgTp
	 AdvUio3MqEnf+HXxZvd/yN+NOR9DW1A/p183ol06VRHMqJa9Q+ZcPsPlbsfA+XVCU+
	 tu4WH2X/YWqodZ51nvhGnEh2a4k48JESImDXwQjyHg2FTX+wnNUlIU66nKJuGFLnSO
	 BpB+zbHl1uAMA==
Subject: Re: [PATCH] net: e1000: fix warning in iounmap on probe failure
From: netdev-bot+sashiko@kernel.org
To: nsvatoslav515@gmail.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Date: Wed, 23 Sep 2026 19:02:00 +0000
Message-ID: <179019012072.2160803.2987779879938123307@kernel.org>
In-Reply-To: <20260921125932.7943-1-nsvatoslav515@gmail.com>
References: <20260921125932.7943-1-nsvatoslav515@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes a genuine, user-visible WARN splat on the
  e1000 probe failure path but carries neither a `Fixes:` tag nor `Cc:…
- [Low] Commit message contains no problem description and no syzbot
  `Closes:` link.
- [Low] The newly added `if (hw->hw_addr)` guard in the e1000_probe()
  unwind ladder…

--

net: e1000: fix warning in iounmap on probe failure

This adds NULL checks around the two iounmap() calls on the shared
e1000_probe() unwind path, so that a probe failure no longer calls
iounmap() on an unmapped pointer.

> net: e1000: fix warning in iounmap on probe failure
>
> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>

[Severity: Low]
The changelog is a subject line plus a Reported-by: tag, with no
description of the defect.  Could it say which unwind label is taken,
which pointer is NULL, and where the warning comes from?

For reference, on x86 iounmap() starts with:

arch/x86/mm/ioremap.c:iounmap() {
	if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
		return;
	...
}

and hw->ce4100_gbe_mdio_base_virt is only mapped when
hw->mac_type == e1000_ce4100, so it stays zero (from alloc_etherdev())
on every other part.  Any failure reaching err_sw_init, err_dma,
err_mdio_ioremap, err_eeprom or err_register then passes NULL to
iounmap().

Also, netdev submissions pairing Reported-by: syzbot+... normally carry
the matching link:

  Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b

Could that be added so the reported splat can be matched to this call
site?

[Severity: Medium]
There is no Fixes: tag and no Cc: stable@vger.kernel.org here.  Is that
intentional?

The unconditional iounmap(hw->ce4100_gbe_mdio_base_virt) on the shared
unwind path came in with 13acde8fffc0af ("e1000: Fix the CE4100 bus type
for the MDIO/PHY registers"), building on CE4100 support in 5377a4160bb65
("e1000: Add support for the CE4100 reference platform").

The nearby 816419dfea5c88 ("e1000: fix memory leak in e1000_probe()"),
which moved the err_mdio_ioremap label in this same ladder, carried both
Fixes: 5377a4160bb65 and Cc: stable@vger.kernel.org, so this region does
get backported.  Without the tags, stable kernels keep hitting the WARN,
which is fatal under panic_on_warn.

> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d7f5c6f161420..156903089fa6b 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -	iounmap(hw->ce4100_gbe_mdio_base_virt);
> -	iounmap(hw->hw_addr);
> +	if (hw->ce4100_gbe_mdio_base_virt)
> +		iounmap(hw->ce4100_gbe_mdio_base_virt);
> +	if (hw->hw_addr)
> +		iounmap(hw->hw_addr);
                ^^^^^^^^^^^^

[Severity: Low]
Can this new hw->hw_addr test ever be false?

The only assignment of the field in the driver is in e1000_probe():

	hw->hw_addr = pci_ioremap_bar(pdev, BAR_0);
	if (!hw->hw_addr)
		goto err_ioremap;

and err_ioremap: sits just below this hunk, so the one path where
hw_addr is NULL skips the call entirely.  Every label that falls through
here (err_sw_init, err_dma, err_mdio_ioremap, err_eeprom, err_register)
is only reachable after the BAR0 mapping succeeded.

e1000_remove() encodes the same invariant:

	if (hw->mac_type == e1000_ce4100)
		iounmap(hw->ce4100_gbe_mdio_base_virt);
	iounmap(hw->hw_addr);

Would it be clearer to guard only the ce4100 mapping, matching the
mac_type test used in e1000_remove(), and leave iounmap(hw->hw_addr)
unconditional?  A NULL check there turns any future unwind imbalance
into a silent ioremap leak instead of a warning.

>  err_ioremap:
>  	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
>  	free_netdev(netdev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921125932.7943-1-nsvatoslav515%40gmail.com
