Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C93F0777
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404795; cv=none; b=uCvwEfjTE4DIWIIqsEeZzh/s/qCZtm9SoxOg9mvLNeFz1oCpkJo+UMmUby9Oqycc7nw2d2I6jNalV5UMLW4UelQCRyULHM4hNXd1bHJmr0g9+TCuOyI325m31Rp/FSqmCoMaC1A5AHOoCNbeUBO6eT4o9hE0GRxxq/BXBNdwIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404795; c=relaxed/simple;
	bh=8vqXnDNjy/ZpcD+yyfUpie1jDLplieWLAlfOd/VS9bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJ1FLusF69s7A1w6r4apFRXERsFxqgQiX4lt20mvV/Y4ssHbLwFsasJKHPyss6PlIdgY++xkmEGhm+uiG//hKrjvstE8VMbnINq4/aHiMq9nkrAFnPj9jhurNw6NLw3L9hBzq0ksZDhA6N6ZuLlc/pDOqk8iAf4vVZs0ZvJSApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cCdY/i2g; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cCdY/i2g"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1141744f8f.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785404792; x=1786009592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wAd4xFo0r8wvmjNNA1QQUVtEiqBDg/i9KGW3ihSCdmA=;
        b=cCdY/i2gmJ8C1N/Sp79JnyVow2pfgYZoBIXyVOzW3kovI8hGkd1U0PlsyOlmzIsx48
         wUIQFRwlRuuKlJ7HZFJRvBwcEfEylEqAff8jAFFHB72bEUnRitu66crZDZMXpJrg1Kt3
         TA0pqVo4eAworowhUWRVPk2X0iJ/pfWkzhwqjXlmI/pDCwuw8JQxnianKUCRaD5OdEly
         ztEX1E3nL2pthAGxWnAjyplSgnM/xA1a3rwfNvYO+/6yBxAdpckvN3IoqfON+BfISShN
         pkQ/UnreGVGIqu7qTg/GWc6gecP2ru9fos6EpXau7Avf7lA91qlDhOGPBK/ojmStq9kt
         Y8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404792; x=1786009592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAd4xFo0r8wvmjNNA1QQUVtEiqBDg/i9KGW3ihSCdmA=;
        b=JQhADTReXbsGnoNxGZpLUji4jeMntI5byV7DKDX9/MjNTQKp7acgmQ+DtOrC31e74i
         pBXfG2xGVdu2iYVoDUc02fC32+zjZeff0+Vc1r/xLtTOpF4xQzuuTCFxFXP+JYZTxKIn
         egtpxuyOXiPqp53j2kLIJ4sawSdaOCcdBNtHGITJ/p0ULqeQZMHZIHWgldL6chNv1Uul
         AcUUUDxfOU8NQrqEHIMffQPinWfEsFpinIl+e4tfMshu1URTiFFpDAUgQzfttUXVGmmA
         kBa9ZiJiZRwql+5OXaGddLUW+s59LZRnV3AlYaV8rcaVTQj7MyyK5Ye33lc7gN8/F9Kx
         fG6g==
X-Gm-Message-State: AOJu0YyEIlS7WDB0MIYrcPbVtZrmDVWgmPpdYWiBxptwBYCC3qONFrsJ
	OPc3cU6SaAQnjj33Vq+IibzmJJSw7AH2bPtFospbsJCX+iTouxjm3AgWAKBIDSwHmGBbwQ0tIDo
	d+bAEP6fnEHH9YOneDNUIngScL8lVZxnnBtdMM5FSaVl6g7RLGcmCNftaY/nNQCWE
X-Gm-Gg: AR+sD11T5t2MrA6gefWNGBgmVmvO2aGGgzqtfYJHUD/ey9y9P6yCgsPMg/In3Pa5nMp
	fUDq0VuCNKAgtKNcKRza3l3zoY/dExVj5WeGZrNooRKu8ylnAjCN4FhVk/apuTv4Ybh/4WX23AL
	d2Xok8ZWi5MAdStVvtSO4jD1Kz2Nz/DpZ4TN98RB+qaoNbKBbN/XsVo7XoZ9o75EjWJwQZnPb3n
	+nf1io55NgGFXqzYUwLbnL3AlgUnVJF43QhTCpIGZlk2XAT0hybtF1UXpxn8EUyEP9okzJC6/sd
	Wqp1KhtS/LEOCG2MX/QN+Kt+USkqr/Wb+7GEbOV7O557MXm7xtU/4GTmU9lNkGEX2hAoBZQUHVW
	qSxigvJgp2pV0XQXO+y9kU3qxT2H0+BHEQ/rMSO6hsZgKdgujwpcZzuTo8DDyPGWzdIyIzTkd0L
	XuOChI3JBM3SxPdnMGA0udgI1KjuK8Zk1eI1TdCjxAekUKCcIWBOhZ0UTTIIwRC1NAQP1twMsWO
	w==
