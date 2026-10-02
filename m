Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8394AB1DD
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958288; cv=none; b=Mi7kpTSRSBwCmtRrVxOax3LhMO6RiYasYCfIxPIl4KJF3xiUcbh4vx2NZ0qztjNPtCyeNvCVXxTsH4JWk0ntgzhmVdsybSOiwxfWYDpHxNZSV8x4DT8OAnMpmi0gU/dLpk9NIE5KMd6BZodS/XkLAGtfmc2tHoXKsaRUJZVbmHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958288; c=relaxed/simple;
	bh=ptWAjZnx4JUlz94PFadcWH/SLIezHeakDWu93ZZrWhc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dUloszSBxog59v5DBijGAHDQHAxta5kI8go+H8Fq4o10W/PSu6gU/z6KqZ+ou9YLbxb+QNyR82zchmoAjK3D1Ffe6yl9ktykNLEQ5q+6DbEdUjgGzZah23ZjPk1kpzOa0IDHET1Y3PysLDCJ9/uQDrAau/BP3X5+sRJ7Lp8jpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zej3FWHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zej3FWHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969951F000FF;
	Fri,  2 Oct 2026 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958285;
	bh=3dbx2y+UWvYElTwetsRZpNeH1k+YbWJz0h2+r4Jg5Rk=;
	h=From:Subject:Date:To:Cc;
	b=Zej3FWHkf+v1zgsXUfMOGTstpzq7TGy+cgWRXzFjCdx0t1vJHglfiHxKZSsXjyjLI
	 4/sxHCOgWVZtcqxhCXbDRD1wz/1enR2AxVg6bV9HukyXujYk3hVWkUnIt1Mst5wQ5+
	 Id634poGWUDgQrW1zQIwdc78c4UI1jA9ncFbOBPR2JVoJ1q24KfTqFlw0Z4rpf4ULB
	 z7/nimQA8pe2FQaCWLNhx5nFptPYjZkUkGZUKxdUhwYLCzzK/NmfCIwQP4V9ooZGwM
	 2KDVzbx2WAj1LA7m0Fmop39YyL5I85DD3vCSZLHCTDEHZAe75h/HuK46Kv1P3j63R5
	 UYv3hb+0Dfc8Q==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v3 00/12] net: ethernet: cortina: Fix Gemini RX
 buffer management
Date: Fri, 02 Oct 2026 18:24:39 +0200
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ7CIBAF0KuYWTuGghTqynsYF8ROW6JSA4TUN
 L27FDe66PLnz38zQyBvKcBpN4OnZIMdXQ5iv4PbYFxPaNucgTNes6ZqsKendRYpDuQdRezsRAE
 FduzIRC1Fx4WBvH55KlUeX2A9dDRFuOZmsCGO/l1epqr0X52zTT1VyFAYbiQzWrS6Od/Xg8dh9
 H1BE/+F9DbEM6SkNqqRrTJK/0HLsnwAIuaw/hIBAAA=
X-Change-ID: 20260919-gemini-ethernet-fixes-3-f0403653f23a
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The Gemini ethernet uses a custom software free queue shared by both
ports. Its page metadata, DMA mappings and fragment references are not
managed consistently as pages move through the free queue and RX queues.

Correct the DMA address bookkeeping and synchronization.

Track exact fragment mappings with an XArray and keep
in-flight page metadata in bitmap-allocated slots until all hardware
references have been claimed.

Serialize queue resize against the refill interrupt, harden fragment
validation and teardown, then scale the default queue sizes for systems
with 32 or 64 MiB of RAM.

This series wasn't so complex to begin with but Sashiko and the other
LLMs just find more and more corner cases. It's for the better I
guess.

Before these patches the network driver would crash under strong load
but it does not happen any more after. Tested on the D-Link DIR-685
playing back media and transfering new media using ksmbd while
issuing ping storms.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v3:
- Add Fixes tags throughout the series, using the original driver commit
  where no more specific offending commit exists, and replace Resolves with
  Closes on the lifetime fix. I did not retarget the series to net
  because there are dependencies in net-next and we are getting closer
  to the merge window.
- Keep PHY-less port 1 bound as the shared free queue IRQ owner and clear
  stale parent port pointers.
- Disable the port 1 Linux IRQ throughout free queue resizing so no newly
  woken threaded handler can race queue teardown or setup.
- Keep failed queue rebuilds quiescent in the IRQ-drain patch.
- Serialize linear DMA lookups before converting them to an XArray.
- Keep all XArray mutation under the IRQ-safe free queue lock.
- Defer page unmapping until fragment lifetime is tracked, and fold DMA
  synchronization into that fix.
- Check free queue space before allocating and mapping a candidate page.
- Rebuild free queue metadata when RX rings grow and roll back rejected
  ring changes.
- Recycle released pages with explicit DMA synchronization using the
  existing free queue allocator.
- Account inconsistent RX descriptor lengths as drops rather than wire
  length errors.
- Count partial RX frames discarded during stop as dropped.
- Drop the cleanup guard conversion because it is not recommended for
  network drivers.
- Link to v2: https://patch.msgid.link/20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org

Changes in v2:
- Replace the page_pool conversion with several smaller fixes using the
  existing free queue page allocator.
- Split DMA bookkeeping, XArray lookup, bitmap allocation, cursor rotation,
  synchronization, validation and teardown into individual patches.
- Drain the threaded free queue interrupt before resizing the shared queue.
- Allocate and DMA-map refill pages outside the IRQ-disabled free queue
  lock.
- Reject and unwind partial initial free queue fills, reset their hardware
  pointers and leave the refill interrupt masked so setup can be retried.
- Avoid full-page CPU synchronization after fragments enter the network
  stack.
- Bound RX lengths to the posted fragment and account rejected lengths as
  receive errors.
- Keep the fixes, and keep the add-on RAM sizing patch.
- Link to v1: https://patch.msgid.link/20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org

---
Linus Walleij (12):
      net: ethernet: cortina: Keep PHY-less port bound for shared IRQ
      net: ethernet: cortina: Keep shared free queue parent-owned
      net: ethernet: cortina: Drain free queue IRQ before resize
      net: ethernet: cortina: Correct free queue DMA mappings
      net: ethernet: cortina: Index free queue fragments with XArray
      net: ethernet: cortina: Preserve in-flight free queue pages
      net: ethernet: cortina: Rebuild free queue metadata for RX ring changes
      net: ethernet: cortina: Rotate free queue page allocation
      net: ethernet: cortina: Recycle claimed free queue pages
      net: ethernet: cortina: Validate RX fragment lengths
      net: ethernet: cortina: Release partial RX frames on stop
      net: ethernet: cortina: Scale Gemini RX queues to system memory

 drivers/net/ethernet/cortina/gemini.c | 632 +++++++++++++++++++++++++---------
 1 file changed, 467 insertions(+), 165 deletions(-)
---
base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
change-id: 20260919-gemini-ethernet-fixes-3-f0403653f23a

Best regards,
--  
Linus Walleij <linusw@kernel.org>

