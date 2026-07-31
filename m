Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368942C4FE;
	Fri, 31 Jul 2026 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507622; cv=none; b=S4aMAVyX8EZRFtMJ3dIcWSD6TVjBi7lthHcbJ+qSG+hLZWOEKRa8XxlxBgQ6XNkDgo9IIBDVWKg8M35ScX0p1oLDa4RR8QzfsanOp2YOl3MOOEQYsUb8eowkNd2nZzHSJSrpFEtHvISPu3S+yTBSCSdoLofJOKer+4TV6DKsWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507622; c=relaxed/simple;
	bh=UcYY9jdkkRWZzcyn2v+5QU24qfIZsp1gpbuwyITlB0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqrS8ACJWMZ3vB6d2awFyNXiYg4V+Id6OxgrUAYFqCuFoai7d2D8reCPKnGURZ9oDdOZmfJ9eOgJUzNFNG4IZol9j7xxB67Oo2ENOJS6Iuun+O38xrBCgozfoJTFCHtbwH3w4FZ8h24eOi2NB5fGfk62mfxukrnWztwsu4gBsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=khygl73M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9TaSsd7W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="khygl73M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9TaSsd7W"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785507619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68d3evjLPRaeFDQ1lOLGdyv0uGksE9tFBPgLbdNMwYE=;
	b=khygl73M9mhCcoRKKmscySXKhUF05pS9zJ1/lri5yOaP/46GgIui8KbDouWhJYva40mOMi
	7opJsak+kPcqVfniTR4DGn+B3kJGCNPZUZ3i+P/XJ8BDJSVZU3o3DWA0FuLAs49P38Wu6b
	UV7PCxHdfiGRH2BJPL6m0fddlKiDXVGSIx9cUzMr92FzkPE4sVHZHruXhd1xExaYlFBplG
	z76t8OXgDuyT2vsstUGzaAy9B9rj0PYm/epy2Z2AYHbhoIpWOuQ3i+691oHairIgCwQ7Iw
	k1JVEUoxKS8CkxEZmHosX1SgA/aVCdQ8qRUBl4/6ZvMyieKt5Gp9ERNSb+JJyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785507619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68d3evjLPRaeFDQ1lOLGdyv0uGksE9tFBPgLbdNMwYE=;
	b=9TaSsd7Wj5Bkaw42xQvwCi57ZT/I0Pb0DgbkaHPxeVafetn7dBKLiTl7lKaG98kUqKlaeW
	LiBs9bVDeAu2YhAQ==
Date: Fri, 31 Jul 2026 16:20:15 +0200
Subject: [PATCH 2/2] timekeeping: Annotate auxiliary clock accessors with
 __must_check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-timekeeping-aux-must-check-v1-2-11ae93068497@linutronix.de>
References: <20260731-timekeeping-aux-must-check-v1-0-11ae93068497@linutronix.de>
In-Reply-To: <20260731-timekeeping-aux-must-check-v1-0-11ae93068497@linutronix.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785507617; l=1378;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=UcYY9jdkkRWZzcyn2v+5QU24qfIZsp1gpbuwyITlB0Q=;
 b=qfkYfL9We1QK8gU6Ls8OR2gO1mNIdW+INGvLyDZ2G7oXHZOMgtcy4aShOvUrp/RXJ+86xi21S
 Kn4iZ3FCfaUAi1g7xVbnInNpAe8IZW+T2CetiX5U1VJsV2a5nHS9GP9
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In contrast to the classic time accessors, the ones for auxiliary clocks
can fail.

Make sure the callers check for this.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 include/linux/timekeeping.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index ca4a881e622f..561313b5cb6d 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -267,11 +267,14 @@ extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
  * Auxiliary clock interfaces
  */
 #ifdef CONFIG_POSIX_AUX_CLOCKS
-extern bool ktime_get_aux(clockid_t id, ktime_t *kt);
-extern bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt);
+extern bool __must_check ktime_get_aux(clockid_t id, ktime_t *kt);
+extern bool __must_check ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt);
 #else
-static inline bool ktime_get_aux(clockid_t id, ktime_t *kt) { return false; }
-static inline bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt) { return false; }
+static inline bool __must_check ktime_get_aux(clockid_t id, ktime_t *kt) { return false; }
+static inline bool __must_check ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt)
+{
+	return false;
+}
 #endif
 
 /**

-- 
2.55.0

