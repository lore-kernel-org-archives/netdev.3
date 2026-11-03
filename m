Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793702615;
	b=kEcmyJcY92ZomIyezdjRmFKQ8r9jJMC4KIiOPMH/g5hE3/MoJdX2xWAjhJcmJJEBQqPT
	 lUSXIfkkGqAJteCiNhmqgDvNLk6h5l60QDaJWRSJdatIY9Hvh4GQRHDv98LdIHM4YRbt7
	 3Sv6ZD75+v/YokiWg2Ditx6pQvg4hiMSEU2gaE+b+ccaN0FawzMh2NvvIYKbwXi7oEucI
	 ax+xJ9aJFsYdWWXeGPrnBQ3g6KBJCf31oo0biVToKHQUZmX29/kBx7jkl2kp7JcpXjIUO
	 U1xLkrduRqZZT98lY36V0RQYw/h0L+AohH7RTvAImp2uqx5cKV61P2Vf0XzTUVE7Wwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+2clxmetH1f6hKvvIm6D4A4xikxCFsBoxO8NB0gBXdk=;
	b=ZFTqPKl/FWOG4qxscfENnl8o2ZAv0YsXmcKCdMgssTNMiLz5wkZF6Oo0+McG0cAdR4hF
	 ARIkV7U+RE5L5nHTiUf0D+S768+FgtrfAfYfTQNkLyuaBsD3jmpsAs3X3D65f6FicN3sA
	 A4usnRjX9nwKQmi8AINnd/CtKkNMBE8lvlzbBYDKwOmuGfwYG49GhIrzqEQ9vDoeIOX00
	 B9cPArrXIExPLJE98Cx3I+4CX+9S3E92l/oWyuHQENuMwHKNWqnXlxM3hdiuXgh5Wr+AP
	 JxkRBepkotoOVZ7UfbczJWZBRrFlml+fyPMknaPyJvwh48CgadSrVE9yWOo6ljM+hqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvHUVb+T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B7606D804
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 961B7606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvHUVb+T
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-854b6e2e41fso2522571a34.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 02:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793702613; cv=none;
        d=google.com; s=arc-20260327;
        b=V5KJPm/x2B6fWNRGr3cU6ncP866D0Vx9Lq8YhvpJdd4CA+H96iZYjAL0vgXUYAl5v1
         IsGo1nVTQJGH/J/NmdnJyJQt1YEbICT1HvyQVnwSnbrv1JO68q2qz0ovCJX9evDYa2ug
         aimBzisrbctpbhgEyvCy45PjYJnUPQCN61d9yi7vkZ7Mhn5hYjaoyhPEOKCEqJJsIVo2
         KEuEAvFZcJ5fDv0kv0Jb4y5v+0O+1MUHFrZsG3hVsl7DTfEU3hwB9Qiq2dMzFPmbd7wF
         PmzIK0fziX+wHfPNclNkwhsZLRgW3j9u6jrdzw5UeVb7cL67Tgf2stDFjUUWvR4U3QD5
         6pyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+2clxmetH1f6hKvvIm6D4A4xikxCFsBoxO8NB0gBXdk=;
        fh=r1rM0XVOwNUzStRzcgwyaV4lSNn6UN222QHTjU0W6HM=;
        b=qvkpa2BujKY5/TIEMcpMyec1jLPzNsuCkw4FlU+OQvujRyqijrdoOen9dj63zd4HiR
         kT2PakCh0cendf1OxjtCSdwr96iwFVXyef+PR9JkcA5A55TR5n/DtnuDPW8J2z+eqYdv
         CVg8sD7ZNH/bHsHQECTf3rFEFSnH5UPircNP/qCnX5CUrpdydHGgiges1/YsciR0zkdA
         q886W+l1f8/fju+B8LNxHIFANcj48Z3EmGeTxast1wSGZxC3vYigchRt/bixLAPK5/+D
         FKlgciDqPKKoa/q6nSjWExHFQ7319CCM6I/Gt4sTVO2qbGcPHnce8MZLybt9LQTgfFvJ
         FUVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702613; x=1794307413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+2clxmetH1f6hKvvIm6D4A4xikxCFsBoxO8NB0gBXdk=;
        b=pvHUVb+TZmgxclqFDg39YmdZ72npbnrQBfllBxOMX+Ta7oW1AwDG9k9Kvxdyi4PU00
         cjSP3Leaq2CNcma9d8zP2NByk/xiCQHb3q+CXX5H1tzZXDtaYp2Oa9CUf6fgIqVkNH9r
         8Yol+azpqA3Kn4y5LqnbDDu5IjjWf1rBENKk9POJFQs7sbp+nSMaP90xLalxpWY3IJ+Y
         xLa4t1Wpvt43sSMGTetP2PpWOE5d79YozpiiUlPOS9DUsFp2ssr45HyUoi20klm85TPV
         qCbK5xappNbZwz8RfxogE9A8wmOBt81ZM0RaTJ2zEBqrmewB2Si/01plMLlRQA6EeCrY
         AAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702613; x=1794307413;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2clxmetH1f6hKvvIm6D4A4xikxCFsBoxO8NB0gBXdk=;
        b=HcJGrjexMbgHPzw2VTzHMYXexqhqWRDFgpFTuE57qHpmX6En/PSODfb0KA6mJuIWPq
         LkTRHcRFhkgkW8dknT+pPpK8ztJVX+2Q5frHbViL8+q5FXCzk97c/rWYKS+xJfSDy6jG
         xh3V80SjDPmPAocsdaywdjxJBxhvJH2+f7TtQiMt5QxsWYGqIT2Ip0fghMcYtPFxc2nl
         90/1+mwz5ie5Zi7gyp3zgCFu3wBq/huKoIMJFr2h+v13tjUTtFCf+zfKCpTj9Fots8Ka
         zhU5xAjZGOHrkXiUr7ZFbdLGWO+6J5HhZjC1cFGLs3KhPpsYXRCSaxNjljmyyoM6HtHt
         9vZA==
X-Forwarded-Encrypted: i=1; AKwUvBznuEqZ5znuiGJm9hjKquzOGByD9MgTTG9NbqmLqtu6S0MhBBy0EnGc3WToiDjZ82/0nZlRIqk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+r4uvBgVqiM5yb2z0ImWrTDz7nCmFtYpnGRSLSU+sX42q5HhxR
	/Th0ixO0PuIMR0zF4oOBjBsqtcsUu+OXKUbN+yPfZGZWwZ1YUZsz12IihEFNd39ssg+l2EVJRs3
	Vc+eIXMtWtlorwm2+T/pEpYiQljnJas4=
X-Gm-Gg: AYBFou2lol1emG0fEUpXKBKOLDtiBw7VIVA5OPIkMTG0NWObWpunQCI+LWrPvczp8OH
	8XTbbZKKXXKkNUnDPLj73WTl/GWxvi3AhsiYGxveJO6qB+rDvBNGuqL9JywBYuBFYtX09gHmN2+
	KG+qeSGjS6eKqlVIqTi4ezPpUUHi5UPU/9fIHkj+Y4bWHKPgwLascCeG7PUMqD6xwUpumFkZfmq
	UHa0k3fUjnUXc5qUZUvZfqFe7VQWURl5NpUrEoFWjnVJp4mNjvAVRtpxP1SB/YwKiNneE8J99a+
	r9oKcOh2yO0utZM3dR/szQ42cnzlO+MIHEjyj9YDhj1oBkn4XAvla8KYs2molevHwkQCIDL+YkR
	TwE+aotji/tGX6dce+K/70JNBc2Xva8902uXHj2LfO0+kHOEbWngTS0Z3dQQ=
X-Received: by 2002:a05:6830:3114:b0:824:659a:adbf with SMTP id
 46e09a7af769-85d364be1b5mr12424576a34.5.1793702613420; Tue, 03 Nov 2026
 02:43:33 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030032314.1978575-1-zhiyuzhang999@gmail.com> <179367762613.488856.7087052675164086918@kernel.org>
In-Reply-To: <179367762613.488856.7087052675164086918@kernel.org>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Tue, 3 Nov 2026 18:43:21 +0800
X-Gm-Features: AclHuK-oQ_9e5ylG83bQrdxRkkrucYAPnzsIDVk3iyXuWtU1FMLt9B2kyf0M3b4
Message-ID: <CALf2hKugxdDx0TmsY-ob5Q9gPzjRcDc8Dv7bhAV-oMgB_=r5zA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
To: netdev-bot+sashiko@kernel.org
Cc: edumazet@kernel.org, kuniyu@google.com, ncardwell@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lyutoon@gmail.com, tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch does not fully close the bug class it targets: an IPv6
>   skb handed from the socket backlog to tcp_v4_do_rcv(), which then=E2=80=
=A6
>   ...
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261030032314.1978575-1-zhiyuzhang999%40gmail.com

Good catch, thanks. I can reproduce this by widening the window with a
socket filter.

For v3, I'll keep tcp_v6_disconnect() and make tcp_v4_do_rcv() drop
non-IPv4 skbs before interpreting TCP_SKB_CB(skb)->header.h4. The skb is
from the old connection, so dropping it seems safer than passing it to
tcp_v6_do_rcv(). This also covers the ACK path.

I have posted v3 at:
https://lore.kernel.org/netdev/20261103103633.2707416-1-zhiyuzhang999@gmail=
.com/

Could Eric or Kuniyuki please review it again?

Thanks!

pw-bot: cr
