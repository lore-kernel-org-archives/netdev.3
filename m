Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234335;
	b=z7kc4ItAb8IRsoFYmVV9F8VweU8+yADqldzE/J6AlVUxEys4tOVxeGs7ylQZH+aKQgfR
	 5HQycWaVINmbKMfr9upubCvMmrgvHErKTy8No2lyc6hkOcLJH5jwXrxFWHQTH7obl7xuL
	 euC0fbXBpBHtbm7Q75GhDF/nr2uyZCAXIWNPbSOB5lxSmJ6LovL2nF4nt8LiZj8/m4Vli
	 sejQuwZsW+Db3bVQ/UvLB+Rxm9RbFQyoLNmHb3PhKmSdUL86W/lZ9PCV7YoECQwtJPZee
	 AxD67VRocBZGbUS0ia9k4SnKQJj6n1SlA7++/zScW+BnwxShBUrLqDgd7rxk+5IDjnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234335;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LGUbBch1/OYdHnTxkjCH2wbrptcygGBhOyaO0PaTRYo=;
	b=qgzIJLKiGMb6OFkEXzz264nBquUU6brqVvDw6HP2N2vNq/oHBNdTxRIBS1G++eEouxIH
	 PPqJeA47T9BJcBAZG9LhtG5KohwqLYk05cafXbNk4M7CtIQsnBQxFy59rftC7iKJFP804
	 C+Kbns9/LNWhD9PAvXTs9rTBMdisLMl/YvcIZqNb+8aCThuWOkTb1/jjCVGc6DgvXnsld
	 wMlARdxv+VbF/svugxeKBRqqfsQHc+WZdgmzpIb3BRC1VtC4o4hBqkTpbQcRPs8Jaf55k
	 0DwDCFWYVRy3kyOP6w1l+/1fPp2IUzoju/uxBklJMAEVAfoZNG9+NG5EtcGFuzmx3Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="A/Eks8PX";
	arc=none smtp.remote-ip=91.218.175.80
Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE4606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2EE4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A/Eks8PX
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tmMY9UeHWouXSyJW7uvlBsehOpe1njzsUfCIaw1Ok5Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793234330; v=1; x=1793839130;
 b=A/Eks8PXc7FJckhaxUn8SyM1BRDX9urOaWjFyjZ0PVkxId2TUF3fDEofy/tNUC8tWxU9tOGp
 CkecdiMyfk2J6u56gUFscfMci24BqlNgix3fCfGy5d8pVESriT01AeE2+RYWpcZ9DmVBiULSXqC
 qZx+Of8cixvjNA3MS2HOmrR4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 435ee883788e7d0a;
	Thu, 29 Oct 2026 00:38:50 +0000
X-Mizu-Trace-ID: 435ee883788e7d0a
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 08:38:42 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH 0/3] net: ioam6: makes IOAM insertion transparent to IPv6
 ECMP
Message-ID: <auKVkslL-fBrMl7t@fedora>
References: <20261028-ipv6_ioam_ecmp-v1-0-9b6715b6f4c0@kylinos.cn>
 <auGryXdPv2mx0qlp@fedora>
 <20261028165812.1b40d1d4@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028165812.1b40d1d4@kernel.org>

Hi Jakub,
On Wed, Oct 28, 2026 at 04:58:12PM -0700, Jakub Kicinski wrote:
> On Wed, 28 Oct 2026 16:01:13 +0800 Hangbin Liu wrote:
> > On Wed, Oct 28, 2026 at 01:45:28PM +0800, Hangbin Liu wrote:
> > > This series makes IOAM insertion transparent to IPv6 ECMP, as required
> > > by RFC 9486 (C2): a packet carrying IOAM options must be forwarded
> > > along the same path as the identical packet without them.  
> > 
> > Sorry, forgot to add target repo "net". I will add it in next version.
> 
> CI bot says:
> 
> The new selftest added alongside this series (tools/testing/selftests/net/ioam6_ecmp.sh)
> is failing in our CI on the "Transit input ECMP with/without IOAM" scenario:
> 
>   TEST: Transit input ECMP with/without IOAM (diverged on seed 1: without IOAM via
>         link A, with IOAM via link B)   [FAIL]
>   TEST: Transit input ECMP with/without IOAM (seed 2..12)                [ OK ]
>   TEST: Encapsulating node re-lookup ECMP with/without IOAM (seed 1..12) [ OK ]
> 
> 11 of the 12 "transit input" seeds pass, and the whole "encapsulating node re-lookup"
> scenario passes on all seeds, so this looks like an edge case in the Hop-by-Hop
> nexthdr-recovery logic used for the policy-0 multipath hash, rather than a test
> infra/flake issue. Could you take a look at whether the recovered "virtual" nexthdr
> (or the padding/option-length walk used to compute it) is correct for all IOAM option
> layouts/trace sizes, since one specific packet still ends up hashed to a different ECMP
> sibling than the equivalent packet without IOAM?

Thanks for the report. I run it locally multi times and didn't got this issue.
I will try reproduce it first and check the reason.

Thanks
Hangbin
