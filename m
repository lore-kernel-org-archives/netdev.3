Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935158;
	b=eXTnMd8P5JM1/IOCoYzZCwsa9ia0+4v3frabdUw1RYYTti6wsoxNJZcbIfONXsWa5Sn4
	 3F0B91H5fY9N4SJKTdT38xTN7DmUkAoXPDxfRTUDUxlE3MjeHAesTB8fzeSNzdQKwyR0b
	 aX5119vR3U1FUVjHriHfoq0nkgEhv4pk9gc7JExkKAbv42bfmbdPL+xf6Yvdo+l7MlMM7
	 WlMoDxRgZkBULGWjXJz7H3GS2FDFA4chiPKqkmhWEwsoPDAG/ifT1kUHRBE1xpYKYHf2S
	 ESRZJ4S5xyYvAAoh80jrw0CY/WShdfTQuHabK5F7DBDw/Fgc6s4Qn//vj8HWWxArlNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935158;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=HOEFc6X9iEnS9KdHNxrrJ/dUjt/+G7BU/XfJjODg9Ps=;
	b=gD8kjGjQwwOQc+YLwo6PwOFA8VfBOQgJSMoKywpK3yRYNWheWoX03Rr2NpgTnuOfZ+RX
	 bYvXbxR2bpNt1kCD+gaZNlt+ebDnvYALMcUryaIkriwRzx17EVhFYITzM+Z1vNhGRsLZt
	 vNtIs8t2jVV+7QUrvgNy7sCM2swIT/53z/PeNMQb4+mME6zV1SOEDWxyBHgZ/VZQ35oa2
	 ebBoXUEAN7VSupALU5H3vUZm9SvuCh+8mYb8YKw6qtwjN8eg3YoCA6C5HMwT4zTHBoFC4
	 oD9zWNTfGBNHtrKpLv0crKTOUhJK7ahBiv5IZIQV8aUd0wvsn/G7t4OAlN5u0e9Tguw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVVKqtip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10FB606A328;
	Fri,  6 Nov 2026 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVVKqtip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9212F1F0089F;
	Fri,  6 Nov 2026 03:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935157;
	bh=HOEFc6X9iEnS9KdHNxrrJ/dUjt/+G7BU/XfJjODg9Ps=;
	h=From:Date:Subject:To:Cc;
	b=KVVKqtip7Gof3iCh8YYjKQeBkoyzgHLffrjtZPrPpya3vi03U4NNPTKmUhPeBVlhJ
	 TmEKOV9jeVOrKwq+YdvDHxWm5g0IH3BgMLzGCG+LHEoeHh3sT18YH52VpR9Kse2OZT
	 kUQjyF6BZwn/Szt1adiZDV1jd0c+25EcEWYVN9GIizLl15xf6/ot3VxDE9BBSR/gN0
	 C9uXpuuRTwud5hTjavXvAn/45Bcq0eeuqL2biWgY3A6wNJ4wtJdzduRyf2vsB0p9f+
	 dNd16e5HnQKfZ/1dOYRmbTG6fa+n2lVjvMDcBMLGiNuu9IIgaCPZkGYXoy33I7MHlb
	 XHD91AGJlCEVg==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Fri, 06 Nov 2026 03:17:11 +0000
Subject: [PATCH net-next] net: ena: reuse the whole RX page on 64kB page
 kernels
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
Message-Id: <20261106-ena-rx-reuse-64k-page-v1-1-ac75b20c5de8@kernel.org>
X-B4-Tracking: v=1; b=H4sIALZG7WoC/yWM0QrCMBAEf6XcswdJW6L1V8SHtK56CrHcpRIo/
 XejPg67MysZVGB0bFZSvMXklSr4XUPTPaYbWC6VqXVt8N4FRoqshRWLgUP/5DnWU7cPw6Efxg4
 OVN1ZcZXy654oIXNCyXT+L7aMD0z5m6Vt+wALp2s9gwAAAA==
X-Change-ID: 20261106-ena-rx-reuse-64k-page-3769849b3e0e
To: Arthur Kiyanovski <akiyano@amazon.com>, 
 David Arinzon <darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Breno Leitao <leitao@debian.org>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Harry Yoo (Meta)" <harry@kernel.org>
X-Mailer: b4 0.16.0

