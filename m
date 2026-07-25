Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266919F137
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988723; cv=none; b=H4i9gnjwk032wBIgu3o/gnRZhoEzPKYI+N96+IRXtmQoXeji/qIyGmllY1tJZO5JU5HlOUNm2w+AkShqLHQ5Y4pxzzt6lRZL6eQKdCU5WK0N74DG2hqD1FycIUC0n336k7jC8QgS2fyObGeQA0S80btC6xZ5258kB7fRCW0J5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988723; c=relaxed/simple;
	bh=MuLZh7LAQACn92BReP+AIVmlYMaUMB7auxQPA2p1K0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4+lrFiHdvQQiZlUeemhzFiaSpylGZkxYiljAjCpxHN72GhVeI0n9CHN0U2KbSz7iARzh0Ft0UGiDnflm7ITb/AW5MFcnht1TWucLVfQ/xnsffgTmC5uxyCOSsF6ZBuhajKDnRtM9FvEjc87V4R8MzCKORNJQXHr9Tua9QVjBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9cpWLRP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9cpWLRP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4956869750eso9717725e9.2
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784988720; x=1785593520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TwzlvPfSU70NZUVPbZ3AqlD6ck5eI3ljtAqEgWA+rs8=;
        b=p9cpWLRPrzKiIJ27vZsmGLPPGbka/Yr05Mcmpq+K0o5wm7Dj86U017o0OgFQUeuyha
         zR1pQgeO7HCZSKlUDzr0wpAh4BXWKCsI/oI/I8PGxxyX/zvI8LLUnuuspij95LXdm4vi
         nx0XndczlFU0WONyAs/gZMyIorVdhRz3hDDb0A2JOCJNhjeX27N1F1Cu/IM6cGHnPjZd
         13g5uGfvUAaeqnK9tLLcwzI39PVsNMLjSssoprPXupIn2BuQtqRlBJ+gqq8q53G6Sbcn
         pGJ+2pSNbocHDLGoimT1lWLgbwTIybxtgszM2RgOEPoF/nf0mXL+5ZRf8eFaS9TQnlmH
         IeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784988720; x=1785593520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TwzlvPfSU70NZUVPbZ3AqlD6ck5eI3ljtAqEgWA+rs8=;
        b=pW8TOf1BciKofjyGgxDmSKdPLKT/eoAa6oVriCaYqtfgBFyST3q4OZ8aT0bU+Qc99a
         Pj17vR13K3SLeXiU+ugyLUqOgPj7sKjqSo6trWkTTrnv++XaT7calp+J3OhBq1l0icIY
         AhhQTTx0w+s4f9HmgnmbvkAlOLta1vPbP4uHWmlJYCjTBpCU8IIp19Sk+2BB17a/wzfE
         GnBoAhgGIU07OJe+1r29HvSjrrquZR9Sq3c2L7KilMy+JHkGfsbajDLMXIdpSaVNHHWX
         DoH5sV6mE3GSa/wuP4K/AfQgnu9QqcI4Ql3RXRAMEmsnQezzrBiW/1PpijGm4Q//hrzH
         xdvw==
X-Gm-Message-State: AOJu0YzuBjDGnXozUQKgjQYp5stt+Ava/eNzJVJ5Th0igQ/zls21aijb
	iTO7xYqn9TnOPLQvs6saMp39l4Jpe2Jf2J3tWpnGGAoX0ezqlMPzlin1w9O33kZHLpM=
X-Gm-Gg: AR+sD10it7BqlxgDPYWVMUG5EStzaAFvGqNa4pndX40gvsak6U/nN1LK5kKSRgS0glD
	13O+wI+1lf99KEcMwy5IsHoby1jzbxne/BfGQbmSQ8rL+LT8UR5xMfzkAudeBeDGX/JF6grs7+5
	1nFpyRWrRqtOi17nA6esEcfYQKBy1s2zZPWkhxUd0krO2hy/WmujTcJoHhwphJAM2S3A6FGp8/d
	2bAXYi7If1vu/GphsGh6yD6TGyxMh/vBnFtuoFrl0vh43jVAaq3V/mJA2druDYYmi02f65cQhvi
	7PpoBrh8vtk0iLhWOeLohbmddi/6J5BevoV54elZSlWt6hXp0HzxP9swPrjAWg+VifXc2QO2k8q
	vg/oh14HvuBDxYN1u5KXurmGUqCHwAILOPFPlXyNXEw2Fb0qqNe80m1Btoi7++g11ZrPkvWKKsr
	u7UripN8Y+
X-Received: by 2002:a05:600c:35d5:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-496b56f385dmr29381935e9.13.1784988719869;
        Sat, 25 Jul 2026 07:11:59 -0700 (PDT)
Received: from archlinux ([2001:861:79d1:d140:7f91:4899:f5d3:d30f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm33542985f8f.6.2026.07.25.07.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:11:59 -0700 (PDT)
From: Ronan Marchal <ronanmarchal29@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	ronanmarchal29@gmail.com
Subject: [PATCH] net: niu: fix potential buffer overflow/truncation in irq names
Date: Sat, 25 Jul 2026 16:11:32 +0200
Message-ID: <20260725141132.408317-1-ronanmarchal29@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building with W=1 reports a -Wformat-truncation warning on
niu_set_irq_name(): the "%s:SYSERR" format could be truncated
because irq_name[] was one byte too small for the worst case
interface name length (IFNAMSIZ-1) plus the ":SYSERR" suffix.

Also replace the remaining sprintf() calls in the same function
with snprintf() to guard against buffer overflow, consistent with
the rest of the function.

Signed-off-by: Ronan Marchal <ronanmarchal29@gmail.com>
---
 drivers/net/ethernet/sun/niu.c | 6 +++---
 drivers/net/ethernet/sun/niu.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 88df15e6dd74..54dd7281191d 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -6021,11 +6021,11 @@ static void niu_set_irq_name(struct niu *np)
 	int port = np->port;
 	int i, j = 1;
 
-	sprintf(np->irq_name[0], "%s:MAC", np->dev->name);
+	snprintf(np->irq_name[0], sizeof(np->irq_name[0]), "%s:MAC", np->dev->name);
 
 	if (port == 0) {
-		sprintf(np->irq_name[1], "%s:MIF", np->dev->name);
-		sprintf(np->irq_name[2], "%s:SYSERR", np->dev->name);
+		snprintf(np->irq_name[1], sizeof(np->irq_name[1]), "%s:MIF", np->dev->name);
+		snprintf(np->irq_name[2], sizeof(np->irq_name[2]), "%s:SYSERR", np->dev->name);
 		j = 3;
 	}
 
diff --git a/drivers/net/ethernet/sun/niu.h b/drivers/net/ethernet/sun/niu.h
index d8368043fc3b..676d31499ac3 100644
--- a/drivers/net/ethernet/sun/niu.h
+++ b/drivers/net/ethernet/sun/niu.h
@@ -3262,7 +3262,7 @@ struct niu {
 #define NIU_FLAGS_XMAC			0x00010000 /* 0=BMAC 1=XMAC */
 
 	u32				msg_enable;
-	char                            irq_name[NIU_NUM_RXCHAN+NIU_NUM_TXCHAN+3][IFNAMSIZ + 6];
+	char                            irq_name[NIU_NUM_RXCHAN + NIU_NUM_TXCHAN + 3][IFNAMSIZ + 7];
 
 	/* Protects hw programming, and ring state.  */
 	spinlock_t			lock;
-- 
2.55.0

