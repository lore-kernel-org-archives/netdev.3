Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028035;
	b=nAVF6FwNt4olvxY5eL4gDyu2XeocvFWA5/iw7adEjP5hWtQ+EvJ88e/5u0IUwoI1fmeM
	 Xf3nxNb4Ps3RC6SCh8MyJpq2FGwos1wOsq+vqhiiQRHmWkebVwnuw5u3iyL2WK7KgIvVJ
	 bYGzj19B37k+3vftHGRs3OwU0DpBm8NxeqPxR+dHpNB9T8jBojzoQJ2Gjpme18NYhuSlM
	 PQLrxyX0hOsJBqGFuUx82VVOMXsnd+0SXOzgnmUrKI5F/PP2eqs8IYdQJTbMUL+PZpWY7
	 qem4LxN9Vi+zcKLKfFFKwk0MKYW1HJasvNkEquHrPYj2xYpgU1Y26J1KpngmuhVWxBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028035;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=In7lRTD+K1+ZleMq6bwEmUr20w7Os9hDuYuQOUUuA/k=;
	b=s2EPUe+MOBStr7P0eAoDc8X3s9JSbOAl5aVwLDaTx+C8bstlcCuydFyW/pSq/6P0ZJw2
	 5zkluBg2ILK2EjzrNjxCFWv+Bvt5pMcL6dfingGVBL1Mg0WZqDlTdgpsRT0C4XfvpoiSx
	 qCYZ3rtwozRuD6fHu9dgnKrEMSOa7Otikr6DYF0T8uUMPGgdqe6ftGX/h6QWxkwuwSAxf
	 Q3sCPpGEkPOB8llX3Oj+Xzt61fckyrOkHgzD9YY66EZYPGmFfC46tQ0+uTXU9MSaqwMUB
	 aodl6wY59N/DBA6AAXFkFX4VIgHnwopUP8qLhy2oco3Quf35tjPCK0egBWiqW44Howw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=OEiJFe24;
	arc=none smtp.remote-ip=173.37.86.80
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC0606A324
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EEC0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=OEiJFe24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4177; q=dns/txt;
  s=iport01; t=1793028034; x=1794237634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=In7lRTD+K1+ZleMq6bwEmUr20w7Os9hDuYuQOUUuA/k=;
  b=OEiJFe24Irn+Yt+wFJDOtMUrWYylm7K2H/dqi+dsZi9mGBJ+iuqpoQ4T
   M88k5h+936/4aBXHjdVLzM3YxMAgUGll2FFtszJzR1JKWBYBrQAhY1/+H
   AyMMG+gAG0NdsNKXphJOcLI3w2NbxaL0HEePX3Dan9pKvEZIVPjeUDJ9a
   R42TKILYphrjW+EM9d/wIjtOqIv+3AcATabDT5FkqpAr7G/objsz32MBY
   q0ufN+9oR+mV8lrsy0fN4RgRHpYLrBDXoxWT3HygjpB0RyIIcjzxbyq9z
   MiE/5/yzuNjipuo39U+A/jABdmhFHRZNf11cfgMz6qSJ1yLLGgkSaauUK
   w==;
X-CSE-ConnectionGUID: I41JZ/8eQzS3BYaoAxZniw==
X-CSE-MsgGUID: spunAW8HRUSBpuZi5hV81A==
X-IPAS-Result: =?us-ascii?q?A0AnAACfbt9q/5P/Ja1QChwBAgIBBwEUAQQEAYF9BwEMA?=
 =?us-ascii?q?YIXghRDjTuJWQOBE5A3jFIUgWoPAQEBD1EEAQGFAQICAo4XAiY0CQ4BAgQDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZckBMBAQECATIBBz8FCwtGV?=
 =?us-ascii?q?oMbgk4nA7YBeIE0gQGEftlLgXQVgTgBhXGCbQGFA3aEfScbgUlEgRQBMoJBO?=
 =?us-ascii?q?D6EFgkLhl4EgiKBDI4iiBFICngcA1ksAVUTDQoLBwWBJUMDNRIqFSNLBS0dg?=
 =?us-ascii?q?SMhHRcRHlgbBgUSICpBQ1t1KmuBB12BKylgAQIfRi0VgXYCglGBI10CAUlBD?=
 =?us-ascii?q?gdFUwklQxJHJCIIEgkBExouC4EaNTwJJkEVDGQIAxoFGiYCIAgCCwIMeygRE?=
 =?us-ascii?q?BMiDRgNSBEsNxUZBD5uB5NYBgEtQwINHxAcIgkwJgEzLg8IAQYjJRUGBAELH?=
 =?us-ascii?q?ywXBZI+IpJIgTWfWoQogWaILJdkM4QElBeSVJkIo1YWBg8MTYRpgWg8gVkzG?=
 =?us-ascii?q?ggbFYMjUhkPji4WgRQBAtAJJ28CBwIHDgMLkWoPFweBTwEB?=
IronPort-Data: A9a23:DC4uHKDL7tmzaRVW/27iw5YqxClBgxIJ4kV8jS/XYbTApG9x0WNWm
 DAdUDvQPv6DMTfwfYhyaITkoUMB75aAx4BmOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGcYZsCCCM/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXGthh
 fuo+5eBYQf/hWcsWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE4qk3LnNxbYAh6N0sK1BH8
 tUIGjYMcUXW7w626OrTpuhEnM8vKozveYgYoHwllGmfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGYwBPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FEqgeS9YYSJK7RmQ+1Ohluej
 12W317EOTsCKe6elDq7oiuF07qncSTTHdh6+KeD3vhnnFGe2EQNBxAME1i2u/+0jgi5Qd03F
 qAP0jAloa538AmgScPwGkTg5nWFpRUbHdFXFoXW9T2w90Yd2C7BbkBsc9KLQIZOWBMeLdDy6
 mK0og==
