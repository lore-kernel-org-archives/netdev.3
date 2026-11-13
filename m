Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613496;
	b=QFjIjfRkyBIrHi7Gl/Xvx3L+7lQ+ooDrdmPVIpqq9ZamKlpjnlZ8lGem/CMk48hbziqN
	 bPuVNzbsa1xljLALJgKMrVY8aiqWP2roOE+JJpI7nz3IK5ooAuv0TPrwcb4Hf6Sav7Ll+
	 2kixC1A3oA2bYZ5EBDQKxvnUM+KEHa8OH0c97iQLz/6sDQFP+bUUknqmb+HkxcY6gsRu/
	 Jh+VISNXAR7hSlbRd/BnaJv/6BpbnGu8FIdym8F5iIxwAUW/5MnAH4GHE8+7VaLvg5p1B
	 Kri0xMjPhUmDxzaFZGMj4P2StSb7ZQ10v8xJbmA/FOypkBdtQiFXrL7tWOPaY1tXdww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613496;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+6DmNrj0lKbC0i8yyJ4hH70nrMKZXTIBZ4cyxQ6R19c=;
	b=sCbo/5Sl1FTNcnf0RMYTuFLmx72S/U2Z3TyK3ZJh37A7viRp2oAxjeA49aMVUrGxIf+y
	 clMSAY2Ehh1yNABoDzps8laP4rOEUwavimCyY/Ruu/TIPnSAdbXooIEBdSADIjnwosce1
	 rZhQWbKFBvD0ofLC5d3o+/cWRsSABQJySxq5pGEYAZqAxxzFL9BeavKjY8hisPDTM/i47
	 Tzm2WhbZuokNjOZp16FRSiDJZuGfOJB4rYJaSK6i2T+jsW0CYwz81JP7dHffo2lBy2xzN
	 6KN1sSSdsjpXM9pgfx7vzoK9E2Qucl22LTDfBT2sR4YjVDEBBAIUlxbmrWtE/mCuqdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=fwoazdPm;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2E606A331
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC2E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=fwoazdPm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794613485;
	bh=+6DmNrj0lKbC0i8yyJ4hH70nrMKZXTIBZ4cyxQ6R19c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fwoazdPmdoiZE79Bm+j8Uyf2hJYdkd2yP5VR6hjT8VlmubQW1nQFYz7xVwJwqMKkK
	 uidIfXnjbDev84gRswpeTnRLbUE+o0xJgUR6OEKKZLDJbsEfhtBezFEkHfEIeE+dg5
	 30ciys/51tx/dEBjqd18VGhZqmJt82iIrgTwmHm0=
