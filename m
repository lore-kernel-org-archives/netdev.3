Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F93C3C07
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986142; cv=none; b=TokV8z8FXoZ+pG6cZKFdqcGnBGwSlty05Q12fKLesUEwjf3x/MdyFhAHZf6QrOUqQveDPqFjxiwy1UUd4dkLK2yPtX8me+j1S6Vp1LtMygqPmkmfmJdYsKkl1B2VkSYNqqQ2VUaOAJgwGYEDCaAQ8By1L0BfJuaqX8s+slmZIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986142; c=relaxed/simple;
	bh=AhE8kBYCLyQqovO8XjRwBY5QEJLeOlD9SoziBjrzcYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIDMPHQ3C6Y0oqCoSSli4SSY5TIwzN8C+B4WhjJr8RGkC6MARwmMTIadLX7+uz+Pel8NNvX/7F6KYG4krO/m/8O6Rux/FiKJwmoiIqy/2tFM6YBVIPWP2C9WP0IKe4veBCD7I3kSEyH2Kw+kcWTzDmSKbIxelNFSwriKsqx9/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=P4t+OBR+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="P4t+OBR+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so18922585e9.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986138; x=1790590938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A360j89hUXEJA66TcDDuqvfuNJeCBxj9mKkqGF4ekdE=;
        b=P4t+OBR+yNwXDVrrneYqdxCBM/Sy1Cl8sYsh9bFhZNzKA8LfhHzrwaA7WqmqoRdDNy
         y2YlNn6HIrKfNeh0mqXxnWKiNGbe5WDXbqCyDCfVH1sq7rKRNqgztlsPoQcrcGgTvmjN
         YUs3zhW23fX4oVHP/+XhUaQRfBTUUwKIIOCdAhXrVFjFpkZg5/IUqnlsp0UAWtnpeegC
         urQtft7RghfI/AjBmPdVtIBhi77eC8P5EQvulpNK48DaEOBjsg7JSFVJVMFRetMLJ+Ji
         OVhdMKF1l6AkbwNl40nluJ3hc6+deJlM1OMy1sYdJvk3pH6uQDVCYKzdr0G52F4J1Rr7
         nilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986138; x=1790590938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A360j89hUXEJA66TcDDuqvfuNJeCBxj9mKkqGF4ekdE=;
        b=xv0AnO+yuph9dT60xsMhfpLZDs6gLmAnsYf/Dvsu7Bcb2uZMSjPCFGe4+ihqbeerwj
         nZ9RXeQtBE8joUnVBV4r0Nwn1UqPlfexeuM7vDiYROcBgKsQllwulN2Y2zPdOEAJRkYu
         mTHNxmCGnBiTpzllFGxjwF0dNFgE3v7gEf10uoECjIhHuPLtFk8HAzDFEqooLkuZCVHG
         51eryoTD6FcUgseaHW9rIUwenAgGw5yiArwCfDufOlYHMw27eNyrdHQbe+YY6Xla5HTc
         BIViCRVN8OsfpKqKcP4CsZHnbcr4o7DBAI8IqacbRDwIfuXIyWttkhmWd5vKi07+3OcX
         iD8A==
X-Gm-Message-State: AFuF++mXBRHCNLhZFTmIL5NQGi5iruyCuLHbS4og537LiB63vDGBW7D3
	flvUb2B65aXF9ocv31OwOd8uAGtLv8IEoBnoBIgZjc1LPSKNpIf5eoZigMR77A+xYixqW80is1s
	SCPuooCsN3MAwPrP4GoyhFOs4TKAn5SueNEWpe3veZgA873mA2LmMCeR+ZKVbICJjhLA=
X-Gm-Gg: AYBFou3iZX03pXVLFy0cFGhR2LApLAXfUBxUSvaC4DFjdD25UuE/NJxf6MO6DWJKSzi
	xtGBrTdw8sUjDX+q681tXOTojwTp7D8iayuczXlk4nib/mBTuueg3c2mqKjbNKzlkzidxZd96L2
	Yec6KZZdSEo3k5m9UsJUYmfdvGwFPqcXq/Zq5dPEMOH5v1l3x4DhU8+Rcv6FWw9a7muKVW5tOMs
	1ACrunttkTSu/ckTq5wYV/H9ljvZ1Gliun5vHQREhKWSpmFOZyc5DH7kjfhi8YsI+XFu0d55X9c
	svwifs63vep/3GvWOKrfsYfLHEBl7w03H+ZCioAFNh+s5Q7A/FVElM7YUqYi/bjxQYvhmSDT7Mq
	k6CefWijtzZKMp47jFEpMCgBq+UVGbo140rQjaEAAYePpxF6DFUEW87ZmL4KXe6LxprQLXnKI8B
	D1gR3uqHaluZ6Ugxdj3BQQ2diK/Wkbco0kKfUQ5CaSo+JCtJTftiOQO4a8dx1rwVjHrR6EYP8p2
	jYE8aVuPmvZ
