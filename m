Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623805;
	b=NwmQ5C5eY0z3Pm7/wcTTkm3c++4cl9cZ4Bt/h5h4eGrh4qCUYLU2byK8NbzRYnrdjePf
	 EdQ9gRXnZSWZA1qEuM5v3qRQskk84gERHgRU9XaWfQBehIcnsSaYqLZ1rV8dJbIdZZ/Ht
	 cifiw8GHstPpyzUVToNna9WK/FdF2PPOZYGu1ErX9dXcLZsGOmHFGi7v56pxwT7olvPDP
	 6Dtj5PXLHWasEmjOissw1mczV8HYnPIMXaYhQGaxfEwidE+/ZY1ZF+CSL0fbw+fRpPQpV
	 UpExxvAJR86aco4crexgTpGHbROvCzxjLBvQd6eUlpIjN1FZ2wwJhzaOtqv+Ok2dDoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623805;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=q6N3NX0VxgUlJlbdacV6LpwCLG8sLTNzGBdI1UEq/5I=;
	b=tWA77T05OS/dZbnQ2OipWXdgCVBa/wdmv3NUqpy/4CLllbuNw3MCwGIXmzE+KCEjtKur
	 epaOWrDFJhyFoQWFjLGcYL2RXNcsL0l/d5S5/dafOFizNiY5TWE0ukZtd/as8XcfC6ril
	 IwJD7g3Nwt5dIzekmyh4bJOa1zcEKXA7utAU0qVA30roxPMO101wtNvKykfNeuMvpS+DS
	 Rs9JvlRrHb0QJ7zh2diCI+sE5XdV5sdwkxYQgilwvLNqlVnAE/h1fA4N5HRQBipdu8sh6
	 PaAyfJM32upSsJNBKvl8/2u+JkbX7Ix0PxV+nssC2oi6Md6GirP/sjmApyEot5FWIQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uxz9u2Pu;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93299606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93299606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uxz9u2Pu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793623803; x=1825159803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KRbAOJ7WcSQIGFzBwguNe/DdPdEva6Uw97qftw++cc0=;
  b=Uxz9u2PujmN9u2keFG9aY4jRxAk6qX7znN00jiK2/bIJgyts1zDt3lUX
   +VTG6lmU0Ijdao+BvrReYNO0D7pNFrNGo2xuCsvt8ipMXiRfwcOhuUssm
   OiQEQIlgb01z51/97kzc6x+2biNUDF+rbn+gwXeyF+ijhjKnTnFE34Nb5
   DZVvEEU5PiHRQ7y18ivHzPCULnZnNTjSOJ3tXs3yea78dEmJUYBv1fC0p
   A8mdyAjb49bwE/Y3kGpPWYhOprgvBnUmmoRRjIt2CGqdTkGXotOqc6SgI
   AGC86FmNdco/GZJggmqr5XdC5fMWW1Hz+rj8a1FXRTVXBHuuDh/H/t97P
   g==;
X-CSE-ConnectionGUID: 9l0oHBMiT4qSkE0AaXQIXQ==
X-CSE-MsgGUID: pPOfjIFaQtihSVSazr9rIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191820"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191820"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:50:02 -0800
X-CSE-ConnectionGUID: ZSq5NK5JQOuUh0pw6oeFbA==
X-CSE-MsgGUID: h0tDrUuyQOGZShrYCmMetg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7928399"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 04:50:00 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	zuomao338@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 0/9] xsk: ZC mbuf fixes
Date: Mon,  2 Nov 2026 13:49:41 +0100
Message-Id: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
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

Welcome,

Nagato Shiratana reported that duplicate fill ring addresses in aligned
mode let a driver pass the same buffer to xsk_buff_add_frag() twice.
This corrupts pool->xskb_list and can lead to a NULL pointer
dereference in xp_free(). Patch 1 makes xsk_buff_add_frag() reject
such buffers.

Inspecting the rest of the zero-copy multi-buffer code found more
issues:

- i40e retries a freed frame, or stalls the queue on a duplicate, when
  xsk_buff_add_frag() fails (patch 2)
- ice leaks the buffer when a frag is empty or cannot be added (patch 3)
- ice and libeth free the frags of a frame still being received when
  a multi-buffer XDP_TX frame completes (patches 4-5)
- handing out a duplicate of a frame's head clears its frags flag, so
  its frags stay on pool->xskb_list and end up in the next frame
  (patch 6)
- ice and idpf leak a partially received frame on ring cleanup, and
  its frags end up in the next frame (patches 8-9)

Patch 7 is Chenguang Zhao's fix for i40e building broken skbs from
multi-buffer frames. It was posted earlier in an IWL pull request [0]
and is included here unchanged.

Patches 1 and 6 were tested with KUnit tests based on the reporter's
reproducer, plus I verified to-be-upstreamed xsk.py test suite passes
on ice driver (back-to-back setup based on netns) with this set applied.

Thanks,
MF

[0] https://lore.kernel.org/netdev/20260918212458.550425-9-anthony.l.nguyen@intel.com/


Chenguang Zhao (1):
  i40e: xsk: fix multi-buffer XDP_PASS skb construction

Maciej Fijalkowski (8):
  xsk: fix list corruption in xsk_buff_add_frag()
  i40e: xsk: fix xsk_buff_add_frag() error handling in Rx
  ice: xsk: fix leaking Rx buffers in multi-buffer path
  ice: xsk: do not free in-flight frags on XDP_TX completion
  libeth: xsk: do not free in-flight frags on XDP_TX completion
  xsk: do not clear frags flag when acquiring a buffer
  ice: xsk: free stashed Rx frame when cleaning the ring
  idpf: free stashed XSk Rx frame when releasing the queue

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 35 ++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_xsk.c   | 19 ++++++++++--
 drivers/net/ethernet/intel/idpf/xsk.c      |  5 ++++
 include/net/libeth/xsk.h                   | 10 +++++--
 include/net/xdp_sock_drv.h                 | 11 +++++--
 net/xdp/xsk.c                              |  1 +
 net/xdp/xsk_buff_pool.c                    |  2 +-
 7 files changed, 60 insertions(+), 23 deletions(-)

-- 
2.43.0

