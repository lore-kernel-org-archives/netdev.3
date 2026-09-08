Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88F3ED5BE
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855619; cv=pass; b=pbzNRHbkxoyTNep+Bf1QZJmW/GBmgoredf6RAD7vcfR6Ej3CFOMl8H/CaLuoyHQ9dGc1yz18xbRw4ZvM7G52XNfh5Ui4GcAofH3Cgya+W6C4Xx51IZFeJ2/ommJ+uBY+BAqHFa6LnkSx144mSlykVRyygwFBQBKTGZ9lO0YDl98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855619; c=relaxed/simple;
	bh=hsjTDp8GxgJOwpED1Wg/Qo5pHHkBB4Ysmhw6O6ZbUK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFNKOMseP20ElOmZ94nBNPTCqpTcO97vWQdsD7mFw9Wn9lSNjow7RSrwAldX4QzQVIbO6AHxbmg+9XoBqdfednDt4Voq49KErPlnaSAoQWpxjTRc4a+XT782kuNy8HM+EtaBBGFn9iebgDITlhc6DIVhOt13QbwTRkzga9FvUno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sO8ebbnR; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sO8ebbnR"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91055b076c7so24884606d6.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 01:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788855616; cv=none;
        d=google.com; s=arc-20260327;
        b=G7+gBLI40YWg6IVVvu+bC2QZnYZsa0dXMNRWW7FKn86LRBwdl3HGzDyWT22ic1Ze/T
         acRqRhizHHmCbMIR0kBRKDoTq65qWtzRS8kRyGOxdmvY064p2rttxQEVAOuYSNvoOE0B
         Id9Ne1p9L3MBxaGjlx7yYz03QenxV1UCTYI3WiFMGoGyL/JaU2vYEMlMPnb8WLpsafnw
         tTFBNlTD9Rk0kTdXLFAw8LUcHqEt0oWRA/bxJEjB/mguWZT6pllbw5SGdDxwEDCLr3ca
         qn5QW2oy6SomunMQCBhdVPci0m1pafPUBPuZ7IWN1D5XwdKFKR5wJrWfw06c+4zJ2twx
         I+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsjTDp8GxgJOwpED1Wg/Qo5pHHkBB4Ysmhw6O6ZbUK4=;
        fh=F4uJmobbrYbWNPfRq3D0Pz/jo7n4kydtCtwsjlKNvwA=;
        b=DkU3gQ6udCycDn49fPwg0GXWz3f56PyxsiON3PP2rrjnMHZsShVh8F/W2NOnZrBHty
         Ng5y5g+6lz1v/n46tiVYHwP1FBqTbeFeW8UEBl0twRl3V800eMv4KcPeOuL0s6GBODUQ
         5F/K44uIKEepJRoVBvgTduAV1MBTOjFtZO8+QllbCuOVJuSgqIpeyu//e/3CXxvSgZgZ
         Mrvfk1thZMTV+aT+WWCIoeMUf9V/iA38xyCFNak9ZpUGAr5VH1NFce+/z5RBxUuTHKPT
         v4KmxWvQGPG9eroCo8LLHK46pTaIOhHQdGAVWNmCGFrHHUfgO454ilmw/VA5DWmzYgFB
         YGMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788855616; x=1789460416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsjTDp8GxgJOwpED1Wg/Qo5pHHkBB4Ysmhw6O6ZbUK4=;
        b=sO8ebbnRRyogAoRUoEKrDUIrV9/y3WCeanjkAFp/SRpg/dbdT0cqX+wN2pNTpuFDX/
         +d9L75Qm2B5nKiNt8BOFJ7xKu/VPzEwH1XXltWfXF8MfArLid1o/wwxXOMSudlwqkf5b
         iv+2MJpKykr9OOcDdb0iGuOtCwXDS97rFgfbVWVftInFIhwAN9mfYyr4Etkr2Xcf85+O
         dmPWy+RMlAO6KgtbEr/+LskeSzf6StieEdPwll9jU/hP2DA4DYZgHWhxmymgCqWysBBS
         sIjpHQv5bpjIFh8kBlqHDCsL/zGpVHKEz0AyDi8msAhBSUvwlfMKCMnH9bC3ntPrEys4
         IJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788855616; x=1789460416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsjTDp8GxgJOwpED1Wg/Qo5pHHkBB4Ysmhw6O6ZbUK4=;
        b=ItBqmfzf3fBIos5pQ0SMBWtmsIhtKQAGDYzvNHSlJ9ymhiYG7AcqEsKEQ/MlbY+KWk
         ovckKqUIFiTdEAFWGk72ZpllqCgTN3RvHM76icErVo2p0ZvL9xT/dH6H6T3txe1TNFhU
         xZk0/zxYIYcG6BsqYBrQkPH/iFimrXzLzsfREwMQSPGjZGNLQ8SvF6GeUVG0hdnK8akt
         dUNeY0Nsp5KDfPHDctjB/xLdUKNgQ8iOhrwCcyXyd1yvHIKK86LR+7YNxZtjcHp2m2ly
         BVicra7N+yInanAbAX4+rTwjmHexNJeIh+YEBaDv9SwRZ4Fbm2eTSxPBahLhsfpFItxV
         19zQ==
