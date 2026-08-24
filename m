Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561953783D4
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585023; cv=none; b=Glo33XkXw4ChOpyp3k3jsx3ICNxGLHip05g991PcYGLCV2ggZfLm+1tuBi52IZRPrQmjScS5DohCvR3BW4gjCMjLmOUA+Z+Yf0+JmxgbxwPDy/97g63O/gkWReO9TyRVLTPvAyhyawYflzc+w444r1Cw2t5OZyW3dgzzZYkBe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585023; c=relaxed/simple;
	bh=hYw7cY7OvliXTsXG2DhqQQpoKZ04lNep+PHc/o1u//s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rToGhaYfkoD54/pW/Fq5A+bTTu+/rHak49RxfgrRq2zlIIeLOTzxpgLlX1vEFf3Zh54YFh2Cis54/1SHMc8fz4qODEDnvR4bzdgioUf2AUDsNHSiDWwsi0Zo1vL6GKhSN00QlXCrbIFb6ZPnThQLJkD/3zlYLACMN8Q2VkWG/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8fz4OEx; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8fz4OEx"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-669bcef451aso395702d50.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787585019; x=1788189819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ApOsiVTZO2JtdB21Z6pP35hGptW3NA1WFLKYP2hHn7c=;
        b=e8fz4OExPhrQpoLn3q3MmA6nw/X+OJPmzd7JtS1SI8dGWdAkUGd1MS+XPWoQzbpfPd
         TaKn6cvR2BqqmNO7EsDF2WBZNCciq/QrdMMCjJaDxClAmYdFs1CtB9UeBrPBx6XPuCnk
         +Ray11mrTzbruMD9GLQwtCq5fIJKo7OBitNVYcWhsZkwu3P9jZ8dyPs6QcRyF+rSvboe
         FMF74xxUKlW9LADegKDY6wIzqkuFGxAZm9uyWJYNaSHcHhs2XW/pxF2SwwiwXt2cV8UL
         jIXKOtrNATNqKpq/qvCUOgzcesM1Vwn5SkiZrR9QBGUy0DNieH8YpIk0hKyPs5XAVFPC
         q8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585019; x=1788189819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ApOsiVTZO2JtdB21Z6pP35hGptW3NA1WFLKYP2hHn7c=;
        b=ebBmea/1UHQQ8J8BEukjZOS5Nw0lKVb8ENOygfKTwrvlaPK38HwkFkNGI36TbvHKnd
         vTb85ZghV3uS8dilG0/RYBqyhRKcncXJ/8WOkp5+RNe0dZ+h+QWsPTnplwWB/VJWT000
         CsgiASqV+3GFFW0lCR38SQBBkZeXlKV8f6/qxT0dbrn4WeqTL0yizP5jr9XF3D2guas2
         C9DBMitFbT63ROtNokDnUM5Dui1kqVI7B2L8+ztp/swfwjTcBmhaM7g27ZPmb4ofs0R8
         BvQWN24xFxGLdgZMUqQDxxAOiydIvJFOhEfq/uetkiAIMuq9N7Uv7po+P/N3hAUVF8z0
         rvMg==
X-Gm-Message-State: AFuF++mHyM+8eGSHkBWegvFHdiwqyd3YwI3+J8fHTNUKCBjjy+Gif6nN
	H1itajhLYlGEJ46qRtF1GEftM/tWCxOvk1LvWYnHa0EXzdXJHyKppRM9
X-Gm-Gg: AR+sD13Sp46HW8BGypTOALuPssTl1tWo11vwk4Ww/yY/r8ydW7nWqtT3OGaC+8+3heP
	hGr0WZPBiFpvamM6r/m2CmX6PH2DHcd5EBL1plC6XOMXmVxiOVgXc9gNPSQuxzv/tloq5YTs6cJ
	Sz4HOe++v+NUWZYYJTYBPVef8yd7hh39hJgzjIv7+TUHZVPGRUaYPux4rqMqLksSYj+oXqE7Dzs
	XTxCNac3mzwkb1nqZ4BtwDz+xJoGCfEXZpudioTlRwGKn+W1/5i9uKfgTXkY24KraoZlZs7KFav
	WLt6j5jRgYeVAzgqmiDI3w3n5OVwEH3XUKtzbocqjhEEGq8pdpTNTl0bqMRd0MSUlYeddcRxixo
	scE65uHNBIWWo+Agzi8WagPatrKPWXPLfjfplYoZcpDxVRZF8tSjmZHoaURdVVE51UGYOWa0TDD
	ChAVbt0hfZgFoZW/pNEdypq0gtNHipWWZ9O/PAYmAbi85ohbA3IthD2iEsJJvrTyek7cY2wEU9Y
	WdOMOWBa83U9Dty/GulDucPa8/gOsvQbiSE2A6z20h4yfzhy5/gWnjD2plT
