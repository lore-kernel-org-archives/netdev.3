Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493123E9C26
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506442; cv=none; b=hDnFkPtraFszPvC8zchoTz+GyVqbntWyxhbEu5lMHMTSjEdUoUpes5afz4lmJSRj3CHyh7Dd7U76tEDAQnE4u94lrkDfc3ZwaNNnlCbRAZ3gjrfrNOYLXpAJAB1V2ddHa4sQyo5EzdNCEr5yrXHXfDkJJhIHFVfrOtwDVNUl4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506442; c=relaxed/simple;
	bh=J5sX2SrdIEkcShCVX4FKwqJy654ONaWz4XVjBJ59Zsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0Qg9AWxE6On1AGbS28d6OVngJIJZDWk8lH10cUcUy6Kz1Gn0ZOcofjG2kLCCq1Mha49gXe1j2QgP31Oqxk85yaTdHeyVA9tUlD1f7d7204StYB8NeM+F3o+7WyZ9eoie8ZeFCQB4Rffbg32mn2cbrIPsjQU3RYj42+I4HacV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUd+AGyf; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUd+AGyf"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c858b392697so2257332a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 10:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506440; x=1781111240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cklV7X8G7kZSGfZd5gIj6cS62hnTZV+K0oRqAnA4spc=;
        b=QUd+AGyfBLLv91sCllQI+jko5gOfwvbMq7QADa/iypeoGE1A1++yZbXFg3jmHpKBV7
         3cH8IdwXj1cHsl3+INuqFXIjh6zIHwIvgrnvnaAjp9Ihy+oXH0K+JzQ6TlyIktXeHj0T
         uIykVQ31cYeIFB6aqRtzetsk+7R9O/ZowUsEcw8ccxyvnbFhTI6jUzmeAe8jOS45hxZg
         PeQ0BmG1xvN5yNS7ACzYq1WbAwjL6gIl6JAxmO3ZR23GTevkxDHtr3hnKLc1O07CCRcp
         rw5mdSuK/JAHvTNk1SwLDs+X3FYHjlSd+fGmUGPYSEza862ksCg3ONJlKD2mYfqpnxDU
         11iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506440; x=1781111240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cklV7X8G7kZSGfZd5gIj6cS62hnTZV+K0oRqAnA4spc=;
        b=eFPas4opLNZjwV3V5xoTOPcE1zKVQ5AV9SR26u9DKchtLBbcoDrF2gDN0xUzNHPiml
         3A44D+9ZpuDYU/Xx9SvIuSdoO+9Qg6oR6Z9m0oEeo4ZhLezQWmt5JcFYX86QIJOLWFHv
         z6Pm982G+tLkUWuDmzts9cpahOGP8A434rJRGKGFcJJjR+J9z+rgcBVf9zgF1+16jJXN
         obxwRwYf1Zcj20zWxb/5Mq0iZG/lT6c8KVDkmF2bOBPQvoSILqb/pxb4HUak+gbr302e
         GiCPNTJMieucT9NWM4UgH2YDtOdZkVT3JLgh0ebynmduHMUF/eFOv5cDjT5eOfgydgZD
         OVZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+he6kzNaBLGWShz3qRDwI08A4URIFSY8uWhkmQsivbnJRW9JDXvTribCuCJwaiJufBvct5+FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDF0BxiXxRXgXHHkOU4241AF5uyDdI42heMYM/RBEvHoSSCg7L
	KXQiwq/o2ziTzXP0PhqFrnh/i+FD07qAJf+5fkqVvznQX8mqkF1x6xBK
X-Gm-Gg: Acq92OFgqdvR/qj2MC31OhRjXm7YfKZPGJ1lyN0ceZQU4DUSJZZdCNxCb5d8G9lrtwF
	w6P0nzfz2ry7Cpy9HwjKNikQhBnegOIaFHbKObJO6o8KnX6AsNYbqapCbPBu7fYPUC1k0DQJLGb
	MirrBb+iUMxTJZVIiYRJ+iw4ipX/cmGd1QUaC10vE/TRaMFGP/JeHU0DdcreZ1TyOS54T0l5epv
	3528brIkmU87YYl2WEfC6gHW8oNqRcRV82qzD0G5oL2hvHRBnKWddoq4aMUIR1Ig6PGM4VEZVL1
	WyBM0+6uKmo9lp+AgUaniy/X7ybO99a1SOp6YU9SMEfe2FioHaQxED78vl1LwJON759QYtKbj8d
	13k8AAvuLjSRFst+6GCKcaSTyS0Nm2bNLdx6XLC0NzON0LUNG6MXAe79rInXh8pjFmYJATs9K4h
	edx+nME/vjrUCxf2zHAPyOz1ejO0E=
X-Received: by 2002:a05:6a20:c996:b0:3b4:68e3:f16b with SMTP id adf61e73a8af0-3b4978a1ab6mr4790527637.25.1780506440501;
        Wed, 03 Jun 2026 10:07:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df045c2csm2739601a12.12.2026.06.03.10.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:07:20 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:06:02 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jakub@cloudflare.com, 
	maxime.chevallier@bootlin.com, nb@tipi-net.de, lee@kernel.org, linux-leds@vger.kernel.org, 
	pavel@kernel.org, jv@jvosburgh.net, michael.chan@broadcom.com, jhs@mojatatu.com, 
	vinicius.gomes@intel.com, idosch@nvidia.com, razor@blackwall.org, hare@suse.de, 
	jhasan@marvell.com, danieller@nvidia.com
Subject: Re: [PATCH net-next v2 02/11] net: ethtool: cmis_cdb: hold instance
 lock for ops locked devices
Message-ID: <aiBe8YC36vmcdFiN@devvm7509.cco0.facebook.com>
References: <20260603012840.2254293-1-kuba@kernel.org>
 <20260603012840.2254293-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603012840.2254293-3-kuba@kernel.org>

On 06/02, Jakub Kicinski wrote:
> FW module flashing was written so that the flashing happens
> without holding rtnl_lock. This allows flashing multiple modules
> at once. Current drivers can handle that well, but we should
> let drivers depend on the netdev instance lock. Instance lock
> is per netdev, and so is the module so we won't break parallel
> updates.
> 
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
