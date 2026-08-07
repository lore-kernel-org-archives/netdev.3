Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5AB38C2C0
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114602; cv=none; b=VMyi/oZrjgSpXvvYcemgHi9wgNVHBukgGEoUiYMvou1/Sj6c60IBc4GvyJEDbOssivBBlD7pLwMgE+fNJnPSZic7HprBmQwO+HR3tBm02SuZEa2bHlGLY8AiRmdDZKzOLBnX/xDDNaRyxsd2OtJv/jGL7pp0wHdWUxn8IkeGxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114602; c=relaxed/simple;
	bh=6pZaueqtoT6Ccmkb7FvNWDYQFHPNGGZFwXSoCh5+d4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ehMerw58VHbMNWy3YQsjPgADkfDdWIz7sfCINLPgWEX4w0lBYw+ORPL9RkUn6ip8SuR1rwY089muUIlLB3I/qGx0+CTnK5Gy1hhBKo5iYBJkHvua7O/wASfyhUb5wACupLn+/37JhmpC23PuSUK+Wy+ittnOvB4LV5QezgIXMBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbMJRz4Y; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbMJRz4Y"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so2071033a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786114597; x=1786719397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tkpFr6rG5lBoCbq0wNytvjoTRlryXvJyiJH9uY9WWYY=;
        b=SbMJRz4YQEkjob1b+jPNpOj93PmzJsMdbRlZXlUF6VkcM/JRdyWrkLOANvGuFIcpl6
         S5U6t+XhQw49fhNo1YrncwTtmrDa50gzCvVyzmXqK6Jlf61cEsjB+3exMpm3gGP5kEqb
         da5cmD7IliG4NCnwbxFM9/IT8/Mj1KflHmgngXC+x//JQ285YKn98SLfoXCZyeVlDLFs
         6h1/Y/vTMljvNXvFKebz7x/DaKsX0TysS3jEKqcKe0Iv4ZFHYQuy64PykpGGPNJUkzcO
         Svcy5s3wluGpFSfkEIppwdWCWZi0XaF7uq1zMWXI8ekmC5o1tmKsysanoWTXGYuA0YSw
         kTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786114597; x=1786719397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tkpFr6rG5lBoCbq0wNytvjoTRlryXvJyiJH9uY9WWYY=;
        b=X6UdGmfwhZfNgvsNuJblY9ODnumgplLHlShlHeUwo6KXRMjtNcdX/KUiu3TCr9A/fq
         Zvldp9tECmpn44Z8y+RwxewIaVfBKIlfPb48K460s3K6Hgok8yNc5izDQSbf55sw06la
         guozXQ7BVC5LliyciCahjliBZSiTYxFEzAk99tlKglTuXrLyLzgTQIJr6lEIJeK9ony4
         uUnTEStVhqoJfJJ+aeVseAn7tcidLNsorjqLgrY4We1Q/tGrTtQ249nbNNbt7IEzAU2p
         qAyL9YqEn5vdhx4GjmH84kQR700vh1e66zsa+237tz/TarT8PArEZ6okl16z2X5Wu0Dp
         fZzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMJyFvusXPcc9damDQFn6bMFWeOD24zF1MrE7sl+iX82LcZ7eIouKNlfvImJkJ2uNvq1epKBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6PsBMJSYsuv4m9EpmZzlv0pvGkJwGkYZFty1fcQdpG17guYN
	FNZHEsmHnIu/hDNSRAcigni7W4EW0LVQvv+DP6QMua28UuleaTa3Dh0+
X-Gm-Gg: AR+sD10/5OEe3cF3Atg7erjd4BjOQd4yK+Sz9LSIGFnM0TnldhVtjQyfv/IbhAWRIsX
	yZx4Erxnsc1RG+1T9GGU/jy3GqE/WDJVNue465AonVMmej05frO2+rYkHUhekQQAwGstuAB3+zI
	S8/FwkZugQlW9J4dGomLdIRxVnbCbRWJIVv2EcbZta6hzRLOw7bQTptcETAImiJPXBhbxGpbfB/
	s7WPhGwzFIjKaL79zlHVmzO+3hZhFqpAAVdneuOBS5MBtui2nV0T2TI+PKbvLSWWWsl1BPjjwu7
	LWnnBHUVyDf7yC/4c1kWzNAtm3XBUFHFEnB28WTdVRyd+KrESa4OqgaUVxnN0dzO5kAbBvEOgqt
	m9Qh06vxkIO4QsJyCTqS4eWK7iCfFz8rK6GBgzJ+mhyZLiCYeF8BqZTQKiKVr0oRJ1zbqiClMq0
	+yR9Np9bH23y8Lo/T1sysaxoxZcJXQWridxRLA8YOpAJpelQnwZNW4hi9N0mtYc2rT41Y=
X-Received: by 2002:a05:6a20:a11a:b0:3cb:8eb2:acbd with SMTP id adf61e73a8af0-3cbce9294abmr977283637.25.1786114596980;
        Fri, 07 Aug 2026 07:56:36 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:782d:6a3f:587:95d7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019c3912sm11957018c88.8.2026.08.07.07.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:56:36 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	pavankumaryalagada@gmail.com,
	syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Subject: [PATCH] e100: prevent shift out-of-bounds in e100_eeprom_load
Date: Fri,  7 Aug 2026 20:26:26 +0530
Message-ID: <20260807145626.52692-1-pavankumaryalagada@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>

When reading the EEPROM address length, e100_eeprom_read() can return
an invalid length (0 or >= 16). Passing an invalid addr_len to bit-shift
operations causes a shift out-of-bounds, triggering a kernel panic or
UBSAN warning.

Validate addr_len after reading it from EEPROM and return -EINVAL if
the value is out of bounds. Additionally, use 1U to prevent
signed integer overflow when calculating eeprom_wc.

Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Tested-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
---
Tested using syzbot c reproducer.
---
 drivers/net/ethernet/intel/e100.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..1de5cd41ea0c 100644
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
 
@@ -765,7 +770,15 @@ static int e100_eeprom_load(struct nic *nic)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
-	nic->eeprom_wc = 1 << addr_len;
+
+	if (!addr_len || addr_len >= 16) {
+		netif_err(nic, probe, nic->netdev,
+			"Invalid EEPROM address length %u\n",
+			addr_len);
+		return -EINVAL;
+	}
+
+	nic->eeprom_wc = 1U << addr_len;
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
 		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
-- 
2.43.0

