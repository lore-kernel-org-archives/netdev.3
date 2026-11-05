Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837172;
	b=l8aS6VkDiAKNl0K15i2gbA+7EwpDSdmsy+XTC55zoFszNqEAcejq8eeP1r05kCIIQ9F1
	 FbonVbbKNvmM7KNOz64W93/Hs5NOC0Ds2h1ppEywAPt6a3Mdf6piZSxy5y//Qls0U2y1C
	 3JyjiR/NnfqrSPKKOT4E99j7v8cmRFC3i1DLzwOghjr1fTF5mA1OXxJHei2PlAqagMIUG
	 bmQPOzLWnRLRfTPAcd4ISeLVQtlzkc8rv1ftEIOmaqJxSz7fAXM5OYDBOAiLDX8Iv9E/o
	 7Ta2wc8HHT6Oa2dGDDXj7UEknWjBu/tfHv6kkWbL4O7X/stK/RCn0XNlMMXiDwVdhPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837172;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=rOcIn02aUhenw1f2b3Qbp+NkAFopxxVHtJ3Yf6T/4SA=;
	b=eIN6wtS0PWskEkbmJAsmw2mPXkM7ZWciuMY6TvibBl6u+CYfbo6fddogL8bxd2a+dHpl
	 tOJEEQzZhrnKfIM7jNlKL+g/UO4jIXEpjYKb7pDFgryGdXzMhTnPWj/oK9WVFT/PrxvB2
	 Bf6ql62c8CwsXatsI1ltlh7HksUCn1+jy8T4JOErMPi+f4St5uqqumNAQXFRyEg7U0AKi
	 paBBg2hDwlReuDKYrSuOvc3/z4Nt34G2BaWX57ihEXJyLJnJL4b8C+f5G60B7/A/RZMP6
	 sYIUmyNpVE1LxXzXL0A0p7xx6RU1AaomEB/Nc5f5idLQ+zIUmh6gGEW0oMB7TDbclkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iMISf4Ft;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32136606A32E
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 00:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32136606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iMISf4Ft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793837170; x=1825373170;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lECegV1ACTKkuiZR56LBYMXL83kUihP66t8EmA5cxs0=;
  b=iMISf4Ft0PI/eQhNF2rexXiHk6O+ueVY2nmEJJRXvLS83niPs8W3tKmK
   k0ESzSbOo5mhrzCpIlfZN+WM7MNzohVFidEazigCl92oW9coV2FZIEZWx
   MkmVsHI8rD6yEEUVwy0Qgpc4jopVpEcZo3IWv21NPfzsH+Ib2ZtcbHpGm
   TjbjPxqjdXEyCTBu/Q/2a4YyzRP08dIeITnbwQUEVZ+bW4C+bhT6Ld6GT
   yt7o8126OmDpcItxNzGI8mepFhWoE4GBB4+KpeUwEFyR+tiXuPfxD3BY9
   1oPDGcTo6nZdqri/zybPubsKkvvsATazBKR3pL59lL42mYKbfaCoMRVgy
   Q==;
X-CSE-ConnectionGUID: c6Q0LUeUS0OsHXWRrnSYYw==
X-CSE-MsgGUID: vKnrd8qjQwWDscOqS9li3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2628667"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2628667"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 16:06:09 -0800
X-CSE-ConnectionGUID: aHaseNclSeaUBeT3aAGEFw==
X-CSE-MsgGUID: kjQBSO02RHiTpR30FX8qBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6864307"
Received: from vcostago-desk.jf.intel.com (HELO vcostago-desk) ([10.98.24.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 16:06:10 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Riley <security@copperfault.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: etf: propagate dequeue drops to parents
In-Reply-To: <20261104135707.725-1-me@riley.kitchen>
References: <20261104135707.725-1-me@riley.kitchen>
Date: Wed, 04 Nov 2026 16:06:09 -0800
Message-ID: <87v76cuopa.fsf@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

> From: Riley Kitchen <security@copperfault.com>
>
> etf_dequeue_timesortedlist() drops expired packets via
> timesortedlist_drop(), but that path only decrements ETF's own qlen and
> backlog. It never calls qdisc_tree_reduce_backlog(), so a classful
> parent keeps accounting packets that no longer exist.
>
> With ETF installed below QFQ, this leaves QFQ with a nonzero qlen after
> its last active aggregate has drained. qfq_dequeue() then skips its
> empty-queue early return, qfq_choose_next_agg() returns NULL, and
> qfq_peek_skb() dereferences the NULL aggregate, panicking the kernel. An
> unprivileged (uid 1000) process can trigger this deterministically after
> creating user and network namespaces; no race and no modified kernel are
> required.
>
> Count the packets and bytes dropped in timesortedlist_drop() and call
> qdisc_tree_reduce_backlog() once the local queue state is consistent, so
> classful ancestors see the removal.
>
> The issue was found and the fix developed with AI assistance. A
> standalone C reproducer, run as uid 1000 with no kernel changes,
> panicked v7.3 and mainline d135ab453a74 under KASAN; with this fix the
> reproducer exits cleanly and parent and child backlogs both reach zero.
> The reproducer is available privately on request.
>
> Fixes: 25db26a91364 ("net/sched: Introduce the ETF Qdisc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Riley Kitchen <security@copperfault.com>
> ---

It seems that ETF under QFQ won't work well, as ETF can drop packets and
is not work conserving. But the patch looks good:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius
