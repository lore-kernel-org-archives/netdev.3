Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792576336;
	b=AS4m0PtHZh6a0AXOQza9roHv02q+lDT13WAseSyNtAbff29Z6RHGnh5aXWM56acFbx14
	 gdukMUCTUvjFpeco6rJz3e74Kzm/yiDuGG3KpgBUT5RkBRDx5nuJjzpe/8BzChruUAuRS
	 F6D4yb4yRRBddsg0P8rRGixXNMhEajUw+ntxKwcSNTDKylLrWmJjFKG4wj+LL+Yf43/Fu
	 1qBY34uy0vLKt/wz5qDBaq3Y5+U0jidMzyL4+462289D7Rglec47Uw4VQxUQ5hfdD8mDe
	 ky3RNK9y7Dgq0fYR77jLlr46XDa1Ddp5D+3WC6XBF81UQJaCK/6DZ/i+BBBa9gadGvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Jvum9vHoM5in6HyLcCxwho4XKzNHKiwHpUd+vconds8=;
	b=GwhvDOxNbajla78CXB2c3i3lU4+AjnXUUNWUwIYcd6JEX0Qojlaxqb03/35gBSeRB1HC
	 ZaC+3TK/+3Y7X14okZECv13BxyP93qlb4Bltmh3SA6vxz5WbMhQ64MRxVuZ0AHaog4BrE
	 UAURXAXf2oP8vYLSK1lLzRJEcuraUhVnkwUpgwOa67NLaS00TrCxX+phz8JftAyKoY8y+
	 5k6Pyr3Z17YvTjlt30/Pyd51Wyv0OJYGvl/V0KlnBsC+4prXa5rR/El/+uqBRn5gGCfb6
	 w6NmCIW9bfjvxsQ5+4kXxfsgtmWrL3LIgkNfYQMcV47GwY77hpX8tZ0eN9SyziButMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=bFdHvy08;
	arc=fail smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CDA606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74CDA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=bFdHvy08
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab38a051aaso4367717b3.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792576335; cv=none;
        d=google.com; s=arc-20260327;
        b=IMxId/pekB+YHsCpMglM3He42rQJmAXdmzlqSd9mp4cD+yI3aq/M00qB+shchXgvX1
         1dTO4zMYOVet/wqSQ3203YLp908gQtAQZZ6Ffh2QR6B53K2ftYWkuV5fMJmr7WNAtoWE
         0+vn/Tj67SJmZqzsLzENM/AhDvBxkyLA95EL+EJR/FdbvQX+4V+o6JFfZMwsphlHS0dn
         4T3AO8R6UkRi1FoA52jUxRI21Afa27usJC/lCK7oUe034UBY8u2oGFVfxCPB9HFyEh0O
         +rcnvL5zzeWe9I+Dw2mv7I46481iEAJphxlDgHjUUQfaXetImAw4wbFPPgSBgHY9ZU/i
         XaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jvum9vHoM5in6HyLcCxwho4XKzNHKiwHpUd+vconds8=;
        fh=UHNYsD4+d3OyYtO6tDyITm2yRCHFd4gIUzBZ3H9ovas=;
        b=s+mMvPT1eWCLCNmyjbvic5o7f/KCAniK06iUXhTiwC9OhAuLqhVH7yKt/MpkPPJps3
         4olM6xGvYDDYm5vZaCfH2GVmtDaWCUcDBrpSwd+fG0AprdQ2MEqlz0yYfL9lv0wqTInJ
         /oG/spDLVLk96b8g9TDgzHVNdm5EMdmQMkxCMcAyDSjiN/XDrGZx2ICqd4OXFasc+PX3
         L9CF7f8VpHqNGQEvqwv35nCtDnx3XPYmTx/7hS0NsqR1lxOB6pKgAAUW1sSftWRrqeuC
         ZLOhBrgfndzJf4I4zvfw7XyUF1RvAi2LLlRciBO9g5Xkrr7OumSuk+a7IgAc+1jecD6k
         fubg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792576335; x=1793181135; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jvum9vHoM5in6HyLcCxwho4XKzNHKiwHpUd+vconds8=;
        b=bFdHvy08P5qTB+4vC3oEIRt/xKMa3RZ5dVG7cKzf2O6NwQgBTnKsoJAKPu00bMNLqX
         eDayHVV406lPN30nVfCqvhQsSPAMYRUsDDx/Yfu8By1+D71d6Xs2cYpYqDcNkhyuHWUr
         QTWvxkxavzRGSjvR+pobQhyGFRotU54L/noqHEgJG1EYXju2pcCE8w8XGdtXZI2ELx9v
         SVqkS0saCjWz8uxENbAQB1dqqIeVrCEl2mUE6lr9c9g0G/CctkGjy2YUYbz4fdva9jH/
         pl//1WVpvsuc7nb8TCyOSdjeFtNpUQvQTmZDg0TltV5F/bFhVAWImJnglr0HUmpi+9PZ
         a7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576335; x=1793181135;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jvum9vHoM5in6HyLcCxwho4XKzNHKiwHpUd+vconds8=;
        b=ax35DiN2NMzj6CJgv38BhoaTG/Ntua+alJodO8gYfd+b00uLm2GLLFUzh93pAYbLud
         0esRb9R7M22wOOLswel/be5RdCwQ9arRUPASCQGEMCQTTPt/8FaYEgKY0dm10w2mBqMh
         XPtkAVXcKU+RWpt+ozb2RxGvC5JZMp89pW4hQzuFMtHLS8kYL0oBFLCacnFaa3jPyzAj
         k0Ku0bVW7JFjeWeT8cQKddNGvwjvSFtQEHOvdDTSdRRgiXrCMxxqOQEcW6hkGTlnpRbQ
         lKZ9+7XtG6Xj/yxjVWOVHRsg3UnP7I2Wsz2xWKSEq/uPdohGX09Kz9Un4yIbUqVoK/10
         dkdg==
