Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8701FF7C7
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066516; cv=none; b=nOThkuD9CZOIgFsiqC9WdSmGIt8iA9MZC8XGt3IsAB8BuXDG4ZHEZUeuv9GSOZoHtnbZ84bZdHhF53xpdRLPPNxRAuz8HCy/etjgqL0hWw+8ZVfKpTmqI5bgFebOP6no+L4HK1ZhwjFiAmpFQnfz0QB8hnU7U3LJsiqLQWgZ0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066516; c=relaxed/simple;
	bh=TOFT+GtrMRJZx4HNyidmMAJZlZ/MBpkuAo+8r3ytcIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7v3YvVEzEEu2Vcg4CnlhivKRuPCiPEehQU2WLIpUvskQWxyE67LYMz/NV3AzYLzhzY7+PqsJ4mvTnUkrrIcIPInpDMkPyXFiGjOxeU1G497fa05l0dLrINNQHREFSDX+N/SeKhq+AKtP5JsG7H9Gd/vZ1OmBV/1PKZ2UczRkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5LICrrB; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5LICrrB"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-133466cf955so7534987c88.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 18:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779066514; x=1779671314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB8hLxgPFXR6TxheosPkUZdcss+SaUcFoZO7z76syt0=;
        b=i5LICrrBWzKoLYG9+4ZD1GMg+8kZGWapYp58PUdV5Ky/bBPpZLPQt32TGokel93TCo
         cI02+MsoAS/Qchh5E9vyupKccYZalRyOvFOYsj7DBhONoHxHuXDraeViu4808Alchusm
         +9v2cgYm+QDT5lLc2smq3u6NZkL3P5z5Am/XqYhME7y8c3bmRXB9UCUhyGm2dEJ8BkSM
         KGuyW5kIR8HODNVS34DMfXsrxvMxh3k1wkvh5caW5ziSDUSDYcKfpUG3v8f18k16Dzj/
         SAvtFU1rAeKzLtHZPuwMbpZbEn8k4MBf8QIzj5xQhlY/q2gqh9+/KDPRLmTK6Mcx84cK
         tBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779066514; x=1779671314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JB8hLxgPFXR6TxheosPkUZdcss+SaUcFoZO7z76syt0=;
        b=ict19b4DFOmo/Wev/KjS08oMUoQzesQPOHjp8inCY6rxaAvA8HvtnJlFTRJ1NxGVFp
         Zz+w9PqhIA9sy1EqkqPgK5ZT8rvNH4s2eecvhQtsPI0ptxjyYBZ2j8zU57x86bWXjUsl
         IIBKrWqcuiXWq0Cu9Tc+7eYdi8hQk02zZUd4Q7LuNmC7jwXvEDEMw+XLSqLBmEkML5Qk
         2PpussIl7wza2gPtg+WitqQBBOuJ8yiGf2PreO6iFuOmPHd8tyggiMVdYIeaO2ltAnge
         EA/sXqAd1ZLXAt/OZOU7HaoLePYRmNhziYC0942dpEaKWC4aK3FyZDSa9IJy/x/tbK9m
         hnyg==
X-Gm-Message-State: AOJu0Yxnt8zgY3iLr95LV4yePXaMEiYudX62UrKyxt0yFiJYS+QFjm9A
	BjGUA3N3w2weMLYYiROXRsnfzxX/mYRFMvqqvU0Yv9nsfuS9kUZCopJyhawz6hyoOW4=
X-Gm-Gg: Acq92OFIZL8NGPM9dxImhxr/an3fWzF5sFLVJi3fGz8/Efgfbfb/iP/m1r9vYXqBq3d
	KZnmdG5fll9FGcHluhJJ0bMKbphJU9Frpp540OuxVJWWfp5kAtZvz8ZaKbwr2BvE8u8ETv6hUql
	IwZIldEMwC7giO75kXeSNXL0Hby7UMESdiurAsc8K/9hkTfnMje0hBgFEOCNFGkF3qfLrsNcVYW
	0uMYpiAIXSbVwhNpbK29Sio/SA5AgRQOhTomsCTbVh7FAswgsNtla4FBV0ZVLtc7j4IBCOEsUln
	m8TakOMcrPVRAiYV+/fnH8sRgwEz5a/mmUMY56qGz8U6W0QQVqunoukXBJlRXMqH1yM/rnsh3BJ
	J4aqw16eFScZBvsXh5bjqViNafxqvPAyJcne2+pcm3LiAbywmC9N/iRcS38vXLzhWtw2N1ymx/L
	joCDHZ4gocNyPfJPB+sTlde+Pg+PuEEu0OO3anMUEG6Dt5aa6GROPvLWwZi69EmJBoYM8vYWSit
	8vxviy3Pm9LBpik1SOXwWUUWpOYENNIV7z8nFes0f5i1SDigqiy6yUBn96hoVT7Na37OeKIBDPN
	bSh5wgJJlWC+NMPr0A==
