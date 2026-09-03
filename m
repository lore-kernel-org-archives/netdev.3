Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C9411A0C
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454052; cv=none; b=bH0z4TD/28/hKZwoObndDs9N4rsz2SunelvIPwoKxNLpNA5evuZcjuTnTgnFLCG6bKv47SUSXLqojNEpYZalPS2QAd2LOmudTqTv5HvITHEKPfzV7pb8MgnofzQ8//rPI4Xra5iBlG/WMW6k1U0ABOeW5xZJn4YVgRGjQkGzsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454052; c=relaxed/simple;
	bh=dFbvVbhrU1LDRoSLSgICkESlVfdQ/zElqgjxIEwbW40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s2ARMn1bdgueIRlm4a4foKZ57QprkxseigwAy1RRzBQTJinTBe5m1uK0g1koyMwNrUfIuIcZADO8Wktc8IZ6uoklWNFztm5j+jtfxohpYggP3en/fZlo2L3y4G0Ol+pJBy339O46dfCbYZjVhiUSSf9zh5AUtKXQ9PXmYTLU9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LICHJNks; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LICHJNks"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-484362f5c4aso84500f8f.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788454049; x=1789058849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0C4Pn8XgLEAT6VPP+1P6SB9fmJ1cYvaZMKkNJVOJvCI=;
        b=LICHJNksgmAMW5MeyBcDytYrQI7igq9kZsHihM23syt4llpR064fmCwZ6yPppLTXr2
         iDEYAcTFJLVa+EpZmywPCy09zA7TkNm8ZEqi2Z9E4YKHU3uMfldcGjQDFU24sM82hvMv
         AAGQZaxbsIhN5z0lstBljcITaxoB2X++wpg+ET46SZEjNLpUWbQFHxF3NdqSVMUCyW6J
         0YqvfqcNTRsucUvAdDewTt5CJPDUS2sMmP/HRp+ODHkr60x8WLFMq6Cr+FNjgZs8mCsW
         t2Z3a6/IeCyVaddJDA57byF0bCZl//A6n2KI2zVuiS0fhbdPkxVenJLISz3Z5jnMXSDo
         t8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788454049; x=1789058849;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0C4Pn8XgLEAT6VPP+1P6SB9fmJ1cYvaZMKkNJVOJvCI=;
        b=EbNCllhDH4qTbvVjy9NT2tZ3lIEvTBuL4oVm4T2O/IDH8K2p0oe4Hx1/FDgB//GerV
         koYGJ4thiUqz2K0/zQj588JfJa8t40hJ3tdEjRU/h1yG9QbTtG8BCAkNBG57MLYf0SR/
         N547Rpu6KvOH6PgXO9/SYuzWl4MnnhbIQ0AEOaLpMwwiTJvONHo9hCHyqmwTu3GoITyr
         TMegVArl7/1acCo1yXjJAZ21XvfEpbxXxkJixQf42kN9cR6NUTjDfSOkbWp3rFkg/Uwi
         3jdEB3BkLmYQwn7TEXkWEZluM4ljuATaBI/HMRpjX5E8O6nfvdvMihM7rm0G+JIZhHZb
         Z1GQ==
X-Gm-Message-State: AFuF++kthqPsXYWiNgZGHVX5r5reBtttFyvT/ggevgVRDUXeUChFPe0P
	/0LzdS89DHmUxJvoB7Fk1tPiFX7p+ejqGBdN6aQmt9tmG1OxA0DB7AOciaP9gm9H8pI=
X-Gm-Gg: AYBFou0cIcZTMbbH7khBKUEIPEGeLx0i1chhjw9ZeokQgZWx9t9gCAmGkSJj2i3awVs
	w/SZ1CDyHW12K+78ZbrTrrL9GzuC2A1h7UlY82OzRpSaFhuCHNSk5RmlYxAFOkos1WIrveWVCH5
	BlGrWAX2o7gx1rSldH4MHMLoxPEXkxv8b7mROmeewHk1fzn9htJBDm4g0BjdDWmrZ28EFtAcYES
	RJBxMszsBCwXhJJdKMbf26WIoqgRb5bElNTKkZW3T4LPWp3W8258QJ//vVbcEsD9qBAw6lgtf25
	q3B+fMat+QSTeKgMO3QIIi+nxclqpZKYe1ktWMPx+ylIvUnG2lPf6I+8iXofHBN1y4GeSYaaH8T
	nlcz9fmWPaEW+cuLcelHIKocd5ZKEixGoRKzaFcXolNhHRo3ldG6D8vL59y+INXfs4yD2m9bVwb
	lklA0X8r54XLoz9lJKvgGEA+GQlonUPzNFeRk8G7S3jO6PbUKQSkuXh1aufg==
X-Received: by 2002:a05:6000:26d3:b0:47f:eac2:6f55 with SMTP id ffacd0b85a97d-4858708fab5mr683390f8f.19.1788454048673;
        Thu, 03 Sep 2026 09:47:28 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80745sm15188432f8f.15.2026.09.03.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:47:28 -0700 (PDT)
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
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: [PATCH 1/2] usbnet: fix smp_processor_id() use in preemptible context
Date: Thu,  3 Sep 2026 19:46:32 +0300
Message-ID: <20260903164700.497024-1-omermetekaya0@gmail.com>
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
disabling IRQs, which triggers a BUG when running with PREEMPT_FULL:

  BUG: using smp_processor_id() in preemptible code in tx_complete

Fix by saving IRQs first with local_irq_save(), then calling
this_cpu_ptr() and using the non-irqsave variants of u64_stats
update helpers, since IRQs are already disabled at that point.

Reported-by: syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04cd90bb99c6ef81a65d
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 drivers/net/usb/usbnet.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index a19ecf718f36..6a48f38e105d 100644
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
 
@@ -338,10 +338,13 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 	if (skb->protocol == 0)
 		skb->protocol = eth_type_trans(skb, dev->net);
 
-	flags = u64_stats_update_begin_irqsave(&stats64->syncp);
+	local_irq_save(flags);
+	stats64 = this_cpu_ptr(dev->net->tstats);
+	u64_stats_update_begin(&stats64->syncp);
 	u64_stats_inc(&stats64->rx_packets);
 	u64_stats_add(&stats64->rx_bytes, skb->len);
-	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
+	u64_stats_update_end(&stats64->syncp);
+	local_irq_restore(flags);
 
 	netif_dbg(dev, rx_status, dev->net, "< rx, len %zu, type 0x%x\n",
 		  skb->len + sizeof(struct ethhdr), skb->protocol);
@@ -1298,13 +1301,16 @@ static void tx_complete(struct urb *urb)
 	struct usbnet		*dev = entry->dev;
 
 	if (urb->status == 0) {
-		struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
+		struct pcpu_sw_netstats *stats64;
 		unsigned long flags;
 
-		flags = u64_stats_update_begin_irqsave(&stats64->syncp);
+		local_irq_save(flags);
+		stats64 = this_cpu_ptr(dev->net->tstats);
+		u64_stats_update_begin(&stats64->syncp);
 		u64_stats_add(&stats64->tx_packets, entry->packets);
 		u64_stats_add(&stats64->tx_bytes, entry->length);
-		u64_stats_update_end_irqrestore(&stats64->syncp, flags);
+		u64_stats_update_end(&stats64->syncp);
+		local_irq_restore(flags);
 	} else {
 		dev->net->stats.tx_errors++;
 
-- 
2.55.0

