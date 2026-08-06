Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC990346AED
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976468; cv=none; b=pmk8tSolGjG3j5OuIV/B2Du8IES820lY1mg6RNBqVgzHioXUJ6OPUmJFG//Cyic8swLKKf8+nLjgfGlKDYXJVAZY/Hfzz57f0cLmJ1DxbJGfEfzGMXVSdJjTCp8Y/Lz6gP+K4hfDjcsgAknAQsd5whvcHxAS0GtdZyV6j0eG6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976468; c=relaxed/simple;
	bh=fRTpmlJsznl08kYs1Sf4WGqrE35v8yE6AG9AMs9OTKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L09CxD2KOzlQUKhZ280NppKAhkehNn3S5s7UYrT59YGS9GEIpBzlf0PDa+kHmaGvC9CoYeEicPwBYE0Ibj9XLm/YX3SjQxH2TUT9VfJYdvX7jdwhbORXTt2mPar+GpsFWFXI+6rYdQcE2U8gBgY285h6CG4t8kzK8okxd1XYNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1cwUklf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1cwUklf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A8F1F000E9;
	Thu,  6 Aug 2026 00:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976467;
	bh=V5Cc9BV+d4AfWJaLrB+0sCFA/7672mEskxE2Fn/Qv6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c1cwUklfCIqE64Snyz8t02czQndT2uV4H66VfVix8t7b5/Cox02AxsINxmgIA93yt
	 YUnq7we48JCBqlrUc8Tz9YhnyE7HauMR3kx7M7Juxh+DLW8YgXeXVIrDSYmBM3spKR
	 9yTjtIkNit+oHAkt+ueByBppWdFy35mIbFMGkOGyzZTdBbWsbROQVSJwELpYNShTPD
	 LtT/7EH+SnBnhgRzdXdjjhryPGVZFJtmrFLIkU+O/K8J0YkwuZMlpjUFPiwcjNUd2R
	 BKDf66G4usGvisBBJU4cexq5jjKs9BvasmLIg7eJ9MEBAXipQSMtnFlZg4HQoCUAKl
	 PpJIHM+OmxF0g==
Date: Wed, 5 Aug 2026 17:34:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai, edragain@163.com
Subject: Re: [PATCH net 1/1] ipv4: reject RTAX_ADVMSS values below
 TCP_MIN_MSS
Message-ID: <20260805173426.32dc3780@kernel.org>
In-Reply-To: <a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain@163.com>
References: <cover.1784972917.git.edragain@163.com>
	<a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 13:08:17 +0800 Ren Wei wrote:
> ip_metrics_convert() only caps RTAX_ADVMSS at the upper bound and
> still accepts undersized non-zero values from userspace.
> 
> A route installed with "advmss 12" can later reach the passive TCP
> open path. When SYN timestamps are enabled, tcp_openreq_init_rwin()
> subtracts TCPOLEN_TSTAMP_ALIGNED from the route advmss before calling
> tcp_select_initial_window(). This can reduce the effective MSS to
> zero and trigger a divide-by-zero in the rounddown(space, mss) path.
> 
> Reject non-zero RTAX_ADVMSS values smaller than TCP_MIN_MSS while
> keeping the existing "0 means use default advmss" behavior intact.
> 
> This matches the existing TCP_MIN_MSS based validation used for
> TCP_MAXSEG and fixes the bug at the route metric input point rather
> than adding a redundant guard deeper in the TCP stack.

Could you repost this? maybe we'll get more review attention that way.
