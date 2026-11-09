Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253729;
	b=gQGAhhAmND3aFxJEA0WJW9aIDKcs7JHWu8IwqrZ62EIagmF44djS5k7MlIf38aRzfIxQ
	 qNFUHiJqXF8wP2aO0jbIdgl/6tpFlj3mg0hzAY6jOV77QFeAoOu7BkuU+CIu9T7I9Sw8M
	 HOp4jpgulyLlodR+u/ISMXpDjCnaf53mPdePDHR7V9DjQwOzeC6zacNAJsbWQu27LS7tL
	 2r1U+yvOXPpxxd4lnoi+t8YM5n9KqsNWNuxZ7Ibw5csOHjsqiQOkNAQHn7J6DIzldlTlJ
	 Ydn3BJXDQ7eTBxlEcmYOMxVHnGJTak5Uxd/sd1K3L8NljgZjgPVDEwflRPTVsthPsRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253729;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Jfp4zHsLxysYo8Zoonr7Zms8JprnC2A6DztGlJwzB9g=;
	b=Vcr1I57moq6yh0PPmciAglMBjOoicdfOBp78m57rUyrD+g1FUBza+z+LNIQYcqOAAjAc
	 F2p0ghAADZRos/wnEn2ut9TGD3WqinLFhaDjDXdJgsOBSVxByFxk8yu3DsEKJ5p/cM4HP
	 B8YFvl9xim8tY4ySE/HKSOjhaslrbugn34JPo0vGQEhR88lZ1/rXVnrkY1AGNCnrlLDjA
	 WWGqdiqRvHjjrU3vVAhujxMcH7QjsjC7qnDzg+HSLTuyHbZ0ew3g7o6LYs9lZ0dGpkLLx
	 AeqNOuzCxc/6sHWVSdgb2ciZ6g+elcAObvzfgGRh6MKeKr2AdHozttrvL6XZV03LCZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGU6CnAI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A7606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGU6CnAI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2BF1F008A3;
	Mon,  9 Nov 2026 19:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253728;
	bh=Jfp4zHsLxysYo8Zoonr7Zms8JprnC2A6DztGlJwzB9g=;
	h=From:To:Cc:Subject:Date;
	b=gGU6CnAIWybsSJglqPq+/YdiHm6T76DQdUbbHgZPrmskuV/LcLh7MMBdHGUNcNO+I
	 XMeEwFBg/qjQOR2isd1ES5IW1x664ESUZSr1m3ajnmEi/EGGZcEUg9xLvK/Os9jWtK
	 fhf02+V1a6nsguqgeoGXyPNBeyRU+IKPVkVxnNkqsEAMsJNcyhMb1zRsYMpfYpp7Ed
	 22u0asTfuIWP2fDHoXeHrNsadbeLE/XUycx8J8mFGNbf2Pm8s5LFrJDUDqZx0hGf/a
	 zCHoTOHKFqOvL/5icYniq2bJnM6Ti1AoIYCv6yXO4GAkxLH//uFe09Qr1y42HmdWZO
	 T9JwcQi7mGz6A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kameroncarr@linux.microsoft.com,
	ernis@linux.microsoft.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/5] hv_netvsc: make XDP propagation act more like bonding
Date: Mon,  9 Nov 2026 11:48:38 -0800
Message-ID: <20261109194843.1353592-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
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

Currently XDP programs propagated from uppers are invisible
to safety checks. I'm trying to fix that, but AI reviewer
threw up a bunch of complaints about hv_netvsc. See previous
series here:

https://lore.kernel.org/20260928223648.2739371-1-kuba@kernel.org

That series is now on hold, let's try to sanitize the hv_netvsc
behavior. AFAIU the main use case is to catch the VF as it appears,
and attach it to the netvsc SW interface. If we catch the VF
as soon as it appears we shouldn't have to worry about the VF
already having XDP attached. Let's do what bonding does and
refuse to attach if VF already has XDP, also refuse to attach
if nv_netvsc has XDP but the VF refuses the propagation.

All patches are from LLM reviews and LLM generated.

v1: https://lore.kernel.org/20261001014131.310771-1-kuba@kernel.org

Jakub Kicinski (5):
  hv_netvsc: fix the program refcount when the VF refuses XDP
  hv_netvsc: hold the VF's instance lock when installing XDP on it
  hv_netvsc: treat the VF's XDP program the way bonding treats a slave's
  hv_netvsc: move a new VF to netvsc's netns from a work item
  hv_netvsc: let the core take XDP off a netvsc device that is going
    away

 .../ethernet/microsoft/netvsc.rst             |  11 +-
 drivers/net/hyperv/hyperv_net.h               |   3 +
 drivers/net/hyperv/netvsc_bpf.c               |  70 ++++++++++-
 drivers/net/hyperv/netvsc_drv.c               | 116 ++++++++++++++----
 4 files changed, 169 insertions(+), 31 deletions(-)

-- 
2.56.0

