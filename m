Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533723624D3
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778584; cv=none; b=fUq5P1roEjc+xJxtSfvLJxcOn5U6asNhJNH3TOBzv5kupjZDjN0Yr990qSeWZ/e0v0y5X+oIdiKuB2nTwnCadOLFcfRHvO+LEhw5IXswrznrg9/+22ED2WcsDbv9IJwbXk8JtHQdqA0XleuRBxauYtvwFvAVjqBs4FDvx6esmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778584; c=relaxed/simple;
	bh=m2VcwnNvFW/954+yXantAC920BnpuaNj2ZtpR7Wqf1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GsveVcIjKUTt7r/aKVj0/hKCaVOiOHlepKbabGJhLlxIQSEy4ryUd5FkCidMTcL4OLOjeYpDfSY/HP9nDjrfK38+fUIrw+I/5XigzOMXaUjX7M2yGTm7DnPdX2MYVnuHqFr1M7hZmioR51/TA8xzKLX5XXPiYdNOSDoFs5bxb8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=m3B5T2TO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="m3B5T2TO"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8b20a899fso2971005ad.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 21:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791778579; x=1792383379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aKpzAlPRldho6ARyI6EXFQgi6l3fYjFwuBpuGWoUMxo=;
        b=m3B5T2TOvw0xierihqtuGqMUk9CE6m0QM9MAJyFf0U/qN6Q7Gv/ehBZovAaIjQ1eud
         jVlz2RgrtOyrNP2rCuhM2DJsVyiAL8HPC3ZgRZmKhMeRzT2+uWFqcm8sQH29SPGhfMVE
         p5NxoAhrZlnh4BSmTwKDaDaulwoLMdw/sAjvOcB6e1Mfiptq+9zFYiegjmesUN//AvMK
         7aMfTKJOE+sUpZYu3Dnwni2IyoDe+/p0MnVMhwdjySLpDEhkYVBnqxrx9HCr6BZGPaPR
         B7iP8s+PE0MgcVpq5pvY444afIcIN4pasxA7Llrel8lzWxLjZ511OvcOj+/MmjfL1ArR
         JzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791778579; x=1792383379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aKpzAlPRldho6ARyI6EXFQgi6l3fYjFwuBpuGWoUMxo=;
        b=caeMuqa8kJJFBGcQ0IGxKbParDSsNRWeNNvhTKqxjSOcDBS3pNzXAniUoBdpN4zs1q
         pZ2am/uU8cg/EhdB5a+jFB8dg1K29Z59Kz7bv41bzkpnI6ZjWU5eVTblqbTWG+m3OqV1
         8FqBO5vscBaOXKe9faFgBxJdSpEH9PTS17kuqWN+ntzwtIlWzgVpmqtZ52BMGl30p5Mi
         4u4akpwrh3O7FQbYPjXwIz432DEkR6G9UBeiJtXn5kXDEsaGqQtxHsu6sWcc5ffu3cVg
         gYWD8unrPQLdxP9ybsKRAteNP4NoX5cBTVWtfhcF5vFxSvqUKflzWaqf+LtrAAxh2NJk
         Pbjw==
X-Forwarded-Encrypted: i=1; AKwUvBy//9xp5rBhiW8UNXgfcOcrClhMQctFykWiDaot2EKSGh01kGLsVuXk0jNyOwKDxeXHr++A8Ok=@vger.kernel.org
X-Gm-Message-State: AFq9FYJM2DgfvP0jRm0qMKY2CIQv7W85nfUd1CPWUaGnqvTchpRKmHbq
	K94vgwWwJ4slCJa2vIqbD0BWjxBVGgCTpQsOOBUNUI8OWJhvNF1ySQYfxpS0flu7z4c=
X-Gm-Gg: AYBFou063qevu6cHrwjMgI8xoomRKj8XuF1vf1Edfy9ZFTli0Tv+7kPIOTav3mFk0F2
	M+xOqddlS7+Qg6RARFWcsiIDEkODY6R5uzc1GXlTdfIiJNxgkdh3KJnjHkTzlTgNmGu7nPgwJtw
	6MxUPwyEoBfoZCQOVpQ6mM7itVbGECvgzkOSKLC3yr7oRDq+0LO4lXrJQAmMxEuLjPwzwVB2yUX
	Os8TOeWjcGEEHZMJXDIp8IRRXHBVXqAGaB2l27zl6eXIEDlPLuQL/CFb6xEC0GhPN4ldDEaWE5C
	9lYNJSOYeyCBT9gejfmx/d/X/aUbiGpchar9CjliD1HGxvWDrqN9Tf8iPj8VfDkkHs5dIpvVz5+
	2P9Q6TSW/8effKdQ1JaMLQFW7UT1S8ju9ukRLHk0jAQ0k3a3nmFZ74FP72cSbyVyyCk/PW36RJ2
	QSE032Mk4HPFcHzrljSibike+7BAOJSxLL2Fp7hJUOtBeKjHtd5ltaD85O2n2/iRFVEpaQOOrAs
	yexiQ==
X-Received: by 2002:a17:902:ecc3:b0:2df:5836:d1d0 with SMTP id d9443c01a7336-2e842ab65abmr73108105ad.30.1791778579446;
        Sun, 11 Oct 2026 21:16:19 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421af46asm38240025ad.39.2026.10.11.21.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:16:17 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v3 0/5] eth: fbnic: harden Rx and Tx completion handling
Date: Mon, 12 Oct 2026 13:15:55 +0900
Message-ID: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rx and Tx completion descriptors carry buffer ids, offsets and
lengths that the device writes and the driver consumes without
validating. v2 bounded the Rx buffer index against the array only, which
the review found insufficient: an in-range id naming an unposted slot
still reaches a NULL page, a bare META completion still builds an skb from
a NULL buffer, and the offset, length and the Tx completion head are not
checked at all.

This series validates each of these against what was actually posted and
takes the existing drop path, and bounds the XDP Tx completion loop so a
head outside the ring cannot spin it.

Patch 1 validates the Rx buffer id at every use and drops a bare META
completion. Patch 2 validates the offset and length. Patch 3 returns a
pending packet before a new header reuses its slot. Patch 4 is unchanged
from v2 and returns the page reference for a dropped fragment. Patch 5
bounds the Tx completion head.

v2: https://lore.kernel.org/netdev/cover.1791659860.git.yhlee@isslab.korea.ac.kr/

Yehyeong Lee (5):
  eth: fbnic: only act on Rx completions naming a posted buffer
  eth: fbnic: validate the Rx completion offset and length
  eth: fbnic: return a pending Rx packet before reusing its buffer
  eth: fbnic: return the page reference taken for a dropped Rx fragment
  eth: fbnic: bound the XDP Tx completion head to the ring

 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 192 +++++++++++++++----
 1 file changed, 158 insertions(+), 34 deletions(-)

-- 
2.43.0

