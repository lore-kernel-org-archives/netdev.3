Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8930DD22
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424904; cv=none; b=bNJcVP+xJz+KKa/lKxwCb5CA49MOpQv5I2yEEiqSCWNW5/EHAcj5MqpVyLO78Dj9SY06LEq0hkh3AMWUCUXizAz8kAhQd7WjLKBJZ7TBoJOLr10JAS8H1BBRlm90tsIesWj5INNlmWdDvKcTzrixyMaAG1fsfkJDmepHZQcfrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424904; c=relaxed/simple;
	bh=20weYDl+VWdcv8t7mGQ/8FZanBnhDcVeN68+vHaqeUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQfVHVMOpfizPPK/cUZlDuciisEHCRwFcda9g+i5jb+lnxc1Utdbwe62quPsU3Sfx3StJBhbeOn5sS7EEpyulInIJu18I5SWmv6RLqmIKA6b1Aum/I0EHmEuuzwLebtZwMQmeyUFVsLezvYvDkmy22dGG4pll+Lskht50RTmqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZh5w2K+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZh5w2K+"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3191564a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 22:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786424903; x=1787029703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tZtc/eD52PoJvgCx24yZu3Y7VDOIu1uYZlUVL1bHOF0=;
        b=cZh5w2K+19vDguh/TqUwBtfcMSDkuuGOnM2bXfVFC/qxxgPKN3j2UjINYjbWHOzQU5
         PbrnE4Im9okUcMAyH4Wq0piTqu08/kst3gr0LKSUT+JKn1fPmdEamWs+Qv18uObs3Tmk
         MS0xGiupXjBcUqP950YY0mbokKNx6hLN3WrVUk05OAuLYSb9KGoMJVnoyX/MTvpmztkX
         QZQRj3NM4fllWRN905sTpUFm5zVRG7rPtJtU+SzxK44SSLdRHSbO3O1y0UpwFcwST6m1
         PO2CQhhD8fAbrnCTYXcu3F6VgtN239VPF3+bqtZv24PNk6PzpbUChFZuPtOhP+0BYacM
         DRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786424903; x=1787029703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZtc/eD52PoJvgCx24yZu3Y7VDOIu1uYZlUVL1bHOF0=;
        b=rbaY2wrx7Sbg/TjOPu8BXqxurFsNY/OD2U5WguGT2Bm83ls/PKyMnkIBV3Y2+5Srtk
         Y6YoXVhqO/Ue3oMz649K0PY4PBLE5XcG30Ugit09A99JDH22hwsM5v5MVAfXA+7yf62g
         XZTVsfJiF04MS/q4oUsQfjPGu2kCM9bvECpBYMWnGp+RUR4nD2S0yTssHBYudk/72Q1m
         0SI+wQ5vLNNReN3TADH6Q//Z2F/NDTV/ssaLnvgQ/rwDQ7UTZXHK0R8ASkUDShBeRx+T
         oVTxiHI5nAjWhXOSBa4rPfZLuT3PcquPXagQnDTvH2CKiPV9Q1/m2OpvgSe9uBMP8jM0
         IWPA==
X-Gm-Message-State: AOJu0YwuFAZ/RGvHv05j4yL7bLxpWxv2VBem/0uPoVJMDBkUoS28wLDD
	Dl9ysq3fe57xkdAAoI1XXFMKoMAb4jo/2/95rdaGLVwd5RVCOd/UfI3R
X-Gm-Gg: AR+sD10ee0Bzq9crDrsYI+jeA17tCOeOH4WQAtAChehOGd8dPC+UkW+15pLUf10KaSn
	X68zOY5y5uIoi65XFmZq6Tz4havKwYqHlD2NRfRVG7muoKGBJSrPNf/ZOxCSNnzcr6YSve4350W
	Isj+PyGoxWALqGY0Nnp9vPVTfamr+gbtnG9Ke+03a59zTeWgbvyEhU6YYP1XnEPIVg40l30PcAu
	lyGh50EIhqK7R93HSh00wrjAW5jffZedmazjC0kBSSF3R9O+izC/CFh/5ErMH66Gn9jmA+Cgo8l
	bkjW3PMFCt6ARywX5jsk24kT4qQJ9n+a3AU+w4l322WBBo0E/+Re4qCfi17e19/+D2ABmjIRhT8
	X1PU7Otlp4xHunDcAGHcdC80kIpUkDN8VC+F5W95NMLIDj9Xv51KaG699fipqooti80qet6tP2+
	pmbYA7uIz40KiN9NkmwFvdxo7sEFSSqDUCNToygOOqtFRt22/z/8HpHweO2Jkw5rlHFIn4GkTIj
	tigcWB6n9mvH8x5LyOFeOfQqFhNiWWwUXc4VA==
