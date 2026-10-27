Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122452;
	b=f7Z+gm8R9A4ppa8NqcOzokzeH9mv1L3OXJLXqzf/pbC8pc/kmklAI/Tkj2RVvgIUCQbe
	 wbjcS3TxIFRwYDeIUniKmSICgzuRU0QhCoVq7qiAudQSIaDBX6HpW/ifTDoD+EdGbz4hv
	 /Y5oURwlZksbLTN0dDpwg24i0Kb8igVHu9EavV946bZb7b2a9NaHTAuBM/HYCdWuKO9Rq
	 qbGYHSvn66tK0ieVEiK/UOYjjN/HZNO0uT8RTuggHHJ/93Xomyv/uiOUZQaHNbhMYTx36
	 NSZjco2W24iGj+7bI8q09AKltpeM5Z27K/VvHdI72D7BFYeNoX09MnkZcz1XGUjkyLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xNDyp1upp/wsr8lQ+FwRlQnHTSKRi5xYjt4jiZaQ9Lg=;
	b=mRYgj4wsPvOiY3GYMSbupOKPz/u1E2TVEL5+XbVDyM4K0mlUkQPlk5512dWL3Dwc/8Aj
	 J+ei3/mNlt3kArILd5KKa6kTPe2OieIAU1IKtR180Euf8+vRgMvo6t033d5TurQPQOFub
	 tbjVoLBzDLJnDqhelU9am70Ji5u94vXG2MrUkb6JECIeYUcJZ0sM47PEXX6jUjrdEvo+w
	 a0LTMuOg5IRAQk1SCxvC0YNqbIid+7VD+Ol7SerZIJWzLJZ1aw7+in1EEha1YVeM7CNl1
	 0pGI1KvVwtePAKW0Kw/ThcCtyWhERAg/96R1VeQXKrnMzjGNN/Plh8xEuf9BxAFjJKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TgVxkn8N;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7FD606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 17:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E7FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TgVxkn8N
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so250698a12.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793122451; x=1793727251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xNDyp1upp/wsr8lQ+FwRlQnHTSKRi5xYjt4jiZaQ9Lg=;
        b=TgVxkn8NiUPxuA0PIvqXpajyKAjwQeqEfgOE7ZQLRRiP7zLZkge8/7fFG6d4ChYdCw
         Q1SsEjfACoBX96ETwG88YTHqcxHrLqD1Oq8Woiv2MgByGNs0T928KDVXS/le7XnBKtSp
         GJCdJ6HLKHi/u6+Nvxw1HiQZ0dzBc/Pza4uzp4gdfO8t/+t/eZucKnb/mW2duhdTLX0f
         ubmUzAvs1uforE7rtTrEvRWC9mSymJisdyIlZcAYiRtrbstJu1XZUQkL5a0EqAr3qji0
         iTeuq+SbZzs1N9SZzn866NDZyNnndBTbzwovIOvKMI/w5zRCQ8GQZd+Rpae2oo2Ia5/7
         zAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122451; x=1793727251;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNDyp1upp/wsr8lQ+FwRlQnHTSKRi5xYjt4jiZaQ9Lg=;
        b=veC6Ieqy6gJRnyg1rFJ5bP/5I+OJyyigMlfqEEXjG8Yr26zvzycJxeT4hE9QPm6Uq1
         cFVLshkHCXfrkbo+W8nxiMA3u2qXI9matsAidUX6MSRubbphTT7TYom1mhTxRhpS4nyW
         yk2mtC3L/+teqcXecl1mdM7Vsq0MdshcReelswECZuHDK4imijFNAvxaXc/ReM6Nz0Gc
         4q8MGUuog7yBEBtgptGjk+AevJQCQEPEjs1auz1w5E7svLUHsxHvmhie+pITMPc14/Cm
         YeH9/toH7TBPWpEw1PFd0JCI8W8mzfw3Yn5m2EmV8XszMG5IHXxNBwBr4QJ2uTRcUoMq
         l5uA==
