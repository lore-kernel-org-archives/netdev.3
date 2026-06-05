Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C53F9F2F
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684554; cv=none; b=cnbA3D2ct0XD+ljHDsG5Xh3GXpqqT1Il9ije8yHwJIr8DZvOBhp3baMD1Wpw5aU/2YuazUhMJVnvi0oTpUK1gkxiCOR1MN3EOWbv6iaV5oCqnnitqxOzm+Xd7H4qqnaYyw1KwqjZhLQ7FhzKYw/Relwb2njxroKDRQr+QV+8RJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684554; c=relaxed/simple;
	bh=wnRAvTrjaOxj81+/1ME5NxHLKUPB4bRXifWPbuOO70I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zg/c0EJqxY1fgB/paYFSasf8b5pjlq8OJyY8u4NX1tl3OusKqcl9mLbmCin3unRCxCzoRl6AV5Kc48jiyGBFEPq/yK9vT2MFmcgjY/+s3oi/ICIsBBI9kBgbmXbKILiaSUKDB4TyIKmAIuK7k3pb67gECrAewHqSxR7L1bFPfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnGh0KpA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnGh0KpA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8584e80bd3so1034058a12.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684553; x=1781289353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6NRQH/3Ow1XDrj5HT1DoF/ebJqBD1PjIhN5lXfVsE0s=;
        b=WnGh0KpAMUe3f/NV+0xsJeNbhfWPwuQ2m9tw2xPGx33i8kgzvgE3NvWlo2AnfN8CsE
         K+Jwm5fHFiKrXT4ec/kpntzHzQUJ8giSx+uFjj54kgstszjVpRmbgBjTpLTA+70H0MRq
         5i6rltUTjNk+l/dg/5H631Fe1XIzwmjLPKchRKBzU1CXmFd0Ok+hPyvN/mXL19HtqsLz
         gz70T7PkZZSsy/LIF8wDQckFJoZF4dUNzFzqmGpdXK9Y+cdH3sjgC3KXuP/4LCqf6RY1
         JG+i4uLuk3mFjavCyl8OSG8PGcNNF3kZJvmQDxVo3jsxpSPle1I4b/7hs4ZuDoQjo8Es
         y10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684553; x=1781289353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NRQH/3Ow1XDrj5HT1DoF/ebJqBD1PjIhN5lXfVsE0s=;
        b=BPEwN5FZftf0ppVbZ4M1qTeOodLs87NI/zIqyiApMbXdX92cH1+svDe+u70PQ39fan
         C+aaTQX92/iRGmcPPHWdwQgEdjgZQ7nspa3wVEvDt3MZTWBBiZXQZYtqFCD6h4ASNSXk
         4hfHe/t6cOYHQTZ60Z6geIVkpOi5DiwN3k5XXF5FrkABuc26LcKvGrf97wYH8rAWbGFZ
         AaiEBHOQrIO8vorGzKNo0Zj7c4nopKEWgQTD6fHvmLufuJZIX91aVE21pXv1chzu+viD
         ph2PQ0a93qv+xNNOIRJGStMugdbd+rYEd833pDVsP5KcYMMSLIK35LzXBLnes7wPO1/b
         DYvw==
X-Gm-Message-State: AOJu0Yxp+ltAbExi9woKjUf+9nsRrTA3rru7CgfRi8wtasROb2fm+q9H
	43futTnGomG/42+nnyLmlI1puT5knl+oOoGMfeFKA29nZqiWVyPe8Rq4
X-Gm-Gg: Acq92OHm6Bf715PmDnhzW658QjQjg3rXLCmO4EwTQK8CYfhQfPwavCEBHbqEDbgo2NH
	xEcWx1BEDM2DPDvZxw6GIIKWfcI2c13t/KgXC6jSrR6CwQ/NnO4yvWpctzJwmwBkSz9Bz/X10ke
	eGV9NfBfsDpc6MbRXPSZd+4mCZxU6zXBXRul4nN41U+HVkT9aLZ3ZVrEXmxFXM4Bb7hRf1mSUGa
	pxM1vAOJAizN+QzpIuthGn7Fj69XMHBs2du6GpOKA2JgNWl6I6PtvLn6/7PouUSvErDS//TRgD+
	S5FrEdwZEEVBhx7uFyD0ahK0I9fnrbHlxluswOEa7y+JlM7MOz+Hp5AlcHmTPS5gGKigGggrPbf
	61pmpXp90qhRVtu9amWGW9KgT8vf0bYTB4+vDSm+creOJTiFQFcISjaJUA7CWNaOMA95BLqktmO
	x2Zgq8nfHgiAsrvcOvH1aBT0Fa
X-Received: by 2002:a05:6a21:4cc3:b0:3b3:be1f:c89b with SMTP id adf61e73a8af0-3b4ccf8e5ecmr6270997637.22.1780684552651;
        Fri, 05 Jun 2026 11:35:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm8496978a12.18.2026.06.05.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/5] Object relationship tracking refactor followup
Date: Fri,  5 Jun 2026 11:35:46 -0700
Message-ID: <20260605183551.969144-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The main patchset refactoring object relationship tracking in the
verifier has landed and this is a followup that addresses the remaining
feedback in v6 [0].

[0]
https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/

Amery Hung (5):
  bpf: Fix dead error check on acquire_reference() in check_kfunc_call
  bpf: Check acquire_reference() error for "__ref" struct_ops arguments
  bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
  bpf: Remove WARN_ON_ONCE in check_ids()
  selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test

 kernel/bpf/states.c                               | 11 +++++++++--
 kernel/bpf/verifier.c                             | 15 +++++++++++----
 .../selftests/bpf/progs/file_reader_fail.c        |  8 ++++----
 3 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.53.0-Meta

