Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855836A03A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114546; cv=none; b=K7NTu55ADRswIv/OKxCMhd+0E8EVjZ5Z+v1vLRU4Xq3PDWw+nJob822PZ1igxxK6G7F35CFbVSpFYn4nsIBG3755gZwFu3xn7jkF1T9axsezgmlf7nGEXK7eg+cXEVWZR0bmo+MBIeU0/l7JR1tGC2A+AJ2Tsr+bW1keIdUgqjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114546; c=relaxed/simple;
	bh=xq9CU9S3gz/8VXDA+D3+mMVbKXxFr9C+j9syTBN4L1c=;
	h=From:To:Cc:Date:Subject:Message-ID:Content-Type:MIME-Version; b=Rit5lLDfU3WIWEroZWaO39m32LW7r+tlKB64ADd66aOsO0aJ9tLwh1WENRWAbQA45S8zDe6WlfXVoRGOw1gbj+oyscjDhRR0HRn0T9LeFdu7dQyUgRE9snlilTN2inBsReAm/eD7fjvMPic7vvfRTOsUfTkdU51a6Yx8MuYAPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr; spf=pass smtp.mailfrom=khu.ac.kr; dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b=ODIFvXgp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b="ODIFvXgp"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca7c1176317so642920a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khu.ac.kr; s=google; t=1789114542; x=1789719342; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :subject:date:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9BVPTP3iHBUFLufPu9HosFWecXPJJE8jbdqDi4BrrM=;
        b=ODIFvXgpJUyHvFWcQJziwlofqZkxgMYPiNhBvJORA+2nl1y/NcLUMQtCxYdBllzwZA
         bxdbgxNtcHn8Y9qBJLrp+nNNjkvMDaUvOoGR9CDEXhqv47oIX5JVXRDnfiIXvMw1bfEm
         uzRUe63pvxaNLeneCvLIJX6TA73bp9D76/izE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789114542; x=1789719342;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :subject:date:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K9BVPTP3iHBUFLufPu9HosFWecXPJJE8jbdqDi4BrrM=;
        b=CfLin4/EvluJobTvGbYuEQUd3r7MzxSxu2kmSvc2nAoeUZr4iJFI2SrTvFmoixubEL
         rnWH2bOYi3HLPNaA6K59+NN+QEhD2e52BC9ST9M0f4CWZXGD0KghuP8R78UmjjC5djzf
         05CGb3/R6BP6P2L9swu8zkV7YKP0CGlxo3bBwfXEOA2DFBkxZA7HpRcw19gtkAoyNHTv
         E86t88XjJagAFhkhSE4CzYwSyjfpSxgbUqFbqxexGpTq15cTyoTblxN73myW1CJ7X1pj
         DtE6rboXhAQols46Fy0kNzjbpjyK1Ht2s/w0A3+T3arNaaTy6EWpwyQmaTqu5yT/aTpJ
         Ny0Q==
X-Gm-Message-State: AFuF++l5btiTD9QhGRoUHRZt7mmYSmNMy4lyCF9H7BGmHd2RdT5qpQCK
	D9jYhgSBO9wP1ubWoPflWxN73fi0aVtryZdaNjdfNhA2OeWVuuqhj0uGetMhcK8dfnP+VUf7fy4
	vv73BMfM=
