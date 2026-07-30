Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA435C180
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422819; cv=none; b=uMuqye5fXqeJYgeY8U9l9JkOwaqPMRPRcV9ZCa2AaipfVcebYfzaO6OEcGYOgPiyb270LBTOjo4OR45c3bUW0A5pTqd97Et8uAcIKfy57KOBVdId6qTTYheIFq0YnhQgY8xzaMuiyn89Wbe3sOfqs1m6lN+eIWfutwe78eHx57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422819; c=relaxed/simple;
	bh=fky8gcypEoBJ3AGom61/sbvLSrOMTaQ3+6aPyUc6spY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8kr7jcdApj7atFgS0ErzOqDEEI23UL2V1YgTQ3jP9SHICr+SVGRjpr/qnCnmOwMSNomOv4BTzvTXrmKFTg2DOtxHtvcD0K0Nki3zdGjc1RBbmQmvoiqJKqn4/Nj0xc0+8b+xLhhXnp733PhLlifWdHZ/Nc5QN9zo9XWmwn6tBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+P3uh1F; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+P3uh1F"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so13279805e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785422816; x=1786027616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G6LXRZrc4Zq8r+P/Ny5YSdNSE7jhUxZKcv6RzfqQxUc=;
        b=f+P3uh1FAQSg0OoAxNmqlmARiHZTVBMshWu77enJusEmMWXvij6xYLeed9x9xDr4Cj
         u55h3xBM5f4OLw1+XtrdWzmVM+/uVhb56eO3cUINgeb30mqPmlWN05ZY1qQKMhZ+dRUi
         41J3Szsps61896LAdjwvei8kxJEo3x3MR1qmGVK8hMnDA2QnFWuSA5XQEj8FTJnk5JgD
         Ss76Sg80iDpkppFUXXyaAU1PoWHZ1sKK+oGvZyMaOmdXO+UehA79ZgLOKvx1EE6VTdQY
         XMSC5KzvK+euLD04xg/B4fVWDHYtn21hYxRdtBr4A3jNQoTb6fR+YC55k1mLxuB4OPY4
         Fmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785422816; x=1786027616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G6LXRZrc4Zq8r+P/Ny5YSdNSE7jhUxZKcv6RzfqQxUc=;
        b=U0hrsO8gzE8gjSxu0dzfRk2LklwiPv3tIiP2gYpUI0YuHXZW6vtjMiti3mDeACyx++
         tvynu73Kjxm2q6dnBWLh1kD7pwR/M+yf0yDOTXOfgH8lJ+ai/b39iqxqovKvsY4gmbZa
         +8sMZkJ/yX60BPe+/oG4AtHWe95Jw07Di/i3B6vamb8wYqG3MADjjB0CZP5BCjEXoCq7
         ihf5OCEfcQ0dCjBAu/Ux/vqCb1RhNy3XVuE5INPsM00WMlZFPymAJws31jjBYwsSAjs5
         +ILpkljpvEKg4/bssXhNFkT/sipx4pcqEjXRpIgnQRB5iP6FZ0qmv141n9dKl9jhexHV
         GKHQ==
X-Gm-Message-State: AOJu0Yypbeif3CHwBbGd0NqmN+sbiPJeGxUErW0BE0leA9VK6HXXtX2x
	HXNgM95Vxs2SmUGjKxQFUqQQG22LfEyCFfSTu4Kz4jEZZk+pRWx6GoVDdWoY1Q==
X-Gm-Gg: AR+sD12Pp3v6+KM3oW4Eife706iPhpS2DIDwt4w0ZcTKoYg/nQvc++tKFpSP7/MxJIz
	ZsgfURnFLWNzImryhtdfXbXgDQ6wl/yPF8COEYTIQ30IMmqlwn3hUqSsKQvsXLPXWmgfvRqqUZD
	uCtts/u4L+psB6zu0w5JbMJ0pKmmIXOSzJN279Hogz3FgQnk8+D98cUOPfGBbM+VTUp3bftEsys
	VdU99830khzUFiWSPvPvbxvaqtJeR/1EO9gt5DWoG7O8F3g1RO0D53KtQUIyAKSPnW4P9GcPj/W
	pzcKmUyXaWaPlK75YY3Sa8iIH9DqEpYmiN5/wQkfPohDiAvBjeJbNnKxZQjRWgQGfWWZafSxv8F
	DwqAw0KSPHjBPKrvVdeBisxVVJnWf2RuyONPx0zreeVYG726+KfPdQOE4hCrxLWEMEUFZNOqqhQ
	VkfzthUeeUJXUpZhCAXc2jlY4QYsnY1OvtsRnnsB+glILI9qBve0TRRW/MIMmG+81rp7k7vW41R
	X7hWkS2Q9T4SpzE7MhBSfzW07cxgqHQBQ==
X-Received: by 2002:a05:600c:c05c:b0:495:6060:d6de with SMTP id 5b1f17b1804b1-49800ece23fmr27592965e9.31.1785422816099;
        Thu, 30 Jul 2026 07:46:56 -0700 (PDT)
Received: from localhost.suse.org ([37.109.160.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011e4ed5sm64491575e9.1.2026.07.30.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:46:55 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: netdev@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH net] selftests: af_unix: skip scm_inq tests when SO_INQ is unsupported
Date: Thu, 30 Jul 2026 16:46:52 +0200
Message-ID: <20260730144652.5715-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SO_INQ was added in df30285b3670 ("af_unix: Introduce SO_INQ."). On
older kernels this returns -ENOPROTOOPT for SOCK_STREAM too, which
scm_inq.basic/partial_read currently treat as a failure.

Enabling SO_INQ here is only a precondition for the actual test: the
SCM_INQ/ioctl(SIOCINQ) consistency checks that follow. SKIP when the
precondition itself isn't met, rather than asserting it succeeds.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 tools/testing/selftests/net/af_unix/scm_inq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/testing/selftests/net/af_unix/scm_inq.c
index 6268b5bf50be..2868cce61a9a 100644
--- a/tools/testing/selftests/net/af_unix/scm_inq.c
+++ b/tools/testing/selftests/net/af_unix/scm_inq.c
@@ -111,6 +111,9 @@ TEST_F(scm_inq, basic)
 		return;
 	}
 
+	if (err && errno == ENOPROTOOPT)
+		SKIP(return, "SO_INQ is not supported");
+
 	ASSERT_EQ(0, err);
 
 	err = ioctl(self->fd[1], SIOCINQ, &inq);
@@ -136,6 +139,10 @@ TEST_F(scm_inq, partial_read)
 		ASSERT_EQ(-ENOPROTOOPT, -errno);
 		return;
 	}
+
+	if (err && errno == ENOPROTOOPT)
+		SKIP(return, "SO_INQ is not supported");
+
 	ASSERT_EQ(0, err);
 
 	ret = send(self->fd[0], buf, sizeof(buf), 0);
-- 
2.51.0

