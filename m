Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682612;
	b=3AvN3FGLswxJ4qrknVd5oRzYQhc7txnhGJm7hUNS/37GrWslIluQ1fdSLts3TmbvWMgx
	 PLWt3IrBWebjffx48EP3OfQkP/FyOLgt0/kRIL8kpTF53owx2GKWX8hd3r6luRzpodwlr
	 /PQO/pN6msoSvQlBAC/uHQInwe8CZxwCnMphldq07MqMxtBb3bnBMLj/jg7BkAdp/kZHZ
	 GUroIBC9cl8U4/MmBrkjnX947AM8Xoa70vkSYBQjrubMhKlHBvepFPm15waA2tq0NxXuh
	 bCrzrqvnLTxjkIWh7ZJ6JdtrefwPoz1Ti9cmjZ0L40QcshxpyrKVXrBgIQmL9ccGgNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0aMMJVhb/yYciWVQAAWCQmERXG+GAY5iNLNs2fW+mSs=;
	b=lHe2BxZV2noDnvIk2SgX3o/yxvJ9ppWYZls+/QJi0Z5iDiWSnWUmDumPysoXRIFTrVPP
	 d4A7aYkgYccGyEW/IGT+ZYM5I39dJPn/Sd+dg9ybUVGB0OKSqUw2ilC0I7bOUUmDsZRuX
	 TiuWSdMNY0VxuKO4CuHk9aVI68kJkoTwL+r6DE/8knYPRu2BrDAlTLEwbRgwTVK4d4nyv
	 W1+JlxtMVovHHIw5yhWBeg6sLzAFMOh/hcOcOfepnK8XPjSawpFh7IUL1DdLP9zgSqWCn
	 OglXItn4VRtEjBwnPWVnRIiMe6XtzV/j/7Q2UMh/RyWEeM1uLjhoS+fylsnbiq2E/Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CPcXOyXn;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EB606ACC3
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 213EB606ACC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CPcXOyXn
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eafb65e169so593373e0c.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682611; x=1793287411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0aMMJVhb/yYciWVQAAWCQmERXG+GAY5iNLNs2fW+mSs=;
        b=CPcXOyXn/DGVCoqRgq5H5e+9MESWF0a85ivXpvn4UAya6/ZGP5UeA1ZnBuGnrLRFFh
         AjTeLjFmwRxHq8yXsgXZifiYpBQt1XUZrwvevsxJOMwGhjf0rH/Whkvpl7ZfhBcqh4FI
         EkqUwAvXou+0EOX5+Tuop/DT8j40mOIbwsI6KjkNrQl2CingR5PPEtNwa93mtpzcyZJ9
         499FvypsmD5CI57ewnqunkmU9A1sURyIxRWlx1OL700rEgMJeqf6u0i3K6eGabqivnsn
         V2Snh5TTHl7hhGWWFhrr5J11zeaZDwHgcDLXJ5k4aVNhhs1YhQ+kbCY2ACAYtEKFeS6u
         9SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682611; x=1793287411;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0aMMJVhb/yYciWVQAAWCQmERXG+GAY5iNLNs2fW+mSs=;
        b=nYoUSh9DbLye0iivAhOAngeedjlihl1N94r/4/PETltQe1Z/4e1X50CP8Gvs0RT9GV
         c8lZid2UmNv9mIyo6w9f5MydbFVZjW7OQe65obAeMUUUP0vKTnNuy79UhbaXzG3Twh25
         +aPOncj37cEALD0tXgDAfSC1X6OMCm5Uxq5OTyYpWkjHBpm/ZPpfxIU5lCIzx8Q7nSFR
         u5YU7wUCmuUEGRQymimMsAXzA9mE46YivFLBXLy2fJ6rDqmjBJQWDOted9Q33Ivc7N1e
         6OC/7U/HLwR7Y86KAR7qp5shUsuOZd/gFdzjjynwU1NVXCt7FzY9SISbYQb3W+m/ly9F
         Wh6w==
