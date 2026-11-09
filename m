Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222053;
	b=1mfEDGocj8r2D/3nQ75n7+2sWp3ROKg4vEB5veuTSy14Mw9dAmt6vpDsR7Gqg1IY9QIx
	 2O800BFJ1n57XrkL6PgBGqdM21P6uDKgE14D9+/FTgjuHguviviHDGKPrePy6f7JI898X
	 +GWElxmRGO/3gK2Prnxb5MWOA4IgS++PsUXxchil7V0FHuUjcuamKQZYWE/VEYxOe9U8N
	 zArKSWTzitYHMBOiG0vKXyNM/d9rDbCOg/UGkI33bzzmyCoPleNL0Uw+f+URPlmSAMpQb
	 7KuixdOSjdSc2ENYD9cqfJNg2ujCnEfdin4GWozKid9tnfCHNU7VNOs4P/CSmqPryRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4iXeY4iqUL9ww0pQAAvwhem0iOVjitiOYOwOdTHElEs=;
	b=y0A3pF+nc+8nXV+kRWSlRVoWzb9kNEAm39/NQkqfx8N/Uts7c7OnAX6kwDYrNbSTTD6S
	 iOiXqxkQgMlTFa6MxYqvqqQzEMzXJMAlVJL3OhvrGrKAuFxLikdTGb203etekCuqiOCjF
	 Q8LUaPAtut894UUmIrjFUnsLGBjW7IVEIpGpkURhztN6tlPwQ7gSFTdoRTBea8kKQLCyu
	 uZhZ8WAv0AHqoRBXkSpwr2fwwDaDcR3vJzW03fw7aPnf/X/f8DZbGEzWC4HP4sNhzISF/
	 p9vGk2deeQb/U9s+PsA0RGR4i5lER90ighrtPK+GHcu1BeFIbCMbQOKrbODXWMcplzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dgb/Ob6Q";
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFD606A333
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 11:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CBFD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgb/Ob6Q
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1931ff67a29so1897281c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 03:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794222052; x=1794826852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4iXeY4iqUL9ww0pQAAvwhem0iOVjitiOYOwOdTHElEs=;
        b=dgb/Ob6QI01rMx87etoiMX2YGgi3uwE/Sja9pTJwEvfOdLa2+5qs2+VS6YOXYKcz0o
         +MYkHXzbIujBKtLr+3+/93zEKoJg4unV/zBPOa8JTwqEAaP+yZL/T0E3hNKjKTG3BPPr
         CmFFzSFLrx62/7MGwPsbC1zVXA2mBlEbRBsAjYQV80MumER68suOgFPiQ1It04NzVpu8
         /Dto9EuhNnMIm+uR+juvruLO2NZMd/M0uttdxPkDAoQVVesrYjah6ILq3Vwu28JYsj80
         gGYqrgt1eeZK54+oMZBd3gYfSnTnv96ZQcDaAt6PYwA3wywyYtkRX8q7zQ7SF7ZKBQmq
         q9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794222052; x=1794826852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4iXeY4iqUL9ww0pQAAvwhem0iOVjitiOYOwOdTHElEs=;
        b=slaZzygBa+8OURhthKqCRPHu7QcB/g4pea1+wLcsIin1vNWGRe8GxAvcdXeNWQQlLs
         jzh6u1VH00D7seuU/gPs+2mkVMf4F3RJqz8T6sPdNkv0e+jW/Uveuw06bzIJcUt05tMg
         FXTRNNmbwywyYwSn7T9jIYZTwtLUih7cycHLTfYs1Fv6UavqYsdVBOTP19R5tefjAuAV
         iXtoMpkfXxeJKkfLehf33u7P3kulMMIGExbBG2Zq68RoFegfacs/APONNxMoCVR4ve2q
         7fMdHOwScSn3narKf5uFlx5ziehay0ZltE+0s+m5XG8HvSypPBPHl8SkSCh+ugERm1V8
         XEAQ==
X-Forwarded-Encrypted: i=1; AL+hErE4v5aBR5Upxg/DajTdhuJBcIChNOk/A2917ZCCm5bsF2EzBvgJhhcpk+1aLOxmAFVirwUO7B0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NXfqDmTD4vjGWr7L8gf6pIYhbU/+qwAlndcvcih8xO/nqnvHs
	vB+I2cCVIH5JGOyrPCb87CD5bE/N0X6i1qgW2Z0oB3oNSrfbrOGC5aXq
