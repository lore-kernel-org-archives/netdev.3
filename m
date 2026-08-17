Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D24457CF;
	Mon, 17 Aug 2026 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981374; cv=none; b=LD5XnVkobeOmBVY7LTMPa9Wt7g2hfScgtOjKFey0cc/7w+3p0tHnQCWKBcqrUl/dcB0s8dxf4tfEGT105kWPU6PaVePEINDGAzc/Va2K1JM8CCblhqgU3+7Lxc7nFLfIxXW855SCl+xGruqqO2shss9EhUDa3rR7Eic0DlNXXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981374; c=relaxed/simple;
	bh=yHkfC5Uqagpc4eLkSCg9ElQyFlUqfQq/EPQAy3qFpCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huym3Jg2KtuEhQ5ywixjvJ6SImLRYgvsCrL8Th95WExG2AGC4JCs+uCgqfxkz96XQIddNe1JB3ctp80qT8ZADsyVEm/36lE2Dq/RNoZg/ruCPv5o0UyKB9jlbBkimFNHfQP4BDUsOSxYrogucmfzLfd4InFokYJ8viAFt4vkzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxuYgzvO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxuYgzvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AE51F000E9;
	Mon, 17 Aug 2026 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981372;
	bh=SNyuqIkgZaQcQbrFq0LsxGNkbLIwVGNMCs4FkR/LPy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CxuYgzvOVq/K+IhaX4nFK84lkDgKAoN6em3GZjJngKdlQmYsfXftGjxWvELmsevCj
	 dZSs3ApbLONsXpIVvTp4zc0b4C6LjPX8l+atGayjX+vhL9BQR6qLruDZauqUmMnVeg
	 hrn6L4RPHZqE3iC4enzpbN9gz3Mr5L8NkkM4GZRYWUKq+MbxsCzz8TxwltuqtZYRXG
	 O9lbmJWeNxLNm/aYJOkJVvDFiVlBTJd+OaJ0CpOhH9IQ7xjJ2EC1U4Js+qL6eajNJK
	 hfMrRpk7l9p5Minky0yMfxPrVHQC3b/Jiku6YGZoGmyYx7KrcYjI7G1ixT+5Q2fxd2
	 UdmEHCD6LabUQ==
Date: Mon, 17 Aug 2026 08:42:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chen Anwen
 <chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
 <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v13 0/3] net: hinic3: PF initialization
Message-ID: <20260817084250.014d9c2f@kernel.org>
In-Reply-To: <cover.1786774752.git.tengpeisen@huawei.com>
References: <cover.1786774752.git.tengpeisen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 10:03:59 +0800 Fan Gong wrote:
> Add 10 ethtool ops for information of coalesce and eth data.
> Add MTU size validation
> Config netdev watchdog timeout.
> Remove unneed coalesce parameters.

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

