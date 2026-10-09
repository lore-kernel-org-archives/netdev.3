Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A03EFFDB
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582876; cv=none; b=i1MQe2jkThjVZxI3ZCYIGfNAGCEFpGszX5pKaEW28YfMTXISmh195X9uZe3JNuMn3FtJu1sWKvRQF3HS+BEQrueu0n/AMEbn5SE7ciP/GKp0ezo5qqk3O6Cel7sVqUS6u0YqkHRHSEcqqVIJ3b/5+FSWtY/GRXwFZjbhbi3EATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582876; c=relaxed/simple;
	bh=CtH6DluhMd+muXMYnJEXGqPlgnABaOW9uHENaxu6YHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcddbmqNfdZyGoZg4ccS57KSL1q2O1YK+3+DfcXEyn0wDAIFmYPRsqoufBX2VX3rnhXvvSTrw9AfVsplMgnlvy5aJT1zFqLBXgjpvY6mloR/Kcye0DTJaT/V9bhX7YWtMsl2nch41SeJAwZwY/3GYHDy3Wde7dXPQl+d1o3Vvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=yTTItb/J; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="yTTItb/J"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so56536a91.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791582873; x=1792187673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4abdHfRSw+nQAbbMuTS5V/T7lcYjtcsQiFz445wACEc=;
        b=yTTItb/JDVpHmMnovZpO0nIRnHIRyiXWAdlRM1jh5x3ZxscihtRQcVQyWDu+6e1itI
         1oYkdwBLVYUuxC5TgsYDWkOM3myxEo9i6vdFU834bRX6G+sr0PlHvBAhle4bfU1OVTl3
         CTPobMwQIfwn3hPUSuhhGre8QCx5ci5SUHc80N8lE6WpgZmserJURdBNoI9o4/yCR6jI
         UWdkDT2VQjN5adHtSMpunnmHOHp8iUkG2BeN46qqXFaG0z+c225yoMhYxSMtEFMGGpOi
         F/H6XyDH6dlgI8Kc5+RHk9Jgq7YLGmYYgLTSEPzgFgxG9KUnVVFrw2su0kTW6EJ6ZAfe
         14eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791582873; x=1792187673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4abdHfRSw+nQAbbMuTS5V/T7lcYjtcsQiFz445wACEc=;
        b=AQ9lZyg4ch7ykXtCNAgPzpzCRyU3ZX+IJgyHs5ipdX2BMXTlawY/DetUmSRBx0wYyx
         QvhZBwWoJQkAhjLA7OpMY7vieOWzPXpryDYPJDZg6VOR2wPM0tWDiWtSPXqwlIeUERlA
         vkHtYPUKB5jGHFcboBKm/fYeRQFaWOlNJ+hRfEaPvHtnHedi7DLF36NSAodZNGb/qaIf
         7b6orhS0G+sfjULANbyWaK3L4HTneOm8RxsEvv/mdfja2KHIPvVtu/2MpLPbbcnPbD3j
         lyOLD2KYirsqtarq3nM9NOLpQe4zr3VSTauM+kCSViwvHxs7Blus8Guu/4IOi6D/CEnv
         DQqA==
X-Gm-Message-State: AFq9FYKiKFk0TixABwLv/aRU8BTo48V+DVCXGt0bb/ro5Pw6AvVoPLGy
	GqFVSOegKGVJ0NMEWwQtB8hOV9WWhIAKkl+vg8Wt/a3xXlegAR/7PDTUb2Ww0ntZzgRlijVcjYO
	vQWxS
X-Gm-Gg: AYBFou10Lqm5aOwq3TcZa0nUfROsY7Vl/coYtVtQnDLOGz4kxDQqptcjj6XNbFFCRHj
	DvfbaQQ4jietIqW6O4zKiURefjhls60et9mroxbmp7xkyUInxva6UaI+GAzjaNpQENHqRcPI9yJ
	Z/dVX6Wlt8cpHjhEGN1O1dvGqNj2DhdayclNFssFllR2NTmqzZoY9buNfqANnNum9mptPnMj4jT
	VrTJl9ZCZYT7Rfb+mxnrwgKCgh/QZ0c31gn1qJakkWEO2ygEDpsdecwJZRxA5MmDxee/O8BwB4P
	9H03mx5TIrN4mzr84qsYEx/iPIoP70r6uu0OZhNS44XsAqnqrYkyBNmt7QT1u0LqRuTxIVaCvH0
	I9fS7GZ2I9XfAfotaYPu3+z5xEtzAGoB1afH5E2T4+WYzs02Pfx5WXFB+6SkZP57vooJBvn6hoX
	Z0Vxwp7W77JgpEV/ZWI7XDvS0TXFGda0AiUVrpbS+hOmqHYFFNFR6QzXq1ForZ3UDt7U40ASMIo
	TW4OCywRENuaNw8G1nPzw==
X-Received: by 2002:a17:90b:2ccb:b0:3ab:1af3:a0d with SMTP id 98e67ed59e1d1-3ab3ac63ba3mr2640667a91.33.1791582872747;
        Fri, 09 Oct 2026 14:54:32 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab397920b4sm3032876a91.4.2026.10.09.14.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:54:31 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v2 0/2] bnxt_en: Fix SW USO padding
Date: Fri,  9 Oct 2026 14:54:22 -0700
Message-ID: <20261009215426.2377946-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

As a followup to Eric's fix a51d233ccd48 ("bnxt_en: fix DMA mapping length
for padded small packets") which fixes padding for normal TX, this series
fixes padding for SW USO.

There are two cases I try to address:

  1. The last segment could be shorter than BNXT_MIN_PKT_SIZE. So, add an
     extra BD if needed to pad to that minimum.
  2. The gso_size is so small that every segment would be shorter than
     BNXT_MIN_PKT_SIZE (under 10 bytes with IPv4). This seems exceedingly
     unlikely, but just in case, it is handled by clearing the GSO features
     for these skbs so the stack segments them.

Patch 1 is a small refactor to move code into a helper that patch 2 uses to
avoid duplicating code.

I ran v1 on a bnxt machine and re-ran the uso.py test and it passed, but
the existing uso.py test doesn't test this specific case, so running the
test was more of a regression test. There were no functional changes to
v2.

Note that I did not see this issue in production and it should not be
possible for QUIC to hit this case on either ipv4 or ipv6 because QUIC
packets are at least 21 bytes. AFAIU, only ipv4 segments with less than 10
bytes of UDP payload can trigger this. As such, I was asked to send this
to net-next.

Thanks,
Joe

v2:
  - Switched to net-next
  - Added a comment as discussed with Michael in patch 2
  - Added Michael's tags to patches 1 and 2

v1: https://lore.kernel.org/netdev/20261008191114.3736826-1-joe@dama.to/

Joe Damato (2):
  bnxt_en: Add helper to fill SW USO payload BDs
  bnxt_en: Pad short SW USO segments to BNXT_MIN_PKT_SIZE

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 12 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 61 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h | 15 +++++
 3 files changed, 75 insertions(+), 13 deletions(-)


base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.53.0-Meta

