Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25A33EB0E
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784360221; cv=none; b=hEMXIYK5oZeqawFfkV3y3GjO/VYhNLdMngq/oD6U2usef2+H2oIEMIB88BL1EV9RgZH9X5Gz39YrSIuzYMpSnENPaVVzSRewb/ToLg4RxKCERLUlJuaAqQV3SZUZRSPUgUsnKhFttudhRpsT7hHEzHOEs6oDoTx1+Pk5iRyMRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784360221; c=relaxed/simple;
	bh=1DCFoJBf2Vu21tPTt/j0CZEOQLEYjeE7HwekksmZYz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUHGsg8pu1NNfMA+mmCV83GXgsLP2/ONyWohh9S0dF9N5OTkTpAov84+webArfcUK1B9PVCULiizvIzu8PJdXUUq2jRILQIcwsCQwwLOeU0goXq2mZSo2E5pK0Gcg8mrqFL0DvAkydBf+gIk+OeHEgz/kEN/o2ho9HzyO0QuCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXbRrohc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXbRrohc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf27856f9cso27823785ad.2
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784360219; x=1784965019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLt3z/YLewySScLqKbA54lMv7v0xl9mubgztEwsCZ/Q=;
        b=qXbRrohcSI/isqvPSe84qBFKmAeLkiMlX5jD4Efm/Bh9QU4mSZmv0McWEMrS+OA+k/
         z4bHtXeZPDdyc0+VAdi//pejeQwuygb5eBgvyBt8z/1LAEy8ZXduOmJJIhDoT2VsKBQE
         dozEekheuQMpnm3g9BrH6/GGUTid16KpeDg+TjdEcSNx6oOnhG0UYwWo1C7AOjC9yxBY
         z2LaaTzxCFdYZZaiyFRMpll7r8frjpBEy/nggCePEFopqCjIlX2/HZ4BY2JMSkHVur2u
         NM/x9dJm9YXhvSDA84D668p3zLjJh41Jap0dW9+dQg2shba80YxCe2uvUn8gM190lQdl
         7U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784360219; x=1784965019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLt3z/YLewySScLqKbA54lMv7v0xl9mubgztEwsCZ/Q=;
        b=SX5FwjGXXv/YijCUNTVEZidalYrahCCv205bhdMUcyCc44idBTDthUxbVaqeVIdgyW
         jRVQe4dzbZnXuP7k9Y/fnQ3MPVqo7mw6siYVETOltFeF512vqVD2scFkYwwngGhpiw6I
         yq11Hr8K94W0rbwZ1TAWdLJgWEDLEhjJFl4dfFIOAHMu6B75lPB/GsUhtVGqi7rlyodj
         lV3MBJoacXcWSKnUe9eZOf1vA3khCmcTGMQoyfI0DZR44QELkRJos7Nqr2xXJgCMTrNj
         wf1G/ZLiKJWO8dNpI4B1yASBJrRbQV3VJrhbmkBgAcLxfdFHJb3HdWPGXJRkzqVgpHRD
         1NpA==
X-Gm-Message-State: AOJu0YxMRh97Hq6z2r7TkKiRS/FH1+tkW4v7Q6V2qSAFLc/nUSzqKuBH
	1QqHS9V26fixizdZW6vZjSdczWwWYS1zqL/BS0b0AyXboTwpPVOAsOCzqeg/xu4cu1k=
X-Gm-Gg: AfdE7cnPLb9MSbbxoZQdPTHTlFXyF5IDwG2c62OupXU55SwxP1p4i22RVz5meCutsHn
	PSJDMpDc1G1NYTnW8UHNb0+wbv79qwgysujdsDXSlsMnHn1eTjejrTc4F/SsTYYVMezqdhlbmO0
	XqBDfmsDCd3ACHuv7lICfJT8vRZsPOryM1RJYpM1SdC/ZchecNK61mqprZnuQIcO/HzHgNray+w
	nahVuOMAEyEBdLcXMUm05YJR+tOsw9pVtTlR4D49jX+u8Go0L1ykudcQ++sBZIR+OBfgy1PSRdt
	tsBnYpmFGow06adejlXHoYxKZEg3C2cRuWsLSBcoy/ypGeuaOYFESFJ5v+6YPN7ETpUwfhdzqT1
	eIivRp8uUoT3iR6owLrqHh0lhX85hk2pgHeBr5mJx0OA3qvZms4QJyw7rND0RP11aqHRWS6gmxg
	32+ZXHqf0WcNQs8g8mig6wep6FmJxwAQi2wgJJPgUo3rbTrg8wzORD2BI=
X-Received: by 2002:a17:903:1a0f:b0:2c9:c18f:7446 with SMTP id d9443c01a7336-2cf34948967mr69058225ad.27.1784360219245;
        Sat, 18 Jul 2026 00:36:59 -0700 (PDT)
Received: from localhost.localdomain ([121.166.4.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347166e6sm23494255ad.59.2026.07.18.00.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 00:36:58 -0700 (PDT)
From: Sungmin Kang <726ksm@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net] net: slip: serialize receive against buffer reallocation
Date: Sat, 18 Jul 2026 16:36:30 +0900
Message-ID: <20260718073631.1674-1-726ksm@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sl_realloc_bufs() replaces rbuff and updates buffsize while holding
sl->lock. slip_receive_buf() reads those fields and writes through rbuff
without holding the lock.

An MTU change can therefore race with receive processing. An MTU shrink
can expose the new smaller rbuff with the old larger bound, causing an
out-of-bounds write. A receive callback which already loaded the old
rbuff can instead continue writing after that buffer has been freed.

Serialize receive processing with sl_realloc_bufs() by holding sl->lock
while consuming each receive batch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sungmin Kang <726ksm@gmail.com>
---
Testing:

Before this change, a generic-KASAN guest reported both a
slab-out-of-bounds write and a slab-use-after-free in slip_receive_buf()
while receive data was raced with MTU changes. A non-KASAN build with
SLUB redzone and poisoning also detected cross-object corruption.

With this change, the same KASAN stress test ran for 180 seconds and
completed 38,137,741 receive-writer iterations and 216,165 MTU changes
without a KASAN report, warning, or panic.

 drivers/net/slip/slip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 820e1a8fc..faae711cf 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -693,6 +693,8 @@ static void slip_receive_buf(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 	if (!sl || sl->magic != SLIP_MAGIC || !netif_running(sl->dev))
 		return;
 
+	spin_lock_bh(&sl->lock);
+
 	/* Read the characters out of the buffer */
 	while (count--) {
 		if (fp && *fp++) {
@@ -708,6 +710,8 @@ static void slip_receive_buf(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 #endif
 			slip_unesc(sl, *cp++);
 	}
+
+	spin_unlock_bh(&sl->lock);
 }
 
 /************************************
-- 
2.49.0.windows.1
