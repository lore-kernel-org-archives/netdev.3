Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D6446C1D
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083849; cv=none; b=iIjUB0otO0XH80KrO/BGT6yaCJ7xsmTC5CiRyePoytSGCb+Zy8W1FgZj+vH4j91cQTYhtx4RkpjNgJJeFlts2/aKi3wluv5H5bjWhbNuGVq5zJc9A6V5eFL92nbINsruh6M5Db54rgNDghZSzwLJ00nozuZI2wZK1B/1gUfyLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083849; c=relaxed/simple;
	bh=i1ilo8QilOmc2Gnl/ngYJRqUhFULTP8MDTnxYTfn29g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVP94sFlbkcQJcDZreznMlsgADW35jCsz/nzEMqdqfnHjUECeI+dKV59hbUh8tfkl4OEscp2g8rbIxLGkR6+FZmGM9hBO8YLekGMZhkFaNTvXn3xeHnKjUY4a8fAjlrokbB8J4aKm/dCV73e00heUSclWEGlDIRauB6+z96dHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhXnZbVq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhXnZbVq"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso3669724b3a.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786083847; x=1786688647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sfRf40BEjyVUNNMxy2qjhENyoGLHR+vMXovfwvx7xxM=;
        b=rhXnZbVq/Tv4qg4bmZfN1w49EhYGbnsB6id0uM4VBlYFk4wQX9LYJ5BXwsaX0ewut1
         8YfFq15o2mmotg8GgqY4kGIiQYAQrGRQER89I+zH3lHCZKjdxI77TRvUKfBjf6pd4MZd
         ZmMnd9IFiqWkYUV4L5cOvl/StMv7PzaPHqE2dRlN6bXU/szohCJX06vHWVwvrQDl18CC
         bc3/sklACNu4q4GEK54W69PugK9q+64hw2CjbGW9feoIyrdf2qSLi9wfTEPwcP12IGmQ
         3nc2Pl6f7bSS8AWy6hlJfn5WtSbIBU1ZyMJzmINXG/Y8pChwtbIHl8VQCRTn9+Px7iM2
         xukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786083847; x=1786688647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sfRf40BEjyVUNNMxy2qjhENyoGLHR+vMXovfwvx7xxM=;
        b=bZstCSKQ5p72fLDR42qPHYaD1dPy8Q7Fpt1gQI0Tg+we+Xul3ClaDOz/LkNTI8d9ON
         Ta+D0Gm3YGwZCTUrXQObZjmoGv5wGBau2xwxfFtLxHaGscrWgcwFzT3CAq3dWCg1QHFj
         IB+3pdjrXpv9AEczJ+f7y/djEBSwSY914PW9uBBtTq1lkBYlx7p6U3xsooLE6ry4doki
         MpTtdZrDEiNoe1jWWgYr+XhN/6P/qyS4SXF5D1tvCxv7Ocx7E8ytkGBUBS7bPU+scEgd
         rk0aR/nstJ/TU5AGZhvUhEPgeVQ4V39GGH8UsP+QnT4B8JDhr2+ZIlVTryc4tJO/Dhbi
         9SRw==
X-Forwarded-Encrypted: i=1; AHgh+RrHgvgal3FXcLzD5Ou3Bm0uNl3swHs/QIoDiUYyUEpp4Vpu0OWFUaRyg0cz64KDStedFeVrVio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTza8WkZWa5dAGFPxl7Yr9t9cG3wwySPnlTdsPEaFtK7lvs+ur
	hnkEASEDBeuVvy4Hv2nzG4E/iuheJSx9/IzEwtvcYJzaCpXwgtljraSbGwYEUg==
X-Gm-Gg: AR+sD12oG3X4+ip2tb0nPqVGB8YxLKzxOwQErXFKwpa9tQQpN7SvWowoKJhNzdSL+n5
	P9wX8dvDWWa9ckEFYNwjmtDBsSyX2TfbbZITKP+81h/wFD0wXNkr+U7HxT6OxTh7ksUvWTVCqHi
	zgZh6rHFW9b3DjqzMscMmK+iEqnJszn/wnRboaL8wE1jWEb21RaxXp1auOcmEosDs5R7wuPKb9V
	ttGxKmdngxpN/5pQI6n+Ni0us3rfDjMEwzcC90fi0zmObWtLqoyneO48k+U14lF3TIE4KWrKRXy
	FoMFrgVLhvk66lZ9zY2UJN1hG1mw4PCiwJgIaB+Td2gdzsadg7CZ5eHtEr7WY3tNMvmXg3KAMq9
	Q72+ZFpc0VPBpLDYWVrbFzRGGESFGd2qlXjuCgVQFdWh6eIaXlkeoENQ2PLcAjgUgGMrmsxcQ8G
	r6OxAI1eJxUrevFWpvmWd4/DX7UXrgISDGwtbdP5osZo2PMt4Y6cUQBks=
