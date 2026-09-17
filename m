Received: from mail.newtech.fi (mail.newtech.fi [185.185.168.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1EB524B0C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.185.168.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652267; cv=none; b=qqeA1KQqFSTXXZsP18+k/mfCozPf4dq/NAIMBJaIuCQq+a+hIFxRmWbGhAaQYUEDYoe71O1VsGoX4dTXNgzjCRWMXjsJ7TWhwzNei6Pzo6LVv2aGWvGxTdc/yxXGAC8/d9LjPzcnSW+CqZrJjDDEHse/lYRlw7+XypKmmOaJm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652267; c=relaxed/simple;
	bh=0dmJ0KBALdv59mWoJgN8V3FG7n4gpJF6ivT66vyqkEk=;
	h=Date:Message-ID:From:To:Subject:Content-Type:MIME-Version; b=g76SpMqfkxPDzZWbXZ9L7GUWvVeJXNKhozIVagDZx4NNKO+RmH1W8r9FlsJFDAk8OarLzHVkfOrAc2xFPohUO7KQhRc8O+E4s31fsjdg2iwwkbvC++JIIGWrjIJCO/IEE+UP8d4MQEDTUElPnigI0l4EOIou1RJhS8SA9bTbr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=newtech.fi; spf=pass smtp.mailfrom=newtech.fi; arc=none smtp.client-ip=185.185.168.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=newtech.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=newtech.fi
Received: by mail.newtech.fi (Postfix, from userid 50002)
	id A48F641560; Thu, 17 Sep 2026 16:31:42 +0300 (EEST)
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
Received: from owncloud.newtech.fi (dag.newtech.fi [194.110.87.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.newtech.fi (Postfix) with ESMTPSA id 3C8794155B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:31:42 +0300 (EEST)
Date: Thu, 17 Sep 2026 13:31:42 +0000
Message-ID: <20260917133142.Horde.4x06M_WjYPvXK32347V1lgn@owncloud.newtech.fi>
From: Dag Nygren <dag@newtech.fi>
To: netdev@vger.kernel.org
Subject: [BUG] i40e: TX-DRP regression on LACP bond legs, kernel
 4.18.0-553.162 (AlmaLinux 8.10, downstream of RHEL 8.10)
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary
-------
After updating a KVM host from kernel 4.18.0-553.129.1.el8_10 to
4.18.0-553.162.1.el8_10 (AlmaLinux 8.10), we observed a significant
increase in TX-DRP on the physical member interfaces of an LACP
(802.3ad) bond, along with a customer-reported latency increase in
a proprietary VPN tunnel traversing this host, from ~3-5ms to >50ms.
Rebooting back to 4.18.0-553.129.1.el8_10 with identical load and
configuration eliminates the drops (0 TX-DRP) and restores normal
latency. Rebooting forward to .162 again reproduces the drops.
This has been confirmed on two independent physical nodes of the
same cluster (matching hardware), each running one of the two
kernel versions concurrently, so this is not a one-off.
 
Environment
-----------
- Distro: AlmaLinux 8.10
- Affected kernel: 4.18.0-553.162.1.el8_10.x86_64
- Known-good kernel: 4.18.0-553.129.1.el8_10.x86_64
- NIC: Intel, driver i40e, both LACP legs same driver/model
 (ens1f0, enp216s0f3), 96 RX/TX queues configured but IRQ
 affinity scoped to two ranges (~queues 24-47, 72-95 active,
 0-23/48-71 essentially idle - appears intentional, unrelated
 to this issue)
- Role: KVM host, physical NICs bonded via 802.3ad LACP, guests
 attached via Linux bridge over the bond; one or more guest VMs
 run a proprietary VPN gateway
- Hardware: 48-core (96 thread) systems, matching between the
 node running .129 and the node running .162
 
Symptom
-------
1. TX-DRP increments on the raw LACP member interfaces (ens1f0,
  enp216s0f3), NOT primarily on the bond or bridge interface
  themselves.
2. Customer reports VPN tunnel RTT increased from ~3-5ms baseline
  to >50ms, correlated in time with the kernel update.
3. `netstat -i` (== /proc/net/dev, same counters as `ip -s link`)
  is the customer's monitoring tool, so the reported "drops" are
  confirmed to be genuine local netdev TX-DRP counters, not TCP
  retransmits or an application-level metric.
 
 
What we have ruled out / do not believe is the cause
-----------------------------------------------------
- NOT reproducible via synthetic bulk load: multiple concurrent
 iperf3 streams (20MB write size, i.e. large sends subject to
 normal TCP GSO/TSO segmentation) driven to interface saturation
 on a smaller-scale test system with matching hardware produced
 ZERO TX-DRP on .162, both with GSO/TSO/GRO enabled and with all
 three disabled via ethtool -K.
- NOT a driver mismatch: both LACP legs use the same i40e driver.
- NOT dropwatch/kfree_skb noise: skb_release_data and
 unix_stream_connect account for the overwhelming majority of
 kfree_skb events on this system under normal operation and are
 believed unrelated (normal skb lifecycle, not real loss).
- NOT (as far as traced so far) visible in any straightforward TX
 xmit-path bpftrace capture (tracepoint:net:net_dev_xmit with
 rc != 0) on the test system - we have not yet caught an actual
 TX-DRP event live on the raw legs in a trace, on either the test
 system or production, despite instrumenting for it.
- We do NOT have a confirmed root cause. Below is context that may
 or may not be relevant; we are flagging it rather than asserting
 causation.
 
Possibly-relevant context (unconfirmed)
----------------------------------------
Reviewing the changelog delta between the two kernel builds, we
noted that 4.18.0-553.161.1.el8_10 (one build prior to .162)
includes a series fixing CVE-2026-53091, touching
qdisc_pkt_len_init()/qdisc_pkt_len_segs_init() (GSO segment-count
accounting used by the qdisc layer), and paired in the same RHEL
bug (RHEL-188227) with an xfrm/ESP header-handling fix. We flag
this because it is TX-path/qdisc-adjacent and lands exactly in the
affected version gap, but we want to be clear: we have NOT been
able to confirm this is actually responsible. Our synthetic
GSO-heavy load did not reproduce the issue, which argues against
(but does not rule out) this specific series being the cause -
our test load may simply not replicate whatever condition
production traffic creates.
 
Reproduction difficulty
------------------------
We have NOT been able to reproduce this on a smaller-scale test
system with otherwise-matching hardware, despite:
- Heavy multi-stream iperf3 load at interface saturation
- Toggling GSO/TSO/GRO on and off
- Checking ethtool -S counters (tx_busy, tx_restart, tx_linearize,
 tx_dropped) - none showed meaningful movement
The production environment is a large, topologically complex
network (many concurrent flows/VMs/routes) that our test system
cannot replicate at scale. We suspect the trigger may be
scale/concurrency-dependent (route table size, connection count,
number of concurrent flows, or similar) rather than raw
throughput-dependent, since raw throughput alone does not
reproduce it.
 
Request
-------
- Does anyone recognize this behavior, or know of other reports
 of TX-DRP or latency regressions on i40e in this kernel range?
- Any guidance on what else to instrument to catch the actual
 drop event live would be appreciated - we have not yet captured
 the responsible code path directly, only correlated its absence/
 presence with kernel version via clean bisection.
 
Happy to provide further data (ethtool -S/-c/-k dumps, /proc/
interrupts snapshots, bpftrace output) on request.
