Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CE449B0D
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083691; cv=none; b=GzYtOvRXn2Vjd3sRgJLtzNCndRkb+hOGmakthzIqLWw8Zza87h/QHfybBppe0fpY5uZ6xsflV5RU3EHbgGf+GFu0cFTRJZ4r7S2jtpNxz7ZNdsyevmYH1D1KBGmVIZcvvv1oXFrfhkweVxrT3VS6TVwaVdqdThPcdfj+F2DdVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083691; c=relaxed/simple;
	bh=w2gcYS3H5EBg6q8bam06CQYFMUriO1Yam8WS3KxLkds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qImqUbxrjhdUnUPRtnZAYKrM/KNk5deRV1fjQeiDlTBksM4hmOCi+R2Uh9tJ6DW1MRBuEGHezMqNUqY8EmSLPyrHcPTSn7iL7M1OeCT0/lsXb3BU46c82/9UzUm0P/fnV3Eqr8KHD4PbOls+vp0bgFfPBEgjLBis93KpvKGeLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hldyVtCI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hldyVtCI"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381b831d535so3454138a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786083689; x=1786688489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1eByOvutqpFbhkYZ53YG1WLEqmP+x9b4al0wBW/J6Zk=;
        b=hldyVtCIHZiBzza45ab1u+zfB8CigCJyHQR9WroRg9rC6HKeYWDRa3pY7bQHGiyJjr
         W1kHmfpaNI3Ss4KkbPJtL+TfAiN8p6xe4ifLs/drBdXMoBGPF5PtCI38jFZoZBLwKg54
         opyAAoo75CMsRy9UhbMGZJuTrA+lx/cVzIPd08qxH0Z82gXeIDbFzvDifFlw9EPyb5UR
         JkJM0wB9iyH2ceOELBNT9x8fPN8ct5Z3k+XKaAeS4ZIG6+l+VbO0s+xS8VLdQ7ndq4xg
         UcDM71o5j0nqtEuuCceuK6pjesndr7V0u5jq5kzS//n6OD6mo+/ZjK+PcfBwNNpzLnKo
         BDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786083689; x=1786688489;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1eByOvutqpFbhkYZ53YG1WLEqmP+x9b4al0wBW/J6Zk=;
        b=Isb/b2pUhVjaX7Qn98WIZ3pSGI7ZhcAqaRaq73ihHp8DxW+RDlcESsxkHPgBELmwWa
         iAESf57nbjWKKlnbWHpxAUFN+VKyUT9kg4NIkrH2TOQdBxiSjVDSY1e/bwNNT+re6wn/
         61w1T97ubnavgpaxedjKeeMpCsMf9QqLrISMPk51GRE+qxmgCmUJe3FJYao02DPBiwTC
         Oa1evUmUYDhmsfHe5EyTd8kDDz4r9BIkMIC42jVRRwwWklBk9+8rN6HQVtxOzqoUEWUv
         xK+c1U6tyQKDBaP3qbTN7D4mN+r+DYGU9A0qcXPKEjXx/HK24aPOwx5lIZSQnYWpRzb6
         FmNg==
X-Forwarded-Encrypted: i=1; AHgh+RqnrDDU30bv1gAEyz+gNsbxl4Doh5G0Emu5szjKFWqurItV+i9qEc6tA0AbaVcR/d8OQNWMMcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YximGy6+raMW//FfeSU7BqPW6XrieASo9X4XOR55CpdFbNAEY7n
	kucZ3bXVnj/P8v8tPqJTZkAKLTB33PjIA3gRRVCvlnyyQ2g1nZ/b5A07
