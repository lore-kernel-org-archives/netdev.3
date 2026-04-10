Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602442D9797;
	Fri, 10 Apr 2026 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789399; cv=none; b=m0l/3+/B1qWJo6Y+DT21IIIyLK44hvookajsPRkHLdqy0tcaOyzYrM8Au2DWvYxNWYIWgws9QJ5IZrvxZPxpZ+rCfYpX/bEO/+3ufwXN2YysTo85wtnKIrAjxpdxEJ9TRTMAQ75/Dq6v7SIcHtaPzSViqP3DMwyg09wgaLhNY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789399; c=relaxed/simple;
	bh=PFxwESjEwiInOIjqqERto05W36d4TqT8t9KgDW8sOSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUg4kan9bZBoMxh8SpaV2Nzl519gk3dLL+b3WfsBy7Wkr+PAU2KbJmB6YmHYRS8cYM1EU0UachrvKPAMaKA7l5z52blku0puYpKNyJGoqEufZUo6hHBvXdGJ/dRUIYs7E+wnSP3hRNIX4R86wQX4uRBBM3KK6Jvfo0o1GOHh9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa+XUCHO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa+XUCHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F85BC4CEF7;
	Fri, 10 Apr 2026 02:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789398;
	bh=PFxwESjEwiInOIjqqERto05W36d4TqT8t9KgDW8sOSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aa+XUCHOgWmSMF5tXwjQPXAitH7QV/XANqoMsyzyd4uyQ/cNkP1YBmRHiQR55zrz+
	 sfByURHJZk5TXIJ8z5LzT2zCW5E0ue+rBd2nyOIK+fSvCOg1Zx9BBmTCdOjSLN/WvF
	 iNdIGk0h/XXe37TMGj4RBSRp241MFK0NV+pEJbsLG+eCJjeWc/Tap9gkR3DboOvUnA
	 JGbNjrAX44i2bUCmpgmTsXFoy6WiIkUlkHAb0y4CXNayPwJ9dhbLIIP83jc2lPEfXY
	 y54G5vyw1ue6B6Kqau/vStn2lu5vkL2j1vrm37Sg9DTL8pH7MWUJeO5AqRfxMJes6w
	 XUEPPSHPoVenQ==
Date: Thu, 9 Apr 2026 19:49:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] net: rose: defer rose_neigh cleanup to workqueue
 to fix UAF
Message-ID: <20260409194957.5465e98b@kernel.org>
In-Reply-To: <20260406170125.175258-1-mashiro.chen@mailbox.org>
References: <20260405125830.89251-1-mashiro.chen@mailbox.org>
	<20260406170125.175258-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 01:01:25 +0800 Mashiro Chen wrote:
> rose_neigh_put() frees the rose_neigh object when the reference count
> reaches zero, but does not stop the t0timer and ftimer beforehand.
> If a timer has been scheduled and fires after the object is freed,
> the callback will access already-freed memory, leading to a
> use-after-free.

What if ROSE is built as a module and gets unloaded?

Please don't post the next version until next week, we're drowning in
these AI generated patches.
-- 
pw-bot: cr
