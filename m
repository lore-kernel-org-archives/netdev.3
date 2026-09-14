Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED259414424
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376679; cv=none; b=DsAanPv7FLC4g8fzMEoJ0HPx5hEEW8YUUPOcVUvEk7sM4c1FBNPnCVqrtZXtb1Ia7uhz2yuPbuLx5WzMNZJWaIzbyxitVMNBNs3FrolSbezIGOCJdkkCoIX4PuQjkOx0ngwWjjnnQFiL14llVviMWBZUrl453rZaGp0x1zJOWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376679; c=relaxed/simple;
	bh=pAks+KPInh9ZWtI6ct5/genc48SB9KuXEC2hZWx4L/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8uiYlYWQcPkfMS8+Nx8aOkLlCGFX6kfWWHehvPR9mrcrgIj4o9Xy3RAWyKdHwVg/HwClaLj+MgpMFm/PXlsyoxEDqTn1kqhOIMjsilKxTd64KzKCPFEd9aDFRpqHGC/WbcuAhiSwpUZQNNO4fiQYG2AwyGEYDUKmWHzuG1Rdew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il; spf=pass smtp.mailfrom=mail.huji.ac.il; dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b=UQW1AmI6; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b="UQW1AmI6"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7af75f51so86425e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1789376673; x=1789981473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fmdVUI1/NR1WuBXeu4WYA7tw+26r3ITA6s7ZdRYWlzo=;
        b=UQW1AmI6gZa8aEIz7daQRPEBLdrPQaBUqmR4bhHzecYwiIQbpZ757T+fs5syCsHNyg
         TPJCDILI+Zstl+jTXYmibw/BFQJ1F08+0OrGyzVnM9HMJyf4FbnFrAKLwhII0c/nMVsN
         aPbl6JEq0TMsoJpXoeZUHw61lvENz3nOQ90RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376673; x=1789981473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fmdVUI1/NR1WuBXeu4WYA7tw+26r3ITA6s7ZdRYWlzo=;
        b=tTZuIYbZalXOtTK/afqhL3GRsWcwRCf/y6+lXiIdJTEdjl/MpVtcDQQtXRP+mubSES
         SvgamT76oIeKyzvcjFDX9s7uwLX8LwK8idaFCwsZlGkAJEks8jhIoRvE3l0uqg3UlJB7
         IGHtg+0XXvH6I6rQngF7RLIiBC806uwmB+xzBv4NAXfPXY+OHfWCARXYUMwkLDcgVx8+
         DJOevs1YKsp8OE5I59OJNekEe2kHB/WxbCePIuho73J62BN3umpQQeEfmnCKEvczcypH
         qkxk4l9R/KFceZePv1YhIyTpRsYKipB7V8oVm+P9MH0lMvYkCzKBte2FPtiOzDwGVsEa
         xa+A==
X-Gm-Message-State: AFuF++k1iORsGneSEGAk/+q+hwmAwazjaF2rYLxAN14EXMzI1f5HZjha
	BzhURM6NGfDhJFlGEyXzXUvamSMBLzp4Xm/d4TrWY8rKJekagwhTp/p6xG6fX3brrQzymNvVipb
	2Kz4Mue+wXgrDDgRkdCWGfO7g0TK7YKlhWPVqYF8d8YnxjlTE80kiiKxYK8bONVVZ3sbUNshDnh
	/p+oZERg0yqJbrzXmbWlldxSj+A+lGCPlNOG8NNXv7raZHdXo+6fNeZQzMOg==
X-Gm-Gg: AYBFou2DH2ItVpgOI5ZGchHG52GKYn/xADruH9E2EBZSINzVRPhCNONLEEleLxpIaT5
	cJTCEwMzvSQmenvCgGpSkKLwHufzx83WC0Sy2p57D05TGqLqNsjJKlIRzWyy16bVm3kckvSkiX+
	gRZx1BsUs2pBiV9Dcw5qn9H5/G1eKgIugzudpTpIoUmc06+papGDi5k1KPeUfdQytSJKVPSDelS
	2AqkZKcB2Xgegj5irZYzDyLYSRlCIAweoh1LYOcmCO33VgLaIQkQbVyrdAJ54oG1UcnJUSVRMHO
	dMFq5svpFucMy/XTH/YPMwog9C10J9B3Bd/5b8tZh2aDGDK9OAKs0CekdPGCpMSeeRz2wwdNurq
	KHpQo/JBYExZvZlMPFPtE47XItmpaS0mGoawsCym8fQgq57iSjCKiCpQ1dJEJm//7hXjYGlURcT
	HjTvTeNd7m6L7jmrP6b/4D6ua0yNOeDfo7jYWvw9Do0x4jp7JjG/YbAVYK7O8LXVRZFtcKlW7KI
	wUX+/bo6wUhA+96DMbOk8ZckM0uSjWY252k
X-Received: by 2002:a05:600c:a18e:b0:49e:7c8b:fdef with SMTP id 5b1f17b1804b1-49e7c8bfe12mr1732005e9.2.1789376673036;
        Mon, 14 Sep 2026 02:04:33 -0700 (PDT)
Received: from inbal-OptiPlex-Micro-7020.tailf3f5b8.ts.net ([2a06:c701:c272:d400::7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm227502585e9.5.2026.09.14.02.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:04:32 -0700 (PDT)
From: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	amit.klein@mail.huji.ac.il,
	Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
Subject: [PATCH net v3 0/2] tcp: exclude old ACKs from fast path
Date: Mon, 14 Sep 2026 12:04:06 +0300
Message-ID: <20260914090408.1435080-1-inbal.lipshtat@mail.huji.ac.il>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exclude ACKs outside [SND.UNA, SND.NXT] from TCP header prediction so
that they fall through to the slow path, where ACK
validation is applied.

Add a packetdrill test for a data segment carrying an
excessively old ACK. The test fails on the unpatched kernel and passes
with the fix.

---

Changes in v3:
- Add a Fixes tag and stable Cc.
- Clarify the visible impact of accepting payload carried by an
  excessively old ACK (RCV.NXT is advanced before the ACK is rejected).
- Document ACK sequence validity as a TCP fast-path condition.
- Initialize the packetdrill test with the suite defaults and disable
  invalid-packet rate limiting.
- Add an SPDX license identifier to the packetdrill test.

Changes in v2:

- Exclude all ACKs before SND.UNA from header prediction instead of
  duplicating old-ACK validation in the fast path.
- Cover pure ACKs as well as data-carrying segments.
- Let the existing slow path handle validation and challenge ACKs.
- Remove the packetdrill reproducer from the commit message; add the
  packetdrill test separately.

v2: https://lore.kernel.org/netdev/20260909075644.1408171-1-inbal.lipshtat@mail.huji.ac.il/
v1: https://lore.kernel.org/netdev/20260906123151.1391349-1-inbal.lipshtat@mail.huji.ac.il/T/#u

Inbal Schussheim (2):
  tcp: exclude old ACKs from tcp fast path
  selftests: net: packetdrill: test exclusion of old ACK from TCP fast
    path

 net/ipv4/tcp_input.c                          |  3 +-
 .../tcp_rfc5961_reject-old-ack.pkt            | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt

-- 
2.43.0

