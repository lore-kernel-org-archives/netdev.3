Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C74B04B9
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062179; cv=none; b=Mpt4K+rMxAdxWa/P70/3egeL8i+6F//P+iYX6cbdxxzKx40IbHTVxfQjowQ2DicxEvnpRXnNqFrxWsLjq7G402XMxy8xdWj196arNR+tRjwMSZwR9rzpleE4ZmlojU7ejdqDWLAAj8zxRVYTrjHCXxjE2kqvN1XbWfKtcs15qZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062179; c=relaxed/simple;
	bh=a7+I5SzK6kzWUrmMV+UflxGmFZS5HE4/91kuzGnXbH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cadvf1hfUNcIe05txaSxqsi7zwld+X0/zOjb8ClsdlVvvjEQyBx82Hq/eanVp4MsvqHXuqiJV0IoVvEzZNoao7MqAt5qwNTG93zOV7awb+Ej9dlQMWi+s0iQq5wK/Mhi7XZMErWyH36o1GQbfsSg7D3I6PqANzp6GdSIx53Gw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=P6Cvlkt9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="P6Cvlkt9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49954b88fffso11471605e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 17:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786062176; x=1786666976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/e+aziBYoBsAHiPO9Sv2tW2ULKRjwcq9BK4whI4yDA=;
        b=P6Cvlkt9zRxUoNZ6jOF79Jx7h11mpxPp1MM6r0+CI/dSIF5+uhViL+3hyHDEfCoogA
         PzoHIdqkUZGiL5CWZUyj0Nb4SoMTHJY4e+0oqoE3Da/EXZEGxac0xkHvRgZGRr5W7+Df
         EhGMw5+kVu5SUo1uv/p2st8bRuODOakshxpuBtSJ2jwuXPsk6JpI/2CRGyyYubVFKjkR
         13iIU8Ia7qD/z13N1N4YaakwjePYgOJvmXhgq6SgFf3qo+w9QBT3ez7QmJQ06QpSd5a6
         yovNouQpGgPA++KfWhsEqBnayZ9JH+3YvS6uoZd7ixEOOZNx5DWTWbY7RwI4ijurQGQM
         KO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786062176; x=1786666976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/e+aziBYoBsAHiPO9Sv2tW2ULKRjwcq9BK4whI4yDA=;
        b=G79ZdBaUUwgAaVFdiAnYELRuFPaSf72ssysuyftLWt/sJUdhlQuGIUkMVAIvsIpBcc
         zR5XQ4pt3kJbrVep2rnrHCj3qpIDxyuXKc0K69I58Iup+VO+30RZ9SDTMoIv/3NK1A3S
         bj3JpExTY1xiE8vCgNqzCbRjWNuQVG1S/lN8mgOECKD75i5C7EmoK6070gzNjqKZaJnD
         zYhkchnElwFa0HobBrIljTpehtnINasCiyeckKLkIZ0PrSQeRE4qWldC2Zk16/4PNPc+
         Lu/CcW16BFDUwtoLpy6e4D8LKtmiq6WWmPuJMtrdbhiiqCEzEjloW2tyL6Cwrgo+9Qz9
         JTfg==
X-Gm-Message-State: AOJu0YzENJiu60gWLKiHf/73v5sai2xXfttKHecngZSpJQ3iHWsEKFdp
	0GTLz8bqvT0CUvay0nhB5/pFVSanV9iEuSpXJyDAOKkF4q9hb8BRvA5QUKCJd+j2DMpVdNk2kLZ
	Zkyx38Zjj3kCdTTHKg+lYhZzR/A/rM6i/OwrjdW4RtEcG55vebJHZtelkHSq83BIe
