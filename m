Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3193A6F11
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350862; cv=none; b=UyHndvLkmpsQP1i+D3cRNVsWD7YqZsqS1MUBs2Exsrguc3ddnAy/kfn8z7+pJelJzi8wiTQe3vPgns4JWaR1iqfw/DVnV5waS9TfgPx/21aq2ChMDt/knMbyfWz8wzUXlaqU2NaMWdM6p5m34CnwRy7LhVaENyRzgq5WeFkIyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350862; c=relaxed/simple;
	bh=Llvu/Ofu6HBJHbIlTQ4QgrB2Mm+whGTtQvvjGGP1f9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TA6+gF5K6oz2yWEpuc2j0HvjXprPdnIaAlxKc+psLrASBax0JKU9lJleFVVyeOD+r4h4UCklBaioSDETpcjDEimrHUvxPf2S7AE08Myvk3jvh/uSKF72/CO+EfjVgYhfot8gGQ3BERJDgEzO9Dco1GIn0QSTzc8y7sD+FwALmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHEY1l29; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHEY1l29"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cea3004256so19584855ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786350859; x=1786955659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wx/dR5BeT9JtgYuBtWLK4gYFoR3mxTUHjHYo0mlT1ww=;
        b=RHEY1l29TyEFnFIDC9zszyGsiXbephwPAPZohV0WXlZvzniSZDLbGdLYBVkZ/5eJH/
         /8VyAtJTySuJqIglPx/1eDOJ5hHELWyAEhy5XqC7MQ9dEVXh1C499wy1B7oT5hr32PZp
         KpYap4GNDhec7d6CfRKX/pLtwEujiFkpP8Lx8q8m8/gPRw4VqFU1l8iCKq/aB1r5Gr4t
         1Eij3m2TrZYPcEovfndOYcbU82xKXfuiaDs2iVL5s5l2mbmA+5pNn5n9cbNxq1cY2Efb
         FdaCrnRWPTb4vdwp8RewubxGsaArrlEuvm2RdXWSz10XyqxZj1owGU5Kg+ssTTjIKmLA
         9IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786350859; x=1786955659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wx/dR5BeT9JtgYuBtWLK4gYFoR3mxTUHjHYo0mlT1ww=;
        b=gTWnkt1EqKEGqPRfpOfF7/XARznmhHxWqjMRbsWe93j3dNsnWjsdoPlSupnE6B4zDb
         3RlcxGkHmHt9gc9drtQid1IZctOPGOWDvME1EjPX5U1xODXjHUue4PxyL8tVFV9rAvFn
         8MBboCjS4KtQxbEdSNjKpvm8mlQau4BlimwVaLBznTWxulslEDOltOq4lU6PCNHDY5xz
         4gB/UjU72vxGwJRWK6brrOqekqBQrK+TSRYQSsxn5yutbu2jIa7874oSfOukXWwPdQ1N
         LwtVPIphcGkDZlYbSIqOD2k+HZiZTOrpJdslJhifctWvgI0Lonaix9QwWaN6GF/ffWoJ
         wmlA==
X-Forwarded-Encrypted: i=1; AHgh+RrHmxLjcDfxRGybd95izFHjbdp5kh6ZrwzeBUvCCp8mxCS6Xo7ExweO6dWFh5a7hasXy9dO6LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8A7q0FtgztuJLtJrjcvu5Q+5SaxIj5wGRC6V85vTnwTOfI8v
	nHLL2UFS2yCbPhf8DXPJ2B6qt/k4LSqVHZ4rnL9ot5B1iNBLPOFGn+s8
X-Gm-Gg: AR+sD13yhSxHzO8I/nMQed0RCqyJfketw2FGGaHQoxN7L/yfOPaEiFRNBg5NHQNGZgW
	6YedXZM22bb9MJqjbc+v8NNvZVfYPAI/L3+JkReYNUIGNHZa2Oz676yzNtUTm8BzNhLpi7GksuQ
	icy9PDbvfdCgjozI01gMv4J6PPZebiKvHFwBUu+MwDgDBqU0ket2lurWBOk7PFiSsTL+xa206ff
	vBC+Zq1VgglA3BEA4ZcvbyDQSVqtyZ+u68eV2PXcxbZwr24oppddKPIEEONcZz2rohoGJ6Aw7RA
	LF3y9qo6q9BnN46fGE9uZMavQLW7dB2+DCnBVqhjjKGiTDYYElHXtDxHWtpT2tC8yZYKIpm4ZFA
	xmlp2JjfIzJ7IqOV0a/TIKPhOer/QVjMvC3ejW7oDWfHUW9biwJCPZ+7ArzXhhda62A6U8Mdg06
	V5DuQkl/GUCwsN9+FrS3ezuySqYx+sjBhYT+loWKEEVEGpy62Po4pBe1rU0AQytq4oKdUQ
X-Received: by 2002:a05:6a21:485:b0:3c4:3b16:2979 with SMTP id adf61e73a8af0-3cb85f0397fmr51639254637.30.1786350859021;
        Mon, 10 Aug 2026 01:34:19 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:9a9f:f6f8:5800:36c0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebee8d0sm38776661eec.24.2026.08.10.01.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:34:18 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com,
	Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
Subject: [PATCH v2] e100: prevent shift-out-of-bounds in e100_eeprom_load()
Date: Mon, 10 Aug 2026 14:03:55 +0530
Message-ID: <20260810083355.21631-1-pavankumaryalagada@gmail.com>
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

Validate addr_len after reading it from EEPROM in both
e100_eeprom_load() and e100_eeprom_save(), and return -EIO if the value
is out of bounds.

Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
---
Tested in QEMU using syzbot c reproducer.

v2:
- Return -EIO instead of -EINVAL for an invalid EEPROM address length.
- Validate addr_len in e100_eeprom_save() as well.
- Drop the unnecessary 1U change in the shift.
- Update the commit message.

v1:
https://lore.kernel.org/all/20260807145626.52692-1-pavankumaryalagada@gmail.com/T/
---
 drivers/net/ethernet/intel/e100.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 1de5cd41ea0c..464dc2d6cdb5 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -775,10 +775,10 @@ static int e100_eeprom_load(struct nic *nic)
 		netif_err(nic, probe, nic->netdev,
 			"Invalid EEPROM address length %u\n",
 			addr_len);
-		return -EINVAL;
+		return -EIO;
 	}
 
-	nic->eeprom_wc = 1U << addr_len;
+	nic->eeprom_wc = 1 << addr_len;
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
 		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
@@ -804,6 +804,14 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+
+	if (!addr_len || addr_len >= 16) {
+		netif_err(nic, probe, nic->netdev,
+			"Invalid EEPROM address length %u\n",
+			addr_len);
+		return -EIO;
+	}
+
 	nic->eeprom_wc = 1 << addr_len;
 
 	if (start + count >= nic->eeprom_wc)
-- 
2.43.0

