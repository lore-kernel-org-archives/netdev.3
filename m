Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2E45C6E5
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513401; cv=none; b=QdiivIubK8oSeD5EjxyS9An+qFckIt7X9MWAuAD+ZKC85M5AkYaNKVOfyXSlut2KFH2RM2uwAODUirqBciuEudfy4hkiEXzf+nUxiV3imi99ttcCAF4llJhi0wXP4bOk+CefWjoVroK3mCV4Q1A61qtgAba1/54h53iIFBlEdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513401; c=relaxed/simple;
	bh=ITz7hBythv5OWTbmQ9c4e1mzRPysX2+YTMbCrseTj6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkwzZP7wv5tUjXHcF49Kvh2c7ypa9jpQXPPZgA6xttFHHFYbpCAFfqAm1ZgWHs8os9SqGGIYSvqRq8VhUjONwGexashTaThmPjktgQgvHFLo1Ufl8erEr+40hrprUdcZGVIlww13v9hHEw0BwFsuNLYmvREWer0XpDy78BFjYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GptVyoz5; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GptVyoz5"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a302a4e42aso2843121fa.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789513398; x=1790118198; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=GptVyoz53IK36EPzHcgUbYwkq3cdLH0NRj/or4T6kyOzkR86IDFCeclS5S2UF0MtOi
         1qFF46c8la50j4maY2qhNiwkr9bYvvZlHb1218Xf2gQQ8BdWjk7xTcILqs5ImSSo2QHD
         cWrC6Ob2OdJiBTqMdUZ62m5gnICaiuyQjAz4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513398; x=1790118198;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=c2qFcZgeiADRiOz2KEwRMd7JmhaHWvQZ83ZEqG3C3yE4K4IG3zO3nKcSXGYIZtupWz
         ZOu5rL3+ZDF4cgzWzW6ZsT/QOG0B0kFE03iNknLj3Lc6eqPHHCw+owGgjhDdmufvp2Ua
         YSs7KqVxzoTCcwvIXJUEWWzlbTgfijCWHpsVWBpIkLQR4J1zTIq9donDHZM86kYpt7EU
         8VZrNp3Sj+RQzNvIs/7mkqtLlfUaAkZ1GU+YAi7H9U2nYszYA3UYKLHu9VlZiyEZKTGR
         5l/ZPld2NqXc2BeRWfyhzg2wl109s8jnIEqIVylrR0LYry/MrGhy4DAALgQLyPr4V+x6
         ZfDQ==
X-Forwarded-Encrypted: i=1; AKwUvByJUJYBrRk6ME782tzbyWnWSe48wf+pQrSMcd2yt1xCmY/6H6S4QX7hakf8xYFxj6LEezeuKV0=@vger.kernel.org
X-Gm-Message-State: AFuF++mY0+tN5eTTvmSldb05CsgJvEHtl/mEpxD10Nvswiev5XBaE2Ts
	5/LmAbp8vfjuGVRJ2VCk3i/P50VC02EUbNpslwqamPFFLbC9/vPT5rUa8fu7XykDwgV7/sWlmEy
	9wQaXt1lfxA==
X-Gm-Gg: AYBFou1TzCTodZNnUfhUnvb6VLXonhu0bFFu4ONE6U3HjhaxP9ccIxwCDgYnRY2gSC5
	O4Xh/82f/45rfI7Uf2ybRMofMAcu9himQIDsAzYjVv7Pa8KwcQPnh996452StfsQa8vW/O/CJFV
	u4zP/0izkTx/YnYnyKxhGJEvEWWa/f9Z6a4KrQr6KaiisoDZypjBdy/JFnQ2Hpxn/N4G4wWL4y7
	dMP+dQxoLx/fOU6/Ap9tTkjUrRqJNZrlvD8B5JaXDnAkMPYHQzPcX3r4pV4QtiW7OY8oa8d8/SI
	EEG/lncNduIh0X2aIn/ZDYhKrQtKuiGI0v4//SiEPrbzlcuXo9kBGbNDKcH4OD/nVVbiKBvoORO
	vAJyTrYIy1WJLhxk+Felg6XhCWQRIOVKu2JgqxEyVlCNHymtvVYzXNiiJYelgkAMzyHGlsYCQoB
	usSWM2m0xfnBpS6zQxdkw9cyW+DP9XSaPZDiSfED9QDjlXD/O6bwTTG+mkRycUD8J+UbP5t3o4m
	p15F9GW2TtyM0APuhTsx1Wawr+vN8UO3x3QUeuVZ4rTW2SllA==
X-Received: by 2002:a05:651c:b07:b0:3a5:b0df:b798 with SMTP id 38308e7fff4ca-3a5dc9cda9amr718651fa.9.1789513397725;
        Tue, 15 Sep 2026 16:03:17 -0700 (PDT)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com. [74.125.229.204])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5dafa9cedsm2102681fa.27.2026.09.15.16.03.17
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 16:03:17 -0700 (PDT)
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1744fso433747e87.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:03:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByXJNvGRGZCprnSLHG8hXCN5eWdA1wtOc3u0JYei96iWZuiNsFCfZhJiJoLZK9Xmo0SQVoEXUE=@vger.kernel.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus
