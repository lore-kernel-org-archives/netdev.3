Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DD543CE6F
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817678; cv=none; b=pKh1/Ee5cC5Xj8BNupFVo4ksnt4ddTLyeR66qicyP1PAbLVaVAsgSYPVOsfaIXMRBsl7yWHD7X43dB13SK5gxA772yvZVpBqoSUNVE5Am9nElCX13Gs8rWqK4NLWmBsK30N2rx1fnY4Y6du0WC3i2h+PtEyKbggkD9GdSx9mcbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817678; c=relaxed/simple;
	bh=IDjn/kq5IVHDJPlyX+6SDU+x4L/nD8KL0YP/lw8iah4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNM1vb8LdkuKSPka47x/YdJZkiwLQZ+JdhQ7Buy+jSWQPXDQt4CQ5BOXxr+IDtO1KhW/XcybvSoR2ugONEgc7tBbYkBhkKUC5G7VitiVc0Zf4Lu/YZUvVBoWzEmDtx+aZnpumwlI2X2eR1wlHwso8h0ol0+SrM5k50vZzeQNgd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goKZDwZb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goKZDwZb"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48589798dbbso3300623f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788817675; x=1789422475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5KUdZmBnDmF2hbOlG2VbjARf63PeIjYTeZjDuYjWBho=;
        b=goKZDwZbuCnjOJn/PCJhhgLuh++5LY6zuuF3CnhVV81Iy9DOL37N4oDriosmvXhT9n
         KBIUaf+8d3B2gZdrI8F5tqsM21GFlJt9y1vWTQ5IIG88549LIAskxcsCNRFRvuun8pUZ
         snkkmDmD2Nwy2/ebEcy3X0w2zN3LlBzoKDZPaLKRzD/23dWakrc47fUo9hFcCvU9MJXr
         T18gADqjX0uxO6J5jqW4kuNazdS/MR6eag5mRRFtDz9XpAg/ikJ4ifcmo9QI09C7O4Gz
         50upSZF9COQq2+eqDt7paZaojxXmk7fG58Xa5I37PokippmdpijphVYhVkFokvJ7QB2P
         QlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817675; x=1789422475;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5KUdZmBnDmF2hbOlG2VbjARf63PeIjYTeZjDuYjWBho=;
        b=jWCdvSaqRWh9vFJ4JKYi2z4XaMjemTFczml1nxD78sTqK7NH7cZLoK8hrO4ulzzPx9
         Av3GANDgoEXN+Ahfch7/m9IQ+jh/aKosNly0mJHqeqLirdqETOk93lNJgrJ4pfDiz9J6
         CwZFpI1c1NtsAoKxWqrKwYEkthvBw9dDg/pG4pPckXfb1M8+gz7ysVoe1BwVDEA9MpKj
         NhpW/FgzvRzzEijjUX8ObAjnIK1QoOX60TFrKWQVbioBeTEn1UsZELi7CxYAB0lkBx/O
         zMtRT8EPXLE7KFOFgorjBy7L8melz/fa50DAUfkzlzKKkmv0RX25E0Eo47Dlqlm6/hMJ
         qo/w==
X-Gm-Message-State: AFuF++mMfyYdEKYmO4+fTucB4iAyRxcuBXoLd7K2LSCJ06xD2XMHznLT
	J1JNhSz3Itn/cO0ASJjyt+8tCa1jE3Ylsv+o3vCIDbKlWKaByYY86fba/LLSdP43+dg=
X-Gm-Gg: AYBFou1sLOaoVxH11mECSiAChu4NI0Sv4B3m57NuXPPY8Pa5/hIZXmibnEH27+2+JRf
	tro2BVEy4dVAXt3lWeM2DAApFNCxRh8OtnzUZZlAwR7I1InTFDvhGRprxTU2n1jvXao40uqTJjk
	K4cy5eycL0XQOJzS+FtUeqXDVUmTQnzwZh/kXEnjnt4laobysqe4vj9O0QvN87VfvUxtxDWjz0X
	1I/4lkIO9GRarDKJfrgoF8fGKoIJxrl/vH96Ie+AEl8wsslM1TxqzZZM9GO6tJ1ds5dPCWbEYHh
	fbWDY2r2oBqDvxsQnwc8AlLs97QUIb0EJK+qP4/GuUnZPJcxNPzrrRzpir5gV8eLm8bjhrMUNvZ
	vMNhAmp6DYHVmBp2VERXB4gO2pD7hH9cdYsBjoQvMb1NNRBtJ1NQlXPN7dD/EijMdLBqGlCsIw0
	HyF2QeG9NAtMq65+frS9NN84hMgFRrkzY95BxxMRCZ1VJF6fz3AaGw9nOMACPpO+sc1Nl4
X-Received: by 2002:a05:6000:1785:b0:485:91ac:434f with SMTP id ffacd0b85a97d-48591ac44a5mr16089651f8f.16.1788817671341;
        Mon, 07 Sep 2026 14:47:51 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bbb51sm32792941f8f.30.2026.09.07.14.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:47:50 -0700 (PDT)
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
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: [PATCH net v4] usbnet: fix smp_processor_id() use in preemptible context
Date: Tue,  8 Sep 2026 00:45:12 +0300
Message-ID: <20260907214727.692307-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907212308.420701cf@pumpkin>
References: <20260907212308.420701cf@pumpkin>
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
Reported-by: syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04cd90bb99c6ef81a65d
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
v4: Use get_cpu_ptr()/put_cpu_ptr() as suggested by David Laight.
 drivers/net/usb/usbnet.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index a19ecf718f36..3df72b0c6bcf 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -325,8 +325,7 @@ static void __usbnet_status_stop_force(struct usbnet *dev)
  */
 void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 {
-	struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
-	unsigned long flags;
+	struct pcpu_sw_netstats *stats64;
 	int	status;
 
 	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
@@ -338,10 +337,12 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 	if (skb->protocol == 0)
 		skb->protocol = eth_type_trans(skb, dev->net);
 
-	flags = u64_stats_update_begin_irqsave(&stats64->syncp);
+	stats64 = get_cpu_ptr(dev->net->tstats);
+	u64_stats_update_begin(&stats64->syncp);
 	u64_stats_inc(&stats64->rx_packets);
 	u64_stats_add(&stats64->rx_bytes, skb->len);
-	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
+	u64_stats_update_end(&stats64->syncp);
+	put_cpu_ptr(dev->net->tstats);
 
 	netif_dbg(dev, rx_status, dev->net, "< rx, len %zu, type 0x%x\n",
 		  skb->len + sizeof(struct ethhdr), skb->protocol);
@@ -1298,13 +1299,14 @@ static void tx_complete(struct urb *urb)
 	struct usbnet		*dev = entry->dev;
 
 	if (urb->status == 0) {
-		struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
-		unsigned long flags;
+		struct pcpu_sw_netstats *stats64;
 
-		flags = u64_stats_update_begin_irqsave(&stats64->syncp);
+		stats64 = get_cpu_ptr(dev->net->tstats);
+		u64_stats_update_begin(&stats64->syncp);
 		u64_stats_add(&stats64->tx_packets, entry->packets);
 		u64_stats_add(&stats64->tx_bytes, entry->length);
-		u64_stats_update_end_irqrestore(&stats64->syncp, flags);
+		u64_stats_update_end(&stats64->syncp);
+		put_cpu_ptr(dev->net->tstats);
 	} else {
 		dev->net->stats.tx_errors++;
 
-- 
2.55.0

