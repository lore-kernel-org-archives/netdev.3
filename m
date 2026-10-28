Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223415;
	b=WBFq00wsIM++T3NoViMsaE/FbGHXW3BS/pT01PynWr/29/0KQcPffbbF3AbAoC9QphO3
	 DJijCjkEtiRdQQAtBptFz8uH7a1XWpInrolpClqvyd9jvUDehYGJlUQvupDUwU8mUeKxq
	 HWRie9CO/QKlmr2Ubk0TGl1B0V9gvw6YclfozH3wcE+58gfaxQquMW7JlktkIVJ5qeNIO
	 jyVS6ZS/B3TWJ34CBhgi432NE9x6X5PjfrtfXq6LBHtUpNMHnSb63AALx7gPSmhQ1saoX
	 U2qp1eWyx33y8ZGo8xVcmZc8wFpONRQ9q1jAYX5/47bb5PUEx8B4VQUZ/9wFXDGnCTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=+pdTJiJ2YPrSz4NpSyy9VvItjU+Z1rpFrJy8LQQFx8o=;
	b=zG1D31IqL+a8YtibFLVGRKZMwo/PxZqTIwLRtL23rqSotj5w+snay6XTT93DRwD4jl3a
	 0ghV9G3afQRGSlNRjdVOxv55NPrJTG0zVNierC2VYr0wHa/+PQ8UlJpa2a6ArTBHxlupU
	 f0JO0B5Xjraks2au3YthKN0e7kdh6tHp8jKxWoohO+rClckE6+8PCOmjnhXn6V4H8DUvx
	 n44Vmjt4rnfJgOxOq/TtjvHptP7OUxkGoCUWC8iDxh/xoGVZpW04aRHtpiG5WhRlrUFke
	 ZdflL7pENfVH5ljGNEOLCt7pFP82Xgv3CwcoAGnFKSDg2DStl+hzZxpQ/kCcHxy/Bgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zby2TfPS;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056F606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D056F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zby2TfPS
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so1079848a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223414; x=1793828214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+pdTJiJ2YPrSz4NpSyy9VvItjU+Z1rpFrJy8LQQFx8o=;
        b=Zby2TfPSNZb6mCWBCl5ZPCA6kSmSfRkiTnCqDGCvRdBX0KiSlFc0FK4TYwyzHWl4y7
         yB+ttUTMUZkgZbHXNSEz7CzOT2gj7jJfto5gojZ9f2gSAyWm3aI9KQh09j9j1hjdAJsA
         8WpgE9cquw6rv/IM0XIFqTG7Be4rIv+AyNhXloustjKToOSkVk7E7DtsbPPOhluw/evS
         n8IPKLBhUMir2kKi/5mdDaVwsD93ewH0fKj4B7iy8Jh89lxHMaO8mVwmPoxIpkepo9Ul
         5Vj4BVnm95QzZIXTrmzZTbdO4HBXZwW34XkdzPzwnHDnKmC2fJyhtQdwtQoCO0/ej4fY
         TYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223414; x=1793828214;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+pdTJiJ2YPrSz4NpSyy9VvItjU+Z1rpFrJy8LQQFx8o=;
        b=NtdfXn/6vRa4IMXw9DAQjR9j+4vdLGRTyXr4pygI0F5iLtQzVAarj6cNzSrxmomNMw
         Ti8pak6196KDlFbW8SAuGnt19XXmU+iL6a52ztb+P4jGa1624NYcpevef3fY57KZIaxZ
         g3jQEAgo+wdzvfopZkE7BUeB+T+zk3XMiL4oyOUtaycuP85D5SP1dszcmUGiWruP1hKV
         hWm9oK7OJIaiSFgHKq2cp+m+ZxWClNcFyDsGriGqu0Yuf1GziesMxOCuXrwsccnmA0D+
         co2dUbERcRvdAPBV2pqmrsW3+fQ7Sf8DLF3yHIimfD73v/oh92f2vJWoEHG63BWwN/VM
         CPbw==
X-Gm-Message-State: AFq9FYLDrWCx1nDXNk4FZrQOewTpsS3rK8WAW9T9AKCqgvPDI9HFeSxK
	0CgiwML70L6adzIshKEAnftZeSI/VYm9BRJ59udA2N+uNxOXlmM34Ig6
