Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4E36309F
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695472; cv=none; b=lBlSJHmDtNNI0Eln/S2prU6myFJdbKGKTHrMh3dCPQRczYRi7WGLaQ3AQ6lXYSa/XhNj+5lZ/o8DmTk+dQu5yFhkj/CwUT4TsWFfgoVgG3GzsznM33TSrxLSSz3KkTIIRiLchJHLiREX3UBnkXOEdJA0PnFCdQJpnV6UP0YHaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695472; c=relaxed/simple;
	bh=nI2XFSMCC8qfjkohtnUDiAO8UP3SGQsSyCdMtKAFYfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AsAY82JBCBSwFLEcd8qOKJvpWSNiA9k9vnc+knC6lXAhWAihzOg/4scaVfyRJW05WzOClZVnam3+wb7U+GwoBai3b6Tis0G/oDLAK4iGkJa/Hhs97E22LEsF+Plxws0R36zgOedMqtQjXoYpycsp3iVyuNfbEkepckX1KlRRdlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=r8JIIGiH; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="r8JIIGiH"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89c52db6231so16526246d6.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773695469; x=1774300269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIHPcpuF/nUZo+dFdxZjNkw6J3cQMhhu5dHimz7xZzU=;
        b=r8JIIGiH3ODwaSQi9Wz7VC7x3LXO8haoNYN7EbhTzbOGj10m7wB58fFmKZa8Y4ktZe
         G1WS/Jpr2r8lcK7ZcIeh15Dcqm190xWxmqVsKgSpqKVgLTah++o1H1abG34QPJ3jlEpK
         XLTxCwlHwaz7+d4zDECbe7iWTz6ivqns+QA+N/U6mI8uY5CNSZadgmV01cNiOHXJFzxj
         uoUnSQmZAVOdM18zS4oQCaDxiN6j/PKy+sYjVmdv6sXsjbBIErK6LbMfQFbsfPF7akbJ
         Huh2GD1iqxVTE61JNCd6U6A0VvKUtBiRJ+NvHc1KijezergYDm/I0JVLDHlJhR9Z2fn1
         Wuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695469; x=1774300269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIHPcpuF/nUZo+dFdxZjNkw6J3cQMhhu5dHimz7xZzU=;
        b=dpkGUdJhZWNuiASYQy6py02IxJSdMsDIFjLutzslQer3NVZAaqURaD7BXCI0YKnflW
         k39aCvn2vrcoQ4H40/FI5jaGzRqAZ75vBrCAv/z0k+o2Pp1Hec1VAN1WYV+pCb4dEume
         6AhuPgXsAd4mPKEv1DMHTRJJ9WtX/RQOqbNRf+8bavh7uajY5uZ21TNopOG+WnDhm67U
         ZaPAvC9+EragFdiWFdyOT3Inq6ZKhVatyhUX3chCdjsMse18ntqp1jJ4ASYN8pjs6U9Z
         OtS7HmDscJZZVeITzuOPugPFmu6uGvKTLe7DddVYbZJ4EINKKA4O2wFqX9jDKdsvicoK
         nv9A==
X-Gm-Message-State: AOJu0YxUdgdlhLawV8VQy1/3476k72tOaDglau8pZLir9WJJCpeYxs16
	6RghktIMMx9TkmLG0N/nVl4VT6hq5qwT0nevzhr1QCeOVhkBsN9H4tbZ43lWyfs5tz7a2icXmmD
	q67A=
X-Gm-Gg: ATEYQzztSmBQqWutqB3RWRnTCrwCd+zgDJ+ItdkHFZcT3pMmgqfa2Y/g6wNkggp1xFl
	OcxhX54PejwsWxh/FcjJN3/uVVgyuCRfN5KUZeo3YcePiKCWDxBc8mG6v7FyyfwgHBDhZkmRWP0
	QdUOEnClvx27WR+OGMjAKrG29R79lzvMMw4ebSvDDs2MBaVwFws1expmGsfrU69QDQIsnjNjL13
	gNrivcz0xD9u+kD7zVLX4BrHbE6Fl6VAwAIo3lFWWB+yUqR+xxala1SMy+FQuGwhJBCiWICYA0f
	mov6IxV67RJa55jr5jkfDbif3jdHJs39g6I/Yz1OF9AjbzuZ8DimrbdNQ4tRa8leeJ+TgyJe3hX
	6fPKDS+dIrFseHVTGK30Zx6o5GY5cjP/Pi3IXIi3Kqo3++DegBvvWPelFFLFALEXmb3UXM+hOQt
	qbf3DwOER65IGf9esMWKS9VeI=
X-Received: by 2002:a05:6214:c24:b0:89c:4f50:eb8b with SMTP id 6a1803df08f44-89c4f50f08dmr92088296d6.9.1773695468929;
        Mon, 16 Mar 2026 14:11:08 -0700 (PDT)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c53374573sm27356266d6.7.2026.03.16.14.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:11:07 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	savy@syst3mfailure.io,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 0/6] net/sched: Fix packet loops in mirred and netem
Date: Mon, 16 Mar 2026 17:10:46 -0400
Message-Id: <20260316211052.332383-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We introduce a 2-bit global skb->ttl counter. Patch #1 describes how we put
together those bits. Patches #2 and patch #5 use these bits.
I added Fixes tags to patch #1 in case it is useful for backporting.
Patch #3 and #4 revert William's earlier netem commits. Patch #6 introduces
tdc test cases.

Changes in v2:
Do not reuse skb->from_ingress (which was move skb->cb)

Jamal Hadi Salim (5):
  net: Introduce skb ttl field to track packet loops
  net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
  Revert "net/sched: Restrict conditions for adding duplicating netems
    to qdisc tree"
  Revert "selftests/tc-testing: Add tests for restrictions on netem
    duplication"
  net/sched: fix packet loop on netem when duplicate is on

Victor Nogueira (1):
  selftests/tc-testing: Add netem/mirred test cases exercising loops

 include/linux/skbuff.h                        |   2 +
 net/sched/act_mirred.c                        |  45 +-
 net/sched/sch_netem.c                         |  47 +-
 .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
 .../tc-testing/tc-tests/infra/qdiscs.json     |   5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     |  96 +--
 6 files changed, 674 insertions(+), 137 deletions(-)

-- 
2.34.1

