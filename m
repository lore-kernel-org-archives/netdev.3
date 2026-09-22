Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBE37B3E4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042271; cv=pass; b=GhkcXOpsk71IZyAi0WqWnjVc8T4XpXVkvMGv1y2YLDEX+imjab0Fvt9z5PQDxFnLtDaNwK5c2n9WWNM3tnSj4By9X4xs6seoYJ/wrE7nwUdJWdDhUTYEt2ozaJkBwHuDAGvFbm7Dubj2xujo3yzYnvFvWEvWIhEkpEwWtYYuLFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042271; c=relaxed/simple;
	bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1CD/tMjSbsLtrzViJ+MFYQOyW8GKNTQ9jUDr1wIPx6m+0to66m1y/FRqUvoGTlfdTJcBpiQjE9EVnQsZAaThZYK9A/YIz+bpk2rvUnwVMGsE1EfZp5WRimxjTDr7+lBv+1mpAJeDyKNzymuDbMMiWOerMyKh39Nhgtof8HisT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGI0BITP; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGI0BITP"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso6413840a12.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790042268; cv=none;
        d=google.com; s=arc-20260327;
        b=TWRHtdRFt6EGB6MXjFvexhZ0OkoEjt/KSKqYeSr/TNxtetfZkHE/svIWpZH3RTUyuK
         uC1U79Ghe4QDq5JluNAmD5vntY77nnDyw/WomMWEct9DU/teo/aKBsd7P2h+8g9ABpIj
         aeCpxVdh8x489WwQAMEjCoYsT2Erqr06H/S8Fi6A/4GR7ZgK2BIgDD7OWSjD+MkAr3lg
         DikDfipEU1SCfyGvyyPayJB18SltpuNetrx0zRiHCTQ1wS/++ZR1awpxcbF2TzMfv23X
         tsFF+2ltVAxwafTUkSaw/t2MfHKAC6ZxmRTSp38+JQ/2AoCD670Bk7ZsWQSQt2iaCYJy
         BvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
        fh=xDslgQKyjN/5SNqZZC0/yYGziCiNoNskeldXy6lG0mI=;
        b=KitFhM368qN1UjkYE3ov+3a1bdHt4aN9FfvtnVrdbT/FyV0BsOogwhv181ieIGcWHA
         LyxFGkM/FN7jXCDbN+D+Sgkq1pOPo6H4WPWqioBNH/X7+bYYUxoyZtsldxLr0qwJybEo
         T1BExjGRLhb1AHDZMyWlbwgo02fhWD8TqAvk3vjkAxpUC/PjtaO6dS2RbpLH5MfGRecf
         tF4ZAWf9GTgvs/sxUZYafjjolMLpHTih9QN4WuRO32gFxhFcaYIu2ddikt3gumLqUFTS
         3KkLHywYJMPBKu9AGvhcqzx9BHLYq7T5X3t6ku9/oTCVPzH1tWjgdKJOhAm7QY/fH7Ez
         16JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790042268; x=1790647068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
        b=NGI0BITP8L/a/qC0xbm7HZrUB1FhX5qvt3/58DbVkDoNSmQslwggSrJ4B6WAIuRrHq
         +fb/Oj+HxVeJ57uqvBgbbtCcTcE9YqLjHg8GWfhsAxh6rc1lxPvF+gJQZtPSNPPT1rU+
         eXlYrkqEScXOMJmDneUFwHwXyI1J8OY/8TFwyBCGeRaPiB22GPtqnCxLr6jbwiiBANCo
         atOrATWzy6hJfHRvLfzoxwCa1AX/WXodQiKsJVfXljILq3zvMqVPqmHHfS8fX5hyLmBv
         vfFGv7QiRc3FpXVjQJ63L0EEKHh0dzPYPhTsvpgbIg+dkKkZTogq5Z+ybRovjQWj/6gg
         XWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790042268; x=1790647068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
        b=RiGjBN47riDI0uLSHAq8SYHOdxmYw8Qv2TXw/cNuwuLXCJ6tj6PVb+i29A3V+hyYjG
         aTbVTadVPSq445PTzaCObfdP18oTHII/nxww82/yVoIelrB5p+eWjujxDs6q6KNx2fZ9
         JMqmlIt29fHEI0+XzDQ4JSiLvMx0hZUyFV3T2UiG31P2P+Wwi+bZ/YFaUMxms+fhxd0K
         4TmcrjnSO5dDQ636K/tT9Fp2EbKO6jrr4E+JPW+xE84fqsbGuKgt/w1NmR/nrmdLyvBs
         fAW2ynPQ18T/r60q3/Oj5Aozrhnz74LnQppKGscZXPCkFLE7d7zqyEuC5DSK6EXmu/Ks
         XUQA==
