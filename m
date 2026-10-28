Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188181;
	b=OxmprcnA7N4NC1kVvvqRdbCw19wBdGuqqr/AOLYR+G5a19dedoeKthCT/fbybmncSTR0
	 tCemCGFHDSuPcxMS8or2WXzXu9ZZWPzOyjYQOUQEFAgUKh2rzEab6XXiHpgdGU9jfcge/
	 aG2zUh+ca+IlruuaXmT8Ca4wCgAx5+7mLijp4ua4xupUzzN0ksKI93Sm62PUz3LC8M/nx
	 +nhntuKximjiGFybT/WXc1L4UbPsMZ1C9qsDJAQeuHIq8a8WtUQcPCPH1B9/vMfDBWjek
	 ZY8DsiA4fbKxKmLIBz843UddGpByWU4PvaLWstb++LJ7peDkJsEIGaVRyS2JUhdkiTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wUNv98EbFI1fTZW5mIt8qGC/wZtQV9k6nB12ordxF6s=;
	b=BRVEMncd3EfrngnqLptQsyoCnTLkUZ28nX93FGdMDPeclIhekyb8HkpWIuqpbREtE9im
	 FrmZPgd3nnfTaIS2Ryt0XRqqf29vGsAjIW9I48NB6x1gBOnqDW271bRXs+MWGWChbCcOP
	 2P0PbZXC7ORAuNbajvEXKSjpYWbZ1TEiTkIgw0pm1QFqBz1yEsHlH9Nb17bVgTfMQZCEB
	 29uWm9HrfmwxtZ2lBj2kpvQ2AJ+rkwMTb98P56iR7y689QWBkjbuLQe7vmNf+DzkTtnA0
	 BopyJQUjGf2mDuX0SA6kaCGkO3vFqdUYY0EIK7nmnvko5nYQHbA7ufdOpSyzvYROJTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bWmuQN3C;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A6606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 11:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E11A6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bWmuQN3C
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so1338885a12.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 04:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793188178; x=1793792978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wUNv98EbFI1fTZW5mIt8qGC/wZtQV9k6nB12ordxF6s=;
        b=bWmuQN3C779hTz7jeshV4Z2+r2ffaEYlaP/mfnLuoQ6xGRpTcfd7nF6niTd1Sih+G6
         3hdzv31hQ3yLRfE4Rnhetv7GfXpop647xnSzhl69Ga4EcDHHRo+oNMqfVtD0niaUPmc6
         9Au3TY1pGMQl+B/TYgihPSp7Q27hZfWuKyGchtD2mYrM7ncMUK56LPubJK3Hz4qKyKAF
         bg/h/o21qjLhWDVRYJkLcFaiaAJXjS3324WJP+Ntjjn9f4JVmkTgKTVy5oJbmT4HSM6r
         lhKTserNDncdUsn1nsCoLNULGT0w2OUY6xPLIzM9mHawK7/xjf7c6NJC6vepDAqpC62w
         7mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188178; x=1793792978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wUNv98EbFI1fTZW5mIt8qGC/wZtQV9k6nB12ordxF6s=;
        b=qc0DoL2CJs9TvIxYnwJTJFeGgekQ869kwkt/+chOBoFx+PhBrHPmyohFzTHOfGIOcy
         xfsJ5FrC8ZsniR8xE7msKhIe7cHoaxUXZfqcU7VTcl6RWMvUbyiRRteBDnq433Bq0IAV
         kbCnshrQabJ979rAaF8YCvB0XsNvJo9jsdP+ctjCbe/Ix3vHBvTkKryNadL6pbmDgeWc
         EgTGCxFoU1fs34OLpAoanTcAYicuzF0BMtaaPE5/FQhTzPtpg280BU7tQFi9P8FUTvRt
         ODh1O/3wrOoW9k1Vm3WrbuDrUzX1mQj4AFBMPsHyLQG95n/wmrIv6gaq8Idr8PSQJ7uZ
         c8NQ==
X-Gm-Message-State: AFq9FYI5i36K1/qQXuu6AUhqFyIupgUkdDWJml7Xl6VBaby0nz9zSVPF
	VQEjdAAWiKyEFxhtAjkWnpAksZKVEcyQgGpLM5+Ouz6gRG5sVSoh1rDd589BcyTkD+t/VA==
