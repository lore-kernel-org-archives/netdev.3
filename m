Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728278;
	b=sNACsoQ76II7QtAML9MrWfQ66upgBBgg9iiD6sLd+UPkUR93TWQ9rxUzjeoCHE1Lp9y0
	 k0VG3PP8Dqe4Gzh7Kp5Sn9b8S3a/NPzAKYv6Ky0bwrPhqjjSQZtLbI92GlkgtV+GoEYv5
	 h3sqr6KmhnIcakENvF+6K6mWLwbztaK3mSipJsZz8SrQIE2/NGowJTnFe2PlJBe/qsQTB
	 DOGMa9LFmVvPXuyQBasMBwiHLdOsCy+gnmX/vs/o7FPAxkDHPNi7Othfb8x32XAkuMFvi
	 fTZVH6hOJkhdLWj6iwVhKPSvKL9TGrgBSb8hCa8ARq2ZLqa5MNlrVOV2xBEU56EMcWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728278;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=GDkc5XXDLv+g9iQnJesGML/aYVxdmCCeQ+1iskneDDQ=;
	b=3BFlmcsz0cBmM3F0NLQf5VvU2r4fy79wwr14Z63I6uSuYz5uw4Y7ssaWps1+/vKrYRwu
	 GloPv7InrQii4RP0JeBrob0tLiMSC8cZT/UDWDU9vG+iEQyU9Ma5UCbeAiZDmBgEz4CpI
	 AwqxIfwrTZCyT7VVe0czKjivH32hXAW0XTcI+2EWKkCKOaocFFN2jgFapAUpia43m2dQg
	 3B90cDEh1NTpMv0iW4Ji62UinCzM8SQsnZ1degGgHaRVlMIXhDOFTl0MvDR+zQWyFINJX
	 3OB8KWdW8WvjzLcjyE2KVQl9L1nhVbb0hKpXjwt0Yx4L3dJB8J3kqv/sWTBoZiWdGyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qny0aWgS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95F606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qny0aWgS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AB21F000C1;
	Tue,  3 Nov 2026 17:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728277;
	bh=GDkc5XXDLv+g9iQnJesGML/aYVxdmCCeQ+1iskneDDQ=;
	h=From:Subject:Date:To:Cc;
	b=Qny0aWgS2vZpeDpO7YuZYn9jznygpcsduzCfOw/O3WaA/xKjsDDHMKd5U/xX0idZU
	 Rdi+ALiMxWYLzq8y3ZbcyiL86E79vU51GOCdqQ3YrvAcDv4E6K8fGOBSWjmO3QiYrD
	 FUuysvqKADsll7c5VuzeVUo7UKsbRnl+BH3PYUeMJvE5+n41pO+I29QUm2YwR3JH+A
	 ytZHusnCd8qncvxop91NSpmSpfa8WO16wGouIqgokP61MpVWNUXIcbvS5XddpJlzak
	 AtD+2Cxh1WIl/4lY6O2EOrcRaJqsVuz/hDl1aFP5eEkgqjGqJ4+qRTOHfPfLaKEAA+
	 tZoaqHQcJnNnA==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v6 00/15] net: ethernet: cortina: Fix Gemini RX
 buffer management
Date: Tue, 03 Nov 2026 18:51:11 +0100
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOwWrEIBAG4FdZPNcyaibqnvoepQezGRNpa4qGs
 GXJu9ekUFKCx+Gf/5t5sEwpUGbXy4MlWkIOUyxD+3Rht9HFgXjoy8wkyBassHygzxADp3mkFGn
 mPtwpc8U9NKBaVF4qx0r7K9EelfIr2xYj3Wf2VpIx5HlK3/vJRez5ry6hqi+CA1dOOgRnVG/sy
 /u28PE8pWFHF3mETB2SBdJonLbYa6fNCVJ/kACQdUhtH5HwEo0FR2eoOUBC1KGmQE0nWiU6MB7
 7E4RHCOsQFqjDmyXpdWec+get6/oDr/7oA+0BAAA=
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
Linus Walleij (15):
      net: ethernet: cortina: Keep shared free queue parent-owned
      net: ethernet: cortina: Keep PHY-less port bound for shared IRQ
      net: ethernet: cortina: Drain free queue IRQ before resize
      net: ethernet: cortina: Normalize free queue pointers on rebuild
      net: ethernet: cortina: Correct free queue DMA mappings
      net: ethernet: cortina: Index free queue fragments with XArray
      net: ethernet: cortina: Preserve in-flight free queue pages
      net: ethernet: cortina: Rotate free queue page allocation
      net: ethernet: cortina: Recycle claimed free queue pages
      net: ethernet: cortina: Validate RX fragment lengths
      net: ethernet: cortina: Account RX buffer size in truesize
      net: ethernet: cortina: Release partial RX frames on stop
      net: ethernet: cortina: Scale Gemini RX queues to system memory
      net: ethernet: cortina: Scope RX statistics updates
      net: ethernet: cortina: Drain RX coalescing timer on stop

 drivers/net/ethernet/cortina/gemini.c | 855 +++++++++++++++++++++++++---------
 drivers/net/ethernet/cortina/gemini.h |   2 +-
 2 files changed, 631 insertions(+), 226 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260919-gemini-ethernet-fixes-3-f0403653f23a

Best regards,
--  
Linus Walleij <linusw@kernel.org>

