Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BDF3A2543
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781316243; cv=none; b=fyXHXRnJjbANzo3BCQLl2K0W5PLx/D21mEb/uytmTxJcQU5WWlUfr/0z7Udi5luoICBl2nQxclA83BMjO66PjQCwAtrU603QkKlnS2setBET1NNc1QCKualLZ+NSvtHEpB0eeewNuXSN9tl2EN2284SBakYeTeobtRa+zAe5nx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781316243; c=relaxed/simple;
	bh=BF63f8tkkJfZ/bY07JtFT74M8MLMPf3ZpoYhZ+oniIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTdrbsaTH48rnHSwtKGmVKfxuKDIS+HOILTAZnLzsKxEMOqJoeTDei3tAOR1Ov91BhhPA2n77LVvGtOFsnckrmOQkDDKHMNNbAce1CVI1NFI435UFqzt5sAavpoflMZOelKnW44zQO/fSYZN4O+9aPpxkTbChGNcfde+lodGY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhqidihH; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhqidihH"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so1043621a91.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781316241; x=1781921041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qvlrbvjYmzCXoLrV2hsJdEbJOUWSCE5NGHj2A3xomvU=;
        b=nhqidihHBRXjKuyI3jLI72GFUIyYnPkVmKDpuWeQ2HmmDsoLX6YgMwVx7gSWGDpv3E
         NppSpLpXY7S2oPkobyW/KW+6RftxJKJriOz6h75wqkk+d3lCwbnfFlQDMbi1/cLcAm0z
         a08kVwWd3Asjc6ZHCzx8Cl3kI2rjahh9QxY/ka+Aljx59VWbluWC0/XIe3FPyGWJr40Z
         v7t917/zN9x+5X1RRE1ECsWmQkP+hlsySBGx1m+PONN4wgo+BMjiaHf7lOXZhh9E4RA4
         w1bMWCTyD6LPmM+nyfG5ybAfcs/DMh2cXx4CwWZhMDCpekNzNpa9GL9VzkQNtPV55dJA
         ngAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781316241; x=1781921041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvlrbvjYmzCXoLrV2hsJdEbJOUWSCE5NGHj2A3xomvU=;
        b=UXHkDM13xoJscGJH+9uJmj+7qYT/RkU4+GvKtVc1U009KfovjU87Ax9tTAwD6bI74Y
         f67xGuGR9ypudTNy9ns+MrA2U54ahMcvtoUNp7f22SDm8hCBKXmsmcgKqc48XJQBC9Mo
         Ow5F8I64nLMy748fZvZriczjMRK++ugFU9It0Mvbyyjgjy55aQREHeLZ3QseIxwsUsSz
         fFwhvU/YmN88Yckansb3phKGq1s3UlR0fteva+Sj/zccGrq0bgJ3I5YdTHfXA9upS9hr
         kDyscjShEm+R5dOcSL5r4rEZE9izdy/ptTzMwwHVdUnxPzzk7amzprjUwEc2c3zSCdtK
         qErw==
X-Forwarded-Encrypted: i=1; AFNElJ+hsYUkL7cUCioSAJmgTZ1UfoWz1++W/KL1ktmxYtidkLP9jn+Es3/L/9JCh6iifnOIJUAH19Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YycsQF0Ed5pAtIWeqcz+0BZbWfxeNDzNwq10SDItvbJcm+CbNIo
	7xYAfF+gi4PhEj+aNuFawMKB8uDtto/6oxCX54WxqW8Em2ZqbYxQMGUU
X-Gm-Gg: Acq92OFrJ7MkD1fCUbPqydAdWKDHd6U6J86xVykFH2J3IkYIHmLQ+t2DUlbSCbBvtpD
	3nOr2ybpSqjOC1xG9TpJWE2UXygfryS8bP7HQl61zBu5jg06tXTxlr/dyZNNG90rLFXsp90ZiRv
	WQ/VGneNA/SLsUqQRJNyswU60I/lcUB2mLiXxD7qBYhIelzr+MAujgypywQOd5X/IL5FVJfLv2J
	t8b+ejOJUx9q/JCxmorgheB5lTnlC4DbwjRuG4WUwwzEJeIWZ5qAEx2IA2wNEszgwWB7bnrS4WI
	G2jbqFlcSC5UKJFGeP3j/TNRkCGgyIZqw6V/j5C4/4deb5cc9llU2l1oZvQAjtQC57kSv+jGtIE
	i3OA88Hg8jlmu8WtKZI6IZ/BH6vHPefmKr8x/fjamxxj0iZdSTivJhRXiqIYM0122BSafQGyjuU
	nsLyEGcyYOnYkI8tn9
X-Received: by 2002:a05:6a20:2d14:b0:3b4:6265:3786 with SMTP id adf61e73a8af0-3b784026fc9mr6690558637.43.1781316241406;
        Fri, 12 Jun 2026 19:04:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8665186d98sm3006091a12.16.2026.06.12.19.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 19:04:00 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:03:50 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, sdf@fomichev.me, 
	razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com, matttbe@kernel.org, 
	skhawaja@google.com, dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 4/4] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <aiy6fWaIILSj6dpr@devvm7509.cco0.facebook.com>
References: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
 <20260612-tcpdm-large-niovs-v3-4-a3b693e76fcb@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612-tcpdm-large-niovs-v3-4-a3b693e76fcb@meta.com>

On 06/12, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add a new devmem test case for binding the dmabuf with rx-buf-size=16K.
> The test sweeps RX payload sizes straddling the niov boundary to cover
> the sub-niov, exact-niov, and multi-niov RX paths.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
