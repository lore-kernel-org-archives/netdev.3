Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F635A39F
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752496; cv=none; b=CNr1tMbMfLJBzQHpOLDwUZoq87S6faljxP9Tf5UuC6UQ5lAvKAV6XBYYPcLIE3L5+O9aYjBNCkn37y2jyogzDtfZqWCGZn4kM+PA8HkDNl6XwF02ePItyLLQitFfBczpC6GXyUaCk9gHMfOB0pt4yHIYQ7lAnhi3j8WJ1EYLS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752496; c=relaxed/simple;
	bh=r4WBstP8E1wpz6/uG5wDcPqY6nEpJ2c97HTH1sCETKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTzzY1B0jojWpIklHH9rqBKn5wwqfbfbVG3I9EnbHB1wFK2kAYP5gaK7JsCrb/lwuDzpxeAcCOlOUBoXYIGdvWLfq7vIfiOkAIFpJY/fqirASjApRs/e2ggNXqprZDtycqBugOwzj3AEQ7NNJ6oAPuALVAY7j/0LaYgMWQk3dNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cTMpBMLB; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="cTMpBMLB"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so46378265e9.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752491; x=1791357291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8k3N5NCfHWljQVwTPRV950V+62uw1NSwz7X6rrxFOfs=;
        b=cTMpBMLBtqKk9Tp0/oAdplTikMFt3Ujw+dFZc7DMmQcO6vu1LVHxOfcl8fRGPvQpm5
         0dcOgJ7P9EiR73cGHFx3FYmdCMcAmyXHyqhco8jzXjLP64qkY3G+4PFO4A6DhPCXhbkq
         kWAbBJ6gzlo8gbVrvaw3SOkQLd9jMhlDhd80r0xUGvyTjhHiWLc8BG/i3M5JBc8WG8g/
         gd6no+Eey74dBS9GbUDMkw+INVkdX5Z8cInztWr9BlWaYoAhn6VuNpcXsNTwgKpziiU0
         6KLs+pX1rlJRUfyF1MrQvsJD0j7PCw8vMTlKI9uXwTGY00XrHQTc1gTdsPIwDDQe4r/E
         Lcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752491; x=1791357291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8k3N5NCfHWljQVwTPRV950V+62uw1NSwz7X6rrxFOfs=;
        b=rdWCdcDPJ5IMCviwOpcWX4DewZeJkSFe5mjuGR+Y7E2MfIN/G1A1ceVaTIovi9aV6b
         J5RYGV4qMGziKMs3+WHn4wD+Ax2Vh6HzFIwCcHnpcj6OldWIGvmnapgkwVg1NWd1TsXe
         eUOCl1CvwMmD1HeJnoFjzv0lVTTjCW2YO/enTx3N4k4Eh/PniZZcsV9qGzH6Xrc2zNeu
         0aGWVEWerDTQOGdQJfvGTqKHpMN5Yr/zBs7E9EllRuz1LqH+lyDYc1ASOlAEo+XheR59
         2VJozzLer3nN+M65w7jWSt5BoXrHBK8ymbVTTXOerP45DnQic1EWnwFgd4LCznI/l7x/
         kgEw==
X-Gm-Message-State: AFuF++m9xPsyqVq21Kg5jbQ80W7TFiVMW8k16fop1JMYFtlvqXBoRTgt
	qIMx67JTYxXgtYEAvkVLWQpJP0hy0ZkkQeoFDavE2GmZbeg0/4vyqe5oJ6Fz4AzYvVLo4PVQIdW
	+1P6X
