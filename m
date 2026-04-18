Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68B142E83
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538493; cv=none; b=PZ3PpbdXO68rIhTVJ5zeYaIR+EWsC+UKdeytCMSyzUG0xuSeNpl/MMJPON0wBcZ9jNyT/IjEGS3xNi5+a22rqoEtCO18U8k6gcVuAxxLhgy/7eIqQp5fnftbwR5rOnxQng1z5pn1FQTtVOxI8CFP3CNN14dsdidRm5f1Cr22ohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538493; c=relaxed/simple;
	bh=d84VBshpGjPS4zFx072tG7gIypnac+O3gwkWHAURGB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYSw0XR1ogAmqoaf1A16Vm3KZo9fnvEXjT03iQJeCvNRNdKF++MU3h5k/7PBDMAedUEgyrQ1WGDdD1ismeTsXmOmNMQlQEQ/vpmtAewL4aisPF2a0wF6EBLHW/aviWBqQfxFHWFP0kBTI75N61ITkDZU8IDjeWTGxtV/eSmSfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpsHpZEI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpsHpZEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51CFC19424;
	Sat, 18 Apr 2026 18:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776538493;
	bh=d84VBshpGjPS4zFx072tG7gIypnac+O3gwkWHAURGB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MpsHpZEIIBXe2ah4SUTtKaa7eYuZL2qAzuwJzhXMS7wWvRefgH1M7glbTbK/JT6EO
	 6U82eU490s//q9zLuNkssP44EIMUnZbG0clwrymQB/8OzJzuHLBQymN5V2v1NEe1ma
	 szolOV8LlXlHN/aXkiqZUqlGX8Y/OIiPCS5Ppr1bFggNFvzjmX0iy/yaLErARuGZpX
	 k/jqqi3N5rVfLygyvnSEuBmLchrzN0iIF0TDhZn2CBwG46zInsS2NlRx7Jy25oE3WV
	 zTvOP98vZ4JSwYH5bvrj0etunv0PR7UaObwnTmEU1VuL8056FqmmhqxaM9Ry5swfMi
	 OtTGVbllAC6sg==
Date: Sat, 18 Apr 2026 11:54:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, shuah@kernel.org,
 horms@kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 0/6] pull request: fixes for ovpn 2026-04-17
Message-ID: <20260418115452.3d2a0a47@kernel.org>
In-Reply-To: <20260417090305.2775723-1-antonio@openvpn.net>
References: <20260417090305.2775723-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 11:02:59 +0200 Antonio Quartulli wrote:
> This is a respin of the PR I originally sent against net-next + an extra
> fix (patch 6).
> 
> Please note that this patch:
> https://lore.kernel.org/all/20260225010833.11301-1-liuhangbin@gmail.com/
> broke the selftests entirely due to the switch from sh to bash.
> 
> There are new commits in the kselftest tree which take care of this:
> https://lore.kernel.org/all/20260416-selftest-fix-readlink-e-v1-0-94e4cabbdec4@kernel.org/
> but they are not in net yet, therefore you won't be able to test/run
> our kselftests for now.

It does work for us, FWIW, maybe because we run tests with make
run_tests. There were some entirely unnecessary changes to ktap 
output which broke our systems but we patched around them :/

> TCP tests are still failing every now and then.
> It seems that sometimes a single ping over a TCP tunnel is lost,
> thus making the selftest fail.

They seem to fail for us around 50% of the time on debug kernel
builds. What's your repro rate?

> We believe this is a bug in ovpn which we are currently hunting down.
> So it's nothing wrong about the tests (they are actually doing their
> job!).

FWIW one of today's runs hit this:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-extra-dbg/results/608740/3-test-symmetric-id-tcp-sh/stderr
decoded:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-extra-dbg/results/608740/vm-crash-thr0-0

In any case - test_mark.sh looks good now, so I'll take it out of 
the ignored list. Thanks! 2 more to go? :)
