Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F4191
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704595; cv=none; b=RdMjgq2vZyPjklyMPlct6l50iWzKCTNXMpX+H4aAxi8Ne8MBGmbDjIGQ1mv5rC0U5WMiuD9Z+V6XVbRIEE8U6w2rL69YY9qKiAWvbpE1Ko1A5OtHTuKOu2eGSWynjz5T0UsQ3oU3kAbU54mEuExPC/V/FUDWd+JTMz3IzA+CV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704595; c=relaxed/simple;
	bh=YoHDSTWk8nycq1cpRuJNFRogL6XKL95l8OAFqxn+FrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IA6MrOLWrcQfV6WuXV+VDjoLxpKiuJDC4bnYxm8b8RVKd6iFmBCLUd9OjDduXdlgBHJtGaCf97ifN2hRH1tq9vHc5AZTFYmcnr2GXg4bIKuEOIAkQ27CgyRMxlBdspXvLhz8uOYx+UHyLcqSYwuwuPAzY5zP4UVQCrCLOEqzZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff+t3ON5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff+t3ON5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCC31F00893;
	Sat,  6 Jun 2026 00:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780704594;
	bh=8rzj7kRzjuTRwf+gA2Dov7GuobV+AAz3ZGhVXLDaZYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ff+t3ON5aJNddaN1Ye8b1gDSrwl8fZE5VBb7JfmBnsEiynmhvA4fEKVWsGnQUG4K9
	 Fo01QKiwMC4Rt3004r+wY0n4Qj4vS27gESA4P4KayHSt83qQgUWoxEjTxLFI8csz24
	 gkfU1oTNwp05JYFVn/2EoucktLbftkeoP4snZIhREdxyrnzGYWV9n6Fux386VArb+Y
	 9ynknu9HF5t+CNmq501DZU5v57oM3Iz6/8AOoVNGn3c6j8mHxgScbWTvyj4sEb34Wz
	 H2wJNfBmlHYs+IcHQEFE15n6/H89LDN1UyPWBiT8C4nhf9BLZSo2jDW8A07G82WWnn
	 0pczSW7ZIu1CA==
Date: Fri, 5 Jun 2026 17:09:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, hkallweit1@gmail.com,
 maxime.chevallier@bootlin.com, joshwash@google.com, tariqt@nvidia.com,
 alexanderduyck@fb.com, willemb@google.com, jacob.e.keller@intel.com,
 kory.maincent@bootlin.com, jakub@cloudflare.com, nb@tipi-net.de
Subject: Re: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers
 run without rtnl_lock
Message-ID: <20260605170952.52c00c2e@kernel.org>
In-Reply-To: <aiNR_GaST-NnkZie@devvm7509.cco0.facebook.com>
References: <20260605002912.3456868-1-kuba@kernel.org>
	<aiNR_GaST-NnkZie@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 15:48:48 -0700 Stanislav Fomichev wrote:
> netdev_ops_lock_dereference name trips me a bit (_compat suffix would've been
> more obvious), but I do agree with the reasoning about needing 'a' lock..

Guess I hate long lines more than I hate inconsistencies.

This:

	something = netdev_lock_ops_compat_dereference(&dev->something, dev);

is uncomfortably close to 80 columns for me.

I think the existing naming is as good as we'll get..
If y'all disagree I can respin. I'll be sad but I'll respin :)
