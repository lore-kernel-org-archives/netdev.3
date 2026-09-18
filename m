Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54F4AEBC0
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738858; cv=none; b=A+Ap6f1GtnD0ausFNrQl15Ijz4DWDPww2U0iN8zhepqorDOTe8NpUrGOQT74ilZFLtx6FGlTWJl3dfpIYNI0eZkq54hLY+Qr6mKAJ3pZiIRVVJzzsvpOpGckS0kJTBgxtzCtagL+bdh06lc211WcX5A/g5P0gRryjh6SZvfs2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738858; c=relaxed/simple;
	bh=qhyuo27wL8dOZ4t7i/6sns1OCJ7PshGao21UmCh/3iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7XYU4IwBNzGusXJlhJvJc47/xNHw7n4UmcpIjyvBTxA/U35McsZzcfsfE7uyXtTHjFXJR8ctJfnNx2rwHvzF4YH8G2BI/uiT5c4xMmgw2zQTCMa7eQqhFTAG54Dr+7spWYdMlbRfeNqawJf1XCgOkhWNbdfNIXgXKlGHIXRfr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3VQqOnq; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3VQqOnq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351832so407308f8f.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789738852; x=1790343652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A7hk4kSUlQH1wBSNdgK7hn061of3Ek8pFYZgMv0vOlo=;
        b=n3VQqOnqX+Aje+gLo3NPBgQcGs1lOzw+0JBQug3/tV4zoXV5Z48cvgOAKFelh+Apw/
         GjtHg/s+zbXYilCh70oh3sNYMiMDb13RgtRMGr4O2LYupEd4LBI6gsLlsKMFosnHxwNF
         UoPpl5XiNixwJJMgbHDpffPPf8KurIeq+MZfe8bOccfDo6EjCU4Kq2rZTzWc++H/JFEo
         Nm4hIQL9LLi9Qqf+idWA/DvT6lqQFTBG3lFaUsm7Fm583cYkzV5HvQColeZgoSWYQp3i
         QCDe/SiGQ5425OdLuxVbcwAa99uC6d4FshAShUkW2cth83tHU82IieIDwahaLThDhVjx
         Rixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789738852; x=1790343652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7hk4kSUlQH1wBSNdgK7hn061of3Ek8pFYZgMv0vOlo=;
        b=rwHh8xtq5y+1X8R2Vkkgjy6mb9SLLigD+CTA5+d2iHTKQ96XiZLlirGNwrkPhUlr0A
         bqUYRP1soZcHjyXJS9kwaJU1TlyB19uuwhG8VB95HcFCkpFluSu2VkuQAcHpymaefvl9
         vPo9Emdk6qu3H2wJN2Cafrut8nkw6VGfRR0PLA8sKZRKYvcXoiDxAxW0OVDByoNSg2Tz
         /Pe/JtkPYRlbkBo6DRtJ5QGWDOCkTgWdXshyzcXT/hMqxuveFvIZu5yxCKBeIXtIlvWW
         yMs1c1xDXR2qfRexX53UaUn+8Bi5UdlmQwustg0s8VCt8h75t9vD4eQSwtfaI2u88SK3
         mTZg==
X-Gm-Message-State: AFuF++nqMxNuLrOaFqHPWGB3/tG8gqjVeYaakFte+muxky53pug4ULpw
	ezOhlqH9/ADqY/Z4ujaLxwgkwhdX6Vqgoo0lHF4othfozevPSXIhhSGlRE4SplxQ
