Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0702DCBE3
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121026; cv=none; b=ijJwjinELc6IBszyiOWQtQlEi5esj2evXuyzuVZJeCL8rjBN9Thm6OgdugIzUM+SXK78lO7R+oEX48LNVEh7wyR03PAtoGQ1vZKw0qa1QQUCn2NzZyF6sYsi3npvHQXolCvd9Dy/KXcoofBpswTz8aOKxPKGftESg36kbn1FrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121026; c=relaxed/simple;
	bh=e1JVroCpy0yxR3TLrzWrxJUaIa9LSvQI5OwiRs8w1Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYoDIGOhGNqWarCIVnTTb95UN2TYxnFn9q4/RKqpss1//zxVPNrs1WA02ShHKq3uLVsSZU1l2NeUvZRJoAeyN46fSAl4LNUw3MB5rZotW73v0IOPUZxr1Q1/8E10kK+DYsVmS3zC3BK699PE/c/0vf8tOEIaoyAnYrPpD2sp/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi7Tswx2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi7Tswx2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4815bce4652so1955842f8f.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 13:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788121022; x=1788725822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xRwk2mxThRhdae+9PHJjX8tprSZn9ioaIXoGdJjtfRc=;
        b=Bi7Tswx2iRL3kWhvq05zRpVft+pem7uoRNqq7koRkuCoJFNUegGcgZxdI2prFGpwA1
         /NFWSBFTEhPaZv7S21YCBUkX71p/msmUcfQBBN8bjmYKgHZzcLZJ1HrVU2/o1lT5bBZU
         ZwOr62Y03cFccXb7d65Sd9y/ti7jVU5+9c8/FGFdvtIqw+ZiW1O4DlvfqJBBgQMaqZgu
         PRPbKuhFGrZHjUJv+SPVUf5c76E7Ro2hN5GlLCy8J1/FQ1HNLe7z6LjITQy3RkipPkuE
         oXKtsJd545dmvfANV1GbZrze6/XPCfOYuPocT454aFH9UFN7m6bbYUM3C71md+RWN1Jn
         7ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788121022; x=1788725822;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xRwk2mxThRhdae+9PHJjX8tprSZn9ioaIXoGdJjtfRc=;
        b=JVtpOIxUrBYtCVAhvBXTmAVNKk45Uph5yy91Ax3Oy37I16c7RLnQCDCiDQ+7uCjruy
         AkrrCDmF7jbM3zsxAoQfPmqyVc4IRAbX+0McqQbPrSUL2vbNsJYzbm7/d1dEIwibVu1p
         C24xODqw66Q6amYXW/lCvAk7QiFN0qhNp3eZ4tv1aaGBrPA2InF7tst5nU5E5hccstO4
         QID6Aa0OL/fRKf6AQJWcqjfDwwch9u62hoEnKltobc3hF+7eL+vgAI0rt1UTLDB25MNK
         p9TOwkjHhmME54cTxeN7VSdHt3ZhGTX5NiXzQxtITVFQZe1TY/7BynhEYmc1dUdRiwjD
         tVPQ==
X-Forwarded-Encrypted: i=1; AHgh+Roh8XbdVzFXiXpNYFkoSrCL6+RFY1HEdg46hZ42Rnnxniq7yZHWCItzOjTw0aE2yPuT0gzjaSw=@vger.kernel.org
X-Gm-Message-State: AFuF++muGklwiQHh9BgyFv1sys2dDZuJ4uxl8NxKq/JwYtGQ0HIMNtlU
	JvJQi4YAyBfs18SJNu3lbYNTjwUzD0tf0vxDULnpyIHAzHFzeMPAyQkX
X-Gm-Gg: AR+sD11U6nsW2/nK+tey59ZnNiQ5mhs+7siyeO3b67pRa3XEKEj3gpUBDamNKj4zW29
	v1pIgtCrccc9dOTLBlZQgmsJqI4ITW8CNCeZcjbfPj0+LBP1/H5vcfd1gXpiJEa+v3SBebq5pbe
	qkwAai1BOIxLB4fAoQwdA8uIGjHlj97iuZj+D17HRjwWoeugXwAVDlON6vMwrM9Viy1L8i7EezA
	ZI0aTxg9W/DyfvtIyHWDCbRPIsYKKykAGBIzKestiyhdg+D5nR7ijZ8nPds8DW1r4dgcVxCZatc
	6fX1Nipkt//CRWIpqjIBBdKmkeArPSl6fdHFFVTIo9XilDpGDwYf9r+DZiyhqQBRJkvYvzt6KEY
	V3R2OspmEBOpEnUzeN92ITE1EaGVXphMrRg3fGNtAJqIaKW1Pw1lm9w4yE2+SLrpjXa7V70/UD3
	azUyAUe686Y2jCgFfMKCy0we+/2kG5vRO+ExqTuN/zRAt44QvlfItkol4m0t0oDRZJCqM+XP+52
	9lmfLL3dF83rA==
X-Received: by 2002:a05:600c:6215:b0:499:5a50:b022 with SMTP id 5b1f17b1804b1-49b91c1bb18mr334176195e9.3.1788121022190;
        Sun, 30 Aug 2026 13:17:02 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm193360025e9.0.2026.08.30.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:17:01 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 1/6] samples/landlock: Implement best-effort fallback for network rules.
Date: Sun, 30 Aug 2026 22:16:45 +0200
Message-ID: <20260830201650.67050-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830201650.67050-1-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The sandboxer sample tool added network rules unconditionally, even on
systems that only support lower Landlock ABI versions, resulting in
errors.

This change implements the correct best-effort fallback: As on older
Landlock ABI versions, the given operation is not restrictable, is
also does not need to be allow-listed.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 030583273f3f..1c514efecafb 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -198,6 +198,10 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 		.allowed_access = allowed_access,
 	};
 
+	/* A rule without access rights and flags is a no-op. */
+	if (!allowed_access && !flags)
+		return 0;
+
 	env_port_name = getenv(env_var);
 	if (!env_port_name)
 		return 0;
@@ -657,19 +661,27 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	}
 
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_BIND_TCP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_BIND_TCP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_TCP_CONNECT_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_CONNECT_TCP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_CONNECT_TCP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_UDP_BIND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_BIND_UDP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_BIND_UDP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_UDP_CONNECT_SEND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 
-- 
2.55.0

