Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CEC43E48A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123779; cv=pass; b=Q1Gx1OfgcAr51Cx2uJuBOvcm8xiNVOB5liJPe66sDsLlY+vlh5HU2lubb8W631RgD1PIR7TvBKDAMjNSPf8CKLdkhqDHvSxyXUdTv4dBybD4GYHSCZH2NJyInGT248oITzkH0WoQWMcEehuHdT3llm7jV0n6bXSrDnkbxyw8Ey4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123779; c=relaxed/simple;
	bh=ezSrAn9CJ7GjnHLdrzeGHcm7ENN3QID29LGU2q4vePY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzVQUMGM2XTaAMo44eSr61xNEuQNrZGGVJTZfcnSKo3GgkaphwWRdH1qA1eJfZAkZYe2nV+8X0W2bgCqDt6JqqAMIOv2ZHHSpqwsW+tVG2OyJd/oyJsXPlGtS5jE88lB3AzyyXHH0WQy8M8tM9BCe21oqyYH1Qpnca51e5XU870=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6ulhmTx; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6ulhmTx"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5919af39dso7351591fa.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789123776; cv=none;
        d=google.com; s=arc-20260327;
        b=ZK22ljtg6uGkmm85viH11/DwE8qx5gBhY7bLUl87MwDdWfDFglYLpz1oJbSZB+YCw3
         rcoUuWodVcxgai9ry2EahD15C76618TcIBnN8SgwSIf9VDdxYtoxzB9zEwpAoK/q+YBs
         6VzeZ7deNPv01hxtrdZyVLnHrT7qkyUHZWMzSh0SdkwpfYJOx8olzpoaRTXCU6IjD+4X
         4CaUILGpmZ6ChFS8CcJwvz3ZX5KxtB7d/Wbn7rqoJ/TlZwRuzbsV8lSjOSS9drXRLp7G
         0oIvcjJPZStr1JI9hW//QFA4kDALDqIytNKzVM+d1A4KjwG86ttObtaXN8wd2PufGL1v
         aaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ezSrAn9CJ7GjnHLdrzeGHcm7ENN3QID29LGU2q4vePY=;
        fh=8WWA6nawXmLFgTAD89dF6QikSmrB4n3uiJiDjR/9rzI=;
        b=VoawqwgHPXf/Fj7D2EBt9JTH3A0rPImF0bMukyeNaYGaES8sdm8zSlE9QUzg7X/Coh
         spVFgRZZpWoRRK8tPTEhLjkv2ABTdMXCyODOkbASTG2RTe1FBOZtV4Q/N+9Njt2LYDMw
         HOPsuqd7E0vEXHPbSzElXF4iju7Vvf9Xpbt7B9k2hZIRWVfJMo8q2SitFfWPnuxwP8ck
         9bBrZAhJwpztsmyvJ4lTRfiBabtIdPzpIHnvt+AJb66iqJ/VCIY6EtAnAKg/fmoHc7JC
         XFAiDKFnmccFHxRq254tPETQZwreo3PmWOcKSwFYYGs1LXJqNX8LyXcMnj5NoaBis7MG
         zDnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789123776; x=1789728576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ezSrAn9CJ7GjnHLdrzeGHcm7ENN3QID29LGU2q4vePY=;
        b=g6ulhmTxVfv5JLib3EYTsO8p4RLkpMe2c9CxsMnw8v9n2gO1eUQ719E7ieF/SgM+CH
         0O/c9rdgTdxSMePZv0lIzRqLw03gDI6exq9pBcqyMl3/qsWBD7BckcWhdPE80VUGxwoB
         D7SX1DGTPaNi7EMB0rNbnmSnTpOBEvuXqOEp27ZU9ehLtwgoZYsjf9IN/hlWmoEY0/Lp
         xrAu6ubEf+uPhr9jjoomSzCYdzSeF0r7czhqonntJuIsY9oUeYXPz1E/7WnroBWqf6kz
         UNt7ho3Ntg5e4zQV1AnrWrMo12G1X2dpQAERxhQGy95fAamCQ7ZZf10yB1VNpMBJTowV
         j51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789123776; x=1789728576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezSrAn9CJ7GjnHLdrzeGHcm7ENN3QID29LGU2q4vePY=;
        b=GuOmu5H2Hw+ieK5UJIGwYo+sAhXgCGNUUfbkISJbnzjwnzzw9HHvGXB1PuOLnw5HEx
         BeRqeYcxdaFzRrRgefVrhd2UqXD/gHqO9kX+b3h5wIpk5od89qPkFKGj0D1o4YqBwIRL
         jYbLRcyJFwwGt7oT+wYU773v9OjAO+ZvEp78etc5+JodTAKBECHHGGqpgs3khmYrIknt
         mkq5Uw3GnjOioedxaLx/g65EZnhtytxfbt6ycFnh455KsdDTf5DzsCgd1imWNkOvYN6Y
         pb5O4h0NdyCfXuGt8OMdLU1+xai9uCY/6FoSSIw18fZ5ESKfYd8AAcxdm9Cbm7fJgBGv
         5bOA==