X-Received: by 2002:a05:6000:2586:b0:47f:9ac6:ca60 with SMTP id ffacd0b85a97d-47fc806f1bfmr2664972f8f.0.1785404791950;
        Thu, 30 Jul 2026 02:46:31 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:97f0:8a89:3637:d698])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm6971410f8f.14.2026.07.30.02.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:46:31 -0700 (PDT)
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
Subject: [PATCH net 00/10] pull request: fixes for ovpn 2026-07-30
Date: Thu, 30 Jul 2026 11:46:11 +0200
Message-ID: <20260730094624.4102963-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

Here is a batch of ovpn fixes for net, collected and reviewed over the
past weeks (they went through a few rounds of sashiko pre-review on
openvpn-devel).

There are still larger fixes in our queue, so please ignore any
"previous issue" Sashiko may report on these.

Please pull or let me know of any issue!

Thanks a lot,
	Antonio


The following changes since commit 51b093a7ba27476e1f639455f005e8d2e75390e4:

  net: sxgbe: check descriptor ring allocation failures (2026-07-29 09:33:10 +0100)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git ovpn-net-20260730

for you to fetch changes up to 26ba17d845193dac4921ae1ab280d28d1938052e:

  ovpn: fix incorrect use of rcu_access_pointer() (2026-07-30 11:28:30 +0200)

----------------------------------------------------------------
Included fixes:
* use rcu_dereference_bh() instead of rcu_access_pointer() where the
  pointer is actually dereferenced
* ensure TCP global variables are initialized before they can be
  accessed via netlink (e.g. when attaching a TCP socket)
* actually disable IPv4 redirects on multipeer interfaces (the
  previous attempt was a no-op and did not survive netns moves)
* hash a floated peer by its transport identity only, consistently
  with the add and lookup paths
* zero the sockaddr padding before learning a floated endpoint so it
  does not leak into the by_transp_addr hash key
* ensure the socket is owned by ovpn before dereferencing
  sk_user_data
* rehash a peer in the by_transp_addr table when its remote endpoint
  is updated via CMD_PEER_SET
* avoid re-adding to the hashtables a peer that was concurrently
  removed (use-after-free)
* limit keepalive values to one day to avoid overflowing the
  delayed-work delay on 32-bit systems
* add the missing rtnl_link_ops->get_size callback so link messages
  account for the nested mode attribute

----------------------------------------------------------------
Antonio Quartulli (7):
      ovpn: skip rehash for peers already removed from by_id
      ovpn: rehash peer in by_transp_addr table on CMD_PEER_SET
      ovpn: ensure socket is owned by ovpn before deref sk_user_data
      ovpn: zero-initialize sockaddr before learning a floated endpoint
      ovpn: hash floated peer by transport identity only
      ovpn: disable IPv4 redirects on MP interfaces
      ovpn: ensure TCP vars are initialized first

Marco Baffo (1):
      ovpn: limit keepalive values to one day

Qingfang Deng (1):
      ovpn: fix incorrect use of rcu_access_pointer()

Ralf Lici (1):
      ovpn: add missing rtnl_link_ops->get_size callback

 Documentation/netlink/specs/ovpn.yaml |   4 +
 drivers/net/ovpn/main.c               |  64 +++++++++----
 drivers/net/ovpn/netlink-gen.c        |  20 ++--
 drivers/net/ovpn/netlink.c            |   6 ++
 drivers/net/ovpn/peer.c               | 172 +++++++++++++++++++++++++---------
 drivers/net/ovpn/peer.h               |   1 +
 drivers/net/ovpn/socket.c             |   9 ++
 7 files changed, 208 insertions(+), 68 deletions(-)
