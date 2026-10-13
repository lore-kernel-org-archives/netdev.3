Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955B31618C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862345; cv=none; b=I3tuS37z5xMGI4oXIWvhd7jmPs0APwJ5M6QNt8CvvuOqeAbMGLk9pKj1q54/qrgYCAu87vq+5he1eEB8oPtSVwn77ctktXXnqfQKKpfHoMEMCh58bNQ9t5kcLbiCFmYTAs9nc862iAv6PIFO4yeRZCZHiV5U3Nqp1Z8ZCNa3KcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862345; c=relaxed/simple;
	bh=mZq0yfkxI0vUOqJBAiG1d5Hp27SaDebWQ9VnPmH0EHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EiIaNB9h3Hldb6tI0tWGel119UOjvMY/3fPPFPVZ7hq8slovtAxxDynAR2y9jOVKXCNAba5xMk2Ff2aHFRWzQIbJ4zW1cPOA6YFpSao3gzAhzL26MDyjNCO6sWbStq51rLT80E8vCpBs1hHOCut6Qp69cf/lIDdCWXeUY9AUAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9dbFpG8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9dbFpG8"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8d2574fd9so11416275ad.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862343; x=1792467143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIaOslUUuQA0fJiLjrDXk3itkuEZwobsIpmCK9CnT84=;
        b=H9dbFpG8HKMjgPFD2bdZ26r+bdVGP48TnY/cxKnK1wV9lPZ7BlFjNTKjZ0DQQ7qUlH
         PB+am0NuHe0EyLZ8I/4AFt2OPul3Jd4b8lftRVgr+DBZwcPwy/r79Uorcde6E2GbexS9
         KyK5/+sRIfoHHxC/i9XIJwvRl0vXZPzFNAr2MaElRvciXRE4zNC8pstrGvof3DAuEI9Y
         DBaLOfKBHnK9gf7J7fk7J/DCoYZVVP4vck1NHJHvQDVo2Usa2fbhCfbQBRjGTBkHjRJ8
         MXleZdT8j7rnGlRar+UeHMkd9jtKZDJR0vcUzchv7fIuPPlpsWkV0pj3/VZND1Gs8/X9
         G7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862343; x=1792467143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIaOslUUuQA0fJiLjrDXk3itkuEZwobsIpmCK9CnT84=;
        b=ijazr53prAcUhwDlrIWWbd3SxmBQIh/s9Si0iVkCkBkkc+H6J6LsPsaESIQHW66LeS
         7YuUoYNlnP29+SaErOWrQefpbj3KzbkcJ4lCuplKKiS1S5ornbptKUFhqGNvbBng2/JU
         uLxQkcLY61S8guDf41+l7Wzu0dTkDFPkhKkP0buVbLFY6N6h6my6EnxUo2jkXEivUxTC
         9/rXMC8NXpCoZtZhREA6wxbUNFH4R9BuwjbxbUhewpCpg5M+HQAwPwUqi/lWi/upIT+I
         rHBv0fL5Bgh8WgdoWDl/4QmnuGsniKc1dJvD53xJh7atbQGYGVTGt7EPL6HOwhc/o5JY
         +n7w==
X-Forwarded-Encrypted: i=1; AKwUvBwSkpFcTdDAbjbTtJyWIdWPB4jpk2E/qcUkkLACQFUImu9vqOtUcUVUXhsRmwyG8zDnNJkNtj8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLt8IBaCDgZlZ1E1Vd+2M/8F/oPJkBeRg0Qw3on1LiJWQQM1bhe
	GVEZ4y9aXYdlYvZTRhebOOvIHhkey3rmYJqhWlsoTVAaFzptQkKBRhgT
X-Gm-Gg: AYBFou1AEoXTcvsc91nMZmPf7IbEG0uNiVQlDMUhykYriDDvs9RLVH+cDDu+waGONms
	M4CUXrNVcbAgAlLCI0HcMgdShsZ6KPd4cgASiHZ/YWJLr+D8bRhUqgczi/fbJrvenidzihQt5yO
	IJg5LnpD3XnNkKvCpKYwSl7NQ6p+6ILGURZsihF1ktLpDGUHzd8ApdJRt58vpD5D8MNcEBphShG
	iW6t3Ww9VRq5mb7Q2m76Vqs5LM3Qh9uMBoOiEGqLeD3ekj5Ednib6nbwbG5CGjujyu8rUHqozpi
	VFTszzg+zrZMnM+OwISSarSQ83Bdkj9vFpPDceRRLll62MzYVPVQPks3S9kwqoVfIrtCsZbDUw+
	tQWd346+/tydFVSRvK1ZPcX1CYtz5cnkNJbC95mhiuaBd2c3bRuGo7M7M/9UoqEL7jySBkxXeOI
	icIE9iJFBa3OM3CXErZvrXfIt43eJgm/ChB8ZLyTN+oARSzpeDKik/V+Y7zvIjXd8eto9ET10=
X-Received: by 2002:a17:90b:1d48:b0:3a8:d01d:327c with SMTP id 98e67ed59e1d1-3ab3ab3762dmr10150604a91.46.1791862342549;
        Mon, 12 Oct 2026 20:32:22 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36fdc75esm19541303a91.12.2026.10.12.20.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:32:22 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v8 2/3] net: stmmac: guard against a zero channel in the aux snapshot handler
Date: Tue, 13 Oct 2026 11:32:06 +0800
Message-Id: <20261013033207.1684328-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013033207.1684328-1-zxyan0222@gmail.com>
References: <20261013033207.1684328-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

timestamp_interrupt() derives the EXTTS channel index with ilog2()
applied directly to the PTP_ACR channel mask, without a zero-mask
check.  ilog2(0) yields -1, which lands in event.index as 0xffffffff,
and ptp_clock_event() uses that index in test_bit() against a
PTP_MAX_CHANNELS bitmap without range validation, reading out of bounds
from hard IRQ context.

The zero-mask window is reachable: stmmac_enable() sets
STMMAC_FLAG_EXT_SNAPSHOT_EN before it programs PTP_ACR, so an interrupt
arriving in between passes the flag check while the mask is still
clear.

Check the mask before applying ilog2().

Fixes: 8851346912a1 ("net: stmmac: Assign configured channel value to EXTTS event")
Cc: stable@vger.kernel.org
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index b9a985fa772c..2a076e228e9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -242,7 +242,10 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 		       GMAC_TIMESTAMP_ATSNS_SHIFT;
 
 	acr_value = readl(priv->ptpaddr + PTP_ACR);
-	channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
+	channel = FIELD_GET(PTP_ACR_MASK, acr_value);
+	if (!channel)
+		return;
+	channel = ilog2(channel);
 
 	for (i = 0; i < num_snapshot; i++) {
 		read_lock_irqsave(&priv->ptp_lock, flags);
-- 
2.34.1

