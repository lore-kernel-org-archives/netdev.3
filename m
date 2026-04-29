Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698D199D8
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421651; cv=none; b=J1zF+gxzy6CmTxCzxxkANVAWka1Ls1dz7pw7jW+h5gNrAa+REQMUglVIDS/Ub/T7ghzPMpfdPR3I+GDw7QpNYjv7/U5z8UVGiYBUs6fD5ap2XeCbbK4AZCU29sI+FHriBDvQWob8gEygHSjyvMYB7g37a+Y7a7/EjKdzoCc5Slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421651; c=relaxed/simple;
	bh=9fzFgwV3aBoRbhtgsfEan8Kws0jWx89MBtlw4TMZIPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WnnV5y+rsdsO4cxgj8hMBXXQK1BMk0RXyFdLoSsNoDVtM7EsCdEjhh/3iTcGdd3b/r1icPDitpLJdAEW+ZZTjHo30mhev009kmodxtQRIpunRBzYSdNZ0IRR48nqo+pheJqJFOMK2S31Me+kMqeAlL0SpZytNiw9NuVlXhbHQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4JHBp1l; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4JHBp1l"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7973e22399so4743657a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777421649; x=1778026449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBrlzsQ3SPS9MDqc3/b/n/nv8z/Nq6uXbkMYi4POkNg=;
        b=U4JHBp1lnSrqZHhiI29KdxPPX/M5y8xI85JMEBEH+iGJRhC5LSo5sLW2f/mydxiVE1
         GkC5bbpIDXDlbfzxGKrryKGmM/4m9KCVYziQHJLIeIJr3N5G849zflUJcKSv7W/Pm0t/
         LYYGfrbAohf9onpXWxANnDV4e/ph/VSldj9A1Qld4qQ5mfjuS2f6FTJfHY/w319TT99L
         lrnR4CGLv0r/uAFV3Ywkf+0VlR5Je5ziHIPypYIa5nzXW5Tv9i4bjY35TYHf30VUdCjl
         0CBi8wUb3zCTSajWcxVf3hhvv3SveZ7Xwl/kK9+nGOmEHDc0xw/GR5BRvoO/wYEa/hei
         IVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777421649; x=1778026449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBrlzsQ3SPS9MDqc3/b/n/nv8z/Nq6uXbkMYi4POkNg=;
        b=Ujy+lS8ibnePXEonkKQEx0hsJEPikfscgaG28Lt8/9vD3EBvzpy7hSyqoMev+KTWBt
         rtImHrIPsTeQceHbdnPdA+ebPn2IuQMvtLm9DroFtYCPV18KWiR+Jry09o+zDLOrtYep
         66471DBKSqSDqyZnIUiZyjqKB2rdeJZx9t9g31gMs6Gcc6U27wn7aSKQjd7+lG1k8o6x
         rG+YbQgMqX1VTLcIbGyzKfwMuZMVSHnrC3tsH/pEBSSQZCLy4PNucN1kGDuYGlhjSsi7
         RFulB2zzTGvP1kL+S+PwlEkY+rcxm5sX3Oa/wWe4Wlw02gNfhkRr5C6cRVrBh6y5USMf
         BqKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UEXaWzVacXRXwNmh9L/MOGGF0tWymwZ7jjtByyDtEls4WiLJ5JQmTVRIVRPOrBoufX0JzpmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWmnD7lrFs3EoxJmIOqs2zo9ujc+HZqqVBqsq8o6VEYCI9bo/4
	+I+9HrT1hbOPptkptuykWBTA1RkulSn5PKwb3OfYkvbObxRxDdBil1pmmlcqiH2aYfyqqWva1x9
	ddsi3jA==
X-Received: from pgbcp13.prod.google.com ([2002:a05:6a02:400d:b0:c76:9b3f:5a8e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431e:b0:3a2:bd1d:d68d
 with SMTP id adf61e73a8af0-3a39c255a99mr6163350637.32.1777421649042; Tue, 28
 Apr 2026 17:14:09 -0700 (PDT)
Date: Wed, 29 Apr 2026 00:13:22 +0000
In-Reply-To: <20260428160445.1336649-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428160445.1336649-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429001407.3358732-1-kuniyu@google.com>
Subject: Re: [PATCH net] bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch, bestswngs@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, martin.varghese@nokia.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, willemb@google.com, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"

From: Simon Horman <horms@kernel.org>
Date: Tue, 28 Apr 2026 17:04:46 +0100
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()
> 
> This commit fixes a NULL pointer dereference in bareudp_fill_metadata_dst()
> by adding a check for the socket in the IPv6 path. If the device is down
> and the socket is NULL, it now returns -ESHUTDOWN.
> 
> > Add a NULL check returning -ESHUTDOWN, consistent with the xmit paths
> > in the same driver.
> 
> Does the IPv4 path also need to be updated to remain consistent?

No, because udp_tunnel_dst_lookup() does not take struct
sock while udp_tunnel6_dst_lookup() does.

And all the other fast paths (bareudp_xmit_skb() and
bareudp6_xmit_skb()) have NULL checks properly.


> 
> While the IPv4 path lookup doesn't use the socket pointer directly, if the
> socket is NULL (meaning the device is down), shouldn't the IPv4 path also
> return -ESHUTDOWN instead of successfully performing a route lookup?
> 
> > diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
> > index 0df3208783ad..da5866ba0699 100644
> > --- a/drivers/net/bareudp.c
> > +++ b/drivers/net/bareudp.c
> > @@ -529,6 +529,9 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
> 
> Is it possible for an IPv6 tunnel key to be incorrectly processed as IPv4
> earlier in this function?

I think this is orthogonal to this patch and can be a follow-up.

I have a series to remove all synchronize_rcu() from all UDP tunnel
users and udp_tunnel_sock_release(), but it conflict with this patch,
so I hope this land net-next this Thursday :)


> 
> Looking at the preceding condition in this function:
> 
>     if (!ipv6_mod_enabled() || ip_tunnel_info_af(info) == AF_INET) {
>         struct rtable *rt;
>         ...
>         info->key.u.ipv4.src = saddr;
>     }
> 
> If the IPv6 module is disabled at runtime, but an IPv6 tunnel key is provided
> (e.g., via OVS or TC), the code falls back to the IPv4 branch.
> 
> Since key->u.ipv4.dst aliases exactly with bytes 4-7 of key->u.ipv6.src due
> to the union layout in struct ip_tunnel_key, could this result in an invalid
> IPv4 route lookup using portions of the IPv6 source address?
> 
> Would it be safer to explicitly reject IPv6 tunnel keys when the IPv6 module
> is disabled?
