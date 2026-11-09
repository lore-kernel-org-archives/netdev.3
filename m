Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233761;
	b=n2HSBL90/nhmKayTFr4DbEr0ler7qwlOzLShmzD1FEtxy/DB7rOKhhMfKDOV3A1bS1WT
	 aTI4I9pZHvYj3VXDJx8Z3JXw/LMw/8fNwvugHASQ7ZkrWtrwQvYrOEelcZd8xip6ALpPC
	 CpZlQvMoKMGKEYqnx6Q0uHrLpbHJOyjeEi3P+b/GApsw233WhGbjeLw3RTvQ77sBP4Cg/
	 p6zotPJTdfvfkZngLn5WI8xOgEZJ8iY0SeFf0v0mDOFQc43yCMsqorxN++pOdGBJVuFbM
	 aSk5Rc/VAmaw0zyXXMWb1DltiY2lVwy85JHtS/YXB38Fas1vFAcuPzvWrvv//u7AEDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233761;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Dt/hwQRjAxZLlmkHmH+5I1kqhm7WLLG5cSo4gTFVmfI=;
	b=IaHiIEiC9cZA+rLMRtUGPNT8cdxRFV1IvSo2vH7aSVvftRG+E6Eiu1JTbknTRi1pPnP0
	 rZObX7Ik9O0C40FRl44IVqAsRdDUaWVX8joXBhGAqcrmzZb7BX5gdJiVtJufihEqRRRo/
	 oKPPTfcdFsgfnWMFtpudHvT8vp1tp57TemaC+SdAAWjbE1WOv3AHW12O1tnt/AHlpJEqS
	 dbByxjOCnGx7yxjuBAHfBVKDKriq5ACwErIPM2IBW34dGuoDKvPseh2aaZGlFDvuHtwDj
	 ww3Dn9dFbE9EKiaKrlxWPMWxlcjE1JBsgV5y4hQtZRdJZsA3mauYnJK3XrbghqjdQKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="PkPVi/eN";
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7373D606A322
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 14:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7373D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PkPVi/eN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794233760; x=1825769760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lgyn94dIu8FZ6VTjt69eykwd0mrqkEU+klfIpWf+9Hs=;
  b=PkPVi/eNQvB1GWXHmMTXwYO+yiJUx1Ag8Yv6Ag19Zb/aF8EFyimvbb84
   61IC8go76rEUmSOkMtNuXtJ/u7YvHLHQhCS8K16qHphZDiuzJjheZKVJ/
   or6iL8aC6uDmoluBKDvG1e/tSAKs7St7oPLO7lVZ3UOzxVxtkb5axDARp
   kJ65UKL5PrwtDNjDYSzMlq85w8436E13Vclnd3T+i6irTTAKNqflrjtYW
   8HzpNOct8UVV6BzNIgDSjDxHGkxJ/lE0y+K4WOKSKxwu2RN4rNrA1XHs9
   9lBdOG4wXJCIW5yebS34zZJ5oTa+oAEKLwVirhlYz46iTqf7X2HeBQqgF
   Q==;
X-CSE-ConnectionGUID: i7W3h/SDSVqjlh6el5qzzg==
X-CSE-MsgGUID: hrjOpR75TPmFP6wbhdqmqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2839609"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2839609"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:15:59 -0800
X-CSE-ConnectionGUID: qkqi+THoRFGwylbRvsBmVA==
X-CSE-MsgGUID: o9r0JlwDQrqd6vEYXGnFFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8201036"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 09 Nov 2026 06:15:57 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 94D8C99; Mon, 09 Nov 2026 15:15:56 +0100 (CET)
Date: Mon, 9 Nov 2026 15:15:56 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: brianrobertjames@gmail.com
Cc: netdev@vger.kernel.org, westeri@kernel.org, YehezkelShB@gmail.com,
	riverscn@gmail.com
Subject: Re: [PATCH net] thunderbolt: Use needed_headroom for the transport
 header
Message-ID: <20261109141556.GR176724@black.igk.intel.com>
References: <000201dd6fba$2c726e80$85574b80$@gmail.com>
 <001101dd7044$3ba5edc0$b2f1c940$@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <001101dd7044$3ba5edc0$b2f1c940$@gmail.com>

Hi,