X-Received: by 2002:a05:6a20:2d13:b0:3b4:7b3d:179b with SMTP id adf61e73a8af0-3cb85dbc650mr25172213637.12.1786083846641;
        Thu, 06 Aug 2026 23:24:06 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f35bc75sm162585a12.19.2026.08.06.23.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:24:06 -0700 (PDT)
Date: Fri, 7 Aug 2026 14:23:58 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com, Tangxin Xie <xietangxin@h-partners.com>
Subject: Re: [PATCH v2 net] ipvlan: inherit needed_headroom and
 needed_tailroom from phy_dev
Message-ID: <anV57tI1egK5Gelw@fedora>
References: <20260806103857.115541-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20260806103857.115541-1-edumazet@google.com>

On 06.08.2026 10:38, Eric Dumazet wrote:
>ipvlan devices inherit hard_header_len from phy_dev during ipvlan_init(),
>but leave needed_headroom and needed_tailroom set to 0.
>
>When the underlying phy_dev (or stacked lower device) requires extra headroom
>or tailroom for headers/trailers (e.g. macsec, ipsec, wireguard, tunnels, or
>veth with rx headroom), upper layers calculating packet headroom and tailroom
>fail to reserve sufficient space.
>
>This can result in reallocation overhead, skb headroom underflows, or KASAN
>slab-use-after-free crashes when dev_hard_header() / ipvlan_hard_header()
>prepends header data or when lower devices append tailroom.
>
>Fix this by:
>1. Inheriting needed_headroom and needed_tailroom from phy_dev in ipvlan_init().
>2. Propagating needed_headroom and needed_tailroom updates to attached ipvlans
>   in ipvlan_device_event() when receiving NETDEV_FEAT_CHANGE events.
>
>Fixes: 2ad7bfab3016 ("ipvlan: Initial check-in of the IPVLAN driver.")
>Reported-by: syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/netdev/6a720a21.40259c87.584f4.04bb.GAE@google.com/T/#u
>Reported-by: Tangxin Xie <xietangxin@h-partners.com>
>Closes: https://lore.kernel.org/netdev/CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=+rs9gHfLg5Wj+4x0sw@mail.gmail.com/T/#mcc6307f115e500df23ea2980d5669fe95f20b6b4
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>---
>v2: also inherit needed_tailroom (Sashiko)
>v1: https://lore.kernel.org/netdev/CANn89iLr4EQxBAKikZCeXbXEk-pjmT4mq3d=D2P01MtNSUgwrg@mail.gmail.com/T/#t
>
> drivers/net/ipvlan/ipvlan_main.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
>index ed46439a9f4eb1dd8bfaf6c83476ba4f2aff31bc..92d3d340281ffbc8e54a61e975484ab156c42c9b 100644
>--- a/drivers/net/ipvlan/ipvlan_main.c
>+++ b/drivers/net/ipvlan/ipvlan_main.c
>@@ -146,6 +146,8 @@ static int ipvlan_init(struct net_device *dev)
> 	dev->lltx = true;
> 	netif_inherit_tso_max(dev, phy_dev);
> 	dev->hard_header_len = phy_dev->hard_header_len;
>+	dev->needed_headroom = phy_dev->needed_headroom;
>+	dev->needed_tailroom = phy_dev->needed_tailroom;
>
> 	netdev_lockdep_set_classes(dev);
>
>@@ -773,6 +775,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
> 	case NETDEV_FEAT_CHANGE:
> 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
> 			netif_inherit_tso_max(ipvlan->dev, dev);
>+			ipvlan->dev->needed_headroom = dev->needed_headroom;
>+			ipvlan->dev->needed_tailroom = dev->needed_tailroom;
> 			netdev_update_features(ipvlan->dev);
> 		}
> 		break;
>-- 
>2.55.0.629.g250fe7f194-goog
>

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
