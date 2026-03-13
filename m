Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E683CCFD3
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423095; cv=none; b=KMDJY1xbvk/OtMiunCmqXxwgu7IhkOH0ebzRnkQe8N3jubNO25ivsKUpzhWw5Ucr0i157KeZDSp2HZk+qYPvEL8Cb+OEs7ee0nvJcPeHWs/zGZKD+mHwxN2IOqfm0LVmNDqQ9JEw+D7pW35mj+DnU9aHNZNDLjWl2UgC/WKJX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423095; c=relaxed/simple;
	bh=2OD3QKJX0BuMOABTQQJG5m/etYMd583kSTssW9ITCLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeKIwgYjufA/h8YH4htGfq9vRkTa72uEJ14VHNokIqIEXgC52jU0BkcJNWYSlVwHEDUsi+X2u0TgAZl6/TPqtQWjmKrX2bLxcLUxn6qN1VjiCpDo6Hrt9tkvnQoRv/urhtQ32S2sflF6y7z+VYEnnTddsCKrxcMRq0jxwHD8Mfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvAOfddE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvAOfddE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF60C19421;
	Fri, 13 Mar 2026 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773423095;
	bh=2OD3QKJX0BuMOABTQQJG5m/etYMd583kSTssW9ITCLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YvAOfddECM9OHDCNVATd3OtuPzVTwbdAIR4qKXpmZyf0ntbXM7QW3isqGakzQ/TkP
	 sAuj/aprrqldMElTll94G04uR2Au/4dGQ6cqMRggw8gdMoR+Bv0+lzTRxlb6PoYEqP
	 A5RHcw1gqQfEjllyKFwmvhV2hp2Perxgo691o2gkxLeOT9WecsF4UTUCbm1GPFR1gt
	 RFDnZVOwjlaE6xP7XjvvHYzck48t6lmx+wTxk34WiPnL2/IUvKks3XoLSJgfUjX6wG
	 OByw319l0yqjFsIIXbW/9Row+ZIBD4YXL815Aw2y6Zhbx/V1Fq3nEAByzyG/MTz4M3
	 2V8IZGoUREA9A==
Date: Fri, 13 Mar 2026 10:31:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH 0/3] macsec: Add support for VLAN filtering in offload
 mode
Message-ID: <20260313103128.41b0c511@kernel.org>
In-Reply-To: <20260313105227.1884391-1-cratiu@nvidia.com>
References: <20260313105227.1884391-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 11:52:23 +0100 Cosmin Ratiu wrote:
>  .../selftests/drivers/net/macsec_api.py       | 103 ++++++++++++++
>  .../selftests/drivers/net/macsec_lib.py       |  20 +++
>  .../selftests/drivers/net/macsec_traffic.py   | 126 ++++++++++++++++++

Thanks for converting! I think we're missing MACSEC from
selftests/drivers/net/config cause kernels end up getting built without
it. And we see:

# ok 1 macsec_traffic.test_vlan.offloaded # SKIP macsec-hw-offload not supported
# ok 2 macsec_traffic.test_vlan.software # SKIP macsec-hw-offload not supported
# ok 3 macsec_traffic.test_vlan_toggle.toggle_on # SKIP macsec-hw-offload not supported
# ok 4 macsec_traffic.test_vlan_toggle.toggle_off # SKIP macsec-hw-offload not supported
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:4 error:0


Also I'm slightly weary about "frameworkification" of the selftests so
since the selftests aren't huge maybe avoid creating the lib and just
squash all the macsec tests into one file? Or is there a reason?
I know that it feels cleaner to separate things out but in case of
tests which mostly get fly-by contributions having to teach people
about libraries is quite a lift..
