Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D23AF675
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946577; cv=none; b=biBzyL4vLlcfWzqovppdWP41yG7laLPgjq+R4FfGl2IDfgBlrsUzul7ImTkymzXXaylOTRS1Ejw/BC3RURASJoATD65SvidDwS1YuM3Lfx06MBcT5yKSfPMMpyvx6ochJNQfcAJgfR8TM6w7AeaLP6umQP/xbLh7RRjys0kxzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946577; c=relaxed/simple;
	bh=fBON41rkWJm+Nr5IP0+q0DD6zo5hPQEiHIFcCKvNNZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcKbgNa1CuPiYhRoVttF76RcjIWoCowLpttaSA/ABvj7nF2TWZupY8B67UQa4dMn03FUdggL7q6p1Cf9L9otszCb7ayA6EDLO9PQ6A19NSIrbBGGNiOxMks6QtsQMRcK+4qF7ePCsnWw2/5tjgo1WnPYGmzvUPB4K3qDzFrQdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=Ywin/PwY; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="Ywin/PwY"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-16ad92569b5so3579412c88.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1791946575; x=1792551375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
        b=Ywin/PwYXQhTh4ucHoiyRD/1QKZQQJbdfFZzrlt5wsL4YgmFSGgtolQwOIx9XV6UXY
         hTNNDm8LldA/ryQazfzd5eoluVf7osUTyoZWIUKlhaTjwQrkBA8kws0+Du6g0/BS1i9Q
         4nqdCyaXN8Da2BjMDlwLHrai1Gt29+rpraXf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946575; x=1792551375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
        b=cfU+pa1iJwILVNk9iGlCRl5d/BjyEvDdPpeQjORFcEBrPzDRN5zVQsxjEdr3IHfL3p
         cDuF6m5OoNSF/kSh6RJvG49RV1meJnOnKM+QGbRxhiCUBeFNaSIbg2Fz9K+yc1/ndR+/
         VsLtEqKeq4C56U5o1Z1qKP4PqsBM+ZPVWKm/QFCtC+zETdTqYYWrRcs7wB81li8JE2f6
         eMMCSrIwH1mY5PMNjbF1sC0kfn+0nmwlVYq95oUy1IuYeCklyuAipV6hOEnN8AJXn/2i
         OAtXsdUfhU1Vu4QKDFtZ261M3MHI4zl6RW841+Dsev2nKv8EuSvSFgrYeXbPB7O/yqUi
         cyGg==
X-Forwarded-Encrypted: i=1; AKwUvBwJGMx0KnLBk9ldbrCM2AiROeAjqgLgvsh+Oa4vggk9FGRcvmBXKr037fEJG5bQTCudRZv3oEg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQRHh1UeB/BAK1IyjSAFv7+nevhTryM/r58kzfPiu0arlvSJw0
	8fJCqp3dmiOAqLo3sm44NB1j49G3kbDRx0oRXJosHedjBPBdhgI8yNgJMYsT5XGWDQE=
X-Gm-Gg: AYBFou2wII11QYnuG4rs1HxPqjwuGG7brTmuhBHZlKK0QBcQ3Vf/l3V+ArkCp7dH17Z
	v3lMc8t+r3VJFRSfJTpl/6Hz9/xwHXFWyQB+5znIgZKbjfWFsoZkHnH+kLUhm27aL+dg7hxUGy+
	2Vx7S/NoetLlS/oVyplt9DJ0Nl7R8POC4GMzrKRrCqoqKEoic7hK6RNVsTGccLj2zaHibGGkZvA
	I5GZiyXXE81adMxOE8dIfI+LUATXu4017G0rin6w5RYvki+pMHjjym03Xlj+FFFM3hnhx5UwqV9
	xShg2HaQT8vDuFslmPqNPFHm8FLyc1OsXs90P/VnJchhovCcF8KJDgHSNn0D6fKNoIIEe5LwO/5
	bueuYgSiun23wklA5DOMhDZ7lZmvoCsc7qopOsEXAeqeGn2+T+65Ra2kQDPIF+KQm7+bw9zA5Tm
	u50wApIUPNX+bjQpKNIs5tYFR2O04S0l8l9BAsGxVrRumGEarXu1ICnP9i4kSCbaCQmASpTGm8Q
	ITRBqNpaT3/yv5rl184BnD6oSiJPiPyVAmohg==
X-Received: by 2002:a05:701b:424b:10b0:144:e246:a0b5 with SMTP id a92af1059eb24-16a5e968b0dmr19796817c88.40.1791946575008;
        Tue, 13 Oct 2026 19:56:15 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-17dc865cbffsm2122640c88.6.2026.10.13.19.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:56:14 -0700 (PDT)
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
Subject: [PATCH net 1/2] net: usb: lan78xx: do not update statistics after a failed read
Date: Wed, 14 Oct 2026 10:56:01 +0800
Message-ID: <20261014025602.26334-2-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg>
References: <20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
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

