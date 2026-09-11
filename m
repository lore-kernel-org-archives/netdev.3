Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D2524AF1
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159405; cv=none; b=bbZQ3Wt4xY7wRcllIzRJmsY3PKgk0MrY1vDKcumK3L/WF+1JdtOyVV6xqsYODw8JANmB3RntvegKv4P9wMkq/U/B91FNpYmiOurJjZMSoVP3rZzoAU6IUOQFH9Oj/PV52Qc+OPxvwrTuSkke6PEM3LQuxTcOcyULWZC/kcN+eH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159405; c=relaxed/simple;
	bh=exSQCJAT2/4ibTKoqVQ2znJRDT0VpBh9eXRy/MEihi4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=doN/L18wPRPykTzyd5IbKWJ1O8QvhKsN8Su6UzpnxnyFKw/zkuP5HsQCG5i0caO/0yRzTUH/b5cJkTgDaeJDQtZWX71owJYe1sRmCEehU2hINwS3NwrCFNTyGylI0HpsOJIq7ddZUQiE/mzByfUID6uXVelSWuOuIGHT9kH0YLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+L2c82T; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+L2c82T"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so13412675e9.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789159402; x=1789764202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTMWraaokQNwDut7O1QaAcnK+p0ZnWjq7amUFlM09KY=;
        b=q+L2c82TmRTr14uIRHELtItlPahikwG50cFASVvuG8Jmr7iDieNAPtj4vLuIs2bGPc
         qpAe+VV3l00VyGSFxA2BplRC40DjrDIKNb97XbEd8aJa7pOjUJVoNh4HuXCx2NtKr99g
         fkaBg+MspFEsLi7GaA98OVZIrALXmcCSsV3K9RND7nC1x2K+rwy0+Qv3+DGCpgfcKnj0
         DeA6f4X4nO98cX7OsbBwNk0CUd4w9ZRmygm65KqbXT+CVmZJXheVx1nHJfYB+pQPcTNw
         /KamIuo1evRb7beQYqOwvWs78lUuvmyqK0tndPYPwV9cP0qBkfqF3XOXoggj6Ja44Pf/
         0CBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789159402; x=1789764202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTMWraaokQNwDut7O1QaAcnK+p0ZnWjq7amUFlM09KY=;
        b=kY7K+7ErfGi2wf6fE+FVudthO3IbxVghROP9hhV8u+DWUqzSiBdrrTwRHoJ5HVRuVG
         +niKQHUQDFn0r8oAVgcbLkNW+Rc0PKQ6ykTrlckHCqBaYne6Pwji0wCTtPdOFQ+oLLPK
         OitQL3FXyipHYwoQfMZY8u/HNfdT97GLGzGKyds2Lurk5Ikl7Q/IpXqg5zODUzRimEoc
         8XPaDod+dwwIDZvlIIfgcssJi8Y8R+V4ikW51sUAh5hVpmVzWEQb/opPwH2cIbIgloF+
         TIX1SOXWUkWPV03D9Tb33C4aF2h8/+EanyCMNdFhSP1bKfZOmAMVPvjX+86TEip3P7mP
         GoZQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5Q5PysP0nVykb4cvu3+OQxiz5ma3ZxHSFwAPCMn5113pdCmdzZZgzj7Uks/yL6S9F/iVoF1U=@vger.kernel.org
X-Gm-Message-State: AFuF++ks58mcZANSfE6PH3ExiUOF2HYEPsrIEZxwVrwTTgCnDAW5DInG
	w0Tw1sqMG/eQpOLtOz2RiJNN503o9PjQDGUGeOD4iDHZW6L5e5yNjMDY3z+eqIvq
X-Gm-Gg: AYBFou3NbSZvFdr7mgfO1AV7eb/oO4oW97bC4lCvz2T8JztZIMGOMjv87i70UPrK7Rr
	VUfvtghAFZl+6zoMLBMxy56lHdfu7Jp4Jq2YRieEKHJHhfPmQK6lXQszQoXPQ1/Geut9rzB40ue
	FmAD2PDfJB23Mvl962jUgoQR7KfarECDh9ao9vt3irdTPEojBb3vtcXtagtr9jVNtkxC4AKASPs
	8pcInCk6xtrKHRpzgtIKdsmgWAaMpGqoWqY5UmyLt1DYb/f205H/pPdCeafs0ytLYJW5LAc3XQ1
	GF3N0caa4LeSxoFPyhvq2xqZchGHDoxeg4cYY1IecGYXToglD6opuk620SkZz4XFTJ6JuwTFKtd
	pc+wvWhizQL1iMDYplg2IPrczTV+u/JQy8f130epTEGRcfprcdr//KbaI98c2Apy7aHg670dNwD
	EswsnJKNb85OzR2LNcb3gJZn2lbJ+tBr+6meYYFUrKZ4ATR/M1yr5Ygp8qcV2YaMzLzEkjl9YWj
	lnJv1OYlPEfeQIqx5mA7yqZmU2njpCEppRZf4S7eoXmYVkWJ75GHR2c02sH17iD5M168mUvemEP
	WnZ3ZqxB8wvRAeyeRd2fbLJORz0RQPkj+09I
X-Received: by 2002:a05:600c:4703:b0:49c:fc6e:a3d7 with SMTP id 5b1f17b1804b1-49e619bfdd3mr66566535e9.22.1789159402051;
        Fri, 11 Sep 2026 13:43:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm199569675e9.15.2026.09.11.13.43.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 13:43:21 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: Fix device_set_wakeup_enable() reference in kernel-doc
Date: Fri, 11 Sep 2026 22:42:01 +0200
Message-Id: <20260911204201.95270-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The phy_may_wakeup() documentation refers to
device_set_wakeup_enabled(), but the function is named
device_set_wakeup_enable(). Correct the reference.

The typo was introduced by commit b344bfacf1de ("net: phy: add
phy_may_wakeup()").

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5f8d65868e0ff558c163421cfea5a6f3bd73a53e..da2febc6425ed340248d9872dd8f2ef79b665168 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1697,7 +1697,7 @@ static inline bool phy_can_wakeup(struct phy_device *phydev)
  * phy_may_wakeup() - indicate whether PHY has wakeup enabled
  * @phydev: The phy_device struct
  *
- * Returns: true/false depending on the PHY driver's device_set_wakeup_enabled()
+ * Returns: true/false depending on the PHY driver's device_set_wakeup_enable()
  * setting if using the driver model, otherwise the legacy determination.
  */
 bool phy_may_wakeup(struct phy_device *phydev);
