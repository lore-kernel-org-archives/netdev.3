Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE7B275AFD
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 04:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786941139; cv=none; b=BRQq7OmUGJJ4SOScnxat9dD/Anz4PlfEVAwEWNKSu1+bZPfQciTD1J/0P43/SrK+to2JEgAxf3+IXvSf/fguuUyLUXJr1yvCZxFQJo4rP1rkprcrYrBwlUw0+hY/73TJhOI0K4irsxtGKfaMiaGomYoGJrLzKGqkb7eo/rdYvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786941139; c=relaxed/simple;
	bh=sqsToIPQilvysXv8NKykHueDkEcBewEOF9CRoMnm8rc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pprx9OWMX0k94NlGu3BS5Y4XcYjID6FPqOx2xM1/S0ec5zSQUaRcoaljHRanG1RmMcUQzHODiJxjzU9gvy5V0qMPBO+jv6EDZk2Q8hq1mS6Ya7vMR6Td3NB8AvF0BGOEMcwlFW7/nbbeNjLi+Qz87BQAlOMITY46AFhbLGcvP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0qAs5f6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0qAs5f6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2969299f8f.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 21:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786941136; x=1787545936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uj3EudBSTWdM9VnNGeDbLYrQoc+1vLbVkReBzm+LJ5o=;
        b=Z0qAs5f6u0SN6F6m1FH4aIulcVP9FJN/vc7Ar0lMxcUsT3SA2e9BEsDxZv7d8PnVHX
         GBsY9bpBW9xVoaEyAGawYFcigzvqZqCqCGeKaKyaZLdFYEVV1B38a/d8ib4LvntO2bvg
         eIA8s4w0xTbLGImNwi9vRN3jvUd8gvYB3SZEIKXfod5TsV6u2eu4TOS/weUqBVyrorwG
         NmE6t9ZJYEXJxFpw2xMoILhBt0KwxWH0vRPCE7K0w7wtybvpd/4htjCTJ+FCrBMc4LCU
         y6TBD2IPKtzPwAJ7jD50wxdKsh8PlHNRgv9+DkXVMuXa1l1RSEaTzLtfCjCtgIj2r0Sf
         eOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786941136; x=1787545936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uj3EudBSTWdM9VnNGeDbLYrQoc+1vLbVkReBzm+LJ5o=;
        b=UJR4VgJROyov58Larv2UBXB2zVj0kUstKsY9qYmeM326cA33PZeAVwY51mEkpZpj9z
         Gu8RT02yYdrY52BFszlzuJCudHZB9RaaDhPzPuZi6tGMjkgyqWIqgMCgZYMyzvrp6QTx
         zCK4gC7l9f0L7oJHXsQ44iOj1awFCSvvVoO+vDrL3iKXC1TMqWsveorszX1xaGuO81ta
         3qp9VPxC34JujmXTHkR/r4JEzttqTOLoUwLck5lxKnsD2TqNzoOIX7DoeoKs/r6QL1p4
         0Jc3vuFcovL1+G9CNxa2Es1f/v7Lnba5WfoqRHxLH1NVdfwD4+rQPZVfTuq0JIEMCgVk
         WJ1A==
X-Forwarded-Encrypted: i=1; AHgh+RqmqXUz6k9ExOb4wuyDJicVLmozw4DnbQH+Z7A5G3flKypCqwd8gKv+LZMSdXfoBVjpivr83Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YznTX9PeAys/MDOMHiY85/e34/RP2U3AdXtaRDhyud1sd/g7hna
	xC224NyviXJMwXy6E6phtAEKw/AwKvugTVDUn3+qPBbFDHSU9jrWmoZZ
X-Gm-Gg: AR+sD13ZM+VoW7vii1pAaJX0v76NsfLMS48N2KggShqvqsrjwy7Sba+rVIOUUjVeRsc
	7fqpRWZ6AtnX6UOoC4ny44HpP/WHuLCpghkY7F4snX4WjfXj/R7tackVxnRAZmgidy5Uzhs/GMY
	RXheC5HJOExtByK5ffEv104sgZ8wQXQHwFH46caVmoQgomXvJroUmQA9g7d9wBmisYvWqyDcaF6
	ClcDVHYKjTQd1ah/bjjAKV+cdipuBtx0D5G/TQ5IuwQoeavV1b5/EMRBvm1wH2ZATYsC5GTb+qM
	0S+OffPrWLzfj0Duov0hObQrSWGS7U3CRgPtxyuff1BfR22SPC3C6Y4VMmckXTezimhxCtPKcLF
	wfNX773FATe0RUnE+NPO2FnCTmsyr/UMgIB6dSNkVEC1qR/zSj1dt8d8/hr4bVO5zW1mSklhmj8
	piQyVrDZK1tcnFBMyGeHe/VQmhQsLynKZyK6/D6w+0Q0aN8s4nLBgzzXsHQ+kFc4/AbBUOfMh2e
	xxa9B6hX0i/QO39fLurxnx+5OVrst853JNJtKUPoApBH8sDOiuD5Q/xuk0hjso80ztvv3YMnbH1
	56zXuHYTfDKsuW54CZZ/JuMaxiIwleEULFCvMYE=
X-Received: by 2002:a05:6000:41cf:b0:482:96bc:3717 with SMTP id ffacd0b85a97d-48296bc37ffmr21474458f8f.21.1786941135933;
        Sun, 16 Aug 2026 21:32:15 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-219-094.95.114.pool.telefonica.de. [95.114.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a315bfsm540465f8f.1.2026.08.16.21.32.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 21:32:15 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] 8139cp: fix Rx and Tx not being disabled in cp_suspend
Date: Mon, 17 Aug 2026 06:30:57 +0200
Message-Id: <20260817043057.20099-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On QEMU rtl8139 model, frames that arrive while the interface is
suspended still end up in the stack after resume. With pm_test=devices,
which keeps devices suspended for 5s, 200 frames sent to interface
during that time and 50 frames after resume, eth0 reports 113
received frames.

cp_suspend() is supposed to stop receiver and the transmitter, but
the mask is wrong: (~RxOn | ~TxOn) is ~0, nothing is cleared and Cmd
still reads 0x0d when cp_suspend() returns.

Use ~(RxOn | TxOn) so both bits are actually cleared.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/realtek/8139cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 5652da8a178c0..9016527e229ac 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -2066,7 +2066,7 @@ static int __maybe_unused cp_suspend(struct device *device)
 
 	/* Disable Rx and Tx */
 	cpw16 (IntrMask, 0);
-	cpw8  (Cmd, cpr8 (Cmd) & (~RxOn | ~TxOn));
+	cpw8  (Cmd, cpr8 (Cmd) & ~(RxOn | TxOn));
 
 	spin_unlock_irqrestore (&cp->lock, flags);
 

base-commit: 3eb40771c00a8488fa6ed2cc1fe203477908bf38
-- 
2.53.0

