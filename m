Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324358;
	b=V7GxF3tiJJk98l+0HRy4x6dPeW9u8eB/JwxiKZfwVrEfGh5jSXz7NhLjFMFQOfS3cD6s
	 c59zCYR/WJsxQ1/BVOkLvcmcfdeRVxxyK57XOSCTE4OU36KLeFvJUe75OxizopwGnsHiB
	 hNTKZzk/9+WoV2r0fVPZucJT6i9HbUQ64BeWfuB6UNPtxwCBswN7hdkI5p28ynO5QBsXD
	 GDgfJR99Y/lvZYPA9pjV+Q/RDkh/YFtF4s9JDjQl8DjQixAuJ8X2AZ7B5w605RUliauSF
	 JP6kvtTO+up4K8bvrwoYMPnOJPERrpv3ZlLbbwt9jG4Wn4Nz6ymquYq0z886S5ZuiNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324358;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3ObznMGziWVDuDmi/B/e6r0qgBFqb2H9Q1tdiVz3lOo=;
	b=Yo9eCBh7Gme8UBkLZbgl1MF1iXWBsI4eNmrfDxlXIgp/pYtys5BmEsv3Pb9kxLdON8Ws
	 UlT+2hA3cPcAWg9GTPdlVSxd2W7wYR8aZmFc6v23F5zgV6JUhAOpSlEYMLI56DuEex2YM
	 XQXxMS5ACwWY482UQrhMRQqep8VlINBSvivo1KWpVK3Pdildpv60cHzrZ2YEMKTSi0MPd
	 6v9E0JGz/lMpg2OhcnaGwR1pCQ3DTb1bM8KVwoUcTzBqDZIsobuZG8VZTTIY/vkragfBC
	 AzywuTPVRcRKkJoNfA8bjOkiClUU4mKHSFk832Ek+BnWXYAPaK5JyZO6/FVnRfJzDsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KNOeGwIE;
	arc=none smtp.remote-ip=91.218.175.161
Received: from mta0.migadu.com (out-161.mta0.migadu.com [91.218.175.161])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E0606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 01:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B42E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KNOeGwIE
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uZpejHfck/NqAUU86XpmBLgJQN6Mm0beX22rzGtYcLA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793324353; v=1; x=1793929153;
 b=KNOeGwIEDhwO1zgbZKCWMh8iG3fLVrZPDwQua/3cHpHj1mPqHOufDcfGlSXDZa8j0wstR9fR
 1R+X9r7zWABj2IMaUKySPvEVQH38BCMyTGBZ7cZW5UkNNY1+dDD9gaWR/qufveY5y8GCwHpN0xY
 fmKpSc+6QnF+Yng8chte6tVY=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ca05b1684fac7163;
	Fri, 30 Oct 2026 01:39:13 +0000
X-Mizu-Trace-ID: ca05b1684fac7163
X-Migadu-Flow: FLOW_OUT
Date: Fri, 30 Oct 2026 09:39:00 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Timur Stukan <timur.stukan.linux@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
Message-ID: <auP1JledouywUMci@bogon>
References: <20261028104758.299129-1-timur.stukan.linux@gmail.com>
 <91955.1793289071@vermin>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91955.1793289071@vermin>

Hi Jay,
On Thu, Oct 29, 2026 at 10:51:11AM -0500, Jay Vosburgh wrote:
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >index 7019e5d8fdc8..9bafcddbb453 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> > 
> > 		case BOND_LINK_FAIL:
> >@@ -2919,6 +2935,12 @@ static void bond_mii_monitor(struct work_struct *work)
> > 
> > 		if (commit) {
> > 			bond_for_each_slave(bond, slave, iter) {
> >+				/* UP state is committed by bond_miimon_commit()
> >+				 * after the speed and duplex check, so that it
> >+				 * can still see the previous link state.
> >+				 */
> >+				if (slave->link_new_state == BOND_LINK_UP)
> >+					continue;
> > 				bond_commit_link_state(slave,
> > 						       BOND_SLAVE_NOTIFY_LATER);
> 
> 	Reading bond_commit_link_state(), for this call site, all it
> really does is slave->link = slave->link_new_state, when link_new_state
> != BOND_LINK_NOCHAGE.  The changes to ->should_notify_link only matter
> for the ARP monitor, so that part is effectively a no-op here.

+1

> 
> 	Therefore, I wonder if it would be cleaner overall to not do the
> bond_commit_link_state here at all, but instead keep what you've added
> in the BOND_LINK_UP part of bond_miimon_commit, and then add calls to
> bond_set_slave_link_state(slave, ..., BOND_SLAVE_NOTIFY_LATER) to the
> BOND_LINK_FAIL/BOND_LINK_BACK case to make the change stick.
> 
> 	A quick hack patch that I have not tested to hopefully
> illustrate what I mean:
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 756d79281ffc..5fb215fa85f6 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2877,6 +2877,8 @@ static void bond_miimon_commit(struct bonding *bond)
>  
>  		case BOND_LINK_FAIL:
>  		case BOND_LINK_BACK:
> +			bond_set_slave_link_state(slave, slave->link_new_state,
> +						  BOND_SLAVE_NOTIFY_LATER);

- bond_set_slave_link_state(slave, slave->link_new_state, BOND_SLAVE_NOTIFY_LATER)
  - bond_propose_link_state(slave, slave->link_new_state)
    - slave->link_new_state = slave->link_new_state

This looks like a no-op here.

Maybe just call bond_commit_link_state()?

The bond_set_slave_link_state() in bond_miimon_commit() seems also have this
issue.

Thanks
Hangbin
>  			slave_dbg(bond->dev, slave->dev, "link_new_state %d on slave\n",
>  				  slave->link_new_state);
>  			continue;
> @@ -2933,19 +2935,8 @@ static void bond_mii_monitor(struct work_struct *work)
>  			goto re_arm;
>  		}
>  
> -		if (commit) {
> -			bond_for_each_slave(bond, slave, iter) {
> -				/* UP state is committed by bond_miimon_commit()
> -				 * after the speed and duplex check, so that it
> -				 * can still see the previous link state.
> -				 */
> -				if (slave->link_new_state == BOND_LINK_UP)
> -					continue;
> -				bond_commit_link_state(slave,
> -						       BOND_SLAVE_NOTIFY_LATER);
> -			}
> +		if (commit)
>  			bond_miimon_commit(bond);
> -		}
>  
>  		if (bond->send_peer_notif)
>  			bond_peer_notify_may_events(bond, true);
> 
> 
> 	Thoughts?
> 
> 	-J
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net