X-Gm-Gg: AYBFou3q+U/QfLKp+4MFPliyOi4eBEjq2LmWS+fNnLIrfsyXDZzl15I9cR3oSPqCFPd
	pIoUtuNEDDIPviYj81Al6JvPUW0zC4GfO3bmJxxEBkLHiCLw0ghpG7+lRCMZ9g49pCJwBiD8AFG
	nwrhlchlBcAK8+vqrICfbKXekDjAj8nJLQuXYXHd81WMfN3O58s2C/6u9Iwar1qIgy3VEsgioop
	OMP+OutXcTF3ZG8m98X+souAzKodscTP6YnkXwHoRS7gD+8NE9GPpUmVAUYpp+RUvBeAqldQ1AX
	AsOieyq7knMxGYEuUxJI5UCarAZKjv4IkxMjH1bQ5gIgcmTP32NJGYrXDiI2sFr7i/SipxJ9dJZ
	9JIQynoq/KLAnRq0fZIwrjWO6Il+nnsFvVI9XsXm+TvDEt6brV1ShjHEusz9uafHoGNyCPahZYT
	QJ1GUlmd2zSTfToAFGRJKt43K44tfrlurIiJCokJUvdtD2AbINWIB9at8C9nBBXIWg/tXehaJTu
	QcCPavd93iiHOFp40fBBGMstcxD6ej2qi/XmX5g95FJhNqBQKWMuJ0ijA53IqgFy1D7h4ADEMX7
	BLNfU6vgLNoX05HPstU0gQ==
X-Received: by 2002:a05:6402:2b91:b0:6b4:16fb:b9be with SMTP id 4fb4d7f45d1cf-6b49cb8e213mr1235720a12.37.1793188177856;
        Wed, 28 Oct 2026 04:49:37 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b49644bcd7sm1355360a12.33.2026.10.28.04.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:49:36 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Jinqian Yang <yangjinqian1@huawei.com>,
	Andrew Preece <apreece@meta.com>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] bnxt_en: Don't keep MSI-X vectors added before FW reserves them
Date: Wed, 28 Oct 2026 04:49:33 -0700
Message-ID: <20261028114933.256298-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dynamic MSI-X is supported, bnxt_check_rings() grows the MSI-X
vectors with bnxt_change_msix() once FW says the new rings would fit,
and keeps them.  FW only reserves the extra IRQs later, when
bnxt_reserve_rings() calls __bnxt_reserve_rings().  The MSI-X table
entries beyond the function's reserved IRQs are not backed until then:
the MSI message written when the new vectors are activated is lost, and
the entries read back as zero.  After FW reserves them they are live but
still zero, so the NQ rings bound to them signal address 0 and every
completion on those rings is lost.  The next ring change (for example
ethtool -G) then times out freeing each of those rings and the TX
watchdog fires:

  bnxt_en 0002:01:00.0 eth0: Resp cmpl intr err msg: 0x51
  bnxt_en 0002:01:00.0 eth0: hwrm_ring_free type 1 failed. rc:fffffff0 err:0
  ...
  bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 17: transmit queue 18 timed out 5716 ms

