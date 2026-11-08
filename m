Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794103615;
	b=hKXJCfmyCfuusEF8wrIe71zroJhNBESwYGibI3IaNsrZZEJjLoB5s0KfDdpBW7QFWkJl
	 rk6NLv2I5gVbc1XaEUPPUmDeIPu+K+BahYlPLACHI+s1nS82xMpFI6hqu6p2Jv+GJnrU6
	 VxFciKhhV4EI3BiM1RjYM+B3J5grPZyhkcSeQq2da8cCs+Aqkrasu3So5Am+vk9MXs1++
	 qXzRY2L8CVfsK+JxVbyTX+dELk5EBz/PoYIu7tH10eb3ZNrloqW5pPgEHx6P4e4KUPQ1e
	 NqDEN0d5Iy58VAnMTItxfp4GqhIgjlqnxlolrL+oE/a4z7ggWLC2JJHOQIpAnlPODog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794103615;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KiQq1DcVKDH0MMQmkbVjLblOBj15HRy/K6PdBPfpb4o=;
	b=J7M91i1S72B3FZwr1R2LTJuDFxEiJUkZLU8C+aONzuQGBGZ/hPH44spK1VRRaYmrW0tS
	 C+Z9z7CXvEfjxheLAPeJIYxD4CfYU9AL2ubTwu9RQAs/iyKETzckKMCp8KpuRygLwad6b
	 dIBNl77BsylDsJbRQSvio9PWIkK52q1fncUH9fCejs+iwm7XUEqM2SxRBd63j5wB5d45w
	 j02mwhm60cq7+Ib4DrVJ5jIYgpWgVmXyziDOZzihLZaj690MRhkIwY2G1DGQMCzGQogHi
	 p02r05VrkkdPo/fsCoY4Kt16Uk/ejeO4nlmiuutjbJ3+Lh15wBuOg6MUj4JHf9GrZ9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=m3NB5rXQ;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EC1606A320;
	Sun,  8 Nov 2026 02:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44EC1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=m3NB5rXQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=m3NB5rXQ9VWQOPzJE1kqCuOB882Lr1gYx/kQZJzSp7IWBBhpGgijBGuUea+jmFsPws8niPgZTK9g8
	 4w0xOfPAZRaNtrXtxiZg+WjfFwCk1+iBeg+YmeKCcWCGyphZTy5iazbOl+oPEZgk7ciy7UQjj4XEfc
	 zVTmEnQaRl2u/8ms=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56aefd938c9a-b7105;
	Sun, 08 Nov 2026 10:06:51 +0800 (CST)
X-RM-TRANSID:2ee56aefd938c9a-b7105
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56aefd91c07a-59b0a;
	Sun, 08 Nov 2026 10:06:51 +0800 (CST)
X-RM-TRANSID:2ee56aefd91c07a-59b0a
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net 1/2] net: do not run out of frags in alloc_skb_with_frags()
Date: Sun,  8 Nov 2026 19:06:16 +0900
Message-ID: <20261108100617.23840-2-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108100617.23840-1-yanhaishuang@cmss.chinamobile.com>
References: <20261108100617.23840-1-yanhaishuang@cmss.chinamobile.com>
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
MAX_SKB_FRAGS * (PAGE_SIZE << order) up front, but then rounds the order
down for the tail, so a tail of N pages is split into one frag per bit
set in N. A data_len that passed the check can then need more than
MAX_SKB_FRAGS frags, and the allocation fails with -ENOBUFS although
every page allocation succeeded.

With order 3 and 4K pages, a 516536 byte packet is 15 * 32K plus a 25016
byte tail, which becomes 16K + 8K + 4K, so 18 frags are needed. Sizes
between about 480K and 540K can be affected.

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

Keep rounding the tail down when the remaining frags allow it, so no
allocation that works today changes, and use one page rounded up for
the whole tail otherwise. This is never larger than the full-size
chunks already used.

This was triggered while prototyping >64K TSO for virtio-net, with a
one-line guest virtio_net change raising its TSO limit; the host was
unmodified. The fix was tested with that reproducer and with the KUnit
test in the next patch.

Fixes: 09c2c90705bb ("net: allow alloc_skb_with_frags() to allocate bigger packets")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
Base: net 30c71476d842 ("ipv6: Check the Home Address option again before its
address is used"). The reproducer below was run on net-next 303d91a15925,
where alloc_skb_with_frags() is identical. On net: KUnit net_core 20/20
(kunit.py, UML x86_64), and allmodconfig W=1 build of net/core/ (arm64)
with no warnings.

Reproducer: x86_64 KVM host (i7-14700) running net-next 303d91a15925 with no
local changes; vhost-net, a tap NIC with mrg_rxbuf=on and rx_queue_size=1024.
The guest (net-next too) has a local one-line virtio_net change setting
netif_set_tso_max_size(dev, GSO_MAX_SIZE), plus
`ip link set dev ethX gso_max_size 524280 gso_ipv4_max_size 524280`; then
iperf3 guest -> host.

Without this patch: iperf3 fails, one vhost worker stays at 99.9% CPU,
tun_get_user() returns -105 (31014 times in 50 ms, kretprobe), the tap's
rx_dropped goes up by 34M during the run and keeps climbing at ~690k/s with
no traffic, and the guest can no longer ping the host until the VM is
destroyed. With this patch (same setup plus this patch on the host): 81
Gbit/s, no drops, and the vhost worker is idle afterwards.

 net/core/skbuff.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8da53d5b76fc..93e7b04ddfe6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6902,8 +6902,18 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 	while (data_len) {
 		if (nr_frags == MAX_SKB_FRAGS)
 			goto failure;
-		while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order))
-			order--;
+		if (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order)) {
+			unsigned long pages = PAGE_ALIGN(data_len) >> PAGE_SHIFT;
+
+			/* Rounding the tail down to smaller pages takes one
+			 * frag per bit set in its page count. If not enough
+			 * frags are left for that, use one bigger page.
+			 */
+			if (hweight_long(pages) > MAX_SKB_FRAGS - nr_frags)
+				order = order_base_2(pages);
+			else
+				order = ilog2(pages);
+		}
 
 		if (order) {
 			page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
-- 
2.43.0



