Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856373A4274
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784519119; cv=none; b=fRj4CVmLkvdIV5uxiOqUCZr6W8q87Bniy4B6vdjrQz0mmFAQZdBDxwX2lj4OpvR6StHVKg5WuaqZHCUdcIQ6H7maFKrBK5dpL6s/kiwxESDkg827c8xUzGWU5E7rfDVElPvDqzXXB9Bq2foNGn3fqjL6+EkvYH0niiB76x7LzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784519119; c=relaxed/simple;
	bh=8uUJTYu9Z11ecOT+fffiqa5MSkhO5jMXa1KI7YHCqEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IENgsYfe6/IIYsfDrO+1/TziFvG5r8Zcgn83FQEMuWCDHY6bLcXgeK0fzuQWZg6XM+15FyQalzfg8KRW4qz4SM6Ngn6ijtYv+W/nOTVKexFAKo7SHXcdmtOBbvzHvcMsB6yJOobv7G5n7R8szo2h7tnKdiycPZxiQ9oJgO47TtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgjDSmXd; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgjDSmXd"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66825848551so2990088d50.0
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784519116; x=1785123916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yppHPM8M0gBps0sSHPYVkG0WqZkYvFLfEYcOEagnwfA=;
        b=VgjDSmXdItlJShsZSFXGl2+LScf3/WxUK88W6quqdsHbVWbJaUbyW9NPWU0Wm5GxBt
         QXit0a3WmZ9x+hWm1uAd4BMvb1EAlypTDzd7JcJ/Bs5BoGo0sNFZkeCaNq3rziEIpBZb
         CLjaU3ZB+nigumHpTk0akZW5zarkL4j+Ktbek/N8njLJtMMofCLETXsmxaPn+7YMbK8v
         SI1LfzDKdX3isg9TlZJsZEXZEG37Vx5kAJhXYmwYYoCVbKLMkHcPA06GDFlOMB5tUKBp
         T1yAQDM/Y6rI9exzL6h1K3anb1M1UnCyxoeAtakNRc1zUX8n3zi6jhHaVeeXkdl3z9ie
         nMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784519116; x=1785123916;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yppHPM8M0gBps0sSHPYVkG0WqZkYvFLfEYcOEagnwfA=;
        b=VMh/te93jNCr66YJfmfjLBwY4tQYvWz2THwuMZCVHPSAp/yQnOEBH/O9jrlPg9dVWK
         6fjvWk5XXZu+Dc9xa7IyhtTjl+lHr5FPlqouttLCOmWTB+xBCgfw9m7V+ef2fnzphj1i
         SFnkW8I99F4Hy4B4rZR6Ilu/LdAI8gbeSxZ68o7HswsCbv2faYVftc+YDDJzH3gOrJXB
         dArUpY9Bmi5lP1Hmw6uVRMoDfyTGjXP9pqbvFRxnj3FtPF8i0riJt65FcWoLS79gJEHN
         lGiR/oqxHg2Xf4WBRjzXRRVxdu81VBE0YLaHnE1GL9XVTMZTKjkzhLFfbYI1Ot1jduFf
         ejRw==
X-Forwarded-Encrypted: i=1; AHgh+RowC4PfB2swrAJRvkCmzu9yBPmTp6jvzWzHJBEWrrzkCkWW5mmhdxOYGqqRvxMToBCD1uQ6Ai0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcGdjxWbeSWJJPWc7YhgjuB2INny420ITOi4h6HO7Z0VjJRDX
	DSuybwbYn+bLP9j7CGzGvNsz0g7GenFHpOSjIbQzNW0j9dBYSxwpR/5n
X-Gm-Gg: AR+sD10FChVQOrQ8IkpKXIAI2dWydRpmcajinR8n6V2TGeJBJxv6Q/3ts94gvAtq5r2
	64kjhZPDvI5dTAhTg2JXuA0EVrP+wrRo8g+MH5lxJE+Dy3oCcOCvRXkWpQtwLTgx9dQ50ssyvoS
	T0s8DX+J+hRRPjNyBTEAK0yoXbgZhLT+D3XrIyDegBi3L10PUqSrXFjzUPs80oq+FACk+vZ74fI
	1vAmNjxFdMxIr9RR/7BG9WqUu3r8+EWvTmJ0z188W4x9chrbtl9pouL/ATE6f3dvri3He4oXQY5
	nB98nPqxtmlmzX0R4JXaTVXgI958kU979sClOVvS/50W0URu4fXndzPSJ20zDx6rrVTwMt36TSe
	mK/FIwjkGKHhzC4XsdA0XevtFN6wQgv0b+1WAkGqW0NrTY6ylqWtHbEZuWZbfyYA89zL7MlBMyG
	wAoJY2MfZ6tnl/kUQE74xm4gu5fAUDrQ1RJEd8ZJ4QFFRKlDeAgmzhY6oqHbWoEYIMexUrIztVl
	xc2mlL8a4WUGg==
X-Received: by 2002:a05:690e:4399:b0:667:8b90:2e5a with SMTP id 956f58d0204a3-6683bd8a65fmr1830105d50.102.1784519116198;
        Sun, 19 Jul 2026 20:45:16 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6683b80d1aasm5357048d50.12.2026.07.19.20.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 20:45:15 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH] net/sched: cls_u32: validate offshift to prevent shift-out-of-bounds
Date: Sun, 19 Jul 2026 23:45:14 -0400
Message-ID: <20260720034514.23053-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

u32_change() copies the user-provided tc_u32_sel.offshift (unsigned char,
0-255) into the kernel knode object without bounds validation. When a
packet later hits u32_classify() with TC_U32_VAROFFSET set, it evaluates
`ntohs(offmask & *data) >> offshift` where the left operand is a 16-bit
value promoted to a 32-bit int. Any offshift >= 32 is undefined behavior
per C11 §6.5.7, triggerable by an unprivileged user via user/network
namespaces.

UBSAN: shift-out-of-bounds in net/sched/cls_u32.c:236:43
shift exponent 32 is too large for 32-bit type int

Fix this by rejecting offshift >= 16 during filter creation in
u32_change().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/sched/cls_u32.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 8f30cc82181d..e7a9a49353f9 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1107,6 +1107,13 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		goto erridr;
 	}
 
+	if (s->flags & TC_U32_VAROFFSET && s->offshift >= 16) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "offshift must be less than 16");
+		err = -EINVAL;
+		goto erridr;
+	}
+
 	n = kzalloc_flex(*n, sel.keys, s->nkeys);
 	if (n == NULL) {
 		err = -ENOBUFS;
-- 
2.53.0