X-Gm-Gg: AYBFou1DpZBDzVESmWhuap6su/y2To2ENcfZndW5xT/1bg225fRcXb6w+a40GYM0hAJ
	gUy3HgvHxygzvMeFqZ+GdNiuuscepQkKoJxYW9aUJRMZjvub6YbkZ4wliRK+UF8pOwENCDYIBFu
	RJ5bKQS/2WwfUiA7L+g2aYeBJbbEekPGeiNnsWKrSlfm7aU3Di9R8aDf4uCMFzDdnex22UPJ0g8
	QZqMgAzJmJR+AzXSrQsFNB5gJBBeBHYTiFVQpyJxKenWSDRLjBxwLQWwusviNtMCaYvYTVCJsdN
	V9br6iXW7QrCaBAhYXhkTDsFuVEqvFfXiGqih5VFT77dfinQasxmlkgc4zIkBe+kOVVvT8HkXOX
	rgw/n+4RLwVLXMbsWDbCnAjeL+Rrn8VQLVn23lkgMTjwkALm1gY//oYNc87bjck/DO7AsOOReq9
	GVSm4JGw+tIVXvKQXXrzM7hWeJTCGIdECKj48qPX+ITgGfwfZFCtsHss8ZyK/J1f2ZCHMhuhq76
	2i6pmp84zmbDWrL/CT4
X-Received: by 2002:a05:600c:1d0d:b0:4a0:151e:f743 with SMTP id 5b1f17b1804b1-4a01b00fba0mr5657535e9.19.1790752491395;
        Wed, 30 Sep 2026 00:14:51 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a0175025b5sm17893405e9.0.2026.09.30.00.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:14:50 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 00/12] net: bridge: vlan: optimize standard fdb fwding path
Date: Wed, 30 Sep 2026 10:13:59 +0300
Message-ID: <20260930071411.2786201-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
This patch-set is a follow-up after the bridge flood fwding path
optimizations and applies the same idea to the standard fdb fwding path.
We are able to remove 2 vlan hash lookups in the standard fdb fwding
path by caching the port-VLAN pointer in the fdb, to do that we switch the
fdb dst to an opaque type that can be either a port pointer or vlan pointer
differentiated by a bit. The field is a struct and also has a __private tag
so we can catch direct users, it should be used only via the helpers.
Sharing a field makes it easier to pass it around and also allows us to
save struct space for the fast-path. Interesting case is when an fdb is
promoted from a raw port to port-VLAN on the same port, it needs to be
handled carefully so we use cmpxchg to make sure we don't generate
deletion/replace notifications because it doesn't change the port.
I tested VLAN deletion after these changes (we now wait a grace period for
every delete) and the hit was ~20% reduction in deleted VLANs / sec
deleting 4k VLANs took 14ms more and on my VM the VLANs deleted / sec went
from 63k to 52k / sec. The complexity to batch them is not worth it.

Note again internal sashiko finds some pre-existing issues - I will take
care of those separately as usual.

Overall the improvement is +10% Mpps and -10% cycles spent in fdb fwding:
 64 byte vlan packets, 4k randomized fdb hits with 4k fdbs, 5 million
 packets passed 5 times for every case
     VIDs  Ports       Mpps                 Gbps             CPU1 cycles/input
                  before   after     gain    before  after   before  after  reduction
       64    8/2  2.375486 2.635811  11.0%   1.216   1.350   1724.6  1553.7    9.9%
       64    8/4  2.376731 2.636459  10.9%   1.217   1.350   1714.8  1554.7    9.3%
       64    8/8  2.376621 2.635783  10.9%   1.217   1.350   1722.6  1553.2    9.8%
       64   32/2  2.375876 2.637897  11.0%   1.216   1.351   1726.7  1552.3   10.1%
       64  32/16  2.376442 2.636426  10.9%   1.217   1.350   1721.3  1554.2    9.7%
       64  32/32  2.376763 2.636268  10.9%   1.217   1.350   1726.8  1553.5   10.0%
       64   64/2  2.375678 2.638707  11.1%   1.216   1.351   1725.0  1552.1   10.0%
       64  64/32  2.376681 2.637359  11.0%   1.217   1.350   1725.1  1555.9    9.8%
       64  64/64  2.376787 2.638396  11.0%   1.217   1.351   1722.8  1550.9   10.0%
     1024    8/2  2.263768 2.498881  10.4%   1.159   1.279   1808.5  1637.1    9.5%
     1024    8/4  2.264519 2.499075  10.4%   1.159   1.280   1807.6  1638.8    9.3%
     1024    8/8  2.263551 2.499231  10.4%   1.159   1.280   1812.0  1640.2    9.5%
     1024   32/2  2.263841 2.499120  10.4%   1.159   1.280   1806.8  1639.6    9.3%
     1024  32/16  2.263990 2.499562  10.4%   1.159   1.280   1806.1  1639.2    9.2%
     1024  32/32  2.263719 2.498905  10.4%   1.159   1.279   1807.7  1639.3    9.3%
     1024   64/2  2.263635 2.501889  10.5%   1.159   1.281   1809.4  1635.6    9.6%
     1024  64/32  2.264467 2.500359  10.4%   1.159   1.280   1806.5  1633.0    9.6%
     1024  64/64  2.240494 2.470246  10.3%   1.147   1.265   1810.0  1637.1    9.6%