X-Forwarded-Encrypted: i=1; AKwUvBzd5EuKU+I64qsYmfU7i9O/BZvrGOBR4ZsUUn2Q1f8p1C9oYBi6P4N/B7lY7EMpDcdfidEaJH4=@vger.kernel.org
X-Gm-Message-State: AFuF++lswNZoyv4ZwXonotvmwNor3EPVAaot6AiePzoE02+yxupyfSEc
	MnwpackSdZivHxmsqMWGMccLNCX8ggaQSYQ/qd2Ogr+GlPRJ7+FpOORh0VVj4dmRXTZSVz1cKwc
	jCvl3jkiD+9QwIXENe+2uwlnhmDpTE/4=
X-Gm-Gg: AYBFou1E9NOgSBKOQOWK9mjKyitFzGPkPutrvkEdkflZ+KKavr6yUGmak2BTyw299BX
	JNMocf9x19dUyOaAFmTG0sVlPbGC6dul12amCou0GYwP688Zqsf65vETkSNldGoM/j5k0kBO3Tp
	XCTkN2aM6tWfk0K1ldzfxCL4+fnipbcDbebteZvqCMlYsP511pdMt9WqHa7FXMwopH1s2vidYbf
	FSra+xjOuwWDll0xlTUrwWj4o2tG9PY1g/gTSzAjyNRiJ4iYEfdFix6oWwPLu6wx3LWy+JMUyq6
	wo0BI0xvjXSr2a86f1lCwD2AXEUT86AZdKBnPfm9pAaT6STdGVVloUvL4kuYQdi2kuKD/LMg/QK
	lSNi3DCPkDPA=
X-Received: by 2002:a2e:bc81:0:b0:39c:9955:9e0c with SMTP id
 38308e7fff4ca-3a5a51ef765mr8895901fa.6.1789123775747; Fri, 11 Sep 2026
 03:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909133247.113923-3-sigefriedhyy@gmail.com> <178904820206.219967.5313952981588630189@kernel.org>
In-Reply-To: <178904820206.219967.5313952981588630189@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Fri, 11 Sep 2026 19:49:23 +0900
X-Gm-Features: AcwNN1VW2hCRe9SDtg7vs6h_4VOh4Y_U9CCUKTlYjaVlanKSuOtZxvyADFn39dg
Message-ID: <CA+7S2vKD8LAkRCuBKvZRWAqfGwbOXLEGch0V28v_p93Dan2uPw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/4] rtnetlink: add AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, donald.hunter@gmail.com, 
	edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, pabeni@redhat.com, 
	sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 10:50=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260909133247.113923-1-sigefriedhyy%40gmail.com

The comment here is duplicated in previous version.
