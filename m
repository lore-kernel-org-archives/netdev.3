Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696193;
	b=fu9c61YYvrJamG3mJhVcETLoEqk6Q8ybgoRtp5+79+gRZ0bNMV1Rno5VeH/GxfMK9UdY
	 +3iB9IbPnEiVeRfTaJiqDEwgMbMU7/ZuHSCMNSlMX0QWWc/RO95ifbPCb1h0w8B3TGVih
	 4a7OQ4sDiYzxVf28S0Y7CgBFJBQGw2fEjglMbu7BZ4+WxbBAkCAGRREeEp/5EGNkVg3rm
	 XAkqK7uePM5ApwDbCKmtxX2gcxMtF9ja5bKeU4ILwKgHhVTALQy4JEHQUO2qj6TVh9y9l
	 /7glaXUo8Rhdz646GtPKvF37XL823wTP1igFHRJTBF38q/wEtaqFRpdSEwY4QxmNCfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696193;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0eq2D2jYQoQcNB0A0YEhxE5qSu++X2zrdL69lZRBaaY=;
	b=WxtfnLyQf2BvvSjlWQNV0FO+KyfVUWEmnY96zUAWjUay9ZVom92i8axPfSJfFVvJ8H21
	 g668zw7Rn+/2OX8HxJ7EzJpbnwg1WR18ItL+wwlnzWVq8eS06rL7UpKU+TOClOpXiRDr7
	 eXSueIUbVtZuo2CTtUYFx0LxJr4lyo7MGc+cncn0sm5BA/pjaGfArV6QGW8ZjJKzxJ3z2
	 M0ylKA5SjfquOlT5C6Tfce2pzCfkMK5P9nthubUQnbIaJWl9zKbU4KHm3eY+kVdqlRveF
	 Y9FS1+AAfvjzZSEsiPd6OdQh7/GNqls/LQpa5YGf7WNwDvyq4TvsC6G15EOhsEuH72w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aWFkOrsC;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Q88fxJgs;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D9606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C9D9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aWFkOrsC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Q88fxJgs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793696192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eq2D2jYQoQcNB0A0YEhxE5qSu++X2zrdL69lZRBaaY=;
	b=aWFkOrsCNC6jeC/sw/skjcIDESLGLU1YeIb10muaNM78MJ8i3EsLo+Nw59+NgOFmB5aWZo
	VDuGNXJW1b5h/DuY60T8d8IFuehoN9otcvEbQUDMM5mTwNLTDnlBVV9yWLtE0q8S6fkTSj
	WMVXxUrhn+Uv0YsuU5ifQWvE84HXWm8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-Z5iFUsbCPc6jR6lw4bEKGg-1; Tue, 03 Nov 2026 03:56:28 -0500
X-MC-Unique: Z5iFUsbCPc6jR6lw4bEKGg-1
X-Mimecast-MFC-AGG-ID: Z5iFUsbCPc6jR6lw4bEKGg_1793696188
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso28024825e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793696187; x=1794300987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0eq2D2jYQoQcNB0A0YEhxE5qSu++X2zrdL69lZRBaaY=;
        b=Q88fxJgsJA4E0kXmoHEzxKAQVBFcDXBz+8OUN0wBDR7hK4A74Ax6t5CHgVkkcbx04l
         Xs9gl9jYaRfreUu+5eUgCye9Y9J1iLGe40CWCuEfpAuNUcL+PpQ/omzGcO5fEbIMOhWe
         L9lwis0Y4wZDcoYP4sShDhD23YKA8/vNYNp4Zzx5WcYjojwIrqc8gpaSPLo0aObyG1q7
         f/6INvJRwP4snqIs5DJvi+XoMqeXoS4aDIkXyt+/xLRPLqxXypHGgF2Ue95s6Sbgx/rD
         FlwZYuwkhFqIZCJbBKnKatPw6ks3c+/6E/RtInyRHtLttw534NOxp7UPOjMPn5kYyWzr
         z7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696187; x=1794300987;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0eq2D2jYQoQcNB0A0YEhxE5qSu++X2zrdL69lZRBaaY=;
        b=uAODVKU06rYjgqMFCEgKkg0rP3Yfp124iwLDfitR3Q2A1pcDDZH4m7vwxeOd2BWTxX
         4dozvVvzC0MDzks31C3sYlo2e3PWN7zversSHHGPumyh1jYLOIkv+vY+6VZ56Dco7eG3
         QNDzl4ON/HkhnVWjcLXqxLAr3bGBmmRZ+fY2f1HuFHvXW8JPWtV1mvRdOGaAPy87k3Py
         xruIShG8Vpx42jDG3aGAWaodVphOss77u4cvzQ5QkgnfZj/aXy+8JnSLgAaJGZ4AkQnV
         138+l3TfNRhDi6NigmL2wYnk9kjmtRAwzQKan2IPtj21MpOfdCIAvAEGSTbnI2aahnAs
         XsZg==
