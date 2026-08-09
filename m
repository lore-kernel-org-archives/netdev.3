Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773532C0260
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786310510; cv=none; b=ANPNgtXLwPo/ibcsLW1lx1HWYWstEutanbuysYTsa7P6wa+JfS3RtKlWclhrArCQp7tRxd6QpGcwXVa1acB+AemCGwtqd+sAIxV3eBmBw6tdEO8ka1OfRcWYf30BvyV2eYl+07MgW3G7dcN3uLZ5aSnorxhChanLlUwOmR3o8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786310510; c=relaxed/simple;
	bh=etVI0yjaaakMG75+rtIMPYoj3ECGHUwCgXykny0Rcuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tS+t5wAGhCH9cpgU31b6JqT3DAVtSxziuo/KJUHp8KkWeOujIhIClne54UEs25ESGd2TC3fjKpelZEHGGwgxLoqY4MRcV+x6/dDvT1S+VPAmRoV1l6yohqgx4cebDzQNpo2jngCBFMgfCqeyIfwDANzkm7xv6wKGsfn84owdx7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=C/stbQGP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="C/stbQGP"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fde295992so925110f8f.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786310507; x=1786915307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=10rEbDfjFih00sY01YWUyBbZUGocDKlJTNwE8WVbpPo=;
        b=C/stbQGPZrtFnAeFpY8bE5hNiTsXwcoRdY8aXITsz1vzeUs4mmTl87OBrD2pq/GfJj
         xZa8OgOcSty/Av3oZH5eHvw33E8AQuxgOWQA/74t/pDqjFHmTgBc6kknmDgjG5Pt8LiO
         v8RAOtggsfcZmc+FejWD+6yYiALjvqEmTWIOxUbxSUKV/LT57addW3F95WWVRKVge2yq
         j3nLYjPEnlaHdXDtikwaJa8n+EGJKgnGQkBztbXKIHvbxyRws4U+C6T6Vs/TxAjVYiMo
         pBRQrpj7ck5p3CG6f1P0AQm3O3qLAuFemAMY8+erESfrz1ssVXvXIFCjuuDeyrOmSiL3
         3izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786310507; x=1786915307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=10rEbDfjFih00sY01YWUyBbZUGocDKlJTNwE8WVbpPo=;
        b=pXxNUPEcJzYe8NcN4WY3uDKskDQKcvSAgMsMSBGg+F7bCppLou/tva29671dKsjlTC
         TfftV/cE2ePNUnFDT3XPqPe2HJ1EsYojRzPhTqwOP9iDMrrz8Ivdx3ETNpuLowZmUN2W
         cSZcUjbUrbvMeaxchcNCnnxPlRF430nvBHzBXBdZgNpR172AluIj/2TniUbiRCyeLzqB
         0qoIQhsG7Eluuz/oT9LYcJ8wsDja8YSVP3cDDjdil2iFFWHdtdgtp3O3cShJZaRIdPF3
         nKGiqBJAcSVyqYYYRR/3UjUjz1tfOFb74wQ7hBmLYRitT59XhsR59ZpXFgVD6kWZDCqV
         lMQw==
X-Gm-Message-State: AOJu0YzEjKSPyG1KCih3FwCZ6TkUNnq/Dplc5jumYj0KNhDkTrRS+AVe
	4wQBnw1OO4Tx2mRRhAznxNOlFkyJylmEzZ9f5viFt0BRicEVWVU3O94oQRkzhEDY4D0zsb6C5hg
	M29iUBZ+y4IeEzcSDFjT2s7cXng7JhtS0uQFOa/ibv1D4XpIj59cwwB1SO3pNozor
X-Gm-Gg: AR+sD12YYf+bQX0Dz7LSNF0xdEnIDcySnqSr9dlp79U7gvn/7WFiae7/pKkK1wbYPpv
	b+266F5uHmXd1j2kpQ2e7dP8qp4xfwP+qPqXzW60W+kKJ4AtJLXNfKW/9En3T7V4f/85/s1Mr4+
	vtFgBPOYCiRv2kwj5iy4oCfDZ8vV1JHG1Dbs7p9Ygh9SQVZ9guQ6L8io8D4zhNfdh5RpyIPVHtW
	IBuvMGZtP0OVGQC0ZSacsxflTT74Q/BFR4PedyK2nU2bzDG7UBpj4nkmpAe4uYiw5/gUpkUa4Q5
	DQ3ZNJnIm1xXI8C4pNeBmVNRSzHjyQ2SsSA0EfU7bpCWl3MazHgBr5p1Bo6RlHp02ZvMc75J1P3
	yr+Z/XOhVY5sfwxsTQpVu0I2FnfPhtdMg7a55uOpKk7Dd8LbezuZnOviMgaQulLa3a5bOuPdRRV
	8s31jxJlC/HNt/WeVokuRkw3CwSuS8zeTC+r9kxEsjaWzaFFBvTETpK58z1gdf6z0YQ1OdaqJQw
	pXzahHE9uIWpYGk7F/0aDM=
X-Received: by 2002:a05:6000:2913:b0:47f:7fe0:a287 with SMTP id ffacd0b85a97d-481319275b3mr12939932f8f.2.1786310506527;
        Sun, 09 Aug 2026 14:21:46 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:58c9:fa0e:8293:9eba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002206effsm24976651f8f.32.2026.08.09.14.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 14:21:45 -0700 (PDT)
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
Subject: [PATCH net 0/4] pull request: fixes for ovpn 2026-08-09
Date: Sun,  9 Aug 2026 23:21:25 +0200
Message-ID: <20260809212142.2249027-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

This is a resend of the patchset from Aug 7th, with the
alloc_workqueue() warning fixed. I hope I am not too late!

This batch collects four ovpn fixes for net that I considered critical
enough. Anything else has been postponed to after the release (or will
directly go to net-next).

All patches in this set are from Ralf, addressing key-slot and workqueue
lifetime issues:
* a NULL dereference when killing a key that is not installed on the
  peer;
* crypto completion callbacks that could continue their cleanup after
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

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20260809

for you to fetch changes up to 2da3dfa1ddfe55a065f484750c83660e3bd4ac00:

  ovpn: defer key slot crypto freeing to workqueue (2026-08-09 22:47:57 +0200)

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
