Received: from mta0.migadu.com (out-84.mta0.migadu.com [91.218.175.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31262F5A2D
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294752; cv=none; b=MY/nils7/Q8G5rfIAFXJmmiiw8YzQH4+4CDdI/BAgkGJpcmCvUK4XnMMWc+EKsJr1UhB/1A4CR8b7GgC4BbHffyqTDNKKl+3/twpJXf66S4HQt2brgaiZjPkWp13oO8kq0mm/g6l0wdLTIXcja9wKt8O6ioE9jHPz2NTcvmkVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294752; c=relaxed/simple;
	bh=oh7TKbdjsLGFrOGUzkUpcfYdM4crWdMPv2+Mpe2CB0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvO3DyZeXVcrRbL2h5Zf7i6P3XKST5cb3lteZvYf3SbN1nVAE4AEEFdNxMh8lXkRwBaowebPg35MolxINiPesg7fcd2T1Rg6A1d9VXyoheHGFOWHNY4aPx6dxaT2gS2VbKMzXux0Rxghcu+184MQesp7M+W8S4EGiOOvGrCEpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TBAUlwWl; arc=none smtp.client-ip=91.218.175.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TBAUlwWl"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oh7TKbdjsLGFrOGUzkUpcfYdM4crWdMPv2+Mpe2CB0I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787294748; v=1; x=1787899548;
 b=TBAUlwWlj+Usm+jBHCDXjojIGK8dYCA7OtLhKfeQYEuK9vvMwTpGQz4cvwU+pT1tNf8KnKT3
 aUKCucxu6xbqONXpbWrt8dRGkcM5+pprQlI0wvEiOg5OwznAKJs5HQINIshm29cMC7w2upteDZC
 czfz8nolYDAOXDV0ffQtgMD4=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.240)
	by smtp.migadu.com with ESMTPS id c12d4a8015f16231;
	Fri, 21 Aug 2026 06:45:48 +0000
X-Mizu-Trace-ID: c12d4a8015f16231
X-Migadu-Flow: FLOW_OUT
Date: Fri, 21 Aug 2026 14:45:40 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Qingshuang Fu <fffsqian@163.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	SeongJae Park <sjpark@amazon.de>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: Re: [PATCH net v2 0/2] selftests/net: fixes for fin_ack_lat
Message-ID: <aof0FLTs59t5tNvE@fedora>
References: <20260821030922.1123754-1-fffsqian@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821030922.1123754-1-fffsqian@163.com>

On Fri, Aug 21, 2026 at 11:09:20AM +0800, Qingshuang Fu wrote:
> From: Qingshuang Fu <fuqingshuang@kylinos.cn>
> 
> This series fixes two bugs in the fin_ack_lat self-test.
> 
> Patch 1 fixes the swapped kill() arguments in sig_handler(), so the
> server actually forwards SIGTERM to the client.  It also makes the
> wrapper script's cleanup tolerant of ESRCH, since the client may now
> exit before the kill command reaches its PID.
> 
> Patch 2 adds a missing fork() error check: on failure the code falls
> into server()'s infinite accept loop, producing empty output that the
> wrapper script treats as a passing test.
> 
> Qingshuang Fu (2):
>   selftests/net: fix kill() argument order and wrapper cleanup in fin_ack_lat
>   selftests/net: check fork() return value in fin_ack_lat
> 
>  tools/testing/selftests/net/fin_ack_lat.c  | 5 +++-
>  tools/testing/selftests/net/fin_ack_lat.sh | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> ---
> v1: https://lore.kernel.org/all/20260817091017.281104-1-fffsqian@163.com/
> 
> v2:
> - Split into two patches
> - Add shell cleanup tolerance for ESRCH per Sashiko-AI review
> - Add missing fork() error check per Sashiko-AI review
> -- 
> 2.25.1
> 

LGTM, for the series

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