X-Forwarded-Encrypted: i=1; AKwUvBxFu5er69Lkqmu6y8O+BfQVZrFfkKeXD0ZOI0Q9aRR2a2BJHmOAPHLNlwmPyx4wyGGxQ4qtfu4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJh4V7Yd5+SnOgdOvOC9QT0n4bU7NwPbhJ7aZj60fJqnEvtN0ZJ
	sRFIiUhq4gZXt264zLoybemA7Yo4y/0E/O3ACkwZyz93fQNgd7DC4hSq
X-Gm-Gg: AYBFou1uAn0gkn0IVIneSkYHsy1yNBWtoJ3LqgsMHw4SD12Dnp0FHs2GSLbf8v/Apfh
	5WRrABxGh4FpLbTyxFqaNaph8nfgQ/8w3DbIb60fRFTJ71MN7RcaaYjofkIdE4IESThAhohPeYU
	FdCpK9NLDFd47OM+lJtIjNoYqstnAZS9POsLmMWMaXI3qci0S3Rs4XA8E5f8zx347jnPmAPhArP
	S1ApqJABIQWgLsxhMD3arLbETuD1mhH3HecRY5TfWeUibfDrZaR0kY0i/Geqo6rSBzsj3Y2EXBN
	JW3+FJ3THWpiBPknuPdCUZIsM2PKRPB0EPWBA1RwiyygaN2RklTxM3Av1lKaXE0KAVYK6LTub6D
	m+Hsq9+aCBBKDkMcUCf5gcYeTbKvaxLjrEVaGJuoI9Zz8S59n+UckXEzEMeVde9uIlL/YoxfqyC
	GT2Y6ovkSgwjnxSvJ+Sxtj/7qZ2zG+ZaAiOVHWoerEj73YuMdrenNWZkFjA0+TWkN1BJJI+VAeZ
	w7WdR2XlMWO+M5rhSApX9tPcIf/hbDaQapqzK2KrXX7BbNpqOSEa/d41D23rjZcF5ojAyB+AeRW
	P/R/CfDs0xj6SJrBIUhTi7GB2qvILJGs9EnkL44DS2Me8jSdRLsFOfEA9Yo5NNlwQAo0WYN41lF
	yxPPWNHf/vafiPOs4eZo=
X-Received: by 2002:a05:6102:290e:b0:7c3:90db:ed50 with SMTP id ada2fe7eead31-7cc9264dd67mr2189802137.17.1792682610974;
        Thu, 22 Oct 2026 08:23:30 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d12049e1sm6759034241.12.2026.10.22.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:23:30 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:23:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 Hangbin Liu <hangbin.liu@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
Message-ID: <willemdebruijn.kernel.2ed6416f82cae@gmail.com>
In-Reply-To: <atnAmOuzTuL-0f4u@kwain>
References: <20261022-self_unused_var-v1-1-8ab10a6b7f44@kylinos.cn>
 <atnAmOuzTuL-0f4u@kwain>
Subject: Re: [PATCH net] selftests: gro: remove unused variable total_data
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> On Thu, Oct 22, 2026 at 11:09:35AM +0800, Hangbin Liu wrote:
> > From: Hangbin Liu <liuhangbin@kylinos.cn>
> > 
> > I hit a build warning when building the net selftests.
> > 
> >   gro.c: In function 'check_capacity_pkts':                                                                                                                                                                                     gro.c:1249:13: warning: variable 'total_data' set but not used [-Wunused-but-set-variable=]
> >    1249 |         int total_data = 0;
> >         |             ^~~~~~~~~~
> > 
> > Remove the total_data variable, as it is no longer used.
> > 
> > Fixes: d97348474708 ("selftests: drv-net: gro: always wait for FIN in the capacity test")
> > Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> Reviewed-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
