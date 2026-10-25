Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792912952;
	b=v8dC95bvDn8CRxUAYctr4GOIEGnKVFx8ORwwbCqXMww0Q5R1OhPGaeUxFx4owsornjAb
	 QkeT9YrcF+OdN2w8oIN+y+/9E9eLq3431HJlOpr1BppyRbgPdYlXjNUTM7kdVOWSxCILy
	 hSnsiqQvznLJH8Oq3d6IPXIfo+dvOAIGyObZvJfYXW6kmI0l9NxB/QnK3fvpRrK5e+1SL
	 G1HcbXelMKKeXbxysLHOHI4+DHu2unj5jHDaZCanpnxCATjmRfKMEBDshsDVzkSWcD3JA
	 1oyu4l6gfPVyXfQgvtiRSO36Oxhk2UNrkrDs9I6VN5bUnG0GbEyxYMnEYpHs4YdjOzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792912952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/GcpDOIHzeZZHHnDHnE8tFmy0iBveN0FRIH1VtyXChM=;
	b=coG7AQk4bN4C2WKeDl2yxFj+VL7S8tj1744Y68L/k2+Ci4rvbddhZIoSB3oilICtF6S0
	 0LM5IBJhpyux/n8wT1MtT0MiWJrxNVt+ZWHW4rbobDFbMmR1S3oJHo9IZwBNPkkgMiV4G
	 y3vKXwjv7Qu1VP73o3BVNY0K3xbqGelu0eF6bd2QHO0YpCwAt3rFGlwKHTSZqCSJ1fDc+
	 tYvxe/8mpRZ7IZV5UCoTSdhLpyCg9Stn+u+LEnOZLue6DPphiWi375ZQeQ8uTnePko8FY
	 Fy0t6nDwVDSEPIRhuUYgPNfccRBE2LomLVKs+NPedvQludqVs8TUlr7jnK1si34oBow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="I/Ef2Atf";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6638F606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 07:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6638F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I/Ef2Atf
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35f036b17easo5154827eec.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792912951; x=1793517751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/GcpDOIHzeZZHHnDHnE8tFmy0iBveN0FRIH1VtyXChM=;
        b=I/Ef2AtfGeMluXC7NTZ+RuqYBNmgd3N4TLprBbVmpnXS4YEivT/OnxgyDoABtA0idd
         PB5EjL6+hzFMHPOTK3xlzOer4n8Umrc9czxgGHTASL5oV/UFbduAjKx+hahx6lXO/whj
         V20JnkwWZG6POBM2VT+IByM4TFYyzI7LQaaUNsvJACSTcDlDAbxG36EuO16NbbV9EfdD
         BgtTJTtl9R4fOJyrIv9Mj4SzATnJR5JdwhZWWak5DJuRO6dYq2kihliflhYmrUfv5T96
         VoGVuBN03e0oErK4aRuBYH+f+Rjh4RoR88Yr7gzebKakIh1TbKbD+OHxkGHALC98ROST
         /drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792912951; x=1793517751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/GcpDOIHzeZZHHnDHnE8tFmy0iBveN0FRIH1VtyXChM=;
        b=EJwmImGc9UpQdO0YwaKU1y5QVlV0IRu8+g4u0VKYWatIVupnfFt2/DxDTy/l1s1YOd
         lwmjRGxnn4F6PGocbtM2Mup2OjOtHvaXgzQULbxxhGl0mFg4snmmFJawGHvr1NLYR7vS
         pCpoH5smH4ll3uvcfxanaSf898K30DTFqymfVKHYJuVt+lO0tjYctPTMIFtmUoAw1AKk
         vuNxt2t6ZyqUqF5nu/cYkzLp+pvGaeLguT/ANrwNQTsSh9ZDyOmoIc3pFVMC7QayGt2M
         lmFGvuc73YoHalRo/ffK2+WVrW8gNCUnxACs0vYHpkRo4N/fcLSN/65sszwZuNpZYE5S
         GY/g==
X-Gm-Message-State: AFq9FYJrxJbhsMlNWow1XiqxUWzMagDEEylAqMl8EjSa0SqfhR2YyucX
	FFsQn1TS70JiqraEjlFlbyEDwKZUGgh6TuJViLPuvHZUCEMnWRU5xabdMBN0q0NR6zk=
