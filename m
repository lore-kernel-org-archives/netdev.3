Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241317;
	b=nVeJ3h81e3DTzXRSliRH4ZPZkh5F217/um+XB5VH4afuRPhQUP5n30QtUkCx82hrie0m
	 uASLZpB0JFT9Rl9x6HjeiKXku2NfFAhQXyITY+xzdG/qVvRkLm4w161fshbJmAf/Mhxho
	 5gUQuKzxbqn89VXMyBKLpyJpuSuXS6kew9seXXeL1m5llemex0VuxLnRbnon1b5uxOqrk
	 1BmH5o6SKlU/zuwTn+84O/UWubYUlyGndQw+C+MBSKslaztS7qjFvgGamEBVKSYWPycM2
	 DwmKohL7OfbVgzhCsmT3syBtK8+MVU4+z6UlYIinszuSMceQD3D1d0mu+dzJmIFh9rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BYPTkk/4BunQr6t7vq/ZOQ1XWuSd/WG5xS8ifOxf1Lo=;
	b=O2eJebbP7IaZz13mbvNluZA2H3WSiq96sCvYnhP7wPU45FQUSwrVmsFUybAt5Wwsm+zO
	 TlXU5EzUa+4jdCdE2gmUAYK+e79esPywBnbWRSziImrrrnIkZ+4Q634wBrUoat0PwCwmq
	 MevF3DlaFuwT4q74MtorkzrSUAtarj1gYcQXky8mRN5jDxSlJGbdnhDtiyDlcj1vYzIPr
	 FgoFVmZ1xDTvoaeMUz7SS656Zw4V6mf7IHVzMgLT/JqSLyyrUAevF0LqrwlxXKxfBgbe3
	 iC6F9QdqxSKIMRrsjZaYZesEM6XwDDyDL73LgqneoTNnpnpI9gyPCcsklhuGgi0cBNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fJs9VWZ/";
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2374D606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2374D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fJs9VWZ/
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5edf97136aaso497025e0c.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241316; x=1794846116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BYPTkk/4BunQr6t7vq/ZOQ1XWuSd/WG5xS8ifOxf1Lo=;
        b=fJs9VWZ/D6Zrq4tHCM/tTaabajQiokI5fKewOJzDRs5IS8KspKYj0dDdxANJBHdVMh
         tdaqSjQLDlakszKo3L0QuF9bEIoXXlM3v+PhugbNXBaYEI4WhZFI+TFRZUeDRimiSA3l
         fFMz/rzKb9ZY7w9xIIhsg0i/nuKM7mqi99g3h12a6cMWirwiauRWpPJzT12d/wbwtWX9
         EavcRosymWl7MLB8U0uP6/tZW3EFQru6Ksn9gKBXYyKqRF0rLAUiomE/jQuR2YvdbJvz
         pMpkI8SfZmNeD45z9ekErRNnLuJIiKV/Cp7IZD2h6ImavO05rvL5qjH7vY2lv6B4E8RV
         9qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241316; x=1794846116;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BYPTkk/4BunQr6t7vq/ZOQ1XWuSd/WG5xS8ifOxf1Lo=;
        b=CaWJsxkB8xE/qa05xfQ6Y6J87s4OzeDFBZYAWL0Dp6dk3UMpOq3S2MAf9WdHcsKlJB
         eMK08NfE7H09OjQwnQELzQV/pfpj0Ew5vi++LPSTM5picTZ2TEMjnJghN78RqDzMFWi7
         Nc/CFtTYNCHngYZgo8Oulh9WGRN0I38FPDwu6vi7T1n5oGl6BsvQ73vNepcq2LR8X9yL
         bbSuye3dplIGI9SsOxfokHxSjCq/n0pqZrZg5OsuycYCm7y1x50j957QNH4vHEPLAwGB
         EjQ8f+G1xidAtR3JpPdMk7DbO5yOTxIyCMsKy4u+n6LtxaWFd3EEPq6h9rDhQz4QqHge
         cCjw==
X-Forwarded-Encrypted: i=1; AL+hErHSdnLUK/ZB+6spSk67hSfg8ueQN9jgXGHtXGwn3JNvI5B8jEUa512Lx8OOfhlkzjl8KFhD7mw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yfIj0bRiue0dZcnbx3k4LAS5+EvXf12u6A+rfm+oSFH0EWD4x
	C3CmjEEQ3nYDVv4+EAAZ5YKUR/pfQX921Cv3E5mYTPRFZXm1bA5UKtJt
