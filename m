Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920519;
	b=fS1cHSPsubb/sOTx9Evd8ruDHpRL502vH2pHAUOjSPrn+NzD0nnTmEAKeOVzAWcLEsGh
	 ZBogxkCw5Btose1WR2K2VEpAYDGGZWzYPavZ6CIL/BGIHziccXNBOIoH3/ab7jHaJEeTF
	 AiLwUNNlK7nw5Shs894Vqw4Rg9Ovby8IJZiitA69IxbWZYWxyoM55LimHSwE2numqVnEl
	 CzaEgj+DFjM4xo4Izpae0Y5tXTzLE+TxsUXTGDnncp+0CRK7zplLYYRfzljqSf7fx2lBh
	 HOziAOxAz+HLv/1EWwYdRPzbfl49le4O4yfQLKxrlbVlp2epnGQpnPHjn6P4cLt6hdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GMxN5KAMb5liuMLzGoApFS7A/XMBgfd4eRZi5r3s3Fo=;
	b=h7FFz0vsg07hKmJTXQu3DhiQOqim/XAHck/DlKRPXLF/gDzEIbQRWi/UZ3EhOQUS4Rmt
	 xaH7iO8FqsE1n7RR9E5pafxW+SeLnXDiIBNibsFrhWWUzGLFF3Hl4e4Y3eFgAC5NlsWxi
	 cVM8iKNcol3arKljDFef6bRLfalEp4H8hoEdjDM7oqLL8vjZmyYa2lGmHZHRQPKh3dfwo
	 ++7W7TCip1Mw0/QkVMCbRh3/pqsClqw2Xpl+L5R3mnL7aCKn8/b5o1IVU3IY0qOzbOUms
	 4hkabppkDzyQBjyKMcLsE5mTcaE47xrWw1/wSAduBsk27kAqJkopJdERiwPlu5P3qAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DQfgo8Lp;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34F606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 23:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E34F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DQfgo8Lp
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso15152a12.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 15:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793920519; x=1794525319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMxN5KAMb5liuMLzGoApFS7A/XMBgfd4eRZi5r3s3Fo=;
        b=DQfgo8LpjtJ0DmzZazlGJfEkeSYgx5z6dIYiQC2tKD2mCrzoaANa9OCoP7oBoIh3iT
         P9xXkWdxoHYBEd6HaFnF/00b24qhoOl+SsqEI6OCLvaLlroy7LnZ6GwelTmQgqi9oQ8i
         Oa4slV6xDUuVv9Sr5WSjhhK4HE7aRNV7N+p8Hg7CTSBpv8O8SARlx6jUfj94J/sQaShL
         rdmOEPZFfUl5mTzzfSugqm9V90vCtG+3VAv2HVgIwxyw0TTFvKtjlKm/3tjTzfQqj4vr
         UXjOKpNjyEYPux0ob2mGr1OljwVNL7rg9BH8seXbIxtdMaFs1Cp9iqUMJaRMhy1nD0T/
         Z2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920519; x=1794525319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMxN5KAMb5liuMLzGoApFS7A/XMBgfd4eRZi5r3s3Fo=;
        b=pyIe/IQ8OfxgA+T4BujTRYaH93f0kPC9hbkKUxdJs6QxKaAyo1xJg+85LBKKrIjsQf
         nD7VIthuMpJpx56L6+Ox5Xe7jmOqPKuGQdMPd4WJJl2EiMfS3gTKCbaqGbluzGQRtQl0
         UqZi+2OGyZQ42Tg1I5GNnBS+vGVsVZ3dxV1PK5mtcprJ9u+Z00AH8zp21ZdyTthAZ2+y
         JqXUMazVY7RQ+7N07mijJz2zNgdLeM2Mxi/lk5zKUe8YQKa6NOZwOdGONuzVwdJprfHO
         RnQHiSJV0Y4Ua9Ald2CQOn1l6/p9PVXMAs8B0rXHDOpWMag1sQjAv9lYVKZL97MA+mGK
         w6Yw==
