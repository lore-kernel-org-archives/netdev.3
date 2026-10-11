Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787C314D13;
	Sun, 11 Oct 2026 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791760307; cv=none; b=AMMNNqwfkKoF31NTTgjM7SluSVk0i/Ck7XlzY2ZrpvfD6wSxyYrgruOgsD486QxFfPXdZlzdeJJ5lZJmuawlfNB4BZ1ASzSL9/ZDRlPqwTvtD3j+uezU/bseVsYmOVn7NpE3SsCiVAA6+k7S4j59ILpziptX1YUhpwvj3rPyYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791760307; c=relaxed/simple;
	bh=L6t6eTegQPAOeQuhMTa9PTtwUFRsC5wObH5Mjwu7cEU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TrqKdVCZAQjMpi0cSXjHUlpC0kfXpfvdDvj3GjGUAlvVFofPO0+VH9oMA5I4Z/Zuapf64N4UH3jGfhBcW1Z9evJ8qbHAm9cgwK3DnndgnKuHZBA4jZtB+E1qaJyk2Q5K4AhMABCojlhRUB+MmIppcce4RelUiPFD+t530gBm2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWF7aSUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWF7aSUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C497B1F0089B;
	Sun, 11 Oct 2026 23:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791760306;
	bh=z5pOc8cLCfkjIfWcLR1xQNYyoRYgZOxxSZvfhh7g+Nc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BWF7aSUpJoro1SGTcMPhW+z8A6y0pcfbt5YtNCSu4Y+b3dTSe5DgVmjIFhGwqdeRD
	 4UxglLlBEH2hl7czxokmhf6nJSOHj4mM/cwH7VeLsVXfkRrYh18Jgmg0g7mJCaZ5pk
	 ZnefNlgrBLf0sSGmsjOy0VvO//amgmTlPW46LGmyV7fUhj/R2EbBSDCQjzDla9qA1J
	 0BUGZWkBSelqCiSQDGKCENIpeiH/xcXu/jBBillE027vC4h65xp+8MhMMG9gxWwSCQ
	 hROGFu3SlnoFGCOKJr+QRBJvBx2oItZtiQzXMYYnR8XmfHrxStEV3r+g299o87dSRR
	 PRjfB2fVRD9CQ==
Subject:
 Re: [PATCH net-next] net: dsa: motorcomm: Do not do the redundant MIB clear
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 23:11:45 +0000
Message-ID: <179176030531.434549.15766940452679334921@kernel.org>
In-Reply-To: <20261010231015.2600207-1-mmyangfl@gmail.com>
References: <20261010231015.2600207-1-mmyangfl@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's last paragraph gives a reason why the
  removed MIB clear needs no replacement anywhere else, and both parts…

--

net: dsa: motorcomm: Do not do the redundant MIB clear

This patch removes the MIB clear from yt921x_chip_setup(). The commit
message argues it is redundant because a hardware reset happens right
before it. It also argues that nothing else needs to handle MIB state,
because per-port state is always freshly allocated.

> Nor should we take care of it elsewhere: .port_setup() should not clear
> it, and .setup() runs at most once per registration, so per-port state
> is always freshly allocated by .port_setup().

[Severity: Medium]
Is this paragraph accurate? Both of its claims seem to conflict with the
DSA core and with the driver's own port setup code.

On ".setup() runs at most once per registration": in net/dsa/dsa.c,
dsa_switch_remove() calls dsa_tree_teardown() on the whole tree. That
reaches dsa_switch_teardown() for every member switch, which does:

    ds->setup = false;

When the removed switch probes again, the call chain is:

dsa_switch_probe()->dsa_tree_setup()->dsa_switch_setup()
    err = ds->ops->setup(ds);

This runs for every switch in the tree, including a yt921x that never
unregistered.

On "per-port state is always freshly allocated by .port_setup()":
yt921x_dsa_port_setup() only allocates the MIB block when none exists:

    if (!pm && (BIT(port) & yt921x_info_ports_mask(info))) {
        pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
        ...
        /* Start disabled, so that the enable below always pairs with
         * either this disable or the one from a previous teardown
         */

yt921x_dsa_port_teardown() deliberately keeps the block:

    /* get_stats64() might not be synchronized with port_teardown(), hold
     * the MIB block till the device teardown
     */

So on a second .setup() within one registration, yt921x_dsa_setup() calls
yt921x_chip_reset(). Per this commit message, that zeroes the hardware
counters. pm->data[] and pm->stats still hold the old accumulated values.

yt921x_mib_read() says "MIB buffer must be zeroed before" and extends the
32-bit counters like this:

    val = (old_val & ~(u64)U32_MAX) | val0;
    if (val < old_val)
        val += 1ull << 32;

After a re-setup, won't the first poll treat the reset counters as a wrap?
That would add about 2^32 to each 32-bit counter. The 64-bit counters would
go backwards to small values. These values then show up in get_stats64,
ethtool -S and the rmon/mac/pause stats.

The removed write to YT921X_MIB_CTRL never cleared the software buffer, so
this patch does not change runtime behaviour here. The concern is that the
commit message says no handling is needed, based on invariants the code does
not appear to guarantee.

Could the commit message be corrected? Alternatively, should
yt921x_dsa_port_setup() clear pm->data and pm->stats when it reuses an
existing block, since every .setup() hard-resets the chip?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010231015.2600207-1-mmyangfl%40gmail.com
