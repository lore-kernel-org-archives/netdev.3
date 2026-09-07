Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645143FF1A5
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808903; cv=none; b=COo96ELZHkcN9qL42MSQbFvXfDv/EO/XR3RqXjA2NrGdrp67yOIHaA0P4h/Yw3e8XOgqWJVA1OWhqx+CJzz670+FKnkQpKzyVp1i8+lBtNLPRI1NWC+TqSIRrEQCzUU7TT2dNrD4j26TQxOWPOYrYM3k51aIkpFo9LD74YaQcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808903; c=relaxed/simple;
	bh=oKmFCxMSUpg7FM60GmQCULluxv2u3pCuJNguQhI5Qq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbvuNGavNFQbe843mH/N7kexyGla9XpcMbYFyfznos7+CpiaOFPQGiLFL/UH80QlavC95KUlYJfOdtVs9rjq9uuRKUzBPjQTH+ekSH06Ljsw0iCPBtfZISS458kgig6kM2IaKE9nCekZpjCXd79hbbSk0+cnOdI7zHZcrqLRo7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=xR9UxgP6; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="xR9UxgP6"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8588583a7c3so36134307b3.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788808900; x=1789413700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HwRm/m+N6sUrS5r42+KRQtIIO2m/BigUBoln3aHxQb4=;
        b=xR9UxgP60xFm0Y0ES05GzgfsdoX/lq0hQSueswTevZvVivqn4VObGnU/sgxhQ0s0vD
         RsSBA4yWGT1F76V5YbcSqaZHiCMgK+/bvB9YoLmCxVhUJzjJxH66sG49lubLDl8uW0nD
         ExQ/2b+MY9DTn28fKJ81C6MV1SMP6P9kgqIZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788808900; x=1789413700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HwRm/m+N6sUrS5r42+KRQtIIO2m/BigUBoln3aHxQb4=;
        b=bEUG/mHctWZWeMfPESSGCbXt8gqpzxnlUUSTIplA6ECnseRVXlUtyLu0EhO9HjOLMa
         aPKKW7tWM0pB4vOy5U16uKZUDebd9MxKfLdYXQqbYlu6hZko7eYmBBPJpEDxBuVfDFLP
         wI/PCxUTuXH4+5cS0ebCN95Ivry2s7TAPvGvrXhKhLHGHON8aL+cQueD6twlIz6k+NDp
         kpUOucWeJPgrI/w02S2MISx0+16BjXhe3nR9EQPILaK0G59UGGCvR196zAWAhCRZ6n4P
         +lcHqei0JWZsdyInr5tjpm3Z+ELDxLmE0cpiCGPXNlkBxBB2cApAi0bIUHkWdGkrwLTV
         YQow==
X-Forwarded-Encrypted: i=1; AKwUvByze5c29yPs5qCpf1yWkITXB7xUczZ2xAPcqpkV9yurqGsMrZD8wBotPNqgELhEo2g5/+zO0z4=@vger.kernel.org
X-Gm-Message-State: AFuF++npVsNJbXzpkyGdUP/Gjfod2KVWHeLWMdgMU0KlFmdIaAGugtE+
	qcdx3k12Y+vA0e3PCNH0t6c5WWqjtafp4lGKas2xUKmlpnZjirJgTydb+c1wbgTqYw==
X-Gm-Gg: AYBFou1oKxqrxR4PPiXS7X0fXI3tC0sp8TU37j3woNpvM+FQQhwbZb9QUov3wiWIjsr
	lE4sZ26V/3GIkYxwDKa2KwSsCJmlKXix4YE7wv6/Ga9onfgHsKXhnNR8RdyIWB/Q6EKf1PQWzPk
	VpRdQRpnebDfnrypU98EF500GQWgvZKLbTLXt2qpCDM/NvyD4DTSe1ym2oK01SZJqfQQEAjY0QA
	+OqiN8Y3Pl9TjrpS2LDXhdk8UM7K+ViSVrFMeZyifN8QtJZQ5EcHyPlIg8XsA5lC5ayNmQS7UQZ
	4+uEIV+aywyrrrTybsXQvu8/pTiBynPWMJXX4r7edDKfyFaKQgT5MxsBnmTxMDc0/BM6FjlD2BW
	Z2iQKdX3Kpp2QxoZ1VZ4LL5aDEU+bs+y8C79P8w4qdoxz7PhnQiZ9FGV0snbmHjt3EZbvrpayFD
	N7lJwp73StBiKgphLInorhpEkJYypMRGmWgF3YLBTqibdRkH4ZEeP6AA==
X-Received: by 2002:a05:690c:e1d6:20b0:873:5bb2:6c14 with SMTP id 00721157ae682-8735bb26da1mr43986137b3.62.1788808900106;
        Mon, 07 Sep 2026 12:21:40 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62bc77sm76546097b3.39.2026.09.07.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 12:21:39 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	vega@nebusec.ai,
	netdev@vger.kernel.org
Subject: [PATCH net v2 0/4] net/sched: cls_route: fix bucket retention and handle recomputation
Date: Mon,  7 Sep 2026 16:21:29 -0300
Message-ID: <20260907192133.2639067-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is the v1 patch, unchanged. route4_change() can move an existing
filter to a different top-level bucket, since route4_set_parms()
recomputes the handle from TCA_ROUTE4_TO/FROM/IIF. The filter is
unlinked from the old bucket, but the bucket itself is never freed once
it goes empty, so route4_delete() keeps reporting *last=false after the
last live filter is gone. That pins the empty tcf_proto and leaks it.
The filters linked to a bucket are refcounted now, and the bucket is
dropped from head->table[] as soon as the count reaches zero.

Reviewing v1, Sashiko pointed out that the duplicate scan in
route4_set_parms() compares against the wrong handle [1]. Patches 2 and
3 fix the two symptoms of that.

Patch 2 makes the scan compare against nhandle. f->handle is the handle
the filter has before the update, not the one it is about to be linked
under, so a change that moves a filter into a chain already holding
nhandle misses the collision and links a second filter under the same
handle. The newcomer is then unreachable: route4_get() returns the
incumbent, and route4_classify() stops at the first filter whose f->id
matches.

Patch 3 handles the mirror case. An in-place replace computes an nhandle
that the filter being replaced already carries, so the scan finds that
filter and rejects the request with -EEXIST. The older filter is passed
to route4_set_parms() and skipped in the scan. Skipping it alone would
rename the filter it replaces: the 0x7F00 order bits are carried in no
attribute and were folded into nhandle on the create path alone, so an
order 1 filter came back as order 0, and a sibling sharing its key could
then no longer be replaced at all. They are carried over now whenever
the request builds the key the filter already has, which leaves a
request that does change the key renaming the filter as before.

Patch 4 adds tdc coverage for all three, including the cross-bucket move
case Sashiko noted route.json had no test for.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829205422.854785-1-victor%40mojatatu.com

v1 -> v2:
  - Added patches 2, 3 and 4. Patch 1 is unchanged.

Victor Nogueira (4):
  net/sched: cls_route: free emptied bucket on filter move
  net/sched: cls_route: Reject handle aliasing
  net/sched: cls_route: Fix in-place replace
  selftests/tc-testing: Add cls_route bucket move and change tests

 net/sched/cls_route.c                         |  76 ++++---
 .../tc-testing/tc-tests/filters/route.json    | 210 ++++++++++++++++++
 2 files changed, 249 insertions(+), 37 deletions(-)

-- 
2.55.0