X-Gm-Gg: AYBFou3Hhs0Rq21V7qFNt2jwEbzv3458Xp2xUvjfQjicYJ0mUNePLYtmlXI10+oEZCC
	67NL0t7vgOHeOEGgqGBk/EdZnvw7yMeMH5aWoQv/ixC9xkonCTxcsQ/FkAqlc0jKEDqSSUmX7rN
	APD8zI2g97vzTmCVIPpNv+2CplTmz2psQ5LkAC7keReRkXdAkSS4La0FkYlOufRDgo38n+UKlpw
	tsMc8ATzPBb+2c3ClB5X2vOBFVOLYHN6ieYi3G/XSVTRNUl5vSDBRlN/K7qRPYvGzHeDp3SDfx9
	SDVwlLFvdq77TxFpOIX+Oz88znH9TJfpu6RgCc7BMhwUs0V1fq6x4himplPzc9uhxlAHKIvAi8S
	QU2jw5O5Fu19PY7624yenSo3UUDoTXSQAYibG58IHMdRugMza81xKPQL6i9vvQA2Ns6MBnM1fI+
	lEMGqSJ1Ok2xuGTvYUhCuosbBe3It1NKcaMJK26c+qHywjf9kRMOnUj3G30WRbpxtT3zim3cCqL
	ozx0Vc/YnbvcntQy+XGar2SJfjLeGbg0eQLCkDUa+ZcPnE/frVfOk04oLi7FZzPGITTtveHpWnz
	e8jXTX6tLAICHqCQSkftisome/AoVTOgdv2p7j2BQEm47Cqek1a2zJof5y9HxHJTb94yl8Zm/Rn
	anohvT1LIuiSfyXX2YvItg1esYsiDnAqx20hLXG5/ZjSZ9Q==
X-Received: by 2002:a05:6a21:39a:b0:3e2:8f64:e4ff with SMTP id adf61e73a8af0-3e9023c11b2mr2986622637.31.1793223414123;
        Wed, 28 Oct 2026 14:36:54 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccb7802sm4455906a12.22.2026.10.28.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:36:52 -0700 (PDT)
Subject: [net PATCH 07/13] fbnic: Let the multicast sync reuse an entry
 waiting for deletion
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:36:50 -0700
Message-ID: 
 <179322341021.40667.10115759993706472767.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
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

From: Alexander Duyck <alexanderduyck@fb.com>

The __fbnic_mc_sync function only hands out MACDA entries in the
DISABLED state. The __hw_addr_sync_dev function unsyncs the addresses
that went away before it syncs the new ones, and the fbnic_mc_unsync
function only marks the old entries DELETE; they are not freed until the
fbnic_write_macda function runs at the end of the pass. With the
multicast region full, swapping one address for another in a single rx
mode update finds no free entry, the sync fails with -ENOSPC and the
device drops to all-multi. The new address keeps a sync_cnt of zero, so
it is only retried the next time the address lists change, and the
device can sit in all-multi with room to spare until then.

Treat an entry in DELETE as free. It may still carry tags, as the
fbnic_sift_macda function leaves the BMC tag on the entry it moves out
of, so clear them along with the address and mask before handing it out.

An entry in DELETE that still holds the address being synced was already
matched by address, but it was handed back still in DELETE, and the
fbnic_write_macda function then wiped it along with the tag the caller
had just set. Reset that one the same way, so it comes back as a fresh
entry.

Fixes: eb690ef8d1c2 ("eth: fbnic: Add L2 address programming")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index d69c91066508..ee781a3e1528 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -520,12 +520,16 @@ struct fbnic_mac_addr *__fbnic_mc_sync(struct fbnic_dev *fbd,
 	     --i > FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX;) {
 		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
 
-		if (mac_addr->state == FBNIC_TCAM_S_DISABLED) {
-			avail_addr = mac_addr;
-		} else if (ether_addr_equal(mac_addr->value.addr8, addr)) {
+		if (mac_addr->state != FBNIC_TCAM_S_DISABLED &&
+		    ether_addr_equal(mac_addr->value.addr8, addr)) {
 			avail_addr = mac_addr;
 			break;
 		}
+
+		/* An entry waiting to be deleted is as good as a free one */
+		if (mac_addr->state == FBNIC_TCAM_S_DISABLED ||
+		    mac_addr->state == FBNIC_TCAM_S_DELETE)
+			avail_addr = mac_addr;
 	}
 
 	/* Scan the BMC addresses to see if it may have already
@@ -551,9 +555,12 @@ struct fbnic_mac_addr *__fbnic_mc_sync(struct fbnic_dev *fbd,
 		break;
 	}
 
-	if (avail_addr && avail_addr->state == FBNIC_TCAM_S_DISABLED) {
+	if (avail_addr && (avail_addr->state == FBNIC_TCAM_S_DISABLED ||
+			   avail_addr->state == FBNIC_TCAM_S_DELETE)) {
 		ether_addr_copy(avail_addr->value.addr8, addr);
 		eth_zero_addr(avail_addr->mask.addr8);
+		bitmap_zero(avail_addr->act_tcam,
+			    FBNIC_RPC_TCAM_ACT_NUM_ENTRIES);
 		avail_addr->state = FBNIC_TCAM_S_ADD;
 	}
 


