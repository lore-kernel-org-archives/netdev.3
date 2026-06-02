Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08323FDBFD;
	Tue,  2 Jun 2026 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422897; cv=none; b=MqfVqUxTq8xKIrx6ZHkXni4XVidX7iVaIrLjRI0mk5o0cjGCr5Bi157+SmvClce25zWNEJ9JDNE1m3y0WeuHhlDZWEly+12QijMQQ60NgU2qtLv05MREjnGKvR8IjJTDvg3Mi7A2yRMLANbkNkdabS5e4D+mB5VL7q6DHt9v25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422897; c=relaxed/simple;
	bh=DvCBSLijMmUehZDN7BL7ZQVfGkdmcQHWOlVEMk6Dbvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XT7SsQE7Ok4PgdrTyA+cE1O1iIF3QhqeuHM53QWEt3Gr/dw3U8/lH56oo8lca36rsqNAsF8xUhDKeRA6SOSvAERAxYNi/KXTlKcqz5BXbkxXu1IcPWuUtmtv3T04EQKR+f21SIT9iUgx0wWIj6dcbBhRj2R2D05w+AwwPB0y2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwHcIuu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwHcIuu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DC01F00893;
	Tue,  2 Jun 2026 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780422894;
	bh=GKc/rx9c0FGYhJ5we5IkWoI6K2nf82lJdy9YDt3Co+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nwHcIuu1i0fuvDfS6+57Nb7sQ0B0g05eo+K8d16OelMizlHYeFFcenJHn5cD1n6HN
	 rQS+aykB5PE2HwmG6FmU/TcDP2Ea58XjBws8RD9JCXfMFZmdJlm1Ryv1SwzU1HA5S8
	 0rGAekdgIuJ9HbHHlrJuPJy9RytXw62F6KogNaDjocOpw3GGknM4Nm6OIkymLIBuXP
	 2LmAbAJMd2krUC3aw6eoV8YppEhX2U8/N3TDdFPumG7i3aReiDuJkBvUhhzSzJ0a0n
	 OIs2AM3fJjKJSyD2h0xe3ZAekNogGy5+twgPTlEUGkJYb93jSneX9F0wZ/mnyFCE59
	 /KApCR8hYuuMQ==
Date: Tue, 2 Jun 2026 10:54:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 stfomichev@gmail.com, kernel-team@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: bnxt_en: suspicious RCU usage in bnxt_fw_reset_task() qdisc
 path in 7.1-rc6
Message-ID: <20260602105451.18a7390f@kernel.org>
In-Reply-To: <ah726OtFX-Qw3U-R@gmail.com>
References: <ah726OtFX-Qw3U-R@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 08:33:31 -0700 Breno Leitao wrote:
> This looks like a regression from:
> 
>   850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the
>                   bnxt_open() path"")
> 
> That revert dropped rtnl_lock() from the bnxt_open() paths and left
> bnxt_fw_reset_task() holding only the instance lock around bnxt_open().
> 
> I can send a patch restoring rtnl_lock() around the bnxt_open() call in
> bnxt_fw_reset_task() (re-taking rtnl before the instance lock, matching the
> pre-revert code), but I wanted to report it first to make sure I am in the
> right direction.

Yes, we need to revert the revert. Per my recent ethtool locking series
netif_set_num_tx_queues needs rtnl_lock for now.
