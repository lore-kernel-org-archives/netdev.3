Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17B1C8603;
	Thu, 19 Mar 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937345; cv=none; b=mOD2fotuTCfjO4R8YOU56YiixWSymNZYf5GHtdlzPVzq5UykHFHQe3bu0uOid0poQbNYQuzXtCZj4mPEJOv+DfXQjkAioS+kMWRLjLNFNWBbnVjsmOMM3DzX83R+j9FfV+aqVkzqKY/I5JJIg2hN5Uhu3mY+YE9gbMTWWPp+1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937345; c=relaxed/simple;
	bh=OuCnqeQcXwL0H6JyilgAKoAIxzy074pyR/M2JUifC4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Unn5InIVHuOzT66vWV/vOZZxh5IPBUmYqsUGIE+v9boWtumYTwipoH5zLlRNIvOsVdLey2ldLfSshtQF/CvTjWUSGKuHsEKOKhAK0x0XMbWXfr56edVyfBSRnTIOc65HL4Rs++N+fAF6WZiqEf7KwhKDdTieszHGMt/6Yy9g+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx+B6Msn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx+B6Msn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F60C19424;
	Thu, 19 Mar 2026 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773937345;
	bh=OuCnqeQcXwL0H6JyilgAKoAIxzy074pyR/M2JUifC4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lx+B6MsnOtMRpVu6Lr3BgjTcWvQR5aDExQ3KB2LMfLOtbXrsiywbQtr7m0ewbQmaS
	 Bo1YUuVCxG+XbST3XvMYyuUsh/46F7m/48NkcCz74rvLjK8jan9AMkkpr2V+G0/Cc6
	 D6L6fthL/skxIJiBRW8J+q4kC6ximwpr/3/eVzpExLS5wajM5TsAPG7KnuUoSZ6Xjb
	 lBP1dsmBmRLN/zReX8I7+kgNEYCkeAIqPK9qLoXYn0GTEgqrw4Zwfi1ukGuS39fIBx
	 aKxYHTdnJb0MbIZ6zyVPJTq7UutvFXDod85o+kxSqDMGUhnZKNMd9Ag5HFIrGsPfB6
	 q2auh09vLjKVw==
Date: Thu, 19 Mar 2026 09:22:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mkubecek@suse.cz, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net] net: enetc: fix the output issue of 'ethtool
 --show-ring'
Message-ID: <20260319092223.799798a5@kernel.org>
In-Reply-To: <20260319072716.511992-1-wei.fang@nxp.com>
References: <20260319072716.511992-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 15:27:16 +0800 Wei Fang wrote:
> Currently, enetc_get_ringparam() only provides rx_pending and tx_pending,
> but 'ethtool --show-ring' no longer displays these fields. Because the
> ringparam retrieval path has moved to the new netlink interface, where
> rings_fill_reply() emits rx_pending/tx_pending only if the corresponding
> rx_max_pending/tx_max_pending values are non-zero. So rx_max_pending and
> tx_max_pending to are added to enetc_get_ringparam() to fix the issue.

Why set it to 64k vs priv->*x_bd_count ?
There's not set_ringparam so user can't actually change the value,
wouldn't setting max to 64k give user the impression they can increase
the size?
