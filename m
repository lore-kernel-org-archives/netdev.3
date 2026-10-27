Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069504;
	b=0PcbghOsWLBNXOfedlsGWRQizGNtgn2/j2mlBP3B07AMOMZnFttG3UHh5bHBaEnde+I8
	 MQdUoJOwLqtjl5MzYH1zoFDZoQLp2K13Uzm4zHjFtb21lYDubmQpRrXnB3JrY60uha/u2
	 8TH62AnQdyH58ADAc65xZQVvYfXlYk2qmIDZMgP3oM/Ejq6I4Lq8OtbNXnz8e23EhnU3a
	 vrIXb9xOnZAy3LZwnKUvQuwKoHh6XKxDUYG7G3ybNzq4Ubqd7QI9k9B1rlNdelpI2A555
	 tF4K2sNbgOn/53zUGheNCwbQoeSkV9Wg2GSXK7uH20MpDfaxVOwQbd6aMGq8j59wNQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:From:
	 To:Cc:Subject:In-Reply-To:References;
	bh=QpmasV/u6brzL15r4wNT1nuKhFWCE8ME2HsJ6/xHFKY=;
	b=DOIWwSjAG8VnuFoLUtQ44HdABW3RqUBYZCx+ldCwFZlnYkmvmF/jlcIc6WWcMmYFCbm5
	 cs6VL0EpMvs4WalqVUqWSyf8v2ea5Jv5cjN+NP9EFGXlIiRUtyfQCOlGZ5TB9t6r5Vtr1
	 NrCxUrloPWmxWnmRP8drNP6XWToAGJCOjTW9hx1/AM+9c+3M1pzJIpZ5toe9LPtuu7TE7
	 cHCxhfRkOmU1Dj0RE8DF6jlIInDT4Szdzt1ft74q6owQWz7Ng59tv203vtCKcPouWkON4
	 WMHVueTy9+Y4bIruxi+PBBpjKqLSDHmOQKW2hDZbPS08cLXdbaswySrz80WFWMqaKIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V5IeXtGD;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F4606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B60F4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V5IeXtGD
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e74a32a07fso3710435ad.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 19:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793069503; x=1793674303; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QpmasV/u6brzL15r4wNT1nuKhFWCE8ME2HsJ6/xHFKY=;
        b=V5IeXtGDuRPEdgnnTuwKO+makwAV74Tyt/skZ63OfmEdmAHC6FhdBpdhJDUjIoGTzF
         RHRSk2ZEXdjPAPTJ6vQYylFD3fjZwQYyLort8JrEGrQdYz87uGtROlieAzucaiVBQkUG
         zVCzOo1m97X3BcaYZo7mxWmPwBeFWfp00Z24WsghVoPtcsRXBwFgsNiEcHAKrI64Y4AZ
         g3+qaVX0AVvRJgrC7+izxFhroUrCcgxYl+lT5oxWhbavE4lkZwN9zmvhy/EA+CRPuSD4
         AqLNS8YmondpUvmZY9jRW6aPwxSq2apkh+pHcjYttpSvPs9aRR0FJq/OqXIiDp1WHl6d
         O6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069503; x=1793674303;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QpmasV/u6brzL15r4wNT1nuKhFWCE8ME2HsJ6/xHFKY=;
        b=UpbQjVgXnNdT5ypufI4Z5vEtVk/8yBD9z4YMTcCsuptWccg2Ie1YmX0bchtMO6MwOe
         078BMycxeJs20qHZTb62fM8FvgUUVlG4PiQWxawDURFuaFTeTjsRSPYc2Z76xIZ4YUDw
         rNNOiZEYNiO2GJrWMtTfrXcutCdjWMz9LkkZRWyQ4zXCTDb6+C46yM+evifyBO9LieSO
         /ChfLJB1tQLLdYyqHz51cEAfqVPxkXU93VMPRiqSOpbfeMJmVQDIHhvTP9DDxVbtv+qW
         SJQbbWTkRNyOBtSfSs6ufxi+sUNUm6rCw9O1/ZpUhAZi2jbg8SfcgvnxeP7o5zTcoiYQ
         GUyQ==
