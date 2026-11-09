Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221597;
	b=JM71cgl8QQfzdBzeFxi2fqujwghuckHW7HnBoFHtPvoCqNDWAtoa2sJvt5bT4S0PyQGW
	 jQI360QE/dZqgh3p8fIqzzmbqZ+QUGY8q4g3J/Pn3PvVMehbhMLw95FdpywHGQjL5CtXQ
	 H9pvlC7YEEUnki/rofdqLZgaj/ZSPf8zkNZn2y22LD2VQLFAj146wGsRlJdOvPgd02EPG
	 EiWOKcaWR2y1J24KXNv641OX4bS95iGB2yw0IL38o3j/BW5mJmro8fS1+nJ9fYfTglpRq
	 QGEpssftkiTu9LacYt6SAOsH3OE/SKml4q9kE25anpA5UYyf69qKUqQy3HEp/KoG53Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yRJunyFxJTxNbMZ/8F4LlLR5Z3XEUtdXwi3weUw7flA=;
	b=v/j+DQK/cDaAL6j/zqs+0Y2oY6YYJWB/6yjwhJuus2dw3zTA33ipYJ9Gy1gzhSkhj7T4
	 DWaKjUCLuIgv0OrTHiywlQruMBNiLDBrbXbW2LqdIboMl4xOYVjnKLPADn6lVbSdZyIyC
	 2sKwST8c7wAFPCYw7DA/T10dhXEqFL+NafbPDSG5rhcZyxEksQUVvpVbeoSDfNHvf+N+X
	 iLuF+Q+TgDHf0l7jWjmeRpu1QZADLiBgieHai59bnzTwmSE3ogAA1E+Is72uF+sDs1G4V
	 VIcfDSGRTFYLP2egwNNDRGigR0GmMYV+CJ1lKhH2iYZDn+ozrPed1S9MkAlyZdRc2tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b="WbYUcye/";
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14954606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 10:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14954606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=WbYUcye/
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15ea896ddc8so1347222c88.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221586; x=1794826386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yRJunyFxJTxNbMZ/8F4LlLR5Z3XEUtdXwi3weUw7flA=;
        b=WbYUcye/Wh3eUMwCeeB4zvCzv5J0SJTJ55IKpmHb6ll0m6Af03Q5QwAVIjMy/uOg9L
         vpqPrOeXXV5jdlOgEZuWTy7M0BjTKh3qmeuI72hr3S3wf+EZi7WirUd0KhQL7Uxv44O5
         O5UlLGn36bket41zt9POfOI1J8kaFMG4J1gxSvR/z6dMo/baR0Z42MDVqZoEiwb1JzW7
         tJTcjyuIRU8OOh/Bby3eLsvEkJwWfAb7R4oUuMfh75Cv2QqI8wCcDCCQmB5OlAuPNZ1h
         ClK1FM8uY6BJDJvHj5TFG9jjM/r5nBvLl5r63vk/dJImAQe7x2/Aj98FRE5z8RwzG6UM
         k3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221586; x=1794826386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yRJunyFxJTxNbMZ/8F4LlLR5Z3XEUtdXwi3weUw7flA=;
        b=SrGJiIvbKZ07BNHAf/MtHownEPWJSZ59tAhElfNE4oOrS+/iokNXNKa5zl4NbhaxdF
         IKlHzrzX24bXBWIrS+RI2i2mkXG4jZ/5AfWHwFqLl+8BVxDi6ZvBecu2HfCWEmrtK7w9
         VC9uJ4IOph4bFZYtdd1PMH1UBi6dfuuUIlRJyKHv4yRfvh/ORm/XXEWq29KNkEXr1Exn
         v1Vr4mV+JYD/0BgG49JNYLhPU2QyOa+LHVRuhrL7kUQo93bZOPethi7duudfqmNJ/oLq
         69TW61IIxdpuDBsBmh91nrptdfHxXcSV59lIrNR0Y/lozoCMUs7HNVJVaqIAvERpVaXP
         UBew==
X-Forwarded-Encrypted: i=1; AL+hErEjI6SUL+GRnpxtIuQWkOyPKyST8b0flyFbF2agD9tSm4lAVXHEFJmsLGntbyyRJBSZ9QJQbfs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9b0RGJLem49zZaRxt2gvXEWGS3j32jyPv/qTSJ/5dQAVvCdTWe
	Ws8vg0r0xwUQr/GQ1wd7nxLN9ll6zNXpZm5SVMJo/hsgabiFps3hmTocaDjuo+oGmA==
