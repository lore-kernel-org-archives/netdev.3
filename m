Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614349;
	b=LTI/2FGs9P7eeNP1fOm64IQguWkTCZwG2o94jnFmUIDtpgVgD5U77CAMEIZ5RBNVP4fZ
	 RvihDE8jW8jtfBpT1/qt+oD3hhb4RADiv9D7pn3lWteCFqcNyVDdkXKtAeZ0hZjnmTW+E
	 u/EaFj+QIqj1/NCDCrrI8KAIQop9cWrRsXWoYfAJ3l+zzDxCMUdluYFVu4UzKwtYzu2OZ
	 6aW+KEAju9UO+nJkRZKLB17WUAOqd0hLc7dzmoddNlEk3XlndqeZZCbAb9bfub6lUP2C9
	 NE4clEvptlpaKdgsVdmv3gR/wqgQysDHJJm8YrTSSZTRaDumpmG11m20hgRdJzpdmLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EVQIgja+KMPXdTV3DxptR9gCtQg/oHJzcCZeV6M7rI0=;
	b=27PJBtbS/xf/D5D+VJniucbuhfOyXE89iEvFQ/ax1m/URHYwp56u/OaMzCjn5DTboJqb
	 +0HCxNzX83fD1PJC4XyJHZkE//gK95EwPlsl86SRyepmma34FsT7Ju53c5nwxlnZ0gk/u
	 kWHUNlLUbaGr2Q7N4K4vrxHd8exkFfu8XPD3K9cZl5luhLvnZtuZ4nxr0bpyRjY7I+b0W
	 dkcsiQbUq3s6FOAZ7fk9dKOQ0GRHuCox6Unf3W+wWMXWbiUoriRTShxdKTDvxoBDtS5kJ
	 ueeFJfYEgTYlZ52o6LdmP7PbJ21wY5N9m/nzB2OBJ3mUcIm/2IX5Uj4SZf9onxKhF9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcYnU9wK;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A660A2600
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 782A660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcYnU9wK
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d21051042so323565366b.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614341; x=1795219141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EVQIgja+KMPXdTV3DxptR9gCtQg/oHJzcCZeV6M7rI0=;
        b=RcYnU9wKb/bGVQGflm2btBEsjiQpoLNIKdcmqYs7m3ClQbS3wsScIUisGYrUqMOyu8
         v2yKz2F3b/yGI7FAv6EaqM3HzjLB8ouajjZIV6CVi6hDLf8OcVwE+TqyOPFsT9e/Ttpr
         Cr/TO+NZsSGFFTUtAJw2IlvRvGObOkLbhlo1aOkxN/PAG591fMxd7HpL1kAe5CcObyik
         GtecC8+Mi/x7sjwIOPx8RTEO9yp3u0OKS68R59PP/qHRDf8ZAxT3mJ8kA5ynEsvlRagt
         BT2qeHo3grbbCSCfdvi8QfBk7prnxys4KGao9uc06mV9Qe/sSC0VBiFGwKSW6FvgMCU6
         aZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614341; x=1795219141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EVQIgja+KMPXdTV3DxptR9gCtQg/oHJzcCZeV6M7rI0=;
        b=O1OqO89+mGwtuSLwOr+BwzdVeExZ55NZuAw4JQhPi39PuwLOngoz9zy+SdsdqoINCC
         qD4w+uuzriWII4N0I9pGfsdvUsw9OtwNy7Ye6xXUdHbJuNARVWZz/ZJ7h8vcUU0qYTdd
         MmNv/LnkgmofRMybQ2XFaEul+xYjQCVpjyRujbeGcQooTQ69vKbpJM367lHl40XPbtWo
         JDWd/WOLgu2SdQPGSsYuvoX8kKsmiSkQ1m4lRK1vBOsG/oQossEguNoqzUoATH6dsUjk
         MhSJBrjXQRDp58ESle/+oldUbMo/p8cN6NptWSwUr7aBPgkbSFnp9T73cd/MYVvz/3gI
         ZFXw==
X-Gm-Message-State: APuU4Z/uWHbBaVbYSvuVOyC+6NPEyiKOnwxhxBBZkINwUxkM+4jlxjxe
	nhBj93U5jxHZsof8Ir3zd4ByG9C5pLg0p2z6xTKFd+0eLvOpoG0tWWygRa792lS5
X-Gm-Gg: AYBFou0WuxzUHI35v7dkO+1mMgJOPLGI5LoFHc9LqRM0Pj5hG2HH4+bffENFZA42iyV
	SgLxkvXxRohKm3DK505Nw0yDqFGoH570vvpNt8SQO62qKwZrOXwkjsBwSLhyPEh8I812qdqLVhb
	EZ/PbXiAJDEXyqukZ4Tetoviz1QpCktvj2OqTph1bKe2Toxc0fwXiW+fJKjOu7IrIh3gyTt2wy6
	0QEWqueOqBJyZJ0iahDfvBcVfAgWhbBaV2VmFXAlK6fTBzjFF//2wPfYiDiUTm5hHdguNwZRi9X
	s/V7QUf9QD+SBeUPFGFcAqX2ODIU6GAunrpqfZTqsoBpCRDRd8nsfSSgX1is1zAL/TH8IUrX9oK
	CREr16lYzdtA6hPqYj2T9qLXVp+fEO5FOcYdHhnuX887nLk3b6evxYBl+cbtMGapUTZNUPvBYOZ
	kUvP91/K+zGwOJU36IUAycZbk5khXE86GYf96Gdb3yU2303Rx6xfft3Y6BTYGJpDLtGOWwK+3Mw
	yJQZ5DijIPGWX2I7Z0ZV8bCTYtBHNu+zhxtYxbcm0MhkZunPhhclwcw2onZCGU3/02iXZ5vyA59
	1uMygk9H+ZCye8mV/DvrDPEsBpjQCrDXjpS5P3Hz
