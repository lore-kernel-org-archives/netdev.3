Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE649B21F
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638465; cv=none; b=gGwisiDsr09QDC3ja3ahxZVDNtSHgdr7ipbUdqHx0oybbbmcZ8Qb9Ca/fFpwTzNuimsdUHY+KFp8uBRXS5DcNz0GyY8m2ej76sL/RRR3mPfRE2n+1RNKzhwSneoLU20WEznzO2uAxQFTG1gVLuGSaj+wMePFiSkfYlyhw3D0TkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638465; c=relaxed/simple;
	bh=lWNU7H3pGz+QanHlByzE+fU0z/aCmgCxswL4bxuI9pY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=seznmL0zx8+5H1H/8P8blAa+HKDWQDSZ7j8omWGCdElPjpdTEmgBtaiLFMZ+0U4nZAmSGirtnfk7kG+QXk1QoGTcif8yDMQ+niIvBukllm+zPX2mYQcmoDP9Z5SnufbUt92S263tGTHMjC61Ppih8u3JvwZ0+iLPojCmyUjr27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPXjRJTk; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPXjRJTk"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fabb1a601so3659150d50.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790638463; x=1791243263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e3hToWSUslmfTLFackz66sQP4RyQS9huTNRKW+A5+Rk=;
        b=fPXjRJTkO9QQmUN5cxq2WACa0mtkZPvpobN51GYmtQueg2VJiYVNIbA5KcysAGi7Et
         Si4to9I7y5fAwFKvv5lxShTYJcKySbq9wrtZ8gcv+tcEKo36zCIpe1vn+qCV0T99PRPF
         akEnJC22EX7xmwowWHrHsSdhFTUFwpdekPbErjNGLXfatUy9FvMvnVpimXZKA9RWmHYe
         Sr2fJVSPjjN6Z46eVe3NDi4L1yZS0s9yIaWUILJFNiQBBH/3zMCtMKFHDxI3qzsao2sn
         WntbUpo7dBbdSwRTL/Zov+KSPx16FIMMikq+gS2kOIXQlW0L7sR7E66601esMgvpbuh5
         PDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790638463; x=1791243263;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e3hToWSUslmfTLFackz66sQP4RyQS9huTNRKW+A5+Rk=;
        b=mqpy4uU76CmCzSg2b2H8dSQEUyGVMmPwpC2Dfrzvbp75yZrUnm5tcL1XWh1kN6jPPF
         u0fQnfBYSl67m62QnrWyv59a6InWtxaZd3IPDh5ze6s1u+SlVt7cP7FvujPPUqDYbLjY
         E+ZppNM6K71trqKq67jv2CNOH/UaUrx6uneufvhJT9/lhUY6f+X96CkXJ0y3nC76dTIR
         m79KBjrYD4WLJ5W/BXkjq7yyefoa+p7Z7JD3+o39gsAXMShJYqnzkgtI0GEhP8vk8Ydu
         L9knCnEC0aGR8ZzgZ8t48MJNLsbZ3kQzUOCaaqNt8mpVLbG5XsUIOBba3wl0Jh2Y596I
         kJCA==
X-Forwarded-Encrypted: i=1; AKwUvBynAh+LQJKbYmWRU56um/EwG5uoGk0rNAwZRbToTGXoUamHIINlVTo4e6AYDNNr+DiEkHm0eLY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKarCFNMwsImFz8DALvFs7KR9GJ7xLoCeIa3pivVbj2geQ+FDDF
	ZmwutwLeNPVVel+1bYyqVi9bouRivjiPhIkZHAFyGWzdY/SogkEQbRcs8LeB4Q==
X-Gm-Gg: AYBFou01Tz3MH3xkD2VfjCdA+L4k+zBCwFBZF3r7wYd0e8XI5wL2RC++oj7CNwzV5lI
	vMOa1+ghnX2YX+cQqmEJYlDidgDDvqfDZNvwlszd0ecimvgq2PvLepUDbJEidmD6n3NXlS2O+/S
	PqR4T6ykOnhNF70QJFjQDtVXR85PV+0JkPjN5Vjzs8rXbLNhW84z39uu2fhAPmV8XaGw7Jj2Eoy
	kKJRKoKGfeKO9s6I2o4cHDk9ZsdgE4+nve/KAcRgCuL9CDyHPsAeFtfg2saT1nCBdusuweFTOG1
	Lrn0XAMQVqPMKNlieviYo6T4EKvhEQjTlbJToN6wu3bCkf7abyfHafbKAGyakwOyk/53abLIM9v
	1wIvkbMf/n6cYXBJ/r/utoJ+XcS+YytsT6iD9pLVSdDRfhSWDR3zAFYEyuosYiKF3lDdzpHmWPn
	c2op2IG/ACPvmRhGKoJ5658U+JbVa/JF0lxMBOCH38KsO/Mwez2q7JkVkFTFSzi0MhLm1qtyY5k
	6z5OxFzxcVJfdWzHbcFnLLXOjMQPdvnB+9B5e88deeCfB8EvFpB
X-Received: by 2002:a05:690e:4104:b0:66f:c1bc:c084 with SMTP id 956f58d0204a3-672ed46f22amr5198272d50.76.1790638463232;
        Mon, 28 Sep 2026 16:34:23 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-675592851dcsm1264207d50.9.2026.09.28.16.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:34:22 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:34:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev-bot+sinfo@kernel.org, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 Wang Zhan <wang.zhan@smartx.com>
Message-ID: <willemdebruijn.kernel.39a32e51cb66d@gmail.com>
In-Reply-To: <20260928054920.1434795-1-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <179057071651.31693.213200671694715782@kernel.org>
 <20260928054920.1434795-1-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v3 0/5] net: resegment oversized TCP GSO skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> On Mon, 28 Sep 2026 04:45:18 +0000 netdev-bot+sinfo@kernel.org wrote:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> >
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
> 
> Only 1/5 carries a Fixes tag; the rest is new feature work.  1/5 was found
> by code inspection while writing the resegmentation path, and it is covered
> by the KUnit case gso_test_tcp_limit_l3_proto() in 5/5, which fails on the
> unpatched tree: a tagged IPv6 frame is measured against the IPv4 limit and
> segmented although the device could send it as one TSO frame, no crash.

If 1/5 fixes a bug that is reachable today (does it?) then it needs to
go to net on its own.
