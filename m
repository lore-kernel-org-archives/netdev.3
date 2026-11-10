Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299491;
	b=XwGYdSr9ik0mXqa2+irCynFz6Nps/vf73e8Vvlrd9/3XW6J7dnwCCiADtXt4GAlRO9pV
	 kezi86OEuJHP9a9PFDrm5SNcGWSgihnVtqYXTwcp4Skur/wOlZLOMWeEUCkSJXjos+Jrn
	 kQSAkq93MD1mRFLKm/dLXBDl7aflcN/l3FBV6FPQ2H6oTO+BmPihN1ybPxqslJsrhXI8D
	 Kpo/LdXdlS+bqMfmwDmp0EWTaPvLqrUaD47FhDGhHksujMVq+mL/Oz+iDuukkYS/7DZjA
	 2sBBffPmv2MaGuwAf7Zp1uCDvb1m9qtwmxd3DDKvwwNDSD/fOf2W25MWOM5wQ8e7djg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299491;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3XSbzMljJ03BDWYHqvs4qG/ftfBUXdLR9CxwKQCoib8=;
	b=iD4yKAnK0W81i8U8adTE9bYRi6ikSeALVhTg9hPct/y/kPIuDvp/KOAZOlR5D7nfQ4gf
	 we/3fPfDd3ob9Al+RLYnrUbJ5GXTneNsYhs7YrjgIrktLCE4kH/hIRSnMqoh/JgsmysBY
	 v2hAnbThC+qfyTWIZvH/gr0Ka+dRXuL41bNuLfzMyMXl7vkFOU5F3FHlcrr6EibZeIbgN
	 qrP56u87Vni8fi7H+bQSb/hoFbQJMImQlyTOx7LhM2hwU1JZsDcSKOc5K//sFXU2LF75m
	 dO0exYAs48jqVXxcuP8R1G3e8ADGkuXO4idTsfki5WQS9JPmecusUZIVmmOexwraq0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rmkke7gy;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D6606D011;
	Tue, 10 Nov 2026 08:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D58D6606D011
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rmkke7gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rmkke7gyw7Pe009zwU6/+o26FWto+mHubHgGScjBrTYLmXLGM1b7BdtUezmaNR4H8eo/bvHXTQyb7
	 0YTZNZ+OdaLNLqTY2vqhixruGCLNXZMvE8hGZdJHf/aHeaiSrNC3J+pIFoZzW7kbfaLs1/S4y52cPX
	 G26RnLNWTXvUWl9Q=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af2d65fea9-99a4d;
	Tue, 10 Nov 2026 16:31:27 +0800 (CST)
X-RM-TRANSID:2ee66af2d65fea9-99a4d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af2d6503b8-ae1bd;
	Tue, 10 Nov 2026 16:31:27 +0800 (CST)
X-RM-TRANSID:2ee76af2d6503b8-ae1bd
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: yanhaishuang@cmss.chinamobile.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	almasrymina@google.com,
	daniel@iogearbox.net,
	willemb@google.com,
	willemdebruijn.kernel@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	narcisav.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net: do not run out of frags in alloc_skb_with_frags()
Date: Wed, 11 Nov 2026 01:24:17 +0900
Message-ID: <20261110162418.28322-2-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110162418.28322-1-yanhaishuang@cmss.chinamobile.com>
References: <20261110162418.28322-1-yanhaishuang@cmss.chinamobile.com>
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

alloc_skb_with_frags() rejects data_len above
MAX_SKB_FRAGS * (PAGE_SIZE << order) up front, but two things can then
make it need more than MAX_SKB_FRAGS frags, so it fails with -ENOBUFS
for a data_len that passed the check:

- It rounds the order down for the tail, so a tail of N pages is split
  into one frag per bit set in N. With order 3 and 4K pages, a 516536
  byte packet is 15 * 32K plus a 25016 byte tail, which becomes
  16K + 8K + 4K, so 18 frags are needed although every page allocation
  succeeded. Sizes between about 480K and 540K can be affected.

- When a high-order allocation fails, it lowers the order for this and
  every later chunk without checking that the frags left can still hold
  the rest. With order 3, a failure on the first chunk leaves room for
  at most 17 * 16K, so anything above 278528 bytes fails. These
  allocations are made without direct reclaim, so they fail whenever no
  order-3 page is free at that moment.

Both came with the commit below. Before it, the limit was MAX_SKB_FRAGS
pages, which fit at any order.

tun hits this when vhost-net hands it a GSO packet of such a size from a
guest. Nothing on the host limits the size of a guest's GSO packet to
64K: virtio_net_hdr has no total length, and tun_get_user() sizes the
skb from the descriptor chain. Today's virtio-net drivers stay at 64K,
but a guest can send bigger packets by raising its own TSO limit, and
the host must not depend on the guest for that. Worse, vhost-net treats
-ENOBUFS from sendmsg() as transient: handle_tx_copy() puts the
descriptor back and retries it, so the vhost worker spins at 100% on
the same packet and the device stops passing traffic in both
directions. On an unmodified host, tun_get_user() returned -ENOBUFS
about 620,000 times per second, the tap's rx_dropped counter climbed at
the same rate, and this went on with no traffic until the VM was
destroyed.

