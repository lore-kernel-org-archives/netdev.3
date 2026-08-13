Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F530D41B;
	Thu, 13 Aug 2026 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590026; cv=none; b=aJeMB+ta6RlqUwW4+tkKFnFaiTS1SoI+/XSPeiHI911fLKLPPbRz23L18WxN+rY3xSK1JaDBD9o6a5jtjTFn8TUkMokxuUGW11tgGaM+17ExnnpMn3MWlyfy41wwqQNZYR1jcHXHHIeBC1CL9cC1Xn+1VH6UIGlCYVt/VCiU7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590026; c=relaxed/simple;
	bh=Vn8ezTcLhHGXExJZyyyAOHcEwebGtFcvE4YHb0uscGQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kRkQjW9ViKOKy11nDtxu3t+xq5xt9VxT8nGBEAZ/JRKxXpVd29ZCXJJeBxgTp+cNFYBQ0k3mpAXBTiFQNQ+6w3cxkKCEThe03t8Ckz7jz0jv0bE32Mg/VWmElEjdcTDNkJ077tgYCIdbwPPzyPwhlSkTCa61nxaYN5HqND6/AMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOYL+f7M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOYL+f7M"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63174C2BCB3;
	Thu, 13 Aug 2026 03:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786590026;
	bh=Vn8ezTcLhHGXExJZyyyAOHcEwebGtFcvE4YHb0uscGQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TOYL+f7MiWdtAGEXcI1NY1ekyc88ok/DwBYrURxiuh9fNPWC42l3MH4oHU/b7JbLe
	 T3wUQ/c22XsMA3W2BDd6A9dCg8K0305mh6YE8XgTR3ckwzVKvpT8u/DrS+j3f9Rgri
	 zMTMX+r9UMsSfRFu7ZUfNWgmyEaG/KCk/Dp8PAL7UxwYQW//Hn1OxIP93FArjaRqAo
	 3ZA1ocbv1IDE0tlmjr430IhyQOY0ZtXZriq4W5dP6I+GCma/J6Rsip52QDmh5dNT0H
	 h72FsNX1/xvfgQ9gaIaPGnBrWHMq33wOWhBW0aB3L2ialwVl4j1hy9awN9+Y+9eoO3
	 5sQJ7ZtABvFyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA49C5B572;
	Thu, 13 Aug 2026 03:00:26 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH net v6 0/4] Fix to possible skb leak due to race condtion
 in tx path
Date: Wed, 12 Aug 2026 20:00:08 -0700
Message-Id: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgzfWoC/43QuW7EIBAA0F9ZUYdoOAZDqvxHlIKFcUyxEIFlJ
 Vr538O6iSMXTjmH3hx31qgmauzlcmeVltRSyT0wTxcWJp8/iKfYYyZBGjBS8DF98eoD8VByTHN
 v5z5HHqpvE3c6AqI3BoNmnfis1Ps3/o1lmtl7T06pzaV+byMXsZX+py+CA7cDSQfRKRzG15Ib3
 dJzKLdNXuReMyea7NrVBAwCyIA+aupXGwBPNNU1RSisFtS/YA+a3mkSTjT9uFQOiuSorBfH3XC
 vuRMNH7s5MNegLUb/V1vX9QfFXyVmBgIAAA==
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786590011; l=4620;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=Vn8ezTcLhHGXExJZyyyAOHcEwebGtFcvE4YHb0uscGQ=;
 b=6pVPQdedMqDNCxO7uSgF8v0iGON/mjhEtWcoHuFzMGy1fN7uUYsftsWmt6yqASNql0cqMq8zx
 v73dq8OdPYIBxJIoVlygOcov8o1v3Eo2s2iXMZ0OTxT5gdStaFMV0T5
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

Now the traffic is handled in threaded IRQ, and the
disable_traffic flag is checked before handling the
data, new race condition is exposed, in which
buffer may leak, if threaded IRQ interrupts the
trasmit path midway.

