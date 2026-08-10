Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98652EF653
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786329523; cv=none; b=OVJ76mfEb7S6FWhTnJezoMQcKeYJnCG9Uh384iT3/tLN2sJmqpA/Xw7XLvzgguk+MRDW/kHWkgiMfEWjsoNBY0HPeNQjdHcsbvozvlC5GO0+Mgd/WByR0qtARrcel88fRc0TMc39I8rL5d5memOp0bwp2mGFkUzuBe/Rx1v2eyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786329523; c=relaxed/simple;
	bh=EdLEzZvXM/G7gNkB1Hy5iRpJlRp83Yy1ii/CkWKkE5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=im/xtFUhrJcnmvmIAVI+qWrhWdQmOe+VpC7GhX4UNLuEqZj/k0NKiLnne//8oladlf2KNbB4K0/L9OO3xFRKdlQb1L5uN70AXk7oOUfZBqcIn5/gNnSSgus7xNmuFKz1ANamHj75/esZlN6KrPnrD+AgV8aVFb0JjAezoTzCpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlA02Df3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlA02Df3"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38101f85591so3368340a91.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 19:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786329522; x=1786934322; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kDegMWLTHluPMcmiCBZ3NAf+0+GXLfah+jDb95TCiWo=;
        b=GlA02Df3RwzheT+uvqsrbAl3b4OuucOcUQXwJC08INMlImY/yRPg/+vRkcnXTNxW05
         9r9FnRYGD07v6NTDfpzOaA46eJ/OFyTsfr2cGHIleanY+wjHBAxzd9yiwZmJit7riXAZ
         mJbs56X66WlyxNGXkZrmf6Uyu3ASpn6oKzvIlPwSKeWQ4+wmtghcIa6HPW7kdUb1hg0Q
         e17pzDJ1ZhPVX5bLhakBNsc8NB90Soou/rVyvLka896unwaJftF+4OUarMkM84TFzA3H
         7JO9U4BtVthM/fKigXj+Gn78+8QYiSMR3k0AklWEXaXZ61jjhoODf+T/GDSlBBKjX05F
         2dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786329522; x=1786934322;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kDegMWLTHluPMcmiCBZ3NAf+0+GXLfah+jDb95TCiWo=;
        b=O37l8esSatBCnwIZCCPFwECrpAHv0zgQNvXs1BJg4cpXFS1hPK4ct9iu+uwEKeOr5U
         Rkb09XLVRNVCd4wpAYfItf1Z2qSxfyXFMokfAYahDTX1bU9a66zj7nQamxJb7iw9TNPR
         VUiD+cCWbo2GU16nmVOCOKFkRJ70K9GK53FlZJl2QMu+y+9crGN1+eg8wF+IBrVO+t/A
         iIna3GqPP7vCiH6ILXoriFgz3aAH4YX1Qnxh/JYZ/H5kZr56dlLq4+8AnUWRx3nbFIR8
         ZWOXSVu0qJCIEb6LylVlcFnaGt9BJSK5iAtmIp98wrP9tMDjDK3GlQ2bXdDolApW6ZcD
         a0aA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+2134AWi0N4jOxqlwDuNUbep/IpPnr/uTZ5nP4y3/UzZvYG1Ku++O3Cu/JjCYC46Hf8gu4FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPy3hYjc6PptG6L7sWJgsgvr7EA8jy/miHljlV4O7bNNnEmr4
	i9oUXnhJ4q4Dyun+lq2rVovAzncaRnB0NpGxmyk6nV/e2YTnXoqv9SRG
X-Gm-Gg: AR+sD12z8A9XU1pfmLwVTfKEQvE/tXFhmUtFGgGj+gXfy7HfdtridJCdrN+v2FSQSpj
	+VmIQQgYlDt/4Is8iNCu4MAkVuvYdJPKP52L4GdeY+0A2LxJ3yDkgnZHxf3Pmpmk3JLyJY1sv0n
	1pr0fK1HEkBVsybBOnX2BSX0DBvTCu6KfxtovnMdl3st2brygdAtQD7v/lLflWxzxlGhaNYPwnP
	LlA3Z/GzgNmkDPAogs/sDgKwBjcXCg2c6819jL5zbXrBXNtjKmuBInPlSLHuBZ1upKVnv66dreZ
	OP92rGXxQVBrd2Gngf5EUqtn1+1caFCiqoIbpACET3tPVtN2XQGmLXCK8J9BEjXyrZ+/qSkmUFG
	U/Q/1GiJnYIL7YDE8tgdoFF4UA3fqLo0tWu0uIfWh/852qd5ipojYdJYpjfsOW2SNylDyMOiLIb
	OTAwKqWbLJNJZKGMx7lNLioVRF/1g28IP55xMn1OBBzvY4slZh6SOjiwtuhEniAx4VdG/CdA==
X-Received: by 2002:a17:90b:2791:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-3928465bb5dmr6621222a91.9.1786329521790;
        Sun, 09 Aug 2026 19:38:41 -0700 (PDT)
Received: from [192.168.110.119] ([203.175.12.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f5b98csm12488209a91.13.2026.08.09.19.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 19:38:41 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 10 Aug 2026 10:38:23 +0800
Subject: [PATCH net] bonding: fix u32 overflow in compute_gap()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-bond_overflow-v1-1-c9ff29d76770@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBPMxRRdJSImnWogNDQsiO6et
 HyL/x9IHIUT9NUDkbMkCb6gqSuwG/mVlbhiMNqg7jSqOXg3hcxx2cOlyCIhtZ1D0lCaI/Ii9/8
 bwPMJ4/t+PPx2EWQAAAA=
X-Change-ID: 20260806-bond_overflow-ac6a6a78d6a0
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

compute_gap() computes the gap between a slave's link capacity and its
current TLB load. Both terms use u32 left-shifts that overflow on modern
hardware:

  - slave->speed is u32 in Mbps; speed << 20 overflows at > 4Gbps.
  - SLAVE_TLB_INFO(slave).load is u32; load << 3 overflows at > 512M.

Cast both operands to s64 before shifting so the arithmetic is performed
in 64 bits. Also update the comment to make it more clear.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_alb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 839f7482dc18..818c18c6ee52 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -160,8 +160,8 @@ static void tlb_deinitialize(struct bonding *bond)
 
 static long long compute_gap(struct slave *slave)
 {
-	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
-	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
+	return ((s64)slave->speed << 20) - /* Mbit/s -> bit/s */
+	       ((s64)SLAVE_TLB_INFO(slave).load << 3); /* Byte/s -> bit/s */
 }
 
 static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)

---
base-commit: 44871eadd07a7f004aa00cb87399461eea08c630
change-id: 20260806-bond_overflow-ac6a6a78d6a0

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

