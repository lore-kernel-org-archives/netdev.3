Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482344;
	b=tRziRQHsgFaRSxdKlW3Hd4tn3KccaiYwI1a/7JVvkshrMjQipHNbBl6bijSLzxmGSJGE
	 o3nl95AOaXN2lpMxXWdkKpsq4tP3YDtLMkec77dJsb2z3UPbyITRgdQWfpU6UAGZUh1vK
	 i3rJxtXyYLKjfavH8X/iQoKYw4/dmjLsY/FeYVfsSiwr3KdqvRoaYUNojnIBDW+aY1mo4
	 nrUqTtS/XpQn263k0xg1A67D1E0hzfgYnbdTGlGzH/w2EMlmzjEyHFYPoy8l8DXpqN/op
	 BrHvDH4fHtXX2Lkctw3ldwvEgLsX5191lKNVyLFUq6HRflv1F18su29Gbnus5w403Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0MDgn22B2Gln4kDn6jyy0QtZqKwhZqAtnn1/NKsmOP8=;
	b=M0HB+nsh0UZrMJ0xWAthgcuZ2qAZlo7bT7ZmBh93HLNsjdXwuToOYwj9/UoEAK8Q0JJ4
	 /EQYIQ/RPiZalDlH3rwrkJC6Da4ch0LPG3Q26haxTQeCkPOFqUc0e1rcBp6MZUbVGb1L5
	 K7yeyWSWtN2W5nlSLvcikY5k4qiaz12XX1DvAVAPOZCh32I7tYUbCbDgDLJvZ1VoZBZ5f
	 dbS1IYptIK9LPFnl2MvZzyLxOXnE/WpvIXTv37SsX+hsvkB7bD7cI33YZVkuhlsz05EZM
	 mw3tyORgrTKAk6b38GWoF6Ywy3DBftinfz3lVlPjRQ0jEu9W5eiMLRe6y1AJN9g6gGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s4hvmFub;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321A606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F321A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s4hvmFub
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so2739990e87.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792482342; x=1793087142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MDgn22B2Gln4kDn6jyy0QtZqKwhZqAtnn1/NKsmOP8=;
        b=s4hvmFubg/23R7MjICEaX0RocR2izVlBWbQXLheVV3yMxO5xs5fcApUOoYUL5H0VsA
         39kw/f9IEjsNHHvxrQrKN5ZlVZd7p/8vgwc7NvLXcZ4iGjXOyHH7SjzMx8tXeQFxqPOU
         VQknwi0YwUPaWl0aGAKhr+AHJDJju2DaCIS/fdMhGcYgondcaUPlbsAplMhLQX2pW5AP
         +Z2g8iSReQc7aonc1syHO0HKtOIJCs9ACYOOV9PDK7K+ZvhUWC6XbykK+vzinxttypWC
         zS8UweaejF5EJULZyobQ4l96edwqN9U1NemR8C5tMjrO+L0Sy5ez5e2IuKTp9GLF8kdi
         b+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792482342; x=1793087142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0MDgn22B2Gln4kDn6jyy0QtZqKwhZqAtnn1/NKsmOP8=;
        b=Z3BXT31Vnz8/mvTalhARGxj6Q9bVUtzd8IHgoweCdvevHJUjUioGIq9LUs2SqQ7daM
         gTIsTmBdlH21aS/tVLYw7kyO39bPjdfDDAr6+WvnuzPXDSN6BazdaXrFD+qWc0V44UJD
         ILUd+80JAQmIv8lYM4bRqHsqoA/fqhlzLEb4B8k2hNq1cjfLF49rE6+NFhPbzHEN5IYb
         AxUsHyejNS30vVT4njJGASBEX44veK5Wwg9IWJ0odDu/L5PnAduY6p3qhigUDSgnugdN
         LzuROwnRPtxPh2pBONBsGWeEl9oyRnyNgUWjXxvINc+iXEZhAgtBcJgZ/yavvQ6Jlu3m
         mboQ==
X-Forwarded-Encrypted: i=1; AKwUvBziXgXwVNOu6eExfie+tTQRZyLLCKZM+pgP8a3/J05THUXRSiUtL6VeEzus2pZnjrCaBRZ49/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUrH7/Bpiw8wWmGGKQf4/9FtuoUDove3B1uZ98q60m/zYtK4cB
	lpFH16S8uG2FLyZ3YJS1k0VuGVagFk4tnn49ziulr/jD7iNUWlQ0mATQ
X-Gm-Gg: AYBFou2YkqzCfREN7wZ1JW+msfVAPZNo50iWUARePi2yBXBIPuBcOXd3QR1Vb7SRCgR
	jQnAdFzwOaYyyTl5aUiotrZUK8AYJaSKrEKVK10KdyluqlT0gswA5cWf7+kT9DuNl6U3qx7o1sh
	yzwKojkgTSTR2OEhlOeUi9Nsn6KdC4RWMQk/yFNYCQEDzVd1RJrkPtqsgmI/dXONmBxU6LYdBJY
	i/EZL2GKbijiFTkXNDozlnMfq5M0d4HpvSyG33XnSiSYGVVQePMNDLB8yi8uQ71NH/Ckr3QNKVk
	WXeWedONXZRc+PVscfjyFFfixseKtE5wcW4ccGznQ+g78tNF7mv+eD7ywvNk0B8C1v0ieccmr5n
	7F/UyRUZhzEpi6/pSFUFfdAtqwiCUCBs06vhFzaXWXbFvNAkfYs4QHvnlX9OSfH9QeJnd/yyU2A
	HbLn7ZIf+CwwwBMAJhnAaf6QFJB5RfgBGUKY5npT9nyiVlWhBf8uVCsxLrXe310kMUogFLSFo0c
	1fdMJh0UZKJHLg7Y0+0
X-Received: by 2002:a05:6512:10d3:b0:5b8:f16f:d4b6 with SMTP id 2adb3069b0e04-5be50a79196mr3315671e87.39.1792482342024;
        Tue, 20 Oct 2026 00:45:42 -0700 (PDT)
Received: from grower.astralinux.ru ([38.74.72.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a42abf1sm2466787e87.19.2026.10.20.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:45:40 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: alexevgmart@gmail.com
Cc: co+0ea1ac045375cf05@bugs.sh,
	davem@davemloft.net,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	xmei5@asu.edu
Subject: Re: [PATCH 5.10/5.15/6.1/6.6] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 20 Oct 2026 10:45:33 +0300
Message-ID: <20261020074534.277692-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012163331.45783-1-alexevgmart@gmail.com>
References: <20261012163331.45783-1-alexevgmart@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

just a friendly reminder
