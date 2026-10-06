Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8875547061
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307145; cv=none; b=IloZeGJp606JbhVsde3KJWPtYJ8f1EY9J+O0DEeXmW3ivpir6QTHfRivGnPgWJ1FWi0WnMFsXYyaGJRXhdPPfdHiToPZ4yg8Am9p2NZFDUt4racenoAGDHMzlj3qfTfny6RWDsbImNaEbGTBXybAdGY4Fd6utjRbQHU0k5uM7yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307145; c=relaxed/simple;
	bh=ww3JMCIG3yr4hgc8MkuqZMfeY4bl4V0wjncu3dC9kjA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cP+fBwBoD/19FX05Gt4MipwhaB5/hUXGma9I1QMt0YBIFaLJgX4Kabk6muYSejV4kmYy85N9TWW80roAlvb3/3fHwg66HwM2Zcj0jsh1Fa8M3LP8GvjTTw8pY5ejgD9ukbpKn0qqeqVeGZ3wUiBP5gat6Ki3bEYjF3orQ7doilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe9FMYHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe9FMYHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A1F1F0089B;
	Tue,  6 Oct 2026 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307143;
	bh=wlHYW4tF5p5geciFkzV5cSjk1tDQbp0cOMZ6Yfk+mzc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fe9FMYHlQfRXrWdexlVWCy3NPLFvCraY+Kewf5fVMxnxLTtr5Jx9y102Oqb2iXKiy
	 mUPS1tqHhqWXf1vyXu+2acC2Ol4NI+5fAz9Uhdkxn+GWzt2L2/t/Skbf2iJQOudqiV
	 q9hm+pJ/9jUNdEZITCkrqf+ssyyF6FSbLJpcyaO//RTflr+LK9OfmNr5haavm8YATY
	 2P8H+bXtP7ulOSR89/xjfbqp1n9pARlPBL6rLaXyBYwEsiwLxz8fZhqYip/pyEMUC+
	 RXq6eh3pexZK2iQs5uKdcnFnjRF5XSTBgeIc/GT4LFzxUE3Zz/w3pmKUZUFPw0/q46
	 3VyW7kNDisIWQ==
Subject: Re: [PATCH net-next v3 01/12] net: ethernet: cortina: Keep PHY-less
 port bound for shared IRQ
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:02 +0000
Message-ID: <179130714260.434549.17412775194221581174@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-1-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-1-3e1f25890ae8@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new guard in geth_resize_freeq() only checks geth->port1,
  but the new gemini_port_clear() in the probe error path can now leave…
- [Medium] Port 0 still loses the shared free-queue handler when the IRQ-
  only port 1 is unbound or fails probe late.
- [Medium] The new `if (!geth->port1) return -ENODEV;` check in
  geth_resize_freeq() is a lockless check-then-use that does not…

--

net: ethernet: cortina: Keep PHY-less port bound for shared IRQ

The commit keeps Gemini ethernet port children that have no PHY
description bound as IRQ-only ports. This keeps the shared free queue
threaded IRQ, which is routed through port 1, registered. It also clears
the parent's port pointers on probe failure and removal, and makes
geth_resize_freeq() return -ENODEV when port 1 is absent.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 2fe7fd0202d26..2be3e90519811 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1048,10 +1048,15 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	u32 en;
>  	int ret;
>  
> +	/* The software free queue interrupt is routed through port 1. */
> +	if (!geth->port1)
> +		return -ENODEV;
> +

[Severity: High]
Is checking only geth->port1 enough here? With the new
gemini_port_clear() call in the unprepare path of
gemini_ethernet_port_probe(), geth->port0 can now be NULL by the time
port 1 probes. In that case the shared block is never initialized.

Take a board with PHYs on both ports:

port 0 probe
  geth->port0 = port;
  gemini_ethernet_init()          /* port1 NULL, returns early */
  gmac_setup_phy() fails          /* e.g. -ENODEV, PHY not on MDIO */
  unprepare: gemini_port_clear()  /* geth->port0 = NULL */

port 1 probe
  geth->port1 = port;
  gemini_ethernet_init()          /* port0 NULL, returns early again */
  register_netdev()               /* eth1 is registered */

gemini_ethernet_init() is the only place that programs the
GLOBAL_INTERRUPT_SELECT_* and SWFQ/HWFQ registers and sets
freeq_frag_order and freeq_order:

	if (geth->port0 && geth->port1)
		geth->initialized = true;
	else
		return;
	...
	geth->freeq_frag_order = DEFAULT_RX_BUF_ORDER;

