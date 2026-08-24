Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F633FA5FD
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585380; cv=none; b=Vqx3KemuHSJFPxEqk5e7/ZD/Vxxj1q18Jv8WFN0m9Wn8kndxYdw5Pu1xz8fK6rpuYEMqoS0JrN6GIruaa17LTn6jjnC8wqrYFhGQhPTV6lHbLNmFbJILP97hzfXo5h1F7xm4jRLmiOJiWuc3MHYHXiGvmQoXqsfESwcn6OlnYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585380; c=relaxed/simple;
	bh=wb3aYsExEyGsCbKmxC8jyjPeXblGtpkc9Lib1zp0eB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ROWZW15a+jfmURoSQiosibkowXGRnMnotR+/w1VnOeo+Ozw6fwYvTad51P4q8CBHaCZPaQna90l5m7oSmuup3gN4gAwwwrfmvspQSNU5J1XSXgkmwrWPV28Ox9PUeMNvuJUbb3BLRSHcBfnpjfifXFkhTRtalVYkKqvHcUDyMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4fd5Xw3; arc=none smtp.client-ip=209.85.218.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4fd5Xw3"
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c20e5890680so124434366b.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787585376; x=1788190176; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxtYpttAkkFeNCs4heKfMrvlAQRBvH9LjM7sWbysPCs=;
        b=g4fd5Xw3tT6PsyB9wPLh4cY+UVPtPQKp+SUS9vm6SlnYKBo64ca3wWLVPMmLoYQzsE
         5W/19tBu6I2RMP/iEwTP5maFjLeF/Crg9rmo6ayAtRiuDayooSRdtbqBCkdUfk1tA6XJ
         9+62vFswcPs1sK9nZtXvJwKTwoYB1HwY/MZDXenF2aj7a9OMRIFxO3m2JGU/5hb43sA/
         iYVIRdw7ldYyTJAvNON+mtX3c3frhiwAV3rVY1LS7BR9UA4xtPDoMoj4UIyWLJagCfrs
         j0stKsn6YGIqg/M1K3m2+M9QLc2TdYBe23YYhSO1z23tCJrSF7ZunGhoev1kef9eeu2E
         JP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585376; x=1788190176;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XxtYpttAkkFeNCs4heKfMrvlAQRBvH9LjM7sWbysPCs=;
        b=JSj+DGCd+48OLmuub7sppCQOPMIM5ywbgvDOSOh3tZz/oxkXHRYTTt0s1NoJMTQskD
         uiWbsqfw0cCb2dpCgwZPbKIngt0BbzqcfcBs5g0CQXcqdWC2LZ3Ji8/+FOwGw8Cn53L8
         ywbsqRqWB4+/1hwtiw9A+eyIE+Hd1pfFJd9ubXGdfeY78vQbrkJRoj9RTBuINqqvDUr9
         YCEg6ImFCLvkqWVjhRYWmPJ7ARw8OutgjI37XjYvw8WYYxEKNluBTqjOwTNFg3CkFIsx
         FzwTTPwWYkx8Qbd8skigdGcZHptLF/2UxHC4doaO8XGib70ETE57TF8OrF9aX8qdZfEd
         RqZw==
X-Forwarded-Encrypted: i=1; AHgh+RodCgbOERPsW8NmKpCnML/wPU/pfrsfQg/U5kKF/Iw6OYN4suSAqqVZ19Y7Nuy5weAETCqn5rs=@vger.kernel.org
X-Gm-Message-State: AFuF++lUR2d4Qh+bo1cnmKrdCJXIR6s0OkFsNegGDP5Eouih/DUiVY2A
	rJivy6M49sDkE8AenoGh+NCR/6/rnMZzQyowot+AsSWTELwRKIPtaf3IFMN/DcgPd04aLB5KTZM
	l1YdCrw==
X-Received: from ejcfb18.prod.google.com ([2002:a17:907:3a12:b0:c21:94a2:c168])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:c245:b0:c24:6f95:4f0e
 with SMTP id a640c23a62f3a-c2492719d94mr2282288466b.18.1787585376193; Mon, 24
 Aug 2026 08:29:36 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:29:28 +0000
In-Reply-To: <20260824152932.1583506-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260824152932.1583506-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824152932.1583506-2-lrizzo@google.com>
Subject: [PATCH v2 1/5] swiotlb: enforce pool nareas and nslabs invariants
From: Luigi Rizzo <lrizzo@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <lrizzo@google.com>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The SWIOTLB allocator relies on two runtime invariants across all
pool initialization paths:

1. pool->nareas must always be a power of two so that a slot's area
   can be located efficiently via bitwise masking (index & (nareas - 1))
   instead of integer division.
2. pool->nslabs must be a multiple of nareas * IO_TLB_SEGSIZE so that
   each area contains an integer multiple of IO_TLB_SEGSIZE (default 128)
   slots, preventing contiguous allocations from crossing area boundaries.

Enforce these invariants consistently during early boot, pool
initialization (swiotlb_init_io_tlb_pool), and restricted DMA pool setup.

Fixes: 8ac04063354a ("swiotlb: reduce the number of areas to match actual memory pool size")
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/dma/swiotlb.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1abd3e6146f45..8e4bd9d47735a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -33,6 +33,7 @@
 #include <linux/kmsan-checks.h>
 #include <linux/iommu-helper.h>
 #include <linux/init.h>
+#include <linux/log2.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pfn.h>
@@ -176,7 +177,7 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
 static unsigned int limit_nareas(unsigned int nareas, unsigned long nslots)
 {
 	if (nslots < nareas * IO_TLB_SEGSIZE)
-		return nslots / IO_TLB_SEGSIZE;
+		return rounddown_pow_of_two(nslots / IO_TLB_SEGSIZE);
 	return nareas;
 }
 
@@ -269,7 +270,16 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
 		unsigned long nslabs, bool late_alloc, unsigned int nareas)
 {
 	void *vaddr = phys_to_virt(start);
-	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
+	unsigned long bytes, i;
+
+	/*
+	 * If we have multiple areas, ensure each area's size is a multiple of
+	 * IO_TLB_SEGSIZE slots by aligning the total pool size down.
+	 */
+	if (nareas > 1)
+		nslabs = ALIGN_DOWN(nslabs, nareas * IO_TLB_SEGSIZE);
+
+	bytes = nslabs << IO_TLB_SHIFT;
 
 	mem->nslabs = nslabs;
 	mem->start = start;
@@ -1813,7 +1823,10 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
 	struct io_tlb_mem *mem = rmem->priv;
-	unsigned long nslabs = rmem->size >> IO_TLB_SHIFT;
+	unsigned long nslabs = round_down(rmem->size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+
+	if (!nslabs)
+		return -EINVAL;
 
 	/* Set Per-device io tlb area to one */
 	unsigned int nareas = 1;
-- 
2.55.0.766.g2966f0265a-goog

