Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141D28D830;
	Sun, 29 Mar 2026 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774811697; cv=none; b=iEMzWAxDjfByy7JU7zy4VTfZww+liu8Vjjy0wHeUCnaMyqILTCQQFr5klVB9P3aD4jaQTdziQIFJUZSWmU5bQeK+KXszgsHvsVIVrP6I0EUyN5KerFfjjwyXjEYNs3N3gNGCdebTxj/21pH6CnAOAMu8Vt/VwrW/U82gewb8sGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774811697; c=relaxed/simple;
	bh=2t4y18byjP1MjQQ2XhoChveQhWdoC7SnSWd/GP1c26g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVHYEzCEHf/eKGr5iUnXWcHWu8pHOrXPHhCARo7HKWDo2JvvNyYrHUC+VVTTCx2iqFqblfLgspzJQU1t+UtDDU43HOpOcg6xb9iRBogh8O5aFg1C0oZzntTmpmv8cceduZULf/sZSpuv3OIL7QuIT8mrdauzH2281Vb0TQ6Y0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L71CGYcE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L71CGYcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3851C116C6;
	Sun, 29 Mar 2026 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774811697;
	bh=2t4y18byjP1MjQQ2XhoChveQhWdoC7SnSWd/GP1c26g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L71CGYcE68iwQWH4swEnEnQd5j4J1W+HudNK3TShVFeCpkhI95IU4g4JXoykRuJrq
	 k5Lip9ePtirW1wyHq/ZlHphH9D3zjq3SkRTWSKi4C+uIhO6SfqpcXVeYHCp1aNUfvo
	 /B+FEGp00aaRdk80zHhk74rzEZH+rpRdusZvw6maC3gyZL7HXZpwNyiK94+LhLnKip
	 dIUabtN4QvKW3DPfjhIBzqkWkDS+DEK59P6bs1a0SIM2PXnAogWQ7SZOzond6lQCaE
	 02lqUAhSz0HiRhlUXj8XHI0Az2eqbWszHG9+TzIJgbP9Kmfz6qelpSkiGQI4YHqE/z
	 4K3ecNoUfEvew==
Date: Sun, 29 Mar 2026 12:14:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, John Johansen
 <john.johansen@canonical.com>, Minas Harutyunyan <hminas@synopsys.com>,
 Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com,
 linux-usb@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v3 04/11] list: Move on_list_rcu() to list.h and add
 on_list() also
Message-ID: <20260329121455.72f87d3b@kernel.org>
In-Reply-To: <20260326131838.634095-5-dhowells@redhat.com>
References: <20260326131838.634095-1-dhowells@redhat.com>
	<20260326131838.634095-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 13:18:29 +0000 David Howells wrote:
> Unfortunately, list_empty() is not usable with an entry that has been
> removed from a list with list_del_rcu() as ->next must be left pointing at
> the following entry so as not to break traversal under RCU.

This seems to break build for jffs.
Someone already marked this as rejected in PW.
Whoever it was PLEASE STOP.

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
  
  The use of the bot is entirely optional, if in doubt ignore its
  existence completely. Maintainers will classify and update the state
  of the patches themselves. No email should ever be sent to the list
  with the main purpose of communicating with the bot, the bot commands
  should be seen as metadata. 
  The use of the bot is restricted to authors of the patches (the
  ``From:`` header on patch submission and command must match!),
  maintainers of the modified code according to the MAINTAINERS file
  (again, ``From:`` must match the MAINTAINERS entry) and a handful of
  senior reviewers. 
  Bot records its activity here:
  
    https://netdev.bots.linux.dev/pw-bot.html
  
See:
  https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updating-patch-status