X-Received: by 2002:a17:90b:3c84:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-392ec5068a1mr800863a91.7.1786424902737;
        Mon, 10 Aug 2026 22:08:22 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14120443418sm1389450c88.12.2026.08.10.22.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 22:08:22 -0700 (PDT)
From: Malathi <malathi.a2000@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	Malathi <malathi.a2000@gmail.com>,
	syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Subject: [PATCH net-next v2] e100: fix shift-out-of-bounds in e100_eeprom_load()
Date: Tue, 11 Aug 2026 05:07:53 +0000
Message-ID: <20260811050753.234931-1-malathi.a2000@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

e100_eeprom_load() and e100_eeprom_save() start with an address length
of 8 and call e100_eeprom_read() to auto-detect the real EEPROM address
length. e100_eeprom_read() adjusts the length with

	*addr_len -= (i - 16);

based on when the EEPROM drives a dummy zero onto EEDO. A malfunctioning
or emulated device that drives EEDO low too early makes (i - 16) exceed
the current length, underflowing the u16 addr_len to a large value such
as 65529.

That value is then used as a shift count:

	nic->eeprom_wc = 1 << addr_len;

which is undefined behaviour and additionally overflows the fixed-size
nic->eeprom[256] cache.

  UBSAN: shift-out-of-bounds in drivers/net/ethernet/intel/e100.c:768:21
  shift exponent 65529 is too large for 32-bit type 'int'

The same corrupted addr_len is also fed back into e100_eeprom_read() for
every subsequent word, where it is used as a shift count again:

	cmd_addr_data = ((op_read << *addr_len) | addr) << 16;

so validating the length only once at the caller is not enough.

Clamp the length in e100_eeprom_read() so the subtraction can never
underflow the u16, and reject a zero or out-of-range length in
e100_eeprom_load() and e100_eeprom_save() before using it. The EEPROM
cache holds at most 256 words, so a valid address length is in [1, 8].

Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Malathi <malathi.a2000@gmail.com>
---
v2:
 - Drop the Fixes: tag and retarget to net-next; the underflow is only
   reachable with malfunctioning or emulated hardware, so this is a
   hardening change and not stable material.
 - Clamp addr_len inside e100_eeprom_read() so the auto-detect
   subtraction can never underflow the u16.  The corrupted length was
   otherwise reused as a shift count for every subsequent word, so
   validating it only once at the callers (as in v1) was not enough.
 - Also reject a zero address length in e100_eeprom_load() and
   e100_eeprom_save().

 drivers/net/ethernet/intel/e100.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..26a7c0aaa6e2 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -744,7 +744,12 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
 		 * complete address.  Use this to adjust addr_len. */
 		ctrl = ioread8(&nic->csr->eeprom_ctrl_lo);
 		if (!(ctrl & eedo) && i > 16) {
-			*addr_len -= (i - 16);
+			u16 len = i - 16;
+
+			if (len > *addr_len)
+				*addr_len = 0;
+			else
+				*addr_len -= len;
 			i = 17;
 		}
 
@@ -765,6 +770,11 @@ static int e100_eeprom_load(struct nic *nic)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+	if (!addr_len || addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "invalid EEPROM address length %u\n", addr_len);
+		return -EINVAL;
+	}
 	nic->eeprom_wc = 1 << addr_len;
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
@@ -791,6 +801,11 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+	if (!addr_len || addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "invalid EEPROM address length %u\n", addr_len);
+		return -EINVAL;
+	}
 	nic->eeprom_wc = 1 << addr_len;
 
 	if (start + count >= nic->eeprom_wc)
-- 
2.43.0

