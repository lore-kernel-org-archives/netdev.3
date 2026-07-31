Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95221C173
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487125; cv=none; b=GHfU8L6ppdGUbywEny9hhXOdsA5rAgK6FQaM+9g7U9ZkKp9gGDQbQh4E4mu2Zf9V/jVxJbAsQzHApjpakAedP5kjPDKDkBAO8qleDt7uIBCLSmYBOf4QPaZkVwB93bg0efG5YH/Rd6G7dq8CPL7yDK5WQYCJ2QnygHwwYNTY750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487125; c=relaxed/simple;
	bh=HyoU0S9Jjsfoql1usJi2ZDSh4CApjG+qT1ez3mSGUR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6B/42bGsABMgQHJPF7OrCxaxyyScT2Hmwgps4vx2Y5ohqK2/Ri3Jib5+qRF42rkR/ET9vXMouvOuHhY55bxACzVsVVhZ5yyK77rYkhOzEGw2LQOYFz5vaqbbjaq8bo1Z18qO9UK36e8fldkqhNRUMaA3RD0imqhM+hZ7th/joU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=d+hEjRI7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="d+hEjRI7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N0ZZm1JK2wMBlBGK+MklXWurG+BI/d0IDpcnHbNN90E=; b=d+hEjRI7itGhMQRymlxCV2KgHh
	Y+qQe5eHDqGgiOMmFjVPpLqlO94T+gCBpcR/nkzqCXYeYeOh2JmBk/jpQn7PpGhR9IpaohQZAs2ax
	pavE8uO0vMCQuIAgDWoqe5Ynq160Kysz5epBsctnYtdKc05WVcBZ8+xSc+feZWX+vy2IMgQUZscbB
	gsGk1dXeKpdahnIgGDzt7nt3Qx+pWF31uxZIQmMhiBPNm4IInQ0KvAWHqpXXi4p7fNVuppeUNGFH7
	l2QlNCGWC/cAU1VMh4289EuRW20qbQmraidcCGCdCr8OAMEjkv0iNOAtbIYVLrHYO0+TgjhiBcd26
	PzyAmnyA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpilD-009t1Q-2U;
	Fri, 31 Jul 2026 08:38:32 +0000
Date: Fri, 31 Jul 2026 01:38:26 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	Rongguang Wei <weirongguang@kylinos.cn>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Joe Damato <joe@dama.to>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Chenguang Zhao <zhaochenguang@kylinos.cn>, 
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v13 1/5] net: ngbe: implement libwx reset ops
Message-ID: <amxe9jR5vLjVUMk4@gmail.com>
References: <20260731061837.12672-1-jiawenwu@trustnetic.com>
 <20260731061837.12672-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731061837.12672-2-jiawenwu@trustnetic.com>
X-Debian-User: leitao

On Fri, Jul 31, 2026 at 02:18:33PM +0800, Jiawen Wu wrote:
> Implement wx->do_reset() for library module calling.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
