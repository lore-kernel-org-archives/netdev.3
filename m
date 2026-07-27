Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D0391832
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166031; cv=none; b=F/ezJ6NMHpdeyVX0B4Q+CgaTm4ac+9NNoOntr52nDSsAXEYWxyEpDXqc+6aIPqU+A0rRbKmep+UTS7TXYwc1PMQo2i1mwNhyJ1rcPMhXcgZ6tR/heyYdcWpzJBq0udcOALXmB5oj165GCds8iiUGm65fPvHu+slOTpANZ662wN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166031; c=relaxed/simple;
	bh=EAMczv1nszBVR/9+wcOrhNsU81s3RFeSw/W6R5Gzuic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv7/ZUtXKjevEk+kbjO5P7sZhmXcr660r08fXbAxpJoy7QNcKunWoTSmvtw+kYN81H7qdrRqgu/0HfStsErOLHiJ8FShs886g2ol7gCmehAwWInDM9G6G/ui2zNZZ7qW52agvD15tVfZGYZLWlcztLt9iENUWRu+N3kJghFLAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRBAiGBj; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRBAiGBj"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc2c6e0688so23548075ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166029; x=1785770829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h00hPgP6noe9BC3UX09XkAurvdybwJjf2mx/x9ihkss=;
        b=LRBAiGBjMiCzpWxbGW+k5yOB1dzXB9uIOmxpDNvwTGYd7hg9gq1a3nt/+Fflpss0Wv
         yIwYOhpSedXjRsUvbYyLTW1aDnDxoGB6TujYu6Z3QX0fotdxffwvFXSe4lwmKiM90hJQ
         eB/avXO3H4ygIt6T/l3U9cOWPPf83q4LpK4xTXZrvZN9qBrVl7Bz5a8XeFfRS63lISlj
         s+Pmn/nYKlAmMy8mmNjzn2lzvESWIlPb8KKeFn/+61CYIe6D7FE25Ef3GC5UJDgFU/UZ
         TwGTlvt9R6I+LdQh641iDsxM1x8duh/Ii+iPggHXM4C5yNN9Erca+AuTzabQvOT/uIIF
         yiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166029; x=1785770829;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h00hPgP6noe9BC3UX09XkAurvdybwJjf2mx/x9ihkss=;
        b=IpCi3ba90/5myTWXCeF0/mPV+7ST965eGUhcU5B5qhEAF6vNufpkE3QY0h3Iaad/kK
         RKXNklNAJf+vHbl8mXQhhkkySo0qdX5Lr5Rpax4KD7fkMCwqwyrPMmeKuRmDPzRaGvqJ
         rwAJ7qzo/6/yXUGColEk0QchOMcxbDW3kEb8KyO2mpu1etOqGbsoD+Jw/NKHbej4strx
         jh3pfTRlA7fFfJvPITmcEWLBRHO3FTwtXmhcAs+Zb+0Zg0WHMAS8zA/vsB6wG1EBN/WX
         RtBJ3w6iDSPZg4lFeMilJIdgJmwbxG+74/WpI9wEs4zaXcCXE8bqulNDjj+yA/UML9nA
         +6UA==
X-Forwarded-Encrypted: i=1; AHgh+RolNHoLdD0nYZWiUzv3lFc8HBhAY27ZvI9EsHB94vKlqdhfV54NaPuZ1CSjT4X35bQGQCsZvNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ZiU7b10asehOVN5M668CPCnNCxOM7oCyvnMjjpIDUBqe01U2
	Jf41JXi/Hoe1/vagPbA/VJIvJ2e/9cHOnFyfLCIRwOdxfRJyWUa21BnD
X-Gm-Gg: AR+sD10ucYHE4qXeR98iDOfwGGDloR7fVEA+Zwc/aBmjzxCza9/O3/SKPghjOvYrqpq
	nv3aaX9ILicM4zhY/mnoMr2tTh3TJAEcKVjXL04/4LngYIPo/J/YuZi3ZxM9iVoz70BtSi/CF+s
	g8wP5PhV3TObOg7ceJP5kvBmrqeXpmkXToOKZ+Virgk4zBg6YgDOR8U6qYKmcaYipTgqV/RNQxr
	IR7XaPScpnBKgyvp+fK+05k5bOoJ5DQfSckzLVrzE8EvoBP+20H1vUVfOawKsnfbpjZp8c3LbwB
	hYkYp01G/8ZF77wZqMLVlvsi93WjzToHs7b9BGyHXorU0nQCk6SNalF1ygl1wUDrhtRcUhcCgqc
	/IOGyg/ufYANGqcRRSc3M17HqcKBRMXx4vLK0+RyuD2K2g5u2jEl6txEZ9n/8dkXkKJ9BDpI=
X-Received: by 2002:a17:902:d2c9:b0:2ca:53e9:1277 with SMTP id d9443c01a7336-2cfde6877c3mr85353625ad.1.1785166029425;
        Mon, 27 Jul 2026 08:27:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b44sm37239915ad.27.2026.07.27.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:27:09 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:24:58 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com, Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 3/7] ieee802154: convert dgram getsockopt to
 sockopt_t
Message-ID: <amd4RLJJZbsZK4TO@devvm7509.cco0.facebook.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-3-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-getsockopt_phase4-v3-3-e89627544639@debian.org>

On 07/27, Breno Leitao wrote:
> Continue converting the proto-layer getsockopt callbacks to the sockopt_t
> interface, splitting dgram_getsockopt() into a do_dgram_getsockopt() helper
> that takes a sockopt_t.
> 
> No functional change.
> 
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
