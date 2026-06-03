Received: from mail-wr1-f97.google.com (mail-wr1-f97.google.com [209.85.221.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE43812ED
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499016; cv=none; b=gf3+eZDJQuZAAURrWikDWzShlnRXAru2IZxSJZ1MZn5H5n11I975kkITtXdU7weUJUFDNwIzJ6EViJROHlNtg0AP4S9vO+JG/CxXcf1zU5//m7Zbx4kP1G2yRTFAlwWd23m5XHWSNgwrQOTPUDMxeUVrqNypK46EpGWQ/+cVp08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499016; c=relaxed/simple;
	bh=As0IIB8SaM9g0iJhsygQfNz95ki/F/8soFisaCB0aVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agby1lXpJF0hcM8aCUqoJrSqwsCYy5Zfd0P+pSePtA7QLcOFgC+ziyjI6Gp5n9sijhrm401Gvli+QNc8Qvdasuyn/IHwBrrl4ILINmZDIPysahCIM+ttNw69Owk0w/UBrJc7hqV6XVY8t7sWC1bsyNN+53IUeQUrEhnZMaDWVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ayz9wp5+; arc=none smtp.client-ip=209.85.221.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ayz9wp5+"
Received: by mail-wr1-f97.google.com with SMTP id ffacd0b85a97d-45ee6d32402so3760907f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780499013; x=1781103813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bivjaMuNT9oJ2l/Y7Zh3L+bPRfO/kPb9uY6ej/NrXA=;
        b=ayz9wp5+Jimqjyzi9GDN7ROlpoqudkTc/KtbNDBVSTcYSEFBESmPDoD2VpzpuYfGuo
         CjWZRxaGzaGu3VhqpTqk2MbajWakxdRIggH33s+PiNo2iJ+/0dMcbLxVmoLJTNRZRIan
         jSPwLE1tzXw5AIAsKUM/pE+zBPEFFJ5lAES8chblDPdzcq9BvF8pm7S8Y1RANuy7VhkI
         h5yEZqAU/TEKH/ldYDdG6y8An4U6t9+9YoPxSaoYi0CY15AMTkTTdiYMxJgixGNqTTAr
         V6ajw12LN2T3lOCp0xsytG+H3a8vA9HtA0f32z/PHEHYG24TvKsBClHho/cnCXPmGEEo
         0rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499013; x=1781103813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bivjaMuNT9oJ2l/Y7Zh3L+bPRfO/kPb9uY6ej/NrXA=;
        b=oom17ILCTzc1NYIbHCTkJO5V/syDP8ZtxkHNJttOXphSckzFtzeRXA7/hTPCvTGPG5
         z4WergItcOpowMEks5N5QtOzTWeQtsT1NbFcA6w9Ii5MTqZVvYgXCYGuUih+TNiW4b4P
         U+sbs29pXY9wMB2RVmFq7p1W1/MB2QQjjfdKFLjgCm1skYyn/kPVvjXzBipXnIFQlwBY
         v8AfOiV3dxfevoj4g5E/FNKTRBwJQABQlIPfr3i9K77ljCzLZobaBZIekVS+gC50JfkK
         DwZc8XSPQolz2MZmBiJl6ezvr0EGdLUO6iguC5BKSAXLV4+EMY12F9Q43M2O9tpC6pcy
         9IsQ==
X-Gm-Message-State: AOJu0YxcnvefKX7XhEb9fAD5/DOjY/BECQ2I8ZJWHGSVuQVdfZmmhoLQ
	WQGSUjYtq46lFwKDEPKq9nwXeKPl4IvhIOeAA/5EZs7X+wTm+xmKvvr/PdAup+9yIranSnPKz8M
	JHIIvdH3oI5HyuNlPBWYfhNKjkGSHRU9HjWdy
X-Gm-Gg: Acq92OEc71ZGjmFesJldMOAv7R1RvFUFq8dk0ZM05GyhzLgImFKvwsTzft2MCpF2Feo
	EIPKb1rYNOZ10rvydBuyYjNl0kaUBsv7jhtBYnb8bTTTM97qYnbowh6X7FXkYwB/kBpKxMl/Z+T
	vh/KnuIh/8yFHCVex9kZdU92Ml+iP5ZrwaEfYVyejRNkVyMpzifGu22ISUseKGLAcgHqQS4QFQA
	3/bDh4uy9nL8DBiOCt10cfyopyLZHi2QCgipPc4qmQDnjGMinHaoa6MbTnaUOqV5nQg1zdyYcp8
	KZZ7VrTWnelCLE3Ya1+fGl6xbruX6r/qe07I/Ld8pRS+llHMjOkQs/9f5DYt15zfmbr/Ll/5Lkp
	IBcTOuiA4oEpyD+jjqTL+NwtjbMC1hBpC8rd91fX60Ixt3LpxeRtNpbb1yAfQu7M=
X-Received: by 2002:a5d:4a02:0:b0:44a:2cb3:b633 with SMTP id ffacd0b85a97d-46021794f73mr4301268f8f.12.1780499013061;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-4601f35b8d2sm149936f8f.23.2026.06.03.08.03.33;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id DFC0E14710;
	Wed,  3 Jun 2026 17:03:32 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com,
	horms@kernel.org,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v8 1/6] tools: missed broadcast_neigh if_link uapi header
Date: Wed,  3 Jun 2026 17:03:26 +0200
Message-Id: <20260603150331.1919611-2-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260603150331.1919611-1-louis.scalbert@6wind.com>
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing IFLA_BOND_BROADCAST_NEIGH in if_link uapi header.

Fixes: 3d98ee52659c ("net: bonding: add broadcast_neighbor netlink option")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 tools/include/uapi/linux/if_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 7e46ca4cd31b..97a2d4411534 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -1526,6 +1526,7 @@ enum {
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
+	IFLA_BOND_BROADCAST_NEIGH,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.39.2