X-Gm-Gg: AR+sD10SqzMui7iKUu6lIDVMDA9VHDgTTEaC3NFDTsJAMnYCI9IHP2yttXTKH6SyuWg
	8Us1XqAUMDEHEpOgJbniOVSdNk+1C7pSlpul6ULCG+8NnUBO89OmK85Liv7xiNr9uk5ckTIbDel
	vyHDME1Fs5im0ynxfWv7uGxg3WrNM9x3TaNuZCis+uNp6C5Gih/aR16vpJ054nDp3VpTzxG74LE
	WJ1nnkc0OOq4eZFtJj0dnlxcVh8cW9yUp9ucmFIoXcd/V1+RS/Hf8c8ZTL3AfZ4qe/GuV+/M94J
	VfaYkbz3ej9As1eA2a5ndxYn2MpafWwkkq42mdfD9Ko+R3gsUL7JvmNYUfyOqU+3jIa8rKktBNu
	BHk7jVIGLh8tEuJI9SMCkJ+6K4z4MBL3xQmei8x+FDR3duOoEEN4tXb/HdAvP8EC7EVKSeJtmrn
	dWhqe4td3p19IU2dfUnq2oFtcJfuNZSai0Gclmud2LNJWLT1zSJzSp34s=
X-Received: by 2002:a17:90b:3b45:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-392621444f0mr1698488a91.15.1786083688388;
        Thu, 06 Aug 2026 23:21:28 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3926254ee45sm836246a91.2.2026.08.06.23.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:21:27 -0700 (PDT)
Date: Fri, 7 Aug 2026 14:21:22 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, Tangxin Xie <xietangxin@h-partners.com>
Subject: Re: [PATCH net] macvlan: inherit needed_headroom and needed_tailroom
 from lowerdev
Message-ID: <anV5Cu3V6UF2Ilqe@fedora>
References: <20260806141938.287660-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20260806141938.287660-1-edumazet@google.com>

On 06.08.2026 14:19, Eric Dumazet wrote:
>macvlan devices inherit hard_header_len from lowerdev during macvlan_init(),
>but leave needed_headroom and needed_tailroom set to 0.
>
>When the underlying lowerdev requires extra headroom or tailroom for
>headers/trailers (e.g. macsec, ipsec, wireguard, tunnels, or veth with rx
>headroom), upper layers calculating packet headroom and tailroom fail to
>reserve sufficient space.
>
>This can result in reallocation overhead, skb headroom underflows, or KASAN
>slab-use-after-free crashes when dev_hard_header() / macvlan_hard_header()
>prepends header data or when lower devices append tailroom.
>
>Fix this by:
>1. Inheriting needed_headroom and needed_tailroom from lowerdev in macvlan_init().
>2. Propagating needed_headroom and needed_tailroom updates to attached macvlans
>   in macvlan_device_event() when receiving NETDEV_FEAT_CHANGE events.
>
>Fixes: b863ceb7ddce ("[NET]: Add macvlan driver")
>Reported-by: Tangxin Xie <xietangxin@h-partners.com>
>Closes: https://lore.kernel.org/netdev/CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=+rs9gHfLg5Wj+4x0sw@mail.gmail.com/T/#m16adf0ff972cbfd8066c3a8e656e75eaeb12d021
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>---
> drivers/net/macvlan.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
>index c40fa331836bb2395267914807542ae5094e1a3c..ff2f4bb651b74cdb054f245ea0f4e8cfe2297193 100644
>--- a/drivers/net/macvlan.c
>+++ b/drivers/net/macvlan.c
>@@ -950,6 +950,8 @@ static int macvlan_init(struct net_device *dev)
> 	dev->lltx		= true;
> 	netif_inherit_tso_max(dev, lowerdev);
> 	dev->hard_header_len	= lowerdev->hard_header_len;
>+	dev->needed_headroom	= lowerdev->needed_headroom;
>+	dev->needed_tailroom	= lowerdev->needed_tailroom;
> 	macvlan_set_lockdep_class(dev);
>
> 	vlan->pcpu_stats = netdev_alloc_pcpu_stats(struct vlan_pcpu_stats);
>@@ -1824,6 +1826,8 @@ static int macvlan_device_event(struct notifier_block *unused,
> 	case NETDEV_FEAT_CHANGE:
> 		list_for_each_entry(vlan, &port->vlans, list) {
> 			netif_inherit_tso_max(vlan->dev, dev);
>+			vlan->dev->needed_headroom = dev->needed_headroom;
>+			vlan->dev->needed_tailroom = dev->needed_tailroom;
> 			netdev_update_features(vlan->dev);
> 		}
> 		break;
>-- 
>2.55.0.629.g250fe7f194-goog
>

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