This patch only fixes the frag accounting for packets that pass the
data_len check. A larger frame from a guest can still make
tun_alloc_skb() fail in alloc_skb() and vhost-net retry it; that is a
separate problem in tun.

Keep rounding the tail down when the remaining frags allow it, and use
one page rounded up for the whole tail otherwise. This is never larger
than the full-size chunks already used. When a high-order allocation
fails, only lower the order if the frags left can still hold the rest.
If they can't, try the same order once more with the caller's direct
reclaim (with __GFP_NORETRY, so no OOM killer), and fail only if that
fails too. An allocation that succeeds today takes the same path; the
extra attempt only happens where it would have failed.

The tail case was triggered while prototyping >64K TSO for virtio-net,
with a one-line guest virtio_net change raising its TSO limit; the host
was unmodified. The fallback case was pointed out in review of v1. The
fix was tested with that reproducer, with page allocation fault
injection on the vhost worker, and with the KUnit test in the next
patch.

Fixes: 09c2c90705bb ("net: allow alloc_skb_with_frags() to allocate bigger packets")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
Base: net a45dbf182137 ("ipvlan: make outbound skb headers writable").
The tests below were run on net-next 303d91a15925, where
alloc_skb_with_frags() is identical. KUnit on net 30c71476d842: net_core
20/20 (kunit.py, UML x86_64); with only patch 2 applied, the new test fails
with err -105. allmodconfig W=1 build of net/core/ (arm64) on net
a45dbf182137 with no warnings.

Reproducer: x86_64 KVM host (i7-14700) running net-next 303d91a15925 with no
local changes; vhost-net, a tap NIC with mrg_rxbuf=on and rx_queue_size=1024.
The guest (net-next too) has a local one-line virtio_net change setting
netif_set_tso_max_size(dev, GSO_MAX_SIZE), plus
`ip link set dev ethX gso_max_size 524280 gso_ipv4_max_size 524280`; then
a 10 s iperf3 guest -> host.

Tail case, without this patch: iperf3 fails, one vhost worker stays at
99.9% CPU, tun_get_user() returns -105 (31014 times in 50 ms, kretprobe),
the tap's rx_dropped goes up by 34M during the run and keeps climbing at
~690k/s with no traffic, and the guest can no longer ping the host until
the VM is destroyed. With this patch: ~100 Gbit/s, no drops, and the vhost
worker is idle afterwards; tun_get_user() handled 246783 packets, 237937
of them between 480K and 540K, and none failed.

Fallback case: CONFIG_FAIL_PAGE_ALLOC with min-order=3, ignore-gfp-wait=Y
and task-filter set on the vhost workers, so only the order-3 attempts
without direct reclaim fail. Failures of tun_get_user() during the run:

  probability   tail fix only               this patch
     0%          99.0 Gbit/s, 0              96.0 Gbit/s, 0
     5%          92.7 Gbit/s, 240418         99.8 Gbit/s, 0
    20%          72.3 Gbit/s, 1152801       101.6 Gbit/s, 0
    50%           0.1 Gbit/s, 4077173        99.5 Gbit/s, 0
   100%          iperf3 fails, 10573852      98.9 Gbit/s, 0

With this patch the order-3 pages that the first attempt doesn't get come
from the retry with direct reclaim (3546571 of them at 100%). Not tested:
the retry failing as well, i.e. real memory pressure, and other callers
of alloc_skb_with_frags() than tun.

 net/core/skbuff.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a7d555b3d2f28..da9025e6f0c3c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6906,15 +6906,41 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 	while (data_len) {
 		if (nr_frags == MAX_SKB_FRAGS)
 			goto failure;
-		while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order))
-			order--;
+		if (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order)) {
+			unsigned long pages = DIV_ROUND_UP(data_len, PAGE_SIZE);
+
+			/* If splitting the rest into smaller pages would need
+			 * more frags than we have left, use one larger page.
+			 */
+			if (hweight_long(pages) > MAX_SKB_FRAGS - nr_frags)
+				order = order_base_2(pages);
+			else
+				order = ilog2(pages);
+		}
 
 		if (order) {
+			unsigned long smaller = PAGE_SIZE << (order - 1);
+			bool can_shrink;
+
+			/* Only fall back to smaller pages if the frags left
+			 * can still hold the rest. If not, try this order
+			 * once more with the caller's direct reclaim.
+			 */
+			can_shrink = DIV_ROUND_UP(data_len, smaller) <=
+				     MAX_SKB_FRAGS - nr_frags;
+
 			page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
 					   __GFP_COMP |
 					   __GFP_NOWARN,
 					   order);
+			if (!page && !can_shrink &&
+			    gfpflags_allow_blocking(gfp_mask))
+				page = alloc_pages(gfp_mask | __GFP_COMP |
+						   __GFP_NOWARN | __GFP_NORETRY,
+						   order);
 			if (!page) {
+				if (!can_shrink)
+					goto failure;
 				order--;
 				continue;
 			}
-- 
2.43.0



