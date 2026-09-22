Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84590572673
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097634; cv=none; b=qfD1RrtAQEVYxhKK8LAFFwR7W4+tyX4oshoRCRXJjniY/JFM64N4pX9zDK75y0jbYLBxLhVQzZmTUetnCzm+tyBCz2LKVQlY0pJwG0fQUfCDdtZAP+DOFc1d00z1iSlCI3eCOh5mcvG27ewV5QoC2Z0mW2IQsjoxocJe5UUhZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097634; c=relaxed/simple;
	bh=YGMK1R0R9ravte3mZzxq5dPBRIF9YN5gHhuG4Lxk7qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZlR5JueWpYRKHcSywZCTmTJTpOEEky9vbCOmV+DxD86XTl0MycSqQThsfGJYkJsD+k2EkTkADkUJ0ndegWnOhUW8FIhGtdnbQ9XJ4+Td+oogYUkvqqZPUdSOEy8V6ebL535JBdZdSebFoEdpzOiJxQBqqBXozsI7+BMjjXoDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=h3b12TkV; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="h3b12TkV"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so158754a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097632; x=1790702432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m73w8MScEFOpXNoHT5D1Hw0tXoHQrkRbgHhw9/iqEPI=;
        b=h3b12TkVAqVP4JPpixa1HMBZjEQ62G13iJNxkBlTstZmcKNDTiQtscvVZZY5Kyfe6B
         KhrLWP9PfhyMeAdT4/zEZHismXAPfvVrfJuf7/LSN50jeA/ZWqRULi5U10XcwfvdK6PQ
         l8hvFqPz7GxeQm5SITnhjl8Ui0YQbsTxNd7Qr/Yqmc3rr/uDGYUdqZK/Qz5e56E5OSpn
         Bk8oycG8B7LeZKLT1QBst4BpS9CYNls0Hd/pMgW5d3MwZ70l3pviKanSa3sjPeHtsLga
         Dn2KOn/ziatuN9bARR+XlFQSyPBJPXEuGLED83yMHUSp8FEcT7+Yjog/8gT8VkendGWP
         xFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097632; x=1790702432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m73w8MScEFOpXNoHT5D1Hw0tXoHQrkRbgHhw9/iqEPI=;
        b=axXQ4V/5aAkbkBIdSNWWiUkNqBz4NLqw3xNOT2dn4dCkTSHVgCloGFNtk+zuRUjDgi
         Nwo7pRQjXsqmAp4jKMe4vzmv9DCgYTIEGA5njMPEaWVpS41DneFbrDgOWBddk1KISFta
         De971nnvLmv8kQQqfECnDh+WTeyvbwq5tlTVo6AjpeLeX3QyfAap5hbCM8QIIMQ2Udza
         APPjsRUnPD04jtfnhcaIXrPc5RA8CHwnamNAvZQnSIcQf52PTkwlCCJzWmAHw8m8CVhe
         cNF9obBtCWgCRHqxXSgCw2Eo4GvZK6U/pmQggNc0QuYfiVE9RNSE3HM0TsqXNYVJ+Tw9
         OLmA==
X-Forwarded-Encrypted: i=1; AKwUvBy0noTxn5du/vPC9F9Mvj55fWgqMdA79U4L1CVpweKLR9wO+Z6dgEjAVGVHiQlIO0st+j6GVLM=@vger.kernel.org
X-Gm-Message-State: AFuF++lTPLmGKWpAexFuPXLhJG0zp/vjvXqqf3VYcZXSCri25NEMQG36
	0lHuBpHFK2qmjTonno2VgN+TIbqjpjpS9lb6oYnCsNy3LuNEPIoqMJeIIrZS+48z+2g=
X-Gm-Gg: AYBFou3JPjZi45OqK5U1ccBLOKIV53xWUu6rebv7zqVQzBL8bm6TU5dz4tIwKCO7sNM
	8T6yRhgUprpK91eCJ/4arvXMUmSg+A1yE0VfZEluqHsyYSgLa9DXku8T4Z2ECZwLM+DJUYB0ZAP
	wAGZF6tXBYppmDuM/jO1nz3tfqS3cS6GTpkX496p9fAmA/erBFsQxLHI+r0B0YPKkD4LcuMi20c
	wQm5V+GrFx+FsLdjvTRQsE7u/R8gBsQ4susnZy68nb0DTqndxKZWJAUCqqmEMLenN2sTN4GQ6dJ
	96VwgpXo8bcZ9LiMAxlqaVPTWo+CkdILpaGG3X2W9JYETiQKpa9YrSJi72tCPZne4+rjYYPW0wF
	mG+e3AfeNlSc3/fnQs34J2vRnbtzN1KCQgxjdrBGferkF1k/VaE02YVlHHDF3u8KDxMEZxfiIy6
	ekHo97fbmYUUJcCh9Yeb7eBrSi6f6ir3syQJZ0MRxv/McO4ca964800kZkq/VmfcrHg/O6Cssi7
	7kCf9AjTowoarb2pXcOofMT623vzx90SbOxLCXZtw==
X-Received: by 2002:a17:90a:d64f:b0:3a0:7d88:c2ac with SMTP id 98e67ed59e1d1-3a07e65d0bemr104505a91.18.1790097631698;
        Tue, 22 Sep 2026 10:20:31 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:31 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 00/11] skb/arena bugfixes
Date: Tue, 22 Sep 2026 17:20:17 +0000
Message-ID: <20260922172028.6269-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set of verifier-focused bugfixes related to dynptrs, SKB
management in BPF, and dynptrs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2 (https://lore.kernel.org/bpf/20260916050830.8774-1-emil@etsalapatis.com/)

- (01/11) Adjust typecasting to just be unsigned int (Jakub)
- (09/11) Test for the new field in stacksafe when comparing registers (bot-ci)
- (01/11, 03/11) Added Reviewed-by by Jiayuan

Emil Tsalapatis (11):
  bpf: Fix bounds check for skb-backed dynptrs
  selftests/bpf: Test dynptr slices past end of skb
  bpf: Fix bpf_sock context code generation
  selftests/bpf: Add selftests for rx_queue_mapping context access
  bpf: Reject pkt arguments in mutating subprogs
  selftests/bpf: Test rejection of pkt args to mutating subprogs
  bpf: Prevent variable arena/non-arena register contents
  selftests/bpf: Test for mixed arena/nonarena code paths
  bpf: Track whether dynptr type is known
  bpf: Track skb memory invalidation by packet-backed dynptrs
  selftests/bpf: Test dynptr slice invalidation on skb clobber

 include/linux/bpf_verifier.h                  |   5 +
 include/linux/skbuff.h                        |   5 +-
 kernel/bpf/cfg.c                              |  10 +-
 kernel/bpf/states.c                           |   1 +
 kernel/bpf/verifier.c                         | 112 +++++++++--
 net/core/filter.c                             |   7 +-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  10 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 183 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  20 ++
 .../selftests/bpf/progs/verifier_arena.c      |  49 +++++
 .../bpf/progs/verifier_global_ptr_args.c      |  53 +++++
 .../selftests/bpf/progs/verifier_sock.c       |  38 ++++
 12 files changed, 475 insertions(+), 18 deletions(-)

-- 
2.54.0

