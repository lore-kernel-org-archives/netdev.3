Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555A3B14B2
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476936; cv=pass; b=jNBLURc3uU+48bG9ncNgVaOlHpgGCP6br+X21A04RahmpNLql0/1O7aqAE6Z8Ss1HNGGo6Bpi/g/vQGTtRpIB+DgOK3wrOKTNq+GdEYtCYQxi0ZmFVk7uxyayfagsiIzKlviovMJbZ+pXJemCmR/uhwAzVJbCkgyecemFEIzwEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476936; c=relaxed/simple;
	bh=Wq+Co+PTe/9OQJlUbPQtbPUN6JHrxxC5Wajt9QbB+RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuukF7y7z0q9feCXgjhzp6/sttCSMh9q/19DBddzAl3OsUjRGeFlzNu/qmCvLIj9YiSUIDeRmvcBFqbeBuL46xAyjkp+LqEHI294jBNsq4qcdBM6/Fh+OT347vXKZvgyhwCqKy12JOmjtKcCf6vu6NsolEGKdqvx9WthrHnHUU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCEF74oS; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCEF74oS"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd3so34205641cf.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476934; cv=none;
        d=google.com; s=arc-20260327;
        b=hpugfzVW4xEB3+H5ZgiobCLy+jHDO8hKBggTQ3baVuqvqMIseOrvv5d74YhvPkq2IE
         ooIFBCKKXiIkyeQ078ojkr6QYzHL/C/izfAT42N4D9nUWhN4SpIHbxV5Rvzjs8z4Jmrb
         NDGgw/KRYs58S73WjrnmSNUa6yXqR/NvLEYFd/Kc0LHfZpPZo73ikeKZThRaQlnr0mxx
         2RCXaN5rCm+25aHcDZMyLrvrulVm4vr81aFClgDCM9HD1CxXyESLPq9JJKS480q7oSr7
         XVfAyTNiKZKHf54lWM4HMOAKfzYTGaqFD5i1AcwbiHiSFZ4L58oT7zOFc6RBo+7wgHIW
         XS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wq+Co+PTe/9OQJlUbPQtbPUN6JHrxxC5Wajt9QbB+RE=;
        fh=AaK4O7+eeP/Jy8C//HCSKZAhQ6N+swYC+x5qvQrzE/c=;
        b=PwgwqZevvaD9SsdIZhDjT4lSLqTlcS0NWOz05xUzafiAVnfEr0Jn3t9IcXtQgznEdq
         bNCzhbIaKGDspsxbj0DIOuo6FN97MbGYdP1MYAKhPJ/1MGwsnN7iKwfok/E2SsYR8oU8
         PDHVNvx4MrLzCaN6f0AE7Z5RXSZPgKa02xQH/am/wGGU9/hdTBKe/XTU9dMNE1UwCtGB
         KUVRJD25wrGQNEyvF/f4S1TJ4FYVlHc861bsitFUuev8QFprJwgJKdSHcRzCx4FfWNGq
         TdNPC6HQDYjh+fPFEBYzFWZISz3XlLKVR4or1vYdF18+tSz5h9sVRgsXS0hI4K2+Z6vB
         E4qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789476934; x=1790081734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wq+Co+PTe/9OQJlUbPQtbPUN6JHrxxC5Wajt9QbB+RE=;
        b=SCEF74oSOajF6IKtPItKR3YIJHuVIKtw/EtsqXJQkbl3ST3fQ5zSffHqHOxLDorNze
         YqBx20b4Qdvq+6jfkqhnEm2q53z4QJWs+ZTk2lWhH05jmStFcxlAXVHa06lXwABUA64i
         A1ChiWiztoOFvIsU0omHRqdQxF8JncV+N7/izbrym/P8CCfbb/d2vTBNdvORflfRMRro
         VuZ3bkCwLxIk50ykjzxLQmy15Knq9a7Cruzs7jDZksJ2cSI4ooOHX7M0zVMkwwS9XmCt
         FnCgc+oO2BJnCvTue1vOjS9CaHOPapMnl3mNWWyJkN+AeWzaP1USRlOczvGvTCrb2scr
         hkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476934; x=1790081734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wq+Co+PTe/9OQJlUbPQtbPUN6JHrxxC5Wajt9QbB+RE=;
        b=Ow8XNVL1tJYBq2xBax33/D8tr0CxfIaD4c23GLXfWZRr4Ao5mFudplfVYMbRzJL2hN
         BwYEFe0IG99lEyQESaz2rxGK13tFrZLy5CcgHklHVpABYM9VaQ/vhX92teqws6HGe8+/
         eEojaOO+kruzQVNS6OrmJYwdZN0N5m7Z0beL8224SAxKo0mt3e8xaN66lDcUD348H/E6
         5MvLDBZCjH4kjxngTWiTuPmAaFF1I4msSFazQFyujCDW+HAKTPAhKUMKgjs+KzRFix6+
         ZLFYv9n6nTRqBTR1ALNohQQzs9VLTf7LPPBRla+AH+dcsGL4+SGfQ0sVJds+xy13eETq
         G9LQ==
