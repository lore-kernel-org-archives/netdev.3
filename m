Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9843CE56;
	Fri, 11 Sep 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126937; cv=none; b=oG+Q4lu5gc2dNQz23uKUPEpF49UvgpZwrfsmDKva/GkCmSBLw8VDIpnR1kZg1xsGASS95nhyyB+AUCie9NOQxDEZeSOMHTI2dORATGB1jZ/6ZOXYzUYyjVwRaFsH6EGp2legfi3Xs/NSG7FV68XDSnbKlSZcK9hElKQ5JV3a9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126937; c=relaxed/simple;
	bh=/WDgAh+yR3M7zyZ2g5l8qS7WjC2LzZT3m1k807O9ctY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xfsm5AHkJeBQTxXDqQGpkav+sCSiwg6by1lbt22RjkVQbhTyhdcMH3w1wFd12jv/tXc6jkq1f6ayv+Gl4iAYxNALTcSafs4h7uUT69GcMbKf+jk1+2Rs0DxAKYlUJlTzG05oJil8ygh/f/amSMTcuSWKR+J4f94NwE/7iC5E6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz6t1789126869t02683768
X-QQ-Originating-IP: 00fCgQCjXhfufXxDsdxdwVWYI1fAKI9kd8dukQ2YCbs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Sep 2026 19:41:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7134341429419294373
EX-QQ-RecipientCnt: 10
Date: Fri, 11 Sep 2026 19:41:07 +0800
From: Yibo Dong <dong100@mucse.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v11 0/5] net: rnpgbe: Add TX/RX and link status
 support
Message-ID: <AA4D5E2B4B7BFCFE+20260911114107.GA2143727@nic-Precision-5820-Tower>
References: <745DADAC2A5786BD+20260911112416.2142101-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <745DADAC2A5786BD+20260911112416.2142101-1-dong100@mucse.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: ODCBvbzq7GXCC7OlqtWMCZHYwrXE/OUHFieCsQxLO3pk0krlSXJy/nrK
	yOJ/EqeyAaWYdZ/XfAGRid9KHJHlbgQb0GNVL2zqgXk3Ik8nlvekt5cla30VPZCB35rHSaR
	BuNquMzfbW1YGvReueMszPZwBYMaJP4kgwoy3uP6eE+XuBYFHMuNo+MeI2L7PKMqsr69elt
	REXUerSrDFEvRWl1bHVqqf/3ZfUG3ks2LiDppJHzL/ooNEnsCklGvo5xm4NG0kr0oUTgCoC
	Ovw4RYlQFmBiwtYf9wotENOoAjUB77Pqd9vJr54KjgfBPbHprb97LkS5rHFhNrJiPFzgFeW
	S/Yvi9NpIv/ib/Cqxb9jgpi6DYqNTjtZya2ZQHpVsAvnsDCJwSTdlsJriapaEwMhsPd9/Ra
	FsTN+Nh7oYJvIjNpcuanTIMw0mmWp9xq42PNqghFzqgSVNWPzmXpbN2TdhxurWWwuFDU63A
	xuEt8LHMfLYud2c62nW2AUQPvy0uH96Dl0b+wqjiv5SvUGK23rPM2ascSYJG2chAeejLS0P
	Y3EL5nL898NK1tFOvRWciBYILyeZDlqJxyyBaM655ROG53mAa4D342G3AIKoyagv/v/oeqK
	TCieXyMBg3s3NClxk07Rv5CDTalyO900a1rxst26fqRWmRotE7doYzAXW/rXK2reHNMD5Gd
	SDldVYVL0zNjOe1Nxpgacgr0h5mTWzcUvkBron3ke9+4UkeBoRKByy2/zEZ5IohDNfboXv5
	yvA9B6n3EM5v537fXo3DEk0XO0kzikhCo++A52KUGJFIRVUnTbSasdpv8QRkCs3W62tTNIU
	tJT9ZUnX3dfSOdh7n6Zqu4u8olh82zpf3dfsXlunhrniDey+IRN1BWyoLJ3SWmIgK8B2duh
	udkEOZQlJ3PNjZHxEs9uXYpRbRjNlc//KQeY8nV8Cm66CKyJ2oG9ObqodaxibxlxFBwuNHN
	TOj6OELlGukuYB0IB233y6jzbqrzZCvwyNX7VpkGv2X63L6FhoFFWcfX7wy3QO9BNAu3bSC
	OjEXz+quXnKnVM+FLQ4smb/GvvQ6q9b7cmMkKIO4T6irAPEx1xkL5ccIKulwhWLpk5g34dP
	UVbGPQvCnG3CwwvxNmLuMAorv/yVz8k9YBr8G/b6LOWXa2PYaKMm+IP6Hbx9vEX6g==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Hi,

