Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530772;
	b=07wsZpznswvFhIbVOfqFgOAnkU7d09MCScxRlgfawcAxmlRtwPLiE11JathQks/vClHB
	 Dv/3pCmF2zR1sH428ZjrnG8HFkiz49IdcNOm2gM0jwd3L/zzNA4QP7EkqV/KjuCQvRQ+a
	 ZwyTATx3L14iMddCXCDud/viFKpqeHpZl1wjMfJf6Kf1qUVPWNKNHh5gh8Yp6iH/b6Ob5
	 92Uqb3WsBE6/SfGmGljMnnYx+j7qB79nYSNjjR3MMnCa1+lJLAywYmk6RqVPWk7dy9CTv
	 1DcrkWEVVa3nNJ4NZaBCjgfAHASwP1ogQOBn5RoOBglNRKT/VkdEWb+o7GCiekTo+Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530772;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RfLMmGdVsOoCEEymC2BFb4soYOw6JKnK8GHYnVNsQEs=;
	b=elzeh1BmKmLi811nxrWzhIO6IwLOxqpCU1gOTuX+9B+/vSvHLfxw7DBo4gcWYEToj1L2
	 a7i/1c/ctu4gzsTCU1KHgjF3sSDZ7E78t9g3kCFFG19sKvQY+6EBGfXwevdpsL2FRYm0W
	 YgsSYrWrGn59+rAFCOHHdLQU9Qn/LgoCtHmT8CGDwOfXNssaZvkst05cvQtxIxOuUJDxG
	 vXngHWpIMvfSG2/AwlhteM+FV5HHVdiRbp9dIa898LeslVeVUWCjSX33FyzOVDBPha61c
	 slcj81wwKJuZwJ0wbS2ADU3lxjxEqL/T+3xuTowWLOxuv89UgR+ap3VbfiaFAu5aItg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aooTEH6w;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF84606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BF84606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aooTEH6w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794530772; x=1826066772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yU42ALbxn12nNI7FlKu41LKo8sMNWyXERmyvThVYxy4=;
  b=aooTEH6wBHC8/P8ykFAZQpvlGP93ZCy7JSdqfp9FKDhETt8d46oi2yox
   RtueBvwa/p2HsYUKoSmjHPpEtdANJXilQMfMvEf3EnuU5vveor2qRqXO9
   S1q0T7qd/31gfVkpY/ZbwyoCYkdQQAO/gQiOaKga6lFONfHZBH2pWZLh4
   z3lAP9BcXyDOIrMwwT+MLFLdDVCt0kYGSr1OSvPVWVyIIQj0YCSQwm88Y
   cMCIX78myafQwePoUbIAnQvgvEDKITvjV3TOugu5XGbVOMvnhfb52UykP
   kxTz8nyS9YKf8ZZ0kwUUAZXm0gyYhe7bXkY9P96sWHVWDEQsyHNHW6mZA
   g==;
X-CSE-ConnectionGUID: fZOsQDWSSrWBoHhPfnwp7A==
X-CSE-MsgGUID: eBlDbmH6Qr6ZrIAjqyY40Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3361655"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3361655"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:46:11 -0800
X-CSE-ConnectionGUID: IaJIFBvDQf2TnN+FDP5PUQ==
X-CSE-MsgGUID: 8NQtFVqASD2F+RH2H3Z2XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8724608"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2026 16:46:12 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	mheib@redhat.com,
	fballuch@redhat.com,
	aleksandr.loktionov@intel.com,
	luoxuanqiang@kylinos.cn
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2026-11-12 (i40e, iavf)
Date: Thu, 12 Nov 2026 16:45:54 -0800
Message-ID: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
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

For i40e:
Mohammad Heib adds missing set of VSI down bit prior to calling
i40e_down() as is expected by the call.

Filip Balluch fixes incorrectly provided Tx rings in error path of
i40e_set_ringparam().

Alex further fixes the error path clearing the netdev from temporary
Tx ring's before it's freed.

For iavf:
Xuanqiang Luo fixes a couple of memory leaks and prevents NULL
pointer dereferences by implementing missing PTP callbacks.

The following are changes since commit bbcd02741c4cfbf9e1c59b1906f21ef772bd15eb:
  net: mana: report RX checksum offload for IPv6
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Aleksandr Loktionov (1):
  i40e: avoid resetting BQL state when freeing temporary Tx rings in
    set_ringparam

Filip Balluch (1):
  i40e: fix freeing of TX rings on RX allocation failure

Mohammad Heib (1):
  i40e: fix napi_disable hang in i40e_down() during firmware update

Xuanqiang Luo (3):
  iavf: fix QoS capabilities memory leak
  iavf: fix ASQ command buffer leak on init failure
  iavf: add missing PTP adjustment callbacks

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  9 +++++++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  2 ++
 drivers/net/ethernet/intel/iavf/iavf_adminq.c  |  1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c    |  1 +
 drivers/net/ethernet/intel/iavf/iavf_ptp.c     | 12 ++++++++++++
 5 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.47.1

