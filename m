Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613493;
	b=sCRq6z7cDbnB/+KohOaQsa4eJZXh4+76//Veh3tOoRfdS9fi0LtKQW2wIrVS7yu/AUDP
	 Ba6Lwsi4tgIpuRn0zBNvxzibJAwXh5FNjC0+gHvRkLsGzaCZZJswZ/xfLH3yZgEui6HID
	 8TxOuQ9ESgvM1h64gut776RfZQfYECMXGMgKms7ELWOL8S+gmfzESZllH1evZXFzxs2PS
	 eyhfBfUIRf0nwp0MOnORCMm8Dp5UW69jrv+cXVTyJpjRw6O3jb+d6nB2aUK0sFd3MLN+W
	 df1E2+x/YsOqRt8Zt5oJFcFgVshIyswmZ05thLC7MeFM/RHe4GIdiyi+m01fAf5uO4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613493;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vjI/JQaVDOR19d/tdfvyfjruNnG1ZOaNzpSlgqnjUzY=;
	b=pX66oV4R7erjoJYALhdfxxFUbIbDVD4MjRASBHHT1W2KiuYkSnTtYU5fbvdZsSMCP3nc
	 ywK9UTcZtBMrjXFq3N+s7SUtmgbCB2thN06+pdyeLyGud7c95pvxbEJ2JimfI9OpM/6SR
	 azOW1tPgkZJ3fJK0qy/WxKAxRhTPi2W/2t4ddwIfewpJTFdQCSMG6JuTU/OVwAV3pKrpo
	 0MhcOIZBSsjGXU3m2iJ6gqokKJuFhEkj5/ukDhR7Imd0An4aYpYsT2BrnhxxseRuNKdVK
	 A4766DcvdAjWrCaYQ8OdcYxzExGhZtsrm6x1mFM20jpRMRv/OdmkEoaEbPnf03UdbCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=dBe4ffDQ;
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6BA606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C6BA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=dBe4ffDQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794613483;
	bh=vjI/JQaVDOR19d/tdfvyfjruNnG1ZOaNzpSlgqnjUzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dBe4ffDQK/R6EvFEzhGhu4HgpFr6EgPleRbN9cbCcAZOHU8MtxKZ3mo+WBsB3JyOx
	 JYsIAqw/WROQJ1zJG3pks1J8Y0pC2ydFLh8PSz6A/kqdJsjGGji4h8tVrECik5bqq+
	 BiB5HpQpe0gLHXLFEL459cYbVkWzZPPaMUm3p30w=
