Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490222;
	b=YDC5aGsk2ZodtrqoHzkqEU/z/2ctUwU6whAmyntPmDT0fi67aenpNg0Hnino4ihTq1CD
	 AlmTNSWlvcqsXj/sa6uUGBe89jlxRpjpI9AyFg1Pi7N3mZuzqmnJOxHL2JsFZT13mIUIv
	 2ZdTMhZ7O7b4ohuGS3CzixoNSSAypuK7cFUuy+ykUFTOsJwEngCPaJCQhG2ge00vw+N8h
	 yEm1X6DycH7FAIM3zyd7HR5hVYlA3SMpcJXfXkHpIt8bgseB+n60+7BIs1ogEpRVUnL3k
	 GURIr7Zbnq2jhgn8OZv+TTZ1yog8G2ubBW9LjE4oPTb/zrPnhhFZDpKxVxAWPgK0oeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490222;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=N0kV5HWnrdvoOzEVA7fc1dLG0Iu29ZKv1qECO2lkSgM=;
	b=iu8Hx4AOGPan5Z9zyKtifvhnSEMMp0DE5jJBaBr0XpVgUCJGgfHVND0moiYZIrwCPrhR
	 ONAmfpLaawkv3mxFgB9hJkcgxJNINpfxK++TN1TedqqmEdPWReAkhRHwNIvqKdcOUf4Qk
	 UZifQIDyxaOBna2+iwUTEW9jZUpr/UpfL/NrCnpGJCuhhK3l9TZNDiADhHDCRDpXt5KmY
	 qjZs80tRfb5WsUdyO+g7wzK5p/O/J5jXKaBhw9C0Q6vqpDMwfFaOOxKYcHrrlwC9q4rQ4
	 8ooLf7we0T9rLwYD8on3SPTdhjnTtZ4WER8X5ko2twMBtmvY2BnLirqNdsO8lwnE27w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0qeCuAf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066A606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0qeCuAf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE091F00A06;
	Thu, 12 Nov 2026 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490221;
	bh=N0kV5HWnrdvoOzEVA7fc1dLG0Iu29ZKv1qECO2lkSgM=;
	h=From:Subject:Date:To:Cc;
	b=O0qeCuAfR/rQv7Uf08ro58zGX8D2b32pF495Hm5GxX2OghOKPMABz/8e0kIvTOMJU
	 UIMVr7aAPLr7uz3WIXjzhhFwfpPS2t0lQ7S3KezY2z1dkaoPCz6y5H+rM/cNvyGmZD
	 xGp4qBlu8eS4L/2gWudNYyJkeBOnK6exBO1e1jzSNPfAzHCuk+rMc7HsuiqSM9daV5
	 f0I4SgrfIQ/vohqj+vqMh/7c7uu+iwwx0XK1aPtKdw0tXHm/5AbWE7/DhIUEO2itFz
	 h7DXhoRNfKgPUpxl7w8R0fm32Lj2v/JzxMgrcC1/heViKUK31J3XFS2K61cK9AqCDL
	 dCKvoo/qaJc2g==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v8 00/19] net: ethernet: cortina: Fix Gemini RX/TX
 buffer management
Date: Thu, 12 Nov 2026 14:30:15 +0100
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/33RTWrDQAwF4KsMWkdFM+P586r3KF3ItiYZ2jrBN
 iYl5O4lLrQuxl2/xycJ3WCUocgItbrBIHMZy7mHWsWDgvbE/VGwdFArMGQ8JZ3wKB+lLyjTSYZ
 eJszlKiNazFSR9c5mYxkOCi6DLBHU6gUexV6uE7weFJzKOJ2Hz2XkrJf8Wze0q88aCS0bdsTRd
 jE9vz0K70/n4bigs1lDcR8ySBhc5JBcFzjEDWR/IE1k9iH72Eh0Ni4mYtlC1QrSeh+qkLBqtLe
 6oZhdt4HcGnL7kEPCxrVJTA5NZLuB/C+kye5DHgnbqnE5R/au254WVpD+52sBCVNrDWuuPEv7B
 7rf719CM1mPfwIAAA==
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

Target the series for net-next, Sashiko keeps insisting to make some
patches Fixes: tagged, and yeah maybe it's true but OpenWrt is the
only user and I will surely backport all patches to OpenWrt anyway.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v8:
- Protect TX fragment statistics updates during process-context teardown.
- Rebuild idle shared free queues on reopen to reclaim unclaimed fragments.
- Separate RX buffer capacity from retained-pointer descriptor ring sizing.
- Preserve PHY probe deferral and clean up fixed links on probe failure or removal.
- Link to v7: https://patch.msgid.link/20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org

