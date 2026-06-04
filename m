Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F703DB628
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562207; cv=none; b=QljFwCBLz4G6mD89se8XSzmAYSfOeXb/XaJQR0IUi0wXxUXDHyUjVnRPWuB36HRlgfVLQ9mLmWvHdoFMwqyU5g/YI5QleVGiTxPTKQbe0xefcVOGZVA+8LgmTrleSYBHB4RC1hyhq72jPGfj5Z36mLW2NnXSdTjX20D+uvmi3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562207; c=relaxed/simple;
	bh=CBt6CTRoYgZmxlwS+t5leQNFWHs1ywfzHiZcS4OB+5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GivkHVlMMRkXBw1aciFUmsS4NsBXMqYx+8qAXwpB7y704MiFdD4b/UDXdQvTb+BZqxHN8PasWXH1WMtH6jej78V6sNTvL1Rte1a0+d1RNEl+kbEUhN6ZTn6yBG/93fVvDeuRWUl86lO+F7Wq42M50tnB6WBCeZQjtvwSzZJrv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdTIlNMi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdTIlNMi"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b09e4cccso3267425e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780562204; x=1781167004; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CBt6CTRoYgZmxlwS+t5leQNFWHs1ywfzHiZcS4OB+5Y=;
        b=JdTIlNMi+MrcnbupB6cCr0oPBDYQsS1uLf0N6CisDsCYdzA3fbkANPXAYTQiH0OeYu
         Kz9m36MSnvbKLCoGoATVixUPi7hQnnWVGG5Dn18kOaC7Vcnno47kXMAw5AxIGCmqUh8+
         WG28TbVtveol7gwAbQ8dG/EM58IUNn2cpF3iqSYhOVwyhpvfuufjWRVlAnTzJCAKLU1e
         RvFnBBOlbdNS5JICExs6yHluVaymPawHbYV4Ly/QvKwpF35hqSnOK2ONwfQkfpj6UXeQ
         8LaxK30PEiM8odjBdr7oi7GM5I+fgyYRq9X5NgjVbgDuETvXJsZPJl/zx15wZCF7Vu7g
         oxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562204; x=1781167004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBt6CTRoYgZmxlwS+t5leQNFWHs1ywfzHiZcS4OB+5Y=;
        b=OTZFvvG6S6KK1UzKn86zWT6W5HuVspdX3SzImkURkbyaHVAZRk37DXJFupTsdQrT+q
         ZRTvv+pF9AKOnSsjpOr7V2IJ661AkH2gBfUjS4snCbMbmM6w1oNkrJtVmVvKM7Pap5Cq
         BEkwXb+rP90C6krSGyD/eiZa4EL1Xk9+Hx0zTKHhwp+ZcdWvT1l3MYJHL5fKEQ6TJM48
         1rSjPOQVhpS7zAit18ewvvkzGcqlCqNQsyWlL0mJ0JWnVZ5U8CSqgqIVQUATxDLA2wQ5
         g9fwJ8GbehjYDCaoies9EhMCXteJlNb0h7UB192JCg48k+erumWTG8Jh+6fChZouzK28
         3NIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8O5awkeeQdR8h9Q3aN1aFkvRS8GMr542z57kDZXBCLeS/R9l7nNMy0RFE7fy4FMO7j1ARn3d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcIh1GdVF9V0PqnYeB6b5Gekl/7mWcYE4RKDkX7KB19QRU55Lj
	JNZhEQzKVDGptlVNe60DyYK4KoOfds1iskf1s/GVrHrzNPw1BdrAYPFI
X-Gm-Gg: Acq92OEQmnSqMshzNi8ELA3QQ68tFr5iJ9loKOAh4KAZ7o7RMPLnwf0JXgxEt75Jlof
	9BxHIBNIxlrI87TIWhbwgMKmJRWqeM63zk0om5W0Z0GVcAn6Umdwdj/qXYcamhv1tm1ZgxjeA2o
	cMeloU4rQwHxlSxVV6t8Yh74OFmQ5cltqherNqaYFxmSArqWYXW7I28htZgoM+AL0pBkhHVWSYX
	eBvA5FlD0N3d1VCxCcBMdMv9C1zyurk5zGMl5UVNNmqgoDj81jy/JwUJkGXVNft9eMl1Foe+//4
	PVx0EehJWcjsO28vayq3iORvbv7SgVCJFbuCHJsSd/VnMNckrodTEbaOsf1L6ZSyLt7bln2v3fq
	yGfffZvqq5OLQsr03SjM/qvyyXrQCchOVjuEO8gdjI5q4OaAsDPz1UY6UJ6iOhkOzQ7/sro3qru
	iivYcC7YsbDrK+I/w8xP+y/8CFtdgRc1keXFcb6Efdn+8UBqcuTvsoJ0bwjBJM8cOmnega2BmSE
	QRytKz1CmnQACRIiLQCOiACZTgADVJmqpr19kgWi1O2ALI=
X-Received: by 2002:a05:600c:8184:b0:490:b3f1:e41b with SMTP id 5b1f17b1804b1-490b60e20b2mr104501265e9.26.1780562204213;
        Thu, 04 Jun 2026 01:36:44 -0700 (PDT)
Received: from cedric-laptop (2a02-1810-cd14-9200-6809-bbad-785c-8e80.ip6.access.telenet.be. [2a02:1810:cd14:9200:6809:bbad:785c:8e80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm61056715e9.3.2026.06.04.01.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:36:43 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:36:32 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
Message-ID: <iwlidn7t36oax3t3y6o5jr3bfm24t3uw4g2toqam3izkmafnxy@sphgjtjrkqg2>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <808529B1-E40A-4E54-A654-86F1B6D1FA66@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <808529B1-E40A-4E54-A654-86F1B6D1FA66@padl.com>

O Thu, Jun 04, 2026 at 07:36:07AM +1000, Luke Howard wrote:
> I realise I misunderstood you: this is about exposing the 6390’s egress FPri to PCP mapping via DSA/DCB rewrite? That’s really cool, and orthogonal to MQPRIO; apologies for my confusion.

No, it's about configuring the ingress pcp to QPri mappings.
The patch has been submitted to the mailing list:
https://lore.kernel.org/netdev/20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be/

Cedric
