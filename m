Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A84848BE
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585442; cv=none; b=j1mCiH3vtRV3aii8aHSP11WYUNmyhIxFRngZwGs+60bERxAnJsMTnmfMR3U9U5GhcxPQCO2mSe8t077PwjFgyc56j2YSSXCz9RHSKgJOxYpzm/b34SNwNDXQ2nmMQczLSvsyLw4bwy1Qyp5ogkM90hEwJsRYUqFcaDqAk28q0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585442; c=relaxed/simple;
	bh=kxYaYiEHDMS4m3fVw67y8ftjVeCbEffDronW4N0WsGM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mJU8BDwNwEG0bplpjqMnYONv6O3jXGDcxNeaNpjEAeEjGs0U6UyaczYwrFEgS/mi0CR0JxUpVuFSSh53D3OyyAD83cjZI4EMh3xj4J1jTy1Mm5c4ndbIHeeQnycmGwGenTlkd+VWk0Jj4Hn6hbiV9aVrh54BTUZoewxqsjkF3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPuo7BVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPuo7BVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA391F000FF;
	Mon, 28 Sep 2026 08:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585439;
	bh=6pZC0pcMP3A7jIwgAYdpG9lTyipNmzfLYRGU9KDOJXI=;
	h=From:Subject:Date:To:Cc;
	b=NPuo7BVixNfW/m+PIbYW5iAJI1mPzuvkO5iyjNc5L2BnxPAoq1tg9FLvpTrcQFrvk
	 tM2xL49FBoJKMpoIUsPR8uhYyu5scGhorrclePECkN77Jq6273tIo8P0r0vi5v8sMb
	 bZmSgBJozNjR8aUcHQjgQE/yb2hjuEnBVIX0HrcktOUPD7kOYWds2rXAK4aENmNyF6
	 PNXztSiqFpai+N5AYPr9ghWlJpEpSuvPsx6ZmNwqGIskWWeczR4gIUfncamtfmzoh5
	 M2hwTS0cZKDnokdIPO9c85/JADE2s9QYZeie72KdoT9PKS0h0lAcu/M2hbNg4cPleF
	 wPRTJW8gekUnw==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v2 00/11] net: ethernet: cortina: Fix Gemini RX
 buffer management
Date: Mon, 28 Sep 2026 10:50:26 +0200
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4Xs2TVLKwQ8+R+GQyNL2aiFtA3BE
 P7dUs8eJ2/ezAaBvXCAa7GB50WCTC4FdSrgMRpnGaVPGRSpmtqyRctvcYIcR/aOIw6yckCNA11
 I15UelDaQ7NlzRkm+w1F0vEboEhklxMl/8uVSZv5bV/R3fSmRUBtlKjKN7pv29jwKr/PkLXT7v
 n8BmgkLiskAAAA=
X-Change-ID: 20260919-gemini-ethernet-fixes-3-f0403653f23a
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
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
Linus Walleij (11):
      net: ethernet: cortina: Keep shared free queue parent-owned
      net: ethernet: cortina: Drain free queue IRQ before resize
      net: ethernet: cortina: Correct free queue DMA mappings
      net: ethernet: cortina: Index free queue fragments with XArray
      net: ethernet: cortina: Preserve in-flight free queue pages
      net: ethernet: cortina: Rotate free queue page allocation
      net: ethernet: cortina: Synchronize RX fragments for the CPU
      net: ethernet: cortina: Validate RX fragment lengths
      net: ethernet: cortina: Release partial RX frames on stop
      net: ethernet: cortina: Scale Gemini RX queues to system memory
      net: ethernet: cortina: Use guard helpers for locking

 drivers/net/ethernet/cortina/gemini.c | 577 +++++++++++++++++++++-------------
 1 file changed, 358 insertions(+), 219 deletions(-)
---
base-commit: 2ff4ca33660706f4092866b220eb0c94940f7e0c
change-id: 20260919-gemini-ethernet-fixes-3-f0403653f23a

Best regards,
--  
Linus Walleij <linusw@kernel.org>

