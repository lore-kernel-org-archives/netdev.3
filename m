Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AF7262E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778026955; cv=none; b=H+l/TXikufv+m/AUNVQSH9j3iMlQhbkOndAHhI9jR8IROFtgRt5xKCoSB0PzlikUSJ53clh/iG89w3SdSHyan+6HRb4bmzAxXNEUfTw0EuB5FP/uF6odN8OsM0ZIG71dSFAnbT7ErLZTsS4biKziRy2ug9Av3bxz/+3VgznXWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778026955; c=relaxed/simple;
	bh=MXm3Iij0jOxww+WX+Dsw+/js6y0F6zdoLEj+xoZ/Urs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwOZR9/MjhoxDyUUJy9lMUU2GntUgz1nFeUl6Y7ehXdlZY4WtmdXzP8JCUGd8DG8DvY/UFErid49tqlG3OAGV3e7Tqtly+xiwGxxLMk18Df6smNYWYKsEHyPElTQRC4jibiyCRgTHB9csMnvXPoVGPexVwepyH+Kv2TSY8Inrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2T2sYqz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2T2sYqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD70C2BCB4;
	Wed,  6 May 2026 00:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778026955;
	bh=MXm3Iij0jOxww+WX+Dsw+/js6y0F6zdoLEj+xoZ/Urs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r2T2sYqzW0Sqhm1O9EUu4yzBNGxL2JzLSI0JiMW8bmU670EQNzBuNPut8elJqYgWx
	 lZ6CDVi+63iXApTXxFF7plqafg5U/IrX8oip4O8pCW/eJ6YAOmTz+MgUCV+d+L+vRa
	 vqSiPKhx/p20AiNoaz0m1KapPmZ2wjy2F7pbZAj0KfhuFrBqvsOYRAqj2iGtQb+50M
	 tma315o/nFqBboQlMJyqXsCFyJbf6YDgLpFIz5pcQu+s/xBoGoznW/bIjVavgo8neD
	 vQZuUIre4mQg2cLJWZRZq8QXYCyryJ7OqctMSDI/Ue4HrZbrqnDxQtPvydgjLvqR9Q
	 btNGFZYgIvCUA==
Date: Tue, 5 May 2026 17:22:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync
 test using netdevsim
Message-ID: <20260505172234.3348a81b@kernel.org>
In-Reply-To: <b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
References: <20260503074747.1321-1-maciek@machnikowski.net>
	<20260503074747.1321-4-maciek@machnikowski.net>
	<20260504100753.7cc193cc@kernel.org>
	<b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 09:36:30 +0200 Maciek Machnikowski wrote:
> On 04/05/2026 19:07, Jakub Kicinski wrote:
> > On Sun,  3 May 2026 09:47:47 +0200 Maciek Machnikowski wrote:  
> >> Add PTP synchronization test using ptp4l and netdevsim.
> >>
> >> The test creates two netdevsim adapters, links them together
> >> and runs the ptp4l leader and ptp4l follower on two ends
> >> of the netdevsim link and waits for the follower to report the
> >> synchronized state (s2) in its output log.
> >>
> >> This implementation runs the test runs over IPv4 link.  
> > 
> > Doesn't seem to pass on netdevsim for us:
> > 
> > # 41.13 [+40.95] # ptp4l follower did not reach locked state (s2) within 40s
> > # 41.13 [+0.00] # Follower log (last 10 lines): ptp4l[2179.605]: ioctl SIOCETHTOOL failed: Operation not supported | ptp4l[2179.607]: interface 'eth0' does not support requested timestamping mode | failed to create a clock
> > # 41.15 [+0.02] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 173, in ptp_sync_test:
> > # 41.15 [+0.01] # Check|     _run_ptp4l_wait_sync(nsimsv.ifname, nsimcl.ifname, nssv.name, nscl.name)
> > # 41.16 [+0.01] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 99, in _run_ptp4l_wait_sync:
> > # 41.17 [+0.01] # Check|     ksft_true(False, "PTP sync timeout")
> > # 41.17 [+0.00] # Check failed False does not eval to True PTP sync timeout
> > # 41.32 [+0.16] not ok 1 ptp.ptp_sync_test
> > # 41.33 [+0.00] # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> > 
> > Anything we need to do?  
> 
> Can you share the config file you used? Seems the PTP clock was not
> found which may lead to PTP_1588_CLOCK_MOCK not being enabled?

You have to add it to the relevant config.

Please read: github.com/linux-netdev/nipa/wiki/Netdev-CI-system
