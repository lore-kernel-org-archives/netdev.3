Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE43F4104;
	Mon, 17 Aug 2026 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009673; cv=none; b=WFuq/1Jiq/mqL6y25Qe/KmduDbY5yh3bDmWrnQovj8iRNyL5NDAG6w5jp8UTCPN9QauvqCn6ryIxy8CTpgCHAp5W5jgObw/9wt+IFxKhjrdYR1An4BDi3ytv3XVy9Ab2lwqipuso5jCtZp1Km9AdycL//Hwm74WUHUk/J5Y5Uwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009673; c=relaxed/simple;
	bh=265zdDWWt971/RjY/D3clG8JNRMkgRw4H6OeYWAxegQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpH+W1VRiABv7FxM74nP7VM0SrTS2PMrt+vWqk2Vbqn8DBl6UOePLZOGJi1zdVGhPtvrERKAtw8bg68nCEHLxt6EU+FeJ1qdgWB1ygwqeJJ14Hy+Zx20XU0fl/npIVaih938xbKxld1GbPjBRg7+tB8YmifwsfQDZ8YjgLxTWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSvklxiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSvklxiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F261F000E9;
	Mon, 17 Aug 2026 23:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009672;
	bh=yR6FCYTjQ/t4hUmY/tKGQJZDRldYChl66zhBHqeGI2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LSvklxiGL8F/sJ6nznMjVdt0oTnD31M4O1L31uuVVDtC0r4IzfvJp3uoIfYTAOaAV
	 A1t2zVAl7kfMAm7L1t3KhCagCVAVO2VvnDXmJWQEuz3MYWQkJu/7tjSDYPPmSd3xge
	 hueEf75q4Qvi9jpcVM8MT9TbghIdeRfLcS/or+llPstU3n6m4LwTMRVxQ4tPsFbp6i
	 ZuIxJlSd/LOI/ZYQWRHiXNkve7WcuNeRyNiWFYr8g4SI4EvqIlPhrArbaWocGf0nl9
	 rBn/THJxvbysScDFyT1p3S8reGkLJbv4KLsisaIQVeRgqp9bBVJ2iE6jhTVtdu8CZH
	 9R6SABQ8H6/2w==
Date: Mon, 17 Aug 2026 16:34:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subrat Pandey <subratp@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>, <rkannoth@marvell.com>,
 <gakula@marvell.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH net v3 2/2] octeontx2-af: mcs: Fix SC resource cleanup
 loop
Message-ID: <20260817163431.44eaa49b@kernel.org>
In-Reply-To: <20260812115258.773319-3-subratp@marvell.com>
References: <20260812115258.773319-1-subratp@marvell.com>
	<20260812115258.773319-3-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 17:22:58 +0530 Subrat Pandey wrote:
> Fixes: cfc14181d497 ("octeontx2-af: cn10k: mcs: Manage MCS block hardware resources")

Commit: f21e8a66480c ("octeontx2-af: mcs: Fix SC resource cleanup loop")
	Fixes tag: Fixes: cfc14181d497 ("octeontx2-af: cn10k: mcs: Manage MCS block hardware resources")
	Has these problem(s):
		- Subject does not match target commit subject
		  Just use
			git log -1 --format='Fixes: %h ("%s")'

