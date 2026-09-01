Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D923C5837;
	Tue,  1 Sep 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275393; cv=none; b=rrlgy5MJsB9ZiAwglcXwPrBvp7k77OgEGzgyetRoy+rAg+7tpY1Dlmt4GgHSkfXERdptR2mqKmNaQOgpAAFEui2nsEE11zP0NM/hVqrWH18aJF/6WRw/VgBT4f+y3FsFQMTJqqC2AhqDxw+hNxhUv3HhywVLUQbIHzVsy2xgGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275393; c=relaxed/simple;
	bh=tShdOyjpCIAos9VNrbfnGhhXKzr+4ovzyE3PHZJrzDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnSgpwg1KglCQ0swRBFWmdXckQsfTFtLVr0uk/HO3yobhVQRDPv7AIWwy4UXbaqCDdiOi1i8He1diA/FnU3JR3SJIdc6vS8/fWTh+pBlhZLS/utnYxraJl5JrJFO8ljqLwUk14YqejH9fUlJeckkQnLOUFH+m6hwaUSE1fzil5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBFnG++9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBFnG++9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBC51F000E9;
	Tue,  1 Sep 2026 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788275391;
	bh=S5y2+wCq0wEsTuG1GWG6BqNCaShtcw/i1pRTa1elg6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UBFnG++94zHjCfFoSrnIXkTRrci3p503x8x7rlcaIEiNh9Pa5e07zU80aTbPpa9Bp
	 SrKEZOcC/Sh99xf1JGgR1tyRjNd25uoS+hB3TdHfpPfd+AOBSpvsepXq22RJAm7QVO
	 NadvhoCWQ5Ent+NnwhuwZIhTLdcxY7QZmTFNCQz9xyb6mLddF1UzhfvD94tFMgVL6+
	 Lvd+ZHPhoqVkE0KkCryHFhCdeggwt1wUXruEw5kDSRD55HA4m+ZRS3ITMpr1UmHCnx
	 Iq/6aDPupP5XwpojpafsEn1scRlNbMWXZq3gnU6f5lDaxMXCV+Ot4jN9fldUxBwomp
	 Zy4YLOOlSfNQQ==
Date: Tue, 1 Sep 2026 08:09:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 net-next 0/8] net: dsa: netc: add PTP support for
 NETC switch
Message-ID: <20260901080950.63e28bab@kernel.org>
In-Reply-To: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 16:23:27 +0800 wei.fang@oss.nxp.com wrote:
> Subject: [PATCH v3 net-next 0/8] net: dsa: netc: add PTP support for NETC switch

Please be advised that the limit of 15 patches applies across 
the series. You posted 2 large series to net-next at once. 

See "Limit patches outstanding on mailing list" in the docs.
If this happens again we'll be forced to start discarding your patches.
