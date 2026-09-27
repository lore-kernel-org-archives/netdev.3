Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF73CC300;
	Sun, 27 Sep 2026 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549166; cv=none; b=qM3zqpe7AbBM3uFKpno4HlBbJbVwjA9Z1/BL/qrLVxycrVQADQMyXueQ2qaOYSP6kyQCJrVo7itpolAQKG0RV40Sq1j/4WCCJJtGJOhfZHsc4d2fh3zj7wB2jvMKULmuPXGe2kxqi1szQ7ecYOza6sD4FOPEwk7y+3NH3ay8W7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549166; c=relaxed/simple;
	bh=RCG0gdIkA00GQ693adKT13ZcJnGBeis4Yw6Gux7yMNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9abSm7WRcF7HzgOWuxwQYd9raTX0AYyucR97U4lNxoTBbdEbAwwVTUCPlTYHO62O7UYQVSyh6lSECYGaidE0/CxQZRlWWimbbye3GbrPYk0CwCJl/KGl3B8kJJ2nUzHOnQYstVmxSeTIKnw0vGLAn3h946AbEG+EQsiU+PZMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFpSvxvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFpSvxvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386321F000FF;
	Sun, 27 Sep 2026 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790549164;
	bh=sLBVj5rbf/Fse4CNTk8aYYevrpQuHKM6zqnS40OkI70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UFpSvxvcLza/vij5zchkmU4f4KvcsN0drTuwjJ68pfN0/Ed3cE4voAcEA9L/8RErj
	 exfMRr7+r7BJUr8LtwEDNMl4D4FpOR0vrsaNJW2mFfiB2OSUG5xKqR8RAG6GE5Xj1K
	 p9eGT17d4T8qkVLo4FOhE3bGUjNAbuud6ZTu9UK51ZftyNfCKT8U7L/GRtV1SiWT/j
	 LZOZ9jm/yq3rTIchbZGaFjK8jLU60++Ud8LNIqaeY/jEX0NXFcGcYSIG7NYbrY65dg
	 p7c0e74RB8EqA9qf2qV+VlVTOV30X/9tbC+gCbalqp6Dq9KUbKinXXLOQ4I0hARmnr
	 nV59h4i5DEB9Q==
Date: Sun, 27 Sep 2026 15:46:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Russell King
 <linux@armlinux.org.uk>, Jitendra Vegiraju
 <jitendra.vegiraju@broadcom.com>, thomas.petazzoni@bootlin.com, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net] net: stmmac: Don't set or get RSS parameters when
 not supported
Message-ID: <20260927154603.47253d19@kernel.org>
In-Reply-To: <20260926093343.292181-1-maxime.chevallier@bootlin.com>
References: <20260926093343.292181-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 11:33:41 +0200 Maxime Chevallier wrote:
> The RSS kselftests fail on stmmac, and this is partly due to the driver
> reporting bogus data for the RSS ops :
> 
>  - ethtool -x reports an indirection table and a key while the hardware
>    doesn't have any of that
>  - ethtool -X fails with -EINVAL.

this is net-next material
