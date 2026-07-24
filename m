Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488DF218592
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887371; cv=pass; b=Ts+Q6MiJp48HKhX5rL+vJYeDOZx9pNEd8B2KmAhUzq0hkYlTDIlFPJNa1XptQSYF/KBYmXoW6s4RdS/FlMw92OamdGsvenw5O1gyimFuRNsQl/TmOW0lwxC3IfqqbnayMzSupllC5OlaZHz7f2BkQ3n3Cj9SlUcKKwBBDtgH/5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887371; c=relaxed/simple;
	bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGiz595RUZhv0kUY1nrp0qGHRCUoPl/1CllrjsVAZeTnVpbotYfgF1Q3RCDTn14bwDK6kVIKKqfYafixqIYwMNtnzOLfqRMXVPe0uLwY22SZE5fvWRJm/bL8og6FeXf4Fs06T3uNy9S/UskrLRNqi+yYAoFox5JSxLUDMFcpzpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie9j1sjQ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie9j1sjQ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69c3044e4b2so31317a12.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784887367; cv=none;
        d=google.com; s=arc-20260327;
        b=MRp8lQqrXQByxHQZ6eUYjtCcRNnfH+0KnUQEfKtPY0bz800Li2ygWZoyYcsZW1Oab0
         bIBdlRNkwvl88XL1nEVlzQElMhUgsqc/Ik1E31pyQJu0mSxiO+sywh8g5sauwFGLifBL
         Rj05gNNqRsAmvevoQ79qXuNHSuNJxpzE68tSYwVi7RiEep0QzLdJ+bR2TVUuhoEpd7lO
         TVSRse43O1EBJmdCAeXZM/pC0i/74vUubElWlC5onJHdoqLDEro6Rj7T1yAlQcgi6eEB
         BkjFhNVnMyT62VnHGHl/OHA47hvFMf5ph9mWsBWPkjwcPZtg8Yh6Yv4e7g9YUbxAROII
         BDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
        fh=NA0+M0osRSje4vxIzWWkX47+z5cOpTOVRklFtzp1Mt4=;
        b=M9AAaGHoRD1KBK3G2KiDGVrYoAHSf/lSjuKXByPkTFUsYBJLsOclRWhT0igMJ5Wel9
         oDEAp/3KeNubVRzodL30Dfyt+6eoT5YlzOZKl5dqy6sAFTr36ioTaw5iIu8gVmNMAVgm
         ruJqS/ISxXh5UZC27+KaAxcxylD9VY5rlm9actnswY6/TRuVuqkSsl+GcJ705ZBzsAi1
         bNEJja/d1kZ4kjp1xH8CMPF06KldOolw5BhCdCugtVycIpD0OqEwQbbd35FTWDvVzWyq
         svs9jDiNMoJ0MyIUHJ2oiSbeZXw0KaqCt5F7HCEOb9WGvxUYjdaRy8AWS7ENOUoVLnAP
         Gg2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784887367; x=1785492167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
        b=ie9j1sjQXi6oO16pWAfr3yBFSJQx7smD72iWnrR6HuFhZezierdTz9lEWSNQ7hWyrP
         I5XOYGDz+PvTRquSJzh+J2J385R6Wy16WXQsYcB7nw+ra0UWCd5gOsQWVG9BsNau47kX
         gQkc085nqcD/4p2mjjLf0GzWsW8H+PYpoBK6OUhP5ire1rHzVMabp4/H7GXTmYXTnvvC
         3vD+M+lJON47R3LggGp7RVcjyE++7qTwX3DaMATuOSeFj8tfs/h4LUxA3habHSdHjKIz
         CN0n9EX5mUUqSb7pGuvw7+/ZLzFfEzS6E3ku2ElbpDH1B1547K1ephUeXIxsXLsZzmMz
         GV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784887367; x=1785492167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
        b=Sxbzuqh9KKsdODyB9OVC8W98jZ8WIA6YCe7n+AjTyr8StuBpMVtrpEPAP2jIlP0sY4
         3A5uOgdkaVAsT1kNRNtHuC6jOyB00Xg3Rf2OJ8JC4H7gnZo7gdXNGbge0NIP09FKeM+g
         dbT4Iz1CVNh+t8J/UON4aycnjF3ClqX7x0x+B5O2uySD2zHB+HFcJwYyf9Xpv17+tWSt
         9q6eWNQpFf8LEGDEnBtw6Wz2oe0p1e5R2UKmk3Pf9FNnn1Kt1XSqzrV8lSes9/H5t2Z1
         5OPyW2wSJHOmNUtD+DZ5gh5jxw8iqzXo/nC4nHoVjIoMmjdQpWpEeqyU03mLxAGqDD4v
         GfMg==
