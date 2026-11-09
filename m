Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244525;
	b=EJHX8yHBuDIE1oOxxwQXmCbVotivwsHuImjXcLmQgHMdvmPihzB6xAEULN74pCOsWhj2
	 /kf5/D0fCdj2I8od7QigGvHJXbOA3KM2iVgshwU/bHqWoPAsji6G9jPh9M3BGsoDMdyhJ
	 ybHZy6m+oh2tn/OxzDgOocay3bdIUHyswVBxlGf+1m4+kJ/c9PNkjI8bz/StdfELkesTF
	 aqmvUlYGGYvhzuw5W0QCUKsEGqBopGzOUo1xzRbUvo635vekf7mu/oX/F3IsXCWcMeqnw
	 407zb9ZKkhW+iNb8qSdqVwaNQW7SRtU8Bp6zg0Y7rPwXGaUd1nxzZZM3vXeU6K0B3Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244525;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=JYU/YOHgKUefKiRsUKOG39mq8EpWpOO2VhrQ/JylSVM=;
	b=17XMHu4RKqnjRCFPemL7anGkZ+vptfIZKcFKbSWaZTdILcMcijwkbwFEIx6G69NDqcbk
	 jeFxaA0isytSphe7JDLuEV6RIwN+9O18THni1ch0IHtEPYXE6QcMMSgvsG6c1CP5P2l8h
	 S/MEHXItTlsUFcLKXxLlM+FA8KQgEUYqjOnPUB5hobFwXN8wNANV2UuI6aIW0BZua+shm
	 fDL0SnGjMU4ueFD2S8n7ER2BXvkzCT6jDSA2kXvlEZSsr1+n799jSu4SKb4nWTzloVKj2
	 IT7jnbuk8TBtNZe+xmy2lpoIQSdq4CXLimt4WuM7YO+jsYRQpsAO1kQQAul0+zf7rSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=v09Gl4cW;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F8606A325;
	Mon,  9 Nov 2026 17:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 817F8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=v09Gl4cW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=JYU/YOHgKUefKiRsUKOG39mq8EpWpOO2VhrQ/JylSVM=; b=v09Gl4cWn7uNQhxEZNCmBfbNya
	T+sb+Oxts0BgEVA76YudLM57OXo4AEd+7G3SU21JrAv1PE4/vAkTsJwkNGL8blZUSTcmfihgrW1R9
	7D7JLWg/g0zGM00oifNPE7izsaK0XQtjqlpJ0SKqv+kQn2hyYpSfbyb5XZs/YIlCM0XIIkfIYwl1n
	ZXlVD/naLNTbF2OblcP8DhpG0ARlEGllIzpBHLaKFJYkOlb70WGNNDJnEFokzRoFgku5QX0ewU3ge
	GOGJbeM7CZBpl9dAUbZP7H478fxlPkfHJiC/A0qhb7kOCG+aCVLxT/Bnr/LdQxoJLCycLo8sv9Euh
	JrTJYk0g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQSxf-00BmJN-2l;
	Mon, 09 Nov 2026 17:15:16 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Nov 2026 09:14:29 -0800
Subject: [PATCH net] net: ena: Keep the RX buffer mapped if skb allocation
 fails
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
Message-Id: <20261109-ena-rx-skb-alloc-fail-v1-1-aee2927cb51f@debian.org>
X-B4-Tracking: v=1; b=H4sIAHT/8WoC/x3MQQqAIBBA0avErBvQjIG6SrQwG2tILDQiiO6et
 HyL/x/InIQz9NUDiS/JsscCXVfgVhsXRpmLoVENaa065Ggx3Zi3CW0Iu0NvJSC3ngwpImcUlPZ
 I7OX+vwNEPmF83w/bA/eobAAAAA==