X-Gm-Gg: AYBFou28jezO6L78mfDy71OWdSxej4PDlbGvYbO/+Iawxvg6rDwug5pPZDDa8gkhmJP
	isd9t9mxjqzEgmTmfpxAEY2/QO4mUSgiJgxuK/jX0JaphTOPO8N5t0BVVmu72e2zqXGPJn3tCUq
	aIuOWjizh5NO3hsQG/TgBWwd9lHohXPwTTXxMbE5iOgwKmhWHijpI1ZPivAh21GLWIDd4Ox9qjy
	17JvT+Gs1q9hS9SszE1p+SipOLbbFE3qwCThbw3GD5uxcpyxl+lXCp7s2tpwpW+2omMRpIBYokT
	tWNRYgblcCdWnFmNY7PQu+luc8y5j+lMuthqgv3NibGz5u4QvkQWTH41aHwfcBlCSScNtv0pwNX
	pEGFirOB93n98aivivIYzVWzfSl1Uol8fgZtmAEpK/rvOLTNz3W3+cTtmzmRc+wV0wFJMEUGI1/
	YekfCa4QiTwv1IQIflcPXrPGfqt/lU883yfYR/KCtEWYtG1C8erFSCpg7AdKvmrtEJLbKGHJZAK
	hga4TQEYmtH6rDt2wdZqIt8WVCw0WIbM2jfSrm1WGKbakl3Ca/3JFB+VWnmXyvL3wMODXkqsWzd
X-Received: by 2002:a05:7301:6182:20b0:366:c0a2:642f with SMTP id 5a478bee46e88-369e84ddf59mr5292495eec.22.1792912951407;
        Sun, 25 Oct 2026 00:22:31 -0700 (PDT)
Received: from ZephyrLabServer.internal ([165.162.64.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec4d73sm18682269eec.22.2026.10.25.00.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 00:22:30 -0700 (PDT)
From: John Macias <dencity7@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: clear the conduit RX queue on user port receive
Date: Sun, 25 Oct 2026 00:22:03 -0700
Message-ID: <20261025072203.1519561-1-dencity7@gmail.com>
X-Mailer: git-send-email 2.47.3
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

A multi-queue conduit records its RX queue in skb->queue_mapping with
skb_record_rx_queue(), as stmmac, mtk_eth_soc, fec and dpaa2 do.
dsa_switch_rcv() passes the skb to the user port with that value
unchanged, but user ports have a single RX queue. For a packet that
arrived on conduit queue 1 or above, get_rps_cpu() finds the index past
the user port's real_num_rx_queues and returns without steering. The
WARN_ONCE() there stays silent because the port has only one queue. As
a result, rps_cpus on a user port takes effect only for packets that
arrived on conduit queue 0.

Clear the queue mapping when the skb is handed to the user port. TX
queue selection is unaffected: the user port's own netdev_pick_tx() sets
queue_mapping again before the conduit transmits.

Found on an IPQ8074 board (OpenWrt, Linux 6.18, conduit with four RX
rings): with rps_cpus set on the LAN and WAN user ports,
/proc/net/softnet_stat showed no RPS for traffic hashed to conduit
rings 1-3. With this change, that traffic is steered to the configured
CPUs.

Fixes: 91da11f870f0 ("net: Distributed Switch Architecture protocol support")
Assisted-by: LLM
Signed-off-by: John Macias <dencity7@gmail.com>
---
The Fixes tag points at the commit that added the DSA receive path. The
problem shows up once RPS is used on a user port, since get_rps_cpu()
checks the recorded queue against the port's own queue count.

This was found and fixed with an AI coding assistant (Claude, from
Anthropic). It traced the missing RPS to the stale queue_mapping, wrote
the change and this changelog, and ran the tests on my hardware. I have
reviewed the change.

Testing: the same change on OpenWrt's Linux 6.18 on a Netgear RAX120 v1
(IPQ8074, out-of-tree qca_edma conduit with four RX rings, RSS over all
four). Before, received_rps stayed at 0 on every CPU over 8 runs of
bidirectional UDP with rps_cpus set on lan1 and wan. After, it rises on
the configured CPUs for traffic from rings 1-3. On this tree (net,
7076f684d) the change is build-tested only (x86_64 defconfig with
NET_DSA, W=1, WERROR). I have not tested it with a mainline conduit
driver.

 net/dsa/tag.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/dsa/tag.c b/net/dsa/tag.c
index 6a5aa7fc3..ecd4d8669 100644
--- a/net/dsa/tag.c
+++ b/net/dsa/tag.c
@@ -115,6 +115,12 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb = nskb;
 	}
 
+	/* The conduit's RX queue index means nothing on the user port, which
+	 * has a single RX queue, and get_rps_cpu() skips RPS when the index
+	 * is out of range.
+	 */
+	skb_set_queue_mapping(skb, 0);
+
 	dev_sw_netstats_rx_add(skb->dev, skb->len + ETH_HLEN);
 
 	if (dsa_skb_defer_rx_timestamp(p, skb))
-- 
2.47.3