This information has been also included in the commit that removes the
lookups.

Quick patch overview:
Patch 01 - adds the new opaque destination type with its basic helpers
Patch 02 - uses the new dsts for standard port fdb destinations
Patch 03 - adds port-VLAN pointer support to the destination type
Patch 04 - changes ingress helpers so we can get rid of the vid argument
           and pass a vlan pointer around
Patch 05 - passes VLAN pointers instead of vid to br_fdb_update
Patch 06 - consolidates vlan fdb cleanups, that will allow us to clean
           entries in one pass later on
Patch 07 - splits vlan unpublishing from hash and flood array from deletion
           that will be needed to optimize bulk deletes and flushes
Patch 08 - makes sure that readers cannot publish the vlan dst before
           cleaning up all fdbs that use it
Patch 09 - factors out the fdb update path to prepare it for port-VLAN dsts
Patch 10 - the first port-VLAN publishing, fdbs can now have port-VLAN dsts
Patch 11 - port-VLAN dst publishing for configured entries
Patch 12 - remove 2 vlan hash lookups in fdb fwding fast-path

For sashiko:
 [Severity: High]
 Could nbp_vlan_delete() in net/bridge/br_vlan.c avoid waiting for a network
 RCU grace period once per VLAN while RTNL is held?

 Nik: Yes, it could but the complexity this brings is not worth it.
      See above.

 [Severity: High]
 Could this synchronize_net() in
 net/bridge/br_vlan.c:nbp_vlan_delete() be batched by its callers?

 Nik: Yes, it could but again same thing - it is not worth the complexity
      and deleting VLANs is still fast enough.

Thanks,
 Nik


Nikolay Aleksandrov (12):
  net: bridge: introduce a bridge destination type
  net: bridge: use net_bridge_dst for fdb destinations
  net: bridge: add VLAN support to bridge destinations
  net: bridge: vlan: return VLAN entries from ingress helpers
  net: bridge: fdb: pass VLAN entries to learning updates
  net: bridge: fdb: consolidate port-VLAN cleanup
  net: bridge: vlan: split unpublishing from deletion
  net: bridge: vlan: quiesce readers before freeing port VLANs
  net: bridge: fdb: factor out existing entry updates
  net: bridge: fdb: cache port VLANs in learned entries
  net: bridge: fdb: cache VLAN destinations in configured entries
  net: bridge: fdb: avoid VLAN lookups in unicast forwarding

 include/trace/events/bridge.h            |   7 +-
 net/bridge/br.c                          |   2 +-
 net/bridge/br_arp_nd_proxy.c             |   4 +-
 net/bridge/br_device.c                   |   9 +-
 net/bridge/br_fdb.c                      | 270 +++++++++++++++--------
 net/bridge/br_forward.c                  |  24 +-
 net/bridge/br_if.c                       |  13 +-
 net/bridge/br_input.c                    |  26 ++-
 net/bridge/br_mrp.c                      |   6 +-
 net/bridge/br_netlink.c                  |   2 +-
 net/bridge/br_private.h                  | 157 ++++++++++++-
 net/bridge/br_stp_if.c                   |   2 +-
 net/bridge/br_switchdev.c                |   2 +-
 net/bridge/br_sysfs_if.c                 |   3 +-
 net/bridge/br_vlan.c                     | 107 +++++----
 net/bridge/netfilter/nft_reject_bridge.c |   8 +-
 16 files changed, 448 insertions(+), 194 deletions(-)

-- 
2.47.3

