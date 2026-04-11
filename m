Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2219C546
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 04:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775881160; cv=none; b=XT4zlXaeXY1V8ftXOrHRHWzxPXKXQOvcwu8FFkkK6dPjXrVfoN/TgD52IzapQ1m5dHqijB9ACdMr9FxzmPWcA11DcVSrLAzrO0uh1wOsEesfEeK6oUQHRdFbiJnCZCK3pWPIVFbYAVl/caiffDFg7FWdA456NwEMDPokTRZHk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775881160; c=relaxed/simple;
	bh=+RojG+k3W/pBz1fUjz9It3pQK3AsTgCyKKb/n1Z9z5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F6fEudR1XhJ3VijPxhRB3+xhbEmjIWR3gBYAsimlfinhJ69Gwpj4HhgJSUx6oSWBMU8yizNytsSrXoJdD9yC09VDU5nFk0WI+gFOqgU8+zY1OzpPyE+LaYfzKAjO1Mene299CcmP2xPc1hcpqbf5qpJ+OUovtY4a32XYtfJlyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j02UJhDm; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j02UJhDm"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2d323567f11so1196023eec.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775881158; x=1776485958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1j+8jiz7wiVO1jk7YCyoxQP0XnF1AUhCkV8p50MFBNg=;
        b=j02UJhDmtYt6xmnFLJakVeuFydikTweNH/Y7/0MLI3A1c7QKin3T9nnr5wIAL+gPeZ
         YFsBNagu5bC/+agvRN0lmRNK8x/Pmf5CGFQP2M6i4kH9rakq38pCNOCOWpI/WrPgPxGj
         icKaKAFHfgi6DsW9PYMcff+HrR+7SR8p6V/dhEouxxA53osOxDmOYZVzL/+FBO0dddkK
         BeSZIRrwR1IUGt7UJ97pTSxzoVQZ7H0tRpuyr3b4Gsezn7jtZnbYDft6Cz8UJho4yvA6
         IY3GMwLDZEZe4wWlEMvzLvUtwS0GMS7U89/EUEB2r5qMCx+ZHhFcuHgP9cn2f16+K+iR
         Hk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775881158; x=1776485958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j+8jiz7wiVO1jk7YCyoxQP0XnF1AUhCkV8p50MFBNg=;
        b=rtNuR3wV/MZWkQeVFAiwQurcQ1kLeJrAGVDQ9lLdEmraPqwGMzuLZA4dF1qgK8/g/Z
         OnS8DOpQ846ehn8Rc2UI2AMpzIDtp7+V0d20m5GIAhd2lp3sVodAwZSadxJtPgksuLoK
         rfNrpuM9nsLVFUkwpTgAPQdzmvQAj2h6HO+aqUiScrOWUKVeP00y7ff80fwHArNnyRqG
         BKjoKtmfGraQ8oiBKN6kebK8gMg/ks37wFGbSTKVeI/ijhu5GjPKHbHAaeuihkwiaPN8
         +chJ5zpk+Ps0aEgIIl20P5R5gSpsRfpRVQ11aabRlSAMbz5q4TJeJikreRIjVs1ugX53
         8DTg==
X-Gm-Message-State: AOJu0YwwX3f67Jf+PCTYY8FqcKdyN9h+wKhH9oaMyUvg78n9SHBDa28S
	DcBgqpAdYa5arHYOma6dN/DpuD8VqGCzBMVubAVf0iVBXB7pFyoFoy0t+Xk/8d4s
X-Gm-Gg: AeBDievUPW+NRGY9RinggoRGlP9GLMI/GMP/HMjbmyb4kH9hBANui34pj2TFd5UTRdf
	g1WzgFVqn2Og6lVrBlCaUiO2MlXhyzTUbu5UcWI++AG7SRnWeEMmXMhy88rErpHIedCoWP+SVyF
	LQY3J2ZK+KZ3FJOPYrvOzNwUflckUnVLBrWwVecfx0zUE8PgUqc9Thp7Ui0u4bshfpR4xoRHhNu
	SOfTeIqJdDDRVjITVmvbUqKPdm3qnbym273uXmefEw/ldxzTxCE5OLPrZdTLIbZt3Q0cKe5Mgr6
	ZXLpeTRIDYm5G1CWCtkRPjGOztESRAdwOJHxSmGL7hgQ9nd/RwOO4/IH/QWrKuDd00kfRZVQ9Ht
	hZLrYhcV6ay8dn/0qTHvhq+UVhEBw47RxUYe19+O1YR1AsABKmiIjHkcWoW24RIbNSxuLoC5Yyr
	IjBqjPMkVRHhnH5w==
X-Received: by 2002:a05:7301:2a27:b0:2be:acac:af7f with SMTP id 5a478bee46e88-2d40e3e6960mr4986960eec.7.1775881158130;
        Fri, 10 Apr 2026 21:19:18 -0700 (PDT)
Received: from localhost.localdomain ([2600:6c5c:6b00:ba4::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm8402605eec.3.2026.04.10.21.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 21:19:17 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: netdev@vger.kernel.org
Cc: Matt Vollrath <tactii@gmail.com>
Subject: [PATCH net-next] r8169: Use napi_schedule_irqoff()
Date: Sat, 11 Apr 2026 00:16:44 -0400
Message-ID: <20260411041644.471644-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_schedule() masks hard interrupts while doing its work, which is
redundant when called from an interrupt handler where hard interrupts
are already masked. Use napi_schedule_irqoff() instead to bypass this
redundant masking. This is an optimization.

Tested on a Lenovo RTL8168h/8111h.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..4c0ad0de3410 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4873,7 +4873,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
-	napi_schedule(&tp->napi);
+	napi_schedule_irqoff(&tp->napi);
 out:
 	rtl_ack_events(tp, status);
 
-- 
2.43.0

