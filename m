Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256E369206
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210532; cv=none; b=UyiouNW0hNKyXpVVFCzqUhUXDF44fYaLectwbJMN2q0uSfgn5xnfWjAFUjDyJgwmjARg+FnEQWW3c9FXGHf9jAQG41QQ7tcqSfotvKXl2dsI3gOL5l0AKfyo9WRh19JmredABJRCDviCdVBqwupip3CqU7/VNSZaWmSgxWc0dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210532; c=relaxed/simple;
	bh=DZoh7eHDw1pjLYVXJOvOB3qcHVXYn6hq7RYP/gXthgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0+cNzreNAvnHQ3inLnAG8F/3HXmj5XecncJCjejL8xIXL70/YsikcK2J6p5GO6TDSnmadABahCmRnZyONf5ecvaVcWVDxoX+uSbibDqowtnFLqhIXZN5fbWT9YRnijRxO9BgR3FI1SIjStKVsYFCNC3EYc/XgFbdZFU1Gm/TBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBp4UK2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBp4UK2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2051F00A3A;
	Thu, 11 Jun 2026 20:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781210530;
	bh=DZoh7eHDw1pjLYVXJOvOB3qcHVXYn6hq7RYP/gXthgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VBp4UK2ApMEOQIqjP3mHQc2VMikWbA5LHo3Jq+5NfQhLVvq3FV0kghLMRRrRiu/Qg
	 VJzLU/lPi7XDf0SJZrkWNOx2L/eROgmmzJJJC2Jyqz/WSXBF86Ysq9Qz59Nk2opUm/
	 UyLMTDLJFmPYtpIkOO2DiNtynDY32jgA2Mv+HFAszQxQJyZgcCg7dgozw2onYaLY3B
	 0W9lbLATGC01BUgIx/fSpTTkfU4WgjFN5/pJmA6651vsSaFGPTiUybwu1s/FqUTmPf
	 EJmy6bXn++px9hx0vNUrkMeM+w/QBWe8kfkEf4VBChPRyKSeVR+upXbwqgM+weUMyq
	 x5b92nZqSwUCw==
Date: Thu, 11 Jun 2026 13:42:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, Tonghao Zhang
 <tonghao@bamaicloud.com>
Subject: Re: [PATCH net-next] bonding: add sysfs interface for
 broadcast_neighbor
Message-ID: <20260611134209.37e3b040@kernel.org>
In-Reply-To: <1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
References: <20260610120812.49054-1-laoar.shao@gmail.com>
	<1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 15:30:11 +0300 Nikolay Aleksandrov wrote:
> Then update your iproute2 package, sysfs use for options is discouraged
> and is not being extended on purpose. Move to netlink.

FWIW -- ynl also supports rtnl and bonding options, so even less of a
reason for sysfs these days.
