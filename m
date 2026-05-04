Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28666218E91
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914475; cv=none; b=l9YuXW7nVnjx6CqHSwHjzvQEgm0opikGWxboIZs6VJNplVvp5dtNomjpQQPF4HYeymJ/xImVvbvOjZmcp0VzxFoCjRt/IG/XFOKzHa6ncPnwAOIRDri/5kgs3WqjtEX5q2FG//WJFwy5OZjRRybf6wPbOeMeI3cq3Nnz6fOUHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914475; c=relaxed/simple;
	bh=TdwrA4E+jW04UfY0sYOGlOSfMgbmAgIRlabkyVMmMXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wro4LX2u1q3eARLl1T2mxu8Krc6TnCQqSQLNTwRyQiH8yrFehL2QMVymwt9QA2WNMpvvaUi5frSb3nVb9Y5iVp/hhxfoGaJsKFWUF4j8/jfA/n3ErjbbUvYqON0Izo03Quy0FSrR1n+vRS9jUtacONVh11wLmnH9pFHuYRA5wI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qleH4rRl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qleH4rRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A426C2BCB8;
	Mon,  4 May 2026 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777914474;
	bh=TdwrA4E+jW04UfY0sYOGlOSfMgbmAgIRlabkyVMmMXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qleH4rRl17nvOQO+WIvfUuV6da/aeU/Qr8lTc28hIEXc5nujzFYag4w5Ur5ICCQlW
	 7SXK1AbYEI5LyiK6eAT7D09zwmv2XoBcI73/5wG/8V/wiceAsCvUiEGFts6ATC5kQV
	 6vI2dECcabMn/yKwtXTZowVZt6qCF7ah/0D7gQmOED9tZ4e8ng18NCQQv48OJGai2B
	 TAl+CvcWzY483lc+V53avEdrcwWihD5T5y7C82Zf0eKUG6nIaRZ9HZ/fqzeuYhq1p8
	 sCArTE2d0CUlJYkpHFp9j5EXM/ZRUhcfsu6xy8p9QqU47QAFgznFga6sJuuM+fdfUL
	 zQHifaR6SoDBQ==
Date: Mon, 4 May 2026 10:07:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync
 test using netdevsim
Message-ID: <20260504100753.7cc193cc@kernel.org>
In-Reply-To: <20260503074747.1321-4-maciek@machnikowski.net>
References: <20260503074747.1321-1-maciek@machnikowski.net>
	<20260503074747.1321-4-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 May 2026 09:47:47 +0200 Maciek Machnikowski wrote:
> Add PTP synchronization test using ptp4l and netdevsim.
> 
> The test creates two netdevsim adapters, links them together
> and runs the ptp4l leader and ptp4l follower on two ends
> of the netdevsim link and waits for the follower to report the
> synchronized state (s2) in its output log.
> 
> This implementation runs the test runs over IPv4 link.

Doesn't seem to pass on netdevsim for us:

# 41.13 [+40.95] # ptp4l follower did not reach locked state (s2) within 40s
# 41.13 [+0.00] # Follower log (last 10 lines): ptp4l[2179.605]: ioctl SIOCETHTOOL failed: Operation not supported | ptp4l[2179.607]: interface 'eth0' does not support requested timestamping mode | failed to create a clock
# 41.15 [+0.02] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 173, in ptp_sync_test:
# 41.15 [+0.01] # Check|     _run_ptp4l_wait_sync(nsimsv.ifname, nsimcl.ifname, nssv.name, nscl.name)
# 41.16 [+0.01] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 99, in _run_ptp4l_wait_sync:
# 41.17 [+0.01] # Check|     ksft_true(False, "PTP sync timeout")
# 41.17 [+0.00] # Check failed False does not eval to True PTP sync timeout
# 41.32 [+0.16] not ok 1 ptp.ptp_sync_test
# 41.33 [+0.00] # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

Anything we need to do?
