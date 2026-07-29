Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682103B19DE
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316514; cv=none; b=YUvUuywMZyHJXauflnXqx9H9qrovWTCdVKJYrlwe0WkNCD3nOlm5ht5idUQriwGQQq6orhCJWGm1LhK2mk0+kh/ONp46BV1NZNsZIKC66czGjQV0STge3Cd/9BAxc2EgyAAJx0d7q1172UMsU4DnCkROwN/lgxUjzgKn7NM3PSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316514; c=relaxed/simple;
	bh=5HbFxxRqzh75HEuLo5PVE1LSDA+Cqa9OYNV2U129l+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JS1J2JHeq9kZCO3Fvva/aWNYL3b2WNjPUB3g4wq7SxWlO5iH1qcnyP0E5BsG8c/BDTqC0J6mYkvuuU/Rz68Zk2Ye4uSMlq7DHzRNrZPjh/tLeD7Vv3xKcNOpDnAPaykdcMAmCBkTq4OCFRz6Pj1yaAnTZuKZjqCP5usMRFLFZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=c+qjVi7g; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="c+qjVi7g"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954afac04bso8116465e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1785316511; x=1785921311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oNpiwhcss09c4/Xotm6inwoCx6Njgo/xmgKicXGYy+Y=;
        b=c+qjVi7g/+cUyMvOuTi2eCXcb/TTy+VUNim8Le88yMtB06i9CHIXnl6iDiEAqKDRd/
         CR0cIDZ84FNUTVHC6QJFF6j6nq/BA6/TQusOesMz7g+jVmB3PwAVb66y98OeEeGzdABQ
         M/axHzsY3LohwZac79uhCR86AVBwOG4VBhx369bZJpjzapNdmmiUj8gQxAnoRni+5Nj3
         1U5rbwQpfYEiYq2qo6JBsG61Rz03CUCzPy/JdJefaX1ulVGdNfjNktzBfSgRNfsDy7Tu
         Jwkdw/5JETIPwhMyh4oO2Q6/A+ax+qXzFIY7sKhMunZBKxlYPj0TQHAA+FqPVQSwqOsB
         wx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785316511; x=1785921311;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oNpiwhcss09c4/Xotm6inwoCx6Njgo/xmgKicXGYy+Y=;
        b=VvcVeSUIKISGyuoR77BH2S4n2dmnAEvVjKpDHLNJZgJeDc9pzJFAJG3PaOiSlcznMq
         /D/rqQj+pJSWn4oB2TE7iWrsM3ENDZed2rqebr1HrnKn0DCU/0RH882Qohe2LWuxlOGt
         /htR8ekSny9Mo5wA3ztanXM+4ipavE7QwGFJc2D26zb/bGRQUKsj8tlsNGmo8u02Cyh+
         YJxl5+UHEM1l01VKvEkXpExucoChNWHe5U6jNN/56YXH6fGA6j4PqNvuDc0QpBm2NOeh
         DPnfArQKQC92Mq4CJnmfiR3TipLJG8hnK57/q4RgFFpfatcL6fbIUi0Bsx1AjBjOCznI
         I9fA==
X-Forwarded-Encrypted: i=1; AHgh+RoXdeO4I0wVhtE+zjMOEwegTt53GNCys3vKqVPpvYq2c3yuuL8WwMf3NFZe06ujcpXOws8uN3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA+qNugbv2Y15Zv9+mTWI1HGUe5E/YxoxpmyXIsx3bAfxpgTaS
	3EGH4MuyPhz8UBNIFVIV8+65oi4ZPRNh7bUNJFqW55RANQ2dqx1vz+BfCVyj1N+P+Yw=
X-Gm-Gg: AR+sD12N7HtoCY0knM2iq6baxNvW3bI7JlC10kU4pqowXrEneezKFobGWv3Z5vNLh2H
	HK/ohpAKcr1tQCYSozJtgObd6qnVh6AtERzDaIdKkZajdkGbQVSBr3c9fVl+FYW4Bw+1pWZTzS+
	nvgh2kWoj7NPR3Ribw6/qOSGS9c3OfMcOxBAZ3KuVz9aHIve6wDLw5hBYUQArgsOLLEAA3Lxkds
	hYR9MSdEiKRZS0Tp5CDRWLyXPSNa+WPzv9pPJBTo5UESYkduelXFCS6eOLTHNcdWlsmqQbXzBTp
	yTVpbHrzXHnUfAgoKhfzRbyXuUDKFz/a8Uny4Dt4zMmewLfqvZ+r1+674390QWWQh2mXnoz1yyi
	E+JJOTMdg3mod6LpjXD8Df96qo9Qhz1zAWeKsMU2C7C6V1evjEO/RPkCzM4UMYYTGkNcXlfMixj
	YlpjXNzCxFXU/2aEMaDcMhUKDK6rkVyfqTMogIQNU02etSw9GRVMM7cN4AswXf4PtBxONWjQ==
X-Received: by 2002:a05:600c:a42:b0:493:b4cf:d37f with SMTP id 5b1f17b1804b1-496c655ae85mr65209915e9.16.1785316510535;
        Wed, 29 Jul 2026 02:15:10 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d72d9asm44869235e9.3.2026.07.29.02.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 02:15:10 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:15:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jiale Yao <yaojiale02@163.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] team: reject CAN and IEEE 802.15.4 devices in
 team_port_add
Message-ID: <amnESUrOtl0dXaXk@FV6GYCPJ69>
References: <20260728151240.89434-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728151240.89434-1-yaojiale02@163.com>

Tue, Jul 28, 2026 at 05:12:40PM +0200, yaojiale02@163.com wrote:
>Enslaving a CAN or IEEE 802.15.4 device (e.g. vxcan, wpan0) to a
>team master triggers a NULL pointer dereference because these
>device types use different Layer 2 architectures from Ethernet and
>the team driver never initializes their private mid-layer data
>structures.
>
>Reject ARPHRD_CAN, ARPHRD_IEEE802154, and ARPHRD_IEEE802154_MONITOR
>devices in team_port_add(), mirroring the existing CAN check already
>present in the bonding driver since commit 8ba68464e478 ("bonding:
>refuse to enslave CAN devices").

Can we perhaps have a unified helper for the check?


>
>Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/
>Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>Assisted-by: Claude:deepseek-v4-pro

Looks your ai gone a bit wild here...


>Signed-off-by: Jiale Yao <yaojiale02@163.com>
>---
>V1 -> V2: Extended check to also reject ARPHRD_IEEE802154 and
>  ARPHRD_IEEE802154_MONITOR devices per review feedback
>---
> drivers/net/team/team_core.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
>index feaa75fbf8fc..d8c46105fc8b 100644
>--- a/drivers/net/team/team_core.c
>+++ b/drivers/net/team/team_core.c
>@@ -1224,6 +1224,17 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
> 		return -EINVAL;
> 	}
> 
>+		if (port_dev->type == ARPHRD_CAN ||
>+		    port_dev->type == ARPHRD_IEEE802154 ||
>+		    port_dev->type == ARPHRD_IEEE802154_MONITOR) {
>+			NL_SET_ERR_MSG(extack,
>+				       "CAN and IEEE 802.15.4 devices can't be added as a team port");
>+			netdev_err(dev, "Device %s is CAN or IEEE 802.15.4. These device types can't be added as a team port\n",
>+				   portname);
>+			return -EINVAL;
>+		}
>+	}
>+
> 	if (netif_is_team_port(port_dev)) {
> 		NL_SET_ERR_MSG(extack, "Device is already a port of a team device");
> 		netdev_err(dev, "Device %s is already a port "
>-- 
>2.34.1
>
