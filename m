Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CFE3C1D73
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338376; cv=none; b=iAyQThxalpYIWAWBdJI+1JLvCM+p5tZXmOy/r3vD5hyJ1DqxUfG/tN9tbwr6SaIwyqyc7XPG7PNgeDqzShpIQRvPw8VEjvwNb0Y31XYoARgRgg8+wNPqh35qTw4X0CVa+p3hhySA4JZ3Otq32xun7xpGkMH0Q8N5ajWxCtez1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338376; c=relaxed/simple;
	bh=i4YZGM44oygpZKjmquq516DY4tyVYynZe6c5RsccAYc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qhFGd6TvCh2fJ5tlrL17fln8crcSZWbiIV+mfIiswQ3K/hlNQ9a4t7L8XnLxMVC0dsCMCEHnCiP7h6FNfKcf/Vin06fRdZbYdYcYerCLTxVUxMLbiyagYzEJfe+n/B+/sMz9BwvFWWV4bf1g9grfBHrssti6lcb3wSExbh2zMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIB6fxEV; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIB6fxEV"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e56a1b327so1105076d50.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789338372; x=1789943172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qDlMjyWVJM1DT/C9g4soY8KmIZt5frD9TDK7DVcZsGI=;
        b=OIB6fxEVb73dx5FEDZD2mdPAt3+AdUyxMR26oT4NOoTifzAvfRqq4e3iiz6Isyzrp/
         lO4LJo0ilSpa3qsAiS0LHeWPmTfAM7aB0beaszKV2FtOZFTgjXihwswOUNAXrJNN2ljS
         0sabefM4JMj3aE/jezoi5T5X3HhQMsqBPcsKwn/Yqd4I6L8CoB7sXdGuu+nUsDPP3Ij7
         2Osbj+jmmGkYfloaDv6/5LCVURZNA4Z1eXYJ+6jnObSD1MCi9xz0UyrJJLCWMC+mcHta
         IONaCjPQjmQ0ga3NKPSmWj58VGwPZyLqYkhLuJR+177tOtuNMFDRe7Ae2Xh2/2o2fkd1
         MuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338372; x=1789943172;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qDlMjyWVJM1DT/C9g4soY8KmIZt5frD9TDK7DVcZsGI=;
        b=hRVJStbFQ8UEBoMywqimd2qe0//bCXlDNolhUsPkmSl0c+tukto8RuasfR8PlKkIAV
         OXJmIk3pEhev9BZRiIX6vGjqH/GJSh+o4sibU7cbAvUAsHGCyIO1yqrds2Z4GoIregq3
         mgXqbx6D1eDl7+62OyzeLuWgRHbHaMnep8kOxuXZBN2BTmcSvmAhRuwQ23DZio5hDDNH
         lPBVro40/LIrflIDFiGbibtna/VbDE6kI5rzsHLNTk/o7Vb4EWJtr5KR7vJHyZabDllw
         UltqaggNSMG5+mKCgDPxvLWSyrLUtW40pAiZ9OIbwvzijYT51Nt05Przy9tDMHt2f5gz
         +sIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxk5RPbW8h2WJ0ESgQpXAJ5OSck0nNj1fxmMuoUmEizWZxubhez7oPn3Ytdeuj4RfFLHfoN2ys=@vger.kernel.org
X-Gm-Message-State: AFuF++md1nmBNbjrKr8U6YNwaOCoLydwdR19CHtkQtE120VTdALgHX5K
	JyI0ejUK7W+dwsGB805r2dAOtsFvR5/msnfU518Fko1UfgTd85PUrY3W
X-Gm-Gg: AYBFou0WVpTQ1f/6JnNpI51iAQc9TKNn4RbOr4VtdYpcJQZKIs6k7nW/726AfwteTOP
	ZuhPCxNVj145pHYzG7GamgbRla5nyHnVeeF17FS3rsLkR+B2YlMawYDaIxtQ/nylkXPH3dbivc/
	u9SCg2EVHJCK27rEP9hTwvDXsFERiEr4fQLZYP5ox8GBXq1UureDdH/YS+y4HwY/ICAfc1mg8gS
	SOvwIoNzn0zJ3pjZimurRQpSTqG3eyBl6TrHgRm6cgphh/yKWV2ukuUOXaMbTL3AkI1uJosiCq+
	4e3WQADrgaDLuAmUb1+XjE24J51tBxtxPF9FbMvNzQ9BhEkEceN6q6gJPK9NtlTwcZxJ2bKrbyT
	mzKjWSt9NqTUfnuQ/pKKj66sITrC4yE5NbeDr7HoT+oF6U6vHAes+KdsF1m1gUFBtB89ckzwuzu
	RoVoiSxbBWabsKzULDmSCmTgJikSQXENtA8b4FOT2620Mr2HLMAw9vhwuFzBjx761WtFSJXlsRf
	DUEUJnbUgn8LetbsJHqjhm+uV/KGHq9aO+fTVCDd1nwJMLYzo5vjVkJNpzliAw=
X-Received: by 2002:a05:690e:4892:20b0:671:1c74:666b with SMTP id 956f58d0204a3-6712454baf2mr4000584d50.3.1789338372220;
        Sun, 13 Sep 2026 15:26:12 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125eb1567sm3728689d50.21.2026.09.13.15.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:26:11 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:26:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org, 
 Johann Baudy <johann.baudy@gnu-log.net>, 
 Simon Horman <horms@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.51a5bb8e519d@gmail.com>
In-Reply-To: <20260913-b4-send-packet-tx-progress-v1-1-01b99569cda6@gmail.com>
References: <20260913-b4-send-packet-tx-progress-v1-1-01b99569cda6@gmail.com>
Subject: Re: [PATCH net] net/packet: preserve TX_RING progress on a later
 frame error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mark Amirkan via B4 Relay wrote:
> From: Mark Amirkan <markdamirkan@gmail.com>
> 
> tpacket_snd() can transmit one or more frames before a later frame fails
> validation.  The failing frame is marked TP_STATUS_WRONG_FORMAT, but its
> error replaces len_sum, so send() reports failure despite the earlier
> transmission.
> 
> Return the completed byte count when it is nonzero, as the allocation
> failure path already does.  Keep TP_STATUS_WRONG_FORMAT on the bad frame
> so userspace can identify it.
> 
> In a two-frame TPACKET_V2 test, a valid 60-byte frame followed by an
> oversized frame sends the first frame but returns -EMSGSIZE.  With this
> change, send() returns 60 and the second frame remains marked
> TP_STATUS_WRONG_FORMAT.
> 
> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> Cc: stable@vger.kernel.org
> Assisted-by: Symbolic
> Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
> ---
>  net/packet/af_packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 76bde7906d..b7e1848b61 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2893,7 +2893,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  				continue;
>  			} else {
>  				status = TP_STATUS_WRONG_FORMAT;
> -				err = tp_len;
> +				err = len_sum ? : tp_len;
>  				goto out_status;
>  			}

This makes sense in principle, but changes longtime established and
expected behavior.

In particular, applications may not know to recover from a
TP_STATUS_WRONG_FORMAT unless an error is returned.

If this sendmsg returns tp_len here, i.e., (partial) success,
subsequent calls will return 0 / -ETIMEDOUT, as if no space is
available.
