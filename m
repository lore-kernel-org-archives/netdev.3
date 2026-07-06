Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55B41DEE2;
	Mon,  6 Jul 2026 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338956; cv=none; b=er/pOzL87uW7VotAhYFDS2WG/KewpFSijEtVa2iF64ibL4qj9TBZx3NWKK4cS60zljPEujjdTBuLen1zAMSd2OvBoBJpFW+i17kgWzMyAG6DDh+WBvFJgwHmUIDI5VCiC1ptQ6TyWJ3Ql5vTPM0Sb2+x1BPoWaKfbHgOf00AqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338956; c=relaxed/simple;
	bh=PTZG7m33xMH9SopMNkZXNBhboWoPLdaQI18YqDUA4dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmAiAgG1sdGiyS91M58RYED3KU25wipm2Z3CC73lybNppINn0fafWGTcg2Ri6IHLbzh5e+x4PrBjM71t3HH4QumhDsseJXWrdUSrJefaHgCXegoFsOsHgCd2bdqQvtmXns5ywkRAaGjCx3pEgAv5nEBT8iN/KjUvbZ4zzcUVQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=FU526xmj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="FU526xmj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=85baL4XzLdV4LjyrP8NBxWz1/vTMzqtO5DKNhG+R0N8=; b=FU526xmjgtWw5jczs74aRiAnqR
	0fyhjwWFvAJr7M3i50dub4+s/M7pUhzBbJOdQor/hbuyMx6/0Xkki9o+WlPNbWE5cJ5fEm0qT3zcM
	25+2qPH1ILNuwToXGzH5EENZF1kJDjWRKt6yJiBbDDk+W/SUar1084Cz5gPX//x+uQNNP7Gjl9jNB
	xdkAwJ0SeAJy2d4MfdTq18D5cm1aaWazSeOlf56ixma4/4ycVFqwzxxZbItMUdiSJQ5I+WlMv87rJ
	/nKecPObH/KvbSp7dA55TcS81fr9HF6SgKzE9QS9m4565Rhjrc+RESxhnArTjSdL8iHObStMpu4ww
	s56JGEgQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wghvL-001OeM-2u;
	Mon, 06 Jul 2026 11:55:45 +0000
Date: Mon, 6 Jul 2026 04:55:35 -0700
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/8] netconsole: stop charging netpoll users
 for netconsole-only data
Message-ID: <akuUkNgyjVOTHMuz@gmail.com>
References: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
X-Debian-User: leitao

On Thu, Jul 02, 2026 at 05:19:44AM -0700, Breno Leitao wrote:
> This work continue to untangle netconsole and netpoll, improving
> memory usage for netpoll users that are not netconsole.

Quick follow up on the sashiko findings. most of them are assuming that
netconsole_write is called locklelly, which is not the case, except
on panic (CON_NBCON_ATOMIC_UNSAFE). 


There are in order as they appear in
https://sashiko.dev/#/patchset/20260702-netconsole_move_more-v2-0-1ebedd921dcb%40debian.org

Tl;DR: There are two pre-existing issue that I will get fixed, but
I don't think they are blockers for this series (IMO).

Details of the findings and analyzes:

1) This isn't a bug introduced by this patch, but is it safe to modify
   target_list using standard list primitives while netconsole_write()
   iterates over it locklessly?

netconsole_write() is never called without the lock, unless on
emergency, which is known to be unsafe (CON_NBCON_ATOMIC_UNSAFE).

Sashiko doesn't undersatnd that nbcon .device_lock
(netconsole_device_lock), is called before netconsole_write

2) This is a pre-existing issue, but I noticed a potential race
   condition between netdevice events and configfs rmdir that skips
   cleanup. If netconsole_netdev_event() processes NETDEV_RELEASE or
   NETDEV_JOIN, it sets nt->state = STATE_DISABLED and moves the target
   to target_cleanup_list:

This is a pre-existing issue, and I am happy to fix in here or as
a follow-up


3) This isn't a bug introduced by this patch, but I found a potential
   lockless iteration race in netconsole_write() in this file.

Again, netconsole_write() is not called locklelssly. 


4) This is a pre-existing issue, but does lockless iteration of
   target_list in netconsole_write() race with non-RCU list
   modifications?

Same as above.

5) This is a pre-existing issue, but is there a race condition between
   interface disablement and configfs removal that skips cleanup?

This is a pre-existing issue, and I am happy to fix in here or as
a follow-up.

6) This is a pre-existing issue, but does skb_dequeue() acquire
   a spinlock_t in NMI contexts?

netconsole is not used on NMI contexts, unless on emergency
(CON_NBCON_ATOMIC_UNSAFE).

7) When netconsole_write() is called as an atomic console callback, it
   iterates target_list locklessly. Concurrently, if a privileged user
   removes the target via configfs:

netconsole_write() is only called on atomic context on emergencies.
There is no conflict with configfs.

8) This isn't a bug introduced by this patch, but could the lockless
   iteration of target_list in netconsole_write() race with list
   removal? In drivers/net/netconsole.c:netconsole_write():

Same as above, netconsole_write() are not called locklessly except on
ops.