X-Received: by 2002:a05:690e:80d:10b0:66b:2964:eb0a with SMTP id 956f58d0204a3-66ce4ae6f92mr6238565d50.3.1787585019068;
        Mon, 24 Aug 2026 08:23:39 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cfb3671f5sm3062475d50.15.2026.08.24.08.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:23:38 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Qi Zhang <marsy12010123@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Florian Westphal <fw@strlen.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: pktgen: keep device lookup under RCU protection
Date: Mon, 24 Aug 2026 23:23:31 +0800
Message-ID: <20260824152331.216494-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pktgen_find_dev() releases its RCU read-side critical section before
returning pkt_dev. __pktgen_NN_threads() then sets removal_mark through
that unprotected pointer.

The worker can concurrently remove the device and queue it for RCU
freeing:

  CPU 0 (netdevice unregister)     CPU 1 (kpktgend)
  rcu_read_lock()
  find pkt_dev
  rcu_read_unlock()
                                   list_del_rcu(&pkt_dev->list)
                                   kfree_rcu(pkt_dev, rcu)
                                   RCU grace period ends
  pkt_dev->removal_mark = 1

The mutex held by CPU 0 does not cover the worker and does not delay an
RCU grace period, so the final write can access freed memory. KASAN
reported:

  BUG: KASAN: slab-use-after-free in __pktgen_NN_threads+0x241/0x280
  Write of size 4 at addr ffff88810dab804c
  Call Trace:
   __pktgen_NN_threads+0x241/0x280
   pktgen_device_event+0x24e/0x3d0
   unregister_netdevice_many_notify+0xde8/0x1ec0
   rtnl_dellink+0x35d/0xa90
  Allocated by task 92:
   __kasan_kmalloc+0x8f/0xa0
   pktgen_thread_write+0x498/0x14e0
  Freed by task 0:
   __kasan_slab_free+0x43/0x70
   rcu_core+0x50a/0x1850

Move the existing RCU read lock into the sole caller and release it only
after setting removal_mark. The object therefore remains alive through
the dereference, while lookup order and control handling remain
unchanged.

Fixes: 8788370a1d4b ("pktgen: RCU-ify "if_list" to remove lock in next_to_run()")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/core/pktgen.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 7f81aed46672..4fb1853589b3 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2032,14 +2032,17 @@ static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
 	bool exact = (remove == FIND);
 
 	list_for_each_entry(t, &pn->pktgen_threads, th_list) {
+		rcu_read_lock();
 		pkt_dev = pktgen_find_dev(t, ifname, exact);
 		if (pkt_dev) {
 			if (remove) {
 				pkt_dev->removal_mark = 1;
 				t->control |= T_REMDEV;
 			}
-			break;
 		}
+		rcu_read_unlock();
+		if (pkt_dev)
+			break;
 	}
 	return pkt_dev;
 }
@@ -3776,7 +3779,6 @@ static struct pktgen_dev *pktgen_find_dev(struct pktgen_thread *t,
 	struct pktgen_dev *p, *pkt_dev = NULL;
 	size_t len = strlen(ifname);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(p, &t->if_list, list)
 		if (strncmp(p->odevname, ifname, len) == 0) {
 			if (p->odevname[len]) {
@@ -3787,7 +3789,6 @@ static struct pktgen_dev *pktgen_find_dev(struct pktgen_thread *t,
 			break;
 		}
 
-	rcu_read_unlock();
 	pr_debug("find_dev(%s) returning %p\n", ifname, pkt_dev);
 	return pkt_dev;
 }
-- 
2.43.0

