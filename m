Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1E3A48ED
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352896; cv=none; b=jxv6q0vD7sh9hHImx4uGWRx7X2DoWUoWcQbHmcGnU6JL9wH9e+ZE1FL2dFW4S8c9lrU0FjKvkVzm/ZNkQrBmXhHKSUTBuw9er2So7Y8AfGUqyffA7e/rVIn2tuOjIkt2Cv3a1syXpCNImKAY4LGGFs1vcdiMI1iUpEOH6dP+gVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352896; c=relaxed/simple;
	bh=33PxB3xOMsaOPPJKquxcOhpcyrtMV5kN4HjjEKs9NGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ixfrtVhBR01YB81918b0K4wyb4W5Ml1yuWFxNF7OrbXGPGHMf7xNCG8JU/7qZ3H7LL4pJuGN6w7kQ0L+1v5BAJcD1nGS1r20VsH1/8ednvxpc+euE2pnDqu7JiaN9pbtDYnZkqSn2BG7pCjcI7q/yjCsIS7DICy1tfPEKYStvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngjM8N81; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngjM8N81"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cab973140bso24014995ad.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786352894; x=1786957694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s87mpArnJrBaRlOD42LLOQjBJTZsxs2th2G+gHL+3Ak=;
        b=ngjM8N81hs3D9275+WHY2zoKUFaahSgbA/9VyT4rrudO32aGdPL0tsw+4i+N2HIgP5
         OKYy67Q+yQ0v83U8TnNE2yhLDRv9Le8rWMeXHxfP1S9hFkel2hJdXUnusTVBXzDeUVzi
         87NKIeq4sTSKRSTz+yBnSXvw7zttjWr6i3wC2FcS6a+UiEfumf2PUYlcWudWo/LM3hi0
         9Obb8HDNifJXLojnu8iVR87IRq3zba1s6mVic2LDdEDrcXVo+NPSqq9IkwwQPbgwJSYu
         ZMfZ8wgBFg1s3naghr29qlsHTNbdl+A0nRwobNhENNpzj4Zi0QkMl7emg3yZM8oDnMEL
         9qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786352894; x=1786957694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s87mpArnJrBaRlOD42LLOQjBJTZsxs2th2G+gHL+3Ak=;
        b=KxaJgI1uZYNn0DkLWPV3yTrnM7fUMrUcAHNoSpIrJ1Es2iDuXAxGWBXZY59QhaqOpU
         rhohezbzJCJMUyUS5EoLmL39HYrO3mAgWbrWVpAkGB/uvqF9piswTRtboZrAdOvepxVX
         7ASYfvUle+zb8zXIEXODQ5s9gL9t7OoxipdJuwU9nDmS1gggk0MYsSs948zilIlgeN9t
         lq9sO+pF0bSPYEGKWnCieNmaydSa91AOHGFNGXkQezr5XneCfmayAEKFaAwRAV7fpNay
         OCRL8YsNZfn4JXZcgyWey5ZZ1L+WnNIhsYAAvLx/KPR7qX8NefK+VHKQhmvpw6a0IcGE
         x6ow==
X-Forwarded-Encrypted: i=1; AHgh+Rrh0Oh+QZYJaScbq+B3ghT18pvXB8PohBrBAsem8KEQHuGaGZxsDNVRH3SOBjg846TPCVxLYrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywylk+KgC6RBCjtboKczRf3CweJ7Wyb/FH3YtDGciDw2WhWgw0h
	BWlMOGYjz6hpAz9ZhlzsoFk+mQ0ZT/myb/opxHmBJnWIKpsoC9P0iwi4
X-Gm-Gg: AR+sD130ac4zsDwviWTEGU2pyBrlT2haZFGAbh6nWRr37C4IqAaNwRQkChKQj51bDUe
	bFN38rz3guUhIoDoQNSlWi7DXrQssSEy3BsluHUPJxW4xijs8BaFi8N0SAvouwRMlQtUGnD/aCk
	T4qfYUuwUCuijuOBtRNzXRE2ekzUvHfMHkubvbbhU94RBTNDyNn5RuqTl33vPskC4KbGGFzd6aw
	fmv/ooG1dUwbN8bBF5ubRBm9z5+uN3nkbUZit8j1tmz8M2LcJKONao5b3G0vCVvpTBpFzVgLTJR
	T6sRIdxC8fjUz/aNoKnUc7amzjoFdlUuYeuTyG5TEsEmvEDgspGhCi7EzVQF39UnFQUlxOtP9aj
	rMWyfLnYIQjRvPNofOVFT4Dvj2bn0hKhXzbI6A2zMyPzMjz4IZOUS7urglTetZAndT+h3VSLF9j
	39wxXp1bgLgWq2hcr0zHCedwng4+8Ufa6FHPmgeEFWZ6ngUYw2HfVCSlI2vwaFgSA2ehPw1hjz2
	Rz2YF1jtbZw+ezmUQWE/C/VoFk=
X-Received: by 2002:a05:6a20:1602:b0:3c3:a3f4:5485 with SMTP id adf61e73a8af0-3cbce6cb2dbmr21537263637.6.1786352893987;
        Mon, 10 Aug 2026 02:08:13 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8d60f4sm41132755eec.13.2026.08.10.02.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 02:08:13 -0700 (PDT)
From: Malathi <malathi.a2000@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Malathi <malathi.a2000@gmail.com>,
	syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Subject: [PATCH] e100: fix shift-out-of-bounds in e100_eeprom_load()
Date: Mon, 10 Aug 2026 09:07:46 +0000
Message-ID: <20260810090746.206290-1-malathi.a2000@gmail.com>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Malathi <malathi.a2000@gmail.com>

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