Received: from localhost.localdomain ([240e:3bb:3032:791:1c66:e624:37fc:2222])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B2594C56; Sat, 14 Nov 2026 07:44:37 +0800
X-QQ-mid: xmsmtpt1794613481t7rc6w42f
Message-ID: <tencent_2FE53706200A3120AE697CA59DF5EFADD907@qq.com>
X-QQ-XMAILINFO: MC6m07AaSFhrgbdkfdoApSPlw8RqaUYqBdtrDYTVYXBSeJMjFpXRGnqPaowPE8
	 5w/+uMM/UAo6QbprCC3xyiPl8lrIHaa6kZMbhsioP83dNNG40nuAoZ/NmfYknfDvFQHIwpOtxP1u
	 aUsS6HXWXV2UdNhgQ7hI6Itcc00a1h2IXniuKvi8W3spHQOzAMWYd/AmGNjpRCT0fdt5PnbbHOZC
	 uBNVDHKkeSfrAl83GCuSJWkFfaxUtmWWwo4D9Pf/JaGJ6Pi3vnS7csR5eM8LTs4yq0s8FlHf9ixc
	 j34QQgSttSf7FHew1s6gAOrLNmouJyHtYVtPt0oRX06usS5n8z9zd5SEKglqs+whdpU6jdzWD01k
	 bqcvlaQOC+Jpej68o9nhVe1ekFbXgSWkIThbjxKjwgqiUC5wf14zofjSdMdfOfhy4yGbamY3rkw7
	 nctq4oysHA8CrhQPhHdac3dz5jdOgbBVOM8Tks2EzDk93oUMFS+0C34Zw7nVqHQus0Ff4sUY0fS5
	 S79x9LtzZhFuv5lSlmGG8ZFXiTtVDMCW0Qxp5iHRfwaIPlmq31U1b5OpVL0qsvyQd+ALMmn0kFmw
	 XrNYPpsoFdKeLIJeAD2TBLrTkZweFtJ4e7K0CaNqHb6j2DRXk1ne0MsFYkj/g4GKOvGaKj15P+Kn
	 Hy/flkCvWBumgpe/AGtQXJbjE0goDEPLqhvYaeHMlCBO8chpV2LB7AKQ75W1wwhICH6h4JREoMAA
	 WTraKyXWtlWnZBmsMxPGDDT+kGX8GXOf8Nkeb3i3fGv0noqIjrFVTuDY1QdDYd2wTr1Heqe1+z9Q
	 RqIzwSggLzapWUISyrNzLnAZfZIvuPW9ey3ATLPtas+iUmqZzdYlf2JOCYCsjAZkL+CrXXFvGx/2
	 LNE7oGfuxLha/r5aWgwPykeyZOJ2gdo9O9VCUzC+jf80BUquOYu0WpIY1k3QitezX8t0ojlsktbr
	 uoUY6Qb8eADFX08KB8jECN+63U74l0E+YUWmioZVLIFz7LR61n2N2djn3sut9o2CA6KQ422nto+D
	 f2t7ETCBETxvjdkBCVnRqYploQPw5ask6vtLZOP7Pl4zrptttUcGtSGjHGcIhiJFSjWU6W/Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel.machon@microchip.com,
	Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	kuba@kernel.org,
	memoriaru@foxmail.com
Subject: [PATCH net v5 1/2] net: sparx5: fix RX ring stall on frames from inactive ports
Date: Sat, 14 Nov 2026 07:44:35 +0800
X-OQ-MSGID: <20261113234436.75276-2-memoriaru@foxmail.com>
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

When the FDMA RX path receives a frame whose source port does not map
to an active netdev, sparx5_fdma_rx_get_frame() logs an error, flushes
the extraction FIFO and returns false - without advancing the FDMA
software cursor and without releasing the skb, which has already been
extended with skb_put().

The DCB for this frame still carries its hardware DONE bit, so the next
NAPI poll picks up the same DCB, takes the same inactive-port branch and
returns false again. The software cursor never moves past this DCB, so
RX traffic on all ports stalls until the module is reloaded.

Treat a bogus frame as consumed: free the skb, clear its slot in the
rx->skb[][] array and return true, so the NAPI loop advances past the
DB the same way it does for any other received frame. The slot is
refilled by sparx5_fdma_rx_dataptr_cb() when the DCB is recycled. The
extraction FIFO flush is dropped since the frame is already consumed
into the DB, and the error is ratelimited.

Testing: not tested on real hardware (no sparx5 system available);
found by code inspection while auditing the RX error path.

Fixes: 10615907e9b5 ("net: sparx5: switchdev: adding frame DMA functionality")
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 15ec9b0..e35ef0e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -157,9 +157,11 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
 		       sparx5->ports[fi.src_port] :
 		       NULL;
 	if (!port || !port->ndev) {
-		dev_err(sparx5->dev, "Data on inactive port %d\n", fi.src_port);
-		sparx5_xtr_flush(sparx5, XTR_QUEUE);
-		return false;
+		dev_err_ratelimited(sparx5->dev, "Data on inactive port %d\n",
+				    fi.src_port);
+		dev_kfree_skb_any(skb);
+		rx->skb[fdma->dcb_index][fdma->db_index] = NULL;
+		return true;
 	}
 	skb->dev = port->ndev;
 	skb_pull(skb, IFH_LEN * sizeof(u32));
-- 
2.39.5 (Apple Git-154)

