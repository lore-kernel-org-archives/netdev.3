Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F2480949
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380530; cv=none; b=AA1H9pdCZEQEeZRxQ13bLZ6Eu4KCE9k1elVtI7RkSs7UwpBmDJ030josyOjtjQiE9XYD2Cw9OxCuE36i1u7oixKFJYCv/WY8ZJngFNTbP75b5JRzeWMcNn4ldITJGnNlBY4pzEMmxF7cYsUAuJ7VpsP2TQS5q416lZKiUR1ck6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380530; c=relaxed/simple;
	bh=jhht/RBrxmhHdLB7HKQVqD2q171T00DBT523xB/csUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BH4UfU0AdGRaKmu8EzKZ/P0KvkIODW5ohgdNVhx+cH/pqebdQcv/4CW21F8+NUp12ZlSc1mYvYdnnk5RAp3x64g7pNsWo1T5O6VGXl+EROS/0PmoY+8JKTfgVkbK+0NIOqgOVfJYdKH5omcaBcnwezqkf6KLxTPoAOKkqGnLI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pwY/x3wS; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwY/x3wS"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so15241985ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788380528; x=1788985328; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R60Je+LB9oGc8/prn9VC52sXsZKtbIqw9m8r+YvTlqo=;
        b=pwY/x3wSZ88O3kHkIc8CRc9UodUrJVGf2+0bWXkSkCWrHwrMYezZ2Gsek3avDcztfL
         G4K/rQIOt/lhX5PICEVI0QB5/yfqRLBJ3UxxzTo/7T3DJCpGqyZUcCSf1EWd6SercqrV
         OmnAutfumbsm1X3mhrWJ7NHUvNxKmQLgRS0IeF9O0QVLjUkanW0KirwfqDW+98GrrXAd
         r2yIYoubKgZNRIxNk8uMeP42pD7S64VeX7VfOau8COJn9cbdSDFFzE9YU4wpqxlMNWRY
         7X/MPtfQcHqGojv+KW8Cb65remXLamOfOdBzKjp3JGi91W5I/s03zJTTAXreq/8nZltW
         OVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380528; x=1788985328;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R60Je+LB9oGc8/prn9VC52sXsZKtbIqw9m8r+YvTlqo=;
        b=a93JXTbDpwQlboN7nSqSB8UsNJCP7qPQBsM7bfkpH79uON9r21YIV7dVwiaMiP3yno
         Y/N3mY0ZFV6akcFWLQTKebesx0wO8h1G1qwxf4xK+NXRdmu/O0e2k1nxYhy95N7Ntclh
         KrfRmc5RuUFwr11SyHymPlpnPWGNQ5nsHMNgDogHoX9vip9bxpsmvQDomAhVjSNkhbBp
         c/xIpOstCY5rJE+PJ+KlCsnuFltiR2nqOsYrWnWHSqjTxLksXPx9kGTO+S6YVyrXGbct
         lYTzqYj+1si78nYp7usQSJAigGPwyffMueYR25Txghj3zBcG6bD3isk9u4dRY2SuJd9W
         BVjg==
X-Forwarded-Encrypted: i=1; AKwUvBz3dGpo4i/DUQQkSBSO2b70U1eT23GwVDhk2xTh55z/HbIMNk3D0W0GfBeqn67Vfc52e8FyxGg=@vger.kernel.org
X-Gm-Message-State: AFuF++mOJx+zXnJ7BfOYsu/ncIRhbQitxt6k8TfuZ4h+zrMVDc0MFrZC
	qq0Bh7M+R3LyE8+GAK1D9f7k9tSuH+7hH1yN8d15ound7NCRVKk6cRX/N1Qsae1sjnHfKU5Q6EH
	pgdIAKg==