X-Gm-Gg: AYBFou2e6Wg4aU7bNsvwtV4sTr1tLjkAHHt9s1WSQ97bQXeHjTpkMXzf1bYzQSeX5xC
	i1GMfuOadmzExvHnRzB6Q+ShH0PY1nf4VHHkRcsILsv/Oibg6R4HEo/mViJ1J16qdqYn5MlfTYG
	9o4Pk3kyeXhYh5A7m2YrxY9UPRMqnTScLRp04ol98hT/4/KXhqP5Sxp9LslC5Xa5/tfJXuRZaX4
	7bh5EWI/WazsmA67Vef6tlBXMA7/dYDqUTcoUycmJvZhk/UbKIVuzYBogxRXVLOM/4B9H9SKamG
	nIijrmf7KpqX/2xcaXY3olOFgjIiCBpqb46IKnk3ypdCf6kQIZMJYM6DMx4OKKU5fSdLxV4E6ek
	5YPy1vsxwm4WcSc+KMlumTbMf8tQ1+haNA0B1kfGNIk+RIPB9WJq+Bqkdne0P7RYGlb4t8o5H8Y
	4TFfWj7YY0Ok+85Y44PQP7ApSmJb/yPJuhNOUlzhqVczJ11kg4Q6d5AjFuTlHDxWn4tZuK6vMRI
	nlqeN9Ivr/jRSZrfHase/Qby0aJqxNkKUIm/EL59vuZGcNS9EGJ16XMMhckmbrhSzNa//JukW2m
	EDlQlcu5Uq9nKtAur18yL/IVpV8DuVBIibu89J+PuJmSIMaEfQ==
X-Received: by 2002:a05:600c:474c:b0:49e:817a:ca7 with SMTP id 5b1f17b1804b1-49fc56c3c34mr35521715e9.8.1789738852113;
        Fri, 18 Sep 2026 06:40:52 -0700 (PDT)
Received: from localhost.localdomain (p54a14b85.dip0.t-ipconnect.de. [84.161.75.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd225898sm168149865e9.9.2026.09.18.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:40:51 -0700 (PDT)
From: Bernard Ladenthin <bernard.ladenthin@gmail.com>
To: netdev@vger.kernel.org
Cc: Bernard Ladenthin <bernard.ladenthin@gmail.com>,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	alexander.potapenko@gmail.com
Subject: [PATCH] net/sched: fix potential stack infoleak in em_text_dump()
Date: Fri, 18 Sep 2026 15:39:37 +0200
Message-ID: <20260918133953.12494-1-bernard.ladenthin@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

em_text_dump() allocates struct tcf_em_text on the stack without zeroing
it.  strscpy() writes the algorithm name and a NUL terminator into
conf.algo[], leaving the remaining bytes uninitialised.  nla_put_nohdr()
then copies the full struct to the netlink response.

KMSAN on Linux 7.2-rc6 reports two kernel-infoleak splats from this path,
one triggered via "tc filter show" and one via a raw RTM_GETTFILTER dump:

  BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x1c9/0x2620
    nla_put_nohdr+0x83/0x130
    em_text_dump+0x291/0x550
  Local variable conf created at: em_text_dump+0x5d/0x550
  Bytes 168-179 of 199 are uninitialized

I am not certain whether this constitutes a real security problem in
practice: the test was conducted in a controlled KMSAN environment and
the leaked stack bytes may or may not carry sensitive data on actual
production kernels.  I am reporting it because KMSAN flagged it as a
kernel-infoleak and the fix is straightforward.  I can provide a
userspace reproducer on request.

The original code used strncpy() which zero-pads to the destination size.
Commit b04202d6065c ("net/sched: replace strncpy with strscpy") replaced
it with strscpy(), which does not pad, creating this condition.
Zero-initialising the struct closes it.

Fixes: b04202d6065c ("net/sched: replace strncpy with strscpy")
Link: https://lore.kernel.org/netdev/20250327143733.187438-1-richard120310@gmail.com/
Assisted-by: Claude:claude-sonnet-4-6 [KMSAN]
Signed-off-by: Bernard Ladenthin <bernard.ladenthin@gmail.com>
---
 net/sched/em_text.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 343f1aebeec2..4132f8c3c5fc 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -113,7 +113,7 @@ static void em_text_destroy(struct tcf_ematch *m)
 static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
 {
 	struct text_match *tm = EM_TEXT_PRIV(m);
-	struct tcf_em_text conf;
+	struct tcf_em_text conf = {};
 
 	strscpy(conf.algo, tm->config->ops->name);
 	conf.from_offset = tm->from_offset;
-- 
2.49.0.windows.1

