Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3553FD960;
	Tue, 21 Jul 2026 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600492; cv=none; b=NtyxXO61S4IYKGavWncWTpa6sfx3//J6VmcOGxYjE3nWKHeURXkvxJmu9QQmz/cDLkFMAFSDm56/a1clhYDEO7oXFkKIOAeV+1RtsvuG+JgC2/CzQmdWHxqd5PxH7/JDkuTzNUvzWsvs4gp3ILsJHskDNI+/T4sJWtYWrl3dhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600492; c=relaxed/simple;
	bh=EVgsh6UMa3GTJAJhgZSNBxZRLmpDbQsr69w5Q+r3Lrw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nP8P+JygfAu5YBbZLgkKIiIvK1v36XXXtA/zYQMjbh+7SzzCr+OATHuIlf5dNBSTBFpnJPhCyqyEfqwX9jSU5MENOJuRHf2q+5MTVZcNuD8yyP+raEtT3QWGC6/uSReXf3S0SbDMj7Z6nUXu8SUh7WdNM6Gfkd6IfhYVCpgqcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDgZJNfc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDgZJNfc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB64DC2BCB8;
	Tue, 21 Jul 2026 02:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784600491;
	bh=EVgsh6UMa3GTJAJhgZSNBxZRLmpDbQsr69w5Q+r3Lrw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FDgZJNfcxC4AonPN1zqnuLnkukNyBEGYQCSQBVJE/ojAuXRLSyBSn3vjsv6wWSNbl
	 EamGDbeLQJAwxyT/gzMZvt69EhC0T/kmhhxkg73+Vc9P6HKoyxYnAkPRoaMYis3V7M
	 B1ULjHUnS4pVhiADwKYWL8IMPky4pqz+NqYQeWj22m4sCcKZDBuZWyAMaRhP5QcK82
	 7ngL9BHZ4zsaX3x5RLBYmytQlyA3w09ZY6Kb3vNoDHXiiXkpRhUlkDK9jzGbGDJyE6
	 RKNDzOYUfGguml9M0YacALxTJN1ujWPb62HZBBF9RwYsf4r9+ZFJVdDTzItYBROgSn
	 8SFBlxe1vEryw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE2C44524;
	Tue, 21 Jul 2026 02:21:31 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH net v4 0/3] Fix to possible skb leak due to race condtion
 in tx path
Date: Mon, 20 Jul 2026 19:20:34 -0700
Message-Id: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHLXXmoC/43QwQ7CIAwG4FdZOFsDDNjmyfcwHhA6x0EwsCyaZ
 e9us4saD/P4t3++Jp1ZwRywsEM1s4xTKCFFCmpXMTfYeEUInjKTXBpupIA+PCBbh+BS9GGkOtj
 owWVbBuiU51pbY7RTjIh7Ruqv/IlFHNmZhkMoY8rP9eQk1tV/+iSAQ9ug7Ljvat30xxQL3sLep
 dsqT/JTMxuaJO1inHaCo+HqV6vfWsP1hlaTVqMWrRJIX2i/tGVZXupOfBNqAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784600442; l=3567;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=EVgsh6UMa3GTJAJhgZSNBxZRLmpDbQsr69w5Q+r3Lrw=;
 b=zscnJa/K/qdSZAXt6eVsKKUYl6NvWTTdiCiUEYYBfZygZLEc8ScMQk9hwThDQ627EEaqBJeNu
 InC6I7e977bDoddw3xWTE/s2rv7VdUNCZMW9h5uCDSid8YcoK1ZOB/q
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

---
Selvamani Rajagopal (3):
      net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
      net: ethernet: oa_tc6: Improvements to error recovery
      net: ethernet: oa_tc6: Disabled tx queues when disable_traffic is set

 drivers/net/ethernet/oa_tc6.c | 236 +++++++++++++++++++++++++++++++-----------
 1 file changed, 175 insertions(+), 61 deletions(-)
---
base-commit: 1c975de3343cdef506f2eecc833cc1f14b0401c4
change-id: 20260621-fix-race-condition-and-crash-94d055a665c4

Best regards,
-- 
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>