On Mon, Nov 09, 2026 at 07:17:04AM -0500, brianrobertjames@gmail.com wrote:
> alloc_etherdev() initializes hard_header_len to ETH_HLEN. tbnet_probe()
> then adds the 12-byte Thunderbolt transport header, although that header
> is not part of the Ethernet MAC header handed to eth_type_trans()/GRO.
> 
> This makes gro_list_prepare() include 12 bytes of the IP header in its
> nonstandard link-layer comparison. Changing IP lengths, IDs or checksums
> can prevent recognition of packets belonging to the same TCP flow,
> allowing later packets to bypass earlier data held by GRO. On the tested
> direct USB4 link this causes TCP reordering and excess retransmissions.
> 
> Reserve the transport header in needed_headroom instead. Keep the
> Ethernet hard_header_len at 14, with 12 bytes of needed_headroom. This
> preserves the transport space requirement without changing wire format,
> offload features, or RX/TX credit allocation.
> 
> Shun Li published the identical correction on October 9, 2026, in
> riverscn/thunderbolt-net-dkms (commit b18a196bb5ca). Credit for that prior
> published correction belongs to Shun Li. This submission adds our
> independent AMD/Proxmox hardware validation and receive-order evidence.
> 
> Link: https://github.com/riverscn/thunderbolt-net-dkms/commit/b18a196bb5ca
> Link: https://bugzilla.proxmox.com/show_bug.cgi?id=8306
> Signed-off-by: Brian James <brianrobertjames@gmail.com>
> ---
> Follow-up to my November 8 report in this thread. Fabian Grunbichler at
> Proxmox requested that the actual patch be submitted upstream. The
> one-line diff is included inline below for review.
> 
> Test environment:
> - Two AMD x86-64 hosts, direct native USB4/thunderbolt0 traffic.
> - Receiver: Proxmox 7.0.14-28-pve; historical tests also used 7.0.2-6-pve.
> - MTU 9000, TSO/GSO/GRO enabled, gso_max_size 65536.
> - Unpaced single-stream IPv4 TCP iperf3, 20 seconds per arm.
> - Stock thunderbolt controller unchanged; only the receiver's network
>   driver's header/headroom line changed. Cable, ports, MTU, offloads and
>   CPU/IRQ placement were held constant within each comparison.
> 
> Receiver-only original -> corrected -> original comparison:
>   Original:           30.599221 Gb/s, 620 TCP retransmissions
>   GRO corrected:      29.779541 Gb/s,   0 TCP retransmissions
>   Original restored:  29.994158 Gb/s, 540 TCP retransmissions
> 
> Endpoint interface error/drop increments and receiver FQ drops were zero
> in all three arms. The unchanged sender in this isolation test ran
> 7.0.2-6-pve with TX E2E enabled; receiver RX flags stayed FRAME|E2E (6).
> This comparison isolates the receiver fix with that sender configuration.
> It does not establish that GRO alone resolves every retransmission mode
> when both peers run 7.0.14-28-pve.
> 
> Historical 7.0.2 receiver-only comparisons on each host, 20 seconds/arm:
>   Receiver A retransmissions: 536 -> 0 -> 132
>   Receiver B retransmissions: 564 -> 0 -> 769
> 
> Historical paired receive hooks covered identical TCP payload bytes
> (18,871,120,863) and packet counts (303,590) before GRO and at TCP ingress,
> on the same CPU. Forward sequence gaps were 0 before GRO and 1,219 at TCP
> ingress, with no packet-length parsing mismatches. A corrected capture
> had equal byte coverage at both hooks and zero forward gaps. Overlapping
> and retransmitted sequence ranges were handled separately. This supports
> an ordering defect in the receive software path for this failure mode.
> Runtime tracing confirmed header/headroom 26/0 before and 14/12 after.
> 
> The measurements above came from actual Proxmox hosts. The current
> mainline source was inspected but has not been runtime-tested on this
> hardware. The diff context was checked against mainline commit
> 7475ea8b58616b33c04afb976cf0fbaad9dd63fb. The separate TX-credit diagnostic
> is excluded from this patch. No Ceph qualification is claimed.
> 
> AI assistance disclosure: source review, diagnostic automation, analysis
> and preparation of this email were AI-assisted using OpenAI Codex
> (GPT-6 model family; a more specific serving-model identifier was not
> provided). The measurements and traces are not simulated results.
> 
>  drivers/net/thunderbolt/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -1410,7 +1410,7 @@ static int tbnet_probe(struct tb_service *svc)
>  	dev->hw_features = NETIF_F_SG | NETIF_F_ALL_TSO | NETIF_F_GRO |
>  			   NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
>  	dev->features = dev->hw_features | NETIF_F_HIGHDMA;
> -	dev->hard_header_len += sizeof(struct thunderbolt_ip_frame_header);
> +	dev->needed_headroom = sizeof(struct thunderbolt_ip_frame_header);

I don't think dev->needed_headroom is needed either. The TX side copies the
data directly to the frame pages.
