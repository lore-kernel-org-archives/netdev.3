Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF12C11E2
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847463; cv=none; b=qXe093Cl97lHyKebFIfenE5faFY9nWaZ1Qmrb8RbsoBhPlm4iCHgUXV9rCgTPpc5jrkul067er0Yp14eJFRutagLJOaj3JI0qgyh8Jfpm/ZSGBsdAnhNoJE0+SgN7y88KysQXxJEoiJ9T7741x5EXRhhsQ8KybqQUKSmxlMX7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847463; c=relaxed/simple;
	bh=9ygC3ApjsClHN3F8iOri1ieGPbycbgI4m3RKD2BIDB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s11roCDoUtCxZpoFVgQOEu73hisvgYCcZuf7Vrwwp+2hZkxrdg9pzGiv6gf5nI2JBNZ1eERi4opwSDcApju20w3Y9ixZ89VuVS5GTG9AH/b3qjxSi7Oo1WgGR1ySuIGi0iOaaowI3q6F+Vs0IA5LOGoq1GlrYDBFt8p7NszPeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRqD4EXZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRqD4EXZ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495502852d1so1332115e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784847460; x=1785452260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ga5q/gDe3noE1zvv1qzIbxX9qih9+DEY4gSM50nlE0I=;
        b=LRqD4EXZ1QcuOUZk+DVqtE+Ptk22/PL/TJBEHlN5JRpTNyJ8AFqVAwx3wxDcRmkd7F
         td5nJ9cRqiZaRpiLKsVjzMddIDFCMSM9gCUm9FuLq1Xt5hlVWBoWYa8sP/5DH0oxP0Lv
         d7+7g5BALn3ROyMQbWEdFfnCu17qX6RIlZs5wk/aB7xBWbFtgXwMiZD3BrprQ+qF6Mkp
         FW3VXCaRznao1qQGjbuvZKp1x/xRqHFYyCXK0zELJFSRbtvt7m3hqCoh3VTDRm8Mx0EN
         pHa2bObzxjIZuRVJzDyC/2V4c7oF7kg32jdsaGsgu+zvs0VMwltEcU1+Jyw3Ma5XJiWG
         igSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784847460; x=1785452260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ga5q/gDe3noE1zvv1qzIbxX9qih9+DEY4gSM50nlE0I=;
        b=ghn4TgYc/SYnQwE284I+N5fU0Pe0Qf6MKaOTwd7CJ/Hbin/xNa92KPfCxcYaeT5DHo
         KZEN0h6exGPRz58sRK3L0h9tqtLPrm+BdjJcOyp3TQgxZ+OkzwLwXkhrAWGNgiPBKvD5
         zawfOgUUH53axyXeGAYkMqtED4oFh3g/Amf5K7KCi4X41TLVExXBtcb6gKH6P+JERsOd
         7q4qJm27/Q3hY9sWev8ZR0YS7z/2QOHiWxxI8ZDdB+JFhj6IaJh+2z9uQGPj05l3C3OX
         srU22eBP/4tfigRozO36qgzD7WcsWCCm2ZDkKkDhCyYGcAIEJu3JjpN5yELEmMC2h3f8
         bhMg==
X-Forwarded-Encrypted: i=1; AHgh+RrSv58/0n1dsVEJhPpRADZofXtqrofKQHsdgVljbLAkCDwWBTdNoJl4iSKO+Rn8OEGSOvIKcic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAy/df5HrWJIJ0Xwr6sSIP6JrNz9LlptMighqrupMZhARixupY
	SWuffOeKB/8+EwQxveOtVK9k+B+Je0e+Dkju38iw5o2Oq8BT/LqaZNUsIXmrnQ==
X-Gm-Gg: AR+sD13cf2qBEAtmwpQV4BEkixF6NpDS7Jqo/pk/NZg6rcjPejCf9kDle98ViLCHfvE
	GbGIl2XeRBw9TrHeY3LGKrYXkVbQNtDFM2qoAQn3gUrXWxArheyfZKcnQ4PdNGfqi6jt0U7WBJr
	K0lo6VauzhOEVTC3PWP3QgIplAFhZpdiovqlwyZhgp82yrmRFd9qfW4BVtfFLBqNalGsFw5g1kV
	zauUK2kVN+w98UizSPfxfLSTEeqW6PQ1UBqP1txv2a5wVT/hvW2ha2/ys6Xw4qUlpm9r8Mp/XiQ
	/lzRZfamVvSZzHobmaJoNqFrMrHbqd4FirJw7UP7f6JW6QVGxLZySFvlAwbzZdw8xBircTSp/w8
	AK3jlIdwTGdFU4Cnzes9C9jcck07z4C4hKIW17qyuh+8Mrqs7Nlcf6aRY8X+sQg4XbSHg
X-Received: by 2002:a05:600c:4685:b0:493:f42e:1b3f with SMTP id 5b1f17b1804b1-4957ac0c193mr12294545e9.3.1784847460405;
        Thu, 23 Jul 2026 15:57:40 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d801:b100:9055:4669:600a:7f4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af6adbbsm24689205e9.6.2026.07.23.15.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:57:39 -0700 (PDT)
Date: Fri, 24 Jul 2026 01:57:35 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: unsync host addresses when destroying
 user port
Message-ID: <20260723225735.b7muegd4dlc6wsxz@skbuf>
References: <34a027de7d860796d37de2f2108337eb82110144.1784679091.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34a027de7d860796d37de2f2108337eb82110144.1784679091.git.daniel@makrotopia.org>

On Wed, Jul 22, 2026 at 01:12:47AM +0100, Daniel Golle wrote:
> When a user port is destroyed while addresses are still synced to it,
> e.g. multicast addresses synced by a bridge the port is a member of,
> the host FDB/MDB entries these addresses installed on the CPU port are
> never removed: the only removal path is dsa_user_unsync_uc()/_mc() via
> ndo_set_rx_mode, and __dev_set_rx_mode() does not call the ndo on a
> device which is down. By the time the bridge unsyncs its addresses in
> del_nbp() during unregistration, the netdev has already been closed,
> so the unsync never reaches DSA and the entries linger until
> dsa_switch_release_ports() reports them:
> 
>   Cleaning up multicast address 33:33:00:00:00:01 vid 0 from port 9
> 
> This happens on every unbind of a DSA driver supporting host address
> filtering while its ports are up.
> 
> Unsync the host addresses in dsa_user_destroy() before unregistering
> the netdev, at a point where the driver can still process the
> deletion, just like dsa_user_change_conduit() already does when
> migrating host addresses to a new conduit.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  net/dsa/user.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 03c7af6abe18..a7dabb645036 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -2885,6 +2885,7 @@ void dsa_user_destroy(struct net_device *user_dev)
>  
>  	netif_carrier_off(user_dev);
>  	rtnl_lock();
> +	dsa_user_unsync_ha(user_dev);
>  	netdev_upper_dev_unlink(conduit, user_dev);
>  	unregister_netdevice(user_dev);
>  	phylink_disconnect_phy(dp->pl);
> -- 
> 2.55.0

Sorry, I noticed this patch late. Something doesn't add up - I don't
understand what makes the unregistration path unique, since according to
all you've said, it should be enough to remove the user port from the
bridge while administratively down, and it should lead to the same
effect (no unsync event triggered). In that case, maybe the
dsa_user_unsync_ha() belongs somewhere in dsa_user_close(), near
dsa_user_host_uc_uninstall().

I will return tomorrow with more comments after I do some testing.
