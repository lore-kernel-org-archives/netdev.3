Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733323A562;
	Fri, 31 Jul 2026 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507621; cv=none; b=DTcdli/wp42Uw1WsMnleZdvXvQ1zsqtFijDWyRi26DlxJjo6ufDwBcG1WhKM1C8Z1IyYR7nByx3zBSiY2PxVQuDt00DTb6XZeYArnj5OysNB5A9G3KgRKFRx0aguKsdjR7AhxNqDZk3EQZs6DbVU0G4lPJ7PxYDTe19eBU0nX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507621; c=relaxed/simple;
	bh=bpnaHBw5URQcNRrcVJj7UR0opKBNv8yeV8RneGmZuV0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=em0r/Hctziu+ogGx6PPswfIILcxjfMnlG6LrKUrDAWtidwLwWkFgQIfCjprRaug9YcGyzv0rgnOAdeMgkq6ottPNQGcPk/7QZmgZarJLOmhvXDNqT7oow3iPhEjiiff00TF7FFBMJTJPYdYc4Of1qNntcrqA5NKofooBj0Lb6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxx9+6rQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eb4BSkLZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxx9+6rQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eb4BSkLZ"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785507618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nI7fTHKHKg6UE0/aQX98hR80HNriUU4/NTMDJw1+u8A=;
	b=kxx9+6rQpz0CYCOT4OEHu9EWZkeBaxSSnxSBSIe/f6xLnqYGG1Ha0F3OVOIQ5ad41/8wmy
	fpzmT6NdKS0B/6CivPltN3s8IyWLBLywBvSEww5mqj0r7Se3bI8TF80ZlI+ojCj3Kok6Qi
	mNbXVF835xOennK75KlXLBSae1ICImjnR2nIs+9NRDKW7Yt2P/8zgd0kt+n+1fE9YsZ0em
	ArMiLUOkxoiciKEKkvdoLTDeSCUINIoki7OG3vEt9Lns2LqKxTzfCCRpudWtSd6qM97gmH
	QO9Hxae7UCLTezhxl5N3YACNpTgxw2mKJyu4TCjCVWZ+Z9AFEvbh4b5x3WF/7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785507618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nI7fTHKHKg6UE0/aQX98hR80HNriUU4/NTMDJw1+u8A=;
	b=eb4BSkLZCIqdKKMZT5EUb7xRxTuwwZ0LhjB+qsU3G1OMPLYVOY5k4lV7erFd13Jw6uQjlt
	Ke76ZyLwN5QRiYDw==
Subject: [PATCH 0/2] timekeeping: Annotate auxiliary clock accessors with
 __must_check
Date: Fri, 31 Jul 2026 16:20:13 +0200
Message-Id: <20260731-timekeeping-aux-must-check-v1-0-11ae93068497@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBAF0KvIrDsQZ2GhVyldxMmvDiGpJFoE8
 e4Gl2/zDqoohkqv7qCCv1X75Yb+0ZHOPk9gC80kTgY3iPBqCRFYLE/st53TVlfWGRq5D6N4eap
 idNSCpeBr+52/P+d5AeuZjrFsAAAA
X-Change-ID: 20260622-timekeeping-aux-must-check-1db2a27cceb0
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785507617; l=770;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=bpnaHBw5URQcNRrcVJj7UR0opKBNv8yeV8RneGmZuV0=;
 b=oAqiS4rk/2A9QhRvbYUz4Fl7mSChL0mwU3vtJJshLEeK78dNW7eVhNbKJbRSAm/yaYwuIfpcB
 hZAef6R/ZkBBP0l0/e/qHC4FBlrs/gNQ9/BlCBGNPU0ZgWHyli3Dc+u
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In contrast to the classic time accessors, the ones for auxiliary clocks
can fail.

Make sure the callers check for this.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (Schneider Electric) (2):
      timekeeping: Remove the unused ktime_get_clock_ts64()
      timekeeping: Annotate auxiliary clock accessors with __must_check

 include/linux/timekeeping.h | 12 +++++++-----
 kernel/time/timekeeping.c   | 34 ----------------------------------
 2 files changed, 7 insertions(+), 39 deletions(-)
---
base-commit: ecc330e3096173f433659aa64ab3674d0d48440e
change-id: 20260622-timekeeping-aux-must-check-1db2a27cceb0

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