X-Gm-Gg: AYBFou3i74vusX0EBiJKRmC+JCjWxsxq4vOt5cRMk9+FBnEcd8BzleO4ZAFGyAmziwR
	LTDhVxhAUEAlXPuKjc7IqV6cADnfa+0OYtuzwAu4CB31J2jkAUaDMrk4ZNqU+xhsA2JYbLRf/Y3
	KGhf3tLY+p/0Tc2d+0Usai/ejpkr4fsqRlThdbH04M5WZh2zoLxK1Uj8v0LklLeyAE8tgtX7p8Q
	zp6ciKPFJG7M4ve+NF08voiOcD+IXV4e0dbzEDa265w3YOqaU/E9DQsDDkhXCSRvP65ksq0XmDk
	TNK29xHC7cppT7XC0PYr7L5ybrm7qcY37nAJhDeVPDoY6h8hJigRMLjFTguG0vrz5xU4H28qdk5
	DUlR6mEjbOTdbfoWo0RNremRzfsbsTp9OvqS3UgCLZ3NKeNlPI/gwEtZ5wEcZ/rkFGCX24pX/+8
	Ap5v0S1nsncufk9J3csqMFA80NVsXTz9Kr9LOhBjcC/yJsgt+CXJLvzxd3nZZY6mZ2NgUyj/Dlh
	tht7rW5EQpByzrAqI0=
X-Received: by 2002:a17:90b:582b:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-39d9bc15493mr5443100a91.4.1789114542051;
        Fri, 11 Sep 2026 01:15:42 -0700 (PDT)
Received: from localhost ([106.101.10.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm3534834a91.8.2026.09.11.01.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 01:15:41 -0700 (PDT)
From: kimwooseok <5mghybrid@khu.ac.kr>
To: netdev@vger.kernel.org, theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 17:04:46 +0900
Subject:
 [PATCH net RESEND 0/2] net: macb: Fix PTP timestamp configuration handling
Message-ID:
 <178911388592.25348.177462085059763031.macb-plaintext-resend-cover@khu.ac.kr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Resending the series as plain text to correct the previous multipart
webmail submission and the quoted and rewrapped patch bodies. There are
no code changes; the Assisted-by trailers now name the tool.

This series fixes two timestamp configuration problems in gem_set_hwtst().
A rejected RX-filter request can change the active TX one-step mode
while leaving the cached configuration unchanged. Patch 1 defers the
one-step mode update until both TX type and RX filter are validated.

The two specific PTPv1 RX filters currently succeed with RX timestamping
disabled. Patch 2 routes HWTSTAMP_FILTER_PTP_V1_L4_SYNC and
HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ through the existing all-frame
fallback and reports HWTSTAMP_FILTER_ALL to userspace. Both defects
originate in ab91f0a9b5f4 ("net: macb: Add hardware PTP support").

Both defects were reproduced on a Raspberry Pi 5 Model B Rev 1.1 with
macb eth0. Before the fixes, rejected requests changed OSSMODE in both
directions; each specific PTPv1 filter produced zero hardware timestamps
for 61 packets of its requested type. On 6.18.46-macb-ptp-functional-rt+,
both rejected requests preserved cached settings and the full NCR, and
each PTPv1 filter returned ALL and timestamped 60/60 Sync and 60/60
Delay_Req fixtures. ALL/NONE controls and all nine configuration cases
passed. The board was subsequently returned to its original kernel.

Additional validation:
- net 7f26a5e8040b: ARM64 allmodconfig and allyesconfig full targets
  passed with GCC 14.2.0, W=1 and CONFIG_WERROR=n. After applying the
  series, incremental builds of the same full targets passed with
  identical configurations and no new warnings. Both rebuilt macb_ptp.o.
- Pi board configuration: Image.gz, modules and dtbs built with W=1;
  the resulting kernel booted and passed the hardware tests above.
- Both final patches passed strict checkpatch including sign-off checks,
  and standalone/series application checks on the net base.

The RX tests check raw hardware timestamp presence, not absolute
timestamp accuracy or PHC synchronization.

An LLM assisted with source analysis, preparation of the fixes and test
helpers, and drafting the descriptions. Results are from the recorded
board tests and build logs.

Assisted-by: GPT-6 Astra

kimwooseok (2):
  net: macb: Preserve one-step mode on rejected timestamp requests
  net: macb: Use all-frame timestamping for PTPv1 RX filters

base-commit: 7f26a5e8040b4957ef4dbdfcde6cc7ba2db53937
