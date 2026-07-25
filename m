Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5D23BCF7
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991308; cv=none; b=NwtPpzy+zPz8e5SxDVc1xJRMDsKa5VfdYD3TA9Ksq40DB1jPYDwlnsVO5LL0uF9aOZkLXLo0WdkojCFw4VhserWibOy/r8S2NuqsDA8ZfDvCFnV7HUni/Vtr363qnT7c7Hd51gysiqEZ03MdKlEW7FAxCEo9nDnddC1Tm9pePS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991308; c=relaxed/simple;
	bh=spjSw6yeJ632vB5+0y38xFTan32fRzqh6cEX15wFX8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R02bnA1+ucytgrwUTxaf/jJxeAeO4E4hcS2FBakXEOn9tJOuOVvAFL+BNrkTulEb2mrDUukAS5biXfJVkk63RCg8+DNl4StPOieRp2KkqJdDAv4DU5rW39yDyoXWyH/WqZDOIw9YTSyVLhliZotHnR3sSv9kcV3JujDfa8Y14NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4T/I54h; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4T/I54h"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso12548285e9.3
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784991306; x=1785596106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f0XuvWRktBewvvd9x2WhTr5h8Kzvho38+5X4qE2gVJE=;
        b=F4T/I54hy48dXT6AehL8/hxM59qdUkiCYSeWRIjwQT9xrNTWVHxoqxDJAgoZRPZOfo
         CB555yTqttlNzWMVd9MuqjJq9T+A5TEsUBMMBk1jyObqY4IAOa1Ez+RS3zUBlR0j/6AD
         EU+mHNJSFuQicmgBmu8tHVBVfpnEz3yttwV70gZTJqhVtsJJOK7EfymNvN9jP/F2Tuf1
         4iMH8e/clUMZzss8wJGMC5tWm8gyz6vTfYO3qY/L+VMvLVmEaTNH6fkAOhCS18CFrVVl
         BtgS9HqVTd+wIr3YzR5WbLjlqFYBuUERORn/lTxXhr53SZc+L433DTwPd9gDzkhL/0OJ
         n41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991306; x=1785596106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0XuvWRktBewvvd9x2WhTr5h8Kzvho38+5X4qE2gVJE=;
        b=IUlSVY5Hisydf2KgVE0kAkHDpz3zFSrurVVy+v629uTIl2r1Eu+zi70sDbnBQRXGRA
         im/j9Sn40Oi/L13RnI1OnLL1Afe3sDzBeAUf5N3bk+1Scyu8ggI/CNcuUv1zjkD00Sru
         cFCoLvbh7xNSwnNK5m+KbKq5qVz5xscV6fWHHwwtCrFjwcyG59l/mXpnTah3LNc32BEc
         fqhcsgUfk5LxKDPwPKvxFvGmZ7sOGqkmc0ob1uFcEKQEXuhHW8EnYJRD8UZnVviI82Vl
         NkjtpoMpV9l7qnXWvybV2pQEjNXXrOXHCOO1GrdB3kVAG/01//Z5+PExzf6nqBm1Y0zw
         ks9Q==
X-Gm-Message-State: AOJu0YwcQFkMd6AlxYd0/0Vn3ntix2CnLkfem2Rbqa2n5IGEswPA6NlS
	KGTajLyHGX8OKcs/J6eDbnfpNN7bDUUiJiLWXg+Qiym3wE+LuQdCdQSvAmhbsUhYnTs=
X-Gm-Gg: AR+sD10SPC4Ub5TLgqK8oY/yNwjD00bEP0jG8dGvJKgfq5MPWNy7ZfkSHHMNna7mI2O
	i6UNvn6IWpuzLssTPzvtr+YGUJMvXw7dKm0e+91WH2q100q5u3K3tCpZ8WWx8sPaWSzMSlW5UUl
	Hkh4qEPmWi0iCFPunYXOQIJc70RmnYGlrH+vr2EX/sbVPutPo/v6GLMKOwYzAf0+22rXT+IETwo
	+2z4j3ZjKAOgOgF0T8H1c+g2eP7s4zPu0pKRpClMN0W1QFGXSsjI3ffk8dihUpdJJWNALM5Pv2z
	Q7yk6c9/bJMopuj7ssYQITQ1oM979RWexL4qJNqGs3Fb+nLDcvxk/QQggypfYBYU+pwzwcqwRjx
	h8K99mHFjbu5Hd19OpkK92dj9iBNKHPY2Pjw0DXBwqbeyDAnwRZ9Adr+1JBtHrO7mIEvJL1T+2W
	ZwbsSH2jZs
X-Received: by 2002:a05:600c:c87:b0:495:4a34:16d9 with SMTP id 5b1f17b1804b1-496b570148amr30507565e9.31.1784991305433;
        Sat, 25 Jul 2026 07:55:05 -0700 (PDT)
Received: from archlinux ([2001:861:79d1:d140:7f91:4899:f5d3:d30f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f5f9f8sm70300965e9.9.2026.07.25.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:55:05 -0700 (PDT)
From: Ronan Marchal <ronanmarchal29@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Ronan Marchal <ronanmarchal29@gmail.com>
Subject: [PATCH] net: niu: fix missing register write in niu_txc_set_imask
Date: Sat, 25 Jul 2026 16:54:24 +0200
Message-ID: <20260725145424.435297-1-ronanmarchal29@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing W=1 build warnings in this driver, I noticed
niu_txc_set_imask() reads TXC_INT_MASK, computes the new mask
value, but never writes it back to the register, making the
function a no-op regardless of the imask parameter passed in.

Add the missing nw64(TXC_INT_MASK, val) call so the function
actually programs the mask as its name and signature imply.

I don't have access to this hardware (Sun Neptune NIU), so this
was found through code review, not tested on real hardware.

Signed-off-by: Ronan Marchal <ronanmarchal29@gmail.com>
---
 drivers/net/ethernet/sun/niu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 88df15e6dd74..37079a6d6ee9 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -4650,6 +4650,7 @@ static void niu_txc_set_imask(struct niu *np, u64 imask)
 	val = nr64(TXC_INT_MASK);
 	val &= ~TXC_INT_MASK_VAL(np->port);
 	val |= (imask << TXC_INT_MASK_VAL_SHIFT(np->port));
+	nw64(TXC_INT_MASK, val);
 	niu_unlock_parent(np, flags);
 }
 
-- 
2.55.0

