Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D21ADC97
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788648758; cv=none; b=Dxx0XSYSHul0l+4+KXCjndmR/6yq8itiPTq1XYzKA0CR7r9vyuTGImEr2j+1FnhExa9t0D72XrRyn5eTcabJk6Z9D9koVpu99tJHjlQyveHZe9zBRZ0mpZKUtrmN5TmexTrm/M3bV0UOzOfaFSW4NiXc/tSA1tFF2CziF7LNraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788648758; c=relaxed/simple;
	bh=NpZyNzNUhutWagHqilNpgKZT91VlklsV6mHOKCKO/T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsjbvyWYfXSKiiaUKaNGagIujU9mQS8aERLDUR8FhjMx2C1LqHqPXEPA4sO+aMblksyAqca1bR+2VJHTQkEglcdYMWHx03BevpV9f553xtbnTsSQROMYU89xTLTfJI0vNlE9cgzUGnsJwnp7VhUsCVsXsTZn9Ffkcs0jFZZO/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdCnBPKK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdCnBPKK"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48431648f33so2399227f8f.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788648755; x=1789253555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XCkBwlj1vCXbflJebDoML9tmLNIEB/3Els0FcjcXPJk=;
        b=AdCnBPKKjFnO5mDjXm1A8Tk1mdhVCnt2jF1Xdz1BUikiXUnUaJeZVJm99giZQOJOvf
         nAFIZe9PmtSZHa3xqsTRnxVZX4KPXMD8zP/5GvzNpvJsUOmkjweQcVdOJELvQ0nFntKq
         7ZSVwRrlGdur9GpOJlrnuaQgCcm0IEwjn2kgM4dPh/QRiQlXMfEfs+QI3FcarFlJhKk9
         OvR+e9AHESvsw2qTQeAmaWyPpruK5+N85rboHCgvVaeAo0Po8viMlJe0m4vcuvBMqfwF
         UN1R6q+IlId7uuUDxUnfSEbqfPweH7yGKIOXy8f5cKvLpGtwTYjSIclMInDkpwFgOcgQ
         hFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788648755; x=1789253555;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCkBwlj1vCXbflJebDoML9tmLNIEB/3Els0FcjcXPJk=;
        b=HYJ6hAuF3G4eikiX9+OApBNBD8xTmFcgWEILCgavS4PrFQ/YgJVs+dm05mtvNEA5Z+
         0k3/r6Lj/ylqsWn7UHxaXp5YIYazQxVZbCouMvCGrcp1XgQQKLT3+ut2aYK35SQNTM5W
         s9jw7E5X2dfLimmjmNOQbrI2+yBzkPYgzui0d/feguDjvkZFuGGtBRc8GSD+zeHLdqdb
         aSCY6uB9ScWTv470HkMjNLugVVssr6A2sgyW8WXh87gyl1dolVgx+eWkEnTBAgKgH+9e
         GJBSX61WQyKY3OjWSAdoJpjZ4SsWOFn5YDdQwKnQ03vTVyQrjd2yrv935LJvuhzgW/2i
         TXVQ==
X-Gm-Message-State: AFuF++lk7yVWMkgCYFS8bCMxI9OUy7pQYioZhFflYzKhnw/xqdQQ6EVX
	lCrCbvi03fcTTdldCQJBElL9aAHXljq3To+tOg313uYYY0jpvc+J1UXoWKkgO4+Yt9U=
X-Gm-Gg: AYBFou2RKeyu98ZrA41BDvf+RmWG3AUv/IizvomR5UnNBWawM8yanm6Sz8jZSTYzeUA
	ho73Thk+SF6WTWGYr10CXbtc+r/kBXUoZIGg9srUWE2FNwIDdw2vOq+YkPnUOF+sddeUE5+QNt9
	REA9BCDsoIiNzoUSC2BCISesKa1fAQx0o7179AvdlpD7T3edB8pmjyF+saNW9YFdosK68CSWf0D
	6dEBDluugomGtDS2xkWf616ZMgJ1dgnm6YHxV8bwOEM+dxI1/B5fjmbdxckYx+qljXp6O/Pqcvt
	RYZdADmiIZtMP9f5knjn5KSyLJkVrZXTeHrYPjqT8LsWdO1FsZASFzqfxlzqL5ajB8VFAwkCkEv
	Q389nrknP5IG7zpGu8lF74xvE9p9l39uaOOJzsy4z6FINHov1JkoOxOzHY1rm6bG+3gU1nRaogw
	xeJtY3c2zqnsrdiDYwPgb6nZJaftSxgvBs2v4Qeap3plmEcetmbsHW5WSEkw==
X-Received: by 2002:a05:600c:3b0a:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49cf86f49b5mr128633775e9.9.1788648755042;
        Sat, 05 Sep 2026 15:52:35 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm405224965e9.15.2026.09.05.15.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:52:34 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: netdev@vger.kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
Subject: [PATCH net v2] nfc: llcp: fix slab-out-of-bounds read in nfc_llcp_wks_sap()
Date: Sun,  6 Sep 2026 01:48:43 +0300
Message-ID: <20260905225211.596366-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903165014.497490-1-omermetekaya0@gmail.com>
References: <20260903165014.497490-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

nfc_llcp_wks_sap() passes service_name to pr_debug() using the %s
format specifier. The service_name buffer is allocated via kmemdup()
in llcp_sock_bind() and is not null-terminated, causing
__dynamic_pr_debug() to read beyond the allocated region:

  KASAN: slab-out-of-bounds Read in __dynamic_pr_debug

Fix by using %.*s with service_name_len to limit the output to the
actual length of the string.

Reported-by: syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1e3df0852e82c21ca418
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
v2: Changed prefix to [PATCH net] but still I could not find the Fixes: tag both in the gitblame and the lore.
 net/nfc/llcp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index cac1b5487064..fda236e4d9fd 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -341,7 +341,7 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 {
 	int sap, num_wks;
 
-	pr_debug("%s\n", service_name);
+	pr_debug("%.*s\n", (int)service_name_len, service_name);
 
 	if (service_name == NULL)
 		return -EINVAL;
-- 
2.55.0