X-Forwarded-Encrypted: i=1; AKwUvBxPMDAv2om3KMP/WwusjGie9UWTjtw2DgYDQXC52d5MLPXS8jOLnDW7L2rZQ//MnqfWQErKs68=@vger.kernel.org
X-Gm-Message-State: AFuF++nnXxEPOeJiuyOhEU7Q2b77rWm0e9Iwp2qsbIlBJjXPkWBoVDF5
	rnhcsb86dwny16KcElJWKfKt46iFKYXEas6kLj7fwdhFRlchYrmptzdGXocHHuQgyJ7zG+EHevE
	eVFRhhihxK9XGLARRCmTfV+U65aS1IMc=
X-Gm-Gg: AYBFou18cNI2V1hQwj3K0z6cUtDPtH7JN5dqnYDT48TKkOydoMiv+Rfm1IVRIrGPlK5
	+JC2Y1sLQUzXLFl3L9dmuhCcJkxd6xLmKaQrsGzs6E5OzcAgAaiuHUR13Svfn4z3S2qUm03S6In
	A4P96pr7Ljb+JoMnn81ASg6qpmr+BwHHVkaf7P4Mdgz8lz7ZgHPGndxNdJkE7jigPSUAK52FPPK
	m18/4k1RdionZZpxTpzU6Zk2efUK2AKNfTalXj5c3jo0TUzhaKYfC3Kt0UfdEUJe/pe0zW2mGUq
	MRr82wVTpnEa1yPvp+c7D6wjlirpPrcq84JBuDifttS9H5fumxCU4hMM5nh6VITvn5zfA/5+g/+
	K+HIFuGClEUDX
X-Received: by 2002:a05:6402:1942:b0:6aa:a133:cfd1 with SMTP id
 4fb4d7f45d1cf-6aaa133d1e9mr802399a12.20.1790042267824; Mon, 21 Sep 2026
 18:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917153923.904124-3-bestswngs@gmail.com> <20260921154147.4e1e092d@kernel.org>
 <20260921155826.5970f028@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20260921155826.5970f028@kicinski-fedora-PF5CM1Y0>
From: Weiming Shi <bestswngs@gmail.com>
Date: Tue, 22 Sep 2026 09:57:10 +0800
X-Gm-Features: AcwNN1XB1q8PoR7CFScqBTcECMNzsAWeNJ-yjmOWlW5xdCHggLWmz-bfJMhZfLc
Message-ID: <CANgPUi2JeO9psd1gL8Ym0k4DMmkzww0fjocvGN_yDi_9wttKPA@mail.gmail.com>
Subject: Re: [PATCH net] veth: manage XDP program pointers during channel resize
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, co+65e5c76b187f08b2@bugs.sh, Xiang Mei <xmei5@asu.edu>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=8C 06:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 21 Sep 2026 15:41:47 -0700 Jakub Kicinski wrote:
> > This is pure slop, cramming loops into functions which have none.
> > Shameful, really.
> >
> > Please test this and submit it if it passes the tests:
>
> You know what, I'll just post it myself.

Hi Jakub,

Sorry about the poor implementation.
Thank you for pointing out the issue and taking over the fix.
Best,
Weiming Shi