Since commit ef5b0771d247 ("net: ena: fix driver when PAGE_SIZE ==
64kB"), the RX buffer given to the device is limited to ENA_PAGE_SIZE
(16kB) because the buffer length field in the RX descriptor is 16 bits.
However, the driver still allocates a full page for each RX buffer, so
on a 64kB page kernel only the first 16kB of the page is handed to the
device and the remaining 48kB is never used.

The dynamic RX buffer recycling added by commit f7d625adeb7b ("net: ena:
Add dynamic recycling mechanism for rx buffers") does not fully utilize
the page because ena_try_rx_buf_page_reuse() only reuses what is left
in the current buffer and ignores unused memory in the page.

This shows up when RX data stays in socket receive queues, as each
queued skb keeps the whole 64kB page alive while at most 16kB of it
holds data. On an EC2 t4g.large instance (64kB pages, 8GB memory) with
519MB left unread across 64 TCP sockets, RX pages pinned 2869MB of
memory while the socket layer accounted only 687MB.

Fix this by mapping the whole page and letting
ena_try_rx_buf_page_reuse() size the next buffer from the room left in
the page instead of from what is left of ena_buf->len. ena_buf->len is
then only the length written to the RX descriptor and stays capped at
ENA_PAGE_SIZE. With this fixed, a comparable workload pins only 497MB.

When PAGE_SIZE equals ENA_PAGE_SIZE, the room left in the page equals
ena_buf->len, so nothing changes.

Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 7eb6456ed0d5..4a35cb6a7785 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -492,7 +492,7 @@ static struct page *ena_alloc_map_page(struct ena_ring *rx_ring,
 	/* To enable NIC-side port-mirroring, AKA SPAN port,
 	 * we make the buffer readable from the nic as well
 	 */
-	*dma = dma_map_page(rx_ring->dev, page, 0, ENA_PAGE_SIZE,
+	*dma = dma_map_page(rx_ring->dev, page, 0, PAGE_SIZE,
 			    DMA_BIDIRECTIONAL);
 	if (unlikely(dma_mapping_error(rx_ring->dev, *dma))) {
 		ena_increase_stat(&rx_ring->rx_stats.dma_mapping_err, 1,
@@ -544,7 +544,7 @@ static void ena_unmap_rx_buff_attrs(struct ena_ring *rx_ring,
 				    struct ena_rx_buffer *rx_info,
 				    unsigned long attrs)
 {
-	dma_unmap_page_attrs(rx_ring->dev, rx_info->dma_addr, ENA_PAGE_SIZE, DMA_BIDIRECTIONAL,
+	dma_unmap_page_attrs(rx_ring->dev, rx_info->dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL,
 			     attrs);
 }
 
@@ -926,19 +926,27 @@ static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag,
 	return skb;
 }
 
-static bool ena_try_rx_buf_page_reuse(struct ena_rx_buffer *rx_info, u16 buf_len,
+static bool ena_try_rx_buf_page_reuse(struct ena_ring *rx_ring,
+				      struct ena_rx_buffer *rx_info, u16 buf_len,
 				      u16 len, int pkt_offset)
 {
+	int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	struct ena_com_buf *ena_buf = &rx_info->ena_buf;
+	unsigned long room;
+
+	/* Room left up to the end of the page. On 64kB page kernels this
+	 * can be more than ena_buf->len, which is capped at ENA_PAGE_SIZE.
+	 */
+	room = PAGE_SIZE - rx_info->page_offset - rx_ring->rx_headroom - tailroom;
 
 	/* More than ENA_MIN_RX_BUF_SIZE left in the reused buffer
 	 * for data + headroom + tailroom.
 	 */
-	if (SKB_DATA_ALIGN(len + pkt_offset) + ENA_MIN_RX_BUF_SIZE <= ena_buf->len) {
+	if (SKB_DATA_ALIGN(len + pkt_offset) + ENA_MIN_RX_BUF_SIZE <= room) {
 		page_ref_inc(rx_info->page);
 		rx_info->page_offset += buf_len;
 		ena_buf->paddr += buf_len;
-		ena_buf->len -= buf_len;
+		ena_buf->len = min(room - buf_len, ENA_PAGE_SIZE);
 		return true;
 	}
 
@@ -1011,7 +1019,7 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 
 	/* If XDP isn't loaded try to reuse part of the RX buffer */
 	reuse_rx_buf_page = !is_xdp_loaded &&
-			    ena_try_rx_buf_page_reuse(rx_info, buf_len, len, pkt_offset);
+			    ena_try_rx_buf_page_reuse(rx_ring, rx_info, buf_len, len, pkt_offset);
 
 	if (!reuse_rx_buf_page)
 		ena_unmap_rx_buff_attrs(rx_ring, rx_info, DMA_ATTR_SKIP_CPU_SYNC);
@@ -1055,7 +1063,8 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 		pre_reuse_paddr = dma_unmap_addr(&rx_info->ena_buf, paddr);
 
 		reuse_rx_buf_page = !is_xdp_loaded &&
-				    ena_try_rx_buf_page_reuse(rx_info, buf_len, len, pkt_offset);
+				    ena_try_rx_buf_page_reuse(rx_ring, rx_info,
+							      buf_len, len, pkt_offset);
 
 		dma_sync_single_for_cpu(rx_ring->dev,
 					pre_reuse_paddr + pkt_offset,

---
base-commit: 0822d2fe38262e8b55c5ea55c970022bca8dd2a9
change-id: 20261106-ena-rx-reuse-64k-page-3769849b3e0e

Best regards,
--  
Cheers,
Harry / Hyeonggon