X-Gm-Message-State: AFq9FYKvHXBb8lbOPwPZNibcQkMGAFacUc6Am6Y3f7X7K4G/w1G9pCW+
	1snD6t7+9cOvvGdovQp27kvzgMLds7mKxpDZbBJPYoi6brFcZlUlIWar
X-Gm-Gg: AYBFou1dwS1DlgBpTUupMwSbtVAqANDzLj/zxE6Pn/AgpToPAPA0LkBvxOzUkQVI1c6
	+v7MJp50m+Q3R15BZ6d0qzu2uM2cSEedoUjSSoCfCG/t1P41/GfebaBgA9avKvRHWCZfXSmlU3z
	9zML9Fo4HwSfqpLn8qZkoZpCBx4qSx7rkM+3beafZV7/D8o5HnwMnvfcItwDz762GsuNS2XmnB2
	VH0PP2H7zXqm+JWQWzjQiuo45fzgdOM4UhKgjMsvwyDAeHpduQrCaeN2GI7A90p4p7OoLAwy9D/
	cYbF0yp22IevETis+0dxsWs9X9SHLk6cR6rEos/Hpr6Cw7eh9L7ZhNFeVM6Ou5HjcSTg3Z+5OcB
	R9gXDYhOAiEMd5Dkh9xEdqgXzZpaqgRqMHwUX7SExK8YnGe6DFLzaNHUpm7wlxyMdmEYFsheT3J
	Vf9mGIkDLXOdD6Es+BWb4JwgeLPXamniuPHsgRvM2ECWXpzEHIA76Bduj4jtaIDYUiImuSj12X7
	bngjVvnscfzeIHYqU7HPHRnLnLW4JerkExZNho0IxH1DrwLyetqoULwDh6BzbA0rAWSdCQ5zrvB
	Bi9PJFXiXdDbW0+1RkOvFg==
X-Received: by 2002:a17:90b:52cd:b0:3ac:9e76:aa96 with SMTP id 98e67ed59e1d1-3adead00d90mr10912437a91.3.1793069502924;
        Mon, 26 Oct 2026 19:51:42 -0700 (PDT)
Received: from msg ([188.253.120.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae406506c2sm1504764a91.14.2026.10.26.19.51.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 19:51:42 -0700 (PDT)
Message-ID: <1793069492.20092.6a150514dd@gmail.com>
Date: Tue, 27 Oct 2026 02:51:32 +0000
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
    Christian Hopps <chopps@labn.net>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@kernel.org>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    David Ahern <dsahern@kernel.org>,
    Ido Schimmel <idosch@nvidia.com>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/3] xfrm: fix vti tunnel device use-after-free across async crypto resumption
In-Reply-To: <20261019153247.89957-1-q.h.hack.winter@gmail.com>
References: <20261019153247.89957-1-q.h.hack.winter@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

The findings are addressed in v7; the series changed as follows.

[High, 1/3] You are right that the decaps success exit still used
skb->dev after the reference held across the async resumption was
dropped.  v7 moves that drop below gro_cells_receive() too, so both
exits now use skb->dev before the reference is released.

[Low, 3/3] Right, the queued-skb drop also fixes a pre-existing IPTFS
leak: the parse loop can jump to the drop label before the queued skbs
are delivered.  v7 adds Fixes: 6c82d24336718 for it and mentions it in
the description.

[Medium, 3/3] The reference is held only while the outer skb exists.  For
a parked skb that is at most one drop_time (1 s by default); the drop
timer then flushes the skb and the reference is released.  The unbounded
case is the pre-existing drop-timer re-arm behaviour of the
reorder/reassembly code, which this series does not change.

pw-bot: cr

