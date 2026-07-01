Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C62D12EE;
	Wed,  1 Jul 2026 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914253; cv=none; b=dOZ5BsxnRzjldx3KlYijLVt2gc6fCrLNG6mvobKEmUOC3Dw+ZLqkwF/t/t+dmbRFgV4s1aUrQM4rYttF0fPz7jx/W7pRh4wG71+vsL5mRykAhJN7HZyU3KJWmxHG0Pc+i1ZJT3vanDkftKss7o3EZplA2qH5LVi4BuT5LLNCO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914253; c=relaxed/simple;
	bh=AyB/L2uCs+AZEaaOd3L9Nr1/Nuxd6Za0GDoPK4n0OO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmNKWXSNm0b1WA3b4LNmhSDXYqJ4aztmm6rQI79p2BdEU69N3ndVWMMNvtkg8+0FpJFmockO14YZszRu4Nh48JP9l1YJuoaC4qGzMNkbbiLeeo2F/uXPpUMt7ivSqD5PGwGAsvXt9wtEJYFAneFBjJOygXD6kDTmfiqi0lX9QtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6BFggHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6BFggHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36391F00A3A;
	Wed,  1 Jul 2026 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914252;
	bh=Iyk9farFukAIvKGcWCVjubpPNe4OtJIT0B3fPfHAcek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U6BFggHOgvcT6jnqIHNAILvtyPmnjoDU8/r6T3eutVDjMHU2SA1lyN1sKB5RVvif0
	 m5/DOfgFr5ToAzwy0tvh+L2syNb1eCPp4fVX2CEOl5pFvd7Va1IBXmNDfJArzGcwsD
	 cgqB8KhDBRXsleLlXezhAYJyRrypFpCfgfgOCR4Njze1F6see57I7na2GJrbYCi6yU
	 gmFPDQNvTkx//l84i4La94Ia4mbGOc6YoRrF3eUJfiaUyr6G/bIhDUzzxblI3XBSbs
	 /z+9cBTKhHbOnnl7eqSY9UK/VFOFV1TeKquJBAepagX43HEjRzBlTcUTSvJIqxIK9n
	 NKZ/yW8tupQ3w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 01 Jul 2026 16:57:19 +0300
Subject: [PATCH 2/4] ice: use kzalloc() to allocate staging buffer for
 reading from GNSS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-drivers-ethernet-v1-2-58776615db6e@kernel.org>
References: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
In-Reply-To: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Sudarsana Kalluru <skalluru@marvell.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, Mike Rapoport <rppt@kernel.org>, 
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-net-drivers@amd.com, netdev@vger.kernel.org
X-Mailer: b4 0.16-dev

ice_gnss_read() uses get_zeroed_page() to  allocate a staging buffer for
reading GNSS module data via I2C bus.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 8fd954f1ebd6..7d21c3417b0b 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2021-2022, Intel Corporation. */
 
 #include "ice.h"
+#include <linux/slab.h>
 #include "ice_lib.h"
 
 /**
@@ -124,7 +125,7 @@ static void ice_gnss_read(struct kthread_work *work)
 
 	data_len = min_t(typeof(data_len), data_len, PAGE_SIZE);
 
-	buf = (char *)get_zeroed_page(GFP_KERNEL);
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto requeue;
@@ -151,7 +152,7 @@ static void ice_gnss_read(struct kthread_work *work)
 			 count, i);
 	delay = ICE_GNSS_TIMER_DELAY_TIME;
 free_buf:
-	free_page((unsigned long)buf);
+	kfree(buf);
 requeue:
 	kthread_queue_delayed_work(gnss->kworker, &gnss->read_work, delay);
 	if (err)

-- 
2.53.0