With this change, disable_traffic and waiting_tx_skb
pointer are protected by spin lock/unlock pair.

This is highlighted in Sashiko review
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260611-level-trigger-v5-0-4533a9e85ce2%40onsemi.com

Also on buffer overrun condition, probably due to loss of
SPI data chunks, receive path doesn't see the expected
data chunk with end_valid bit set. As a result, driver
keeps adding data chunks to the skb before running out
of space and kernel panic is seen.

With this change, before adding data to the skb, if there
is no space, skb is freed and driver starts looking for
new frame by looking for a data chunk with start_valid
bit set.

[  705.405490] skbuff: skb_over_panic: text:ffffffd2eb72a264 len:1600 put:64 head:ffffff804e5cdc40 data:ffffff804e5cdc80 tail:0x680 end:0x640 dev:eth1
[  705.405569] ------------[ cut here ]------------
[  705.405575] kernel BUG at net/core/skbuff.c:214!
[  705.405589] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP

[ 6703.427690] Call trace:
[  705.925157]  skb_panic+0x58/0x68 (P)
[  705.928726]  skb_put+0x74/0x80
[  705.931772]  oa_tc6_update_rx_skb+0x44/0x98 [oa_tc6_mod]
[  705.937084]  oa_tc6_macphy_threaded_irq+0x3f4/0x900 [oa_tc6_mod]
[  705.943084]  irq_thread_fn+0x34/0xb8
[  705.946654]  irq_thread+0x1a0/0x300
[  705.950134]  kthread+0x138/0x150
[  705.953356]  ret_from_fork+0x10/0x20

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
Changes in v6:
- Changed the rx_buf_overflow flag to appropriate one
- Using skb_tailroom instead of fields from skb
- Updated commit IDs and comments to be accurate
- Link to v5: https://lore.kernel.org/r/20260729-fix-race-condition-and-crash-v5-0-3906bc485daf@onsemi.com

Changes in v5:
- Fixed typo in commit messages.
- Changed the commit message to be more accurate.
- Fixed the wrong data type used.
- Link to v4: https://lore.kernel.org/r/20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com

Changes in v4:
  - As disable_traffic means device is uselss unless
    driver re-loaded, all tx queues are turned off.
  - Process all the received chunks on buffer overflow,
    as long as data chunks doesn't have any error bits set
    in their footer.
  - Added spin lock protection in every place wait_tx_skb
    is used.
  - Carrier is not turned off on disable_traffic.

- Link to v3: https://lore.kernel.org/r/20260705-fix-race-condition-and-crash-v3-0-3e51841e4d08@onsemi.com

Changes in v3:
- Cover all the instances of disable_traffic flag with
  spin lock to serialize the access
- Disabling the tx queue and mark the carrier off when
  disable_traffic is set.
- Continue processing received chunks on buffer overflow
  error and "out of skb" error.
- Link to v2: https://lore.kernel.org/r/20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com

Changes in v2:
- Improvment to how error -EAGAIN is handled. Took care of
  couple of use cases where start_bit and end_bit may be missing or
  repeated due to lost data chunks.
- Protected handling of waiting_tx_skb pointer with spin lock
- Link to v1: https://lore.kernel.org/r/20260621-fix-race-condition-and-crash-v1-0-87e290d9357f@onsemi.com

To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>

---
Selvamani Rajagopal (4):
      net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
      net: ethernet: oa_tc6: Improve the error recovery
      net: ethernet: oa_tc6: Disable tx queues on fatal error
      net: ethernet: oa_tc6: Fix for the wrong data type

 drivers/net/ethernet/oa_tc6.c | 260 +++++++++++++++++++++++++++++++-----------
 1 file changed, 191 insertions(+), 69 deletions(-)
---
base-commit: 2bb155e92167cd5ad6aae312e83291da2454f8b0
change-id: 20260621-fix-race-condition-and-crash-94d055a665c4

Best regards,
-- 
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>


