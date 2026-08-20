Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AB389453
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256845; cv=none; b=Qtd9GnCqIMBvLih0T8nUbUb+XQWCQIGNpUiD6S+dcq0s+b2nX9tTZk4Ri+Ty/UTlZTAOdueBUzWibVvmAoSWzp2NYhvniQ7QTG6WHqEF3AnLGFpx9A9Y2r9EBA7eui3QEwUVr9dcrQGyxYveZtJq7DT6I3WZXnbkzB+fvqjaDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256845; c=relaxed/simple;
	bh=Ng/H3V2O4u1IyHpay8/lHPwCwoDVnQaObwgJaKdP1Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rY/w5q8+rATXnPU5U3GAfluSkfw5mddxooe3dRju6DOK0QWo7sNFE44JQupe8g/Xj1Rff4/zlCck+82w/yAIAlCULHW5wBl0b/TrPasCpicRv46Z/+I+58cJR3wWD2ZWLGESzN0VvToF/aSSgMHhDp4KHLPeuQC+D0mpblAfx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqb/tR8t; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqb/tR8t"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso530835a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787256842; x=1787861642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/pZcBVmHZcpyFoM1c9HOEpMfbGDPio4XjY70+PPmciw=;
        b=Hqb/tR8tv4RO5OFxjhxEiOSNo6SggxiYF4vlcIy6a36eJWbpdP26RNcHuhjnlbX9RP
         KYua8wzHeW7yAOYHOipZdL9RZUfRT1I3WBW++FoIC+4MDMwHrM4xdVli7F5Hp/puGTK5
         BwuOqbKn2PgXynTtPSs+DiH9H+YsT1GavIyqMmg2JbkeL/nwlNte7fYITUJW6tuGbq8x
         SDFL+eAE6nqTx6v3nYCy8/smLD8uu7lWipgo+C4LAKzi1hwYEfrekZUSClN1UE8MKfCY
         faRjh9rWDnrkdZgNpJeSGKkqw4671MI02qWQSRF4ta3iwajp5YgXaIIeTFDE1IaovTLb
         fUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787256842; x=1787861642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/pZcBVmHZcpyFoM1c9HOEpMfbGDPio4XjY70+PPmciw=;
        b=pOlaEWkvVkTeoyFsX+6ABO4vfWTh4bjU6ZmMwFDwHarA5r4oJ1znsXJAs3gtYwQQ60
         tlTx6GdBRZ2WHUnexxIOctB3SDFarp+CqiBEeiHUu4Ib6nKZJpcWEwjuhpCBBU48/ENB
         nVta3MkLdlSg2ZyQnObpw+gKbxKOHpctjik6Ua8XeSDdOAg1YDAN5kkbKcUdlkIe9Vzh
         NYT6mp0xfjrQ33M/6Ktl3NZTauD1juZxk3XEmyHAMg+cpedjEf5Jdf5bGpdMSNaemRRB
         08fUJb5jUBnppfVaNg/+mfZpKh+WlyLmCC29yXOPsDSQxSWBDb4EaQj12xRIv5vNoNKz
         Z7kA==
X-Forwarded-Encrypted: i=1; AHgh+RoWoepddWpn0IzdCp55nd/t1mDiTp1h7mqFTRkHLq8co/BuQDICkY086l84Y5gk2gG/yZwkn68=@vger.kernel.org
X-Gm-Message-State: AFuF++mfciIEzs1Cwf/rpHpYHa78kndCHbrNuRijdwzX09+/RLWwQFIp
	x16T4Vind+M+feUjUeSSryqbRINthY2UX2UOpJQKiaS4t2Z+gA4PXW0g
X-Gm-Gg: AR+sD13LMBYIWs1nmNl/7n6fQBfAds/hGHobWhsL4/xCuh/Jmj4a43MLVfmf11hL/2v
	4rsNjQptFKwGpv8jZ5tnx2jOTAxX81SNYzLEDeLKtWjI/elBCy7fgnx1tyKA6b/yZEJIavEi+Qy
	1iqb6h35XQ6LMVXnKg/090mzKTIX5QX/Ieiy3jz7YtY5HtOaxyT4JJv90H29qQ8T7GeuDKFJ7JN
	wNJ5tr0NBAWdvVRM4e04IMmvjTE/A3auE1J3OvuYYtrSO1z+wzzQQv3WTeY0GuH0ZICThcjxaZX
	ujqrUaEAs2WtzFsFgtI4wTwh5VVRCGq+pTUTj9CGba+WRZEJIGHw3FoKcTPkYBDJLbx5IdpigAX
	pxyv3E1XRmohdfglO49bO21tiu4IIxX4/M5yoB/7us5ohYnIQDePdrGIVA74UklobTtfPqTBd+3
	NZHHl+Ncyr7Bix86UcAADRRxt/wVSdV9ExsdjvqVK3yFDDu+gSl2DdvIx8
X-Received: by 2002:a05:6402:5d2:b0:69a:b38d:403c with SMTP id 4fb4d7f45d1cf-6a42f18f10amr1234734a12.7.1787256842300;
        Thu, 20 Aug 2026 13:14:02 -0700 (PDT)
Received: from beelink.. ([186.247.160.121])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff1565fesm3016822a12.17.2026.08.20.13.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 13:14:01 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Yiqi Sun <sunyiqixm@gmail.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Matt Johnston <matt@codeconstruct.com.au>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mctp: hold a reference to the route device in mctp_route_lookup()
Date: Thu, 20 Aug 2026 17:13:00 -0300
Message-ID: <20260820201309.3634132-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817121432.3586534-1-sunyiqixm@gmail.com>
References: <20260813022102.2792032-1-qwe.aldo@gmail.com> <55cd94e61d68d95e9db16f21980a532f4edf70e1.camel@codeconstruct.com.au> <20260817121432.3586534-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I've reviewed Aldo's patch, and the approach looks good to me. It
> addresses the same issue I was trying to fix, so I'm happy for Aldo's
> patch to supersede mine.

Thanks a lot, Yiqi -- and for the original analysis, which flagged this
first . I appreciate you being generous.

Thanks for the review, Jeremy.

For the record, this was applied to net today:
  https://git.kernel.org/netdev/net/c/408da1df1811

[1] https://lore.kernel.org/netdev/20260731022926.913865-1-sunyiqixm@gmail.com/

Regards,
Aldo
