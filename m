Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA33ACEE0;
	Wed, 29 Jul 2026 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785368034; cv=none; b=HHOOtdsIS1Ze3a9H+V5M4IVJeRuOrzH2Z+9uMCI+s3SK7iMJ0Gv6rRlLhz+cJAVF3LEgTGdOUtkhdWA1PwvAgb3thHgez3JMBIIbgRvCZbvE6uAb9wRhfsBuljZD/NZHzRVmHJ94AI9/nmRG4U1PLZKMDZccKzQwYqHiYVGRfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785368034; c=relaxed/simple;
	bh=KZ2W+1TmJoCFSiu6MleXkp5WCkU3C8yGtbI1EnuCgJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDE27Byqvxt6WR7Gmw1aMJEXxsmU+b2sbWtko2LADkcMe/p5l1WWD3SBfTYX9bC486709spdlbgdCqwQE050zaN7FtaVqrG2WfNhfL2tM/N8fvoH8c4AS/WVO0yfOFDRy6p8CBh95SsXofK4gK8rdpofm75BUABo9LXc4foG0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ6FaQ4D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ6FaQ4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C501F000E9;
	Wed, 29 Jul 2026 23:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785368033;
	bh=RC/IkC1uOxSmcA/OGvfbq2tS4YeI5Tdi4kPMyQml92k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SJ6FaQ4D8PFLN3x7nYco2Aazcnp80U3QwkqaJCAdSUrI156dNJHmWRjM9XoIFuuiB
	 B4l2GOxAcftYZuLW6TLVuswwbnP+nGqLJHV/7sMQ7lVDx4nG0kkzsncI4LXwAu4Wiw
	 OnVRWmiwP9LsW1Xh1QoGNmAh4slb3KO6Ms+YmpPh6vVa33j9UAbwAqU4Ox286hIgDV
	 OOt1/dtpKuRAmjcl3ammwgniK+C4IFWgx0I4B1Rq8RvqvgtBJJ54xeqc7CBepaQ+Xn
	 bY4NEjwaNWxLNyBa4WAGflFxWfdYEt6pyUROKCTkc4fkyNeWPAWKnm/S8BKKnpFN7P
	 r76pIkR/YDpCA==
Date: Wed, 29 Jul 2026 16:33:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
 rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
 ajit.khaparde@broadcom.com
Subject: Re: [PATCH net-next 0/4] bnge: add more functionality
Message-ID: <20260729163352.6e0b9bc5@kernel.org>
In-Reply-To: <20260724142954.3101980-1-vikas.gupta@broadcom.com>
References: <20260724142954.3101980-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 19:59:50 +0530 Vikas Gupta wrote:
> Patch 1: Makes bnge_shutdown() functional by properly unregistering the
>          netdevice and freeing associated hardware queues and interrupts.
> Patch 2: Implements ndo_set_rx_mode_async().
> 
> Patch 3: Adds a dedicated HWRM (Hardware Resource Management) command
>          sequence to handle explicit interface down and up transitions cleanly.

If you have to respin - there are 4 patches in the series.

Sashikos point at bugs in the EAGAIN flow handling in
ndo_set_rx_mode_async. Can you double check that?

https://sashiko.dev/#/patchset/20260724142954.3101980-2-vikas.gupta@broadcom.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724142954.3101980-2-vikas.gupta@broadcom.com

And the concern about IRQs being in use on shutdown perhaps.

[P.S. Ugh, looks like I wrote this yesterday but didn't it send? sorry]
