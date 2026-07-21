Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640BC434E2F
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672151; cv=none; b=hKNBC5Wr+tRHSUDDA+2vz42e2EY2NvBSvNuYIrTqMUTibE94dicnfa8qkA4UbopIJ8msZ0KlkhoWV79Nw06mbVWr5FE6acX00JoXKcoh1hKYtdC8keYQb3hfjYx20KXx2rSx8vvmCEjsza91Uz01b+mxPJ2fp3sGAJaO5BTCkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672151; c=relaxed/simple;
	bh=VylVE97urOnGo1fKhA1IwM8dNjVc6rVPycHxhapEvGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qi20J8/CBcVDK7Of0iOZ84SUwD7F8lIcdHyJU4Og0Ivy+lnMrryoWJSb3OMiagv9lwqwsCjk4oIzGCp+gIqLYDualkNJU1Cmg4/jIO6JwHYNhUAheHgCSe3LLk8rPlsE4RZxwaijtSHFBzyZusZJUyfCqGYoZcE3PCyyxrudUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhMhKu1t; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhMhKu1t"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84867f07d63so13306618b3a.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784672149; x=1785276949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5mP6wFrKPhYjd/5KHULwyWUdonzv0xy3jN9195/5g2U=;
        b=WhMhKu1tzHDSY/1mwMMhB10yCS21VcrNOG24xbGFP/TljIzjw3V+C8SD+v6CyxMlPR
         /GvxPSJFZsW6G5VH5FmHIiwekS0jpd9IADSz1IKxB9OvJB9PkvO76pJkI5RvNAGr4nlw
         WKNywSAM8Z7g/HLnCtJJojyyA/nAV+L1vfrIyP+BbGRn3bxT3Q2V7aJMBbOfmL/X9AU+
         +4cMuPCfkss4vMwsVqd/+s3S4+uIcxfAiOqz5HZnm9MvMf+2rZMlkyskEw+veFBlwjQ6
         ADugWw7ixYd/InKQdTpc4311w/7BAZINvrUbSF0Y6/mJ3vxxZUMtH7sRHih+1D5Nv7nx
         7jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784672149; x=1785276949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5mP6wFrKPhYjd/5KHULwyWUdonzv0xy3jN9195/5g2U=;
        b=g38Am/9xfIJ3IYh+LZf1qVlPlXiOFlLCkEj0mSglG4bBDF01Hr3w0RvDqm3xFaGemR
         k985YOLrIFtN/ksZ23x5IN3nECWOPa6vAD1h7NU7SGpBHE9WuylWqe+K+ISeXz9ZTi6n
         6b87psqldPVVGSkVJQIuokJo/ARQ56q3RDhhTyaV6srpcCe+B8mzQB58Df+ipYPTxwWg
         GZxg4AdNx3GU1kQvmvmUQVixmGSSAMRQ/OLNy66K9t8QtxI5gmrZFXKPMEig5OrBnPxW
         eDRugmeG7idqfvzKwFGdrJCi23lOQs0EC57G2TWhbhyqEU7tNU3RHYALxG1KfZfwAoFM
         FbQw==
X-Forwarded-Encrypted: i=1; AHgh+RqVz+hFnhZvGytT4YY6uFxex942r+U5+FluRIHNNBd5v29Q2ChtD2m3vzp6pihQKpciB7818iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KXQD8ow6owd+INgnqMVKk5u9SJHh1IHwH+2kiLyExqUW4KYI
	mgPlLjxsVaWZjMiIwnjxciA4egyD6kN/ODyI617bX59/3xpeeHCwdWrs
X-Gm-Gg: AR+sD10NXEnmy0lJza3VmOrC9VCNWQEcvnFoo0cyFqRVmDhyYnBc11kgf2vaxEVrrUU
	wB7EVSTTYqPvw+dswkX39WvO0AXuEAKvQ1FB85pAAUF0aaCAtZtAFhuKIEdT200mW/lqKN6GebN
	ObjfJrbSs03YfBQZ5a1Ue9JSVerudMCSJD28AndukyJO2DWImrJrOcsz8mTDodoHUGOPwXosxXu
	psaWfflYwaE0kFr6fiYEB8RCZUC9yT0in4/0hFXxrIhn4IJcGM59Xhn3PEN6YsJQX4FWs0Oy4kD
	n//5vycCevZ+Hn1aRj2HVMZP2hLtRX/e+D5RySBfumruZqngwmx77vn/2c8yekRZRweh38KpvFH
	hbEYepIRf3b8rEwk0nek1RXs5I3AFXxXguOetVooNr3cA7dYS3S+hKLEede0HptTMPS5sP+Ytx7
	BUWefHrg==
X-Received: by 2002:a05:6a20:549b:b0:3bf:9c93:ac44 with SMTP id adf61e73a8af0-3c3ad66b543mr23855336637.19.1784672148601;
        Tue, 21 Jul 2026 15:15:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::9edb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e088d3fsm2093442eec.25.2026.07.21.15.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:15:48 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	Zinc Lim <limzhineng2@gmail.com>
Subject: [PATCH net-next 2/6] eth: fbnic: expose all hwmon attributes unconditionally as read-only
Date: Tue, 21 Jul 2026 15:15:36 -0700
Message-ID: <20260721221540.648272-3-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721221540.648272-1-limzhineng2@gmail.com>
References: <20260721221540.648272-1-limzhineng2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All fbnic hwmon attributes are read-only and always present, so
fbnic_hwmon_is_visible() can simply return 0444 for everything
instead of matching on the sensor type and attribute. This also
prepares for the threshold and alarm attributes added in the
following patches: they are exposed unconditionally and reads
return attribute values.

Signed-off-by: Zinc Lim <limzhineng2@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
index 6c8c66ab86c1..38bb26cb8e6c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -20,12 +20,7 @@ static umode_t fbnic_hwmon_is_visible(const void *drvdata,
 				      enum hwmon_sensor_types type,
 				      u32 attr, int channel)
 {
-	if (type == hwmon_temp && attr == hwmon_temp_input)
-		return 0444;
-	if (type == hwmon_in && attr == hwmon_in_input)
-		return 0444;
-
-	return 0;
+	return 0444;
 }
 
 static int fbnic_hwmon_sensor_read(struct fbnic_dev *fbd, int id, long *val)
-- 
2.53.0-Meta