X-Forwarded-Encrypted: i=1; AKwUvBwxT8ulgMjW27VQFos5ygHIXQPed+G20wFi16kC+gOArV1YhfFZa3mNUViYDHBFoU+2AV111Xs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL60fCxqxbfG6NXNrtjfeqQ2OLRyn+Fn4yVj+mL2z+VhZWhjzAn
	bhM4Qb5cjcJ/XXNOgZxTNUFdIceH2anh6V92O6wxOA0Gfh8szi7NEusKyNk9svJJjXBWC0E+oMo
	qqJudiP7ZtCwJQnxSYKAIWK8PCPdKfciSl9HJXQiG
X-Gm-Gg: AYBFou0UB6Us8lXVUN3X4HZfpBLzZdE+QNbYsVxDOabiPsAY1Gm1LtWUOTiDfxtSHQH
	jyByOBKAnho7yJBFnMykPmu05BsjyT9buD8YfszbZE67+WukWpBWC+KgQXItxtuJArAoDcC0pi3
	ZQrHgflvjqR56ChtvUX3S5S+sZc5Lv428aujesyvvVd/XYe+s24bfRrl4S8a/UtBoQxhO5xPwhI
	B0SyVO4TpnqU4IL4oFT5RlPk9Qp6VMiEfrmvYzSy+aj/V/KxvKjinQ+sCyvbgzy50IWrMT4VmmL
	TaLdN00hxBmcLKQkxzJ5j0BAucew/ULrl6safYTvp91+jKnjnJ/xG2JFxpkxqVJerl7Qb7cDmKN
	YUDBeYnUw3x3folV4gKGdZN7QsQWrmHhZRryLZ6BbQ4QH9D2b9oLuogl+FOMx/85xUGIQdv0bK6
	liXYjBzprKG0A5eF0wz34stdp1YwyJr7cEv1e7b6GBxUgSxpSVXGxbTfgkycqCG6oesaWuVOTTW
	whyzbAubOnGjaQiXPl3cV4mjeTBuKVNuQJGiI2NICwKVm2YZYyppM6mBp4nt4tg25SDoL9bbVvm
	tbJVs6/ZsrGL8p7W3z2WjUzx3bOVnWBe4SGCQRHWS4O/TJBu4K9mE3Z7ZhNnnV3RTr3rAx8=
X-Received: by 2002:a05:690c:e653:b0:8a9:da0d:1d94 with SMTP id
 00721157ae682-8b133fbd819mr5144797b3.68.1792576335378; Wed, 21 Oct 2026
 02:52:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atQmpPlfT_DSd9dq@chamomile> <20261018025319.1445197-1-julius@bairaktaris.de>
 <athy9HUHBPfCBKu6@strlen.de>
In-Reply-To: <athy9HUHBPfCBKu6@strlen.de>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Wed, 21 Oct 2026 09:51:40 +0000
X-Gm-Features: AclHuK-pk6kFTufeu4wo_iVpKWwHjnmfy3Rd4sMx-D_9eg3gvY73gs9VtcFkc1Y
Message-ID: <CAC1t37KrcwpXz5BDrPMpKBdpwJMon=WQWs8sbxDh-FrGFkAaMQ@mail.gmail.com>
Subject: Re: [PATCH nf-next 2/3] netfilter: flowtable: update upper device
 stats in the fast path
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org, phil@nwl.cc, 
	coreteam@netfilter.org, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"

Am Mi., 21. Okt. 2026 um 08:08 Uhr schrieb Florian Westphal <fw@strlen.de>:
> Conceptually, with flowtable, offloaded packets bypass that device entirely
> and therefore should not touch stats of the virtual device.  At least
> thats how I'd expect it to behave.

Fair point. Users could just as well report that as a bug.

Pablo, I have a v2 ready if you still want it. Otherwise I'm fine with
dropping the series until the expected behaviour is clear.

And thanks for giving your thoughts, Pablo and Florian!

Julius