X-Forwarded-Encrypted: i=1; AHgh+Rrp00ZHB4K5hzfSn0n6ulJJRpvlW+evcz5Q0HhAsW57r0haCtPKvBWvLHA6sTPEU4pIdWJetmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfvo5PqKLpqFelaLsFjmw1pAUuadN0W7tyL/80eMtyUf4XV38G
	59z5lVK6zkhk4vUcDadn/CP1Kg7FL0EDNwV6s4A/Rw2nCr5pHoc/fpDi+INxwliHgPnvrPgWmTv
	79MmDlBBjb6yuhnx8vS5vUqD4Ao5r004=
X-Gm-Gg: AR+sD118/dfHPnuhQm7uhFcpz+gJEqcbae9QYF6L4ZD6NiimDadvHmPayL1gVlZwukq
	s4WbagoxGco+3DJHWSEvZCwtOgzid4ucM2kA/3cFHPagUVkxDqXpaKcnT4GyjQyMTJ0Wvin4O/3
	FWK5QhF9qfKu4MzZSuas9QWSFQbh2r0vrXYeNOr22XrEgAXJrKb7/6TUEXkoNLpk7q/UCFDkQrl
	rek7sGCmF3IredN3LMro97a/gP5PcT2XEf9L6/Nie44LR7QtCbnhGEeZouSBU9CLKJvrdYTHdx5
	WRaKLyez7g5MK4Q=
X-Received: by 2002:a05:6402:3997:b0:69c:7a3f:9fb5 with SMTP id
 4fb4d7f45d1cf-69f8ddfa863mr771337a12.7.1784887366457; Fri, 24 Jul 2026
 03:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
 <20260723162602.3275661-1-nicoyip.dev@gmail.com> <20260723100030.3eee6d51@kernel.org>
 <87ldb0lo8t.fsf@cloudflare.com>
In-Reply-To: <87ldb0lo8t.fsf@cloudflare.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Fri, 24 Jul 2026 18:02:33 +0800
X-Gm-Features: AUfX_mxJN7h4yxh_VHEGxVwUbDqmPuLUq7be4uNYXJEjMRhF3AJnYtdiUAsj4Rs
Message-ID: <CAAo+4rV_5B-KOQgPL3BC3WKGa_otkEUXD=wDjCig9M0Se-mYtA@mail.gmail.com>
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 5:40=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Thu, Jul 23, 2026 at 10:00 AM -07, Jakub Kicinski wrote:
> > On Fri, 24 Jul 2026 00:26:02 +0800 Chengfeng Ye wrote:
> >> Subject: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendms=
g()
> >
> > Since you are spamming the list with the reposts of this could you
> > please add [PATCH bpf] to the subject so that netdev CI is not confused
> > into caring?
>
> +1 because we need bpf CI to run sockmap selftests on this patch.
> Please point your agent at Documentation/bpf/bpf_devel_QA.rst.
>
> Contrary to Emil's ask, I'd recommend fixing one issue at a time.
> Reviewing multiple fixes crammed into one patch is harder, IMO.

Sorry for the disturbance. I was trying to fix the other issues
reported by sashiko,
but it seems it is harder to fix multiple bugs in one patch despite
being the same
function, as more issues are flagged by sashiko when a new patch is sent...

Then please just take the original v1 patch for reference and ignore v2 and=
 v3,
and I will stop sending new patches for this report until there is
further patch review.
If there is a new patch, [PATCH bpf] will be used properly.

Best, Chengfeng
