Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F006449EC7D
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142822; cv=none; b=eXju5kdpOvbhDgSa8S6z3Sa2CLgGz8fw416HGsGh5ESnKv8thB5CRrPcmo1usDDfKiWkNbUc5KPZQEEg6Y54XQ3VNGPLNRjWhiZYLNLB0iLEQBJYjkzgpyChkFtgZWjaRkF3Hc8vt01gDWGkg4Yld5X0gAfHMlhPGZYSLzbcfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142822; c=relaxed/simple;
	bh=gBbxLP629Gvcj9VfC9SPmRJKw+A05O9nG+Plld/3GVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FEu1XnJMpxVIu2zPPCy7yNsJ3qOuFUdlR/HMuisnojwyEdATAe0KEjD25MvJ6GA71zYt9FYNw55Johlc9/ulgLkYs+NUJlC+4QCfDUHi2w0gBLO2yia995UlS7ugLvQ0F9J66IQQmTJy60K4w2+ToPz3xxZf0FdYegn99N4CFgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gs.ncku.edu.tw; spf=pass smtp.mailfrom=gs.ncku.edu.tw; dkim=pass (2048-bit key) header.d=gs-ncku-edu-tw.20251104.gappssmtp.com header.i=@gs-ncku-edu-tw.20251104.gappssmtp.com header.b=k8qOVQ+Z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gs.ncku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gs.ncku.edu.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gs-ncku-edu-tw.20251104.gappssmtp.com header.i=@gs-ncku-edu-tw.20251104.gappssmtp.com header.b="k8qOVQ+Z"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so9266095ad.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gs-ncku-edu-tw.20251104.gappssmtp.com; s=20251104; t=1789142818; x=1789747618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8yzgeJZFDZiVAiiCE2K00c+oQsu6HsCjjXTSMd7Ylo=;
        b=k8qOVQ+ZB/TO1NN8QH0kgqXLzcJRAHtUR75nlZeZ0ncHfLiENxwXD0gZv+eDKU3nL2
         wWE0eh4Ouc5Zm+uCeRw5S9Xw4OdEpk/zLzYfIHjT03PVEAJkQbGELUu3HpZKvk9J5IVe
         rkLJMcYEMjIg0uQIMEnqk8gMvJnaIV4+0Yvsnx6Lcw9BP75BrwE4QCxWf0rKN5RRLTX9
         VO0C89r+h/Poj4GBI8M9fJl5QgvqwQnHkhsr/qjoKbZYKVuPbACEz+HoHijn9ezvebgP
         97rJem5hElhSA1bhR6A/0ZW227bfqNZLuTHQ9aO63UArSziPhbHolrq9FFb7ZygcMMXc
         hG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142818; x=1789747618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8yzgeJZFDZiVAiiCE2K00c+oQsu6HsCjjXTSMd7Ylo=;
        b=Vrdkeo6bvsj014VxV8WBI8y8PzM9hTAOgdb7FxWagh8C+J55YUsmmI2Db9JBCwcIwK
         Cjda9cjunj/C7rvPXwV4TmL9AuaMgl1vO2xXCIAk+K1lfhEW7W1UOqLSMnhItWjtxlDU
         3S5CxAEx4LsS03u9YTWD84t2vPL4/vLsqFjgfdXonkYWsoR4UvWw9CC7XTwPmNGs5Zrn
         8ZbUXyC0qkgqh9nPyFwioF6RS0qGS5O9AOrPLFNc4/RMATisZlIGgftXuheSoaD+mKlv
         czVdUePzFMUQOQb6GbeYYwoHk1U5GAwZLIQTv6uPbSbIr9WkMi6fJquocSrMcE2obiYg
         kZ4g==