X-Gm-Gg: AR+sD10L2hHajm2bPFryAI8xXfRcdY2eCcW38+wCbdM3PINKIxAn1eizRffOELy0aNB
	yjfamALJTbtR4f8dyzZzNUDacpMUi1RyMGTzUYcHoA4XdCzBx7ejSBZy0dEr582ctNND1GCCL0P
	lFMouRYaTYxsuweG1+Tk4T11WRwk1SmUrlNExPPNLJHaH6j1O1b1PPD9SrM5Il7MJWvyNMgKX9J
	O9qL0BTL4cpzNauDQdLkdFpC6H7GrqzGkEPATYFNsg8/BivSH+61+jxTYoy7g5QG3hFUOCnXZzc
	qolK1JpZHGWm5yEIr6eQf0qPOBHklb38zbSgvZp/Vm09TiE7solXR7f0cib8a0KUkmh1vzrvLvD
	QwZUV0qYRwgrRlqKjGxWLVvh4xAz8Mg/dclGDwTj0yLytNhHxu4tfPb1FQBXymEHjq5vFCI3Xvf
	41YervnwWUIJ+eP6Bbwv3r1vmOoXl1nlJ23CGqL1hVp4TjXvF+5AQtnicT1R2UtIYsTGUVp+7dE
	9Zvq2sQh2v0
X-Received: by 2002:a05:600c:12c8:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-4994e7baae6mr168088995e9.10.1786062175961;
        Thu, 06 Aug 2026 17:22:55 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:6db2:29ac:6c1f:5e1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm359215f8f.22.2026.08.06.17.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:22:54 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 0/4] pull request: fixes for ovpn 2026-08-07
Date: Fri,  7 Aug 2026 02:22:40 +0200
Message-ID: <20260807002250.1817498-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

This batch collects four ovpn fixes for net that I considered critical
enough. Anything else has been postponed to after the release (or will
directly go to net-next).

All patches in this set are from Ralf, addressing key-slot and workqueue
lifetime issues:
* a NULL dereference when killing a key that is not installed on the
  peer;
* crypto completion callbacks that could continue their cleanup after;
  releasing the peer reference gating netdev and module teardown;
* deferred work running on the global workqueues with no driver-owned
  drain point at module exit;
* AEAD transforms being freed from an RCU callback even though
  crypto_free_aead() may sleep.

The series went through six rounds of sashiko pre-review on
openvpn-devel and should now be sashiko-free[tm].

Sashiko will still report pre-existing issues, but like I said above,
they are not critical and will be addressed later.


Please pull or let me know of any issue!

Thanks a lot,
	Antonio

The following changes since commit 594d905195024b228c962627ae5ae7c17bd582a4:

  af_unix: Unlink scc_entry in unix_del_edge(). (2026-08-06 11:52:48 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git ovpn-net-20260807

for you to fetch changes up to ab0fa79efbc496817d877470be507c21462142c1:

  ovpn: defer key slot crypto freeing to workqueue (2026-08-07 02:12:13 +0200)

----------------------------------------------------------------
Included fixes:
* release key slot crypto transforms from a workqueue rather than an RCU
  callback, because crypto_free_aead() may sleep with async or hardware
  implementations
* run all deferred ovpn work on a module-owned workqueue and drain it on
  module exit, so no work item can still be executing module text after
  the module is unloaded
* finish crypto callback cleanup (key slot release and leftover skb)
  before dropping the peer reference that gates netdev unregistration
  and module removal
* avoid dereferencing a NULL key slot when userspace asks to kill a key
  that is not installed on the peer

----------------------------------------------------------------
Ralf Lici (4):
      ovpn: fix NULL dereference when killing missing key
      ovpn: finish crypto callback cleanup before peer release
      ovpn: run deferred work on a module-owned workqueue
      ovpn: defer key slot crypto freeing to workqueue

 drivers/net/ovpn/crypto.c      | 26 +++++++++++---------------
 drivers/net/ovpn/crypto.h      |  4 +++-
 drivers/net/ovpn/crypto_aead.c | 19 ++++++++++++++-----
 drivers/net/ovpn/crypto_aead.h |  1 -
 drivers/net/ovpn/io.c          | 10 +++++-----
 drivers/net/ovpn/main.c        | 19 ++++++++++++++++++-
 drivers/net/ovpn/ovpnpriv.h    |  4 ++++
 drivers/net/ovpn/peer.c        |  8 ++++----
 drivers/net/ovpn/tcp.c         |  9 ++++-----
 9 files changed, 63 insertions(+), 37 deletions(-)
