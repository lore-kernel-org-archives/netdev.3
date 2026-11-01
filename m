Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521065;
	b=Z6WrrGhFH2CtWsUwyPiY3UhZB9jflQvGYMl1Y6sqXxhAw2tKYBkrYcgvqTpGWY8+y5aD
	 expEjaOLEfu4q9jneLWYRJmXM3EsPhQX5XvMkoE8uCo/Jv+EQLfIZP5eaU3VrfuAlIms+
	 gdYNWvSzqQZ8S65DwWJTYjsu4QvZEtH5co/gZChs3HOoCwoZz7nDgamahDqnfRcXO1FPh
	 iLjho1ek4FYH4+/WIZQvo9yJIP0BUNX1dvgu7ErpnKy7dPt/CaVJc4ObDrReVR50Lu29L
	 dofAuacIPyH/YJ556y0AxSTBDzjWYIurRHJ0r0xy91jLMAvz97BtMdr2CDJapgu1I+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OTjm1dRowZIe2r6H1xJ9iOraQ4+BG5KAu0AE6tkBlgs=;
	b=CGlYL0XA34ZC5NBl9j9H55ohyuv+Fi6a90yr/xmRBu+adKKnbZt8OAcBeNW8S9dBX2qG
	 GM5sxBZz2JO8MJgozAJfjt8ocsmFOqZSrs0HELrrSPNcnJhxgml5vC0WHZXaQXED4AvOn
	 +x5s+LRLsica51BW1dYrpMvdfm9arqXSn0lmmOWLyk6QZ1aPN+CA3z4hMueol/YjgRHhL
	 lxQF8NDuNBGALMpfvENUhdEomi9Wtpcw2EssEESx46cjM4zWO91SMWNqFMEv5WjaPfpkU
	 bwF91naO+vQnv8/sV9JEBqAikxl8NwCJ/VIJtPrJHhKNalSzBeXJFBKDej4iGFzt9yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LfQN93U8;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21F606A326
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 08:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A21F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LfQN93U8
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so901790a91.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 01:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521064; x=1794125864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OTjm1dRowZIe2r6H1xJ9iOraQ4+BG5KAu0AE6tkBlgs=;
        b=LfQN93U8rZAbvzHs7ZZZcu1MeQd4rZwIEKoFakEJDMEbmdhjfcAfSF1dFYdBcwiSHm
         10i8xSIZoedMZdK8awfK+xM+ziKF2tZkuTMlS8D5Fc37yw5rn9f6obMhu3dUca+g1FY3
         DKkB400y7DJjfsIFWgP54EVaYa5SVVbsAfE4RqQDc3UjfVBcXE8pCrMhpC9qP5pVRI+4
         y6Kng6pEnFZtYQlpnAEeHzFpAhyXlG3hFp2QrB3tQqgA4wpfutlLYapR/Z7p38/blgqi
         KWv1iXY9DBZvByKSBgUnicpD4musrNDMey1kXtq2/AmE3aEY36pWAD+vHhEUHwhkKiPz
         3hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521064; x=1794125864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OTjm1dRowZIe2r6H1xJ9iOraQ4+BG5KAu0AE6tkBlgs=;
        b=nJUkL74hyNwtt25eX/IEaZA8I/eoSp6k9uIFek9y3/0uLMs5yP334EUxQVTkNwYcfO
         ZlQQf/2svF1fv58u5/FUqBxj2HdOd+4H5S88QQGSJN7tJWYYWTf2JZljihFTpT7Vovhu
         l9r0H1bX8OxwabftrrQQfnPlnig7wBMPuQB5sUpq/bqg1abmxRpBfVt6usKXSCCE6bCy
         bI45YfLVy88uCIolHQwa0iFpCeIWCZmMGbsyenY4bNa31rPqAYW3WP/HPN/Nw1gUqyKL
         41PsozOTuuFPbtFeSGgm1bwgiLqMOejvDnyyA+foggnQn+D8ggtX75As88CRKBrvTsLX
         bGdQ==
X-Forwarded-Encrypted: i=1; AKwUvByGbKKKdcTEZNu2m4DOBGed+tSnhXvyeJrBTnbisGai1busuAcZkWs2UBnCEanOrf+eva+mgRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rk2rP3C6b6oQiD1cLY56b1txQjOsOpkykzcU30Le9kGvnzp7I
	iBq9TkS3TYTZIP2CtF5OY5UapNzDAeNHKFcaDOYiLTef6nZBTAbN0IfU
