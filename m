Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBCE37E5FF
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380527; cv=none; b=R6LDnLvuEmG41QkYsX26GvC5fmio0+IIAOMcvvp35r0SbEV2aABepDPP0TalV0v4Bdd7cZWUA0fP3OWsNHCg0K5CHNEQA5CM7CGqmz25QzryY8smQYkb96RKYhHb1DAQp9iOhsUSz+HX0uJ5upxTEep1QDcOIyollLZY/jzb8qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380527; c=relaxed/simple;
	bh=B0vK6YTDpQs2GopgLT4bEK5kK3s52dfugzneav7KDeQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ho7gqq74uHAsbJozdTo7zDxdFlKuVi6PZEkZJ1J7Q1ttO+zME+0iaJN7mKSRCrAOwQJJngHkKxVOhCSigDj1PhjcrSF1ufjnSusLmlkpkLzQNx1TUXpeH1q61fjYOBqLG6ktW/mL8PWWfOvNNcIfyM/Xqjoa1J44yyjcfjbM11o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZjcAyXl; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZjcAyXl"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-381250979d5so1954998a91.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788380525; x=1788985325; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FNTpXX+qFZkepqUD97/CzK3xxhgqfbaP8aZpgIAie9U=;
        b=iZjcAyXlRuykVL9NPtJBFnE50xTrb75uqS571yzi1IkPqSQAO0Beb2jOKZb+6x0WU4
         pTuN8E48/jbLFAG9HKcceU4g1wfD4/4iOZr5dcxgdgoZxXebEJfnlqvWPOPW9CXHFJV4
         95a22t0CM98scVpGfwJCW4c26lT88WwFpWHCxNlr/LC91l76gf5+b1AfViH2drmt10ch
         FEBd253lqEq18Swcth/AUPjOC+zLXHR9hrQUtaptJU8tZR26ZIpONs/Y7gwjkxHV+RBv
         MwT/ZG6ET5YI4Gu6jD6U+WC5oxgwOFcQsLWwHgUn0eKongb7ilYHaxgIobuh77hdi84T
         Cczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380525; x=1788985325;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNTpXX+qFZkepqUD97/CzK3xxhgqfbaP8aZpgIAie9U=;
        b=rn3erSb7yod7IbKelxx2SQYhxQ+B1MfgMYE70Tawt8fdb23VaE6ULxgXzJ8qjsN1yj
         JYTIwbIvaFokDgtJfPBL+/O6UVWk9ZATzAE0TopwSMcx3DBDTAbSU0k1E5TTyYpbrN/v
         j8ZKl0pBW1PFpowi/Knn55BC7UL4xZwJEtKs9dBzzSWc6kyANgDt9fbpvSWvjl6zvHyf
         3lRamHKiU5mGuXN5MaIm2o88Ua2ZICZAeF3beJuJWHmBJTxZdCWLToSt/vE/SdEhRCDg
         avuiBKX2c4ZnT/vLBNHEpcUXoxgBcs21fC5c7+j4hZdVQUe53E9/w2VhSm9FAg7UAx/i
         0AGA==
X-Forwarded-Encrypted: i=1; AKwUvBz9Pc0TnnEykc3RYFSKhuaxM+Jw+BwF1WniCHSIVGcTeao31r1PWhWXxRpmBttlK0EnQiyMU/k=@vger.kernel.org
X-Gm-Message-State: AFuF++lR8RKDRzkh2AqSMC57Yzt/4qry2vCcQo9hZgWD5X9nvCd3m+Yw
	EmWBy7+U3T1kgpzS4k6u06D8WcBoHwDoZVjZCf9e0KcqJxcGrEvFyvds0hy6NKYiSboEFmIPhLx
	XYcB6jg==
X-Received: from pjbbh12.prod.google.com ([2002:a17:90b:48c:b0:381:171e:961c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfc5:b0:398:d292:e6d5
 with SMTP id 98e67ed59e1d1-39aee17a08fmr11907862a91.24.1788380524927; Wed, 02
 Sep 2026 13:22:04 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:21:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902202202.892676-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/3] af_unix: Minor fixes for MSG_OOB and MSG_PEEK.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Fahad Alharbi <fahad@codepure.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fahad Alharbi reported blocking recv(MSG_PEEK) could hog CPU
due to OOB skb.

Patch 1 and 2 fixes the issues and Patch 3 adds tests.


Kuniyuki Iwashima (3):
  af_unix: Update last skb marker in manage_oob().
  af_unix: Return immediately when manage_oob() returns NULL for
    0-length buffer.
  selftest: af_unix: Add zero-buffer test for msg_oob.c

 net/unix/af_unix.c                            | 12 ++--
 tools/testing/selftests/net/af_unix/msg_oob.c | 67 +++++++++++++++++++
 2 files changed, 75 insertions(+), 4 deletions(-)

-- 
2.55.0.970.g62bdec98f9-goog

