Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217439;
	b=0dmUsArLw72C0p/ek3FvyQY2GGfSTzp5RsnWvqKOvVcqYPeusVEdybr8dj3Q+OZfuQPV
	 mjpC1NdJ/uxkk8asFz1eWbDB/XhAcHD0NBnEdsVCcuueqB7Il1cnCzXXR/pkq9pLJGn7k
	 N8xNIQR8DnwU8n3ft7bHGI//oZf/O3rBToYkZOE9GjiA6GFNmZhYYbFQpKrexuM9Iy9n1
	 lV6vRNBLLbmQaDE4LljzTE59mdBzOCpo3TD2oIq6JlWaJ8UptvG6QQMpbGhIBAZLLE+R1
	 pOKljaOnOIQvKvBWbeDKBUfR7/qyFO+cjkAtrf4hNXq245U/u2CwqNEo/DrOCdw6J+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217439;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=/uZsH17bYEh5dbv52qPr8YKax8++4Unn6PCBM2yJmTk=;
	b=zyxmJ9q54xdNZyvHqoKV7Wm39IaHC88rvZ4wbBExnOx2//Y8XD0r91YXhzmY711jLrG4
	 5IhTlbOMlPrvYU2E5/HntXY7VZiCvOalLXW2zsSi0OoZNrAct/jlIgvEhk5/IMoocjpsy
	 8NBrvl6DUA2fzuEzZovA8epIfw+63aHkbvwdxOhEnZma3UZMyeZHiSv3MgDXVtXFLl8rG
	 ppGR+CXylz8Wk1Qo18xHMIwpzJTnqtxPZRkqk4T//hVktwoDWN6J6NmJoFgSDIxHq4Tk5
	 +qA1ob3jAx0CWwfrrepP1vln1zv7ehujn1pTzp/+lxOurgAkLlhS00h15XxGUCGR1bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=M2MmqxUk;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE10606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 09:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE10606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=M2MmqxUk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/u
	ZsH17bYEh5dbv52qPr8YKax8++4Unn6PCBM2yJmTk=; b=M2MmqxUksP32Up3ASA
	+Arbe3MsTy2RE4ok/WAIvbSe/YolFtb50QFRSZfQIwZUJKz5L9I5BqdkFd2R7+/A
	1NVCweYg2+/nYL7iGbrEdJnsXzvSA5Nze4sHNiRY0p/Siqxox9PYvIeIjXJtMaxa
	YBGKyfHUigi9tIqYhgqMWe5Gk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHJCGvlfFq58sxGQ--.4049S5;
	Mon, 09 Nov 2026 17:43:14 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org,
	eperezma@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [PATCH 3/3] virtio_net: add rx_timeouts per-queue statistic
Date: Mon,  9 Nov 2026 17:43:10 +0800
Message-Id: <20261109094310.103979-4-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109094310.103979-1-lange_tang@163.com>
References: <20261109094310.103979-1-lange_tang@163.com>
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
X-CM-TRANSID:_____wBHJCGvlfFq58sxGQ--.4049S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4fXryDKFW8Xw1xCryfJFb_yoW8Aryfpr
	45A342yFyrXw48XFWfGrWUZ345Jwn3AFW7Gryag34ruFn8GrnYyr109FWjkF17CFZ8ArWj
	vanYv398J3yj9FUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVoGPUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-hKo1mrxlbJWQgAA36

From: Longjun Tang <tanglongjun@kylinos.cn>

Add an rx_timeouts field to the per-queue RX statistics and expose it
via ethtool. Whenever an RX queue gets stuck, the NAPI poll increments
rx_timeouts, so it counts RX queue stuck events.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/net/virtio_net.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ec7c248080c5..feb6bfbb1c5a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -135,6 +135,7 @@ struct virtnet_rq_stats {
 	u64_stats_t xdp_redirects;
 	u64_stats_t xdp_drops;
 	u64_stats_t kicks;
+	u64_stats_t rx_timeouts;
 };
 
 #define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m), -1}
@@ -168,6 +169,7 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 	VIRTNET_RQ_STAT("xdp_redirects", xdp_redirects),
 	VIRTNET_RQ_STAT("xdp_drops",     xdp_drops),
 	VIRTNET_RQ_STAT("kicks",         kicks),
+	VIRTNET_RQ_STAT("rx_timeouts",   rx_timeouts),
 };
 
 static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
@@ -2983,6 +2985,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		u64_stats_add(item, u64_stats_read(src));
 	}
 
+	/* Count a stall recovered by this poll. */
+	if (rq->watchdog.stalled) {
+		u64_stats_inc(&rq->stats.rx_timeouts);
+		rq->watchdog.stalled = false;
+	}
+
 	u64_stats_add(&rq->stats.packets, u64_stats_read(&stats.packets));
 	u64_stats_add(&rq->stats.bytes, u64_stats_read(&stats.bytes));
 	u64_stats_add(&rq->stats.alloc_fail, u64_stats_read(&stats.alloc_fail));
-- 
2.51.0

