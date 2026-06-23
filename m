Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF222B8DF
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235838; cv=none; b=pemBM9NtGVJYFyVyZD6dxOYnJPbkYgNq8LoF8ZnPbvGkumQFoEkNrREX225xaDPu9fchPbzXAw1tf058GTV3TnFuqJdwbK8vzjC3pp1kTjlxERAjSVXFJIykvEb2Dl1nWyTYTlfOCnbauTfug1aPeU9RdG63E9gV9wejo3ev32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235838; c=relaxed/simple;
	bh=ioYi7GcamJsn90KVpyn6iZZp/MavdRPxcFcKwqGKZVs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JGP9ot75zHFq26rq1bgdjGuWFCE0u/m9a6tYMU5kjNdUzgdEYU7HxU+c90sCWNDqzWdldQt3YCzTEf9yXVD9ApTNVcVe9QB9WRXkN3M+bpjd/O1y0L065ZUKmnTBpHiuFEB00YX8uvmUoZLfc/ov6JteEN3rXhwE4fHwopYDSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+SuTrAq; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+SuTrAq"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-517878a92c5so301331cf.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782235836; x=1782840636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rcmW8M8dG6XYKq8c3St6rtT6Rm6Lmw1Yby76Z5jO128=;
        b=K+SuTrAqdHxEoErvk/d/dIOyZhkbfFYovjVkbUYA0i+DzMsbIO8dj2RcVWlMdLJs2Z
         /T1Hqm7fUT482DN4uAI66Rm0GlpWrOJ+UwxMCV01CQLkCn3PCLdh106afCC4M5isXgut
         JC2vEZF7BnyY1+qdsqE1y1LtMw+X/JdOPWWHij/pgx9deTX9yiKxN09kfMQ0+Ut1Apwj
         rKHALEUvE+hVGH2r9+8y9kC2Kr6KO6Zgt6gvb25SOjrhw1xQShv3khXy81ikAJTuD+iA
         8a+BDcOGSZqGXvTI6YJKlXKGZia3LDd20koEfR+BY+m0iK5DwaGOu7quRfmnpyyNPEJR
         IjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235836; x=1782840636;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcmW8M8dG6XYKq8c3St6rtT6Rm6Lmw1Yby76Z5jO128=;
        b=HYQPgFE9LhG4zETeH5toAedsG0yy3FzarmMTE2y+vA/Zy07bNy6VVIkF5yl0iAEx60
         wAfagNeBAhsZPYdqk34s66qoG6I/MfRVOzKFSuvImp06l4uhkig0+NsHaQiz6dXj2zdh
         Dueku2g/QCW67qduaiZH4Ommrk/hfSK2U87hCZh+rndrCjnSl3P1iUVfEeeaPDZ9cBFi
         DKp55SLN/nUMVeSSb2K7bUw6VCj52oEAUTQFdsTrJpVwcOz2VUMH6M2ZYLXmpzez5/5p
         M1oXqAoo5eiAKJ3fOUWjhPxRyk15T7VikhGWVvmGe0r8vt+K/uZRJBLiPVPyarPyjKNt
         cqvA==
X-Forwarded-Encrypted: i=1; AFNElJ8Xiu823sk0/W7stIRq+nhCO+dP+W2LEzIfFJi6wy+dMjxCsjKI5gLfWcdQSbykhmb18+POsxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkURsZLpNdrzPJdmC3TTIIaR2SYBCfN5G5OB1ljaJCaEcRRBok
	5m9poitp/fjZcmrOhYnkI6PWhCPh+rcQ9TBnHuLuCpDfk7URcvWlXezBoA62C6DToL05R/GQkm3
	C/ZIBzOBpzUZ/3w==
X-Received: from qtwy8.prod.google.com ([2002:a05:622a:48:b0:517:697f:f2b2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1484:b0:517:75d8:b956 with SMTP id d75a77b69052e-519e4c6689cmr306690041cf.40.1782235832046;
 Tue, 23 Jun 2026 10:30:32 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:30:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260623173030.2925059-1-edumazet@google.com>
Subject: [PATCH v2 net 0/2] tipc: syzbot related fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, tipc-discussion@lists.sourceforge.net, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch fixes a recent syzbot report.

Second patch is inspired by numerous syzbot soft lockup
reports with RTNL pressure.

Eric Dumazet (2):
  tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
  tipc: avoid busy looping in tipc_exit_net()

 net/tipc/core.c      |  4 ++--
 net/tipc/udp_media.c | 19 ++++++++++++++-----
 2 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

