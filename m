Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06514846F
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089692; cv=none; b=BbUiZw4VoT1ZnLu9EFNX9xKHf8Zz6eNwn6FP0WCbjIdN38XleVxwhIBbuNGJ79MioHPucMbwnBR/W/oqmRFB6WCUNm+KDvrS0BI/Uuf+drhteKugPbmN/7eaOBWYKS4Cr2ybOURbftahXgkJWaQgYzEa4qWdZDN4zIRM4MBb8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089692; c=relaxed/simple;
	bh=QxkD24rKU9b5Fd28Z8zk02ymgHEsScF0ygPgge9N8As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3jr9u8YXaf56BJehXeWpiItXGNTnDeuqAVjBHlHyo/1nvAZz+LuZtpOdZMAFqrCSpLNBLGSvDW+EPdCQm/XWh5+pbpPC3442hNk3dJ+x4avxNPaBRMPpG8HZkKncMVt8GdwteCSc9DONyNFh4MHlO3NneBuXVkuBy6BEwGn9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuOlwzDu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuOlwzDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33255C4CEF7;
	Thu,  2 Apr 2026 00:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775089691;
	bh=QxkD24rKU9b5Fd28Z8zk02ymgHEsScF0ygPgge9N8As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XuOlwzDunkV5LvDL4n+xJwZc2+r94qMlFEJZwdx0Hq+Kycjo5ROaHPiSqGyJTPRP9
	 zABJxpXS7PxubPfBZRA3smdATVLInJ4hiQCtiFKJpJzF12GHQHjtpL33ZansVZGZmn
	 Srcl02KHYwPeLNRCkbnTm4lmVn5dUc6+RjysP73QjIB//0zxJfQUI/lf1xagg5lxm0
	 2smfT39fz8XzeesLqKnXSoCYhjqm90c4wCtQG9EzJG6am5RySzIYEMbXHtplrY/1dh
	 Lrb7TIJiA9VEMdUP4PufbRJzumHWM3ZJ1d5yfYjt0IFjMjFS6lzLiQ3qIS2qo97BiO
	 +zdg+cHBKr6qw==
Date: Wed, 1 Apr 2026 17:28:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, kees@kernel.org, Yiming Qian
 <yimingqian591@gmail.com>
Subject: Re: [PATCH 2/2 net v2] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
Message-ID: <20260401172802.121b34a4@kernel.org>
In-Reply-To: <17d4d7e2-3b55-4eac-926c-e1355fbc1cd3@suse.de>
References: <20260401081741.4273-1-fmancera@suse.de>
	<20260401081741.4273-2-fmancera@suse.de>
	<17d4d7e2-3b55-4eac-926c-e1355fbc1cd3@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 16:50:36 +0200 Fernando Fernandez Mancera wrote:
> As Ido requested some changes, update the status in patchwork.

Thanks but FWIW the idea is to toss it into your normal replies :)
The bot should be able to dig thru the thread to find the patchwork
series even if you reply deep in the conversation.

Quoting documentation:

  Updating patch status
  ~~~~~~~~~~~~~~~~~~~~~
  
  Contributors and reviewers do not have the permissions to update patch
  state directly in patchwork. Patchwork doesn't expose much information
  about the history of the state of patches, therefore having multiple
  people update the state leads to confusion.
  
  Instead of delegating patchwork permissions netdev uses a simple mail
  bot which looks for special commands/lines within the emails sent to
  the mailing list. For example to mark a series as Changes Requested
  one needs to send the following line anywhere in the email thread::
  
    pw-bot: changes-requested
  
  As a result the bot will set the entire series to Changes Requested.
  This may be useful when author discovers a bug in their own series
  and wants to prevent it from getting applied.
  
  The use of the bot is entirely optional, if in doubt ignore its existence
  completely. Maintainers will classify and update the state of the patches
  themselves. No email should ever be sent to the list with the main purpose
  of communicating with the bot, the bot commands should be seen as metadata.
  
  The use of the bot is restricted to authors of the patches (the ``From:``
  header on patch submission and command must match!), maintainers of
  the modified code according to the MAINTAINERS file (again, ``From:``
  must match the MAINTAINERS entry) and a handful of senior reviewers.
  
  Bot records its activity here:
  
    https://netdev.bots.linux.dev/pw-bot.html
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updating-patch-status
