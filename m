Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A94B04AC;
	Tue, 18 Aug 2026 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787016838; cv=none; b=rTTusmvkufE6aEUwRF0H/WXZPiNF2QihZ+eSxyU/pEsNCuljcZ3ptsdtt0pxP2y0bjkiZLiLODyI5k9G6wprY/Krh8gszn0GypQSrwpyZ8qCVpcWyHCVTDmqcG4TDTb1+NHK/OPCczr1Ud0JmBTcE8jymw4dejSU8AUsHWRWZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787016838; c=relaxed/simple;
	bh=PZMB0cyMnYAzvR5XGM+LOA8qbDQ8XPrm0i4g9i6VMXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q90xI9A2XDB4A62AZp0/KGcICOoRZmg1FkqG8frC1jt0pzPBN1XzJoQWSHrFmuu25V93ZPp71dR24F/0pSg+xmwaxteU8VyP+qEkYtSJ/YQWAWkHVldwqpSBLUGRiuZu7w+cE+sFe7XponCcvH/pUOzQc6Z1nbMtwWRvHg911is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/uL5skC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/uL5skC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4789A1F000E9;
	Tue, 18 Aug 2026 01:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787016837;
	bh=HE4o0fBx1vjmEZJ8y/WxeHMVqUkBuJHObDItDEHtR58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B/uL5skCqF26SJ9oSkFev6+fiCHIdBYT12Y0S9rc6ea5Z8EprZC61GkEQLErK6xpW
	 wAmmJLfgcxRyvjiIyUFNCLkhpXGOn+zTSVuuejKIoMVEJZVCMlqT/dckmxz2yiAz7x
	 +5A6v7jutM4YB+/ObFgWrS25ZVwTJof5+3QtOsRvHhoDYOwHnKtwZk+VlL39srCUrD
	 W7ParihMlxWBSRS6chol0bk9/UFaJUKUmP7X5tYWJbzOdn6bjuvHxtUhY8rpPJ7yum
	 5IWA3UPWrEG/lmUQWux24zkB2JqAsc8vX09SmgIUDPGiHr+NikJ6lnbwjTyDO/R+Q2
	 /n7206oi3khuA==
Date: Mon, 17 Aug 2026 18:33:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, weiwan@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: yield the CPU on every exit of the threaded
 NAPI poll loop
Message-ID: <20260817183356.4d90d878@kernel.org>
In-Reply-To: <20260814220427.623427-1-sochnev.v.74@gmail.com>
References: <20260814220427.623427-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 23:04:27 +0100 Vitaliy Sochnev wrote:
>   CPU: 0 UID: 0 PID: 241 Comm: napi/qdma_eth-0 Tainted: G W O 6.18.41 #0

Please try to repro this on Linus's tree and repost if you can.
Don't recall the exact details but IIRC the preemption is now
more aggressive.
-- 
pw-bot: cr