IronPort-HdrOrdr: A9a23:xugZx63c0Ik54rFHzQ5rhAqjBJQkLtp133Aq2lEZdPWaSKClfq
 eV7ZMmPH7P+VIssR4b9+xoVJPrfZqYz+8X3WBzB8bGYOCFggqVxehZhOOI/9SjIVydygc378
 hdmsZFZeEYdWIbse/KpC+lDt0n3N6LtIqshevY0jNRaDsCUdAH0++8YTzranGfg2J9dOMEKK
 Y=
X-Talos-CUID: =?us-ascii?q?9a23=3A5eLm42vEgX1UycmCOHTI4myy6IsELiT//jCALna?=
 =?us-ascii?q?qMj1DebSSYE+i/qJ7xp8=3D?=
X-Talos-MUID: 9a23:TpaFbQQOmHs+yvAQRXT3nCxkHfg4w56TM2oVjKcH5sm6ZXVZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,179,1787011200"; 
   d="scan'208";a="539489649"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Oct 2026 15:20:27 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 661F618000243;
	Mon, 26 Oct 2026 15:20:27 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: netdev@vger.kernel.org
Cc: sebaddel@cisco.com,
	aradhana@cisco.com,
	rfaucett@cisco.com,
	satishkh@cisco.com
Subject: Re: [PATCH net v2 0/2] enic: retain admin DMA resources and identify V2 VFs
Date: Mon, 26 Oct 2026 08:20:25 -0700
Message-ID: <179302794669.3.2902500839140961922.enic-admin-net-v3-review-response@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v2-0-8db19b4a714e@cisco.com>
References: <20261022-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v2-0-8db19b4a714e@cisco.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-10.cisco.com

Thanks for the review. I have completed the audit and prepared v3.
Below are the changes and the disposition of the remaining findings.

For patch 1:

> All-ones RUNNING reads lead to quarantine and retained allocations.

An all-ones read means the register is inaccessible; it does not prove
that previously issued DMA has finished. I am keeping retention rather
than treating this value as a successful queue stop.

> Admin close and VF unregister can hold RTNL for several seconds.

Agreed. The 500 ms timeout applies to each queue polling pass, so retries
and mailbox waits can keep RTNL held for several seconds on a failing
device. V3 keeps this locking to prevent removal from racing with open
or recovery. Shortening the lock hold needs further review and is not
addressed here.

> Keeping bus mastering enabled does not mean a quarantined V2 VF
> remains usable.

Correct. V3 clarifies that keeping bus mastering enabled allows command
transport and ordinary teardown to continue. A V2 VF whose admin channel
is quarantined is closed and cannot reopen while that state persists.

> PF quarantine handling differs between the reset and reopen paths.

Agreed. This is a latent policy inconsistency. PF SR-IOV V2 activation
is not wired up in the current driver, so this PF quarantine path is
not currently reachable. PF recovery policy must be reconciled before
enabling that functionality; I have not added untested PF recovery
changes to this revision.

> A failed reset/reopen can leave the interface marked up, allowing
> a later stop to repeat napi_disable() and IRQ cleanup.

Agreed. This is a real, pre-existing lifecycle issue and remains
unresolved in v3. Adding dev_close() after the failed reopen would
immediately invoke the problematic second stop. I will address it
separately with a lifecycle fix and targeted failure testing.

> Generic datapath queue-disable failure can leave teardown incomplete.

Agreed. This is also pre-existing, and the new close paths do not
repair it. Generic queue ownership and cleanup remain outside this
admin-only series. I am not treating the incomplete cleanup as harmless
or claiming that this series makes that path safe.

> A retained BAR reservation does not prevent every possible later
> owner or re-enumeration path.

Agreed. The reservation blocks ordinary ENIC reprobe while the PCI
device remains enumerated. It does not prove that DMA stopped or
preserve IOMMU attachment. Reboot remains the documented recovery;
remove/rescan, kexec and rebinding to another driver are not claimed
as supported recovery methods.

For patch 2:

> A completed CMD_CLOSE should also resolve the earlier statistics
> DMA target.

Fixed in v3. Both close sites now check DEVCMD2 completion under
devcmd_lock. Completion of this later command proves that the earlier
statistics write has finished, including when close returns a firmware
error. The statistics buffer is therefore no longer retained
unnecessarily. A timeout or failure before posting leaves it retained.
Admin queues still require their own successful RUNNING checks.

V3 also fixes the early-notification window. It obtains and validates
the VF source ID after QP enable while receive interrupts remain
masked, then enables sends before unmasking. Queued notifications can
then be processed and acknowledged with the correct source ID, without
relying on PF retransmission.

Other changes clear local VF registration state after channel receive
activity has been drained, correct the core-close ordering comment,
clarify the poison-state comment, and change the terminal diagnostic
to cover both admin and statistics DMA.

Both patch boundaries passed build and static checks. Focused VF tests
verified queued notification delivery and ACK completion, discovery
failure cleanup, and statistics-buffer cleanup after a completed close.
The uninstrumented candidate also probed and registered a nonzero VF.
These were targeted tests, not a new full interoperability run, and
they did not reproduce a physically failed DMA engine.

I will send v3 with these changes.

pw-bot: cr
