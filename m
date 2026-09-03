Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC64348477
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405980; cv=none; b=U2SjMZuVPtesWBpND7o0bwEwV+oohQXzBSSsDZYVCL0YkHCQcRP4sYskUGVF+/SvuacbX+kNePGHDtN+q/I3IrGxqNvhOjsmpFaD8YtjpsIkoErZFWDG2oJD9GGTF7H1Hrk6xwiv8LTS3Apnqj56tV1BlQng1BsdIV9dft8NgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405980; c=relaxed/simple;
	bh=gOjQkDLbzdXqow7zeUnlIMIEm2lKJpD0HPEg/RDlObc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFJX4V+JK7rHU1XgSmz2BFYi/efm+ByPCJUbVcII4gZE6eDMBlG5pLEtdBUbCvR+xFUD2TC4prCNKUcuX0r3FOgSgagOWWquLO0r+jXiDA306Aa0ogNz+kQA+5ssNSoTQfzpkYgWcTsDR5Jo7bzssBaLEKU3i0PhEe1WZ2G5Lgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjKCZcnP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjKCZcnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1C71F000E9;
	Thu,  3 Sep 2026 03:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788405979;
	bh=Ii3eU6sNlToA8SxX6KGpZTIjqJUeqdYKdDwqDtIJNRA=;
	h=From:To:Cc:Subject:Date;
	b=OjKCZcnPhtV5PQ73GeB+YdFQnPuVEh+QTXAzcDIw0UMEq3w7jF00sKGbAjzbowv0o
	 v7f/+qPj9EiZOQ8TFI9A27iM5M1eqTVE9XsDgg2QO2IQ94Eq3iHP8bpn6gc6fs+zS1
	 Z05hru4ARgtRSX9aZZ9l46iKD1WkxhvVbzygK1lg5sgJPLfUMmHDR9uVmhTTcIGNAG
	 Xbh641uXMdWRX6Ov/5dn7uCzn1Aqr+4XFNwhf8IGWNYPQiO2AQ7Bed+kuC48oXmiB8
	 cxMUMqkXITxF4qQn61HU+TvMkqpzZvSzYjmkqJl8wdh9NQIv1K9mMenqpK0sQ+INzK
	 nRrFUyT565FEg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/5] eth: fix bugs in ntuple filter reporting
Date: Wed,  2 Sep 2026 20:26:06 -0700
Message-ID: <20260903032611.3000029-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking thru some reports prompted by:
  Add new way to add BPF LSM hooks
  https://lore.kernel.org/20260831110934.241898-1-a.s.protopopov@gmail.com

I/Claude noticed 3 drivers with buggy n-tuple filter dump. PoC built
based on intentionally adding the same bug in fbnic under QEMU confirms:

    # install 8 rules (this part does need CAP_NET_ADMIN)
    for p in 100 101 102 103 104 105 106 107; do
            ethtool -N eth0 flow-type tcp4 dst-port $p action 0
    done

    # Python
    SIOCETHTOOL = 0x8946
    ETHTOOL_GRXCLSRLALL = 0x30
    RXNFC_SIZE = 192          # sizeof(struct ethtool_rxnfc)
    RULE_CNT_OFF = 184        # offsetof(struct ethtool_rxnfc, rule_cnt)

    buf = array.array('B', bytes(RXNFC_SIZE + 4096))
    struct.pack_into('=I', buf, 0, ETHTOOL_GRXCLSRLALL)
    struct.pack_into('=I', buf, RULE_CNT_OFF, 1)   # room for one location

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    ifr = struct.pack('16sP', b'eth0', buf.buffer_info()[0])
    fcntl.ioctl(sock, SIOCETHTOOL, ifr)

  ==================================================================
  BUG: KASAN: slab-out-of-bounds in fbnic_get_rxnfc+0x144d/0x1910
  Write of size 4 at addr ff11000007522be4 by task python3.12/647

Fix the 3 drivers, add a hopefully clearer mention in the doc.

Note that Sashiko will likely complain about mv88e6xxx letting
user read and delete rules from any port with ant netdev.
We can fix that in net-next, if mv88e6xxx experts can confirm that
the current behavior is not intentional (it's wrong but users may
now depend on it).

Jakub Kicinski (5):
  net: dsa: bcm_sf2: bound the CFP rule dump by the caller's buffer size
  eth: nfp: bound the ntuple rule dump by the caller's buffer size
  eth: nfp: drop the replaced rule from the list when reprogramming
    fails
  net: dsa: mv88e6xxx: bound the policy rule dump by the caller's buffer
    size
  ethtool: document that GRXCLSRLALL rule_cnt is a caller-provided limit

 include/linux/ethtool.h                       |  6 ++++++
 drivers/net/dsa/bcm_sf2_cfp.c                 |  2 ++
 drivers/net/dsa/mv88e6xxx/chip.c              | 16 ++++++++++++----
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  | 19 +++++++++++++++----
 4 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.55.0