On x86 this is hidden: GENERIC_IRQ_RESERVATION_MODE makes the PCI MSI
domains MSI_FLAG_MUST_REACTIVATE, so the message is composed and written
again when the IRQ is requested, after FW has reserved the vector.
Since commit 0d6a7c417983 ("irqchip/gic-v3-its: Enable dynamic MSI-X
allocation"), arm64 GICv3 systems take the dynamic path as well, but
write the message only once, at allocation.  On an NVIDIA Grace system
with a BCM57508, raising the channel count from 18 to 32 left MSI-X
entries 18-31 all zero, and the 14 rings using them lost their
interrupts.

Keep the allocation in bnxt_check_rings() as a check that enough vectors
are available, but free the new vectors again right away when FW manages
IRQ reservations (BNXT_NEW_RM).  bnxt_reserve_rings() then allocates
them after __bnxt_reserve_rings() has reserved them.  Without
BNXT_NEW_RM there is no IRQ reservation and bnxt_reserve_rings() does
not grow the vectors, so keep the current behaviour there.

In bnxt_reserve_rings(), size that allocation from the rings FW actually
reserved (bnxt_get_num_msix()) instead of the count computed before the
reservation, so that a partial grant does not activate unreserved
entries either, at least while no RoCE driver is registered.

The allocation can now fail after FW has committed the reservation.  A
later open would then find nothing to reserve and return before growing
the vectors, and bnxt_request_irq() would use irq_tbl[] entries past
bp->total_irqs, which still hold the freed virqs.  Grow the vectors in
that case as well, and clear irq_tbl[].vector when trimming.

Fixes: 2d51eb0bd81c ("bnxt_en: Add MSIX check in bnxt_check_rings()")
Reported-by: Andrew Preece <apreece@meta.com>
Closes: https://lore.kernel.org/all/20261022193620.2152038-1-vlad.wing@gmail.com/
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
Changes in v2:
- Size the bnxt_reserve_rings() allocation from what FW reserved
  (bnxt_get_num_msix()), so a partial grant does not activate
  unreserved entries while no RoCE driver is registered (Sashiko).
  With RoCE registered, __bnxt_reserve_rings() can still keep more L2
  rings than the grant covers; that accounting predates this patch.
- Grow the vectors in bnxt_reserve_rings() even when no reservation
  is needed, and clear irq_tbl[].vector on trim, so a failed allocation
  after the FW reservation no longer leaves stale virqs behind
  (Sashiko).
- Only free the probed vectors when BNXT_NEW_RM is set; reword the
  comment.

v1: https://lore.kernel.org/all/20261023121321.2127263-1-vlad.wing@gmail.com/

Tested on an NVIDIA Grace system (GICv3 ITS, ACPI) with a BCM57508,
FW 230.0.165.3: the boot-time channel change (18 -> 32) followed by a
ring resize no longer loses completions.  With instrumentation, MSI-X
entries 18-31 read back as all zero after bnxt_check_rings() allocated
them, and read back correctly once bnxt_reserve_rings() allocated them
after the FW reservation.

This conflicts with the "bnxt_en: Ring accounting fixes" series on
net-next, which also changes the dynamic MSI-X path in
bnxt_reserve_rings().

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 34 ++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0682060b048ce..55b11c7684313 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11524,6 +11524,7 @@ static int bnxt_change_msix(struct bnxt *bp, int total)
 		map.index = i - 1;
 		map.virq = bp->irq_tbl[i - 1].vector;
 		pci_msix_free_irq(bp->pdev, map);
+		bp->irq_tbl[i - 1].vector = 0;
 		bp->total_irqs--;
 	}
 	return bp->total_irqs;
@@ -11701,8 +11702,23 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	int irqs_required;
 	int rc;
 
-	if (!bnxt_need_reserve_rings(bp))
+	if (!bnxt_need_reserve_rings(bp)) {
+		/* FW may already hold the reservation from an earlier
+		 * reservation that was not followed by growing the dynamic
+		 * MSI-X vectors, e.g. because the allocation failed.
+		 */
+		if (irq_re_init && BNXT_NEW_RM(bp) && bp->irq_tbl &&
+		    pci_msix_can_alloc_dyn(bp->pdev)) {
+			irqs_required = bnxt_get_num_msix(bp);
+			if (irqs_required > bp->total_irqs &&
+			    bnxt_change_msix(bp, irqs_required) != irqs_required) {
+				netdev_err(bp->dev, "Unable to allocate %d MSIX vectors, maximum available %d\n",
+					   irqs_required, bp->total_irqs);
+				return -ENOSPC;
+			}
+		}
 		return 0;
+	}
 
 	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(edev)) {
 		int ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
@@ -11728,6 +11744,10 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 			rc = bnxt_init_int_mode(bp);
 		bnxt_ulp_irq_restart(bp, rc);
 	} else if (irq_change && !rc) {
+		/* Size the vectors from what FW actually reserved, which
+		 * can be less than what was requested.
+		 */
+		irqs_required = bnxt_get_num_msix(bp);
 		if (bnxt_change_msix(bp, irqs_required) != irqs_required)
 			rc = -ENOSPC;
 	}
@@ -15093,6 +15113,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
 		}
 		if (hwr.cp > bp->total_irqs) {
+			int old_total = bp->total_irqs;
 			int total_msix = bnxt_change_msix(bp, hwr.cp);
 
 			if (total_msix < hwr.cp) {
@@ -15100,6 +15121,17 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 					    hwr.cp, total_msix);
 				rc = -ENOSPC;
 			}
+			/* FW has not reserved the new vectors yet, and writes to
+			 * MSI-X table entries beyond the reserved IRQs don't
+			 * stick (seen on BCM57508).  Free them again;
+			 * bnxt_reserve_rings() allocates them after
+			 * __bnxt_reserve_rings().  Without the new resource
+			 * manager there is no IRQ reservation and
+			 * bnxt_reserve_rings() does not grow the vectors, so
+			 * keep them.
+			 */
+			if (BNXT_NEW_RM(bp))
+				bnxt_change_msix(bp, old_total);
 		}
 	}
 	return rc;
