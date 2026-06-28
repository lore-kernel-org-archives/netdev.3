Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA936683D
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782688189; cv=none; b=r5hF+2z6/V76cI3KBgVyrSxb8oe/rRuyb7eUvrl4msQmWMwPOcxuJQ6+tAHbMTvWp5Rp+AX+AIiVBAdghETUnV9JRVrebfTbqX/ubT9LYrj9kEujRe0Eau5EzxQX+BcsxyR7ug21CzQoPMt7LnOsm6YiUTp1uaIhJvbfEMZ21hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782688189; c=relaxed/simple;
	bh=LLwlsDT32jQY7igZz7tUnFSUG1UFdyvJJB6/B4mx1Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKauZrRGdFzJPrO9n9Y/ezLeN2txngbDRtoaKbGTFwZWnHkM2+SeYpAiFKHCn7QwHQBbairq5a0Pmc7n7VAKtXiFh3pgCJWk0OO+m1RiSw+E0B+w68pNs9BA+W3ZNzoCuid8kkjVkBiFHAT+SSkRftyqErxhXW+gfG/bN6cM3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK7a6Fni; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK7a6Fni"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37fc01a7835so514185a91.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 16:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782688187; x=1783292987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVnh4LbQ3kz20s2UX3kTG5JB1aSdqwqf5wBEeB9fYHY=;
        b=RK7a6Fnix6/Ii4MAgmlorAEJ4fFnwLP3mzMFkn7FIJIJplSxCj3S6g6g2XgV61alZH
         fJC2iCIGUGMwuUlviVfwWx1vG1uiMqTo6W64qFsCkLKC/MchxMge/WW9fXWF1auYWnT5
         iouetgkBA8JlIuMlxS8igwOtpyvt/MRA0lYTAXXbBQTFOZiXLNVD6cAL69D2ohLkXy7v
         6NaD0I+amcVAK5J7dgqR2GjYkwnmFx4P1MVqqkS88IudPATnapvvvhMHgdOCR9QUT5e7
         YzQEC2Zr1PBzq47rn1pOIzUVhmay1Ywuv+zjqtWuCPlN7Y+XhC4J3rUuJ4VmOAALScYf
         XriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782688187; x=1783292987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVnh4LbQ3kz20s2UX3kTG5JB1aSdqwqf5wBEeB9fYHY=;
        b=WfsS3j2MRFgEFE9/PUhyGFDKyQas9d2FFj+VHCqV/ZvWhCdtYrevyOX+X5r5AD5DJt
         KDB+bEa/wFfre/GgRknPKR/KiRMWjfrn7mkd2KWxncZ3Oq4n2zlr/PzAC1BUayWuBP6f
         dTaf6F5srBl20iilVGIklNkDg4ATdskX83bjCfvez8NtVPCk193Wu2puRnf4DuSSnL/9
         JPT5s6Gh5t65TTEssZ6zTkgE2S32ztg5/HM6jhdAT6A/qvDDaU5/ekX2e4L2EljU+l03
         Ix0qeIxIDNTJpyeNv1MyIGqHWeZL7p5EukSCmIh2zM1lm3NdvJHbu3uZI1NDHtdsuJEr
         7hDw==
X-Gm-Message-State: AOJu0YwKVuV5Z5Zeadq8NA6Wo105+Mras6FUja42dsU8Bt5PcBq/1Axb
	IiCjVmT9Y0hGCGVPiZAfuu3t3VMR9KHyRkp8YA+bu5EYqHwmqVzmTLiYmhvtpQ==
X-Gm-Gg: AfdE7clCFID2x87bdRNvmKYmLFtigtvZXb96+zdGhRfRoLXKDAeGPJBcdXX24K6ngq0
	reNyRK9Yi4qAQPb058sOW99HR7Y0kUrq5Lwpve1Bcf94r0BBUr76Rc1hO8Ahn9CBseCgThpB5+I
	lnMswrVJisVufVsXVMwCbXqQAVHoapmygpqOjnQZjHNZ/L9Bumtm+YPmeURzg/yhhntcy87xBIg
	rHdwcFIDAmHA63JRivQzBKSPffJV2OcWnDQL6iIXbF9ahTGnskVQb3zSycrWsUecBopCEgSq9sT
	u/lkcSVPaO3358kBIv7oXOChzsU2BUkngSB/KKiQAYk+VWTN2Cj7t6M9K/eGfI/x9MBD34mEIvj
	6ohVQuahN3gCX820hcKHClGzcZ5Ki/ucwn23o5rnmYszwPR8wPM+aLHrPxrv8ihINuKpMTYodRi
	G9t91YUmmk1UbZENsZfh3HSd+VXZ/yVeInlL+MC/Cs9Zc68v85cLGLcRZq5gWrAR4Hnv200CGzx
	7EseAFUcg==
X-Received: by 2002:a17:90b:3c4e:b0:37d:ac3a:2f4f with SMTP id 98e67ed59e1d1-37dfa25153fmr13328791a91.13.1782688186684;
        Sun, 28 Jun 2026 16:09:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3800b9c834dsm606960a91.6.2026.06.28.16.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 16:09:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] net: ag71xx: NAPI weight, MMIO drain, and TX OOM fix
Date: Sun, 28 Jun 2026 16:09:41 -0700
Message-ID: <20260628230944.1244501-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the custom NAPI weight in favour of the core default, remove
unnecessary MMIO read-back drains from register writes for a small
performance gain, and fix a TX stall that occurs when the RX ring
runs out of buffers.

Rosen Penev (3):
  net: ag71xx: Use default NAPI weight
  net: ag71xx: remove MMIO read-back drain from register writes
  net: ag71xx: re-enable TX interrupts on RX OOM

 drivers/net/ethernet/atheros/ag71xx.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

-- 
2.54.0