Please ignore v11. I found that the In-Reply-To threading is incorrect
starting with patch 2.

I will resend the series with corrected threading (24 hours later).

Thanks,
Dong Yibo

On Fri, Sep 11, 2026 at 07:24:16PM +0800, Dong Yibo wrote:
> Hi maintainers,
> 
> This patch series adds the packet transmission, reception, and link status
> management features to the RNPGBE driver, building upon the previously
> introduced mailbox communication and basic driver infrastructure.
> 
> The series introduces:
> - MSI-X interrupt handling with NAPI support
> - TX path with scatter-gather DMA and completion handling
> - RX path with page pool buffer management
> - unicast/multicast filter.
> - Firmware link-event processing and carrier management
> 
> These changes enable the RNPGBE driver to support basic TX/RX
> network operations.
> 
> ---
> Changelog:
> v10 -> v11:
> [patch 1/5]:
> 1. Drop MSI and single-vector MSI-X support. Require at least two MSI-X
>    vectors, reserving vector 0 for mailbox events and using the remaining
>    vectors for the data path. (Jakub Kicinski)
> 2. Prevent NAPI from re-enabling queue interrupts after the device is down.
> 3. Set the real Tx/Rx queue counts before registering the netdev.
> 4. Preserve the configured Tx/Rx queue counts when tearing down q_vectors.
> [patch 2/5]:
> 1. Treat a Tx DMA timeout as a terminal AXI fault for the current driver
>    instance, and document why Tx cleanup ignores the repeated idle-wait error
>    after the fault is recorded.
> 2. Free q_vectors after an RCU grace period, matching the RCU-protected
>    statistics collection path.
> [patch 3/5]:
> 1. Arm Rx allocation retry timers only after NAPI has been enabled.
> 2. Mask queue interrupts again after disabling NAPI and calling
>    synchronize_net(), preventing a completed poll from re-enabling them
>    during device shutdown.
> 3. Clarify the hardware guarantee for the first RX descriptor length.
> [patch 4/5]:
> 1. Advertise unicast address filtering support to the networking core.
> 2. Program receive filters under the netdev address lock before enabling Rx,
>    and clarify the hardware multicast hash calculation.
> 3. Clear the RAR valid bit before changing an address, and set it only after
>    the complete new address has been written.
> [patch 5/5]:
> 1. Quiesce Tx DMA before notifying firmware that the port is down.
> 2. Remove the stale mailbox-event boolean return value and document why a
>    failed mailbox read is not retried as transient lock contention.
> 3. Document the firmware link-event retry rate and mailbox ACK protocol.
> 
> Links:
> v1:  https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
> v2:  https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
> v3:  https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com/
> v4:  https://lore.kernel.org/netdev/20260526033539.164061-1-dong100@mucse.com/
> v5:  https://lore.kernel.org/netdev/20260528023150.239532-1-dong100@mucse.com/
> v6:  https://lore.kernel.org/netdev/20260604112750.769215-1-dong100@mucse.com/
> v7:  https://lore.kernel.org/netdev/20260611100036.36370-1-dong100@mucse.com/
> v8:  https://lore.kernel.org/netdev/20260731120322.895955-1-dong100@mucse.com/
> v9:  https://lore.kernel.org/netdev/20260814111317.1741087-1-dong100@mucse.com/
> v10: https://lore.kernel.org/netdev/F44E6669E6C9E7C4+20260831073608.401988-2-dong100@mucse.com/
> 
> ---
> 
> Dong Yibo (5):
>   net: rnpgbe: Add interrupt handling
>   net: rnpgbe: Add basic TX packet transmission support
>   net: rnpgbe: Add RX packet reception support
>   net: rnpgbe: Add receive mode support
>   net: rnpgbe: Add link status handling support
> 
>  drivers/net/ethernet/mucse/Kconfig            |    1 +
>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  201 +-
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  118 +-
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   43 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2248 +++++++++++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   84 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  158 +-
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   32 +-
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    1 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  235 ++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   43 +
>  12 files changed, 3138 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> 
> -- 
> 2.50.1
> 
