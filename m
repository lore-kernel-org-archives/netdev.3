Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C963EDE53
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690862; cv=none; b=jumqJ/5eHWityjvIgJr44W6Wnf1eQBGsXsw0oZ4h2LcEOvvpMtg4pag/WD/S3NqiJ0M3/6VQlevjwXtwJeyG081oEcJ+Hyt8313BXBWHa7/yYjW3meYOHo1VA0HyPTUM4Mvz8YhHyvFBjEaznE47DhjTEmpF+Y5au5szO3uR3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690862; c=relaxed/simple;
	bh=VVADNSV1X9wTkRBoKH71hQL9qSar8jZgE+dZ8EZnP3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu9gSxfSZyfv+JiW+uWUs4BtpQnC/zyk5T08lEma3XHKOvd5CLEicuVmJTMiNCp7WJCnf5uOPPaqrJAbbqQW7xEHcTYG4FefOKO0B/G3jy5jnxdrl9AJeUp6R7muy6IMJ6szuAAbWPmjBbvQfnr9TT5c08i9o6BurRXC+PuNXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWNn0obn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWNn0obn"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84237c55ef9so1222533b3a.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690860; x=1781295660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLIAaKlmgt4AiSXDWFcEgvbqEgZu5tWx4v+R7w02MlU=;
        b=AWNn0obndberHrdOLGHmbiKgn2xP4vgMxCowoBbyjvXUEm463a7j0TBRhmRFt0kC07
         b98ZgMAZhy54UWsQ5oxjlp/faDb5LUzmDMdkNYpZszFSSYOFQYeq8ESrTxebHQsoGrd+
         /7oeUaf3PmKxIKOlLkdY+Kksy5iZzyAfCDap1XST7/0DbCDYJASWqoAEMevX2DRwovVA
         BcK7BV57JOW5MBgBUV7qpbsTbf2Neg+PVklOVLBvWgQWpE8ON3UYN6nyOJ1ht7bpZOt7
         us+758cw1HPUNVKCnv5bHJaxqvLFB50iSr2iLAlwPAdOCnJoQ3OoFd8QvcyLmYrPS1vJ
         FDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690860; x=1781295660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uLIAaKlmgt4AiSXDWFcEgvbqEgZu5tWx4v+R7w02MlU=;
        b=sHL9ohO/662dRExN/lFa13Jx1pNA8bc/DajE1hDXGzqDoVkV3Kz+ryrEOghfyP8ud3
         uIei3qS3Yf0OAsTZ8Qp0ZFjYLOMvxgKviLUNFtaNcB80a4NOR9Mf0Z+rmHpWUnrZfOIl
         Vxq4iiHYg2eiRiKMLVpxkp54r2KKfV5fXJzDNheAfcgQEYJyPQ/vrQ3U/P8PHWwr1KfF
         e04HbsSl/m9kmefD+MPpEV6hac+xDRI0aLJrZs/ZkKHQBkZASm0KeL1KZnnF8pB1b/4n
         mKoDnoJ5j2R/lOXWbodl3u9g5NNnqE49Z67IR8nKQcd8wfV6wjL3v4W/xr1+u5y0n9+N
         Fe8Q==
X-Gm-Message-State: AOJu0YwkPYZjqjHzZyANa+C9x29Cc0rsBKwNKt9rLr7wwS7jlP3zkglp
	ayaTjLOx6CKm2X6avJi0UZ7yN7umI0okNBcxieSfJb2yscd7gas7IVNx
X-Gm-Gg: Acq92OHQNOpsx6IpwcqKt8Iu8F/1oBEWv9we7ZBL85QEC3qqIQVfvlmxjb2+IPXI8pZ
	g+A6aFDvMvdefqFE45WEeD5SnRKaXFAy0YZifWVdqyq1xUHFzUh1+C2+2+GTes4pVtEREo4+3Mq
	DCdBLxHV9X879TTnqs0QVW7cZko10YBRIDTZ/Odd0zHcOBw6Wr6jcwsXraok5dFHldQ4elY0GNl
	uZpiPzkNtWyhVdX8OGXf2JmysA9nFMGWxMW+80arAzehGi75P7RQIbrRePnCQZamZt+AWbHc+S6
	vBLzmkAk0m8SUE1qRKTETb13IJfWoADlbbRhDxTbdJL/7eK+rrzvldODPBapydEg1HiGyKg1IGO
	zqqmNaQ+JZYRMQdO4wYvYHUeiy7wVbdAyGoWyoneZyAxdB9sIAToI+fvpZvexYzKEdT7YP2ibmC
	r74ffZ0KmaF9U0Z64AaOQ4e5M=
X-Received: by 2002:a05:6a00:418e:b0:82a:7893:e14b with SMTP id d2e1a72fcca58-842b10b2f2amr5312600b3a.38.1780690860191;
        Fri, 05 Jun 2026 13:21:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282374300sm12345069b3a.20.2026.06.05.13.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:20:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 3/5] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
Date: Fri,  5 Jun 2026 13:20:54 -0700
Message-ID: <20260605202056.1780352-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
References: <20260605202056.1780352-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

refsafe() compared each reference's id and type but not its parent_id,
so two states whose PTR references differ only in the parent object they
were derived from could be wrongly treated as equivalent and pruned. Fix
it by checking parent_id too.

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/states.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5945956a7573..06d9ae24f006 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
+			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idmap))
+				return false;
+			break;
 		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
-- 
2.53.0-Meta

