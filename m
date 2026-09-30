Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CAA20ED
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726582; cv=none; b=OG4JiyTk3bemRh2cq92pXJ1Ndwm53QGDKbDjAf5Uev5Ko7CXHXrhs0A2Ys0ysJ36xQBYOgSbW+cSWzgePhCjmqdQS1zDCVNNByFiwdU3s4t8sPOYayjh5oeelpsY/jFazPpt+kAnZHp93V1iI/c0Q3diOz4Ci3yHkMOhzNOjCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726582; c=relaxed/simple;
	bh=0yjg6jnnQDBM+0BKF4jXyVY+t9ZWhl1NrPDMZoRKXBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fj5qwUD2Yjl6yF2mNyut3q34Lz6jzJnCSGyN3zh/TAvqZhvjPB+aE7BbVKC6zLeu1BYCLZ9IvzEnLbDox/eLMCYoD9080N+ZP8uCDMD0y/Md4bN3A0cgZpK7z1UZc01hsHrzxbcRKAP+SABF2jaOsGt2Q62Drq0flaRkz0tSlSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJDMtot6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJDMtot6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5D01F000FF;
	Wed, 30 Sep 2026 00:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726581;
	bh=TmBsp48q9FtMutirtkoRM3AJOyO4/4gTHufHBeZKsgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LJDMtot61c+fCT1FO72cgEYpvsjp4HIO1NhGdST5dOx2RmsNdAhQszEvxrZbV69eB
	 qSDQdb+pSxrZoT9MtxWE70/ucPZ98is02/ryP5Vc3hV495MpGSekD1dcfLlip4R541
	 6cDFqKjK6NHl9WOTzoIqIWwHnqJIqx4Fo8R9w/qncb7xJbO1Ajk1X4VJACeX6B8F41
	 BoyQ61IUGzsC4yPm03MsEcFikiZceYwHNwkuw8eP/WIV3+21sqkA0WebEv05GlYbVz
	 pK3z+XqFB9WdqE5f+uQ9wNiwVrl+CHXUvCoE1AoCsu2nzh5zaY3T9xiyF5uDrxe4qk
	 VvsA3d23j9KqQ==
Date: Tue, 29 Sep 2026 17:03:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>,
 syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v3] net: phy: make the hwtstamp provider
 lifetime symmetric with the PHY
Message-ID: <20260929170300.39a8cb63@kernel.org>
In-Reply-To: <20260923071132.908826-1-chenguang.zhao@linux.dev>
References: <20260923071132.908826-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 15:11:32 +0800 Chenguang Zhao wrote:
> phy_detach() removes dev->hwprov when it points at the PHY being
> detached, but phy_attach() does not install anything: the setup and
> teardown are not symmetric. The teardown path is also reached from
> the probe error path with no RTNL and an unregistered netdev, making
> rtnl_dereference() of dev->hwprov trigger a lockdep splat.
> 
> Track the provider with the PHY instead: dev_attach_hwtstamp_phylib()
> installs a default provider in phy_attach_direct(), and
> dev_clear_hwtstamp_phylib() removes it in phy_detach(). Both sit
> next to dev_set_hwtstamp_phylib() so the locking is obviously the
> same, relaxed for unregistered netdevs via
> netdev_ops_lock_dereference_or_invisible(). No driver callback is
> invoked; installation is skipped when the PHY is not the default
> hwtstamp provider or when ethtool already set one.

This is pure slop, you added this incredibly ugly
netdev_ops_lock_dereference_or_invisible()
instead of just taking the RCU lock.

Please don't send send any patches to networking for the next 2 months
and use this time to learn kernel programming basics.
-- 
pw-bot: reject
pv-ban: 2mo