X-Gm-Gg: AYBFou1oDNxXh8COL03+vXjQDMW7380t7eN2vCfNAG1zHaLuIeo18XCJ+Iuc8Y5OVhV
	YiGgfOTvslRc5fXkLfZS9wmP1oTiwLIuHt1gAQw5REiRtnNWYV8CzDG4zmOIcUMX764tI4a4eSn
	EPhLsYKTurpij+yk7O+G4iNnINZhlKaGac9LYR5VwbTAuoYcbkRTu063hcMIzaDWMkgtkFF7S8E
	rtiExwqPIqhvORHVQmJg/aGbKhIIKg0CmaRCEdjWa6OKfkvXmc+N1oqMHymaUQtHEiVO3RQLOA3
	jEcY8C4VIoK3yfHQAd/h2jSs/FFvKaukvOkpCNv0ywEuSqLdmyvJlvwtQDNPkhdFsjQb39uQNhc
	5mcjZyFzNFZYiV2l5YqC6YwJqYa3McWFwXiXYX7pFGJ8U5Q8X/m4V7AMBhF2krZb4WeIdPkvpc0
	k/+i3KDRbHsmoq9BAmAyI8wTOKVdMRp8GbNQkZJW6AcTJtjb9/mmhBaigvzJE1i3NgutfJOUCM7
	1uKrP28GYBPBIkEGwOZFBEN4acNxkDWtqqM2HD75l6QVx8AALbAbtpuBHg+NJ/8+aM+cb73Ypt6
	MgWEjTpafyCAiA1QpoqNVi/W0G9nwTyv2kebZw==
X-Received: by 2002:a05:701b:2705:b0:189:d6bf:7ec7 with SMTP id a92af1059eb24-1b39fe946b5mr6255466c88.19.1794221586094;
        Mon, 09 Nov 2026 02:53:06 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:53:05 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	Chirantan Ekbote <chirantan@chromium.org>,
	Greg Kurz <groug@kaod.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] 9p/virtio: keep a request until the device returns it
Date: Mon,  9 Nov 2026 19:52:49 +0900
Message-ID: <20261109105251.2545764-4-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
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

When the RFLUSH of a pending request arrives, p9_virtio_cancelled()
drops the virtio transport's reference to it. However,
p9_virtio_zc_request() has already dropped that reference if a fatal
signal ended its wait for room in the ring, since the request then never
reached the device. Such a request is still flushed, so the reference is
dropped twice. This can happen when concurrent requests fill the ring
and a waiting process is killed:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:37 at refcount_warn_saturate+0x84/0xd0, CPU#3: dd/293
  Call Trace:
   p9_req_put+0xe5/0x190
   p9_client_zc_rpc+0x52e/0x970
   p9_client_read_once+0x237/0x6c0
   p9_client_read+0x9d/0x140

Additionally, a misbehaving device can return the request after the
RFLUSH, so req_done() writes into the freed request:

  BUG: KASAN: slab-use-after-free in req_done+0x1d9/0x280
  Write of size 4 at addr ffff88800392d758 by task swapper/1/0
  Call Trace:
   req_done+0x1d9/0x280
   vring_interrupt+0x32a/0x540
  The buggy address belongs to the object at ffff88800392d708
   which belongs to the cache p9_req_t of size 136
  The buggy address is located 80 bytes inside of
   freed 136-byte region [ffff88800392d708, ffff88800392d790)

Fix this by dropping the reference in req_done() for a buffer without a
reply as well, since the device can return a flushed request without
one. p9_virtio_cancelled() is no longer needed.

This patch is assisted by Claude Opus 5.5.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/trans_virtio.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 53046668c16b1..68c3457bec401 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -145,6 +145,9 @@ static void req_done(struct virtqueue *vq)
 		if (len) {
 			req->rc.size = len;
 			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
+		} else {
+			/* No reply, so put the ref that p9_client_cb() puts */
+			p9_req_put(chan->client, req);
 		}
 	}
 	spin_unlock_irqrestore(&chan->lock, flags);
@@ -195,13 +198,6 @@ static int p9_virtio_cancel(struct p9_client *client, struct p9_req_t *req)
 	return 1;
 }
 
-/* Reply won't come, so drop req ref */
-static int p9_virtio_cancelled(struct p9_client *client, struct p9_req_t *req)
-{
-	p9_req_put(client, req);
-	return 0;
-}
-
 /**
  * pack_sg_list_p - Just like pack_sg_list. Instead of taking a buffer,
  * this takes a list of pages.
@@ -806,7 +802,6 @@ static struct p9_trans_module p9_virtio_trans = {
 	.request = p9_virtio_request,
 	.zc_request = p9_virtio_zc_request,
 	.cancel = p9_virtio_cancel,
-	.cancelled = p9_virtio_cancelled,
 	/*
 	 * We leave one entry for input and one entry for response
 	 * headers. We also skip one more entry to accommodate, address
-- 
2.56.0