X-Forwarded-Encrypted: i=1; AKwUvByMiah6J+o8d03IR38ZbAEG+La8ndmWw9uQlKoej05nLelT5xCGEJ8e5tLhXYdT9c7jXxLXFGI=@vger.kernel.org
X-Gm-Message-State: AFuF++mBGQxLjUyMbscvs8C15ydHjlYgoGa+gWQBR4ym7FszlUG9m4ih
	qM4pQ9ieXk0YxIqwxKmNAMEpqLq/2uqEvrLWxY2yBkFIg/tRMtRuHMWvUnTSHeejVnXYDsvssXO
	pgP6/wZCWdvTQ1H2Wz026SMVsb2Szxzu8TmxwFlRm
X-Gm-Gg: AYBFou2wWv22gq1GfbN6hOz5IFrvzhfIDzBuOwyh+Jf0J9GGgiGrqsWHS/4RG9elvYC
	2KDJILXzWUI07v8wTXCMUEq5+Y+LfKTQcvma4UPbd7F0EiLhPb9bwkSFSJk8OQQxWrkRFsW2U7V
	PxVgV5KDHAf7oJ9ZNZZAJ8iH6MCx+uX+IEwZ7TXaIi01U1KWA+wG17oFxs2uKRORrUr8ltZY1aN
	ThHuebCIMvBKfVaxiCp3FR6kVJGmhu3n9av5oOuYI40uPDLhPViIbXlI2t6HZTYft+woxfPcWQQ
	8wHaJiUl9o89Jx/clCUn49x7zoqnzTSsYUZc1ZfapDfVvl5ASQoUfEt5YTTSmLA8TVX8fv7slMq
	YrPXXBwscDuqUy5t9M9dUgfwp1d7/WmYenSa6erNgEDwh0WuG+Qn8OCFJzw==
X-Received: by 2002:a05:620a:2855:b0:936:eb7f:d2c7 with SMTP id
 af79cd13be357-93980400609mr3654539685a.27.1788855615776; Tue, 08 Sep 2026
 01:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908072135.877364-1-qingfang.deng@linux.dev>
In-Reply-To: <20260908072135.877364-1-qingfang.deng@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Sep 2026 10:20:03 +0200
X-Gm-Features: AcwNN1Xe-V-EjnVcuPI54J8HF_f0_7IiJQXu4AsaIKhTCzrczAlMe4wF4WaYDBY
Message-ID: <CANn89i+w-txLUf9KbUORYy03x2GS8Z=Uroh+rqiBKztdc9hqFQ@mail.gmail.com>
Subject: Re: [PATCH net] ppp_synctty: ensure a writeable skb header
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Kees Cook <kees@kernel.org>, Tom Parkin <tparkin@katalix.com>, 
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 9:21=E2=80=AFAM Qingfang Deng <qingfang.deng@linux.d=
ev> wrote:
>
> ppp_sync_txmunge() checks headroom before prepending the address and
> control bytes, but does not ensure that the skb header is writable.
> A received skb can reach this function through PPP channel bridging
> without passing through ppp_start_xmit(), which calls skb_cow_head().
>
> For example, a PPPoE frame may share its buffer with a clone queued to
> an AF_PACKET socket. If it is bridged to a synchronous tty channel, the
> address/control bytes can overwrite data still visible to that socket.
>
> Use skb_cow_head() to ensure both sufficient headroom and a writable
> header.
>
> Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN io=
ctls")
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

SGTM. I will fix pppoatm_send() in net/atm/pppoatm.c which has a similar bu=
g.

Reviewed-by: Eric Dumazet <edumazet@google.com>
