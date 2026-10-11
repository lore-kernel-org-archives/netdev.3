Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD539524D
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791741981; cv=none; b=VnzaFAK3yKJ55T2MeuvZFLVGviD97a0xpY+8057PsrFvreB5MrOpVdtfCEuWtNOJBttvPBlHAB96OV9LB/kTM/SMka0xrimSdGYyWnjfYEVomXPVeiKo+o3R6bCo4qIHyNjrYkwDUOXnfY+O6PO52tIA5z3MbXXemp3cCW1Ls4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791741981; c=relaxed/simple;
	bh=sGfJW37kF+KsguqA/h5BGHN/eEQlOxbqPWqn7IZN5V0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M0z0j63f7buwYanAqgrZ/R1LJ+Y8kIKvkawsgM72rDKST++LQT80GmnZNn0iyK3KBovwZdMhFpj7QwDbL14F/YpOvVS6yAgpOcCds6xQeVePDn76K8O/SNOXd702gtCP7A+qFAif06bprfVBth6BZLg9yKb+MWxvy9gMDlYAfh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fawkdbhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fawkdbhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F6A1F0089B;
	Sun, 11 Oct 2026 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791741980;
	bh=C0ERb+sK5qUvcSh3exjFOgvRdFPzyk/DvYlg9dDjAQ8=;
	h=From:Subject:Date:To:Cc;
	b=FawkdbhrTmVkJjOqTUusGgQIJdo8BmRnFmSIjB3hh2B0FlV1wX7t5YYGLP1KqVOC8
	 20lC5fnV325A0Znq2KUsgJgLJVuBB6vqGVwDb0DOb6h9KAbMvdACNLkHMKicvzXVVp
	 i5TiLQ2ZbXNwbWWdPUIr3EAquK7+e1lqkuY/fNrtGaVDGow47pnaWBPwxZdzVpYrkI
	 IcyQY36dOXeY+VCfD4Rta0+M7It8xVeAIRabcLnBeG34VwpHhlrjwTwQR9cmyyjEdO
	 BpjJvXoCthsGVaKPi6AdjUw7DOYfIefAFdRoKz+FxyE4/Jnq74sTVrVvkA2Kv1CDH4
	 aiYF7eU3WyXig==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v4 00/15] net: ethernet: cortina: Fix Gemini RX
 buffer management
Date: Sun, 11 Oct 2026 20:06:13 +0200
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOwQ6CMAwG4FchOzvTdQw2T76H8bBIgUUdZiMEQ
 3h3ByZGYzg2f/+vnVik4CiyQzaxQIOLrvNpyHcZu7TWN8RdlWaGgAUYYXhDd+cdp76l4KnntRs
 pcslryEEWStYoLUvtR6A1SuUTWxY9jT07p6R1se/Ccz05iDV/6wib+iA4cGnRKrBaVtocr8vCb
 d+FZkUH/Ib0NoQJKpW2pVFVaUv9B8kPJABwG5LLRyRqVNqApV9onucX1j3T2FsBAAA=
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
      net: ethernet: cortina: Rebuild free queue metadata for RX ring changes
      net: ethernet: cortina: Rotate free queue page allocation
      net: ethernet: cortina: Recycle claimed free queue pages
      net: ethernet: cortina: Validate RX fragment lengths
      net: ethernet: cortina: Account RX buffer size in truesize
      net: ethernet: cortina: Release partial RX frames on stop
      net: ethernet: cortina: Scale Gemini RX queues to system memory
      net: ethernet: cortina: Scope RX statistics updates

 drivers/net/ethernet/cortina/gemini.c | 783 +++++++++++++++++++++++++---------
 1 file changed, 581 insertions(+), 202 deletions(-)
---
base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
change-id: 20260919-gemini-ethernet-fixes-3-f0403653f23a

Best regards,
--  
Linus Walleij <linusw@kernel.org>