When eth1 is opened, gmac_open()->geth_resize_freeq() passes this check
and calls geth_setup_freeq() while freeq_frag_order is still 0 from
devm_kzalloc(). That makes fpp_order equal to PAGE_SHIFT and
pages = 1024 >> 12 = 0. kzalloc_objs(..., 0) then returns ZERO_SIZE_PTR,
which passes the NULL check.

geth_fill_freeq() then does:

	m_pn = (1 << (geth->freeq_order - fpp_order)) - 1;
	...
		gpage = &geth->freeq_pages[pn];
		page = gpage->page;

The shift is out of range, and the page lookup goes through
ZERO_SIZE_PTR. Can this oops?

Later in the series, "Scale Gemini RX queues to system memory" sends the
same uninitialized state to geth_freeq_post_page(). That function writes
1 << 12 descriptors starting at geth->freeq_ring + (pn << 12) into a
ring sized for 1 << 10 entries. Would that write past the DMA coherent
allocation? As far as I can tell, nothing later in the series closes
this path.

Before this patch, geth->port0 stayed non-NULL (dangling), so
gemini_ethernet_init() still ran.

Should this check geth->initialized, or both ports, instead of only
geth->port1?

>  	if (netdev->dev_id == 0)
> -		other_netdev = geth->port1->netdev;
> +		other_port = geth->port1;
>  	else
> -		other_netdev = geth->port0->netdev;
> +		other_port = geth->port0;
> +	other_netdev = other_port ? other_port->netdev : NULL;

[Severity: Medium]
Is this check-then-use of geth->port1 safe if port 1 is probed or
removed at the same time? geth_resize_freeq() runs under RTNL from
gmac_open() and gmac_set_ringparam(). geth->port1 is written without
RTNL or any other common lock.

On the remove side, gemini_port_remove() skips this block for the
IRQ-only port:

	if (port->netdev) {
		phy_disconnect(port->netdev->phydev);
		unregister_netdev(port->netdev);
	}

so it never takes RTNL. gemini_port_clear() runs next, and devres frees
the port (it is part of the devm netdev allocation) right afterwards.

A concurrent open of eth0 can pass the guard and load
other_port = geth->port1. It then reads other_port->netdev and
other_port->rxq_order. Could those reads hit freed memory?

Later in the series, geth_resize_freeq() also reads geth->port1->irq
again for disable_irq() and enable_irq(). Could that be a NULL
dereference if port 1 is cleared between the reads?

On the probe side, gemini_ethernet_port_probe() publishes geth->port1
before gemini_ethernet_init() and before devm_request_threaded_irq().

Can an eth0 open in that window resize the queue and enable SWFQ_EMPTY
before the handler exists? gemini_ethernet_init() may still be writing
GLOBAL_INTERRUPT_ENABLE_4_REG, the SW free queue registers,
freeq_frag_order and freeq_order without irq_lock at that point.

>  
>  	if (other_netdev && netif_running(other_netdev))
>  		return -EBUSY;

[ ... ]

> @@ -2392,6 +2406,7 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
>  	}
>  	clk_disable_unprepare(port->pclk);
>  	geth_cleanup_freeq(port->geth);
> +	gemini_port_clear(port);
>  }

[Severity: Medium]
Can port 0 still lose the shared free queue handler here? Port 1 now
stays bound only to provide the SWFQ threaded handler. Nothing stops it
from being unbound while eth0 is running: the port driver does not set
suppress_bind_attrs, and the IRQ-only remove path does not check the
sibling port.

In this commit, unbinding the IRQ-only port 1 while eth0 is up also
calls geth_cleanup_freeq() unconditionally. That frees and unmaps the
shared ring and pages while port 0's RX DMA, and possibly
gemini_port_irq_thread(), still use them. Is that a use-after-free? The
later patch "net: ethernet: cortina: Keep shared free queue
parent-owned" removes this call.

Even with that later patch, this unbind still runs gemini_port_clear():

  echo 6000c000.ethernet-port > /sys/bus/platform/drivers/gemini-ethernet-port/unbind

devres then frees port 1's threaded IRQ. SWFQ_EMPTY_INT_BIT stays set in
GLOBAL_INTERRUPT_ENABLE_4_REG, but no handler is left on int1, and
gemini_port_irq_thread() is the only refill path.

Would port 0 RX stall once the posted fragments are used up, while eth0
still reports itself as running?

The same thing can happen if eth0 is opened after port 1 publishes
geth->port1, and port 1 then fails late in gmac_setup_phy() or
register_netdev(). The unprepare path clears geth->port1, and devres
frees the IRQ.

This looks like the "releases the threaded handler needed by the shared
queue" case the commit message describes, reached through the remove
path and the late probe failure path.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
