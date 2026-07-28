Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7E339396;
	Tue, 28 Jul 2026 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785213148; cv=none; b=bNTEUch2Pb9jBUyPVGy+KSvQHDsFWjmsPNHn9URH+X1if1dimdEKaN4AQX/FHBYzQa6J4IUOWSoNQOyP1M5Pxx+eOB+kImQwpTmwkKixSbyGl4SgAtXjk3tuG2RDOvDiExXbgYq2ZuW8ACBD2VYOo7lrh1m4dqc723ujdDLAuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785213148; c=relaxed/simple;
	bh=aavYTI5HCXUaYhwHqo48+nPER3bw7KpBtBkvgfowM0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsfA2MHu3t4E4R6dpIsYrfgaxBRKELdvj6o4amsBtCkLuQ346fdZ5eSN/l39oClTY80iu69ylzYmfQhawA7Budn3A58uDqm3YJXbnhUc/P5CuMrLlUqu2Sd6boPGNFDj+WvthTB+2cy6q5yXeIqcIkbPmeM99mcQVq1ZVgDZ5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XW1Stwbr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XW1Stwbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785213145; x=1816749145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aavYTI5HCXUaYhwHqo48+nPER3bw7KpBtBkvgfowM0g=;
  b=XW1StwbrvBHXvmGXEkSc4yZf5zLlELp0dHFjm8CNne653anLyLd/aUlA
   kk6r62OVK/8GmDC+5gOm5q0bbIndsaSzf2s6fVatDXx62RO/C3Fi+9qP6
   5XkPCt2FhDavDKa+bcsBNvJj58ErqMyoceJtL3gQCDu/LLJTu1CDR1Pcy
   0N0iJGS/VFuESh8H4i2fbgZ6PbzEmibXIZT5N1oT86aVh5tqzZBSmtoxv
   VsGgBLP63l20Xm3CoKXEeMY+xYybclBNdv0UBe5CFsspAA3DLVpa+fO3i
   tngtgJT/9KogWUG8Yf/urPf5qJzgIKHQSqG/xh/KlgPIMjSIIkNNpv6nc
   g==;
X-CSE-ConnectionGUID: 9TT2TLe3Q8+lgFs4L9gC3w==
X-CSE-MsgGUID: opmXsrZsSlSlf2yQAEEh4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="97165343"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="97165343"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 21:32:23 -0700
X-CSE-ConnectionGUID: tgwENM1HQ7eEChsHAUyC2g==
X-CSE-MsgGUID: 5LBIezZaQ+SAjJa5hC0eFQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jul 2026 21:32:20 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 3B4BA99; Tue, 28 Jul 2026 06:32:19 +0200 (CEST)
Date: Tue, 28 Jul 2026 06:32:19 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Fan Ye <fy15309206903@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangjianrong <zhangjianrong5@huawei.com>
Subject: Re: [PATCH net v2] Revert "net: thunderbolt: Enable end-to-end flow
 control also in transmit"
Message-ID: <20260728043219.GN2365036@black.igk.intel.com>
References: <20260727123002.25225-1-fy15309206903@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727123002.25225-1-fy15309206903@gmail.com>

On Mon, Jul 27, 2026 at 12:29:48PM +0000, Fan Ye wrote:
> This reverts commit a8065af3346ebd7c76ebc113451fb3ba94cf7769.
> 
> Per the USB4 spec, a Transmit Descriptor Ring with E2E flow control
> disabled does not require any credits to be available before the Host
> Interface Adapter Layer transmits a tunneled packet from it. Once E2E is
> enabled on that ring the controller must first obtain end-to-end
> credits.
> 
> The ASMedia ASM4242 USB4 host router (PCI 1b21:2425) never delivers
> those credits. The controller does accept the configuration: reading the
> ring OPTIONS register back right after tb_ring_start() returns exactly
> what was written, including RING_FLAG_E2E_FLOW_CONTROL (bit 28) and the
> E2E HopID field. No credit ever arrives though, so the Tx ring's
> hardware consumer index never advances and the link carries no traffic
> at all.
> 
> Measured on two hosts connected point to point, onboard ASM4242 on MSI
> X870E and X870, v6.17, stock drivers/net/thunderbolt/main.c with only
> this revert applied on top:
> 
>   before: 100% packet loss to the peer; thunderbolt0 is up and the
>           XDomain handshake completes ("new host found"), but iperf3
>           fails with "No route to host" once the neighbour entry
>           expires
>   after:  0% packet loss, 0.28 ms RTT; iperf3 4.21 Gb/s one way and
>           5.17 Gb/s the other (5 runs each, stddev <= 0.02), 1
>           retransmit in 10 s
> 
> An instrumented build additionally showed a frozen-Tx-consumer watchdog
> firing ~30k times in a 10 s window before this change.
> 
> Rx-side E2E is not touched by this revert, so peers that do return
> credits keep receive-side flow control.
> 
> ASMedia does not look like an isolated case. The out-of-tree
> thunderbolt-ibverbs project disables native E2E on AMD NHI by default,
> noting that "Strix Halo has reproduced TX completion wedges with
> multiple native E2E rings active" -- the same failure mode, on a
> different vendor. Since the driver has no way to tell in advance which
> host router returns the credits, going back to the previous behaviour
> looks safer than adding a quirk per affected part; Tx-side E2E can be
> reintroduced as an opt-in for controllers that are known to implement
> the credit return.
> 
> Note that the reverted commit was not fixing a reported problem, it was
> derived from the spec wording alone, so this revert is not expected to
> regress a known workload. Cc'ing the original author in case there was
> one.
> 
> Fixes: a8065af3346e ("net: thunderbolt: Enable end-to-end flow control also in transmit")
> Cc: zhangjianrong <zhangjianrong5@huawei.com>
> Signed-off-by: Fan Ye <fy15309206903@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