X-Received: by 2002:a17:907:86a0:b0:c44:16ad:c31d with SMTP id a640c23a62f3a-c509614d4abmr362582466b.4.1794614340662;
        Fri, 13 Nov 2026 15:59:00 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm153454266b.32.2026.11.13.15.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:59:00 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 7/7] net: bcm4908_enet: order the TX ring index accesses
Date: Sat, 14 Nov 2026 00:58:47 +0100
Message-ID: <20261113235847.517308-8-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113235847.517308-1-kudzo51@gmail.com>
References: <20261113235847.517308-1-kudzo51@gmail.com>
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

Since the TX interrupt was added, poll_tx() runs in its own NAPI and
does not take the TX queue lock, so it and start_xmit() share the TX
ring with only the two indexes between them. Nothing orders the
accesses around those indexes:

- poll_tx() reads write_idx, then the descriptor and the slot. On arm64
  the later loads may be satisfied first, so poll_tx() may see the new
  write_idx together with the previous lap's descriptor, which has no
  OWN, and the previous lap's slot. It would then unmap and free a
  frame the DMA has not sent yet, or free the old skb a second time.
- poll_tx() publishes read_idx once it is done with the slots it
  freed, but that store is not ordered after its loads from those
  slots, so start_xmit() may refill a slot before poll_tx() has read
  it.

Publish each index with smp_store_release() and read the other side's
index with smp_load_acquire() before touching the slots. start_xmit()
now publishes write_idx right after the descriptor, before the MMIO
write that kicks the DMA rather than after it, which narrows the window
in which the DMA can complete a frame that poll_tx() cannot see yet.

Sashiko's review of the previous version of this series pointed this
out; I have not seen it on the hardware.

Fixes: 12bb508bfe5a ("net: broadcom: bcm4908_enet: support TX interrupt")
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 26 ++++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 4139dad3a..8bc620de2 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -566,7 +566,9 @@ static int bcm4908_enet_stop(struct net_device *netdev)
  */
 static int bcm4908_enet_tx_free_descs(struct bcm4908_enet_dma_ring *ring)
 {
-	int free = READ_ONCE(ring->read_idx) - READ_ONCE(ring->write_idx) - 1;
+	/* Pairs with smp_store_release() in bcm4908_enet_poll_tx() */
+	int free = smp_load_acquire(&ring->read_idx) -
+		   READ_ONCE(ring->write_idx) - 1;
 
 	return free < 0 ? free + ring->length : free;
 }
@@ -619,12 +621,14 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	dma_wmb();
 	buf_desc->ctl = cpu_to_le32(tmp);
 
-	bcm4908_enet_dma_tx_ring_enable(enet, &enet->tx_ring);
+	/* Publish the slot and the descriptor before the index; pairs with
+	 * smp_load_acquire() in bcm4908_enet_poll_tx()
+	 */
+	smp_store_release(&ring->write_idx,
+			  ring->write_idx < ring->length - 1 ?
+			  ring->write_idx + 1 : 0);
 
-	if (ring->write_idx == ring->length - 1)
-		WRITE_ONCE(ring->write_idx, 0);
-	else
-		WRITE_ONCE(ring->write_idx, ring->write_idx + 1);
+	bcm4908_enet_dma_tx_ring_enable(enet, &enet->tx_ring);
 
 	/* poll_tx() wakes the queue once there is room again */
 	netif_txq_maybe_stop(txq, bcm4908_enet_tx_free_descs(ring), 1, 1);
@@ -718,7 +722,10 @@ static int bcm4908_enet_poll_tx(struct napi_struct *napi, int weight)
 	unsigned int bytes = 0;
 	int handled = 0;
 
-	while (handled < weight && read_idx != READ_ONCE(tx_ring->write_idx)) {
+	while (handled < weight) {
+		/* Pairs with the release in bcm4908_enet_start_xmit() */
+		if (read_idx == smp_load_acquire(&tx_ring->write_idx))
+			break;
 		buf_desc = &tx_ring->buf_desc[read_idx];
 		if (le32_to_cpu(buf_desc->ctl) & DMA_CTL_STATUS_OWN)
 			break;
@@ -733,7 +740,10 @@ static int bcm4908_enet_poll_tx(struct napi_struct *napi, int weight)
 		if (++read_idx == tx_ring->length)
 			read_idx = 0;
 	}
-	WRITE_ONCE(tx_ring->read_idx, read_idx);
+	/* Be done with the slots before start_xmit() may reuse them; pairs
+	 * with smp_load_acquire() in bcm4908_enet_tx_free_descs()
+	 */
+	smp_store_release(&tx_ring->read_idx, read_idx);
 
 	enet->netdev->stats.tx_packets += handled;
 	enet->netdev->stats.tx_bytes += bytes;
-- 
2.56.1

