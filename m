Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420103;
	b=xX7YFjLT71/wX1EcGAllVnjvqaN00TR8CSogVYgOfzUC8fp+6F8aOZQolcAnr678LehZ
	 hNzAq5W30w2YDTqID3tWMpHV+nBYhhf9T0HaagB/WnsUaNF1ZcIsry/e4PAwKxPnTZspd
	 C2MaQ9uqV/PvNcnhjbITzGuQsoK8JD6HbzloEa7ugtuY64ibX5Cs/1AJVsn3ssNS9lTlI
	 /it88ldog5JLH0vG+BGAPggyo5XrQv8yMOomdo4GHbRuzqZpUa+PWQikIAGvgPRDlznUv
	 mYTPkKk2fsDjIrFhIlNEZ1yGIS12vspfb/7SD0y1OjSm2BZ1xLGN7ZpLTHrHEbDl5MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=//OtvncOxqkH1qXVs2mmLokVSDfmsZG7I/PEFZI4LlQ=;
	b=WDcEUl0kkf7andKGBw51EVo6BrwpqB42P77Me0gbfXoMu2SdhzmS17ri5LDUfDIBh7vi
	 hiuCAlUau1iHNH0xSVuisHSYLduXnDtWctygXGQCim+jdUz7BV24q9jsW0waDvoYl0VBj
	 jn/wLfRZll5qcxHxl6q+cuFr6Cu2tjxqgEZUf6RrUb7milmf119lCbvQC0ih8vGFcTfCQ
	 zFJHoMUFfNEFDvBGHPFFwdPsqfTU6x4WEsvtIdn353xHYoqbWxfAK3AFohemgLMhKnrMI
	 XWBwMwjG/BGTYlfrp5X2e2091CnPTaDkuxz+KYPkdGQYPG9N2BicJl1oja4yunYaVCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5SHIvSE;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EC606A31D
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 04:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 271EC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5SHIvSE
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso532051a12.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793420102; x=1794024902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=//OtvncOxqkH1qXVs2mmLokVSDfmsZG7I/PEFZI4LlQ=;
        b=p5SHIvSEVlY2N5MeAMwJeRbnig0B8IWyv0r1b2hO8nqnB/xe51wEBZs5wYwgYBLZEi
         1lJS3cn+rrNv245sBwLfKGGLd3TEDBxDT9/wZhliIHs2lEjN+Phx1gh/OgvLZ5Ca6/EG
         EXOsfmlW8WsFYaGve03aJwsWt859aznyZBQL7T+c/WjP27rX51p9w6nq0IDEf3Hpc4w0
         FDAlncjhjr0PzrA+5G0ozhd827+n38kZ7nTdvvAMGUXuQXrYxyPVHpmouG3kgTaUHw3r
         aHFPTbjMemgwpz5Cj8DWbcEzXr4CGyE5oUvpJkQheBfrCoJKqzRrIkctwR/k5aXmw8T0
         zW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793420102; x=1794024902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//OtvncOxqkH1qXVs2mmLokVSDfmsZG7I/PEFZI4LlQ=;
        b=eZKdvBV2EAlsWHE5oMCzFo4Zbyx0EOxYuAYvONRo8vpx/UEBcOQbg8lVVpJ8UW+XDp
         BI4osZWvHddK8YZWSjqC6m7W+Wt3l/z3ohoX70RNqCmyHKkEyc6kVijpw4QIYdhcGvqV
         0JtYCWWFuqMQioHy/0iPTkdftcE9mRIjQH8aQX6tmPArY/MWAFwM9gN77444F1CGV+Js
         4CFbw6Jmcu0EPX259SI91zaW8HmvExGcH3sSF8P9ezz3bJJUx/fFGInlUmqINchFeIO0
         7rvOa1Jy9PVBf6fF/zuozwc7PdjBIy+echoqvD9C80s6sB0HnV12nFq0ULnlst6VSZcS
         1Tuw==
X-Forwarded-Encrypted: i=1; AKwUvBz6YKgtu0a8551BFwof2wsaIxbffpNSn69vK39ygA1/eSRFA+yVWXKkhPSCdVqJrZzjRwi/Zz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRuyJsqys8+C09XetpYzinnTAEjk+AC73+5TqxouN/OO2tTiF5
	YpQWBYchkQowrgm7Y1iZXTGQLq5sr1SutOadOgtQ3GZ/XNv+5nmENhim
X-Gm-Gg: AYBFou3LshS9z1SEIXLKDkQc6OXi7kG2NLrAtcZqMOq5Fgd60Qp6AWV27JHzTAILs18
	0fo9e8oDQXL9rfiLbbWxLyXvY8f6KAGMqP6csSEB2nO+DYB2+MvAkqTrtuaabVubOzE4DiD6w5k
	Qlm5wn6Y9ZAb7jdPzrxs3/5+azMcUvVHbMpj4sINf6egTKDNrLJyudvM9c4PEBJa9D+jBzRmLzU
	1pKItL0I0joqD2NtHqcCBQQAokoBHDWqhjb420NpJVZwb6AhYnBnFpQz3B3TMCV79R/FqgZSnib
	Fo+8IridBq3FiWaoubEdUuXpUlZM7UQomrM8jMtjgKgF1qaN0dEWqmyA2hQa7gXC3Mz1uNIgMMi
	m1U52WwgXT2k4iWMmSnMj4mOLNbBf20aK2xgIM23rlSVGoW7zeCcTDU8/Nr2Tx+dp9dU6HiqayT
	XUqHk9Xs5xjquX8iAPI+USXtZuJsasTAscjjIB1CHBGA4ALtB94t8G7ENTvVQgLXZkNAK7z2TxZ
	C3qZ4cQj929XBh+qAeer99UKMtCmubcgLD6ooSFauiWOCiuiZk6Aa09Tb1FpPjAPleXgaP6++LT
	hM0e3a9O77MywbFCZiXeQtnH
X-Received: by 2002:a17:90a:ec8d:b0:3ac:b7b9:6484 with SMTP id 98e67ed59e1d1-3ae897ae130mr3323310a91.45.1793420102417;
        Fri, 30 Oct 2026 21:15:02 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845d5e62sm6384937a91.13.2026.10.30.21.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 21:15:02 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH ipsec 0/2] xfrm: fix state lifetimes in xfrm_migrate()
Date: Sat, 31 Oct 2026 12:14:53 +0800
Message-Id: <pm-xfrm-core-objects-candidate-0027-v3-cb1e033bff1976f510c9-0@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_migrate() keeps the old states in x_cur[] and their successors in
x_new[], but it does not hold a reference to every state it later
deletes. An SA with a hard lifetime can expire and be freed by the timer
and the state GC in that window, and the following xfrm_state_delete()
takes the lock of freed memory:

  1/2 The success path drops the lookup references of the old states
      before it deletes them. Delete them first.

  2/2 xfrm_state_migrate() returns the published successor without a
      caller reference, so the rollback deletes states it does not
      hold. Take that reference before publishing and drop it after the
      migration commits or rolls back.

Both windows date back to the initial migration support and are reached
by XFRM_MSG_MIGRATE and PF_KEY's SADB_X_MIGRATE.

Cen Zhang (2):
  xfrm: keep old state references until migration deletion completes
  xfrm: hold migrated states through rollback

 net/xfrm/xfrm_policy.c | 7 +++++--
 net/xfrm/xfrm_state.c  | 6 +++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

---