X-Gm-Message-State: APuU4Z/ybZnWxAoXI7Cb4SizJ9d6u3vf2xKQAeJIf/L6+8AbzdhTaIhZ
	00RS15sdBKey1Nut/SNX/IkpdmEmpWNHufEfhajxNJCvIi7LnrKsU3JO0GJ9ug==
X-Gm-Gg: AYBFou28EHQ3lL3dueMK02h59hH47kwh+ZOuyCiYWLoh+ewfBZBwE2/is4wGKhJPCcN
	mZptfj+mFh1E7EKeQwPD1Lz50JivNjrT/yweV5qkS7t/G4VILvSi0ZgewjVsQatEXyvNrilYx/w
	ZdB7JLsbx9ooViUrDB9EmR5m18LOMpMaTPtrOKgxeL1SkALVoizBGG1rtBGGkSrWGXm0eECBKDB
	4o6OOZVVWUiqruqeY+XIHg/GFjzm57R/f/TSQGaVQ7W+IK5nylpDrJDgw2cqb3/GXVL708uf9TF
	4n5RFKM8D5LCJ95fvfs2K5qyMqdA/q/QybOuJWkjIJx/kuytNM2n6PI5bWWx6svXLaPM8QpS7lL
	Z7IWv59GLX0bhkF9fvL1gkC5ebzhCs1uZIY+QoKoDrhUIBgNSjrDRTSjhH+SPW11G1hbJ91SR7/
	zP4nNVhmxWVuGPaiVx1MpKOA20Nxi/WaITyfZZdWERS9Z6hEpnMLN5MR+HFUHZey6aIPjXmit3I
	P3Swf9qnR48/wnPsVyQZukp6NIZYeJaQe9R6Wvo26QSv5q0+Qx5N8Lko9M18PiXfKD6MRmeCThQ
	ODk0el2ijhDZz7IdXjkre2V3TSTk8dRBhWNYkWgRvICfCNFxf+JInnVqjZb37VmZqlpZZ2Nzm65
	/1SS7N41EdpiCgUUKENd/V1GZ7tOocm+Kj1jzXyWzD492qaE9Wd7R7KT/0Rr5hyc88CqAMGd21e
	bFsjQ=
X-Received: by 2002:a17:90b:254e:b0:3ad:d29c:5e64 with SMTP id 98e67ed59e1d1-3b0db701624mr483657a91.65.1793920518697;
        Thu, 05 Nov 2026 15:15:18 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c8ff96sm851345a91.13.2026.11.05.15.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:15:18 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Jeff Garzik <jeff@garzik.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ibm: emac: fix TX skb double free in emac_full_tx_reset()
Date: Thu,  5 Nov 2026 15:15:16 -0800
Message-ID: <20261105231516.120321-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

emac_full_tx_reset() cleans the TX ring without the TX lock.
emac_netif_stop() only keeps MAL NAPI from polling RX for this EMAC,
mal_poll() still calls emac_poll_tx() for it. A descriptor cleaned by
emac_clean_tx_ring() has MAL_TX_CTRL_READY clear and looks completed,
so emac_poll_tx() can free the same skb a second time and both race on
tx_cnt and ack_slot.

On a Cisco Meraki MX60, each MTU change to or from a jumbo MTU does a full
TX reset. Toggling the MTU while forwarding traffic corrupted skbs within
minutes (list_del corruption in GRO). With the ring cleaned under the TX
lock it survived 10 minutes of the same test.

Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index b676b286e339..75e51ace16f7 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -745,8 +745,15 @@ static void emac_full_tx_reset(struct emac_instance *dev)
 
 	emac_tx_disable(dev);
 	mal_disable_tx_channel(dev->mal, dev->mal_tx_chan);
+
+	/* MAL NAPI runs emac_poll_tx() even while polling of this EMAC is
+	 * disabled. A cleaned descriptor reads as completed, so clean the
+	 * ring under the TX lock or emac_poll_tx() frees the skbs again.
+	 */
+	netif_tx_lock_bh(dev->ndev);
 	emac_clean_tx_ring(dev);
 	dev->tx_cnt = dev->tx_slot = dev->ack_slot = 0;
+	netif_tx_unlock_bh(dev->ndev);
 
 	emac_configure(dev);
 
-- 
2.56.0

