Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548225;
	b=r1EjDjCl65/U5BlpRtPxPF6ednwuOrxr+WBLX7GUne+Ckq0aGcbcxXMaQIS8bw2hq/PO
	 MnDWiqTYYU/3CRx3COpF/E1lStokU923YSSD0YkfBb5eq59vA/pDT6A8U4R5d+57kJu3s
	 kXQXDUgb0E5dQyaOuzh88+lwbVpeCxHqNyYHBwJQKfp2SS077RvE2OrG/4fcNxdGgwS3K
	 ZcM2fqRtgFpSquYO8hsONpW9pBpOwO5UkC1/w8Xt/1hfeDpnptwtRZVL3NFu1wKqrUNuL
	 uqCvD0P5v/SGN8FiH5ZPh9OQW2o5BwtEjQfzkKjOS1eHhlCAaegVZhh7wOsUxwxRN7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=leSND+5gisN5Md9k6LWpzUNyWGXK/I4NhOs2RkfudTI=;
	b=Dk+/LDOaxQfluXtYextZsEstlgj6iM6C7Eghdy4OtelkJFtujA87YFeAdBXLjtmFAs9K
	 MX6bid4WE3PQ9qW50IJ2cEdC7eX1zd9D8RfsxtWlKd2Hg2++5JzLQPFNDzwLtbz8Owd7Y
	 eBUaSrjqvlQP1cJmdFjGoTMhqe/8qUO6kELSfvjJILkdYLH626umh6wHePV6ZBDxFSjoH
	 Ku66inrXEYpIYtfLz0trIDpg3kSy3vWHPxZH1Hikc8iyNAZE6KTh7DO1O27IczSbfEaRA
	 vjdW9C1mnVuV+tT6/u8GuwNnB5/SvF8wR1wc1cLp0IOWXF73is4qotYA2qSfDmh6zoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=KyhcQuTT;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24593606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24593606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=KyhcQuTT
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd633ef819bso43516a12.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792548224; x=1793153024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=leSND+5gisN5Md9k6LWpzUNyWGXK/I4NhOs2RkfudTI=;
        b=KyhcQuTTzpKqbvaknksf7utJsW06DxxLx4QaDlffYH4qt+I/ETuSR2uThYMvmk1veb
         5oxIgT6jmJiE5b6tNj+sNcOQmBF9p0UT55GNErw3tlvsQVtD+txBcJA93+T/YT+HIhEP
         jkbyvCZGDqcw29GFSQD1rx3XkNXqwrdi4MJSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548224; x=1793153024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=leSND+5gisN5Md9k6LWpzUNyWGXK/I4NhOs2RkfudTI=;
        b=XbZ7yCZU2FeBf58H+D/cUZ65ScQOa/7mZfW2s21NYm12F57KTPk89rWbJyhn5FkKLv
         HllWpLDlinQ8WgfXhlvHA9USXGd57/HfViuo8vZRNefCenY3LvjFnNhZ86QvVxK9hOoc
         YeN917kwWbIQXeGfggedpO/YBB37D8l/Ez5/TWLd+srXx3H+EpQcj1dKbqLTnvwm+gtb
         /OV15hkqOzt8WK0719x1hWx3gGoAJ0d8gZKqQp/BrXB7x8JRo1lgWEHB/gUg+3dXeBno
         YU2DNX3/bMf2rsUL5Hqfa/pPogWEz58+zRiRZvP4o2sSqkUd/sxtNCiVHkBXaE+PFNvy
         aKCg==
X-Gm-Message-State: AFq9FYJMRyxZdWlDqrCAXnLCC31NbZimYd2KjyY9ncUT4ly5meeKnO8V
	Jcf/Xb/c9Mg3Sn57IjABPKAoqQOC6t8SAJAE8a5b9WTpBg7AGl60JGn17oH6tri4E1g=
