Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398F377EBA
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274729; cv=none; b=aWkciEsn7brqMJ0kVnJvp9Hy+rhYn5J51TgpCNiYND0d1M4rXny//WkiulETjcP5NsAhn9HWMpcSrs+ASctFTDI821Peq+ri5gGYeiPASW6JoZpmaKfxcWxaRrZ+HPkaOAu7IIsI6i7EPUzo5FoppZfA2veYPdvaukcOrSuGTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274729; c=relaxed/simple;
	bh=8pcwJYcdh0WDe01GIw6gH7H0XpLTcpq6/bmY3L1SuQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2S4ugfwjXzsn8H1K3Hu6Ek9KWNcYpT2dQCTOeqOdHHxYCcMDZid4wPVkGrlqie9iDelMknL2ic0gNnO6VEpjx7+ncVqG2tfeff4AcgcFQD4GCGguQuMKeZhHBwu0IDPFsfjV4sjuC/JOuGccVU4jvzuddL1hPw49N3X2BBY3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=xW1Vkb5r; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="xW1Vkb5r"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e041ea211so354657a91.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785274727; x=1785879527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qE1Q3EaTS3Ay3rZB5tABle0IwKRHwBd149YIEXSHe/o=;
        b=xW1Vkb5rcC5XX6pJNyDTTErjNaJo3wBnJeTCN7tngN5Ej2ydhaIayzotQoMHo8nGiy
         xcy8dplkzHQcG+1/cIHogZ2kiiK/2PND/g2MmvDy55CSKsZ15hxMBa97G7WG7lenbIuH
         FIHMWgZQDoPDuDBr4njAis3MJ+CdSgAzXj07nYe0B7j0/SDZrgI0PoAnHGNmunHVBL2U
         UksIGDnlX4P1Ub3wT3blusPw9u0fYLr4qA/0SkKtvDjQEubftHFxu8ee5TNiOBcNvwJs
         T2v8ds/Cq64AzVntAOoqAnO/vzfBzskbCkaO0mVZbSdq32dYxy/JelTaUQj0G2hSgRKG
         f71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274727; x=1785879527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qE1Q3EaTS3Ay3rZB5tABle0IwKRHwBd149YIEXSHe/o=;
        b=QxvS5O+K6wQ1HeZ8tZRwfa8OLZV2mqey8VVAortMCKe52FQ3et4lcUM62Kvv6atfpi
         xio63Gqdys5GNnw3VaCFbO+vf1WZl2ugdHSMVbH1j99J+OEZSEVIZwC4r6MRLs+z6yUB
         HAVaxBMHDun4+PwoPhnqIEptpOBFzXpk5/JOVupSjtBbwn9pvWr2UXRClPAhrS1phsLL
         xrJ6HUc2JB0vWcZpj89+PaeyIZR58w7xocDKRb//kXA7JnjUjwMj18mY+7fQi9ctwiuk
         nMtgQcfIuemjNdtfSvCaLcRx2451rouw4V9QQ4x6jAqohYI9+AbzokH3w14OJIcqJGBT
         dG3Q==
X-Gm-Message-State: AOJu0Yxvfxx4qK2TDWuwZIA2E5XpgiiGbMBYEtloEA+XoEFcJFIZJbox
	uCSOlYBESSFe40s0A4xoEDtyJDzIac5D9L4eslRrJHKA8Q37C6Qu97+TpOJRuA21SUlF0s59D2O
	Tmnvx
X-Gm-Gg: AR+sD12cH25XhbcP+k0jmIhffU4g2PTOMF8TDYmE7T8845eLfA2cyNmNep60H8PXY8i
	A+jpMuWi4yIlXznu/O3SyOj3jPFl3BuDFsEZVyDj4hOM7lNUrb039kyIkjMx+RzvOaQzzi0kI8e
	TTaTy8bPWEwp6koXSKH/U7XjZed/dWD1RYEzNNg0fXTBMGVadodYuB9LNQQX6f0x0gu9Qn1Wvw+
	Uoj6cHlbm9/N6u5YNztdk024imQutxviqDaFbpQ7a6WKHQw4J2vwcLQ/OQNzXAv7y7FQYCr0nif
	GD8tcxpQT4agtKDKG1pqX86AAOnBqIY559kE2ASdwwUCzZSKfKqQmZ47MF2xboXhtMA6h1z8W8L
	WCOVBkLL7Oo4QAYWAPTc0TZMYjDgMYh5TsjPdSUiqOxBzk97QBiJHa8R88OU6HWlpwuCbPTL26n
	EkvOBro7gwSHuZvXXpV8yBP0PT7/5MHekAXRBaRjRwFbacRwclLQwNqI2lX35ASRcqcsgQz85h3
	E5kF+DKdjw0qNMB6TA7oM4vL5o=
X-Received: by 2002:a17:90a:dfc7:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-38f6a33d8c3mr4669488a91.8.1785274726950;
        Tue, 28 Jul 2026 14:38:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7271f0ddsm2037960c88.11.2026.07.28.14.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:38:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] ip: drop unnecessary fallback to ioctl for tx queue length
Date: Tue, 28 Jul 2026 14:38:43 -0700
Message-ID: <20260728213843.794737-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel has been reporting TxQ length with netlink since
the 2.5 so the ioctl path is dead code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ipaddress.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 7e4cb77c..6fa02c77 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -159,30 +159,11 @@ int get_operstate(const char *name)
 
 static void print_queuelen(FILE *f, struct rtattr *tb[IFLA_MAX + 1])
 {
-	int qlen;
+	if (tb[IFLA_TXQLEN]) {
+		__u32 qlen = rta_getattr_u32(tb[IFLA_TXQLEN]);
 
-	if (tb[IFLA_TXQLEN])
-		qlen = rta_getattr_u32(tb[IFLA_TXQLEN]);
-	else {
-		struct ifreq ifr = {};
-		int s = socket(AF_INET, SOCK_STREAM, 0);
-
-		if (s < 0)
-			return;
-
-		strcpy(ifr.ifr_name, rta_getattr_str(tb[IFLA_IFNAME]));
-		if (ioctl(s, SIOCGIFTXQLEN, &ifr) < 0) {
-			fprintf(stderr,
-				"ioctl(SIOCGIFTXQLEN) failed: %s\n",
-				strerror(errno));
-			close(s);
-			return;
-		}
-		close(s);
-		qlen = ifr.ifr_qlen;
+		print_uint(PRINT_ANY, "txqlen", "qlen %u", qlen);
 	}
-	if (qlen)
-		print_int(PRINT_ANY, "txqlen", "qlen %d", qlen);
 }
 
 static const char *link_modes[] = {
-- 
2.53.0

