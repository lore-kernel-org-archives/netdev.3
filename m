Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch [109.224.244.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F61B425C
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880369; cv=none; b=bIBfXejZUL7R8a6tAJZrPDYqRUxqJVSfySHeEmVGCLDiN9AczytP7Q/VRBkpj9DDf6Hv0Sv04apl+RNY0E31+m+wVzJsrJtD2BFYV98TlCdhXn7mgsM4yBmrFeUR3F7ehEmnsAkGuQK5POAGcZQJi+m8Q2UPAFReKKHIscT3Hnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880369; c=relaxed/simple;
	bh=yNwHhNa+heliVuLXUrQko/d+H6PvZ1Ncj1k81RKd9lc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4zXXrcLWIhw//hS0BQY10WZm+YMOivy2flPfnIBlgExvMR6hAYSRm3kU/MuRNeDYidvHb98PaFBl01BuDl8NVdbbO58poX+3COKooul6ablutln/JS9sMFteraw9yqL3z4GPYPzXRtDK0vMj3G35OMSZri2zppWmFi+IuXOKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=PH1VnivB; arc=none smtp.client-ip=109.224.244.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="PH1VnivB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769871627; x=1770130827;
	bh=Qh+3JkFhiy4nIGSMFxn6kJmF5ZPrgjdBMWDDxS2+4/M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PH1VnivBgpmU8D1Ll8IP+c+gYhLczr3puNPVU67XL1ieYZx8FYgLPVsJHTAWhm3tv
	 sX9x2bg4CkNtwy9MjQp5zHYgcnPR8qlIYwvcdvtusAwxUZD7qCVfEwNoxyJuXC9Hlf
	 W1X3zvY1nvIM5UIEPwhD/x1oJIcR+rH0aX9UtsEWke4nRv8WB5ImZBb7b+B8Re51+5
	 aYK5VLeQdTqQBCgYIL1d2/bW1gAP2Bq7adSCqX5VwHduhe6zSc8kaVmcFME/iQEQ5E
	 w1R6rTgdMcDRcwepqnF8ec7sqUseKSB6gmYaIeeAMYyw96nH0dbcPrnZh1A9sFo/Do
	 +2692kznb/yMQ==
Date: Sat, 31 Jan 2026 15:00:23 +0000
To: Victor Nogueira <victor@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule list
Message-ID: <Pr4njxDDR8e9tElhovQfunuoyxlxUQdZqfdGBZg028rsKLPq4w1aYIUNKcAlF9EuqQHZjoj-9ocK2wEltjyQoRhUvsoKyZYveLK3oCAAd4k=@1g4.org>
In-Reply-To: <CA+NMeC-65UfJyq=34_K9tzf9J=-XFPJqDe1BxLNZv0mnjkxZEA@mail.gmail.com>
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-7-p@1g4.org> <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com> <412136f7-1d46-42ac-96f9-b6cc462204b2@mojatatu.com> <77q-JcImMG2fuQxj_GMUtYmaFAIuPrYMasj4I3aqIVID-Op24JIShBIPgt9kozLZgN4HvsGCS8Ez16mKq4Wq9juL1IOKydWUJwMwCYgHRMg=@1g4.org> <CA+NMeC-65UfJyq=34_K9tzf9J=-XFPJqDe1BxLNZv0mnjkxZEA@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 33c208a5f3561c0aaf6e1841e737ff64732bef69
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ok, just to confirm the intended behavior changes compared to what is curre=
ntly in the tree:

  create missing entry list      FAIL (got -22, expected 0)
  create empty entry list        FAIL (got -22, expected 0)
  replace append entries         REPLACE append failed: expected 2 entries,=
 got 1
                                  FAIL (got -22, expected 0)

- CREATE with missing or empty entry list now returns -EINVAL =20
  Previously, CREATE could appear to succeed if cycle_time was=20
  provided even with no entries, but it still left an
  empty schedule and later called list_first_entry() at
  net/sched/act_gate.c:552, which is unsafe. Returning -EINVAL here is the
  correct behavior fix.

- REPLACE now replaces the schedule, it does not append =20
  The old append behavior was an accident caused by reusing the same list a=
nd
  never clearing it. With the RCU snapshot change, a fresh schedule is buil=
t
  and swapped atomically, so providing a new entry list on REPLACE replaces
  the old one and avoids stale data.

- REPLACE with an empty entry list keeps the old schedule =20

Thanks,
Paul

