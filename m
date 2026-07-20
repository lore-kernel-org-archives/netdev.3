Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E142DA4A
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558499; cv=none; b=I+5aqZUZp0NFS0TtJ2ukNs0EcxIn1ETL04yxijB9oX6EJEW08vTxrX0iPG9e47rXcyjzJGEgCNgmpPVeDWG6MMv25pa8xEbY1clU0Q+l0kIqAquV9z9GjEBB2Z3y4MjXZ9WPJRrEFYkM5bz60t86LEtSgCi5FDYLreOCMxh2mIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558499; c=relaxed/simple;
	bh=KbhSVhj8ydWvyCYVy78QiomwJJhQZLtqHlTFhfKJb58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9OUv6aX/1dymTN1wm60ce7ngMYZRznrakHIOO+KI9kSrjCWtkU+cP0AqUsZ15ps/FMOI0G4Ajsqkp+6XOsPUoKeZ6gLnIeidmltyiIG85SWyqemQ+AyRCWH9dktZMB19diO5y+hYMMA7OqajNbQiN/VcY4wIXq4R/sGo1EYnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Tz7xpW6o; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Tz7xpW6o"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f6609c657so1088142f8f.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1784558495; x=1785163295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWGlW/0F6NXZBAICGaUrx0HbVzGxk28bg1kcBbMFDDk=;
        b=Tz7xpW6oX+b/0mAuT1rS+8Rpp5jGI+zgHXRoHCmgrDvP9E7F4cqpAspzzuonixG86f
         plj25B76i6Uf5khLQbym2EDj/oYdacOwBJlEb3oqkCbgHcaRYJlj2RTXEm+EfpbKeADw
         NUbPI4F8oaVdrzjq2PN27kafGaCAKuCFHUmUSFhFfosN8Iv4kotV7uTNtuWjY6AJECcZ
         Xv1MgtWODvnVLmMyQ7tzgiw8IK5fI/X3e4VvUA7znvTeO4M/OEoFFtawAQyvmWwqsi12
         XShbNxkGfOU5R1Vc8nEb2WywniLRaCGtUVi7bgIv3HO7RAVcDu+/Y+4MQfAJmkAzq+oG
         Kpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558495; x=1785163295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWGlW/0F6NXZBAICGaUrx0HbVzGxk28bg1kcBbMFDDk=;
        b=ne7Cad1jU4okVy86UIB1ZEwdddQk/XQYsrp+MSeYARvtUUxIa9oupQcFK8H480lB8i
         +4FDZUdqDMKa4ghnNbv7RpLOJWETJrKhblP5cNfff9f3FMkI0ib0UnYnBb1HmYYj4FmO
         xXbftDie19qtkQbQNhMAC0CaJtDLVhUU51kUIPD+JtD9TVNnC55JxLET8RBGLTyrfQTC
         CFY6VLaI0lwssciZzVzyIj2/nvZvPfcWe1yFdH0Z6EQFR+ZXrPwCGDUllmK02tl25eWK
         5IB/6MvEUIyzn7tmweHFPWxgNS6HNVH6QL8t159ES1g8MhF8znbzdNS3a0hG+zdcDA7J
         varQ==
X-Gm-Message-State: AOJu0YzwqWoaChEZQOEOvVsKT6PbO+5v+lm61ZUW3qESel5APxTfb5ga
	L8MJaoT2cm6iX0PfTDGD96dvtyjM5Dqe54bORDqwqwml6oa1hvkqRyVFTQbjvZWs4pRjA3lHdhy
	0z7rvjO/eh6/2ZEZKR615GK2Ck2sbdMLa2lDdVmezlqCMjd/FrQoQUrmt4pS3RbaZ
X-Gm-Gg: AR+sD101LmbF2GC7dBLo+k0gMyQ8SYN1B6p81gUxLW3IyQiDAK/l97IIOgoakLvJlvg
	lJzIu1IzofzYOT0XfKOhisYOa2TntNKijbm9IMmIO7SPJ/xMm0NviAcFN9vip+I5Q2Nq0y1TfOb
	TN73Pzzi3o+7niU7Sq1IP9y+g2bCGzQPmgUHGBzLDHNpCYitPvOIFoVN57EGj6RIG9wA1H2awaB
	adxvRXQVKYtFJICJ/u/mz7ORcSnUaU4bvNCsPia9ZE32nCQIa4njosDs0/67wfRGsohARB4DqUr
	nELNtmc2b0AMXFUyR6jTJPBdBRJuG3BtWy0v0POiFX9L2e5V8ViyuSWYEKJLuisUtFaAe/uikHY
	4edQYwXJCCOor+i+U0haM71LsedAj6KRryfgb6o29Fsxvknp8loQDAK3Rvum/1q2Fp2VapUMUnM
	s/lXTyXADjUv/Sm4VBi17VPLLhTw==
X-Received: by 2002:adf:e190:0:b0:473:d65d:49c1 with SMTP id ffacd0b85a97d-47f6232c53bmr16967067f8f.32.1784558495400;
        Mon, 20 Jul 2026 07:41:35 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cf:3416:35c6:c361])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51c33sm26387406f8f.12.2026.07.20.07.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:41:34 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 0/6] pull request: fixes for ovpn 2026-07-20
Date: Mon, 20 Jul 2026 16:41:25 +0200
Message-ID: <20260720144131.3657121-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

This is a resend of the series of small fixes I sent on 2026-06-08,
now rebased on top of the latest net/main.

Changes compared to the previous submission are the addition of the
committer Signed-off-by tags that were missing on two patches (as
flagged by the SoB checker) and the amending of the commit message
about the new clock function being used for keepalive tracking.
No code was changed.

There are larger fixes in our queue which we are still working on,
therefore please ignore any "previous issue" Sashiko may report.

Please pull or let me know of any issue!

Thanks a lot,
	Antonio


The following changes since commit e13caf1c26587434f0b768193100440939c0fb91:

  Merge tag 'net-7.2-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-17 10:25:13 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git ovpn-net-20260720

for you to fetch changes up to f7e6287ccd3abeed9e638b581dc3fdf742106ba3:

  ovpn: use monotonic clock for peer keepalive timeouts (2026-07-20 16:29:31 +0200)

----------------------------------------------------------------
Included fixes:
* ensure keepalive timestamps are computed using monotonic source
* avoid UAF in unlock_ovpn() when iterating over release_list
* fix memleak in selftest tool
* ensure reference to peer is acquired before scheduling worker
  (which may drop the not-yet-taken ref)
* fix refcount leak in case of concurrent TX and RX TCP error
* fix potential refcount unbalance in case of sock release in
  P2P mode

----------------------------------------------------------------
Marco Baffo (2):
      ovpn: fix use after free in unlock_ovpn()
      ovpn: use monotonic clock for peer keepalive timeouts

Pavitra Jha (1):
      ovpn: fix peer refcount leak in TCP error paths

Qing Ming (1):
      ovpn: avoid putting unrelated P2P peer on socket release

Shuvam Pandey (1):
      ovpn: hold peer before scheduling keepalive work

longlong yan (1):
      selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()

 drivers/net/ovpn/io.c                       |  4 ++--
 drivers/net/ovpn/peer.c                     | 16 +++++++++-------
 drivers/net/ovpn/tcp.c                      |  6 ++++--
 tools/testing/selftests/net/ovpn/ovpn-cli.c |  4 +++-
 4 files changed, 18 insertions(+), 12 deletions(-)