X-Received: by 2002:a05:600c:34c1:b0:49e:799a:8951 with SMTP id 5b1f17b1804b1-49fc56aba0dmr158594105e9.11.1789986138170;
        Mon, 21 Sep 2026 03:22:18 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:17 -0700 (PDT)
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
Subject: [PATCH net 00/11] pull request: fixes for ovpn 2026-09-21
Date: Mon, 21 Sep 2026 12:22:01 +0200
Message-ID: <20260921102215.3599702-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

Here is a batch of eleven ovpn fixes for net, all from Ralf. They come
from two series that went through a few rounds of sashiko pre-review on
openvpn-devel....

There is also a patch for our selftest, which is just a companion change
for a fix introduced here, hence I attached it to this PR.

The first group hardens the UDP transmit path. struct ovpn_bind is
published with RCU and read locklessly on TX, but the local endpoint was
still being updated in place, which can result in torn IPv6 address
reads. The peer dst cache was also not invalidated when the socket mark
or UDP source port changed, and a route resolved from an already
replaced bind could end up being cached. On top of that,
netlink-configured IPv6 link-local remotes lost their scope id, which
breaks route lookup.

The second group tightens peer VPN address validation. In MP mode these
addresses are the lookup keys used to select the peer for an outgoing
tunnel packet, but duplicates, peers left with no usable address, and
addresses that can never identify a peer (multicast, broadcast,
loopback) were all accepted. Such configurations have never worked
reliably, so they are now rejected at configuration time rather than
misbehaving later.

NOTE: Sashiko points out that ovpn_route_key does not include sk_bound_dev_if:
that is a known gap, addressed by the bound-device work already in my
queue for net-next.

There are still larger fixes in our queue, so please ignore any
"previous issue" Sashiko may report on these (is it still reporting
pre-existing issues?).


Please pull or let me know of any issue!

Thanks a lot,
	Antonio

The following changes since commit 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60:

  selftests: tc-testing: add a lateral-drift hfsc classify-walk test (2026-09-19 16:42:11 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git ovpn-net-20260921

for you to fetch changes up to 006208026819d5e9e5ec07b3e73d95960a059327:

  selftests: ovpn: validate peer VPN addresses (2026-09-21 11:39:13 +0200)

----------------------------------------------------------------
Included fixes:
* add selftest coverage for peer VPN address validation
* reject multicast, broadcast and loopback peer VPN addresses, which
  can never identify a peer
* reject MP peers left with no usable VPN address, as they can never
  be selected for TX
* reject duplicate peer VPN addresses, which made peer lookup return
  an arbitrary peer
* fix stale entry left in the VPN address hashtable when an address
  is cleared
* fix torn IPv6 address read on lockless TX when the unusable local
  source is cleared in place
* fix torn IPv6 address read on lockless TX when a new local endpoint
  is learned in place
* fix dst cache being populated with a route resolved from an already
  replaced bind
* fix stale route being reused after the socket mark or UDP source
  port changed
* fix bogus validation of an unspecified local source address, which
  must instead be left to route source autoselection
* fix IPv6 link-local peer endpoints losing their scope id when
  configured via netlink, breaking route lookup

----------------------------------------------------------------
Ralf Lici (11):
      ovpn: preserve IPv6 scope id for netlink peer endpoints
      ovpn: skip UDP source validation for unspecified addresses
      ovpn: track UDP socket route key for peer dst cache
      ovpn: validate peer state before caching UDP dst
      ovpn: replace bind when learning local endpoint
      ovpn: replace bind when clearing stale local source
      ovpn: always unhash old VPN addresses before rehashing
      ovpn: reject duplicate peer VPN addresses
      ovpn: reject multipeer peers without VPN addresses
      ovpn: reject invalid peer VPN addresses
      selftests: ovpn: validate peer VPN addresses

 drivers/net/ovpn/netlink.c                  | 108 ++++++++++++++--
 drivers/net/ovpn/peer.c                     | 121 +++++++++++++----
 drivers/net/ovpn/peer.h                     |  25 +++-
 drivers/net/ovpn/udp.c                      | 193 +++++++++++++++++++++++-----
 tools/testing/selftests/net/ovpn/common.sh  |  13 ++
 tools/testing/selftests/net/ovpn/ovpn-cli.c |  54 +++++---
 tools/testing/selftests/net/ovpn/test.sh    |  75 ++++++++++-
 7 files changed, 493 insertions(+), 96 deletions(-)
