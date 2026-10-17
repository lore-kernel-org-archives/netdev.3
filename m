Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86810303A04;
	Sat, 17 Oct 2026 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201904; cv=none; b=fSWDOvxbnzMIq8Z6IeI5FazvAqxdWoKE54iESW71dxJXZB7wFkTJxxtF5GlZ1nThH3J+QOTOU18WHubr8+udJANTdi5LkV4S3Wsbb/h/1NaQuDadjl7gBD+bYws05aA42/PbB3EktVMI92oAxvIzwVSAkFEQFcsOHOD7BUbUbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201904; c=relaxed/simple;
	bh=oKETuXSBZkdefM9dWckLhk0fN5UHfALK9WumShvAcyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmGAjMOA1y1KbVSCy7YU5V7eQnoWhtH3qxnuE30+MOCRu3mKAD+u4/X1VmWVitIiJpeO3Z5r7DTnlCqlN34G/dLxlMx0DyxvoKWmZJw3yVoIyLukg3CpDCAaBuab+Dz2t6GleNup9H8X7lWhrpoYdwcixxapsStQVXpDV5Y5mys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nplHoavD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nplHoavD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BF81F000C5;
	Sat, 17 Oct 2026 01:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201903;
	bh=B6gIefhz/Ru/xttBCGW3zqpyd9FbstuaxPbqvmUeRAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nplHoavDlUWw0W/h7cM1PFP407lefwuqoZpCkZK4pb/JLWzbrZl1BOyV8PkZjeA44
	 Q3G3GE21CENRnTS6flG2VtQTV7P1WRuekylzd6/jEv0UqoUh1C1WRFTw43I+z74/ey
	 bRz7cUSIXZGDovaXn0TKRIBxRm+nMJPZnsh6hU8MaVPCl6ZIZOyq1b04bFgpYaWA4a
	 RGBDl9WrhpXDV8sN9hw6N8Z6M9IYW/u1x/onqW0d9ojw9sr9kDjsvHNR/y/yRYL7pk
	 smw4bSvt/hvecRXtwATMLZG4Vv1Ltynm3VYdHx9VO3NWaYeirp1ja9G17B4LSb2YsS
	 3U82XVAAuXRTw==
Date: Fri, 16 Oct 2026 18:51:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko
 <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net-next v2 0/2] netconsole: add locking to configfs
 _show callbacks
Message-ID: <20261016185142.757f6c2c@kernel.org>
In-Reply-To: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
References: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 18:03:42 +0100 Gustavo Luiz Duarte wrote:
> netconsole: add locking to configfs _show callbacks

let's wait for the fixes to get merged
-- 
pw-bot: defer
