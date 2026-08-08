Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39EE3AB292
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218250; cv=none; b=N0YUYgYibJqSj0zZ5ASCa63/OUWBr5e31N7n1hzyKiRghyBOSRnU9qsDjMaAcbaz5mKwSiTmFPcF/P5tDvDQUGjeFM0g2TBflrB1jyWX9jQOOp0lnknWZqf6ZJR+HdaZpASy1yu9FpnDp1kdecwHFqNs6bgnUps5B+AcPPb9UDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218250; c=relaxed/simple;
	bh=FQYWuQZWGGBXPvS2LUjG9GwTO7VFydczucFNprVTDwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5R+mIu78vd1EhmzaWWV4BnnwnItI9vgPDsAHua7gJ74CZsdjIniCVp/TSvw7Gs+ytY6YF5bKoJHv00JVzxBrISvFNOgOe8dKFheyJP+3ew8fQJzzv0v1RQbc6HkbVaf+0IGb8bolQUXl3tc/m5l85ZhANtsLqL4E9GVB2Vx6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/TLsoFi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/TLsoFi"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f904e80eeso451654f8f.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786218247; x=1786823047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G/t8sJ5LOSZibo69U8WXLyP0rFjkd69TP+Q4li3mm3s=;
        b=l/TLsoFisPjS43RqFm1yGADM4a79hd1ghG2Xq9GC+1ggOfB/ItUwXsXGcyOeZTBd8c
         SGGmSbvlzdKAq8QKm7Cxv0fDyroC19Qh+gwjiM08vau5zO2PXv439QzYuigpFxkSVCje
         xo3x5wjRdTny3fmmiYH5ZDjPw6EM/jNhG4kzwCKPL5pxmhJYG5++ezKMmq8cFP1qNJ37
         WWIdzlkwqrBlAceolqn0v21Z8TXQTtdHK2x9TGEj619nhU7RRVQY3i6eygOBVV+bvlBi
         JCe3C3ai210RMOrFtWPfXNM3kFTFArkZYr9/9R3x7fUBsSsaT6CXdTM2/co47mQnH3an
         XAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786218247; x=1786823047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/t8sJ5LOSZibo69U8WXLyP0rFjkd69TP+Q4li3mm3s=;
        b=o619b8J+CLJiYBEgHNzuZkNqgkhrLswP9jxmcxAAa/I62QEL4vYK+a/LXy4CJOL8B4
         sMpssEE1TZ2K1nnNepw5U506jh9k4ZZDdW1fWbpBD7IyyCdeYCNW0JBKOFY+Ct4+PSOt
         vJl6iXVIc3FIPTUTLTFQXVGIB8dGUa1pLtO8K5KoMxHvkuo5pbZ4U/GfY4u6Kahn5FPi
         B/auENJoSZc9okV1nsGOag6JNRm5GmYka+XF3kI+M25FIfkeAlCbvOJM5BIxQHCOWcPQ
         pq+XT7LA1ttCrlPvU/upACeCw4dULXc922s/r+nfgN1UKcJQ7CIEIc/skzhs9bR9x2UI
         9CgQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQHu4/GLn6XMqh3YXoE3eo1I3Y95lnMVDUyREryuJwje/Iys+KEnQnldxudxFQya8ybYXbr1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrei637gcDDgboIsrXRnFRyyG2QeAl15hGuzw+7OpkPY8w8L8t
	PSjoW7oLDxoscgLC6yAXFzrz2hZ9bK3suXLmj+Cd1nrl28/ub/Y2AHmG
X-Gm-Gg: AR+sD13zQCUhBNWaTf5gohsvt+iYWHCORgS+1sV1jUsz75bAOBn3d9MRrNHJitHFZr0
	gpWKA4myiYR97pEa7t2zHddpdRA2is98nsnaod4/SyUJLZcpUvfkqsdSF8/kvLelYmTUsUZeJpE
	f1dc0xCJL7guPbkpsjPE5Pt/DdCK1862vLRyu6Fg2xTGcis9vsIluVEpQjVRMY3YigNYg8Q7V/B
	/RZbulHaFosn2nfwoWnN+LxLX5lLArncZgKnEU3bckuT3pYl34zEODMmuDJ6SMm7hGp2c6+Bkfi
	458Dm7F0bhY6bUSZRhJHlw35z/KXGKc2DOoLfncFwNUwkwXKoKS7GRURJGae27GRGWsPg25NV1b
	tJEdun0hPUh/xBvAIOImrInrYbMDNfAa61srWRdGpcCdKbzZaqcc8ka3aYe8we967/FWGvnp+Bo
	M8gnbdMll8rBwYf/RhHISpbO6XzPj6qSgaOxiKQ7k8Z5ygk6yAXIz0ghdoS6K9DuLU+QC4FO8qw
	EJVx3iE2Q==
X-Received: by 2002:a5d:4c89:0:b0:47f:86af:8fe7 with SMTP id ffacd0b85a97d-47fec6283d0mr37624758f8f.22.1786218246895;
        Sat, 08 Aug 2026 12:44:06 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([46.31.101.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145966sm16281318f8f.5.2026.08.08.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 12:44:05 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Mark Einon <mark.einon@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Grzeschik <mgr@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Alan Cox <alan@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net] et131x: propagate EEPROM readiness errors
Date: Sat,  8 Aug 2026 22:43:47 +0300
Message-ID: <20260808194347.813242-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eeprom_wait_ready() returns a negative error when the LBCIF status
cannot be read or the device does not become ready for some other
reason.

eeprom_write() propagates this error before starting a write, but
currently returns 0 when the same readiness check fails after the
write begins.

This behavior was introduced when the EEPROM code was refactored to
use Linux error-return conventions (from 0 = failure to 0 = success).

Return the error so callers do not treat a failed EEPROM write as
successful and the function contract is maintained.

Fixes: b802ce0c705f ("Staging: et131x: tidy eeprom code up")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/net/ethernet/agere/et131x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 1b465a167672..4b6a579e9c66 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -567,7 +567,7 @@ static int eeprom_write(struct et131x_adapter *adapter, u32 addr, u8 data)
 		 */
 		err = eeprom_wait_ready(pdev, &status);
 		if (err < 0)
-			return 0;
+			return err;
 
 		/* Check bit 3 of the LBCIF Status Register.  If  equal to 1,
 		 * an error has occurred.Don't break here if we are revision

base-commit: dd057113ac7ba5bdd2aed3d9405305911152f911
-- 
2.43.0

