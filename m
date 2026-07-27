Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397292AE8D
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117481; cv=pass; b=crPEyY3gUMbKSsAYubL/TOGTxKbRiM6pPssN9mUpWtLLkqgdnjwPIZvYSl0Lhb6untdOHFuTFmh4rLvizAzHb/XG/YHBjq3KBbcPBlNIEpDe0GUKQtqzmX2vTB2oPId8TMcjr2vg/46nD4xU3rRuVeJ5Djivb4LjLRz3NpViEvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117481; c=relaxed/simple;
	bh=dZTDfCZ3UTF3DVqqkLuxaJmHcHKEZVXom4abZBlr010=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3RnCCBmLHk5BenY088QTGyL2ZBWtXD20yC24L0yJyVFNXbFVYSEa/3U1y1cA8fc94ma2enOT5pgmkvfwwjC3ePLfV1QKfcO4LdhI1SvvrAq/Yak+30ay72TTV8oJpa4ClfC+a+Phvu5X4dKLZAKNHU2We/jNU1hlg9YPYZ5/mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0H8hl5h; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0H8hl5h"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso2784775a12.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 18:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785117478; cv=none;
        d=google.com; s=arc-20260327;
        b=JfASiNje2VyNqUCnvqB7iXSemy4ksv5cFLfkge5Zv7p9I+thEqXYDaMNodLUvP54ED
         8NXQ0to4EFfRtpH7LE3KAFctRc6PilH7dLD0tlOzkAXp2f1MajiZBQ4gqiArjd4nEbcn
         4vs1e2Cnotw+L/PqpVXzXHN+NAMwIPsulDPuRsfJDkb9Zrc16WievW4+OfFZIBk0P3Po
         H76boJuyp5qvBHZBH9Ksz/azzfqOIEaiR9wlYxt7WppZemE8e9FIK/t27UeN0RA4F+fB
         uaGefharmMNlDlaftLKNXL2S7/Eq/WD9rYL4YW0uB99BrtS5oBiNlq+1FmBgWDyW784r
         4lnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dZTDfCZ3UTF3DVqqkLuxaJmHcHKEZVXom4abZBlr010=;
        fh=coMThyRbC1De3youhRCq41ahqO/5FnaYqpk7v5jVRws=;
        b=SP9zLviLkKLzhmRuu3qAzlDTMOxJYOPBG6FoPWQSyeDL4YK+ufPKgXKm4rn/ynSe/2
         Dl6W/JoNJZ/HHO2xtxU5RYcXEYr4+l3uy+1cCy9UvLH7YIrb6WCzlh0NqxuYUbfqLU3Q
         K079PEQpib5rkqK7FcYk651PKiYjQ+zxNuDT1GrKkbKn47QP6rtWyzaCahIlE2E22KcV
         27qSBLigmYjTVW72gKpjYO8tVZozgxibXcI8pWtsMt5sTvBa1nPqA1bWST84k6qU060m
         xr7mxrkxrWDinxHXf/L0iXMyrPoHfIUp9f+pjpGfQAurHq3BHJu6EDwaw+13Esi2VcT5
         FKbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785117478; x=1785722278; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZTDfCZ3UTF3DVqqkLuxaJmHcHKEZVXom4abZBlr010=;
        b=X0H8hl5htbYVQ6fj4VSw/BEnKijfFg42dIgwIyMA3KdWlzD3yA6NR1XYGFJ6S5i7c2
         lIziEJJdxtettBDGOi2HgB5HWN97CI38lP8W+fFlm7ddymQqNlS9KLLuHrpBHR9do/OD
         QOf/ZEiOKVSLtpPdJwb3IB9rHEZH4LS3orRIDZGv+Ht3Q50ObOTNctjM0lGLLBw9Yhvv
         hhwAoGpJ3B6diTfr592U5nRqWxtC5qGTewidcFVbOS0Phba3WKQuctt5yO/thJOVFXZs
         vYBbHftmqzAKy+L8KSwvYcyzpDW3GVudLGldd15TgNVCfMwmqbaPoFFozKFo9vlm04Mw
         1qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785117478; x=1785722278;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dZTDfCZ3UTF3DVqqkLuxaJmHcHKEZVXom4abZBlr010=;
        b=oyXB0+8YMsehkpRwKkvG4PHrOUvHi+jo6CZ771pAy7WJ3BN71uFZ1k1aPgNKp7vu1n
         GfysdBBHU6BNk2A75jU0063X3AHJReOzAOAbHMZ8pzE/ysWDshLR6QdhRfjyWg4pyXME
         fVQn747KyAnSVGHwF5NHDUG3Pqy49Z282ytH/ffh3PdL/doB9EkDLscJCzFJAdO52bD3
         qsKJIGdOPz9Lp9AekLPiY2anEd8KvD3tOH6/s5VO6P1RKfzjEYfzQ9OiVTdmLV575mSW
         pH9giH4z6TZbO/VVNlRskJLMaYOjhecRVMlCXh9+CTgOm3EyOXxnTo9i16x2XKCKtace
         KFFA==
X-Forwarded-Encrypted: i=1; AHgh+RraAGyhu/xdgEL88YHCfNKjHI0QVqonCyLi93PejYtICiqIEaKijZ40Gpoz9zErnEpJk/7PZy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxey7bnIQq6VtGrsyxP50xN5mDoiFnov5uQvHgf1cIZcxYSYW7V
	iB1QiukfERmwchQ8woHpcMvckPh0eKkML89B8ECancLoCeqQOriNd9Wu+JSOfPLOgwCEJuYgb0m
	HqBJ7O6xBTnBfYEN3E3iSd1c0evnHKNM=
X-Gm-Gg: AR+sD11s65r+j79rZYzDlI/GI7kdnE5JQ6Fw3wwg2adZ11eB86ytR9MahiFRFZ9Lv3z
	enyKqM9pbCR9puR6O0WJzL5TBy9tT3xF971wIZptW1Vw3UbbDcNg4/wTUZrI/WLKsn4T7XCRJt6
	RCag2Rntc8Cl/CsZT1CtLxRyQ3cnrGijs8f42SttKBg2pOs/CHSVV341yCb8zEyBkdtPuT/FE+n
	gzd5UF5xsKivtBloN/ed/MbItTGvi9LOpIOGNbZwO43KLWOU6fn3DYSCvPHdtwxntfJYGgxy9Ch
	Z8rIQnvy469M2t4JhTY=
X-Received: by 2002:a17:907:3e90:b0:bed:6e53:bb1a with SMTP id
 a640c23a62f3a-c1f1f081bd2mr299282066b.48.1785117478067; Sun, 26 Jul 2026
 18:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718-realtek_mutext-v1-1-1cd7beb20ae6@gmail.com> <8638d68c-4bb8-476f-97d3-98f433949ab7@linux.dev>
In-Reply-To: <8638d68c-4bb8-476f-97d3-98f433949ab7@linux.dev>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 26 Jul 2026 22:57:45 -0300
X-Gm-Features: AUfX_mweyhhpwr2EjSyfq2lD1f41O2VhilcZ6zaKHrgjPqLSkULqE9X-A7cjNow
Message-ID: <CAJq09z5E9EHAOhFr3GW7aiDkXAiCGO14C08sAnYOnb5mov97kw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: use devm_mutex_init
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Qingfang,

> As you're fixing a missing teardown, and the two files were introduced
> at different times, you should split your patch into two (one for each
> file), re-target your series to the "net" tree, and add a Fixes tag
> respectively.

OK, I'll split it into 4 commits, for each time the mutex was
introduced. I've just sent v2.

Regards,

>
> Best regards,
> Qingfang
