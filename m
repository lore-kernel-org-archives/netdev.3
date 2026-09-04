Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7A233D9E
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481187; cv=none; b=V94VH9nj7i6GVpjahG0qigOBgVs7SvQhNxOE4bwPwZmJw6ReiQL6TYYD8QaMQUswgqj86ekoFtM2/pC+9bFjMCKKuRUWVM8MrSOMP7RJXKWgX0yCNPi0kB+4/SanDqYa4hty3PzX0mIakQlyuKqMkkRdnR+RHqdFgMA8/4MgKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481187; c=relaxed/simple;
	bh=knG7swO2pXMj7MUqp/Sg8kXLxvr9BbTSiJeqLlfvXWE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TYM5KLGzUXbZgLgXFKJPMjcOsCrvO1hpCWkYnMyHSt4RM+tLp/nBUaiU669ZVzGxvgySYhygA+Dmll7E+OER7LETaaFNRNI+AAkggahSXAUADZHVAFgUkJL59BDI/WHKpRf7eK51avuut7oHdz8Z6MJ1pKb4TXv+DdMxzzP2CnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDTq8dMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDTq8dMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0DB1F000E9;
	Fri,  4 Sep 2026 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788481185;
	bh=aQZqbwHIvDuApk5qGzI5f8vGZdiKUlcC08Ix7Ek4ckE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BDTq8dMhOObox41sr7SLi4DOqk8nsbg1b9hlWxushHpALP3VFtaaDJii57f03SrBg
	 m5s9YGyWEWwb7XSrpJ1blqQ2FxHMJ9giskR5FHJHT0kKgqc9cXyvRFFZ/q9+Sl3toA
	 wuF8Lxe9vwtVQGAZhOGqBcvgH5aFTJeUk34vkXYiD7lZlZZcKYNnjrWt9LgPAhUCWL
	 h4oxFScNE2/BjZtJkD30JzEzC5vyq56VWkBoVu7BKU5bihRhoxGaBz0mwzfJFrgRkJ
	 fj+txn6Tqfs02w/VFz5zIdZAeuTzU5E899OAU2D5bNv2qgM1yV0nz78xvt4a431c0H
	 v6AkSDK2qBrdw==
Subject: Re: [PATCH net-next v8 4/6] selftests: drv-net: refactor so_txtime
 errqueue handling
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 04 Sep 2026 00:19:44 +0000
Message-ID: <178848118486.4131868.16349357312570798232@kernel.org>
In-Reply-To: <20260902181747.2483351-5-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-5-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Commit message hygiene: the per-revision changelog block of
  commit "selftests: drv-net: refactor so_txtime errqueue handling"…

--

selftests: drv-net: refactor so_txtime errqueue handling

This patch splits do_recv_errqueue_timeout() in
tools/testing/selftests/drivers/net/so_txtime.c into a dispatcher
do_recv_errqueue() plus a new helper do_recv_errqueue_txtime() that keeps the
SO_EE_ORIGIN_TXTIME specific handling.  It is preparation for handling
SO_EE_ORIGIN_TIMESTAMPING messages in the following patch, with no functional
change intended.

The only comment below concerns the recorded commit message, so the diff hunks
are omitted.

> Signed-off-by: Willem de Bruijn <willemb@google.com>
>
> --
>
> Changes
>   v3 -> v4
>     - rename func to do_recv_errqueue_txtime

[Severity: Low]
This isn't a code bug, but should the per-revision changelog be separated by
a three-dash line instead of "--"?

git mailinfo only truncates the message at a line of exactly three dashes or
at an explicit scissors marker, so a "--" line is kept as ordinary body text.
The recorded commit for d88dea26ea55958d0982df4811107d0743ccf08d ends with:

    Signed-off-by: Willem de Bruijn <willemb@google.com>

    --

    Changes
      v3 -> v4
        - rename func to do_recv_errqueue_txtime

That leaves the changelog permanently in the git history, and it sits after
the Signed-off-by trailer, so the trailer block is no longer the last section
of the message.

Could this be resent with "---" before the changelog block, or with the block
dropped?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902181747.2483351-1-willemdebruijn.kernel%40gmail.com
