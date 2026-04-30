Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDEA426697
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563885; cv=none; b=iv7nohwoI33gxHR6i6uiil0ffuT2IPZDWqaBnft2d8Q6hVN+S6phB1tDKPgSf8ZsiBa9L7Eu8fMnKM5kC7FYR5Go6JUmTPC8gfskOcmTzMf/raeJwdMt1aMa+fA9JJSsXhHhODSf1mZ5u04OE1bpxn78ZQGVmy7mfxt/p3WFgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563885; c=relaxed/simple;
	bh=6uzJjTQlJ2AoFxoeIorIzS4OpkA4n1urVMwudhZDabs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mo/8TgjnmPwuqj1iy99v/PFrQjBuRhkUeO33KmCXUjM63ILLvgAzxu3V2RWtQIgTlFzohHk4W/NOmbH6URn2Azs025sY8dVmDAwGXA9LMW8Qr2r8NNYPiAqjXVHGzQ1N7Lcz2x4mNVn/fPdchOD6Y39KTHr7Ykt1aP7wHDUpDsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHOZsasK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHOZsasK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422D0C2BCB3;
	Thu, 30 Apr 2026 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777563884;
	bh=6uzJjTQlJ2AoFxoeIorIzS4OpkA4n1urVMwudhZDabs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHOZsasKa8i/VntqVUCgIe92mCa+dHO59JooLKCIFvJrsR3T4orCaqnQe1/XGRMbz
	 wTLPrgmKSm8Jkg0xcowCFYZmDYGm+13xm1AWWInnMWiv2nBC+rPyiVWJx6TKfBhgMo
	 OnnCGMTaXOh6DgIYj7JdHC4XtQD1r4DmhX/svEhovCuHi+FzJjEhnGqv1xEcM/fuTb
	 DOrL7cFGfZ3DJ3Me2OyFXTg22G0q/VMYQvkwGZWv0jDRVtxzVDJFfUSahXt71yog+c
	 ghKTi9yR+mnPULW+kRSXNsdVIFJCmpo4e1GythPH4gZ1bUQxexG8bOoJ1e27vVMTx7
	 NDLkjiEZEiTuQ==
From: Simon Horman <horms@kernel.org>
To: michal.swiatkowski@linux.intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	jramaseu@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com
Subject: Re: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of IP/IPV6
Date: Thu, 30 Apr 2026 16:29:49 +0100
Message-ID: <20260430152948.1683359-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
References: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: use NETIF_F_HW_CSUM instead of IP/IPV6

This commit replaces the IP and IPV6 checksum offload flags with HW_CSUM
in the ice driver to allow hardware checksumming for IPv6 packets with
extension headers. It also removes the mutual exclusivity check between
TSO and GCS.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 5f92377d4dfc..33f252a6a22f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3491,9 +3491,8 @@ void ice_set_netdev_features(struct net_device *netdev)
>  			NETIF_F_RXHASH;
>  
>  	csumo_features = NETIF_F_RXCSUM	  |
> -			 NETIF_F_IP_CSUM  |
>  			 NETIF_F_SCTP_CRC |
> -			 NETIF_F_IPV6_CSUM;
> +			 NETIF_F_HW_CSUM;

By advertising NETIF_F_HW_CSUM, the network stack assumes the driver can handle
checksums for any protocol and passes non-IP packets (e.g., from AF_PACKET
injected frames) to the driver with CHECKSUM_PARTIAL.

Since ice_tx_csum() strictly parses the L3 header and expects IPv4 or IPv6,
returning -1 for other protocols, will this regression cause non-IP packets to
be silently dropped instead of falling back to software checksums in the kernel?

Additionally, skb_csum_hwoffload_help() relies on NETIF_F_IPV6_CSUM to
safely fall back to software checksums when IPv6 extension headers are
present.

Does using NETIF_F_HW_CSUM bypass this safeguard, potentially causing
legacy hardware (like E810) or E830 without GCS descriptors to compute
incorrect pseudo-headers and silently corrupt IPv6 packets with extension
headers?

Finally, for protocols other than TCP, UDP, or SCTP, the driver falls back to
calling skb_checksum_help(skb) in the default case of ice_tx_csum().

However, the driver appears to ignore the return value of skb_checksum_help().

If skb_checksum_help() fails (e.g., due to -ENOMEM during pskb_expand_head()),
could this result in the packet being transmitted with an uncomputed checksum?
