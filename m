Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF84A440D;
	Thu, 24 Sep 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265297; cv=none; b=Dd4MRnPjj4TfhJx5XEM8zaO8gliRbffrfWnaneeso5wrvjy5fFJYIilr9MRoFMt5eNI10rwoe/dyIxN0GCP1nwLpBk2D5Gk+2Aw6nInBPxJ8AeU9Fj5G5upqk2YHXSKwOo6ICxEbvukkErr1MBBCHSzE21nHSvd8zVEhG49BWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265297; c=relaxed/simple;
	bh=mxG2FiqPOgRdRCdKCGuvJclsYsO9fnNhbA4y7yX0aVo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UEwn2aWVcK5eMPtuxb0YSlaE+si3JSUDZL/+W/ab7rbuGxyJXLFPauTFMEyWMtDvB60QJJFBm6p+Iy4nW7dnk7BkfWteZDZ7ytmudpn6uMULgmIp1IwyJp8isJISRg7uVVWJ00yCMURZ4bGKFz/SfTbEQFx84oZs9ls350JeDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhoWW0jq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhoWW0jq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F2E1F000FF;
	Thu, 24 Sep 2026 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265295;
	bh=WxRwkjeergipzjy0uMRZTXDUDSUf8XVConGIHIBupxg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NhoWW0jqpcicBVv7R3YtiKTCUY39VGoip6bAu1u9LFpXQ+i9ONXROPSF8AOrpvsBN
	 IJ+e/ZXYgVIV/lStApAJ5MMYdRjGZ+JO2FMlKwqz7C/sZgYXMhhDbxER+yUemzZ1b3
	 0efAot6jZUrQWsEiyq4t3bWP37QMzXgD/JC9kt+Wa0MUF64R4tTot2L9NwvuVku84M
	 h30T07LQ5NkGVAGbYD1kQCuiAXNPEgJD/d7iBBLcXkxq3H4L2RqW1IlRcGcgOboyDI
	 rvKAIFzyl7f0JmCtbOdAgL/EbK0kKTy4dSgaY6YcIOCJtzaj7ODb2iYZAZAnwXhO/V
	 ozX0HRd1x8lng==
Subject:
 Re: [PATCH net v2] net: e1000: fix warning in iounmap on probe failure
From: netdev-bot+sashiko@kernel.org
To: nsvatoslav515@gmail.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, ffainelli@freebox.fr, auke-jan.h.kok@intel.com,
 jgarzik@redhat.com, joe@perches.com, aleksandr.loktionov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Date: Thu, 24 Sep 2026 15:54:54 +0000
Message-ID: <179026529412.2160803.2090347947027060894@kernel.org>
In-Reply-To: <20260922155238.67445-1-nsvatoslav515@gmail.com>
References: <20260922155238.67445-1-nsvatoslav515@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit message misdescribes the defect and half of the added
  code is dead.
- [Low] The submission carries `Reported-by:
  syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com` but the next…

--

net: e1000: fix warning in iounmap on probe failure

This adds NULL checks before the two iounmap() calls in the e1000_probe()
error unwind path, for hw->ce4100_gbe_mdio_base_virt and hw->hw_addr, in
response to a syzbot report of a WARN from iounmap().

> During a probe failure, the e1000 driver error handling path calls
> iounmap() on hw->ce4100_gbe_mdio_base_virt and hw->hw_addr without
> checking if they were previously mapped. This triggers a kernel warning
> (WARN) rather than a fatal crash when passed an uninitialized pointer.

[Severity: Medium]
Is the hw->hw_addr half of this description accurate?  hw->hw_addr has a
single assignment in the whole driver, in e1000_probe():

	err = -EIO;
	hw->hw_addr = pci_ioremap_bar(pdev, BAR_0);
	if (!hw->hw_addr)
		goto err_ioremap;

The err_ioremap label sits below the iounmap block being patched, and
nothing ever resets hw->hw_addr to NULL.  Every goto that lands in the
err_sw_init / err_dma / err_mdio_ioremap region (e1000_init_hw_struct()
failure, dma_set_mask_and_coherent() failure, e1000_sw_init() failure,
the ce4100 ioremap() failure) happens after hw_addr was successfully
mapped.  So can the new if (hw->hw_addr) test ever be false?

The pointer that can legitimately be NULL there is
hw->ce4100_gbe_mdio_base_virt, which is only mapped for one MAC type:

	if (hw->mac_type == e1000_ce4100) {
		hw->ce4100_gbe_mdio_base_virt =
					ioremap(pci_resource_start(pdev, BAR_1),
						pci_resource_len(pdev, BAR_1));

		if (!hw->ce4100_gbe_mdio_base_virt)
			goto err_mdio_ioremap;
	}

and x86's iounmap() does:

	if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
		return;

which looks like the warning syzbot hit.

Also, the pointer is not uninitialized: the adapter is zeroed by
alloc_etherdev(), so ce4100_gbe_mdio_base_virt is a well defined NULL.
Could the commit message be reworded to say that, and could the second
Fixes: tag (1dc329180fe22 "e1000: Use hw, er32, and ew32") be dropped
since the hw_addr case does not appear to be reachable?

One more thought on form: e1000_remove() already guards the same two
pointers the other way around:

	if (hw->mac_type == e1000_ce4100)
		iounmap(hw->ce4100_gbe_mdio_base_virt);
	iounmap(hw->hw_addr);

Would matching that idiom here keep the two paths consistent?

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
>  err_ioremap:
>  	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
>  	free_netdev(netdev);

On the tag block:

> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Fixes: 13acde8fffc0a ("e1000: cleanup CE4100 MDIO registers access")

[Severity: Low]
Could a Closes: or Link: line with the syzkaller dashboard URL be added
immediately after the Reported-by: line?  scripts/checkpatch.pl checks
for this:

	# check if Reported-by: is followed by a Closes: tag
			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {

This matters here because the body defers all reproduction evidence to
the dashboard:

> This issue was found by Syzbot. The exact kernel configuration (.config)
> and the C reproducer used to trigger this warning are available on the
> Syzbot dashboard.

Without the URL there is no way to check which configuration reaches the
e1000_probe() error path with hw->ce4100_gbe_mdio_base_virt == NULL.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922155238.67445-1-nsvatoslav515%40gmail.com
