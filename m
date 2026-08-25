Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDCA4028E2;
	Tue, 25 Aug 2026 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660026; cv=none; b=tIw0dxudbBP0V21I/Q0+iHYIBWGYxkRVd2IMz0VuENwV/TA7BVRwpo+nWXWGzNdX2eacrAINF4O5mq+/0LtAmTeWodrKBWP0qgPALEsaqKQkEXAlfd5WZoVQsTcxVSid690P+/WbS/r+PjAttuQipf9lBiY68GLz8O82/cJBHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660026; c=relaxed/simple;
	bh=BPqTzFySuXaMGgmAsoD7CPkggXOSjTbdKBOovyqrngE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNTDa/JEwYJtbtbBWyO4tj2jaGZY1JBmbKadgKTO6fjkhIQCJ7h64iy7p25LnJRGGBREyA0cptZelpAWTnmYT2jNsBz9Bj5tX40Haw1RoUDX3Bim3WyeNmm5jnbK+t+zepkJsk23ZXPPafQLn0px5uQO3TCOZgWxnXv3Uk6Sru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHUo30jq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHUo30jq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787660024; x=1819196024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BPqTzFySuXaMGgmAsoD7CPkggXOSjTbdKBOovyqrngE=;
  b=IHUo30jq/tPOe/Q+F3AfAUvNoXFgUEIlP+IN5h7xYQe0VCwLPiqESd7a
   yN45mZjgu1wKFo+hs0RbtDCOd2dZkMeexq6idO/FZ0+yeKuQo3rL4m5F6
   gSUJhinJ/qDSyrh2c4sDEOLKFALEvhA37XOrjRybpowSoXB2dYCLkrfGQ
   XBm6juES9czrj3pmyKHBSBvW1K5s5X5vo4kjggmzmQgBnYAzQK7V85NzL
   fr3+l0NlwCCn+ABiT1ZHgBfaH5j6a1Yq1C7uqgjxc2R/Br37zn9WYrKsB
   1CZc2P6B4oCqdxTJg9dh1hU0KzXcuqSQz6eKBae3jFa6Dmmtqn+jtA9ZX
   w==;
X-CSE-ConnectionGUID: UZ4f3WTOQGKN1okn5sybzA==
X-CSE-MsgGUID: SZrp7jbSS6iQwU8VGvJOWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88327262"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88327262"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:13:43 -0700
X-CSE-ConnectionGUID: EiOGuw5fQraGTHU7MR3K0A==
X-CSE-MsgGUID: /3VGv8cIQ4iCr/3zvvu75w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="272512677"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:13:41 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dropreason: add SKB_DROP_REASON_IP_TTL_EXCEEDED
Date: Tue, 25 Aug 2026 20:13:30 +0800
Message-ID: <20260825121330.338380-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9abd7020-90b3-45e3-84ef-ca31b760feaf@suse.de>
References: <9abd7020-90b3-45e3-84ef-ca31b760feaf@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 25, 2026 at 11:36 AM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
> The patch is sound but isn't this drop reason a bit redundant? I mean, a
> simple check on traffic should have shown to the user that TTL is been
> exceeded.

Checking traffic for TTL presumes TTL is already the suspect. The reason
string is what points the investigation: in the linked bug, IP_INHDR read
as a broken header and the capture time went to checksums -- RX offload,
tc csum actions, both libvirt firewall backends. Nobody filters on TTL
while the kernel is saying the header is bad.

dropwatch and perf report the reason without a capture; that only helps
if the string is precise. IPV6_NDISC_HOP_LIMIT and TCP_MINTTL are as
visible in a capture as this one, and both have their own reason.

The exthdrs.c hunks also cover three drops that report no reason at all.

> In any case, net-next is currently closed [1]. Please send this after it
> re-opens.

Will repost when it reopens.
