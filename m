Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792464194;
	b=lY9FbDCOU3Bg7fjANPwe73hD/jBqvJsj1k2XGAynKhC8ojX62mOty+LY2IByGOjjoXWP
	 zkrulkEn7S4QoXULYZTcX3L1fq+x0dEREa+STS0yBBxI1ZyXM+IEwy53AYYl+I2nr51AJ
	 SeIJYI+V4nHCCVJPXWD3ubcoZq/JvPP64MAYyP4YbhJySA5b/lNVnrhl6pv2Fn1Z93dSu
	 hMljAR057M25yhBkB98MBAspy6/Pcobzozk1YcFZcBCo8QRB7faicJGkwf7ynkwUB4koT
	 2RnYEVsH5cfFl+kj7BhOYibn0pmYmTqcbwXdWVkosjfOqsIrHzIxiT7DagN7HKW9YKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464194;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z+kRb/mPzIQorFcWxE11rMCba20QvMcFwWP+qkzX6Og=;
	b=340FeoZ8ykBGEau7dZXH0ci4RkGKPNnB9xvlFGGfi4p/0B5oE8o93oj9KFylfqPCTl5H
	 TKsUaKLftWhczvNd6NWWdVnUGOouVf/dLUdlYbioCrm//Yq0OUhBGVzam+wpQkXXmGih8
	 lEZV/nOpEzb5ua+1n0WKJ6FlGgzuy77IpjiXL5BwCEZXfF/eAG+thAZ03/bONs31BtqF/
	 ENnmzuGIy8VUgJ+/X/pVMExcYdkJ+YRbPhl+gTyp0csG6N1NbY7+1JRy3Rpc13FH8nh7d
	 PXj/2PQXgFR0odVHBZCQH5qkj1qb8nl3FZKnIvfmnIFZsHNAr0OrYmKe0pJbNIxo1sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTT84nR2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63BB606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTT84nR2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69C41F000C4;
	Tue, 20 Oct 2026 02:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792464193;
	bh=Z+kRb/mPzIQorFcWxE11rMCba20QvMcFwWP+qkzX6Og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fTT84nR2R62RRmcXHkPQ94a9FDZovZi+neUCYdhCJHjRb4B6iPLScQ0Bw4qbIIWwm
	 3+f4TOnule4Vf1q0AmfzleJlVVemTp9VKUtJZ9VEFzQtGDV0mwbEGAuJpWf+i6MdFW
	 1F9MsD8muPWuvmua0snHe23/zDSU0bNxVNCdiN0zvkvfbs1X5fsyRsJzVsZ+4d2gZs
	 dHDCgHPErI1RjTXd9fOHggdp7XMl6XPQ+rUz+Pa2XS+dRANbT49XJ9tRQ7mb9hp9xO
	 MiRhWV7DUrrjX475XnLZ4RCmAYgwVULj+BF1bzBGFl11d5ypcqyumrvVp5OJHU1GN2
	 iFX5g7316JS4w==
Date: Mon, 19 Oct 2026 19:43:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <netdev-bot+sinfo@kernel.org>, <netdev@vger.kernel.org>, "'Mengyuan
 Lou'" <mengyuanlou@net-swift.com>, "'Andrew Lunn'" <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>, "'Eric Dumazet'"
 <edumazet@kernel.org>, "'Paolo Abeni'" <pabeni@redhat.com>, "'Russell
 King'" <linux@armlinux.org.uk>, "'Jacob Keller'"
 <jacob.e.keller@intel.com>, "'Kees Cook'" <kees@kernel.org>, "'Chenguang
 Zhao'" <zhaochenguang@kylinos.cn>, "'Aleksandr Loktionov'"
 <aleksandr.loktionov@intel.com>, "'Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 (The Capable Hub)'" <u.kleine-koenig@baylibre.com>, "'Russell King
 \(Oracle\)'" <rmk+kernel@armlinux.org.uk>, "'Maciej Fijalkowski'"
 <maciej.fijalkowski@intel.com>, "'Simon Horman'" <horms@kernel.org>
Subject: Re: [PATCH v3 1/3] net: libwx: keep NGBE OCP cards MAC enabled
Message-ID: <20261019194312.19d069de@kernel.org>
In-Reply-To: <00ba01dd5ab8$76a833c0$63f89b40$@trustnetic.com>
References: <20261013020626.5548-1-jiawenwu@trustnetic.com>
	<20261013020626.5548-2-jiawenwu@trustnetic.com>
	<179185736117.2527009.17237483632731841289@kernel.org>
	<00ba01dd5ab8$76a833c0$63f89b40$@trustnetic.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 10:13:40 +0800 Jiawen Wu wrote:
> Sorry this patch was accidentally sent in the V3 series, it should be dropped.
> I've changed its status to superseded in patchwork.

Please repost the correct series. Please do not touch patchwork state
directly.

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