X-Gm-Gg: AYBFou060TJlm7Pzhuaa5iSDonK7aZ+lQNqoyfFj8uSOH88ZtykyAz2D7RT1HdUiA3S
	m61JrPCfZ1oKC2OP9Q4hT9tXaWvFZ0qh1ESKuKX7FrcIuojx/LI2o5en4o9f6r746qWHQVFW5Uu
	BcEEa5hbIHfBQJJTAv1nsRL9YZd1S/O6NAnGtNKv9p+ZZUulnO2uiBbLVKX+NtWp5Uv0BWJ1ICX
	mUb1jAqdj4d3RC5zW/GEbB7fQGfXu1FztZ4rbLj/3NqYPVcwXXFAutldZLuSFkzCn6EMORalmD7
	77/C8oe0CxfMNKDI6fZW9Y+gq5LbD9AzEWt7D9+Cp/jObwf+ONJfll3BPB6ZCWh03oaFeu72cBW
	gpBuCJPuY/8sbxuTmtlKX0SfO/mPNg/fA4UPMeZcfCdHqq6RUZti4HeyeCY11jIdtX5Zndjz1wa
	JI332nwcMZkPHbDcuJ3u2DwbAiCSGJyrKkeYZQ3of9WX3GY5Hl4SXy57zLtu4Hq38mGstJHJux8
	/apABYoVgOoVM03bYxuyB3wNd0UMNyzgVVrYHSM9idF0iCIEi/tFMBEQ2gVkOLjqNSJ1qPbKg8H
	6XWIKAqkwvylGIIa3Ocqky3E+Rje8j0F2LTvVgy52AzcSmVyByhLHcIHlGqeeUJV29p1s/0UHd/
	zy4/GG9lqF28YOu9vNuKLnoFbp7zhUFPlJeNTENFDqjzRUp+rdcgVYLQXjMEm5HYdEcu8E6mubv
	bfsQE6kOg2+FhQpZAWNw==
X-Received: by 2002:a05:6122:4890:b0:5c9:c60e:3a48 with SMTP id 71dfb90a1353d-5ece735964cmr1685538e0c.20.1794241315788;
        Mon, 09 Nov 2026 08:21:55 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe12dsm21301241.5.2026.11.09.08.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:21:54 -0800 (PST)
Date: Mon, 09 Nov 2026 11:21:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kalpesh Solanki <skalpesh942@gmail.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 alex.aring@gmail.com, 
 stefan@datenfreihafen.org, 
 miquel.raynal@bootlin.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: andrew+netdev@lunn.ch, 
 linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com, 
 Kalpesh Solanki <skalpesh942@gmail.com>
Message-ID: <willemdebruijn.kernel.4bc56403b78e@gmail.com>
In-Reply-To: <20261109083037.22337-1-skalpesh942@gmail.com>
References: <20261109083037.22337-1-skalpesh942@gmail.com>
Subject: Re: [PATCH net v4] tun: disallow setting IEEE 802.15.4 and 6LoWPAN
 link types via TUNSETLINK
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kalpesh Solanki wrote:
> A userspace application can set the link type of a TUN/TAP interface
> to ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, or ARPHRD_6LOWPAN
> via ioctl(fd, TUNSETLINK, arg) because tun_get_addr_len() explicitly
> recognized these types.
> 
> However, TUN devices cannot function as genuine IEEE 802.15.4 or 6LoWPAN
> interfaces:
> 
> 1. They lack wpan_phy, channels, PAN IDs, and MLME operations, and tun
>    never initializes dev->ieee802154_ptr or dev->ml_priv. When an
>    unprivileged user creates a TUN interface in a user+net namespace,
>    changes its link type to ARPHRD_IEEE802154, and issues a netlink dump
>    request (such as IEEE802154_LLSEC_LIST_KEY),
>    ieee802154_llsec_dump_table() unconditionally dereferences
>    dev->ieee802154_ptr / ieee802154_mlme_ops(dev), triggering a supervisor
>    null-pointer dereference / general protection fault. Similar
>    dereferences occur across net/ieee802154/nl-phy.c (ieee802154_del_iface)
>    and net/ieee802154/socket.c.
> 
> 2. Similarly, the 6LoWPAN subsystem assumes via lowpan_dev(dev) that
>    netdev_priv(dev) is struct lowpan_dev. On a TUN device, netdev_priv(dev)
>    is struct tun_struct. On netdev events (such as NETDEV_DOWN in
>    net/6lowpan/core.c:lowpan_device_event), it clears bits in
>    lowpan_dev(dev)->ctx.table flags, which corrupts private memory inside
>    tun_struct.
> 
> Rather than scattering checks across subsystems, fix the issue at the
> source: disallow setting ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, and
> ARPHRD_6LOWPAN via TUNSETLINK by returning -EINVAL. Cast arg to unsigned
> short in the comparison to prevent upper-bit truncation bypasses (e.g.
> arg = ARPHRD_IEEE802154 | 0x10000).
> 
> Fixes: ff4cc3ac93e1 ("[TUNTAP]: Allow setting the linktype of the tap device from userspace")
> Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
> Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

This may affect more protocols, and sashiko may surface that.
That can always be a separate follow-up.

> ---
>  drivers/net/tun.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e60..b50a7245be9 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3362,6 +3362,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			netif_info(tun, drv, tun->dev,
>  				   "Linktype set failed because interface is up\n");
>  			ret = -EBUSY;
> +		} else if ((unsigned short)arg == ARPHRD_IEEE802154 ||
> +			   (unsigned short)arg == ARPHRD_IEEE802154_MONITOR ||
> +			   (unsigned short)arg == ARPHRD_6LOWPAN) {
> +			ret = -EINVAL;
>  		} else {
>  			ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
>  						       tun->dev);
> -- 
> 2.53.0
> 


