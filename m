Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E72737E3
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859824; cv=none; b=QyTUeUJjq44da0UUJcv3okyKEFwARD0zJAej9s3PUp+rqBr1quHEfL8Sax9XHp7WSMy2UzEmF8OWVSCVvgzLEn462Z+TTm/10nROdtgVpG4BuxdDC2Q91y03dK/9ouyQKCH3SLehoEjg+GJz5mF5ps7okkN4DvRa276SdQZe0rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859824; c=relaxed/simple;
	bh=SKjpIwrI/Ty/83Rr6VQ6g93VCgkx+AoZGCCGGr61jao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXKrtEi7s8ogzJI8I/sIhGS3HbCRQnwNSkhVuCL92WHnMZavzA0J07BKM1zXgurmhetMpA5NXco0bT3WaYcJp/Pnh/QgRENY9n/7xLxNNOj3FqSVSDQORTB6o1K1YcjTvtt+aL7t88FpqzZFJY6s7S9NOe2c+A0uutcY7sclVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbS240E4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbS240E4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA26F1F000E9;
	Tue, 30 Jun 2026 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782859823;
	bh=4/7TjGJiqZagTrJvi7kpMXuVrILhpW7k/6RtBUpwu6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nbS240E4fkTexZ4KVCGleDZ6Ui7AHYGBZBuASvkTzuaeSIbLK1nSTFFQ/yDpAjjZg
	 hj8N4tVcDPKDNeqKTPUPVyLv62PEEdI5l1fPkXhcumUuUlEzii30PgKS4JDe4/3hZB
	 Go6hwcMA2VWjQsfmQiPY6Jr+WT/Ud6sL15ntoANXHAdqm/MOoQvyV6520L/4xFqcgq
	 so4pbCqCnWcwgrBeUG777l9Wl2vwe2CD0nEEUNVoUxYXwHRtJTYuxCJ1LOPT8KH4HL
	 bnW3wkCkQfukIBzjLmqWjr9We7pKuBqWCBE7pCKz4QE6uBjqs+pBQdWAIWX3Q6Db5f
	 Vmkx8igg4Or6Q==
Date: Tue, 30 Jun 2026 15:50:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <leszek.pepiak@intel.com>
Subject: Re: [TEST] intel: low timeout
Message-ID: <20260630155022.27c9a271@kernel.org>
In-Reply-To: <35ccefb4-a588-4556-87c0-ade880eaa8d6@intel.com>
References: <20260627095400.3c3d9f80@kernel.org>
	<35ccefb4-a588-4556-87c0-ade880eaa8d6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 14:56:02 +0200 Pielech, Adrian wrote:
> On 6/27/2026 6:54 PM, Jakub Kicinski wrote:
> > Hi!
> > 
> > Some of the tests need more than 5min, could you increase the timeout
> > in the runner to 10 or 15min? Looks like it's hard-killing tests right
> > now after 2min:
> > 
> > https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/xdp.py/stdout
> > 
> > which leaks config across tests:
> > 
> > https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/irq.py/stdout
> > 
> > BTW the JSON reports the timed out tests as pass.  
> 
> Hi Jakub,
> 
> I've increased timeout to 10 minutes per test run. It seems to help with 
> XDP tests score.

Great, thank you!

> I'll later take a look on default behavior of runner in case of timeouts.

default behavior == pass/fail status for the test?
