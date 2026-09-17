Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9C4FC8E5;
	Thu, 17 Sep 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648198; cv=none; b=lPmT3WG29JphU3QDwyfBLN/TCdvvHi2lb+xgAp9rMUXEgk7wWeoDcFKBdBwT/90asImIutxPzuamwxsMl/2YVuRh9p60BVCUs8YmFL25vDIOCJ8BpryXnvSxF+oLLMNhQgyLZ6tbj+4+KI0ww0rY3XyEtebyPqeRe/Wmu/Q7Pnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648198; c=relaxed/simple;
	bh=hE4YXXq9f/kz4Pqfu90t6YgBCb4aMDtxvj+Ig7ZfgOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jow+quWj47L4p/UwoRglY26zRZy6Se8v/GIcrJPIIfhuBPKsRTGCR6XVK3GZQ1mJLhnRUbl2OuxSuIqh7kJWqETGXWILd6UONod90AjGyf/Tdb258PzwpTZxPGo36MLfmp9gvKaxBl8sgMV8/d+2DSRrCHfqj0x6lLGyQe+6eRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=Nn3/gwWe; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="Nn3/gwWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1789648177; bh=hE4YXXq9f/kz4Pqfu90t6YgBCb4aMDtxvj+Ig7ZfgOY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Nn3/gwWemPcdz6OqIU+M4WARBgHgjNI8+RMG204vZBoH/x5d/b5UgnOGS/ag0RgZ6
	 xDYSgDbAS0vjfGyb216frHmT8j5+L/5Ag1Xkd/OUY6LQOzdvsqh4z5NyfHHkICoKNj
	 RFPzGSn2Mc2WpdlpBiRv/diuVpmoZ9znEk1lbNDJJFRSAPEiiwyTladJbgQMFYxxfA
	 MFiV8z2ZkK0jzDLrfDnpP1+kUO619KC1YXezfPJHjBjhc37+hWX47xoTXgngSBODAM
	 HfeYlkTf/PJ8Hh1pyuSCa/6VQwyfS2RUrdZ5ANVA1+6sjLXkz384DRtvLMKqnmiUz4
	 tWcV19FkbgOmQ==
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6aabdd31-6dc7-7f0000032729-7f000001b6c2-1
	for <multiple-recipients>; Thu, 17 Sep 2026 14:29:37 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 14:29:37 +0200 (CEST)
Message-ID: <d17cbd3e-d373-452c-9a7d-dd6d5a413565@fritz.com>
Date: Thu, 17 Sep 2026 14:29:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/1] macvlan: allow source mode devices along with
 passthru
To: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260917100258.2582568-1-t.martitz@fritz.com>
Content-Language: de-DE
From: Thomas Martitz <t.martitz@fritz.com>
In-Reply-To: <20260917100258.2582568-1-t.martitz@fritz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate-ID: 149429::1789648177-014BE0BC-FC2C784A/0/0
X-purgate-type: clean
X-purgate-size: 3232
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-03  mail-id: 8B5ACA0422  external: no

Hello,

Apologize for forgetting a changelog entry. I'm adding it inline and hopefully don't
forget include it in the next posting (if any).

BTW: I'll be attending at LPC in Prague. Would be great to have a chat with your guys there.

Am 17.09.26 um 12:02 schrieb Thomas Martitz:
> Hello,
> 
> we're trying to solve a use case on our devices where two SoC are
> connected on the same board, using the only available high-speed interface.
> 
> One SoC runs the main Linux system including the full routing stack
> (FRITZ!OS) and the other SoC implements most of the GPON ONT side.
> 
> The high-speed interface is of course also used for the user traffic.
> Therefore we must tell the inter-SoC traffic apart from the user traffic.
> 
> We achieve this by matching the well-known MAC address of the ONT SoC.
> The user traffic passes through the ONT SoC without modifying MAC headers.
> Now we would like to use macvlan (with source mode devices) on the main
> SoC side for this but our routing stack requires the rx_handler to be
> available. Therefore macvlan is currently not an option.
> 
> With this patch macvlan becomes an option because the current limitation
> of either "one passthru device" or "any other configuration" is relaxed
> for the combination of passthru and any number of source mode devices.
> 
> This allows us to configure a source mode device for the other SoC and
> register an rx_handler for further processing on the passthru device.
> 
> Thanks in advance!
> 
---
Changes in v5
- Properly respect "macvlan_addr_busy()" again for non-passthru  interfaces (and avoid calling anymore for passthru interfaces)
- Guard NETDEV_CHANGEADDR from messing with the lower device
  address during passthru interface removal
- restore unicast address (dev_add_uc/_del_uc) handling> Changes in v4
> - Prevent macvlan_restore_mac() from changing the MAC address
>   of remaining source mode interfaces.
> - Set MACVLAN_F_PASSTHRU on the macvlan_port only after adding
>   the passthru interface truly succeeds.
> - Changing existing interfaces to passthru mode shouldn't become
>   allowed.
> 
> Changes in v3
> - fix passthru port removal caused by passing the wrong 
>   device to macvlan_port_release_mac(). This was also
>   detected by syzbot.
> - macvlan_port_release_mac() is now named macvlan_restore_mac()
>   and gets passed a "struct macvlan_port" directly.
> - Link to v2: https://lore.kernel.org/netdev/20260709100512.1383421-1-t.martitz@fritz.com/
> 
> Changes in v2:
> - changed several port-wide checks (macvlan_passthru()) to 
>   per-interface checks (vlan->mode == vlan->mode == MACVLAN_MODE_PASSTHRU)
> - correctly handle removing the passthru interface when there are still
>   source interfaces
> - Link to initial posting: https://lore.kernel.org/netdev/20260612092345.2352255-1-t.martitz@fritz.com/
> ---
> 
> Thomas Martitz (1):
>   macvlan: allow source mode devices along with passthru
> 
>  drivers/net/macvlan.c | 107 ++++++++++++++++++++++++++++--------------
>  1 file changed, 73 insertions(+), 34 deletions(-)
> 

Best regards

-- 
Thomas Martitz <t.martitz@fritz.com>
FRITZ! Technology GmbH, Berlin (Germany)