X-Forwarded-Encrypted: i=1; AKwUvBzPZxMJtra/CouRZSV9EAorK9gVPsXCzAwD1BwW00mxrtqMvIV7F4MZSZ6tJ0ydqYyUJDkQhdo=@vger.kernel.org
X-Gm-Message-State: AFq9FYITCnsgo8Cn9M2RcVjlOFKC4OOl5O3JwHnBBb4ueciEMhz7ji0v
	OOE0qz95MfiG19yYb2hteAl4wRnD8miwNOqaG/ptuPhHlU1v1Z200oZQmRqxaWHWB2I=
X-Gm-Gg: AYBFou0QV9DJpFKrsxwTi/AnIpfW22TW/tRvMun/UeIFE/Uef2SYq2DKhzpRwNdPSJw
	18aKDpB1wHPnM3pUoWQLq3uU+eVFhdt4Rgb/NijwDktm8Pp3DJZTeObu4O4rHJ1XTwNo4mtqNgL
	WA/21jWxjPNrCTzaf67h0CfFVe/o/O9w3wW72e819kA8YqHvttv7qWSzKwVl74K3xM4idacpftY
	PZraLdMlkDxqKWYNNCEbHmmX0/L/R5MZf5mdDy1hlndcJCx2f/eaT58Z4MrlEmaZtV4K76xbFqi
	wkLzUR7QhzmPLkruCBVmwdO99n8ZATzQKGMNUEYnY/Jel4PcnXT3w1/TUqnayLZGiE1rHq6BrnG
	DnvgcocWfFSnPjbva54nonRa72XeAVwhBhOt1cRXTN+GRrmM/IuSrDxg9TKx1YLIIuiKqyVLYRo
	FPotQ1imWqoTP4qq9cOdznSuel/rtvKvzYtED+PPGT96dsejEb13jCS7gQunHC6A2eAKHM5a9CT
	mG+3YiR3MWCzzjaVy9ZG3gpxnIya24h3TGRPT5zBweOww==
X-Received: by 2002:aa7:c4f8:0:b0:6b1:c6fa:c45c with SMTP id 4fb4d7f45d1cf-6b442ff7c46mr7973700a12.38.1793122450667;
        Tue, 27 Oct 2026 10:34:10 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:1e9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964601f2sm323930a12.37.2026.10.27.10.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:34:09 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "phx" <phx0fer@gmail.com>,  "John Fastabend" <john.fastabend@gmail.com>,
  "Jiayuan Chen" <jiayuan.chen@linux.dev>,  "Network Development"
 <netdev@vger.kernel.org>,  "bpf" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
In-Reply-To: <DMFRU74YCDSH.1WJJT7VL3MEYE@gmail.com> (Alexei Starovoitov's
	message of "Tue, 27 Oct 2026 16:46:11 +0000")
References: <20261021155629.68813-1-phx0fer@gmail.com>
	<20261022054811.35008-1-phx0fer@gmail.com>
	<DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
	<CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
	<87v76o63qv.fsf@cloudflare.com>
	<CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
	<87pkwv5cj8.fsf@cloudflare.com> <DMFRU74YCDSH.1WJJT7VL3MEYE@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 27 Oct 2026 18:34:08 +0100
Message-ID: <87jyn359pr.fsf@cloudflare.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 04:46 PM GMT, Alexei Starovoitov wrote:
> On Tue Oct 27, 2026 at 4:33 PM UTC, Jakub Sitnicki wrote:
>> On Tue, Oct 27, 2026 at 01:10 PM +08, phx wrote:
>>> Sorry for the long silence =E2=80=94 my laptop died right after v2 and =
took the
>>> local mail and the working tree with it. Agreed that the ordering fix is
>>> the right one; please go ahead with the commandeer, Jakub.
>>>
>>> I do still have the reproducer (a KCSAN selftest for this race, verified
>>> in QEMU). Say the word and I will post it, or send it to you to fold in=
to
>>> your respin.
>>
>> Feel free to iterate on the patch once you get your dev env restored.
>
> I very much prefer if you Jakub will take it over.
> 'phx' is a clueless bot that sends spam across all subsystem.

Got me fooled. Thanks. I will respin it myself.
