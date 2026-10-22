Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693727;
	b=de4bG0s2AMVKViUQg4btpeGMHVmx4TueOs04y04AilK9joam419aoq0XgqGiggnl1vxF
	 pRtS7Jm1Fb/uLc9lSrG3ZuJ0rSQkOl2QjcWTA4RLob5WG/K3Uq5uJ6M2xrBvyXJvXeNZJ
	 59UMQ/x6ymAlgomnoXHCoPUapAgA+rIDvTlfKDkvHzcf87mK0LpJbqx0A+xezTjdKKNhA
	 1rWJcRK2gY3/l+imMZa4HBuhj5QNHXGZkajNYekZkDVOv8HBnLKOrPJ5ki4NhhO957wym
	 Y8F1ystDiJ9/qxjQMNS+Hyxwh12LnA0sqrXF5mNr8+4ifLImPkODhehL/VUuZXLkdkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8G9f2sj7l3e7G5lnQu4Rk/LClqYHjpBN2zxkfvmpRHA=;
	b=KcpEeI1Yu5XBONhu5zEaa3ldOmKScxngBB7KRGERBR4saHKIeEqq2imIdjcgyXHuebzx
	 xWeltY4SAFs4AqYo36moBFNiiziIygNIENmLmQ4IJzk/e9jghmw65VpNmYxoENRQ68Gvq
	 Lke6DbrFTBELgLGKqp3PFa+V5tYyyQwFYMy+I7Rlu0F1O9h0wbRQAR/W4ttMXyUE6SNEz
	 QjztfhdUkzUoxQSJgTSC2wSuS6/PSqtzFHJxotjY6Jd2rKxyu1lYK5UOXLV53vBWvM99I
	 FRMF3yTTL+d1LQfpdTcLTTjwh48XZ8jVnlUGxGlogePbrTxHNejJ1OemTFGt8ViNOFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l92fzV10;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546E606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8546E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l92fzV10
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3ada2f39f30so31626a91.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792693726; x=1793298526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8G9f2sj7l3e7G5lnQu4Rk/LClqYHjpBN2zxkfvmpRHA=;
        b=l92fzV10KlIkb0cr7Ubm74f9+Kq4xHT9XI5iy3Y3+jmKil+EUWHxjrstd9x+6/r587
         QIXkkGMxZgi9vD3oTXgT3fq27Op+NlD6zspidLjmK5RR/r23seKPba5jvTzHFrLC50SM
         1cs5RAnzK5LYj3idkPr+ZtEgEfYhtUP/h4POsvtSYtfIAi37mZjvy8hB2N6smSuWZnI1
         O91VMeruxHSBJNZi+AU75lm6j612fdTR/9PgF+ral/TjdT2IYnZnVaSZKPgkM07c/2Hc
         MfYL9//j5CfVqXWQdJPJauXdg4mI0zV4UUrMBy1yI8QX/XCr3Z3RrHJIxrm3Jl4WinaL
         8kzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693726; x=1793298526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8G9f2sj7l3e7G5lnQu4Rk/LClqYHjpBN2zxkfvmpRHA=;
        b=Cq8yCUUQ/BCFaZhCHewVMWQovlRXYSuNb2ecxCZBY6gJbqw4aBkx5z+LsDBsynqYW9
         rK3yLwGnWsJ6o8agmexLC75li0ElBTkyrH5n2c5m2FfPv/h5huaJsKCG6QT3L0FWuyfk
         TusB9EPDxXCrA9DyeXTOqAraoVze4sBGnt3AToyuFaBKrNwG1PIa9MHl8wos3HYwsri6
         mYWMKD6oKjG25IonTAhXicDX5E6nxyhOdTyllXryCWxngBkN9gneehCjyaFRBA2Tp7yg
         0LUOsQ6X6A0X4Z1E86oAwPu3VsED93DeXvpIKElxuv+Wrw0cK0E4PWKO3zxhzxv5K01m
         5d/A==
X-Forwarded-Encrypted: i=1; AKwUvBzeNzO0eW/WBSKm0/gK3RfrS+b4+OCjvWL7ZB7xN+sflfSZBROwDNSD6l3wjLZBJ0OCHGWzLJ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcziWm/Wj/wYfNL2yUKJ2CXCt6iRKX8slcIO421Cfr3k9Znt3e
	CukacoXWn+1Krz4oWTrurlY9Y7v+cz4Eo0NJOYVqzlrXHictLvL2xqWV
