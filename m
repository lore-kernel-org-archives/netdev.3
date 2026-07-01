Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51992D94BA;
	Wed,  1 Jul 2026 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914249; cv=none; b=HUXREfkXkJqcq1E6UnvzpqMFUPcgjmxAyZfRmp7crc0484nsHcq7bpt/a80dqU89p9ZN1O7zaP6cZgg4LgI8uydtVEZFW6N9R2PE3FGBQiOwO243DRTYi76E8S6dgVVcryXLVw08PM7fZV9e8qve31y9HuUi9Qb/fGdM68l7uYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914249; c=relaxed/simple;
	bh=aand3RgNd4Cf6AAS8azBi8dkpD1wIzGiaaeMK7kxPAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EX78cT+FHsBLIUvky57Buw3qRQPzu5hNy10PDXxZefLnecw7OFdbaFUNnjMth3H/hk7TUOEaK0wEZ8GsA17cdV4pehKPiqccQks5Y0fCaMHYspN5JRLGAhV8oKEsKYlftvGnLSMaX2YHL0dYtFXN2pG88f0lV+ek9wlCg6IZKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlniPm7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlniPm7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9FC1F000E9;
	Wed,  1 Jul 2026 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914248;
	bh=KN3v4O8jkhd6Mt2HpgZaziumJD8qk36FkI+IylasYd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KlniPm7g68QtWZ0ZI9P+lp3JUjV32CfOcL+P0rwGBBPnR7YemV6QARFIlMBom7Ft2
	 hg+UXCYHwEMJfnINZ+cvQYZ2+Tx2E1sF9CLPJSZbS9/iJa9EAD3VFKNZHhuUfFv4h/
	 bjenyY6mkL36a02MkyvLbUf8OWfNk5KqEgFxqkJpda74bg7w3btOfpXfB9Xrbv3Chq
	 PE5b8Dsablj2qQqu/5Z0viSA4rkhgtGLq3C1kqL33o3SsCQ0rOotmd+azQFlkyCnqP
	 wMq3kV+j7NIZUxi0pBzmzk/HNlVf2GeUrUj4tyvCR23R70TuTnD/ouuREl2EBNGope
	 cPqa7hslPkgiQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 01 Jul 2026 16:57:18 +0300
Subject: [PATCH 1/4] bnx2x: use kzalloc() to allocate mac filtering list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-drivers-ethernet-v1-1-58776615db6e@kernel.org>
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

bnx2x_mcast_enqueue_cmd() allocates memory for mac filtering list using
__get_free_pages().

This memory can be allocated with kzalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
index 07a908a2c72f..d560524d317d 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
@@ -26,6 +26,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/crc32c.h>
+#include <linux/slab.h>
 #include "bnx2x.h"
 #include "bnx2x_cmn.h"
 #include "bnx2x_sp.h"
@@ -2664,7 +2665,7 @@ static void bnx2x_free_groups(struct list_head *mcast_group_list)
 				      struct bnx2x_mcast_elem_group,
 				      mcast_group_link);
 		list_del(&current_mcast_group->mcast_group_link);
-		free_page((unsigned long)current_mcast_group);
+		kfree(current_mcast_group);
 	}
 }
 
@@ -2713,8 +2714,7 @@ static int bnx2x_mcast_enqueue_cmd(struct bnx2x *bp,
 				total_elems = BNX2X_MCAST_BINS_NUM;
 		}
 		while (total_elems > 0) {
-			elem_group = (struct bnx2x_mcast_elem_group *)
-				     __get_free_page(GFP_ATOMIC | __GFP_ZERO);
+			elem_group = kzalloc(PAGE_SIZE, GFP_ATOMIC);
 			if (!elem_group) {
 				bnx2x_free_groups(&new_cmd->group_head);
 				kfree(new_cmd);

-- 
2.53.0