X-Gm-Gg: AYBFou1y1sd2EcGMV9o27UdImVmM9yuaUqotote6ick1bNtqPJgXLSNj8hnaRVS7+1O
	zULQVLokWTntOVsXIl+K6u0+9KjeTfu4xB8exhp8AVMk8Oh82WnimwgOq9sVx0rTydz+6jaXslf
	JiFrlK1yJ9+8ZY3IvSlxRB1J9sYVFcS6dOdlWzjza831QgopbG41Kvyqc8X6UexISX81LKkayUV
	rypy4Kww3MUOrf2GQHhz7305MR5Mc0qlqFSTs5MQ1u575dKi3WeAQWcdA5Jdlthk/Q3CAHfcc2R
	O3rGb/RGeT7ZP8A7+eYr46jw6GnL6LMGBMA+ZzfQ+dC9llioXWb09aE6hdtrPAItrLinq2laGYN
	lKdenI//5Hd2fNajPHHZw0AmHFXEpNEFXAlZt689fnWatP8jZ1q1t1iQPz6vi2dO9we9Yfww048
	QkSCyWWHq2gzFglS024KdVYdMR8PMDn1gRve54Pwa7gpHZIDopMZhKBdF+7fYTcEiSB9F9M5CNe
	5U+v1pRIzb67d+CBh7SvklfIxQTZqiqn3JqkfVWD11aHK3HO/DdJgEgUauN+VpdgsuA+dOargyj
	l7DHfjjSlOncqrTC50/aQt34UrTPECBP+lRNpZUjm1OihCeyDYD4iXYG26zH/DF9Z2Lg88UWT/c
	RLEMMOtX2ORBsuFpPCW7m3HY=
X-Received: by 2002:a17:90b:5886:b0:3a8:a98c:ea07 with SMTP id 98e67ed59e1d1-3ae896f8551mr5236140a91.13.1793521063450;
        Sun, 01 Nov 2026 01:17:43 -0700 (PDT)
Received: from LDYT9Q2G2M ([2a09:bac5:cad2:3228::4ff:28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm10011455a91.9.2026.11.01.01.17.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 01:17:43 -0700 (PDT)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Finke Lennart <lfinke@student.ethz.ch>,
	netfilter-devel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/2] lib/ts_fsm: preserve patterns across tc dump and restore
Date: Sun,  1 Nov 2026 16:17:34 +0800
Message-ID: <20261101081736.51803-1-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Dumping and restoring a tc text ematch configured with the FSM algorithm
can change its packet matching behaviour or fail with EINVAL. This series
preserves the public token types returned by textsearch_get_pattern() and
adds regression coverage for exporting and recreating an FSM configuration.

Changes since v1:
- Describe the tc userspace impact in the fix's commit message.
- Split the production fix and KUnit tests; mark the fix for stable.
- Add KUNIT_EXPECT_MEMEQ for the exported representation, as Andrew suggested.
- Add tc maintainers and netdev to the recipients.
- Add actual loopback packet classification and performance measurements.
The production code change is identical to v1.

Validation on base 2a500a04d6f969318c05f46aedb6e73fc1963a00:
- The same updated KUnit test and ARM64 GCC configuration fail 13 of 15
  tests before the fix and pass all 15 after it. ARM32 GCC and ARM64 Clang
  also pass 15/15. Compilers: GCC 13.3 and Clang 18.1.3; QEMU 8.2.2.
- In an isolated ARM64 QEMU guest, a tc basic filter matches the four-byte
  UDP payload "7777" and rejects "AAAA". Recreating its DIGIT/MULTI text
  ematch from the rtnetlink dump makes both payloads match before the fix;
  after the fix the restored rule still rejects "AAAA". Every probe is
  observed in the classifier's evaluated/matched counters. Restoring a
  PRINT/MULTI rule returns EINVAL before the fix and succeeds after it.
- The guests have no external NIC. These tests use direct rtnetlink,
  rather than claiming coverage of a particular tc save/restore utility.
- W=1 reports no warnings for changed objects. Sparse has no diagnostics
  for them; an unchanged ARM64 vDSO object has a declaration diagnostic.

A native ARM64 userspace microbenchmark of the mechanically extracted FSM
matcher (GCC 13.3, 64 paired samples per case) measured median paired
slowdowns of about 1-5% for the tested long character-class scans and
about 13% for a one-byte rejection case with appreciable variability.
These results do not establish in-kernel or network throughput. The extra
lookup trades matching cost for avoiding a second stored pattern copy.

Mainline cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a, linux-next and
mm-nonmm-unstable still have the affected code. The series applies to all
three checked heads; they were not built or booted for this revision.
No x86, big-endian, sanitizer, module-load or stable-branch runtime testing
was performed. The packet test measures matching, not dropping actions or
network throughput.

I identified the issue and reviewed, built and tested the v1 fix. OpenAI
Codex drafted the fix, tests and changelogs and drove the additional v2
validation. The added assertion and revised messages are AI-assisted.

v1: https://lore.kernel.org/all/20261031052307.23533-1-zhiqizhangg@gmail.com/
Review: https://lore.kernel.org/all/20261031202211.22f18bca7819dbe2d107d17d@linux-foundation.org/

Zhiqi Zhang (2):
  lib/ts_fsm: preserve token types when exporting patterns
  lib/ts_fsm: add KUnit coverage for exported patterns

 lib/Kconfig.debug                |  14 ++++
 lib/tests/Makefile               |   1 +
 lib/tests/textsearch_fsm_kunit.c | 138 +++++++++++++++++++++++++++++++
 lib/ts_fsm.c                     |   7 +-
 4 files changed, 154 insertions(+), 6 deletions(-)
 create mode 100644 lib/tests/textsearch_fsm_kunit.c


base-commit: 2a500a04d6f969318c05f46aedb6e73fc1963a00
-- 
2.54.0 (Apple Git-157)

