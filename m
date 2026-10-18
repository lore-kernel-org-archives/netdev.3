Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B83F58DC
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304269; cv=none; b=cpHL0UQI3ABPRKpowyIGArbJoS8YX6a2ACuLKpzZ7eVFSxrhZYtqTDsMiUthz2JwShLVCkz2wP++WG6WMfguk7fIqPM4TodBZRk0nM4uI1bTK+kxFd91gcSDERnXc+VreBEP1CzaBOBGjyNwW+W4vYF48OlEaZyIGxLZwrTxtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304269; c=relaxed/simple;
	bh=AA4CFCI/T0Ewszphaoo15ML6lrPZ6nLxKoibb0yiWds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN6fzQMSbEPYos1hXe5BS8BY7xWBkeg0v48Ui4F8fXoKXGHSuW1xyEokvPzhtaKSyu6jJq1OhjMzZ5iH56jjrJPcpi487yMqjtEdeuikub5bV7zGTy35zf6mNOT1SZuZ4EdQZL2CprtC8s+yxX09BOoeGC9x6i5XO8rjTYBznrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=Dtlfntjz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="Dtlfntjz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab41538192so914155a91.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792304267; x=1792909067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yaonELdcVf4OUI2YJCgEvAYKPGQioZd6te9YEzY8XbI=;
        b=DtlfntjzLEdOCfUOgBuomjBZSoGFilba39LXPLFRJm8I29WHiwQbUmdE4K43K3vD9Q
         KWVUOyEcs7MtwE4e4Q63F9wRAxbjq+t33arNw+NWjw4N2ywegiK+AZ4tt0Ak3UibM/xI
         43tacmr5e061Jqy8Cq7nLVd8x0RSPpYreW78U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304267; x=1792909067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yaonELdcVf4OUI2YJCgEvAYKPGQioZd6te9YEzY8XbI=;
        b=xYsvi9EaRdAw2Pv9GgtJ6ykG04cbz5woUgXAO8BnXkdoT4bkvhTyGfbcc0XrC/JmvW
         KLmI0/0w1mx0Na77vx9Y4kbEGswwHQPpK0Q6xhhdfD2sjxrp2dXLfr8U9lQCnyChwjHC
         CvZgKvFZVEu0a6hJE3sdlXaS2mw03JvG/3Uv9dCzcszaCwpFJC/qtQcSUHz3jtKd/T7g
         LHek6lsJynqhZa8nNBg9m80ZmqcIiKeiGv9WyMPiGvjs25aEqyI3U8RuRi40+Veh/tpd
         y4glqroibeaxn2CVrB+QepNS+fs7+f7VAu8zvkJsJPc7cL82gcLp5zIVRpijB6h2IkA/
         93lg==
X-Forwarded-Encrypted: i=1; AKwUvBx6Oq0A0qKvL+h0E9aerMsSDxejDrgX2KXWPrASzXG9o75BcwZbZbQo59lmvmbz1qSpJsYkqBk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOJ4nqT5KuoOms3KAIZGstd7+uZFtZJ17w00X3M1wGKQF60ADF
	EgMWoq4CGmqlaqGwfEHADWZOo/hojh6faLznv4CDx05JMxRObrZr9lUrabf6+WQSTFo=
X-Gm-Gg: AYBFou3q65eZ5IVtSObqhxZF2ZiBdOTOpTPQbXj4/4G9+Jvb8QZjgUzcvC/aatN7YqA
	gQWkojEHZQMMT3DdTTyqa5wFj5tgEAGDZTa6IpesZLqlpS1M3ce3I+pI8ytbgUI2A9SHvTbyhVK
	GSyHhx4G6Aztxf1wrNdrRslG1WgM5vf7j36xxM3/B7dfzaZoUdqqOiQaIXslVwcR3NKBLPM63P9
	En0S1OxPNmpiWTrf6vP0mjyB3Sw/Fjvyd/4nTBNQYpsmyHscjA2g7ZdOvL39ZJvvueWahez6zFo
	cAP5NRiRvZKyZ1L/vputx9YejaQ3+CB90Sm2r97JqFp5A67fa3NaXJMk8PM2K2USPWhqgCn1/SM
	GbjV0ry0J+bBUdrQsn9bmxyz8G6znu8bJ3x20GhedlDXLOi1lCjD3+mXs6Q1p6xbCZ4fnBmzg/i
	r17fhVwqMbePkC79QfTq5+m7ILs8pPzcsNjphw6AO3O49oJbACJC3yspPAbiTeOHG9S8b6y6zAv
	N9W8VIRNbGpnt+kAZtmdQ2YEJwv0GcdWdDwFwZkXvALFPtNOw+1FGM=
X-Received: by 2002:a17:90b:4c49:b0:3a8:185:cf40 with SMTP id 98e67ed59e1d1-3aceeb95f82mr3978010a91.10.1792304267228;
        Sat, 17 Oct 2026 23:17:47 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ecd32sm11025963a91.3.2026.10.17.23.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:17:46 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: usb: lan78xx: do not update statistics after a failed read
Date: Sun, 18 Oct 2026 14:17:33 +0800
Message-ID: <20261018061734.19488-2-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018061734.19488-1-law.wei.jie@gt.tech.gov.sg>
References: <20261018061734.19488-1-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

lan78xx_update_stats() reads the hardware counters into an on-stack
struct lan78xx_statstage. If lan78xx_read_stats() fails, only the
rollover check is skipped: the counters are still recomputed from the
uninitialized stack buffer and stored in dev->stats.curr_stat, which is
then reported to user space by ethtool -S.

Keep the previous values when the read fails.

Found by code review with LLM assistance. Tested together with the next
patch, which makes short reads fail: with an emulated device, ethtool -S
then keeps reporting the previous counters.

Fixes: 20ff55655a93 ("lan78xx: handle statistics counter rollover")
Cc: stable@vger.kernel.org
Assisted-by: LLM
---
 drivers/net/usb/lan78xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..cb8204371f5c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -789,11 +789,13 @@ static void lan78xx_update_stats(struct lan78xx_net *dev)
 
 	mutex_lock(&dev->stats.access_lock);
 
-	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0)
+	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0) {
 		lan78xx_check_stat_rollover(dev, &lan78xx_stats);
 
-	for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
-		data[i] = (u64)p[i] + ((u64)count[i] * ((u64)max[i] + 1));
+		for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
+			data[i] = (u64)p[i] +
+				  ((u64)count[i] * ((u64)max[i] + 1));
+	}
 
 	mutex_unlock(&dev->stats.access_lock);
 
-- 
2.43.0