X-Change-ID: 20261109-ena-rx-skb-alloc-fail-e4f636066c30
To: Arthur Kiyanovski <akiyano@amazon.com>, 
 David Arinzon <darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shay Agroskin <shayagr@amazon.com>, harry@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2916; i=leitao@debian.org;
 h=from:subject:message-id; bh=LPKsa7T00qcgXRyoDqB073prQu5Cuda3IqoCxZ8jjH0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8f+gKvtMuAoYcsDyR7F6kK1YSCkHcNRQyVaNh
 Lvl33dSnCWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavH/oAAKCRA1o5Of/Hh3
 bbLjD/4mB4e+HMtX/0Wl6aFhSCqlvy51+mKWVBkxYm924d3DZ7EB5owN3Pj77fnKkKR8cGvpbk0
 QgHQUAGyK3BH1vkyGJV7JWuHEYQJh1p5K2xPopwlaofzQ1aRH1SiGOlORhBMsySwkx+HvYrNF81
 6dbrz1AU5W/Vnpbxg2B7Tyj05V42Wpr/2k67ju6/YOljM3aARrm0DniEz3Iz9ID0U25MqxVOQgZ
 2pwuI7sxZRax+mDlGnGaWSROjfb2zOjzLlxweG8PFVXdYeMnrth0WZV16A1huw0JsAMcZJf4rDY
 kPc1Ves2wRfmT1+CEVt3Qf1MSbCpAFMsYBACeo+gYe8h00gYgKBtL99asXkloJM55RnV5Kc8tKH
 AwxOtZ1mW8Y47qBJp9M27arOqffMbZsFhd3QhFSU38AoLkBTjD/ggPPwVAYKeaLz1w7BlkRzwW2
 dOtcR4E8RtG0oQxA0LJoDp8Y8begh9/oUVf9kVCHGWSH7M3OKtN9qJBzD/w3XcTpd5IdBw1fJ+g
 Y/EjHQXbHm2/2nSqLaJZuYAY9ELT3W+81PmDXs0wVXCcg7Mex6AchGq6a2iDqu2lfDhBKjlKD9p
 SmWSPp5FXixwPUrwDy5DGzRMK5Wyn3WZk1wWDW6h6ujVwNdRJFWrP+0WCFL/Fo6fY7exrssCDVi
 1nhvZmn2YOnGfGQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

We are seeing the following issue in production on arm64 EC2 hosts
(m8g.metal-24xl, 64K pages, SMMUv3 in strict mode, 6.18 based kernel).
Right after a global OOM, the SMMU reports F_TRANSLATION write faults
from the ENA device, followed by a burst of:

  WARNING: CPU: 48 PID: 1656834 at drivers/iommu/dma-iommu.c:1242 iommu_dma_unmap_phys+0xf4/0x108
  Call trace:
   iommu_dma_unmap_phys+0xf4/0x108 (P)
   dma_unmap_phys+0x194/0x2a8
   dma_unmap_page_attrs+0x1c/0x38
   ena_io_poll+0x7bc/0x1790 [ena]
   __napi_poll+0x54/0x220
   net_rx_action+0x250/0x520

ena_rx_skb() unmaps the RX buffer, or takes an extra page reference to
reuse it, before napi_build_skb() allocates the skb. If the allocation
fails, it returns NULL with rx_info->page still set. ena_clean_rx_irq()
then puts the req_id back on the free list, and ena_alloc_rx_buffer()
treats the buffer as still mapped and posts its old DMA address to the
device again.

With the IOMMU in strict mode, the device then writes to an unmapped
IOVA, and the next completion of that buffer unmaps it a second time.
If the IOVA was handed to a new mapping in between, the device can
write into that buffer instead. On the reuse path, the extra page
reference is never dropped.

Allocate the skb before touching rx_info, so that a failed allocation
leaves the buffer mapped and unchanged for the refill.

Fixes: 9e5269a915a8 ("net: ena: use build_skb() in RX path")
Fixes: f7d625adeb7b ("net: ena: Add dynamic recycling mechanism for rx buffers")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 7eb6456ed0d556..15e5cfeb0abe7f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1009,6 +1009,10 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 
 	buf_len = SKB_DATA_ALIGN(len + buf_offset + tailroom);
 
+	skb = ena_alloc_skb(rx_ring, buf_addr, buf_len);
+	if (unlikely(!skb))
+		return NULL;
+
 	/* If XDP isn't loaded try to reuse part of the RX buffer */
 	reuse_rx_buf_page = !is_xdp_loaded &&
 			    ena_try_rx_buf_page_reuse(rx_info, buf_len, len, pkt_offset);
@@ -1016,10 +1020,6 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 	if (!reuse_rx_buf_page)
 		ena_unmap_rx_buff_attrs(rx_ring, rx_info, DMA_ATTR_SKIP_CPU_SYNC);
 
-	skb = ena_alloc_skb(rx_ring, buf_addr, buf_len);
-	if (unlikely(!skb))
-		return NULL;
-
 	/* Populate skb's linear part */
 	skb_reserve(skb, buf_offset);
 	skb_put(skb, len);

---
base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
change-id: 20261109-ena-rx-skb-alloc-fail-e4f636066c30

Best regards,
--  
Breno Leitao <leitao@debian.org>

