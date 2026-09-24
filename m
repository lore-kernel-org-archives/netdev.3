Received: from mta0.migadu.com (out-99.mta0.migadu.com [91.218.175.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328E3AFCE6
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219783; cv=none; b=LYry7gDdxv9GWv2SVYoY7rWK9+I3wHuopJVTlrI0V6M6rCuptz2O5Wa9aAC1m4PLxgB1Z2XsZ+dRNX2zPDKQUoCyKE5m4FPXRBtHEHTKc6xHIS3F89GrVCUtAPId8zNvLQuF9hD6trxt9DGr4986azvdkiOqpC/qeGb7awSHch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219783; c=relaxed/simple;
	bh=Sz/uMVvtvi3NFxxQ6n0vt/kFme+lA9TCV7g89jS3C4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCKZbUsvWE3sF79a9/xGuAWqWspmMlSyxb3/tmIAw1NBPrjs82m83MPnYuZ9xBwF6543b9pf/YBBuu8fGn6p5zM6bPHJjSvVpOKgfKOHiz8F+GrStM7rAeRWeVQSZ7SLrLY5nyozA/WnDmX9Q2k+KOEyH7WDNAii4qVoVcJd1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qGvhKsu0; arc=none smtp.client-ip=91.218.175.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qGvhKsu0"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Sz/uMVvtvi3NFxxQ6n0vt/kFme+lA9TCV7g89jS3C4M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790219778; v=1; x=1790824578;
 b=qGvhKsu0wrkzZGyT6ZwvFh+OJshy56ZEOjoC0fVWMYd0VG3y+agyP6hemWKiafPamAScej9T
 lkATVpIX34zjOpi8Q0IhJqee6fZHRbhme/o7CNFYtI3O8HFMjoXQVJd7UpdMv5ot2bxhONE3hnw
 LcIEg1yXT2v2Je4NBtYE1EQI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id e26be85f0c4105d4;
	Thu, 24 Sep 2026 03:16:18 +0000
X-Mizu-Trace-ID: e26be85f0c4105d4
X-Migadu-Flow: FLOW_OUT
Date: Thu, 24 Sep 2026 11:16:12 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	dsahern@kernel.org, idosch@nvidia.com, andrea.mayer@uniroma2.it,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuhangbin@kylinos.cn
Subject: Re: [PATCH net-next v4] selftests: net: move log_test to lib file
 and remove duplicate code
Message-ID: <arSV_FCIC21S138L@fedora>
References: <20260922-self_log_test-v4-1-4c656801f8dc@kylinos.cn>
 <179021041767.2160803.17788389754543951970@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179021041767.2160803.17788389754543951970@kernel.org>

On Thu, Sep 24, 2026 at 12:40:17AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Loop-variable corruption in fcnal-test.sh via bash dynamic
>   scoping: the new shared helper `log_test_expected()` in…

Thanks, I will add "local a" in the new helper.

pw-bot: cr
