Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF92E2840
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787483239; cv=none; b=ZI5jrHmjDwWfGl5R00Gm5mD/9jZ6WE7r83To0HMdHHiRSu+b7a3fvJT/HqFoOF1R86l/a2nfADctlwRQiFPVNViXi7C5yy/jv7OdbUMfIJKzbbAJQXYV4tQfwHVo9iITilgDmEuM+MA8l6vMKB6NZukts521HGckZshSLLin0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787483239; c=relaxed/simple;
	bh=oOLd4/NCDvLsCU7E1foO+QYUFPSlplt4rMf+O/pxJmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEuPRU9N3fUB4duAxEPjKthVzbo1HvnPXTcP+kPw/BlXH+0ca3r5xsByOFuSZy5omiaU/5/Ysiun/3h2bnNXGh83TFsFsoMMaKvjI4mPpJ+UUuTIwyFRYD3guFlPG5qw8umJ04gRLkW3I4eqznNy3VIG8GlGUaKQxiw/5qa8pCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUKVCZq7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUKVCZq7"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso2594403e87.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787483236; x=1788088036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uWawBJbVIptjhuQku9JCKqKhz9haE6JzFWqrvZOjUxU=;
        b=RUKVCZq7nCH4MaZSSz+0km+h9FUFjNzQ75rl46zsyTPf+YY0s5il2n8cmtN/kegxJI
         BJqRTMSMFMAnErmZZ4olYYjAZmC/mXWF8SqGnyTQ4YnHW63ZOzRfswIjlWH2s9tEZt4m
         +BxhlqdfdA8dkkmjE15xp3Lsj3pm2siq9QrVmzyyapptrOdDxJxyetSoq9FjbEBfIhkB
         naH7CgRHUZxsu+XMrEnrUnaaj+JKjWd34BhVCDzG2pwGCPPKM/gh8GsB2I/nlLfEzTsP
         iPTFeoFlHVGf4QB0cdWUbgYVaJqfwPsDNcBnmKV0DSWsedbORa8UcdyU93EiV4sUflwE
         BWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787483236; x=1788088036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uWawBJbVIptjhuQku9JCKqKhz9haE6JzFWqrvZOjUxU=;
        b=ErviklDQSRqbpTkwczO9EiPli4AuAr80JEr+kUhiXZH/2bkvcj9g4/wN4EC2rz0zoQ
         yQXYmCiHYRcWXeVYxIdFmb1k2LRshJ9XFQdKxcmnVH2/5hi7vMLWffDiAacW9/YE0INP
         t91LTlbWiZ9oWQSAU3S0F3sX1dB3N5bUbgxGOVTU8+M/tEVDcmheJH/WXOfF91tfXyTm
         YYwF98Ab8XeSIO1omBPVRa4dI+Ylr4oJdbDvV+tYs+/dTEznMywlbfBLNEMik0VxZZwK
         jEMKfrC+EWPrCUJeZn1R5zUYHijr9sfaIN2poUC6ucAVCMOeVXfqJz2wazQFjIJiNDaK
         0oEQ==
X-Gm-Message-State: AFuF++nHElot+HOgnHpzibiu5L3sXB5lfx/8HvWES6T0BqvEYyn7aJss
	0ZxQYo2G0/bA7wc2K38d/OU947+eslI34+Z7p0qxq6+0+iZ95ewyvulqndPIzruYNA==
X-Gm-Gg: AR+sD11yq04YunG/6vEuzkZOjFZ78JvOTmdiqOCdneaUJMcsNqXCfFIeLYLFXk5XJt7
	beNOrvIUidHs90IIONZCr/GkS7QVUbs4MUmxWLlvu4vDwMFiDQ1sAcTAktAY1B3RCsfPxSEnK7B
	LU911U1G0PmJ0uOfkefeTF6/luZ6BbjnZ6guV54cTxbXCg3c6H10/0DNY8+430WKtiMnymMqCVw
	IKEe9POFpbQY6He+A65jlviUtGu8LiLlAifNjzCdvVuKmQ/0F21EIjrpw4N+Fd1cdHDlzvvzB1C
	va+ANipOH7dlDkDcsrdtj+9//eQ+maYsSkUWsJdYN0hCSM20zvK3J4bYzv+fv2NgNJlRmguwGhU
	fqug15FTxdmI9kbWxd4Tu0oOBzQqC4SmZDGXlK6MVv6RQUbePmDGpDw5LXMtXt0D7baQ5BDru9j
	bX/h/u8TEN/mW76gmIS7Oebi0b6l0GtZdE78nu8YadNcS5VMSmhLfR
X-Received: by 2002:a05:6512:3f16:b0:5b2:158e:9918 with SMTP id 2adb3069b0e04-5b484261b55mr6704565e87.19.1787483236019;
        Sun, 23 Aug 2026 04:07:16 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cda2627sm964748e87.19.2026.08.23.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 04:07:15 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: netdev@vger.kernel.org
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH 0/2] net: phy: air_en8811h: fix LED GPIO not surviving MCU restart
Date: Sun, 23 Aug 2026 14:06:35 +0100
Message-ID: <20260823130638.1166453-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EN8811H PHY's LED GPIO pins are only ever configured as outputs
once, in .probe(). Every .config_init() call after the first restarts
the PHY's MD32 MCU, which resets that GPIO configuration back to
inputs, so the LEDs silently stop reflecting link/activity state after
the first link renegotiation, ifdown/ifup, or resume. Patch 1 fixes
that. Patch 2 is a small follow-on cleanup enabled by patch 1's
removal of code from .probe(), kept as a separate patch so patch 1
stays a minimal, clean Fixes: change.

Verified on hardware (Nokia XG-040G-MD, Airoha AN7581) via OpenWrt:
before the fix, the LED stayed dark after the board's first link
renegotiation post-boot; after the fix, it lit correctly through
repeated link up/down cycles.

Vitaliy Sochnev (2):
  net: phy: air_en8811h: move LED GPIO configuration to config_init
  net: phy: air_en8811h: simplify en8811h_probe() trailing return

 drivers/net/phy/air_en8811h.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.55.0

