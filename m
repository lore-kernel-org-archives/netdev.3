Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005536923B
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139113; cv=none; b=mwX1X+NJrfc7MfJx0CzRo9DXW3CIZV7Lz/+Ag2/qvCr8AIWRK/e1zvmhdi9EEiBN9dGPCnTDGzQKmhQ1xI4QEKcUbV/dSK7erk0rve8ruU0lOUB6RU7GbPVL4NXEL4Rag92CBeAAAZ9qqPt5yiju9uMaBvuIbOaGAu4dkzzmcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139113; c=relaxed/simple;
	bh=6/BdbYqdcZY9dIig5OcHM3ZIkVv9X9lZQVPrP0wQUIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwZmRaa4tLAwRXwUDTyDpzCEADza00BDRceRnPgwSBkIsObA2PFWb24Dc2PPFFil5s+tbfSK7vV6Bm7k+F4O1e/uH/8AvVPyqh1ITovEjD17Hqer7H8nfIQa0nnqc4P6uiYvCOwu/vb9g1Y67I7FB1HWaBD6VKNEuvN+33ntVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E3yKSxif; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E3yKSxif"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so560716f8f.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789139109; x=1789743909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KmDwdyq9Q0uxbSq8SDMOz/Ug4vndqaUQy+VL3xEV3E0=;
        b=E3yKSxifi0pvQfRdRgC/conJLhso6/AJHcMTItLsGdSMskSELM5uK2fYz9e6exQVKf
         MWft8Xeo02GFKwFF1J20S9wMB7aoIfSvbf2fLR2xFMx+SWAgWo6uiymrZLkNaSKHGQG7
         r15l414Bow79sjZNDiDrUjENxonicH3bQf7ox83uGmtNt7FijjI3UsyCX0bGe+Z+quEU
         Xmp3SGFCgwatniq/9zav6LmQq+OUiGsl7Vsc88cEUAM27e4mZZ4Aj2BF5km1Pqy8SeGN
         ibSoc2lO21+eMvLhgqVmDiC3iN0b+l4XndHd/9DStRXuRxcJAqUbnM6O1Xu76+wYIHgp
         BovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139109; x=1789743909;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmDwdyq9Q0uxbSq8SDMOz/Ug4vndqaUQy+VL3xEV3E0=;
        b=semqOqOoEUJpHIGzVgk3jvA8d2o6l518wi2ob3juAYVzc1gfiP2q2ghS9w+PewoPwm
         q9Qa1/nWRfkbQ4kmBKRQ17AEsCu40ixihH6CaUjjKsMzKZGaaj7ufiFGdNDszJa4FvKA
         14uhpBqviGVd+4/EHExXXyJp0xCmFbCAmCS0iGz0KaX6RAdxG4oIz8wdoeie9AH83prx
         w4V8M4BgCYPX7dZmN74f8kEo8FXikcDmJJc6Nw9Ww0kD22RKpAmuzEaREiJGdwa4O8Jn
         qmaRlApYvKRUTQVmxiq+7+hkyzgCJ7v5PI7eJAWKaSgwJWE80ZF/TKggX2gTmZMKP15B
         PMig==
X-Forwarded-Encrypted: i=1; AKwUvBxoYlGjgRzjy1/mb/pJwWC3SVEzHaJYBxqyRmDQX7jMH5o4fC5P2ttnUezVp0XqlXuhmqM99Tw=@vger.kernel.org
X-Gm-Message-State: AFuF++mjUvIy21DYYM90sB4Ug8pBv9pcBI6t9mVVPgwIJ60S/L61n0C+
	4FgVxEgTAZZRGz+N2zo8cf2pfvEacspYIn6YpeiU7eRkmi8zFhCIiE3BudIGOzhmMzk=
X-Gm-Gg: AYBFou3izvRC2eI2AUsB99s3Ts5751qDd0BUR33B85cVmdUUPvpwch+f8sEiccEgNBS
	cu5rxpa6YVq3ho6b6ckkBkCNKSkBYZNgT7RNdigtRb2aU1TsCux2A6JPiHRcgWgndHMF7r5XiDy
	VWsGC1TCvb3tsl2bi3Mfe5l0JVbnROStqFCZNrbd70FaWxMscwx/BxyyTf2jDhd006ltwDWzbsh
	5XMEgj/moE87z9rTw6qylD1lqtRDU23PBiEXVoX3GngJQisCENO8lr5+S91+ZBrUxG/4JFA58ZO
	Zrrm2rGMoTYMikiKRe2TBVhdXjH1LJJM3zzsaKPhih/6Q/osaic1fbLfSfGsZVd3V4+SOu2Jy+e
	z75lFwTF/03WonFzrqQsaGGZRic4w1GIu8HLEJF8tMkPMfcAQHjz0pA0Cxbpv19kFukpz4z6P1T
	xUkXYfNRDlQtGOQ3ErRZEgznkyu31Ab9kw0+GkrSqrjVXAau9bfQww1BoQOryaH6/b+My61pCEJ
	/+8BA==
X-Received: by 2002:a05:6000:29d8:b0:486:f4b1:8c4a with SMTP id ffacd0b85a97d-486f4b18d31mr887113f8f.10.1789139109105;
        Fri, 11 Sep 2026 08:05:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb350686sm6853579f8f.27.2026.09.11.08.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:05:08 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Francois Dugast <francois.dugast@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-block@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-api@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] block: Include error-injection.h for ALLOW_ERROR_INJECTION()
Date: Fri, 11 Sep 2026 17:04:01 +0200
Message-ID: <20260911-module-include-error_injection-v1-1-5da895d8c84d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

block/blk-core.c uses ALLOW_ERROR_INJECTION(), which is defined in
asm-generic/error-injection.h. It currently relies on this header being
included indirectly through linux/module.h -> linux/error-injection.h.

Add the missing include in preparation for removing the
linux/error-injection.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 196bccf27f58..324a2d1bb727 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -40,6 +40,7 @@
 #include <linux/part_stat.h>
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
+#include <linux/error-injection.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>

-- 
2.55.0