X-Forwarded-Encrypted: i=1; AKwUvBxA9zU1/aTeh1TmcRi2A+FGgVv5TGM5drQBRuzbao+HqhDSz85pxMDinUdLC5Rm3rXGPeMmkA4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NATfA1TMx6NnPi65gmHZlCacDtmxEp4eei02LkFsL5Wzpjynj
	Hm7zzTbIu3sGCGJXJnBUKk1tMAVA8yAtghaUcpFg8+L+TRQ/N+M6MB3ODBOe96nathY1pY6PqB+
	oVOXP3wLKZEm6/obVfNJHpBhQDcK97gIwL77hiPOzuc04FqdPtavTp9JOL2KYgpkJhw==
X-Gm-Gg: AYBFou1mQi1j2WsV2jRq8bFbiAPmCntFpH0FBRVN364H8nfadIHcvBx/mpBwPFaKrbD
	oq+TKpKy0VPQBEvTVhoMbMmxzMsyHRHpelUHLHNU/OSYWhKbANN20iiauh9S98u72UT5E3jLlob
	WmUQl4vOcmooVC0aOaMpbG/D51mUqZwMomwaZtvLKaHftaqkLNNpry9nkJviYwihyhYw+0u5y4g
	jxFMdY1kEwi7lEBKvGAAY/WqoRxZ782eXIrzjJ9UbBUUBo0DLHsAf6Jq0cUh552kP/PU1Nx/KQd
	h6SOZO9wcrcgPYt1eHBknAo4rVLppoWVnDmVv/WmYzpZQe1LxthRpcVKDooQkM8ZyJ7VI1Eu+Ix
	HA9JSwbQr/YUMUjNW86Q2waGzoOT3OFMNX3I48E96CLqNM3islJW12miInzEDX7JRooffzptnhj
	GeMSq5B4p8DOkM3ag/Z1S064EwuviWf+1JAoswAuSfgkc=
X-Received: by 2002:a05:600c:34cf:b0:4a2:fe3:121b with SMTP id 5b1f17b1804b1-4ac18d68ba0mr257502075e9.28.1793696187604;
        Tue, 03 Nov 2026 00:56:27 -0800 (PST)
X-Received: by 2002:a05:600c:34cf:b0:4a2:fe3:121b with SMTP id 5b1f17b1804b1-4ac18d68ba0mr257501695e9.28.1793696187165;
        Tue, 03 Nov 2026 00:56:27 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm433231295e9.1.2026.11.03.00.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 00:56:26 -0800 (PST)
Message-ID: <a2ad86f8-1e4c-48e6-8cd3-4c43d73dea3b@redhat.com>
Date: Tue, 3 Nov 2026 09:56:25 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/4] net: phy: as21xxx: fix read_status speed
 handling
To: netdev-bot+sashiko@kernel.org, ansuelsmth@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261028073024.25175-3-ansuelsmth@gmail.com>
 <179335632134.3134.7804602022043442736@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179335632134.3134.7804602022043442736@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/26 11:32, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 5 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] With AUTONEG_DISABLE, as21xxx_read_status() no longer takes
>    speed/duplex from the PHY.
> - [Medium] In autoneg mode, as21xxx_read_status() now reads
>    VEND1_SPEED_STATUS on every link-up, which is the PHY's own report of…
> - [Medium] The new early `if (!phydev->link) return 0;` in
>    as21xxx_read_status() (drivers/net/phy/as21xxx.c:732-733) makes the…
> - [Medium] In forced mode (AUTONEG_DISABLE), phydev->speed/duplex hold
>    the user's configuration.
> - [Medium] net: phy: as21xxx: missed pause and <=1G speed in
>    as21xxx_read_status()
The above ones looks legit to me.

/P

