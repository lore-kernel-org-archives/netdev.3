Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261562673AA
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570062; cv=none; b=GhdrcmcrAqes/nu4x+dIsuMvyivqch/6qrl32oeGomhC+2y1Dtx+nqNGwzOz6YvN7qNF1TbP59JA9duwqObknDdNNbmGgQnfwb6PwV4qkQM/8QjlfkY3OkQC2jt8oHDeFVUw+eJO67yMyfTY0oCad4apoUOY/66mDpZU5JK/wg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570062; c=relaxed/simple;
	bh=0LmyQ00Ck04jQaIqLZzJpSz9VfDo7KjmLZWdKrbv6cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpGBJsjRjvxlL7XbQBEOvhxIpL+IE6QwV+vC1Q4tU57X/aWbk1o12yGxhIH3hR7ebb2QJhaZi3yvYsXnrlAZKq6Hn5gt1LXlUQffRCOWGKLFA0eAlatz9DbSEuCODPAs1xe9KLfD3W75L7qw/7zSa72reEgGzDTJngI+vtQNfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQmTTows; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQmTTows"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso47089166d6.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781570060; x=1782174860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6yM1xk7ypP2XlTdzKi2NbwQFcEcc7IeUirVA4naqQo=;
        b=JQmTTowsOHxNPQ+6RqGJkoV7n7PHnMVxcbij/xCkz7bCXtRNfrM7oSMTZfh3svu8Sb
         t/iIKig9ACHFfF2bhf3X27i75QjnvO5R0sxmaCt1R2UQuP6sjIsb5VDvCHhdYhZoUeD1
         Qi0ra+3hD6QlRORxHlKTGp1d7Pdw0tSXIbRWTTDzkSLpTbTPK6Tem3ahGVG2aTe1M0DY
         FVUTTXZ9ME3vcRqUrULgGyYyUis/ltEgwtxxNp1fcB9jb519kdV/ov4ChEDNj1xtDQf7
         sJuHTj9YxnaoRbLMmCd3/5/fNaC5+n3MoLVjTIAlUdKcvDUkJGndOHTuEq3kJkcoFgVT
         bK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570060; x=1782174860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6yM1xk7ypP2XlTdzKi2NbwQFcEcc7IeUirVA4naqQo=;
        b=eJmbheSpa4wnncviZgJyEUfUuMMn/BjBnJvgxXAhmgq7IY1FdH8CvqRkhQTdFWeb1r
         oCLpi90LG9IemDGpt3qlDFn8KXK9XMslpJrz/xH6Z2vDgGAk0W1P5mDtttpryRx45S07
         It+AeUWdFdFPucCtfLYF3cAOP4hF8wf743Qz4wjEj60j4gZ/GrZJzn0Gm2AMAsQMAqNi
         91k8qUXpjeWaSeOM5CObVbRSvmJ37A0CmGvghn3K2t7hsVax32JA8EsFtQcT/EJWkm4I
         lOTJQ2N8QL5fzWcTAoI0vp/j1EnFkY/KtwoHEXTu1qEkICznyD391tTp4HiyyiD3MDXj
         xmQw==
X-Gm-Message-State: AOJu0YyktEZ3pKcN32XwucEiU2CUjR8jC43SfDnDik/4+S9zT52AYScJ
	3SGzh4hLRKoJOumePcfOZN55aYjEc3XZFnyadzRZOQA2f7Uj+5ZEcyOVQWEBkSLD
X-Gm-Gg: Acq92OHT86WMezDVPF/kSCC5c+PJRSvKmqgWvzFs0Vfb92EzJQN2mi3YwwgHa4tRnI+
	s+CEnUoylZ8aEZ9ItB+hedqRqW4o7Hq/zLBuedP0dcCNqnFP/Ki/xV3Nk2u62aePV+8222+sAJT
	IAJ195GYKlEwDZlna09TzCqapV+2GDtUjzbEy8KSY8jNxhqsOOv0WFKHqh7LGNC8bOZSqUlrqjb
	hnxkzkcc09tfAQLAta4/87/eSQ7OE2yOxZFPrIpWMXcRC88p7tQgKECBi2r08EEQ3q3duPyzw6o
	hu2fX7bMtSNE5UxCrlFzN54KRofzWjeirgABVExnojG5rtdqTTVtZGYpApaxqnYeCsKqX9Xgh0G
	YuEHFSSEdb3EQ2e++2QhtogD2QKwByUWhizEodHZMmh31hjH7U8MVi54JBfkfBmq1kwZulZC8t+
	lT4/wVk6dhVhuVU7YVN2EOoBzp6F3JLfrftuP2AhgcfRNcBAoeDLX7VtDpBioNWPVqTNLu0Lzdw
	zEXv+QMXhCRM7lB9bUJWCPk7wVl/Y2Lx4hlPumAmIpWmy5Vn3L6DaxkCnfJSTvaB43IFO0kfb/V
X-Received: by 2002:a05:6214:500f:b0:8ca:1ddd:a6b8 with SMTP id 6a1803df08f44-8d32c7ce63bmr291687616d6.14.1781570060080;
        Mon, 15 Jun 2026 17:34:20 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f132178csm16794326d6.7.2026.06.15.17.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:34:18 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net 0/2] sctp: validate INIT in COOKIE-ECHO when auth disabled
Date: Mon, 15 Jun 2026 20:33:32 -0400
Message-ID: <cover.1781570014.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a security gap in SCTP's COOKIE-ECHO handling when
cookie authentication is disabled.

Currently, INIT chunks embedded in cookies are not re-verified after
unpacking, creating a vulnerability when cookie_auth_enable=0. This
series first refactors error handling, then adds the missing validation.

Xin Long (2):
  sctp: factor out INIT verification failure handling
  sctp: add INIT verification after cookie unpacking

 net/sctp/sm_make_chunk.c |   2 +-
 net/sctp/sm_statefuns.c  | 200 +++++++++++++++++++--------------------
 2 files changed, 99 insertions(+), 103 deletions(-)

-- 
2.47.1