X-Forwarded-Encrypted: i=1; AKwUvByYcOvYz2kQAu9ixeVHvjb4X3H26tUSwgevyCZd9cc/YIrhLto2T2/0z8L9D0V3hQQCvma59sU=@vger.kernel.org
X-Gm-Message-State: AFuF++ml5M8NcQrjJjY6JJEhdWUxfAL7MTm3SiC88KtMJ53tVWPhuP9z
	1Yqnb43nosgUIG1QtcVrXmI+fY85f03zv/UREvtXjwVBpEQ2evInxxTcCaZ1JCHTWX1gqag7DZC
	gzJjaqx1VfolzeF0PKDuYUUc57xqdlLUzYSDNSfBH
X-Gm-Gg: AYBFou1xrOrXEcwMpiGbhY32m11Hjug0OC2/J93kmrGnMJ5O/5zyCOSj8g4zZw7uIbz
	34f+Cn5YS4SlvOqoZlyKGa0eQKyvlaTgStLSUM/IY5k481xzM1qaFva6ZKIschrkDJPBH5aM9yn
	KRpGJY9XCzutEEd/B0xAv6F4KVspV7uc7v3LqNUunQCqkn6ag18FNeicA+pjrywymHhrxv885y7
	FkjdAbWo/G1Naj+xeS1BHhqD36peT4nFCKtoRnEQV8X8P+Odi8/6W/hkWCACqSGQX6y9VKGzcD+
	X/xv5in4KsOUre9w8K/TkmJy4dFQhx5rGChVgnb58QxRipo/YUr0MK35+id2gjnVPxgW+mjGVDs
	Ih3EEF0uj3fL3B8CzXSkg0aKpSXGGCx03W710MMuDb6XKL0JMdWR5YWYI5gi8oPNt/Tk=
X-Received: by 2002:ac8:59cc:0:b0:530:b2e3:86ca with SMTP id
 d75a77b69052e-5310d0abafcmr103588331cf.60.1789476933047; Tue, 15 Sep 2026
 05:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911114922.621937-1-edumazet@google.com>
In-Reply-To: <20260911114922.621937-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Sep 2026 05:55:21 -0700
X-Gm-Features: AcwNN1XJ4rXFdgQz-iZeZq-CFXRqtIVaPJPYaVXCbl4DhnIUPyFqJgpvkonrndk
Message-ID: <CANn89iJtFN9wO6DG=zU6NLfchru_nv4_0SMghSwm8sQJxKLnUw@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: do not leave stale header offsets after pskb_carve()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 4:49=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() remove
> the first bytes of a packet and reallocate skb->head.
>

I will send a V2 addressing
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260911114922.621937-1=
-edumazet%40google.com

pw-bot: cr
