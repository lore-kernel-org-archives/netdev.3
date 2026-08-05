Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4F470EBD
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935713; cv=none; b=j9AJrPKXnFK7UjqWhcoeiz4GXXhHnQkfj3jbi/1xbsedoQy5gUTgH43xh1zw9E+BPAFeAaooD2nvoq23RiRlb0H7NQpK6Mdmh3EvssNSWPIwRFD12Zj2ui3bXzxWE416JWMTUBIkjQ/9u/GQrKKDEqkY9ThzUgMlY/NuYzKsIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935713; c=relaxed/simple;
	bh=UPhpllrZamcQNZMJtZeoWoFQuApaJuhTwqaKdaUAHKg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IyjQIQZdg7Yw7PxZuecJCAwL1cPLM0YukTw1UNj6SfXKhTrCtyA0VC5FoUkE3DbUjru+8VIAIyZOd8wEdzXMflRD+Xq6HHYcDTr7BRDqDfdNUNCQUyabaNKIm/AnZ7P4trmcypITNIG4CzJEYjSZJMeSazWMIE4RvPj/4VfFxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eB0mtfSV; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eB0mtfSV"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51ebdfceddcso10564641cf.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785935710; x=1786540510; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+iiR9tifk7fD8CAqxueTQWxAf7agC5Bth/Bv5SAURm4=;
        b=eB0mtfSVDlKLJ88cpRRqedZfA/9gYbIwSaWHlMw7TD3NqcoxBrnGA20ivBY6JGvJ75
         +/9o4rJHZ+1lpW1sV5YkFozcKeHAxGhW/S/kVTmlbqxKZRysPAl1eOleCCJDHsD0h7z6
         0KiimzgLOjTeeNFMKBIUG1oG2K9rjakUyxluHKOlEQha4FWn9UXRYR6dJuRHVHsNTjkz
         S/IUUyJGrdcq6g55bX+mcZmNBGbC3bJuPUDUkJwYKza15Lw0IPhT8wfs/IJLwgvFIoZP
         nG1X9elwAudgMTLlr1HW+jrxnd3c427yoA4cR675qAFIDEetP88EAuI0rb7e93w+xo9h
         Ktpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935710; x=1786540510;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+iiR9tifk7fD8CAqxueTQWxAf7agC5Bth/Bv5SAURm4=;
        b=L5Kb5UTWQI4PQqBoWNuH3RIMr7Ke1NYM6STxuUQ+5X/pnb5wqG6YhMVwRbjDjl8uR7
         oirUnk0m1eCM/uipwXdqiJkzjgIM97iQep1f3n9pdFp0L0kG63PdXR647wFZvf2MUY/H
         Hn0MO/JUMR6GlZtCT9UNIWKLJdEswCrjeJtH0nbez3vcY+vQdOilrBi7a9bn2XCtxrEB
         0tfSPXMsWP7uyzlrIjV3BRxq5rX12ieDZBkrh/v2hLCOvA3vUg/nd/jZBuqSNrM3BoJd
         t7MWDes6KWIqj5RwlBj12/3CIgjCGvzKM7clwwl8PD/hC8vyoDmvMiMGWf0Plu8854XN
         /b6Q==
X-Forwarded-Encrypted: i=1; AHgh+RobT1rp9tXnM8eZtSVx2GCeVAqab/1mq39F0OWfsttaN0BG1jACOaujkvjGHZU9QJNjZdfafBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKlaXPfGKTXVUpGP87VcFCOi+iOgkLF5ci5q5ydLCAPFwlTfMO
	Ujh7X2u3PtOvnfQ0LgUP7v8LZPrxhgKXPTgVxdfqILp9J4/E5rMvrnlCFwdKmZ3XQVMF7zJPFwF
	Qz/WACqyYsFTTGw==
X-Received: from qto6.prod.google.com ([2002:a05:622a:a6c6:b0:517:58ba:db8c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8c:b0:519:fca2:346a with SMTP id d75a77b69052e-52ce610775fmr55916631cf.23.1785935709551;
 Wed, 05 Aug 2026 06:15:09 -0700 (PDT)
Date: Wed,  5 Aug 2026 13:15:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260805131508.3227331-1-edumazet@google.com>
Subject: [PATCH v2 net] net/atm: fix slab-out-of-bounds read in vcc_setsockopt()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+53ecc09fb81df10ef4de@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

vcc_setsockopt() contained an ineffective optlen check:
  if (__SO_LEVEL_MATCH(optname, level) && optlen != __SO_SIZE(optname))
      return -EINVAL;

If __SO_LEVEL_MATCH(optname, level) evaluated to false (e.g. if the caller
passed a mismatched level), the length check optlen != __SO_SIZE(optname)
was short-circuited and bypassed. Execution then fell through to switch(optname),
calling copy_from_sockptr() assuming optval contained sufficient space.

Furthermore, even if level matched, a cgroup BPF setsockopt filter could shrink
optlen after entry. Because copy_from_sockptr() on kernel pointers uses memcpy(),
this leads to a KASAN slab-out-of-bounds read when optlen is smaller than the
expected structure size.

Fix this by using copy_safe_from_sockptr(), which unconditionally validates
that optlen is at least the expected size before copying. Also change the local
'value' variable type from 'unsigned long' to 'int' so that SO_SETCLP matches
its sizeof(int) ABI encoding on 64-bit systems.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+53ecc09fb81df10ef4de@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=53ecc09fb81df10ef4de
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: change @value type to "int"
v1: https://lore.kernel.org/netdev/20260804145806.2112004-1-edumazet@google.com/T/#u

 net/atm/common.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/atm/common.c b/net/atm/common.c
index c7f92405daf050ecd2a507e41efdd622ab8dc6a8..81195727fa18ba4e6146c0c02cd3898d17fc436f 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -710,7 +710,7 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
 		   sockptr_t optval, unsigned int optlen)
 {
 	struct atm_vcc *vcc;
-	unsigned long value;
+	int value;
 	int error;
 
 	if (__SO_LEVEL_MATCH(optname, level) && optlen != __SO_SIZE(optname))
@@ -722,8 +722,10 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
 	{
 		struct atm_qos qos;
 
-		if (copy_from_sockptr(&qos, optval, sizeof(qos)))
-			return -EFAULT;
+		error = copy_safe_from_sockptr(&qos, sizeof(qos), optval,
+					       optlen);
+		if (error)
+			return error;
 		error = check_qos(&qos);
 		if (error)
 			return error;
@@ -737,8 +739,10 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
 		return 0;
 	}
 	case SO_SETCLP:
-		if (copy_from_sockptr(&value, optval, sizeof(value)))
-			return -EFAULT;
+		error = copy_safe_from_sockptr(&value, sizeof(value), optval,
+					       optlen);
+		if (error)
+			return error;
 		if (value)
 			vcc->atm_options |= ATM_ATMOPT_CLP;
 		else
-- 
2.55.0.571.g244d577d93-goog

