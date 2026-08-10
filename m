Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187F391828
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343937; cv=none; b=L2I9yqLUZtuVAOl0If/HOnzDNo6cZbo12UXLhDdJ7AN+f4YN5Zm8FyEvAW1osY6S6b03/izV9Ac/KQ7uKSoJVVe/ZE0iEH9960UImx3CMoAyB+LFWA64sQxbLzD8AC9LnIM1kuiiNvTztZtDtqKzcge7TXOKoGDq3o5tpV6i8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343937; c=relaxed/simple;
	bh=eOhyBaxVU3H5GsJyGAc5oPRoZW7pggT5TSaQxAt2Px0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NI2QNbK95PzezyLDL90aXxKUZBkXok1rUMpZh/OX6uz5hxQR7N7L9551faqwPALPkXcsv0OofePlMAKQXpsHB+RuItBysLLUcsHsLGVOYR2olRVk/nNm1Hiy9JcSPM21Rje26FPumcBC/e3+TDZ9aWHuQRHYblpDTAt6b4zTD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqK0vVyf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqK0vVyf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d049069377so12058665ad.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 23:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786343935; x=1786948735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cQPgo7/ImwAyna2sJScM9HYP43JmyinkJZImCKBlm+8=;
        b=CqK0vVyfiHcyBjSGlMVyRksfqw10qeiLe4vpUKJHI1wfNltlUuVHdMfQMVJd7e6/ER
         bUaVkkz5fA2qHPpUQZ12OWg79iF/WtZqxkcnlIrYzcz7tXvGtdIwzbevE+kwhVYcsM6l
         qeHFfoG/pEbaj/2TT6bEHbxiKhyXmUY2fM/1RcMGkBeQUI+Mhm9+P3UA24RVfivNRId7
         YjKVwfKQlCtLbdXbawYINSsqGdvnpgNwwrksCp+O8QxXqmcb1u7c8cEtVyAk/WZiRl7g
         ZpE2f8RU1dqDOSJ1kGdQFOqDVWMUrVFgkv35OC9jqJPogVyPMFLDSQmzGlIn8rryaP7b
         9eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786343935; x=1786948735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cQPgo7/ImwAyna2sJScM9HYP43JmyinkJZImCKBlm+8=;
        b=Wyk5n+bPfHM4fZ2dMVrLtNObMRCFJzhYIa4VUd271lp0omfOxzBpu3sqcdkvT8/meB
         UihWlZzjTnSWejWbIIXjfKeflKhPFJsq8hE42OdjaCE2/Fmp9CAj1rSmiQlMxBQPfTag
         J4p9WXX0z3EhLFI6MQHtQOqlOMzc+n+aVHLVIsvzdFR1PWTyR1iLGZg+S9tyP2TMie0/
         YPBVs6o6k7kN78RZtVCi+hLjPXmZIm9Nrx89AiGFD9OKI7Uqb1hWT4R2zd69flXPDo+V
         hxJdpCf2wqNihTy6NdBzz36m8s9iknZu4X8ekSPFjgb/Kh/GeaQTKdNF7QQNx3CMBPQw
         oiIA==
X-Forwarded-Encrypted: i=1; AHgh+RoYpx6+fHaoGG1zzIm3QMhx03Kwi9c7nvw8lSrydLQ+EFSViG11z3a0sC+vAxD4ecCg4IEZPSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdIbb3JCZMr/b+hXAu5Ip7FriDHH4CTlScleOqZF/H2n2TIWN
	TAdql46aWrtre35LBvmoOzczrRAWwSzGKBrvc9wKcJ5YcPYeSe1Rgkis
X-Gm-Gg: AR+sD10CbYoGMkkgDzNEj+M5JYjip8UYhVilUSqRymzgUz9hcOienZ8N+TBWPnLr3j9
	OW/33PzREFTPRBz5YJB9srPTQBkfNkbMSALoON8NLAxyqh58cCV8ECbinxQPmnxB9jgTAjneGhG
	zOT7Q4Paj+ghYENmVtR9p3Uril20WMZbdCaPk65r22UXDOUERlaun+mT9KqklGFlXl2G+a4nzOm
	J3B6mwHECKpjEi/RM04Hms3uyrGcacZ/p9L+nkAvKbH5inQhRWR/CWFKnzMun3gvY4Fge2CMTdV
	6CrFAODfKnK+0jOZLNHqt2C0g++o821XXGlkOnSrJZWMis40zEAFakMYFL204vF10fCYHcHZJVb
	WFSTNAVt35GCyYHHM4DwoG+6EUSFrtH7yHbiAFSpgBTeyDZ0MWik28re99OFSw1BoHW1sDMSb9T
	tt0TKHY1osplboyvLHWbCbAhpluqOErR0SyMwHqBt5Mppq9sGju0cKTXdIQCXbxmhrSQAHM5A0X
	Bu6bJGz5fM0n/vAljCKfjI8QwI=
X-Received: by 2002:a05:6a20:9c94:b0:3c3:91f5:82c2 with SMTP id adf61e73a8af0-3cbadb861admr30450624637.16.1786343935121;
        Sun, 09 Aug 2026 23:38:55 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde308sm39626282eec.20.2026.08.09.23.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 23:38:54 -0700 (PDT)
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
Subject: [PATCH net] e100: fix shift-out-of-bounds in e100_eeprom_load()
Date: Mon, 10 Aug 2026 06:38:15 +0000
Message-ID: <20260810063815.151326-1-malathi.a2000@gmail.com>
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

The EEPROM cache holds at most 256 words, so a valid address length is
never larger than 8. Reject larger values before using addr_len.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Malathi <malathi.a2000@gmail.com>
---
 drivers/net/ethernet/intel/e100.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..a236273f5e65 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -765,6 +765,11 @@ static int e100_eeprom_load(struct nic *nic)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+	if (addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "invalid EEPROM address length %u\n", addr_len);
+		return -EINVAL;
+	}
 	nic->eeprom_wc = 1 << addr_len;
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
@@ -791,6 +796,11 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+	if (addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "invalid EEPROM address length %u\n", addr_len);
+		return -EINVAL;
+	}
 	nic->eeprom_wc = 1 << addr_len;
 
 	if (start + count >= nic->eeprom_wc)
-- 
2.43.0

