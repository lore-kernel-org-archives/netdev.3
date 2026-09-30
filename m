Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4E51AEF3
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805067; cv=none; b=O2fy0G4GusI/pH6/9i5wFoJH/nq4ghPmZ8/4BojjCnDgb3UMrA3KFBqXBOJgBqAt2aOSu+LTuD7z/eeeoQW5peHH1Mc9IiU+1rQFCvaO8yNNUw/Wt0TThJLl78hYBrwje3FA4FXY24SYYKEeGh8Efxf8REjLuTCGI1FsOVn1Nz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805067; c=relaxed/simple;
	bh=S22VfBD4pPls7UNG2NGxhpfRB45ROGORhMSqMHSQu6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kem2bAsACwFzRUaDfCxJQ+KyapQWmlQJRAP5Vrd+XgW+tlO2V/mJCrgXkZnn5eMhsR9HetY/dY5OG8x+1FgDvJCPpurDNedTE9uJ/7q6mtMTX6i2Xy3Oks/lwyz4LuDZ+N6pbVwWHD9QIx5bzdSuf1IZbTYi1xHYlO1mcGUtojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qts7upZX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qts7upZX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso60316015e9.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790805064; x=1791409864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8LP8CV7WHWqRDeEIDZ1+1JYJj+ocKrw1BORKdvPxNb8=;
        b=Qts7upZXHfzDn7Iy13fsIBPnv9thUWdpaxbsjgvCS5XgctLBIyjXxyvi0hcj2oSZ+P
         YD2DgPXYRxspt9bDXqkuByIjD4moULTqf7YOHHrh0NvhHIj+YabcuED2tbXoSw3CypvU
         o/DiWuPZXeUi9q7Xuv9Gfyfvw0k2Npm6aXozgm/c4+ReWAz+rn9K86/bjXXJGq8j/kmd
         m9S73z7np8+TQPkxxXUPzs8L8//ke1Y2Xp62bkRWye2wU0/WCi+zJHw1ag7qpAWiQo9n
         efXrt8zMDfUth3lgcARbV3MqfNyTkUJponBpl33dQaav7jr2aPvPnSqOOpSN5/ELofEx
         KqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790805064; x=1791409864;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8LP8CV7WHWqRDeEIDZ1+1JYJj+ocKrw1BORKdvPxNb8=;
        b=20993fi89eiIXgAJMfx3Enf8pUnsWjoFM5g97Or2eTnilSNGDqWjn3WMCfatF0YzAm
         GDRuomn8np0fuF7aBjcfH258EXfUGd/xgXxWEatPoWJ4+Xvc4qkZ1V7G98V2ndNGUP4t
         kMJMD/pfNKYVr45t/txfVd91KGHeJ2/s8CkQpln8T1Q7uYLWVYbEhC8z7/clNG50Jpty
         5g9ouhQZHp+kYb1VmIVJlEUKAnKBQlod4qFTmndL6qX+9zFL5dqgxR03I26uJ7SVofIw
         XQPprMDaOeaIw+JS+1JIznA1KNDQ7wcahQOac3NtYMwxjlWHLvVjorXapMi9E6vdIR27
         EECA==
X-Gm-Message-State: AFuF++lnLEuRIGhR4O2bbh6nzBb8RZOR/CLjab4+MtNp8KQ8hSIf+g/5
	ijupRVaMd8hdBCvPQk0aJ9xbdLAoDF+v4g+YV7+yfsvP4AcpwUZHyiv8x1GcehjLyeM=
X-Gm-Gg: AYBFou14eE2EWUL+lxeuiIlVT4TxX9pIWc8tgHXL4kCwyd1Q0JGWwcj1NIBN6ekMZsW
	n9gm49lJRhcSTfCQmP3sT+eJBLnMB91ROe9AMIgSwgC4cg6a+X0TD2Zl3KnGw1iACd1U/Vr09aJ
	nLNvhXi0nP7B/ZxmR4JvCnllzqhOmdelO/U8cQ2c8P1kS6Rbe81rNlveRFerHSpFqgfHV2uIi0u
	xoVqMTH+6YCWarOBPXBUxMN/cQCAByumpR9uEQewOTvKQtIRk+a0COpkSZladABLEsbN7pS4HRd
	hCuekAB8rL22ODiFCmf/lqYfd4cCykwXci3o1sMm54V+9yrBkBVlEEDQ715WRrvLntkwU2LPTPi
	tGTzv1p9sN1O6jeaI9hKIC5SWFoJtdnqTB9RYb1pD0A76y+1nMtCOTkPX96hsRl4k5ApDB+jMXk
	AZ6TrPUELuMz9QSdJ+ccTyRjMX29qUFkx0f41i4s0hG2CurXi/B4UIFw8TEwC2aQzPQqKY
X-Received: by 2002:a05:600c:638e:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a01aff908dmr42791025e9.26.1790805064167;
        Wed, 30 Sep 2026 14:51:04 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979bbcsm12937155e9.5.2026.09.30.14.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:51:03 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: netdev@vger.kernel.org
Cc: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH net v5] usbnet: fix smp_processor_id() use in preemptible context
Date: Thu,  1 Oct 2026 00:37:12 +0300
Message-ID: <20260930215047.718270-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbnet_skb_return() and tx_complete() call this_cpu_ptr() before
disabling preemption, which triggers a BUG when running with PREEMPT_FULL:

  BUG: using smp_processor_id() in preemptible code in tx_complete

Fix by using get_cpu_ptr()/put_cpu_ptr() which disable preemption
and return the per-CPU pointer atomically.

Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
Suggested-by: David Laight <david.laight.linux@gmail.com>
Reported-by: syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04cd90bb99c6ef81a65d
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>

---
v5: Keep _irqsave seqcount helpers, only change pointer acquisition
    to get_cpu_ptr()/put_cpu_ptr() as suggested by David Laight.

 drivers/net/usb/usbnet.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index a19ecf718f36..84f97f448b2d 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -325,7 +325,7 @@ static void __usbnet_status_stop_force(struct usbnet *dev)
  */
 void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 {
-	struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
+	struct pcpu_sw_netstats *stats64;
 	unsigned long flags;
 	int	status;

@@ -338,10 +338,12 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 	if (skb->protocol == 0)
 		skb->protocol = eth_type_trans(skb, dev->net);

+	stats64 = get_cpu_ptr(dev->net->tstats);
 	flags = u64_stats_update_begin_irqsave(&stats64->syncp);
 	u64_stats_inc(&stats64->rx_packets);
 	u64_stats_add(&stats64->rx_bytes, skb->len);
 	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
+	put_cpu_ptr(dev->net->tstats);

 	netif_dbg(dev, rx_status, dev->net, "< rx, len %zu, type 0x%x\n",
 		  skb->len + sizeof(struct ethhdr), skb->protocol);
@@ -1298,13 +1300,15 @@ static void tx_complete(struct urb *urb)
 	struct usbnet		*dev = entry->dev;

 	if (urb->status == 0) {
-		struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
+		struct pcpu_sw_netstats *stats64;
 		unsigned long flags;

+		stats64 = get_cpu_ptr(dev->net->tstats);
 		flags = u64_stats_update_begin_irqsave(&stats64->syncp);
 		u64_stats_add(&stats64->tx_packets, entry->packets);
 		u64_stats_add(&stats64->tx_bytes, entry->length);
 		u64_stats_update_end_irqrestore(&stats64->syncp, flags);
+		put_cpu_ptr(dev->net->tstats);
 	} else {
 		dev->net->stats.tx_errors++;

--
2.55.0