X-Gm-Message-State: AFuF++mg2kRXDmjEMT0QUbYb0b/8PnMrGS22Q0CL3HHWCx06iYUJjfjH
	WH5ICt1AFIBFatHTp4uvvM4tcYHXjaRAZFqDoqHhyOtfHbgnQgj6grpPxGLHnLFK7qJWVuO9Uk2
	C6jlvz3fLndGGVVTc9L+i6lDojQP4u8odawjB64Ew1s/QQ12cyKNTG5sKx9zGcNb7F2UZSM0I5n
	7VwIdVWa40xpVG9CyaUFvMfvv+Q0nubNy1/poXs/UZOTazktXjtQ==
X-Gm-Gg: AYBFou3djvzTN7L3NWy5z7QBDzapLXDEQ2ewVHM3msr3Xo5A8VmaCg4QH6fbTpzFQIg
	e9Ev0UevVRGIdKMmNuVJhpZ1LyMtouFkhVDfzXNVyh+XZJwpfxp+JMz3vBsVQHQkLIKqf6IKEcn
	H+xQrR8RN6aMntTsEM7GcbuJhN67zFOE80trQMBbpN52Hef/Z/zCHZp+8WltLXmnInrQqjNpvj6
	1b/fajLxBvcwP/mgp+aXrRdLXGl4VTgS9v+dfWo1p+k0G4Bg+FrJJtdTFydC9JQv8sFa6y4VMVM
	3fYKY5XFpR1x3AXTHLGss6vqcu3lJTcxURENRYI1NSdHMDB0RFY3836bTVvgmzBa6NfN6YbosII
	odpSkB7vbkVmWXcoZ1SIb2OLXm0BIgLTeQ+J2ud0wfdviGuMsIdvNdjG1Ij0QzCkOTvdoERGnKj
	eWCO1iaBxBlchNkl4owCI+3g1s89d4OXro9Tu5xG+uqKIjSgVR1w49c+uJ48GS/Mcp1uCEVmEB8
	GNWhx3Pcd1dwC40MkZp3i+FVfH7gf68dTD4sPD1YCXOtZcH8iuo9qyc5y+N97smkOfq
X-Received: by 2002:a17:903:1a88:b0:2d7:1858:1d96 with SMTP id d9443c01a7336-2dd0e9e565emr113903455ad.7.1789142817956;
        Fri, 11 Sep 2026 09:06:57 -0700 (PDT)
Received: from localhost.localdomain (111-240-145-155.dynamic-ip.hinet.net. [111.240.145.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfcefb6sm13883055ad.56.2026.09.11.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:06:57 -0700 (PDT)
From: shuo huang <f64116045@gs.ncku.edu.tw>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	f64116045@gs.ncku.edu.tw
Subject: [PATCH net-next v2 0/2] selftests: net: Exercise TCP payload verification
Date: Sat, 12 Sep 2026 00:06:47 +0800
Message-Id: <20260911160649.51863-1-f64116045@gs.ncku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 added TCP payload verification to udpgso_bench_rx, but did not
exercise it from an in-tree test.

v2 adds a test case to udpgso_bench.sh for both IPv4 and IPv6. The
test checks the receiver's exit status so that verification errors
are reported as test failures.

Changes since v1:
- Add patch 2 to exercise the TCP verifier from udpgso_bench.sh,
  addressing Jakub's feedback.

v1: https://lore.kernel.org/r/20260906145643.219609-1-f64116045@gs.ncku.edu.tw

Testing:
- udpgso_bench.sh: PASS=22 SKIP=0 FAIL=0.

No full kernel build or boot of a patched net-next kernel was performed.

shuo huang (2):
  selftests: net: Add TCP payload verification to udpgso_bench_rx
  selftests: net: Exercise TCP payload verification in udpgso_bench.sh

 tools/testing/selftests/net/udpgso_bench.sh   | 34 +++++++++++++
 tools/testing/selftests/net/udpgso_bench_rx.c | 51 +++++++++++++++----
 2 files changed, 76 insertions(+), 9 deletions(-)


base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.34.1