X-Received: from plry7.prod.google.com ([2002:a17:902:b487:b0:2d6:dcd1:657d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e805:b0:2d9:69c9:2815
 with SMTP id d9443c01a7336-2daec6054a8mr91907305ad.7.1788380527339; Wed, 02
 Sep 2026 13:22:07 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:21:52 +0000
In-Reply-To: <20260902202202.892676-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902202202.892676-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902202202.892676-4-kuniyu@google.com>
Subject: [PATCH v1 net 3/3] selftest: af_unix: Add zero-buffer test for msg_oob.c
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Fahad Alharbi <fahad@codepure.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The previous patches fixed two issues related to zero-length
buffer with MSG_PEEK for MSG_OOB skb.

Let's add corresponding tests in msg_oob.c.

Without this series:

  # FAILED: 50 / 60 tests passed.
  # Totals: pass:50 fail:10 xfail:0 xpass:0 skip:0 error:0

With this series:

  # PASSED: 60 / 60 tests passed.
  # Totals: pass:60 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 1b499d56656c..f051d79f7a8e 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -290,6 +290,25 @@ static void __setinlinepair(struct __test_metadata *_metadata,
 	}
 }
 
+static void __setblockingpair(struct __test_metadata *_metadata,
+			      FIXTURE_DATA(msg_oob) *self)
+{
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		int ret, old_flags, flags;
+
+		old_flags = fcntl(self->fd[i * 2 + 1], F_GETFL, 0);
+		ASSERT_NE(-1, old_flags);
+
+		ret = fcntl(self->fd[i * 2 + 1], F_SETFL, old_flags & ~O_NONBLOCK);
+		ASSERT_EQ(0, ret);
+
+		flags = fcntl(self->fd[i * 2 + 1], F_GETFL, 0);
+		ASSERT_EQ(old_flags & ~O_NONBLOCK, flags);
+	}
+}
+
 static void __siocatmarkpair(struct __test_metadata *_metadata,
 			     FIXTURE_DATA(msg_oob) *self,
 			     bool oob_head)
@@ -347,6 +366,9 @@ static void __resetpair(struct __test_metadata *_metadata,
 #define setinlinepair()							\
 	__setinlinepair(_metadata, self)
 
+#define setblockingpair()						\
+	__setblockingpair(_metadata, self)
+
 #define resetpair(reset)						\
 	__resetpair(_metadata, self, variant, reset)
 
@@ -888,4 +910,49 @@ TEST_F(msg_oob, inline_ex_oob_siocatmark)
 	resetpair(true);
 }
 
+TEST_F(msg_oob, zero_buf_oob)
+{
+	sendpair("a", 1, MSG_OOB);
+	recvpair("", 0, 0, 0);
+}
+
+TEST_F(msg_oob, zero_buf_oob_blocking)
+{
+	sendpair("a", 1, MSG_OOB);
+	setblockingpair();
+	recvpair("", 0, 0, 0);
+}
+
+TEST_F(msg_oob, zero_buf_non_oob_oob)
+{
+	sendpair("ab", 2, MSG_OOB);
+	recvpair("", 0, 0, 0);
+}
+
+TEST_F(msg_oob, zero_buf_non_oob_oob_blocking)
+{
+	sendpair("ab", 2, MSG_OOB);
+	setblockingpair();
+	recvpair("", 0, 0, 0);
+}
+
+TEST_F(msg_oob, zero_buf_ex_oob_oob)
+{
+	sendpair("a", 1, MSG_OOB);
+	recvpair("a", 1, 1, MSG_OOB);
+
+	sendpair("b", 1, MSG_OOB);
+	recvpair("", 0, 0, 0);
+}
+
+TEST_F(msg_oob, zero_buf_ex_oob_oob_blocking)
+{
+	sendpair("a", 1, MSG_OOB);
+	recvpair("a", 1, 1, MSG_OOB);
+
+	sendpair("b", 1, MSG_OOB);
+	setblockingpair();
+	recvpair("", 0, 0, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.55.0.970.g62bdec98f9-goog

