Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706430ACF1
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182537; cv=none; b=Hv+1P1sDw0xRt6ReU5t+kQ/fGS0WRGUUgBKDLnJKBEtgRGe6fak+ROp9jrhgFR+mFGFaGdznp3yapQ5WPXx7GBLLdRThyfb6k9LF04/A2nM8fAbNKQT6j4Uk5ftvVuadgdnp7xWRh9m3LSbp7Mp+kcLMd8npZciP7P83n+jf1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182537; c=relaxed/simple;
	bh=ZLwXqCq2Ap0KvBU7wGFoUaT2WepbIYKAMa8XjpenRKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XWFhWFEYqbo/iepalaDgGzoYRDbBSvTIAenRkbD5O6iVqI6B5Va9dNemnXNK/c9NC1dFCnJGlDkcpdbPe5qZr1DnmMJRzOlB4byNJ8ogoFQKy7QhU0oFzAFrpxdSD2DVPTgCb2m3Q0I4p/W8VEPhMLkhGzvCZ13PwxulH2dxmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzh0OeSN; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzh0OeSN"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1b8088203so1646029a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789182536; x=1789787336; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R6dTHggqsEilI1RnNJzH72nIojYbnjwHQf8gB3kiS3A=;
        b=tzh0OeSNLV4TU0Y1N3wje3qsYxhJBiJe0BYssjeGpHZ+Ba/SrvNJkKoGQm98pHmxNW
         qbb/8V50uqUhMg0gsR0RETMwg7PembZ+I2oEVse/uKRQ699PDfVFK0CN7aknQCd78QEX
         lRA7mC+gtumRWGWXrHIrLnXbfFKpPvJ+KxYG27fFSLjfaWYx7PYJvdOOeQXAvJ/fKoKj
         MrGCbEDqhCGf5RSbuR1151+IB9iRWHJhxCNkGgynpka0X7nepTjdAegoE31xrQVkJhVJ
         nneRIS2U3GS5rFLkQXt0NkRBLLwTnwfXUKQVAs30MtjC8E1YJc8z/BRc2P0zbTGDpy+N
         CUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789182536; x=1789787336;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R6dTHggqsEilI1RnNJzH72nIojYbnjwHQf8gB3kiS3A=;
        b=dtG4D3ENgaoNJku+Q/odNnHpE3/hv414r/1BqnYByFvwCIvLTtzVn4pUWfF4mNnJ2v
         uzv06pt4m1fEvAt4d1jKrzlZGcb1pzw5rqlhtIcxkAZBlmcudwJXmkFfugZLv3bOxD4m
         ++A6ZNl2ciAKYQNiqzskWbWxe+F2wygcJJXy5FMTIeqTUoS8l69sANZPfs89SSTTYpC1
         a5nO+EyVP9i/S4475RMLg8wXwQGvmrDDYyp7c5VTzBQgUE9AQ52gB/1JRyh3iH+W4V1W
         9wwUbsrRuOrWdfiuMTaX66TQ68kkkDmRxG1QkRoS2S/uFSFy2EMGxBvdKonYpeAhA05Z
         32IQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3WT3fu+fGRXcqNZ0So+/adFv4CnQSuEyhHRY7ezgMG42k7sWkT2g3YZA3znEuyHoEGU8W0zc=@vger.kernel.org
X-Gm-Message-State: AFuF++lGp7u/lKvjAHQ+lJ2s80McSb2kqaNa+uU04OORSBRrYjkM6ghv
	OV/iyAqMnDp2nKCoEJLTB8LFajqhW1+k7WUzj+pvuKaRyjNX0hVrb0rMcaWBNzSgfpcKiDX3FgX
	IVbSeug==
X-Received: from pjbpc10.prod.google.com ([2002:a17:90b:3b8a:b0:383:7b51:b1cd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52cd:b0:385:393e:7124
 with SMTP id 98e67ed59e1d1-39dbc699006mr1971035a91.14.1789182535888; Fri, 11
 Sep 2026 20:08:55 -0700 (PDT)
Date: Sat, 12 Sep 2026 03:07:52 +0000
In-Reply-To: <20260912030852.1467872-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912030852.1467872-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912030852.1467872-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] selftest: af_unix: Add test case with mixed
 lowpoint in scm_rights.c.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The new test case creates two SCCs so that each of them
has multiple scc_index.

Without patch, GC cannot free the sockets and the test fails.

  #  RUN           scm_rights.dgram.mixed_lowpoints ...
  # scm_rights.c:176:mixed_lowpoints:Expected 0 (0) == ret (12)
  # mixed_lowpoints: Test terminated by assertion
  #          FAIL  scm_rights.dgram.mixed_lowpoints
  not ok 5 scm_rights.dgram.mixed_lowpoints
  ...
  # FAILED: 45 / 50 tests passed.
  # Totals: pass:45 fail:5 xfail:0 xpass:0 skip:0 error:0

With the patch, all tests pass.

  # PASSED: 50 / 50 tests passed.
  # Totals: pass:50 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../testing/selftests/net/af_unix/scm_rights.c  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index d82a79c21c17..c165f250220a 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -378,4 +378,21 @@ TEST_F(scm_rights, backtrack_from_scc)
 	close_sockets(10);
 }
 
+TEST_F(scm_rights, mixed_lowpoint)
+{
+	create_sockets(6);
+
+	send_fd(0, 1);
+	send_fd(1, 2);
+	send_fd(2, 1);
+	send_fd(1, 0);
+
+	send_fd(3, 4);
+	send_fd(4, 5);
+	send_fd(5, 4);
+	send_fd(4, 3);
+
+	close_sockets(6);
+}
+
 TEST_HARNESS_MAIN
-- 
2.55.0.1007.g17ff1f9808-goog

