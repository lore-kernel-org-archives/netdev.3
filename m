Received: from mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5A3DB625
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169496; cv=none; b=SVuAvcF8NZ4Txpp/9vQ9fii0EG31WMLjh/5MLTXxMIB6pb0NL7Sl1lMtmu5OCMu2+sJcD1c8eqpApwcv07Ce5CoaKbGlabWtrt+nh8oPNZNZFzg+6AFE9fKvVpKNlkJF9Zh6A0P98nwBBs/gdHc1nZmduatjmQ7u+k5R7pHiTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169496; c=relaxed/simple;
	bh=uoYBUZYR6JvZduOaIOw7eJyGX1mknOaAZIg8QjZQDBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIQzlT8dKjtW0lNC3iMtnmcrBo9oviGVdGscv98jaz5RAxIvjsDZNrp2WroAkYNwJYrsdM3r7zB4a2ZOC+HkZAGHOJAhPd03zMNJszw32cC61K9EM4MWC0YjJ8J/wDIt45L5p5/MMr7u8g8l/1c4p3WwGNxobL1pU6WYMEI0V60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bAH+Fg6Z; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bAH+Fg6Z"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uoYBUZYR6JvZduOaIOw7eJyGX1mknOaAZIg8QjZQDBY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788169493; v=1; x=1788774293;
 b=bAH+Fg6ZO1d1HMYGQDMd4osrXXEP4AwyMn199wvemjd2F3IEuuw3WmVlhUmpH8z1q6gOahz/
 3AO9ySn0XPHwqp3NZvBXqznUpWtO1Ec7MfsbVIUFlrrNeoCB2gakGpdgqdd+CQi3AH1VbR/5TBX
 L6T0NVLSLhhOo7B5vVIFeL1Y=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id daff03af7750e607;
	Mon, 31 Aug 2026 09:44:53 +0000
X-Mizu-Trace-ID: daff03af7750e607
X-Migadu-Flow: FLOW_OUT
Date: Mon, 31 Aug 2026 17:44:46 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Jay Vosburgh <jv@jvosburgh.net>
Subject: Re: [PATCH net] net: bonding: annotate lockless writes with
 WRITE_ONCE()
Message-ID: <apVNDttw4HSn3cEg@fedora>
References: <20260831081027.3209554-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831081027.3209554-1-edumazet@google.com>

On Mon, Aug 31, 2026 at 08:10:27AM +0000, Eric Dumazet wrote:
> Several fields in bonding are read locklessly using READ_ONCE()
> (or ACCESS_ONCE() previously) but have corresponding writes that
> do not use WRITE_ONCE().
> 
> Add WRITE_ONCE() annotations to:
> - bond->send_peer_notif decrements in bond_peer_notify_may_events()
>   and reset in bond_close().
> - bond->slave_cnt increments and decrements in bond_enslave() and
>   __bond_release_one().
> - bond->recv_probe updates in bond_open(), bond_option_arp_interval_set()
>   and rlb_initialize().
> - slaves->count decrement in bond_skip_slave().
> 
> Fixes: 4d97480b1806 ("bonding: use local function pointer of bond->recv_probe in bond_handle_frame")
> Fixes: 9a72c2da690d ("bonding: fix div by zero while enslaving and transmitting")
> Fixes: ee6377147409 ("bonding: Simplify the xmit function for modes that use xmit_hash")
> Fixes: 429208aab9db ("net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jay Vosburgh <jv@jvosburgh.net>

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
