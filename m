Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9B3328E3
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740787; cv=none; b=YTez+2FUVL4kjqIQiGt8ERh+tW5ZN/5zG//FrREtGtMB0z3DkAYryLFdHGbiOvVHqgvHmgmhb0du8o3/jSg6Pk/gjVgA5jqb6eyPEViuFtmLHoSDiiaSCZlelT3lbhyzl6bJe3U/RdOMH64tyctSMT23bGIKC452Urt/mZEdS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740787; c=relaxed/simple;
	bh=gAi5jxv8fF7aM5ZjMOpRleMC9ONCtzk5xWOGgZZRxss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4Wbvy6pCFA5iWx8syQb8Qv8sTgUYLHnvCDkKrwQMjj6wdeYtTDHgt1dZ81oW8QNA66onFhHyVjnTfbkyvMHy4/WwyCIIh4mJBqK17UH/acww3gCPD27kHGmML0XIfrvj2oNyUKJC0YYN3AK8akepjFNHMMDi26W4VEQzEMxZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RQ4hLX8P; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RQ4hLX8P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+9X84gM6iPEoxKcZAhAl50CEeyqp8NKTGUKu4SVJ1n0=; b=RQ4hLX8Pjeed5bx1LQsphXhndL
	MFRXk+IVG7JkisutRLWo2IpGuhbrkD62W4vT1fDfScBMc2nqzJFu6ZFRzzOrt+Hrl2QVgWdwLNIWI
	bfb/pMWeksTiZlPJtfR2pOMsMKP1yPwKPG3cWc9wQ8JAO+a5bDsLC9yRRpKMYsVSzbEBk7ZJI9zay
	21BC2oSjdvxXtKnvM+9/XcQSgSSSHZRpFeH1ST9YMcHdcPWGOOspSmmN6jtMrJ5qM91mBcqzhMTpc
	wlbjg0JMUcbWudwcAafBTSn24WgRc5kY07E7crSf1X0VagRHBYR9So70Wu0pY6/YH8VzCuwVO978w
	bM6KrGPQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w2R0B-002nF1-PK; Tue, 17 Mar 2026 09:46:14 +0000
Date: Tue, 17 Mar 2026 02:46:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, 
	Michal Kubiak <michal.kubiak@intel.com>, Joe Damato <joe@dama.to>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: Re: [PATCH net-next v5 01/11] net: ngbe: remove
 netdev->ethtool->wol_enabled setting
Message-ID: <abki0rJxJONPsdfh@gmail.com>
References: <20260317073827.4300-1-jiawenwu@trustnetic.com>
 <20260317073827.4300-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317073827.4300-2-jiawenwu@trustnetic.com>
X-Debian-User: leitao

On Tue, Mar 17, 2026 at 03:38:17PM +0800, Jiawen Wu wrote:
> netdev->ethtool->wol_enabled is set in ethtool core code, so remove the
> redundant setting in ngbe_set_wol().
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
