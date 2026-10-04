Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB6480DEC
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151207; cv=none; b=ZZNCFRXLbelV6P9mhyk5fIQJog3q3YE3EVJ9feFnk1HJd9PoE+tH9vQNfdqbr/zHsfYA2oRmiA25v0AGcQ7nmf25/ccwXcTPHqDhMvo2ICWrqDTifnbxvBobXfbixLXGQpa7I/YvEps07xltIJeIuJ7XLgWUbAIjRCxIAPEbr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151207; c=relaxed/simple;
	bh=A49zyjjnqqb50pG4MqWzNRlRKAi9xTHYpw2ixK1+k84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gRlBNnPKTU0NFIw6PEB4w3ZsbW1yu4txfjfajeDNtp11Nnq7DVdSCz+D7ta+Jj1suwGDKnKI6pOrdYPtYAmDRfNtAxx4/WhoOtF0rIXI9bgrw4eNiuoUHegj5gvuYek4gHZSQnv061fcjneU/gPMzCkWZdwEpUqn7e49BpxH1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsNSgBPe; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsNSgBPe"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a1722c37c9so1902245e9.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 15:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791151204; x=1791756004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9ZMcU4NSbtXZ2T+rqlz7vA0bY14DXoiCQpMM48epr0=;
        b=RsNSgBPeuAwryu6cQEQFTvpMvhmclslYU+UDPuOLsR94lwv0GFEFC21qRMaIunzVd/
         wKJK0CBl4/WbBWpmfJuE1anC1jtMuzHSeXUmjXmJv9fgOsAwbqgzHS5fUOLCzgzw5Gfd
         v6Wxoy7XmmGDdfvShzCLKflCAixNZjnHjHhlZXjWVhJgVzF3C1i+mtWUYNYujkd1UQxI
         3Pbmpm6t5klfqL1cpYFMQ2iKK24I0lPH3wXukZfuNHYTJ5tpzCa/ioYWQMpeudL7MeWM
         l4Iz0dnV1Akbnts1PEIhpH9SxZZb3LmxCn72dWBbFy2jzf0K0ZNABDLCO1gz60AG4Bak
         q3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791151204; x=1791756004;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v9ZMcU4NSbtXZ2T+rqlz7vA0bY14DXoiCQpMM48epr0=;
        b=ncWp9mKn2M7Gq4LFfpyLyaowC8vWWpjgNCCmRKj2rkJENWUnrlR3e6EHmchcQXG7Ue
         L6XaLeqpKBho23pJMMjx3M8koGkxAiOYsivf8o1K8hYyBzkMiiC6c9dhZ6CqDWVHZGp0
         O/Ot76I0Mrm0PW5ltC3qbxsHN6xHOwmcyhTBC+aR2Np7+l6nf98Op5dQU2lqH4oeyzCS
         E/m9QOYv6+MX+7+fq/nMFc/nqZJlzKyywX2BnBgAFnJZ9kGEInS3Gbi55L6GX1aBl6T6
         dms0hwPhb4aGiC2KDLC+GavkCht/NcHMjShVuNxU3PPmYVA4omsRw/EsvP5pUik+J/3C
         /wzA==
X-Gm-Message-State: AFuF++nJ1yXU9FGNXR0dLgPqPwZycyrY0cuIGsHoqagzLp3TizjneXOn
	qmR+CoEuht5TPYEPxOnQkQ1ZvANe1mC0dEGKnNB9w3Vnh3/UjV1e5YpClrYYy3Mgvy4=
X-Gm-Gg: AYBFou3DAuSS3K6ASy5YRzpmwr2HYdIhTububI+/rgK1wIJHt5IqDkXlM1k/w97H0IV
	KrZiUMCt5LQddMQlcT45FiCJKsvYrzd4N488Xp8zDIIq62pjr9CIGd9WCr9Z4S1+N7jU2pBIQum
	uGIGWVLWHk77bXOXtB+BZObj9tBewNFSzmWxBn6a37XTE/fHdYqR+I506fZB0o35RS2CdSw/Rv4
	xTDbw5gqOiWeTwIZo+LMNDPql5bYi47E32rTxrOH+itNXmhrhGbaeg3Rg56JXqjgw9lH/CJEYrq
	t6mVIJmx9HtaHbtXnjTWdahxuD+GodTWee7sWDO8sxx4JN5DJjJKeurDQa+jCd/717gIxvQmwlV
	D7oLHVmzmd/Ofcj9tq9sxINORo+g0hoOSyy7g05AH8Zhvn1BHHeBqmI499M4Y/Q6aM1E1cUuhic
	1BYyYgcdmQSh0aCQWS2ioOVn92nwlNAnjxcq7ZXRC7x8Y4SsUxy6IO9bpzUoop/iPs8t2hZDeH5
	9hceEE=
X-Received: by 2002:a05:600c:3b1d:b0:4a1:7033:5b55 with SMTP id 5b1f17b1804b1-4a170335d02mr45106945e9.21.1791151204108;
        Sun, 04 Oct 2026 15:00:04 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0a6e894a4sm256671015e9.5.2026.10.04.15.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 15:00:03 -0700 (PDT)
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
Subject: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible context
Date: Mon,  5 Oct 2026 00:59:25 +0300
Message-ID: <20261004215937.302247-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

tx_complete() calls this_cpu_ptr() before disabling preemption, which
triggers a BUG when running with CONFIG_DEBUG_PREEMPT:

  BUG: using smp_processor_id() in preemptible code in tx_complete

Fix by using get_cpu_ptr()/put_cpu_ptr() which disable preemption and
return the per-CPU pointer atomically. The usbnet_skb_return() hunk
is a hardening change: that path runs in softirq context so no warning
fires there, but the same fix is applied for consistency.

Fixes: ed194d136769 ("usb: core: remove local_irq_save() around ->complete() handler")
Suggested-by: David Laight <david.laight.linux@gmail.com>
Reported-by: syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04cd90bb99c6ef81a65d
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>

---
v6: Fix commit message and Fixes tag as pointed out by Sashiko:
    - BUG is in tx_complete(), not usbnet_skb_return()
    - usbnet_skb_return() hunk is hardening, not a fix
    - CONFIG_DEBUG_PREEMPT, not PREEMPT_FULL
    - Fixes tag updated to ed194d136769
---
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

