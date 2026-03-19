Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686B1FF5E3
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940620; cv=none; b=B055qzYrTSQ+ymNDx0kG7Fr+RxRsN0gmZZc40LMOLAKpEIpsEyww7qhbl5TcgQHc+d9tyBTJLF51YuMdGjtlVhcjyr+ViFGJgrEoG3h2MCjHH+e2g3Znj3nvjLYR8jju2odkA1y8bpmfEOKmRUmZur89jD97kHmUEnaDH+o2akw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940620; c=relaxed/simple;
	bh=3pd+qN5NdevWGNRkic639T/+Af9LD7nOyEObSzOU2js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftttlKbkin6olBJZpB7AoH9aXMfa3/098PwjyBMjSKVi7Y1Tl+gIOrwOs/bW0NvzT0IP6KhQ+e0zt/+h0H+GHdaGJeCQIgHNuVMBSvoMqIjJz0NkmDiGBa+cjrq2nPhe0X5xTjhdjKcYHylAP6nkxro6dD8pIkXn+RhZT/+Is4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=bGBc4LJv; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="bGBc4LJv"
Received: from ms-a2 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62JHGtln076728
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Mar 2026 02:16:55 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=ZnSb5Lc1a/qEmrNjUZt+iozQpg8AU9Sb33OjOabZnec=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773940615; v=1;
        b=bGBc4LJvuOOJw9EdeXCGzMUTIIeDyDSJE5i7QwHUiXkKGOnbAEINK49qfEPEVHt3
         JCrnNDr8GPCVfCmaKmHWH9WMw/rck3zgsNyVIcJV9xJ7nla3Oi+BZXfr0wF1pIk8
         r6F24g3EzAI1eyVbuPp8HFFp9R/yyE2J6GVhtDcIWMZy6zCJCH3B5OxfehUanB0L
         WUAwAxvE9KP45WROZwB8Xpr/HBx7jALTH7+ptX+l7FKrjTF1Bc+beDuV+CMuQIf6
         5DvJL9vWWipyRrG5cLo7HFA0Oz7/qnVTXqlyLkjkEPhlkOZohmj+SXITKq4b2xY5
         M5QVeD0JKaXoMpmShjH63w==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH iwl-next v1 0/3] i40e: support XDP metadata ops (RX
Date: Thu, 19 Mar 2026 17:16:41 +0000
Message-ID: <20260319171650.5815-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for XDP metadata ops. Since the i40e RX
timestamps are not available from the RX descriptor in the XDP path,
this series doesn't implement bpf_xdp_metadata_rx_timestamp().

Patch 1/3 prepares i40e_xdp_buff for subsequent patches.
Patch 2/3 and 3/3 introduce bpf_xdp_metadata_rx_hash() and
bpf_xdp_metadata_rx_vlan_tag() respectively.

Tested on Intel Corporation Ethernet Controller X710 for 10GbE SFP+ with
./tools/testing/selftests/bpf/xdp_hw_metadata.
Since i40e doesn't support HWTSTAMP_FILTER_ALL as an rx_filter, I
locally changed the selftest to use HWTSTAMP_FILTER_NONE instead.

Kohei Enju (3):
  i40e: prepare for XDP metadata ops support
  i40e: add support for bpf_xdp_metadata_rx_hash()
  i40e: add support for bpf_xdp_metadata_rx_vlan_tag()

 drivers/net/ethernet/intel/i40e/i40e_main.c | 51 ++++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  5 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  7 ++-
 drivers/net/ethernet/intel/i40e/i40e_type.h |  5 ++
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 12 +++++
 5 files changed, 77 insertions(+), 3 deletions(-)

-- 
2.51.0

