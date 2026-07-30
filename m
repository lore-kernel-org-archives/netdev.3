Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423F3B0AFA
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400183; cv=none; b=tG0PgH0UNCNtk8ay8RWNO1/Af/ny7s2UARo6ClNjSN8r7PEcorx0zHpbV/lwtFsp8hKYwGR8b0TnscuKC1xGlm8alDAMDwyRi48oyyEIXuDv3eWXWXlhNTk277Otg+MPnwemyj8H94i1ZSoiWUPjQh/zm53WxfiA7XLeCRJt5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400183; c=relaxed/simple;
	bh=B42SBYl9aaiB6nmRTz1a/KnUKAuigPrYtj6ZNfBf1yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=snGIk2/LSuTODFPUReQB7Qi+wZ4lxzgwR1mWZ70/U/41HFmc6oiPXN7zc9ML+Tgy5YmWZx1vg/dOkTen6zj7E2HIWb27yFBWn/BqXFWxgYGWSyL6ns7k5QjvE8Ufzpb3rwTDGw7xVd3OVkmX5mFPAjwWwNwoFQ8QLHWnx1/yDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKvyorm3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKvyorm3"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca53979f8e8so194201a12.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785400182; x=1786004982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bw64pOvp75tqjEbxe44Ni3tYR32AoO/7olUauM7iC3c=;
        b=GKvyorm3ah+QffBXR3s74KWJCVMGmLEA4+kk0g0Q3c/WUNQU49N1bNTce6OJ9v9Vm0
         Zd9v6TvsTBG3wg81kD7ScTFREJvrJPe0J9wWNAI2CpGwxCwy4dUvp5xozR8SSAZOWLCX
         RvYAsWDO+IkyshN3O2t2Etb+Mqcdn0olytCgxBCTOu6REzj3QwjwnL3qCPTqSO/wOVy9
         G/Ghsw8AX4suneRoR5XamhBdpGcxJI2QXwhj0+u76dQkcxg41p6iGiMxxg9JArxzlF/V
         39iCi33B/LJELbRiaMEWqPXoKN73iEEpZEkPS29lGvlg76NQEZ+xwFqA3ciLDeYHaFVw
         OxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400182; x=1786004982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bw64pOvp75tqjEbxe44Ni3tYR32AoO/7olUauM7iC3c=;
        b=bCyCWbLsW4Z/xrl1/NT+ssjN0hAnPVHetJ0w4sZx4Rlry96F/UM0RV6EFpOgbI7OF3
         eAIPhbjPBHaTnYCTWFCMOUEAPH1/z4LtinVox2ySr3oZQVtXG8o5jlrNwSj1G4BPw+BU
         2xr8j4RbvQt5R3BfU1HF/+6r64NWOmWfEh0yefph/xhd/TPQAzH3RTuHeB829vIrHtZU
         uj81JRmZYWpGasQKDLOLaOgYRnZYcGsFCZFidKsV9388RGwDe60KyN9vDClVuW/tuiSs
         6A0QSiTqqROTYuVVsz8jIdNZemKiun5+LENmehWFFLCpfazdI9HrpOoHFWklwqAXb4WH
         vuAA==
X-Gm-Message-State: AOJu0YwpTG3u75CaPMaKXvQPMxm6jc/ukbEO3p3k2iszc6wcr1cPnxKO
	R4TYcgUMIRFu9ufFWZNr1DsMrWCfoRboXnIZAVVMEqPr9yrxIaNvXresxqWcCg==
X-Gm-Gg: AR+sD13p5s/ZfzR2J/atpfhUTkCZ2ifZGYuVJnLCakbHEy6kdvNqTuOBI59qX/q9f/v
	BI2K/TUyQWqxkWFV19pNAfE1MvWWflMNGoCGsUH359pRpOwim3W5Nz2sW82D228XWaX37VgALQm
	TXXbF+1ROcz+SKMy+2mKsfF3cfLwSav5GSZvhxX2SGGnIdIurHFcIoO2VBGzUgkmd70qy5JFfSF
	Ye2HfNdxn03rokqHk6qMvoeGD8Sipjq+GUDPnnpVK4mGt7qt1At55uMcgEt5Gfj+YMAdGwakJXm
	EZ6xnIoepjfPniGHGMDcKXiTeSXfy9wOQlQ5rPysRfBUXgsc/f3SaFyp9IHL/ZyJQ/Zs/I6I0mC
	oRjGIMCAnBFP7HjYgRvn3eC31Tn3PsjgEyQ6O5LUQ4erzpdF7g+ISqh+eB1m8Lj5AGHVQNBU6wc
	pScy2oLlpkYGzBQ2PJkZwapZGNJ3eYHWkBTcfMJ5j5kVEjz8rhiSxxygYQueYeAXIabVtXBkzBV
	9y6Pk1GJvyIFRMchViZCvE8MOxKoo0ENo+iU4bRW6kXh8/bc2U=
X-Received: by 2002:a17:90a:ec8d:b0:38e:7069:7117 with SMTP id 98e67ed59e1d1-38f9bb18cbemr2207672a91.0.1785400181820;
        Thu, 30 Jul 2026 01:29:41 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b770e33sm664279a91.15.2026.07.30.01.29.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 01:29:41 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v5 0/2] packet: use consistent hard_header_len in send paths
Date: Thu, 30 Jul 2026 16:29:23 +0800
Message-ID: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_PACKET send paths read dev->hard_header_len at several stages of skb
allocation and construction. Concurrent netdevice reconfiguration can
make those reads inconsistent and cause skb headroom underflow.

Split the regular and TX_RING paths so each patch has one Fixes tag.
The separate SOCK_DGRAM consistency issue between hard_header_len and
header_ops->create remains outside this series.

Changes in v5:
- Drop the unnecessary per-frame copylen reset from patch 2.

Changes in v4:
- Use one hard_header_len snapshot throughout tpacket_snd(), including
  reserve and per-frame skb construction.
- Carry Willem's Reviewed-by on patch 1.

Link to v4: https://lore.kernel.org/netdev/20260729030122.21462-1-q.h.hack.winter@gmail.com/
Link to v3: https://lore.kernel.org/netdev/20260728031345.49562-1-q.h.hack.winter@gmail.com/

Qihang (2):
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h |  6 ++++--
 net/packet/af_packet.c    | 45 +++++++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 20 deletions(-)

-- 
2.50.1 (Apple Git-155)
