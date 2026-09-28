Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC793BED44
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621507; cv=none; b=XNzwoQnwutLKUYzZlO+2/WBeOvAYj+gAEKkmQTwFKUjeubN+kswV3iBQnejho+zs6WTX8TBffgVpLjOOPoExIg7WrFilPXpeJGvTYkpvklaH5N+9Y0OnKGt+WoEotbz22glGNe4bQPl07apRhnpD/oRngQ5KrbMmJTo/CRKPtUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621507; c=relaxed/simple;
	bh=EBmE3giO3xcXmLQHaSN3V5pizTDx2BGOStLLtNnjxWg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hfMjSiHj0pKuuVH8z85BJWkAcIpyCs1jf4jEq8/P2qgV5w8Fasr+lz/qaL4sq9/SwbteLwAnEGJhcvULmR5QWqbtH5bcwS5XaCmrsWv0nPqVy01/4bC4MlDJx0X2MdFZfzKL2EMOQBf+jlTrN5FqnzEtCirF1JgNKghN/Oypyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dr4lDOvn; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr4lDOvn"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a886c555c5so21853167b3.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621496; x=1791226296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3egM1frRs32ga506avUD6lSWm9sZ+yGf/5m9pLjd+BE=;
        b=dr4lDOvn8cWMDpqyfLr2uUJLpSDHRtYvkaqRkfA9qIySAiiXO7TKdfE2PGyDoRxJMb
         7k9y2wXy/hUeDqZkwDSDGj/NLr7J+szGfhgp+wMBpLbPrdCysGEONA9rTUlabh3ESGe4
         jdI5hv/ZJfef+ywd5xGRtxMx6HDkrAvA3+Imau8QCD9O9hfdr/CZbAApR5lr7VoiF5LW
         +Be25mEvE84oJL3yaGpXCuBsd2s7SimW65zqMxNcwCbWtDPphIBAdbKECRzHugNZRiAm
         qkv9y50xrcd3q8MCmVAP4n1ywYBvFhKMwGGRn+P+HBQEz2B1t8v3X/puBDZtiF3IkhNj
         uYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621496; x=1791226296;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3egM1frRs32ga506avUD6lSWm9sZ+yGf/5m9pLjd+BE=;
        b=b+AvjRzCobUPFWBbImYG+uT7C6G0+QTVFIlkUIISiWok3CAh4qdcteOvLWMyx2jvdq
         goGgiN1OPhk8dWBylKaFnSYL//z7q781JMC3ae/fjyY5kIYPrT27uO9ycd3jPQFGk2MC
         QsOaHlIaJ8KTOlpahZ8Trj13BoiOGHAKCqPc3LoNTFXwBJiou73q/0VZDV8lh6FfEava
         SsIrZz0v4gw0cTYO4H04LpbSENBKjhF12uAyIAjFT9cTgzBV43UIu14aUlYYJIpf1mls
         9AwYtNZvvNEyUMH3s4NrMu/fvQZU5/qU0jH81/UovIuoSA2tToCIYbgEGwr4r64UPpMe
         C2Xg==
X-Forwarded-Encrypted: i=1; AKwUvByTy2g8H+LW0Lz9nifPoLbuHsLlh3f5ubGPtsXne3oifrhTDIl6rfp9aOdYME9FkKrrRzpRKnw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKK0J7dizhnwq6AOAYbVJcaFXLSIy37jM2IXt2EE9tAa2u2yy2I
	Kg59BBjNov6FN4sbRpU/E+0MRu7GE/cDUqvvfwNyxh8LG9+veOfUJENC
X-Gm-Gg: AYBFou0GRd3MzIN+27Jd4Mp4xhpH+HpILATumaMnHEEC9Z/vi/zPZOQ2tvQEo9YmOyk
	zQ2N4hUVWu2/GBH6QGS1kn2d0OoIqagfXhFIaU2KwEIku0818SJWeUxqjC77+o2L1P+j6Nm0Hik
	mZbrWrg+7fcRKTNOlz9Oi4L+k2cQcfuokl4ciDT3GqKxXgz36wZN7RsY/T6ki6KJ0k+cFHGQqcV
	pl6byPeRMU7cVxTgGyxRl/etlrSmIHW0yvcd3ufu8kG7drxGNpUscCXswYilsQYQUmwrMGtBGfF
	ypGZBRTCT6pzls7AwoS8D8jz/n4hDqSfPK8LYvqbg3dGHQ6LkOlnVo2QBAI3EDcG4QpisNV37Ab
	9J4Zq+P9UowNZ1//ubB2qmiHr13SmSSzdnxosWtVGWdFoF0/s17YRgl7Ngilk2SsTPn8NRjmDiF
	O9jRZt+geJe2fTwZqj/b1jmwTR8AZoymYrJg0D25Ibkhg/935gLfUp7QyfjPd3KRjv8jd74/pvj
	C6MLQJ1+dR3U2Yb82z6nSspPC1V0ymRfFPaCWx1n3ImYZO6maL8
X-Received: by 2002:a05:690e:138a:b0:675:398e:b887 with SMTP id 956f58d0204a3-675398eba1amr2715071d50.5.1790621495747;
        Mon, 28 Sep 2026 11:51:35 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6755f26183fsm329917d50.18.2026.09.28.11.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:51:35 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:51:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jiale Yao <yaojiale02@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Message-ID: <willemdebruijn.kernel.2d99358fa8ef4@gmail.com>
In-Reply-To: <20260926162554.163197-3-yaojiale02@163.com>
References: <20260926162554.163197-1-yaojiale02@163.com>
 <20260926162554.163197-3-yaojiale02@163.com>
Subject: Re: [PATCH 2/3] tun: Drain eBPF RCU callbacks on module exit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jiale Yao wrote:
> Replacing or clearing a TUN eBPF program defers its destruction to
> tun_prog_free(). In the device teardown path, tun_free_netdev() can queue
> this callback as a private destructor. The rcu_barrier() in
> netdev_run_todo() runs before private destructors, so it cannot drain the
> new callback.
> 
> After the last file or persistent-device reference is released, tun can
> therefore unload before the callback runs. Drain outstanding callbacks at
> the end of module cleanup so they cannot execute from freed module text.
> 
> Fixes: 96f84061620c ("tun: add eBPF based queue selection method")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
