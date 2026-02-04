Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C9D3C1989
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199111; cv=none; b=UwDIla/S2xK5PYeh55rj4bc7UZHiRyKfoxNrych9i4E1I3Rf+aeFyj4J5+BVvLf2/o2O5SelJ6bswOrXIuRm09Z1nJ+RF4v5W1AwWaqPIvD80jMqdXC5vH6pHrCdGAweKh8LPnF0KZunp1wn3Yah7z1zGyTZWlOmozxQRcTuvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199111; c=relaxed/simple;
	bh=RqUvHqsbdJMXbroQSbdoa+j17A8Lq78NDNCD6CEhGH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwJbmjffc8yJ7xxybZcB324hp/j8PMHW6WyLRSV35h+rSpnt3NFLUti7YedKAXHCbVHiJVh+trXmmTnHIiT1vy7PiPyJ54K4nZkD+tYUacILZ7tDMf9Jyn5e2RhIGKopMnRky5CTTuSIL4VfkyeM6GshSgpNLKySnz3H7ebicu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Km5MWAOq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Km5MWAOq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-435903c4040so4429487f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 01:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770199110; x=1770803910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsS2W/JwCUgw6NN0Wz3AYONgmZuWQ5joMlv0dByi4ao=;
        b=Km5MWAOqgKvfPhv0SPoi64vQ23QnUBw9q2/Ua2FnDxfvG4yejUVVUVKTURAtFCcUsQ
         xUCskVjp7dw/KAlS1RyxfllziMWMOytV3ZKR2X1uBYv/qoRmNB4kKOafr+v5COwoOt4j
         475IIpIpCnORYHO+5VkI5u0Qa3VnQ6GCLBIH+Jm2jebh1aNrW9070zKmM/xzFrwzZ9ZN
         XfVbC+hI94PN9SPGkoTQ4xsLMSMrsnjd0Q6TnATV7JVJzaY47y9QhypUe9962Y3F0k2e
         IEPuZP6WjrCJh/Oh+mQsSdTDqVILIJWiTyyh/F7ZZaPV4qGikhpvv8UShGn32T6PXqPA
         zAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770199110; x=1770803910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsS2W/JwCUgw6NN0Wz3AYONgmZuWQ5joMlv0dByi4ao=;
        b=ZJ+HrK4zMnVSinRC6A74r/VH/6NrbnN1z5aUnvaAwavcBn6S3adPI0qxbptrFr9yus
         DCjALed8EUnvgZAHM/Ab7CMl1JK6FPvl02wxsD5sbwqkh9gXx8W40T+eiswIs1VNyejQ
         3Eo4B+w3NFnYSqvqzOvqwECWMLkYOGpP4dSj/YXNlgt103QBOlXKlaWZiYzyVrSwYTXG
         DmVNGBQuQdVsLyJbAztaL/2Kt16/xJAz7mzBBi3uYtGyBfyscbPIFJoi28sOt4iNA9Yk
         tRIgS6K//9/2Uc92lRJvDpC7QVTl7vrr68XEaAmY5GaWY8zJGy/Kda12tbkY2RwkcwPH
         xcjg==
X-Forwarded-Encrypted: i=1; AJvYcCVGVbRcxOqJXAv0WSy2HCd0OYst6mKBTvCKgRzC01Z/MHIJMRF23p7CUfTFrfYTUArJAgfukHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aXs/y8MTQiDx/ONvvcMVs/KFWPe19+jgQtB41s101LDWaNuH
	/yrZXNiWO5J72ui+yxTuXiYXasX2eMCgIUqeIN6AZtdoxom3G8VBfocC5XUfC3ZYneY=
X-Gm-Gg: AZuq6aK8qtfEndFDjFgbQeZcLds67Qgsx58ACWgcTTAOzDfrJT1O6QTsXDOsotuNpin
	X/p2J0cePFEssr1un2+QejwMY+SLFmwLJdkFQvC3Z6RbzNJ8uD8cVlunmw7gQAjbF2/XtrBSwP3
	7TrFwuRyHK2iEcRt05CN7t6aPdzg7rJGbs3oWkB/lJqr0NkFyQpMksfo+Zj7n3L1lEn7k1y24un
	3MBuF1oDQiSd53YoEAVbSGlSx/glJULmFzW4fxo/5naX7HSo0AsPRxuvW7PLP2Bu5R6iqjMmOvB
	N0Gh5n/h9lDhVUgbVdlgFqrYqaT2eBA6dPU5Nd5Vr5f9kT0jjZcIbnG3MYXLhC5AFGG6ktr/Y87
	hPZEjoK4Maxv7sU5MKta4UknTPsAWIugfN9IL9RF7B/t9+usfrFVI3oTcsW7rri9rg9myUCyHbm
	zvx06iv+U7jzKI7tVY9yk=
X-Received: by 2002:a05:6000:290b:b0:431:b6e:8be3 with SMTP id ffacd0b85a97d-43618053a95mr3496064f8f.38.1770199109610;
        Wed, 04 Feb 2026 01:58:29 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d02sm5028086f8f.3.2026.02.04.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:58:29 -0800 (PST)
Date: Wed, 4 Feb 2026 10:58:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next 1/5] devlink: Add port-level resource
 infrastructure
Message-ID: <tvw3nu7emtvoozmgsskpqqxej74ku4pprztx7kmy3vyv7gygx5@tpfdfghwmrru>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
 <20260203071033.1709445-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203071033.1709445-2-tariqt@nvidia.com>

Tue, Feb 03, 2026 at 08:10:29AM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>

[...]

> 
> 	DEVLINK_CMD_NOTIFY_FILTER_SET,
> 
>+	DEVLINK_CMD_PORT_RESOURCE_GET,	/* can dump */

Hmm, I assume that "set" is somehow on the horizon. Wouldn't it make
sense to add the enum as a placeholder to have the cmds
together?


>+
> 	/* add new commands above here */
> 	__DEVLINK_CMD_MAX,
> 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1

[...]
