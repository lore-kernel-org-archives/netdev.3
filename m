Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465F50AC14
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466376; cv=none; b=hfP5H4B22ZEsBg2Z+cxewXVqkBhA/DzS8XUrI5oLA76MgbzSRCWoL+Bpd9QucjcOdrTmHfqVksy8sN0b11KXWavTnUx+N8p3aBkV/ccL69Zg3DKcsHUe1cqorEZ/vmBEabH+U/h+vA+uY2o7eRLCngP7h3RrGr4BGRlGvUernMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466376; c=relaxed/simple;
	bh=if3+2uAeCRhbxNTG1eS3XV/6S15lptrmfnU/a0gittk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0lB6oZ6i6yQqs/l9SUuNzS7I+UXo7ycJ8HaZoGMJh7Sgh6sMd6VWE87/xD/oFyf9hbbZoBSTQ9bFDZzGjrKi1WhGZunLseXE3uBP1SJ97McUzF4EZDNdxu35ZpGwLxacnm9sZ8pZUz9k7Se+jXITanubP9S2m0HGgZs1/nzrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=jiVKt2B1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="jiVKt2B1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-395cf2535acso274839a91.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 13:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788466359; x=1789071159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5hY0LBIvlsS0CCowPL3V+4aAcjVobSM0xuyxpYlgF4=;
        b=jiVKt2B1rWLD1DjR40a9eyvgBpGZw3UYqW6V0ZvwwjDvuckmQjLfvK4r4Gywn1sFVf
         YI2ubLg+Zfve0c8vXXKxwSPtOBeXEB4nD1J+Bfu/ucr4WDsThDYB1fCjdPRA+INjVW0T
         XjBAi6csLbrf3XSWrjaC+zgP9beP+OZPsf0qLpfsZnNvHVdLRuv7VkiR+5ZKghVWEz+p
         VuyzWlpMFtdjnA0jEfMROEtq2yhN+zgfVYxwAAm4vLg02N/Uug4rwIXjxce5ZwiB/Ps1
         5GFlPrFTlYuskj37KznCyxZA21kJnN/EyO9dC3N4yWVXG0Zq6S4Lnw/JNknI4aGDnVX1
         sOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788466359; x=1789071159;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b5hY0LBIvlsS0CCowPL3V+4aAcjVobSM0xuyxpYlgF4=;
        b=KgwE+Ilc+R0OcVKd0BNk9Azu8tvz1yH9KB3iGfqKsUWxl9SlR3yaAK8K2//h59HAA3
         /nRo498yMNkfEOOMO4T29ZAItZJiKHsMb6nwxHGkDPalxQtvYf8DxxQ2qCOKVSiTE8rP
         z252+kEXwFEgQoYpBX1BPgHUlA9okueFGdD3MgFoDXsU36HPywtDSrENYSbNBRJYrVCP
         rssxCXlgt4B+P6rppCbGCgfKgb6nquQZbeJy2IrUW6OhIqFBAhXM7yaKdFo90tI6blxC
         fReKbKJlVBj8BRl/Xav2OV/pH4tSFe1snUvSUEVwqmAzwkB8KuDCuTEYGZJC2I3iaAH9
         omag==
X-Forwarded-Encrypted: i=1; AKwUvBxDJxVU6cX2N/S/r2nlSBcSrO1ziWzP7ZJ1uzL7GZIaVRbdAmD5dFZSy1b0zOPMq5l7UIs4DY0=@vger.kernel.org
X-Gm-Message-State: AFuF++nWNF9n41Z74qUJVG9cW8seQtqyoL0CkZAM/U2KWl4SENkeCDFG
	IsPQFos6HV/vgXr7YQNREoAdX+B+b9xLJUKUnl0YiDio0p66hWBKDjEubDMNTfSIMyU=
X-Gm-Gg: AYBFou2UeS6TppyNGOXBfssfeiIqfMlRtPOJi98kKG+5JwQCvviGGOFr5czsPjyDrIF
	jmB34khSC2AvFw7EvPIxOTNNsCKA0wv4W7pCpDjUx9xNzQ9SyrAchLp2oLcF8LbtsVDvcSeJVpc
	bEJKT5lwuvF32C9uX6pvqcP1DFuvTUMZvbDESK+LdfPqMA4La00p8Vh0ypjsEkm4oLiX97m/9Hs
	S74M2XesGHhADeIACAYeO0vJgGiWXAvpKd273+DFq7szbOSF+NkfbzYrkCHERcGLszbBlu0NmNL
	mO8ZodAONzXf7sOOLjLtMy+5kahIzb1/1pLVz/dYl0hhDGz+bdUVvL/HwXUiF3Xs9ljGo0GyFAH
	JFTPxY1Ibya9thrsIP94ql+6i8i5hnCvbxmJQa5lvhWYXiCGMgxX/7MD3+8YJGgC2zOxl+7FQxK
	vSePBTADudsWjWGQY2NuhPXUHorhA0DnPZyktb//OLtyeEIfDqTt3i
X-Received: by 2002:a17:90b:4d91:b0:398:c6e8:3fc2 with SMTP id 98e67ed59e1d1-39b27c42b89mr215418a91.4.1788466358809;
        Thu, 03 Sep 2026 13:12:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6951789a91.1.2026.09.03.13.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:12:38 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:12:37 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	andrew@lunn.ch, olteanv@gmail.com
Subject: Re: [PATCH net 1/5] net: dsa: bcm_sf2: bound the CFP rule dump by
 the caller's buffer size
Message-ID: <apnUtd3dvlQUEFYr@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	andrew@lunn.ch, olteanv@gmail.com
References: <20260903032611.3000029-1-kuba@kernel.org>
 <20260903032611.3000029-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903032611.3000029-2-kuba@kernel.org>

On Wed, Sep 02, 2026 at 08:26:07PM -0700, Jakub Kicinski wrote:
> bcm_sf2_cfp_rule_get_all() walks the whole cfp.unique bitmap into
> rule_locs[] without consulting nfc->rule_cnt, which is how many entries
> the caller had room for.  ETHTOOL_GRXCLSRLALL requires no CAP_NET_ADMIN
> and the ioctl sizes the buffer from the rule_cnt userspace passes in, so
> once an admin has installed CFP rules any user can ask for fewer slots
> than there are rules and run off the end of the allocation.  A rule_cnt
> of 0 leaves the buffer pointer NULL and the walk dereferences it.
> 
> Fixes: 7318166cacad ("net: dsa: bcm_sf2: Add support for ethtool::rxnfc")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: florian.fainelli@broadcom.com
> CC: jonas.gorski@gmail.com
> CC: andrew@lunn.ch
> CC: olteanv@gmail.com
> ---
>  drivers/net/dsa/bcm_sf2_cfp.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>
