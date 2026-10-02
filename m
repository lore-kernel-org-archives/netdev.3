Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EEA3F58C1
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971404; cv=none; b=FrRtFGRiioWnIxbbnw2iBOmlkH9EpqB1dAY3lynNrk57GpVHSqle1+Wf8/XMapK+fjeEMboeR9CF65A8qYHycJnjJuHrFMgZpGf7o2lyDvmH8v1asUGNfcsaMjmjq1LXHj2PcLTtcr//9ZijQ6IwzVFQsmNRT523j9LfMZlhIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971404; c=relaxed/simple;
	bh=Z6tK4dNj1gKeRySmC3kmEtZcZDJ9ZK8kHuCVEEmIqAM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NDj2Q8N+EYCr+T5V8ZVDX2pSAzpKkkETy7zWFnn+/NvbydECU8wUCRmpaRtDtRFY7aW504DhDaZB7kI0d8pFJmKhugfyI6gd0aBLMcvKx6yx167vDgPzNr7HDl7zJ0pvcVNpVjH0c2cAvif20QiahDueYOSRg9B0emR0mm+P+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZauZx9AC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZauZx9AC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9171F000FF;
	Fri,  2 Oct 2026 20:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971403;
	bh=LEhmULMl6hpe915xI8ExlF5rYbX1B5bbLPpaL2b4dKE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZauZx9ACtqEbUZGF5nizG1NUj2mtxakILOnohRaFjVuw0fgTL7OYK54CQb1XyNWzY
	 P/lvWrQjEDe7GpduDXX94sCsfd2lKH6psPD8iPILFZ+ooELa10EXmRcGCQy7b8WOBW
	 qQ/Mrz/UVtJ3zI3kZqiuqEyhb5dQSr56o8lTy0yI/ILeRgnpXcItDjmfkZIwGRzd5W
	 TwIKkI6ieOaHEM6zWvtxYVY4Zn76QNRQ02dksCv82LhB2YgTE/AOIqHtThZMAl1uCm
	 4Wdo/bRJAsQrEf0KADN7V2KkJzGSsn8WzRvKss88tvq7UPuSykqOSKoPgZ75Am8hUr
	 zMpDYS0UeHE4g==
Subject: Re: [PATCH net-next 05/10] ice: use inline helpers instead of
 memcmp() for IPv6 mask checks in ice_ethtool_fdir
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, marcin.szycik@intel.com,
 jacob.e.keller@intel.com, przemyslaw.korba@intel.com, xiongwm2026@163.com,
 ynorov@nvidia.com, horms@kernel.org
Date: Fri, 02 Oct 2026 20:03:21 +0000
Message-ID: <179097140192.434549.13219476450847741438@kernel.org>
In-Reply-To: <20260929224153.1455466-6-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-6-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not match the code.

--

ice: use inline helpers instead of memcmp() for IPv6 mask checks in ice_ethtool_fdir

This commit removes the static full_ipv6_addr_mask and zero_ipv6_addr_mask
structs and the memcmp() calls that used them. They are replaced by
ipv6_addr_any() and a new ice_ipv6_mask_full() helper. The mask checks in
ice_set_fdir_ip6_seg() and ice_set_fdir_ip6_usr_seg() are converted.

> ice: use inline helpers instead of memcmp() for IPv6 mask checks in ice_ethtool_fdir

[ ... ]

> Replace static full_ipv6_addr_mask / zero_ipv6_addr_mask structs
> and the associated memcmp() calls in ice_ethtool_fdir.c with the
> kernel-provided ipv6_addr_any() helper and a new ice_ipv6_mask_full()
> inline, reducing boilerplate and making intent clearer.

[Severity: Low]
Should the subject and body say ice_ethtool_ntuple instead of
ice_ethtool_fdir? There is no ice_ethtool_fdir.c in
drivers/net/ethernet/intel/ice/, either before or after this patch. The file
this patch changes is ice_ethtool_ntuple.c.

The body also calls ice_ipv6_mask_full() an inline, but the patch declares
it without the inline keyword:

    +static bool ice_ipv6_mask_full(const __be32 *a)

Could the description drop the word "inline", or could the helper be marked
static inline?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929224153.1455466-1-anthony.l.nguyen%40intel.com