Changes in v7:
- Bound free queue refill work and release surplus metadata on downsizing.
- Serialize TX completion statistics with the IRQ-side writers.
- Fix ethtool statistics retry bounds and counter synchronization.
- Reject pfmemalloc pages when recycling RX buffers.
- Document XArray dependency for lifetime and recycling backports.
- Reject TX rings smaller than retained hardware pointers, so now the
  series has also started to fix things on the TX path.
- Document the retained SWFQ pointer shrink and allocation limits.
- Keep ports IRQ-only after PHY setup or netdev registration failure.
- Keep parent-held port clocks enabled through IRQ draining and queue teardown.
- Link to v6: https://patch.msgid.link/20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org

Changes in v6:
- Initialize statistics synchronization objects for lockdep.
- Post free queue pages from the exact retained descriptor pointer.
- Document replacement-page lookup failures and tag the DMA mapping fix.
- Initialize and drain the RX coalescing timer around its IRQ lifetime.
- Rebased on v7.4-rc1
- Link to v5: https://patch.msgid.link/20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org

Changes in v5:
- Preserve complete frames terminated by an empty EOF descriptor.
- Recheck concurrently retired pages before consuming fresh metadata slots.
- Fold RX ring metadata sizing and resize rollback into the page lifetime
  fix.
- Match free queue teardown unmaps to the saved full-page DMA mapping.
- Preserve the hardware-owned free queue read pointer across rebuilds and
  keep replacement rings large enough for its retained position.
- Keep shared initialization parent-owned, quiesce inherited IRQ state
  before child handlers register and force first queue setup from ring
  state.
- Link to v4: https://patch.msgid.link/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org

Changes in v4:
- Protect stop-path RX statistics updates against preemption on 32-bit systems.
- Validate final RX lengths against the Ethernet minimum and descriptor
  transfer size so malformed chains cannot pass short skbs to GRO.
- Charge the full posted RX fragment size in skb truesize accounting.
- Reject free queue geometries that cannot post one complete page and
  document the changed refill and recycling behavior.
- Reset the free queue allocation cursor with its bitmap during teardown.
- Bound recycler IRQ latency and release retained mappings for stack-owned
  pages before allocating replacements.
- Rebuild oversized free queues while both ports are down so RX ring
  downsizing releases the surplus pages.
- Scope RX statistics writer sections to counter updates for PREEMPT_RT.
- Restrict shared free queue handling to port 1 so IRQ draining covers
  every registered handler path.
- Reset and mask free queue pointers when rebuilding the queue.
- Reorder the shared queue ownership fix before the port lifetime fix.
- Publish ports only after setup, serialize their lifetime with RTNL and
  suppress independent child unbind while port 1 owns the shared IRQ.
- Move child-unbind suppression and PHY teardown ordering into the
  parent-ownership patch.
- Link to v3: https://patch.msgid.link/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org

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
Linus Walleij (19):
      net: ethernet: cortina: Keep shared free queue parent-owned
      net: ethernet: cortina: Keep ports bound for shared IRQ
      net: ethernet: cortina: Drain free queue IRQ before resize
      net: ethernet: cortina: Normalize free queue pointers on rebuild
      net: ethernet: cortina: Correct free queue DMA mappings
      net: ethernet: cortina: Index free queue fragments with XArray
      net: ethernet: cortina: Preserve in-flight free queue pages
      net: ethernet: cortina: Rotate free queue page allocation
      net: ethernet: cortina: Recycle claimed free queue pages
      net: ethernet: cortina: Separate RX buffer capacity from free queue size
      net: ethernet: cortina: Validate RX fragment lengths
      net: ethernet: cortina: Account RX buffer size in truesize
      net: ethernet: cortina: Release partial RX frames on stop
      net: ethernet: cortina: Scale Gemini RX queues to system memory
      net: ethernet: cortina: Serialize TX completion statistics
      net: ethernet: cortina: Scope RX statistics updates
      net: ethernet: cortina: Drain RX coalescing timer on stop
      net: ethernet: cortina: Reject TX rings smaller than retained pointers
      net: ethernet: cortina: Fix ethtool statistics reads

 drivers/net/ethernet/cortina/gemini.c | 1009 +++++++++++++++++++++++++--------
 drivers/net/ethernet/cortina/gemini.h |    2 +-
 2 files changed, 766 insertions(+), 245 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260919-gemini-ethernet-fixes-3-f0403653f23a

Best regards,
--  
Linus Walleij <linusw@kernel.org>

