Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F51F4181
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770461427; cv=none; b=Pcq7oq29kzGcLAha5e7PIDkxJZV9s9Yy/sFhFqV9Q2KJ0Dmoll28FjQdll+6jz5ORrKaqlgMx0NYcWHB00JHDYf3wC+77pi7gFYypLyUpsji/MfALyKn1KVaE4PxzNFkopasQVPXRyZkr0v1EukYIdrryaCbJWZwZNEg0+BR1mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770461427; c=relaxed/simple;
	bh=6OZX7EKogGNAZsj0RNloLVy4u0hDyHPuVJ6PiQoyoFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LkN1MkB8iWExUul2dIRRyCXGiU8b6ZeXkpFidhVEjScGg1IWhldZhuhrYjuorN/NvYW74Uuul4KLNI5Y2Kjr5hyaj7sMpV5RO6vVFhp2itLFupP88ROBE+ZkvZjGM06QtuSVxH6QHuGOcdEUpLOWewIqX5lSogkFW3Fvy5DRBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3KOAyK3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3KOAyK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BF4C116D0;
	Sat,  7 Feb 2026 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770461427;
	bh=6OZX7EKogGNAZsj0RNloLVy4u0hDyHPuVJ6PiQoyoFM=;
	h=From:To:Cc:Subject:Date:From;
	b=T3KOAyK3mZst5PAQO0GLwVxw2hHoLOlvJTwpPyVaPh9LEafu24czTJMdXYWSlRtC9
	 xJkbuO0/CEn3F9R4zrAT+LUh4Ma+OZ+FFd/FtKcXscXoLP+iWkmKuwT7hsV5AzdIbA
	 nYvJV5dirxKCQ5ORQC+F9tL8x5GD6M6ug9yl69R2b8/+uK3owKXmI3uBvxN6wGXx5C
	 bqijkUOk1JlwNZW0Z0odJ/1q7iUeApUJ94vFsyb+Xv9Q9AnAUOfPoYzW39aZ+dSjz7
	 v54TaNYEamaaqZepoTFJmIer+SpmFSiggncj6NPbhKWq83eg4EvcFzMsbrDVxkxvTS
	 Ac0ZlSFjFy9KA==
From: Thomas Gleixner <tglx@kernel.org>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: i40e: Fix preempt count leak in napi poll tracepoint
Date: Sat, 07 Feb 2026 11:50:23 +0100
Message-ID: <87v7g8zv2o.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Using get_cpu() in the tracepoint assignment causes an obvious preempt
count leak because nothing invokes put_cpu() to undo it:

  softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?

This clearly has seen a lot of testing in the last 3+ years...

Use smp_processor_id() instead.

Fixes: 6d4d584a7ea8 ("i40e: Add i40e_napi_poll tracepoint")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/intel/i40e/i40e_trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -88,7 +88,7 @@ TRACE_EVENT(i40e_napi_poll,
 		__entry->rx_clean_complete = rx_clean_complete;
 		__entry->tx_clean_complete = tx_clean_complete;
 		__entry->irq_num = q->irq_num;
-		__entry->curr_cpu = get_cpu();
+		__entry->curr_cpu = smp_processor_id();
 		__assign_str(qname);
 		__assign_str(dev_name);
 		__assign_bitmask(irq_affinity, cpumask_bits(&q->affinity_mask),