X-Gm-Gg: AYBFou3BglAk7McROaVP9ktZkPfdK6SBnArlcMWf9AFWG0UgtjN7Oe7s5qPwLTDkBAa
	dE0ZiSD2fOEzhwvmJ5E99tDwuuLNm0R002pEEijyPLrhex5jArSgv8h5jJk9u5BXMeeH6iAgPyw
	fSUddRto3sfgBmEIgoVucg5jg2zAxC/mDgh8feKKilAt5HStcvxfrRaGu2Pund5kkBo7CTbbOWp
	3sc8OqMWCM7tJD4LrYhdESV0cfzhWfxzMKDgR4/id87aFrfkcdyD+szhvnbVqgAbUTt9FJPGyGI
	RmauIQT8kfnFrTd+srHymLrD5jKCUdVe2TV3NegMsmBfnIQl64og+TMVOJ68NsemcRoWckT5UQ8
	PAqLV+2uFPDrPmxrgJIh6aPykrB+MnSR0Jar2fFgv6jcDN0kPr7q/F3NRe1X97gPLgANnv2ooqW
	4NeYXIIALTpKhFP/CZoh4B5bX8ipz0wfFkVDeh0JLlxsoHaWsiP2/Jr+/99a38v3PLPhumTxH88
	0PLA8EZ/cyRM8+oDKsW/JUgtAlmy4JPhk8sdOIDPShfwcAXQ2Xw9dW1t+9kLutEvT7lqZziL5J0
	46wCqbAM5tA5QGOWj7wBJeAuwMlYjl8l5DcLlLEYapFSC41HbIZ/iwIzgMWX7xXmHzbGzopTdH4
	D/ex9/xgP88ihfXe1QaDw1rC/2FIR/pzBcEo7I+0Mx4nJehIgPr7/EK/3DA==
X-Received: by 2002:a17:90b:164c:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3ad86cc64d2mr5437501a91.60.1792693725903;
        Thu, 22 Oct 2026 11:28:45 -0700 (PDT)
Received: from wang0.shina-lab.internal ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490d4bfsm6115262a91.10.2026.10.22.11.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:28:45 -0700 (PDT)
From: Lianjie Wang <karin0.zst@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <karin0.zst@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] virtio_net: reject stats replies for queues outside the request
Date: Fri, 23 Oct 2026 03:26:58 +0900
Message-ID: <20261022182710.2055771-1-karin0.zst@gmail.com>
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

__virtnet_get_hw_stats() passes the vq_index of each record in the
device's statistics reply to virtnet_fill_stats() without checking it,
so the device decides where the driver writes the counters.

For ethtool -S, virtnet_fill_stats() uses vq_index as an offset into the
output array, which the ethtool core sized for curr_queue_pairs. A
record with the vq_index of a higher queue makes the driver write past
the end of the array.

For the per-queue netlink stats, the queue type also comes from
vq_index. A receive record in reply to a request for a transmit queue
makes the driver fill the struct netdev_queue_stats_tx on the stack as
if it were a struct netdev_queue_stats_rx. If the device offers
VIRTIO_NET_STATS_TYPE_RX_SPEED, this writes one counter to the eight
bytes after the tx struct.

Fix this by rejecting the reply when the vq_index of a record lies
outside the range of queues the request asked about.

Claude Opus 5.5 was used to review the driver code and draft this patch.
To reproduce, the virtio-net device in QEMU was modified to answer an
ethtool -S request on a one-pair device with a record for a receive
queue the device does not have. On an unmodified kernel, KASAN then
reports a write past the ethtool -S output array. With this patch, the
driver rejects the same reply with "Failed to get hw stats.", a
well-formed reply fills the statistics as before, and the
drivers/net/stats.py selftest passes.

Fixes: 941168f8b40e ("virtio_net: support device stats")
Fixes: d888f04c09bb ("virtio-net: support queue stat")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <karin0.zst@gmail.com>
---
 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index daab43ac92ce4..0473fa9947858 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4955,7 +4955,8 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 				  struct virtnet_stats_ctx *ctx,
 				  struct virtio_net_ctrl_queue_stats *req,
-				  int req_size, void *reply, int res_size)
+				  int req_size, void *reply, int res_size,
+				  int first_vq, int last_vq, bool enable_cvq)
 {
 	struct virtio_net_stats_reply_hdr *hdr;
 	struct scatterlist sgs_in, sgs_out;
@@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
 		qid = le16_to_cpu(hdr->vq_index);
+		if ((qid < first_vq || qid > last_vq) &&
+		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
+			return -EINVAL;
+
 		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
 
@@ -5055,7 +5060,8 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (enable_cvq)
 		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
 
-	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
+	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size,
+				    first_vq, last_vq, enable_cvq);
 
 	kfree(req);
 	kfree(reply);

base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.56.0