X-Gm-Gg: AYBFou0YPTNtI5+XTqeOYJT25YTmRtPJiJxj1ZHp0HMijd+PZ7FwyXdm9mbsajotpZc
	TPenLeMc+yp0mWHVSlSHVlNMPX/CJea+WAZDLIMIqBc9rGkxpqDfJAxR7pqJwTUnsXuHbonjgzl
	LySldxbSCe/CBH1bxoDl+zKy0NmRwKh+nybxQ97+Q6Bi33yBcepZG0zw/o/cTF78atPXXUj2R0h
	QwZwQpfrd3JQ2qYYdkwnDMGPt7HPAcz+uHCNP9dP4K5D/MXDAMRNWefW/8d99VtZdGmXKm80ZJ2
	by08abXZZGRU1nUQbGNlYUCjBnZTkTT3qiHslxwrj/O0OA2t/za578tzWZFbpdxoE8PvB97OSGN
	90Hlo7K83oy81npVC0NpVDlhfyHKaNpa+SJ9BxxeutqatUP+a6o8seB4qZiJnxqutxmHGPc6KDD
	4h2KFty/ogsT6LJ981XY7gGZQ9ctFfKyGnCpofdsHSutGOqc28Axx86Nm24UpNTHGusc3+7ndQ+
	87K3epTbdaQc7FI/sA8a6RndEdLqd7Ehq4gIgfwyny95nnL+EqE1CCG4FcE56grfFP2uD9FVJFg
	oluEfFVLAw==
X-Received: by 2002:a17:90b:4b11:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3ad86cdda5cmr529688a91.64.1792548224392;
        Tue, 20 Oct 2026 19:03:44 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([203.125.131.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8035a117sm1934124a91.16.2026.10.20.19.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:03:44 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: usb: pegasus: do not advance rx_skb->data on dropped frames
Date: Wed, 21 Oct 2026 10:03:09 +0800
Message-ID: <20261021020310.34045-2-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
References: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
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

For the 0x8513 chip, read_bulk_callback() skips the 2-byte receive
header by advancing pegasus->rx_skb->data in place. This is done before
the pkt_len > PEGASUS_MTU check, and when that check drops the frame
the goon path resubmits the same skb with the advanced rx_skb->data as
the transfer buffer, still PEGASUS_MTU bytes long.

Every frame with an oversized length field therefore moves the receive
buffer two more bytes towards the end of the skb data area. A device
that keeps sending such frames makes the host controller write received
data over skb_shared_info and past the end of the allocation, and the
corrupted skb_shared_info is used when the skb is eventually freed.
With an emulated device sending frames filled with 0x5a on a KASAN
kernel:

  BUG: KASAN: slab-out-of-bounds in dummy_timer+0xade/0x3f00 [dummy_hcd]
  Write of size 1536 at addr ffff888105821202 by task swapper/1/0
  ...
  Oops: general protection fault, probably for non-canonical address 0xeb4b474b4b4b4b4c: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0x5a5a5a5a5a5a5a60-0x5a5a5a5a5a5a5a67]
  RIP: 0010:skb_release_data+0x36f/0x800

Only skip the header with skb_reserve() once the frame is going to be
passed up, so the receive buffer always starts at the beginning of the
skb data area. Unlike the old pointer adjustment, skb_reserve() also
moves skb->tail, so the two header bytes now count against the buffer
size: lower the length limit for the 0x8513 accordingly, otherwise a
pkt_len of PEGASUS_MTU - 1 or PEGASUS_MTU would trip skb_over_panic().

Found by code review with LLM assistance and reproduced with an
emulated USB device (raw-gadget + dummy_hcd).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/pegasus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index aba1a640fc26..7c7d6b69998f 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -461,6 +461,7 @@ static void read_bulk_callback(struct urb *urb)
 	u8 *buf = urb->transfer_buffer;
 	int rx_status, count = urb->actual_length;
 	int status = urb->status;
+	int rx_offset = 0;
 	__u16 pkt_len;
 
 	if (!pegasus)
@@ -510,7 +511,7 @@ static void read_bulk_callback(struct urb *urb)
 	if (pegasus->chip == 0x8513) {
 		pkt_len = le32_to_cpu(*(__le32 *)urb->transfer_buffer);
 		pkt_len &= 0x0fff;
-		pegasus->rx_skb->data += 2;
+		rx_offset = 2;
 	} else {
 		pkt_len = buf[count - 3] << 8;
 		pkt_len += buf[count - 4];
@@ -522,13 +523,14 @@ static void read_bulk_callback(struct urb *urb)
 	 * If the packet is unreasonably long, quietly drop it rather than
 	 * kernel panicing by calling skb_put.
 	 */
-	if (pkt_len > PEGASUS_MTU)
+	if (pkt_len > PEGASUS_MTU - rx_offset)
 		goto goon;
 
 	/*
 	 * at this point we are sure pegasus->rx_skb != NULL
 	 * so we go ahead and pass up the packet.
 	 */
+	skb_reserve(pegasus->rx_skb, rx_offset);
 	skb_put(pegasus->rx_skb, pkt_len);
 	pegasus->rx_skb->protocol = eth_type_trans(pegasus->rx_skb, net);
 	netif_rx(pegasus->rx_skb);
-- 
2.43.0

