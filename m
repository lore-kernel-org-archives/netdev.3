Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DB2D063E;
	Wed,  1 Jul 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914261; cv=none; b=ElDbLKxKTkckoaIG1iCBTbeaOmXTS4MO4kgmjhYO9G7+Mg+r7Ze6vh8nmjBz52LbLjvg344Fn9NN1YbTarurhwMCiT8XuJuMeuGcCsjrNmFv00/cG0JblbqATqsv0Fopb8xM5HtkyXjP42KIdQrogtSCCAbwObiTgFrZnNK1SLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914261; c=relaxed/simple;
	bh=ppZhTeXg9gmO+8PaxwWk0ZxukXOZQZ0VH6QiMrC0kyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUymWs+sJ+WjxECfF4f12cyU0KRNCEvAp8q7IOrvQU04A7Yg1scf86E7PfUREtLZnwrLtbWyHXXBNtaEDOjQ6pVNaipl7bL051IKkQu3oPMHUz9dGRoT6ZN/jFNJ8QBkPRbX6q62FY5TBePSF5NRqto6Tyj3w75j8qHw7S0cmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjiUo+I1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjiUo+I1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB66B1F00A3A;
	Wed,  1 Jul 2026 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914260;
	bh=qVNG6A0QrvVc3Q5VGETu2ZNN6OFwwV/HGShrasBWJk4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JjiUo+I1MUHxEgU3cQbZI86Y6WHaDCOxBbtbySGtgnRUKHqnTTFt5JN/+yZbEvPqb
	 BhROnNLTi+nMcez+8v1Nto6/1KuUqnMd3qAXMJe2sqM8PayfcKz0sjU9kLPVgKUl7g
	 zvtzpJwqFk+YJo/2kc6qaz+Cr8TE47gB8TD7KbFle63Z/yJvJeh61z7zwar0G+jPIp
	 bVXz0dHzWlX0v/ImjFLGHVpGMuKGgVPJyGugLUOiKm34jrgQaMQyUftl0SDvVjkXbb
	 4wdni/3VNT2ldqBHT7XKnGSXy7AZ0k0+OLvP1JJn8yHLXktr+nMzN81mcn1K3TyjPH
	 ayilUm7MHnf9A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 01 Jul 2026 16:57:21 +0300
Subject: [PATCH 4/4] sfc: use kmalloc() to allocate logging buffer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-drivers-ethernet-v1-4-58776615db6e@kernel.org>
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

efx_mcdi_init() allocates a logging buffer for MCDI firmware
communication diagnostics.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/net/ethernet/sfc/mcdi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index e65db9b70724..b806d3d90c42 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
 #include <linux/atomic.h>
+#include <linux/slab.h>
 #include "net_driver.h"
 #include "nic.h"
 #include "io.h"
@@ -71,7 +72,7 @@ int efx_mcdi_init(struct efx_nic *efx)
 	mcdi->efx = efx;
 #ifdef CONFIG_SFC_MCDI_LOGGING
 	/* consuming code assumes buffer is page-sized */
-	mcdi->logging_buffer = (char *)__get_free_page(GFP_KERNEL);
+	mcdi->logging_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!mcdi->logging_buffer)
 		goto fail1;
 	mcdi->logging_enabled = mcdi_logging_default;
@@ -112,7 +113,7 @@ int efx_mcdi_init(struct efx_nic *efx)
 	return 0;
 fail2:
 #ifdef CONFIG_SFC_MCDI_LOGGING
-	free_page((unsigned long)mcdi->logging_buffer);
+	kfree(mcdi->logging_buffer);
 fail1:
 #endif
 	kfree(efx->mcdi);
@@ -138,7 +139,7 @@ void efx_mcdi_fini(struct efx_nic *efx)
 		return;
 
 #ifdef CONFIG_SFC_MCDI_LOGGING
-	free_page((unsigned long)efx->mcdi->iface.logging_buffer);
+	kfree(efx->mcdi->iface.logging_buffer);
 #endif
 
 	kfree(efx->mcdi);

-- 
2.53.0

