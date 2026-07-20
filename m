Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88826D4CA
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542847; cv=none; b=L5zE0VvScLWsmLOoEYtj99Q4DRFGpl6NYfg68BQYMJPRfiqIdpDwrhUmNHImm3+RqA5nU2aXt3jVCeMY/pRk4HD8B4wT3eKfST7f0CeXm1A1Jb3pqJd2nla+hP95R910sFUaRlnteCn2q16aFGI2eMjDPIhPSdwtoedH1aM4Y+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542847; c=relaxed/simple;
	bh=HsJu/oeZkgrbMRQJplNCCxvCknHoMa9stmN3nySY0Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVU98X95WVlQQV7NCoZPtD9CvpWFUqCjFHxl95+SX9ylodpFZX8qEXn87DfUocGAHHKQpaxHe833BkXVN5O9QgD4TtONY36WXK7bhOxDsMS5PU1LiNYiuD7JCg5+PtvV8CndxG47R27y6HTPqdw4XAO7VhqMeg0YKN5/iH3RwQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjh+DFYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjh+DFYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705FC1F000E9;
	Mon, 20 Jul 2026 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542846;
	bh=flOputq0F1qDtEH4RgZe2aKJKIjg+JYbpkOo9KKbYTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mjh+DFYbdkU0Qkrb3ZH/TZZARuS5ejj2Bk02pjrHoRe9WBRXqtIc6gOopPc8WU3Ct
	 KMKzrh3JxJhaO4rb3r4UGi99i8o6tRsE8PlcP5Kcrg6UJ1qqAAoV8eTXUG+d2F3YJo
	 6A1OZHIzfIgXK2CS4YT8OJ5Bs171ifWkMMF8pMmQD2eeouwBee6N37aev83WOUaUxm
	 AU9Nfy+ELaMpNwscTgtP2RRuvYIWYXhmfHLITDd6QtMf+lgCtQP+oFNXl8s73N5MrU
	 PbkhogmG59HNp0QggiLn5U8+/K0oOHRvqDuSmlD05WKG7gTI//GiXYqsd4nFcx1yL5
	 pAbTl7TScS9rQ==
Date: Mon, 20 Jul 2026 11:20:42 +0100
From: Simon Horman <horms@kernel.org>
To: Takashi Kozu <takkozu@amazon.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kohei.enju@gmail.com
Subject: Re: [PATCH iwl-next v1] igb: remove ASSERT_RTNL() from
 igb_write_rss_key()
Message-ID: <20260720102042.GE19108@horms.kernel.org>
References: <20260711133239.29270-2-takkozu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711133239.29270-2-takkozu@amazon.com>

On Sat, Jul 11, 2026 at 10:32:15PM +0900, Takashi Kozu wrote:
> igb_runtime_resume() calls __igb_resume() with rpm=true, which
> skips rtnl_lock() to avoid deadlocks. On that path __igb_open()
> -> igb_configure() -> igb_setup_mrqc() -> igb_write_rss_key()
> runs without rtnl held, so ASSERT_RTNL() fires a false-positive
> WARN on every runtime resume. Drop it.

Hi Takashi,

I think this patch description needs to explain why
it is safe to run igb_write_rss_key() without holding RTNL.

> 
> Fixes: dfaf57ef99cf ("igb: prepare for RSS key get/set support")
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>

...
