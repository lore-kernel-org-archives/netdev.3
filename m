Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502049BD9B;
	Thu, 24 Sep 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268715; cv=none; b=Mn26eXkJ4NViON26k7Su74l4+p9tZ5nH00syuHlHdL2dIIVyhePwqgDQ3Ewcdfuh3WchwVznahySmFgZKJnv8FkbK1h7FwpX06MWokrfhayWDe29hT3WV4AP19bchT1aMbphGN6DeGnDf9FTrg6nxUD0z/JkTNnYGYDRIFP1oLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268715; c=relaxed/simple;
	bh=J0DW3E9Z2fPNxhuyaSuk7VVRbi+OD5OACzXEv0JiGIY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jXbcw29r+Q7OzJbfrth/JDOmOt3J72+NVBpxKLsVjG0hfytr923e+3ms1+6gvIYVRilqT2eOBWhJ1t5GEJhHnb8cBQHCXN5x7EbXZ+0eR8W3llOb7LyBcEkGkZHbFHNVfjhwJzSIhIeMjl3kEKwQDaymzd6SkbLECSJk9ZaM3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+BQR6E/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+BQR6E/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8C41F000FF;
	Thu, 24 Sep 2026 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268713;
	bh=eSSbZnuCtl8KDycVQpA/SGQENb09ic1AWqUQDE6gDSA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W+BQR6E/ARkY77WyRvDCrbfBmdwmPiO5UNnTfMszL7stSF3MSUDw1HtBDuwdUWywk
	 ZGYp6+BZBGHcGdXm145sBvqRnJ85ehyTl2OxgGlLbxUBGiaEswePb0yCrlyXVZIEG5
	 DfTnShquyK+cdp0uBLKeX4WWnioArkHxhiNSFUFwk8wOPg8DBuvkjfEHbwzhjtrYZ7
	 FTyvGTZxORK/NFEjRzTHejx6PtiRUZkEbGp8Lp/yOJgS+RCWWCXEjMuh9h3TreGZQR
	 zOXVhEiHv23AWqLFUJLEOcgZS0FaQnqb5pL/CP1dOH8+/w0mi6p7Z92UuhdW8YZlWd
	 ort8Ir02wrsTw==
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
Date: Thu, 24 Sep 2026 16:51:52 +0000
Message-ID: <179026871201.2160803.192841426910444830@kernel.org>
In-Reply-To: <20260922155139.67364-1-nsvatoslav515@gmail.com>
References: <20260922155139.67364-1-nsvatoslav515@gmail.com>
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

- [Medium] Half of the patch is provably dead code and the commit message
  over-claims the defect.
- [Low] The commit carries `Reported-by:
  syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com` and asserts…

--

net: e1000: fix warning in iounmap on probe failure

This patch adds NULL checks before the two iounmap() calls in the
err_sw_init/err_dma error unwind path of e1000_probe(), so that a probe
failure does not pass a NULL pointer to iounmap().  It carries two Fixes:
tags and a syzbot Reported-by:.

No Link: tags were present in the commit header.

Two questions below, one on the commit message tags and one on the diff.

> net: e1000: fix warning in iounmap on probe failure
>
> During a probe failure, the e1000 driver error handling path calls
> iounmap() on hw->ce4100_gbe_mdio_base_virt and hw->hw_addr without
> checking if they were previously mapped. This triggers a kernel warning
> (WARN) rather than a fatal crash when passed an uninitialized pointer.
>
> This issue was found by Syzbot. The exact kernel configuration (.config)
> and the C reproducer used to trigger this warning are available on the
> Syzbot dashboard.
>
> Fix this by adding NULL checks before calling iounmap().
>
> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Fixes: 13acde8fffc0a ("e1000: cleanup CE4100 MDIO registers access")

[Severity: Low]
The Reported-by: line is followed directly by a Fixes: line, with no
Closes: or Link: URL pointing at the syzbot report.  Could that URL be
added?

Documentation/process/submitting-patches.rst asks for it:

    The tag should be followed by a Closes: tag pointing to the report,
    unless the report is not available on the web

and scripts/checkpatch.pl warns on this pattern:

    BAD_REPORTED_BY_LINK
    "Reported-by: should be immediately followed by Closes: or Link:
     with a URL to the report"

The commit message says the .config and the C reproducer "are available on
the Syzbot dashboard", but without the link there is no way to check which
error path syzbot actually reached, which is relevant to the question
below.

Also, the description of the value handed to iounmap() as an
"uninitialized pointer" does not look accurate: the adapter private area
comes from alloc_etherdev()/alloc_netdev_mqs(), which zero the allocation,
so hw->ce4100_gbe_mdio_base_virt is deterministically NULL rather than
garbage.  Could that wording be adjusted?

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

[Severity: Medium]
Can the new "if (hw->hw_addr)" test ever be false?

hw->hw_addr is assigned in exactly one place in the driver, in
e1000_probe():

	err = -EIO;
	hw->hw_addr = pci_ioremap_bar(pdev, BAR_0);
	if (!hw->hw_addr)
		goto err_ioremap;

The err_ioremap: label sits below the iounmap(hw->hw_addr) that is being
guarded here, so the only path that leaves hw_addr NULL skips this code
entirely.  Every other goto that lands on this label (err_sw_init,
err_dma, err_mdio_ioremap, err_eeprom, err_register) is reachable only
after pci_ioremap_bar() already returned a valid mapping.

If that reading is right, the hw_addr half of the change is dead code, and
the second tag

	Fixes: 1dc329180fe22 ("e1000: Use hw, er32, and ew32")

refers to a defect that is not present.  Should that tag be dropped, along
with the mention of hw->hw_addr in the commit message, so a stable
backport is not aimed at a path that cannot trigger?

The ce4100_gbe_mdio_base_virt half does look like a real fix, since that
mapping is only created for one MAC type:

	if (hw->mac_type == e1000_ce4100) {
		hw->ce4100_gbe_mdio_base_virt =
					ioremap(pci_resource_start(pdev, BAR_1),
						pci_resource_len(pdev, BAR_1));

so on every other device the field stays NULL while the unwind path still
calls iounmap() on it, and x86 iounmap() does:

	if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
		return;

Would it be clearer to describe only that case in the changelog?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922155139.67364-1-nsvatoslav515%40gmail.com
