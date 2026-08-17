Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0AC3ECBED;
	Mon, 17 Aug 2026 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009926; cv=none; b=cALkra9hLyVbFs4+ixv4ux3pEg0H2rH0+heDfIBMxCvTBXS4LZbfbEdVKAu7gFUsNci7+d54j1EYR4TjbWU2At5aP1ABulYBQOIY1nP/+MjEHb5hETvZqKdLfCwcgfTCFAeUyVU/NmxO87v9z9uE3vmltj5oybVI5yd31J+hRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009926; c=relaxed/simple;
	bh=2tUxnHkEFBZ2JdUVdwF5gViS9XDKGt/Wthfs2ra2XMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4/MYPScj+O2aNZ4TIPSXHUH3Jiqto7Yz5feJmVgvQI3mV4N0HCfQ5PTTFrnDK6nhoUeqI5ZXKH68Y72Qrf1lwDGhcGol4rIwYpYvKk3LCXQdlmC75v9MYk8OKYh5lTj6efSMa0rhjnBw+AJyqbtAmrgUO3UqAPPn0hS64MPIQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffS47bDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffS47bDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DAD1F000E9;
	Mon, 17 Aug 2026 23:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009925;
	bh=yCoHqlcxoyWY+tmMWp+eVl8fHsUSjs1QiGrszrpMmrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ffS47bDcI/1RxXa6w1ILpNy7VjO++lfuxqjAXk9rwCz7Q197haPEtOVvZXXNVlXv1
	 W5divaI2T1IuixyQMnR7r21nNAcKXM1YttJP9AInwGqWl29OO8gx5lri5N0flQXRr2
	 CQ+NgmCc3uKZcQD0HRABun6BgZKi+oUCoOfJtudT2Rda3Z/LlvFlzvaxlnjjNf3Nx2
	 4x6crIgN1+masxVjNUuLFoZcWiNF+4yYCUF/8FZdc6Gsb9FYK0dpjHj4Bw+Pil5s8U
	 2WSWwfA56xjdWTjdTtDKiGeoKGKxEdiMhXiSC1u060B6/pGZnvOF2nR3o30ek6zh12
	 xegj+R+rNHP0w==
Date: Mon, 17 Aug 2026 16:38:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 4/7] r8169: enable new interrupt mapping
Message-ID: <20260817163844.631c08c2@kernel.org>
In-Reply-To: <20260814015203.1328-5-javen_xu@realsil.com.cn>
References: <20260814015203.1328-1-javen_xu@realsil.com.cn>
	<20260814015203.1328-5-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 09:52:00 +0800 javen wrote:
> This patch enables new interrupt mapping for RTL8127 and add error pkts
> counter per ring.

drivers/net/ethernet/realtek/r8169_main.c:4383:11: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
 4383 |         while (--i >= 0)
      |                  ^
drivers/net/ethernet/realtek/r8169_main.c:4365:7: note: initialize the variable 'i' to silence this warning
 4365 |         int i, ret;
      |              ^
      |               = 0
-- 
pw-bot: cr
