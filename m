Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3749E5D8
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209649; cv=none; b=LlhS7ljoD3CUWnz0yc0ONG7XnXWl3nzUyKvTRw1uUL+/rp16/kwcB2s/Jth7fkWtpPEO27WRVDirEGXSy49UH/fxpJj5pkWqWzkrlYeJ58jVsSFF/dQpNpu9VQEobjc6VfgRoqOLJ5EqC41HnlJmrJZ3pHVZf2U+C0jGVxcCKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209649; c=relaxed/simple;
	bh=lLfFIlgTK8T/FOk7LUTds2Zx9Z4K70GZdC/QkiwqZ0M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JFYOwldtKygmHqTI/tthmR3pW3xuznanP5RjRjQvpJCPc3RYtOLG/cAH8A/GA3rsWcF2Vmsir2N47wvyCsl9lqs36oHX/2hCQjasElBvPQ3AQZOfyXQ3ldfMw5a0UI1p+zNYrc0osBuzUoHS3FsZY+G8Jq7ZgDz77g6Gjxd6vlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nofCIAYh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nofCIAYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F6A1F000FF;
	Mon,  5 Oct 2026 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791209641;
	bh=ATzG+L8YsNUmOKoBB/0ap9vpolQt4BSY6mfBdVkuIBU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nofCIAYhG7dNx6Jw6Tof83bZ3Q/+7konRGEISbyroRn1NByU6/aOAKmc0teLiI8lt
	 K6tsqsGxDeQcEDShasFyL66hB3qgvNpFedhW7YfO0UcexAJpg26kjhGEttcbwPgRsG
	 x3BPnfgN3VaS0D8pNgHIyuGwfBdTjxmYLVw+tqArtgDTkc459DVhh+9OP8yI6YPbqs
	 SJfhWhqj4LZhura48DtBsEZ9CGUqi/83qsbutwq/qJzlojUDwCaMw5MztiiLKaRiwH
	 cBXV0ZCS8qWievWHK3MgCjFQbDLhRoFP7AxcSNy5f7tQqfu9Vl0aD15ANj99os4pRU
	 3paQf3N7TilWg==
Subject: Re: [PATCH net-next v4 1/3] net: stmmac: set real_num_tx_queues to
 max(offset + count)
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, olteanv@gmail.com,
 0x1207@gmail.com, daniel@riscstar.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dcaratti@redhat.com
Date: Mon, 05 Oct 2026 14:13:59 +0000
Message-ID: <179120963986.434549.17858114667686220816@kernel.org>
In-Reply-To:
 <20261001-stmmac-mqprio-prio-offload-v4-1-a74610d7f1e5@oss.qualcomm.com>
References:
 <20261001-stmmac-mqprio-prio-offload-v4-1-a74610d7f1e5@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message describes only one of two failure modes.

--

net: stmmac: set real_num_tx_queues to max(offset + count)

This patch changes how tc_setup_dwmac510_mqprio() computes the number of
real TX queues. It now uses the maximum of offset[i] + count[i] instead
of the sum of the per-TC counts. As a result, real_num_tx_queues covers
the highest queue in the TC map even when the mqprio layout has gaps or
a non-zero first offset.

> netif_set_real_num_tx_queues() then passes this too-small count to
> netif_setup_tc(), which invalidates the mapping.

[Severity: Low]
Is this description complete? It seems to cover only layouts where TC0
itself ends up out of range.

In tc_setup_dwmac510_mqprio(), stmmac_set_ndev_tcs() runs before
netif_set_real_num_tx_queues(). It starts by calling netdev_reset_tc(),
which zeroes dev->prio_tc_map:

drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:stmmac_set_ndev_tcs() {
	...
	netdev_reset_tc(ndev);
	...
}

So when netif_setup_tc() runs, every priority maps to TC0, and the TC0
check is the only one that can fire:

net/core/dev.c:netif_setup_tc() {
	...
	/* If TC0 is invalidated disable TC mapping */
	if (res.offset + res.count > txq) {
		netdev_warn(dev, "Number of in use tx queues changed invalidating tc mappings. Priority traffic classification disabled!\n");
		WRITE_ONCE(dev->num_tc, 0);
		return;
	}
	...
}

mqprio_init() installs the user's prio_tc_map only after the offload
callback returns.

Take a gapped layout where TC0 fits, such as "queues 1@0 1@2". The old
sum gives real_num_tx_queues = 2, and nothing gets invalidated. TC1
keeps offset 2, so on transmit:

netdev_core_pick_tx()
  netdev_pick_tx()
    skb_tx_hash()          /* returns 2 */
  netdev_cap_txqueue()     /* 2 >= real_num_tx_queues, warns, returns 0 */

stmmac does not implement ndo_select_queue. That traffic class,
including express or preemptible FPE traffic, would therefore go out on
queue 0 with only a ratelimited warning. Its mapping would not be
rejected.

The code change handles both cases. Could the commit message also
describe this misrouting case, so backporters can see the full impact of
the bug being fixed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001-stmmac-mqprio-prio-offload-v4-0-a74610d7f1e5%40oss.qualcomm.com
