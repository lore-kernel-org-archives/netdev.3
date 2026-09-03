Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25F4F30F9
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454522; cv=none; b=D+Qp4IQALkVB+5ubZaXYGMGGLw9wWQg6ezWUpKLQquD5h2z75Fo1NS1upN9oEwOpbJuJ+hsuKyrxfP0zlz09j+ObhluMVYQTf69REnZZ4uHivRFrLW69ljBa3cRb/f9p7z6nytRyF2ok4FoVdtvz+dexXoPWGH5SoT+hFSNURUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454522; c=relaxed/simple;
	bh=r4lLAslr3Z/NX7BD2LhfQjN7YicMpHzqO7Pu0yQeDb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q4pvtm3UIPh6Y/fnRqR0S3ALdG2az2QA9MPoit0UAy0IerLRNGJLXh7MeDaw6KJ0xizWH4qZ6p/ZD1iIHiqzVIlkcQzYZEd7H09iLnJhv8pnOhI3rv0GfczIA/M4cuFJft6gfKlqt+CcIzEMDfUeJIcYgN2JqYoTvIkFa8TYy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdKIdRvU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdKIdRvU"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495590dde14so1654515e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788454519; x=1789059319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XN2S7CaOTGey8tonopGId8lsYub4UAOQaOoySYQOJDk=;
        b=cdKIdRvUnNJ4LIFIzSSXNoTnLc14y2bXiD+dlPCcZ5CNPF1nPS6iSp2RaWCHpMeZHm
         ytnodiwhnC4/+P95l8DzmXqv0DIqIJxW5osgZhAbUHqj+Wt4r0k0yspymUAaG+Kg3k6/
         aM7SkL7Ui072VxrKtCQMcnkkp0+CfmjldQULhwXhu3L6qeqSLGsteaA5wM3Fq99qok52
         YUOetYqQJQyzCxDBSwH1KuqJuJEvEw9JUCjTe8VDmETkfN6nvfXiWchrtz7BFGfmad5M
         gqDyj64ICmTnkmfW2OoPk5POdNypxGgda/uiDlrbuaEubf2qOKjV725kfXdlecGtnY04
         obew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788454519; x=1789059319;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XN2S7CaOTGey8tonopGId8lsYub4UAOQaOoySYQOJDk=;
        b=s0R2aN5AzROlK2CBa1nJ2i3/SWUmQUfqUzDtrqSQl2Bj9ZQdvMnUsqR+evCe2wD/mF
         1j5+fVt9nDQ3BTfavS5ZJD2dPw/J+yaU3/UVoKgXtTbzH7o9rOCDC36ehXvj2UT9cmAU
         KZK/L/mGiMRxfTkUvX5n7H1/ymIi0YxSfnT9CTAFrfydKG5uKjJyvZ0D7Df6vrVYvsNr
         B5TugSD9JnbmgzEFooQo1fvIUhBvdNCwgYyBkrcdDISgzmZF3SQRmJf0+Vdrx62VPYiZ
         DNdlJqExDRK6wcfvKsMfezuVmNK7EPy8HOB4y5+8LrLmWWJfcKajgLCAIvzdm9NmU8gk
         ULSA==
X-Gm-Message-State: AFuF++kyQNpueJSbbxPZiUY8hgY496dvnG/pjWiVgwr5bZM1gTFL7ZUL
	v3jN2E3A6nLyL0upwqKX97F9RnORopmoHp9qvrnTyGR3I2RXaH9AMz9ij6oYuLh9i58=
X-Gm-Gg: AYBFou13iOAjru9zVi0VyeeOJkLgrCyYqnk/1Iyv1WQApYK7ciSD72no9hf9NKfxH4o
	x91oJXqgod1SvE7ViH498kE9Bdgl426rEAfvNyHAm1KmSsMFBphkOCTRewS5ahRwng2mXlHY4Hb
	kGWbp5iAoiCzTA069Zu0WS1RZtEBgabq/fiZcrhViR/KA4iBIv5okF1F+MsprhlMKDjFU+a21hD
	gwUL1OPiFOW61qJ7m/Qtamps9DTtCYszofxDpjJIv3L0I/q5sND2ATkCz1mgLpcalWnXv+ZLuSF
	U0DT5nxrLTaxfVUjhOyCS2iiE2CYbeb2EPN8RnwJDgIxlDKR+iHh92Xi4zxWFPa2qSjqlqny7nu
	K6bwSII8R6uTmbJ8pu89m/1s+Ioy/PqyLEZe1AkafvqsBDxISYKPTfril5dAZkNXtLRaoUtHCHx
	uyTEaRrZr7q0oYYf/7CuXNRURM4UMYZSM/WNbdg2KipEVo3d9IO3l0bE66l+DrDL1D2Efk
X-Received: by 2002:a05:600c:4fc4:b0:499:cd34:f7c with SMTP id 5b1f17b1804b1-49ce58168f9mr243889785e9.5.1788454518780;
        Thu, 03 Sep 2026 09:55:18 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf0c1728bsm70772565e9.15.2026.09.03.09.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:55:18 -0700 (PDT)
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
Subject: [PATCH] usbnet: fix smp_processor_id() use in preemptible context
Date: Thu,  3 Sep 2026 19:54:32 +0300
Message-ID: <20260903165456.498079-1-omermetekaya0@gmail.com>
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
Resend as standalone patch; previous send was incorrectly labeled [PATCH 1/2].
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

