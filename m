Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127242;
	b=U/f07YsHsOE/u3du0fipPjMXPwDp7fyIpavEYTOkSUX0YzQHJ2w5c1M2+0IBCt/Llk7J
	 pY/IXh7EMyYxnFzlRp2Z7IoEhIuYHZsxXrRkcYHotMsLfNQVmuURzDPVZCpcFOJzcaxmI
	 k11kqddJNlfaCf3gcCQg+4Xzqtkd+EbWHRzzYmT4SnSX0QTvClXq+O0lpm2cpWej+XMDW
	 lsNESujBenBxJQ1O9l1imrRYC4xAxFcJ1YMzdMWK8tIzqO+Xm2SX6SClIkxk5DElUe3Bm
	 9nH7zqtuXJI2T0sHZBu/yDbgm9MB7QBj65jwLh9jpJBYpDHuQhQ+nbUU4fkpkyPffrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127242;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=zIOVRWimvi5sL6RvvcGg4xNjH+GTSE/6lJuUuXwnf0M=;
	b=S2OSvZ37QAhpSBm1EJEXSPGJmmq8kP6kNMn+n+YmKeXZJnkGZE9/VdL/nUXQWYowEABN
	 9xzRlTXaN7c0j2SLNuzWC2NWzC5tSA/Euv+TLQ86G/2lXlcsj5Z1zJheMQRUtJc+jHr/7
	 0b9a0Fz7fqi/m1Km7vx0HIDHVr8GtgWzaroKyJcj0lXMiwZZI7fo4kQEqV/zw0XgYwXbR
	 XIkAUagP+dKEnyFtRecfhahBKVhdIcP8IC9KIYib9rWEsM54I3GGuxlcDwAR/IbaNxo6Y
	 ogNRLkXUQWgDvo3mvK3dw/zUXWre3Qh5l0R6jYXoXKjSD6HBLE64PWiJSAnLjGiLTug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daXaBHZA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533B606A31C;
	Sun,  8 Nov 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daXaBHZA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED871F0089F;
	Sun,  8 Nov 2026 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127241;
	bh=zIOVRWimvi5sL6RvvcGg4xNjH+GTSE/6lJuUuXwnf0M=;
	h=From:Date:Subject:To:Cc;
	b=daXaBHZALBdtiBs2E2dTVw58NYJWaRWQ4TE1oinT0rExsydmZqpXJhKv17+2WKsIi
	 4b54+A0StZc/5OgM1CUgn3xr6uxI334upHw8FOA4y67pTUh32DjJDARFKY5qN7cVif
	 SPoobMJNmoVRLjWHEcUJgNumK6ikdU+LThlkvPss7CAA4SQ8Dn+hXlgZCMA3aioEmj
	 DZiHJD+tPmHkiIFV4AC0vW8h0/uAOXOEkU7HdDpPuxWPeeYZHCFsvqF9AG7E1h9bj9
	 SC3T+ajpUzpDj6FNfnVfw2Fsv/IPWLY8pZ8+1lcOjqtcd6VaC4avJsimpLU9K4VjRE
	 Y6U4P90xmfruQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:40:36 +0200
Subject: [PATCH net-next] ptp: ocp: replace __get_free_page() with
 kmalloc()
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
Message-Id: <20261108-b4-ptp-v1-1-71160700886f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1JmbbDGGsSriItJMm1HMA0zUQqld
 zfR5fv/8TZQEiaFW7eB0IeVl1ThdOggzJgmMhwrg+2t650djB9MLtlQvDg8X9HhGKHKWWjk9Re
 6Q6JiEq0FHv9H3/5JobROcz0qGS+YwtymRXjidHyhFhLY9y/Kmt8VlAAAAA==
X-Change-ID: 20260624-b4-ptp-ed56a38a6afd
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.1-dev

ptp_ocp_summary_show() allocates a temporary buffer for formatting
PTP OCP device summary information.

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
This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
Removing needless calls to page allocator helps with memdesc (aka project
folio) conversion and gives a nicer API without casts.
---
 drivers/ptp/ptp_ocp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 625a85b2dc7e5..decc56892059b 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -18,6 +18,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/xilinx_spi.h>
 #include <linux/spi/altera.h>
+#include <linux/slab.h>
 #include <net/devlink.h>
 #include <linux/i2c.h>
 #include <linux/iopoll.h>
@@ -5281,7 +5282,7 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
 	bool on, map;
 	int i;
 
-	buf = (char *)__get_free_page(GFP_KERNEL);
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -5497,7 +5498,7 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
 			   post_ns - pre_ns);
 	}
 
-	free_page((unsigned long)buf);
+	kfree(buf);
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptp_ocp_summary);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260624-b4-ptp-ed56a38a6afd

--
Sincerely yours,
Mike.