Received: from localhost.localdomain ([240e:3bb:3032:791:1c66:e624:37fc:2222])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B2594C56; Sat, 14 Nov 2026 07:44:37 +0800
X-QQ-mid: xmsmtpt1794613482tx90uzoj3
Message-ID: <tencent_364C372B15AE436C192DFB31905364000D0A@qq.com>
X-QQ-XMAILINFO: MJf32pulH481/XhV6XrBMSzMZufquwlOtl4+VypOeFTVrmcQmGQiKfUMT/meF5
	 N/t3TckGsE/agM1K9vrp4siJueOF+OnX1g/j/Obml/NBQsntJHWQZQliYH3zOO7+Vv1dIvxBGkU0
	 sFNRyMEwm2KcOEU33GuM0vo5Bj1gbWqd1Bdk8ptOAQrBC0udIG6XoDZUDgkIZQoVASgCzxCInYZ1
	 /oOulxlHyxBW7d/8T9NQHl05hHoN+A+8hnuGmer8NZdgbw9oSWuPqhEztv9Er6EbspTEAunSHIVC
	 Z8+GvGpfduNz3k6Zzhaca32uO3vM7xDtZ+AKeMESuvo8iZFH2xvd0iNnvPJjKApBgWHr80xE/x35
	 JwQOgZ6wlD8PL/b8CkiFzF1VGz92ozzeBZEZil3xX80shnOsz3M5QNZygjKgMWCzqP0DQhWmMHYa
	 /8G/CzDIyQArJAHvnpRl4QPsElzgWKQkBmkTDgjhmqW5aZ5haQhefPfNGSah8TYMoYDjMVeuEL30
	 w7g+m3Kaav5rTLuz9RZbbM75dQprpu3llurKaXknun7NfPFgBoWYrQc0sDGa1zc2Cwyy6ln8TBzP
	 xx+waTmWYVHpyltwalgBtP4eQGhmUq2mcKWMYkJebxekXxdBvaNDzxFpcH7AG3LJEUOt43YSSNJU
	 cpy4DMzZEoTeyCbwy7WSqqLmoQtGohaLb3HH7VqYq2tjJVGPefJoENC7hXRdA13P79sBVDdL6LLv
	 V+JSuoVT/blhI2JUzAw17RAw8KWbsm15n8JfcWFuczYpk5S2LMRmBwAu2S63a1MY+k56MvOfkrZj
	 9+VaJqD8k+Y70K8A7fRn0w9p+UKncsh4AOGMXutiXLMBp3KO8hfjX8qWiucUpSFxREkdxTIb/+oW
	 e+Al16t8pfl65jvSFo4fJRgZ6ZcWbvFgSRRVos3tm7D5t7GK8zG4cnTIMa4E4meivTlDvQqZdGzY
	 m18M6FUypgPXfeoNEkB7VkqzApHX00WrskVLFmFRvkRPmcnNXszQfZfbA0het05cdRSxy4GY564e
	 lMbzqtSDl6svO0PJg/m3gvDSl2JNXdvwBez4VH+C9pUmOAbM2qLBNOelNp+9Rd4OrxEY4D/Y21UG
	 D/6yU4bLKlJDHQJs0=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel.machon@microchip.com,
	Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	kuba@kernel.org,
	memoriaru@foxmail.com
Subject: [PATCH net v5 2/2] net: lan969x: fix RX ring stall on frames from inactive ports
Date: Sat, 14 Nov 2026 07:44:36 +0800
X-OQ-MSGID: <20261113234436.75276-3-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261113234436.75276-1-memoriaru@foxmail.com>
References: <20261113234436.75276-1-memoriaru@foxmail.com>
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

From: Zhang Hewei <memoriaru@foxmail.com>

When a received frame's source port does not map to an active netdev,
lan969x_fdma_rx_get_frame() recycles the page via the page pool and
returns NULL, which makes lan969x_fdma_napi_poll() break out of the RX
loop without advancing the FDMA software cursor.

As on sparx5, the DCB still carries its hardware DONE bit, so every
following NAPI poll picks the same DCB, hits the same inactive-port
branch and breaks again: RX traffic stalls on all ports until the
module is reloaded.

Unify the NULL semantics: NULL always means "frame dropped, page
recycled", covering both the inactive-port case and a failed
build_skb(). The poll loop then advances past such a DB like it does
for any other frame, dropping only the bogus frame and keeping RX
alive. The WARN_ON() backtrace is also gone, which previously slowed
RX to a crawl on every bad frame.

Testing: not tested on real hardware by the author (no lan969x system
available). The drop-and-advance form was verified on lan969x hardware
by Daniel Machon during review of v3.

Fixes: d84ad2c0d80c ("net: lan969x: add FDMA implementation")
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index 053d125..4181a9d 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -113,8 +113,12 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
 	sparx5_ifh_parse(sparx5, page_address(page), &fi);
 	port = fi.src_port < consts->n_ports ? sparx5->ports[fi.src_port] :
 					       NULL;
-	if (WARN_ON(!port))
-		goto free_page;
+	if (!port) {
+		dev_err_ratelimited(sparx5->dev, "Data on inactive port %d\n",
+				    fi.src_port);
+		page_pool_recycle_direct(rx->page_pool, page);
+		return NULL;
+	}
 
 	skb = build_skb(page_address(page), fdma->db_size);
 	if (unlikely(!skb))
@@ -258,10 +262,8 @@ int lan969x_fdma_napi_poll(struct napi_struct *napi, int weight)
 			break;
 
 		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
-		if (!skb)
-			break;
-
-		napi_gro_receive(&rx->napi, skb);
+		if (skb)
+			napi_gro_receive(&rx->napi, skb);
 
 		fdma_db_advance(fdma);
 		counter++;
-- 
2.39.5 (Apple Git-154)