X-Received: by 2002:a05:7022:689d:b0:12d:ca32:5a2 with SMTP id a92af1059eb24-135044192c9mr5712131c88.6.1779066514363;
        Sun, 17 May 2026 18:08:34 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm18891372c88.0.2026.05.17.18.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 18:08:34 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RESEND 2/7] net: arcnet: fix typos in comments
Date: Sun, 17 May 2026 18:07:22 -0700
Message-ID: <20260518010739.80979-3-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010739.80979-1-enelsonmoore@gmail.com>
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARCnet code contains quite a few typos in comments. Fix them.
Initially noticed by inspection, then augmented using codespell.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/arc-rimi.c  |  2 +-
 drivers/net/arcnet/arcdevice.h | 10 +++++-----
 drivers/net/arcnet/rfc1201.c   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/arcnet/arc-rimi.c b/drivers/net/arcnet/arc-rimi.c
index 53d10a04d1bd..fb3d3565aa9a 100644
--- a/drivers/net/arcnet/arc-rimi.c
+++ b/drivers/net/arcnet/arc-rimi.c
@@ -185,7 +185,7 @@ static int __init arcrimi_found(struct net_device *dev)
 	lp->hw.copy_to_card = arcrimi_copy_to_card;
 	lp->hw.copy_from_card = arcrimi_copy_from_card;
 
-	/* re-reserve the memory region - arcrimi_probe() alloced this reqion
+	/* re-reserve the memory region - arcrimi_probe() allocated this reqion
 	 * but didn't know the real size.  Free that region and then re-get
 	 * with the correct size.  There is a VERY slim chance this could
 	 * fail.
diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index bee60b377d7c..f1947342d67f 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -137,7 +137,7 @@ do {									\
 #define TXACKflag       0x02	/* transmitted msg. ackd */
 #define RECONflag       0x04	/* network reconfigured */
 #define TESTflag        0x08	/* test flag */
-#define EXCNAKflag      0x08    /* excesive nak flag */
+#define EXCNAKflag      0x08    /* excessive nak flag */
 #define RESETflag       0x10	/* power-on-reset */
 #define RES1flag        0x20	/* reserved - usually set by jumper */
 #define RES2flag        0x40	/* reserved - usually set by jumper */
@@ -166,7 +166,7 @@ do {									\
 #define RESETclear      0x08	/* power-on-reset */
 #define CONFIGclear     0x10	/* system reconfigured */
 
-#define EXCNAKclear     0x0E    /* Clear and acknowledge the excive nak bit */
+#define EXCNAKclear     0x0E    /* Clear and acknowledge the excessive nak bit */
 
 /* flags for "load test flags" command */
 #define TESTload        0x08	/* test flag (diagnostic) */
@@ -194,7 +194,7 @@ do {									\
 struct ArcProto {
 	char suffix;		/* a for RFC1201, e for ether-encap, etc. */
 	int mtu;		/* largest possible packet */
-	int is_ip;              /* This is a ip plugin - not a raw thing */
+	int is_ip;              /* This is an ip plugin - not a raw thing */
 
 	void (*rx)(struct net_device *dev, int bufnum,
 		   struct archdr *pkthdr, int length);
@@ -257,7 +257,7 @@ struct arcnet_local {
 	char *card_name;	/* card ident string */
 	int card_flags;		/* special card features */
 
-	/* On preemtive and SMB a lock is needed */
+	/* On preemptive and SMP a lock is needed */
 	spinlock_t lock;
 
 	struct led_trigger *tx_led_trig;
@@ -299,7 +299,7 @@ struct arcnet_local {
 	int num_recons;		/* number of RECONs between first and last. */
 	int network_down;	/* do we think the network is down? */
 
-	int excnak_pending;    /* We just got an excesive nak interrupt */
+	int excnak_pending;    /* We just got an excessive nak interrupt */
 
 	/* RESET flag handling */
 	int reset_in_progress;
diff --git a/drivers/net/arcnet/rfc1201.c b/drivers/net/arcnet/rfc1201.c
index 0edf35d971c5..f2ec58d06fc3 100644
--- a/drivers/net/arcnet/rfc1201.c
+++ b/drivers/net/arcnet/rfc1201.c
@@ -235,7 +235,7 @@ static void rx(struct net_device *dev, int bufnum,
 		skb->protocol = type_trans(skb, dev);
 		netif_rx(skb);
 	} else {		/* split packet */
-		/* NOTE: MSDOS ARP packet correction should only need to
+		/* NOTE: MS-DOS ARP packet correction should only need to
 		 * apply to unsplit packets, since ARP packets are so short.
 		 *
 		 * My interpretation of the RFC1201 document is that if a
-- 
2.43.0

