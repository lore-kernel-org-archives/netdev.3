Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75E1643B
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784596382; cv=none; b=REfkE2VMWCgVH0renRNRxV4wtxFZibGlqcnZOy1bFF2mkmxFmwZJv8SOX8TXxn5oyY6W/sOpnnag84mXNDzVxkcp/feaMgMLZhgi+37dz8BL+Q1n3uUTdOzWTiq/s65o5fCR/ju5STT5Q+OkrFnnZ8FDlK3DuVlDpgBpHC5hAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784596382; c=relaxed/simple;
	bh=F6pW3Ewmar7TsFTg9YYa0oV4uHuWQ+Z9NmROLb2SWq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EB9VKQHTcw89FRogrX7DDklqSQmv/kM42WWKZM5yJM5CP5t2/fRF21nos53bbfJtIMIYuAM40y/IBaEFRmWX2QQ0t75srtof5DawqVmDNa3y/PvW1ow4rSlbdavtvDTHqyvREWD5lz+/42rwbyMGBSUvV86EI0qEL1U8lBRmVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmEsxL1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmEsxL1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602011F000E9;
	Tue, 21 Jul 2026 01:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784596381;
	bh=LEdcsynDvv+UXK5WXaHCz3Ub7Hn/CbWK3Qd8EHqb8Hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mmEsxL1sd0icUrbL8o2qiGSYQgFNtYQYd4nZf0WM+IPBMbynPyGgtxLsF4h0XGTIz
	 1w6LZT6/Zpt11822xGWqNCpVDgdjMWsLGnjLYixyYo99ULojuCOa+CucE8lBzPXO74
	 xkjLwzsBdopsJsdrxjoTUtSJ0+FzN5K9qWQ7u06LIqsHZ7NVW8Q9lb7jMUjQrwE7P9
	 LcqPE1OXGdYHWVWkre5qaPQa1NwTz8ISQxQJ0U0DPN+UDjBjEZK2jHH9CBiTvbrM74
	 8huCpcwz1FelPWsCK7kckyaez3uvSUnC8YcvTXxocM1YtUhtB9AQjaJAMqqmEUDDSa
	 EMCQPzsey4rfw==
Date: Mon, 20 Jul 2026 18:12:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+456957213f32970c0762@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: hsr: fix memory leak on slave unregistration
 by removing synced VLANs
Message-ID: <20260720181259.4e5f976f@kernel.org>
In-Reply-To: <178406192459.16306.5204629050926533917.b4-review@b4>
References: <20260707082327.3238690-1-edumazet@google.com>
	<178406192459.16306.5204629050926533917.b4-review@b4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 22:45:24 +0200 Fernando Fernandez Mancera wrote:
> > When an HSR master device is brought UP, it auto-adds VLAN 0 via
> > vlan_vid0_add(), which propagates VID 0 to its slave devices.
> > 
> > If a slave device is later unregistered while HSR is active (e.g., during
> > netns cleanup or interface destruction), hsr_del_port() is called to
> > detach the slave port from the HSR master. However, hsr_del_port() currently
> > does not delete the VLAN IDs that were synced to the slave device by HSR.
> > 
> > As a result, the slave device retains a refcount on VID 0 (and any other
> > synced VLANs). When the slave device is destroyed, its vlan_info /
> > vlan_vid_info structure remains allocated, leading to a memory leak.
> > 
> > Fix this by calling vlan_vids_del_by_dev(port->dev, master->dev) in
> > hsr_del_port() before unlinking the slave device, matching the cleanup
> > behavior in bonding and team drivers.
> > 
> > Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
> > Reported-by: syzbot+456957213f32970c0762@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6a4cb6ca.57639fcc.86d58.000b.GAE@google.com/T/#u
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Just to confirm - is the sashiko review a false positive?
https://sashiko.dev/#/patchset/20260707082327.3238690-1-edumazet%40google.com