X-Gm-Gg: AYBFou1NO5VH4FnSLWJBX1+yHYcORECm++jAXfuKdcnqHCHxlqslSGrPdkcvt6a5BRx
	DRisdjB16fMyQfr1vFCkH8lXZhLvQtPwwFC1QVhUp+REvfYzPvF0h73pBmLAPxMo7Uh6LbUYh4I
	6pGKETZwabBCB1n1asIhycztCYUibFeO+DLuC+c0zo/kPA6eCrYZQOPPCoidqOqWuqBKW9cVYF/
	v+sj5MdRlcUfavCy6Mo7NMCiP6e8YKvyXnxkowMa2hrzxHQE754KLdsY68PTa6cV+f1JjjDdfZt
	corl+1+DZyQvwnli5X+LTlSiUgeZOMPJ9YHLOvVdA9Ykyx7gp6HgOuCPMqYk1xBNp5oLju38+uD
	wRSmIt8cTHVmnGRmfOjZG8XvKaGfCPMM4cscSc5SJ7+jgpRl3Pb3os/nPpADDpUqDUfiaOgS+7L
	gfzZ3TdNh8U5exlpS+xQECWqPdIEGQMJhiDHK+do+X+yIXRJHADmrXGbRsdKntBrJbXvCVIok6Q
	YxNgqJp6arBoyboTsV/0Ttbhs0qUIX2mnx0WBdTmPwNGGA6MuhaJ95tVEx/YUSQd6ai5Agvnyx9
	hpRSbWKYeSygEwr4TXhaZYMRNuF5awfxrdKK6NkQ6RBsdps/
X-Received: by 2002:a05:701b:2092:20b0:151:5d01:9316 with SMTP id a92af1059eb24-1b39fedc89fmr6555851c88.23.1794222052154;
        Mon, 09 Nov 2026 03:00:52 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375604109sm15407609c88.10.2026.11.09.03.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:00:51 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] nfc: pn533: bounds-check the ATR_RES response before parsing it
Date: Mon,  9 Nov 2026 20:00:16 +0900
Message-ID: <20261109110016.1511307-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

pn533_poll_dep_complete(), pn533_in_dep_link_up_complete() and
pn533_activate_target_nfcdep() cast resp->data to the fixed ATR_RES
header (struct pn533_cmd_jump_dep_response / pn533_cmd_activate_response)
and, on a successful response, read nfcid3t[] and compute the general-
bytes length as resp->len - sizeof(header). A short response leaves that
read past the end of the skb data, an out-of-bounds read; the copied
nfcid3t reaches userspace via nfc_targets_found() and netlink.

Only the success path needs the full fixed header: a no-peer/failure
reply is just the status byte, and the existing failure handling (turn
the radio off and re-arm polling, or print the error) must keep running
for it. So validate resp->len >= sizeof(*rsp) after the status check, on
the success path, in all three handlers, before nfcid3t and the general
bytes are read.

Found by code review; not reproduced.

Fixes: 361f3cb7f9cf ("NFC: DEP link hook implementation for pn533")
Fixes: 673088fb42d0 ("NFC: pn533: Send ATR_REQ directly for active device detection")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
Changes in v2 (thanks to the Sashiko AI review):
 - move the length check to the SUCCESS path (after the status check), so
   a no-peer/timeout reply (resp->len == 1) still takes the existing
   "turn radio off, re-arm polling" / error path instead of returning
   -EINVAL and stalling the poll loop
 - also guard pn533_activate_target_nfcdep(), the third ATR_RES parser
 - add Fixes: tags for the two commits that introduced the parsing
 - drop the inaccurate claim that the other handlers already length-check
   resp->len (only pn533_init_target_complete() does)
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index b0133e51dce9..9c65b52a8a14 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1319,6 +1319,17 @@ static int pn533_poll_dep_complete(struct pn533 *dev, void *arg,
 		return 0;
 	}
 
+	/*
+	 * A successful ATR_RES carries the full fixed header (nfcid3t[] and
+	 * the rest); the general bytes start at offset sizeof(*rsp). Reject a
+	 * short success reply before reading nfcid3t and computing the
+	 * general-bytes length, to avoid an out-of-bounds read.
+	 */
+	if (resp->len < sizeof(*rsp)) {
+		rc = -EINVAL;
+		goto error;
+	}
+
 	dev_dbg(dev->dev, "Creating new target");
 
 	nfc_target.supported_protocols = NFC_PROTO_NFC_DEP_MASK;
@@ -1799,6 +1810,11 @@ static int pn533_activate_target_nfcdep(struct pn533 *dev)
 		return -EIO;
 	}
 
+	if (resp->len < sizeof(*rsp)) {
+		dev_kfree_skb(resp);
+		return -EIO;
+	}
+
 	/* ATR_RES general bytes are located at offset 16 */
 	gt_len = resp->len - 16;
 	rc = nfc_set_remote_general_bytes(dev->nfc_dev, rsp->gt, gt_len);
@@ -1937,6 +1953,11 @@ static int pn533_in_dep_link_up_complete(struct pn533 *dev, void *arg,
 		goto error;
 	}
 
+	if (resp->len < sizeof(*rsp)) {
+		rc = -EINVAL;
+		goto error;
+	}
+
 	if (!dev->tgt_available_prots) {
 		struct nfc_target nfc_target;
 
-- 
2.43.0

