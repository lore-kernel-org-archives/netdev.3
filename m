Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017996;
	b=F2gSOgVgM5ogcSnTxs0G/KeESfsDJFgkVG5rhtASApwrf1FbAn7AlqC7OIIK5Y5nhs6E
	 UiW9mwlfFQmmu6UVFYRvZ+9dipHfc4HRS1Ub0HpxJ6ge3yKw0RCTgLF6I45vic0xZYP6i
	 WYA3LnhG+RrNEh56Z9P4blKV+IDdchI+W4Bl5GRnsiRLncl1v1yysCfoiVsombUhlxFjF
	 02UCwRRXJKfbiL0o2qcLNmMzjBTcvYkNe2ZeS4KSuYWuZmHd+CZwAorB+0UDdAysJeb9v
	 0ajTHf2ycskYV2cgftc2XWqOmomhvgP3vpnhfWY/R2LUlkwXd1sLkynj22Mb++JavXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rkisdwNIn8uTnkECMBdY4BzVA5wTAqs0WDJeDG4YWNY=;
	b=yHYa2alqI8ROlF0fo4apdx+SHr+6r9QBGUb7Wd3M3/pEXkVPal2VRgn+OtK/wU7Z5I48
	 WMLnwCH5YyywdnOqnNkC+/Ag/0jmKnkPHmDhTm7iHxqm46BwqbpZtRtTtuZrDkk6q8z1Z
	 3R5Txt+mrDaaHi8qVQSlSteYJLeYcoLAKIn4+Dw6kiPWfdwXL/gHdCfPvm+UXFKjeZvfW
	 st7W+F2qKXJ8/49gQ2T+GYvIm4UCooNLVkcI4/fcCblmR+VFdo2EOqdbKQWxXP4cVORF9
	 JMWBdwLsrJ5mX8HNfG9zAwKEl5Z/qQ4uUCiVVSZrbcSbpJY/B7UrlezzucqhhtsP5BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="C53h5S/J";
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11144606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11144606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=C53h5S/J
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c247f6687dcso439500366b.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793017994; x=1793622794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rkisdwNIn8uTnkECMBdY4BzVA5wTAqs0WDJeDG4YWNY=;
        b=C53h5S/JyOfMGXKUYSZbrQurHCkZF/KaUJ/Vi4gQHfeVL8tXR6k17Cb77keeaBMbQQ
         0VIfl38twCtNPUOKC65JivlvzsY59r7zFpE4sv8kka7+ywPIszBnGeFrcHZWzH3xyHyR
         7P8hyNLyMVCSg2zyOA7AJNjjTpKlb5W2MyhHZFNuxPG29QHxbdGQQFwvMjd7DKYz7LIo
         Qskhvi18uEJiMijRXcYBzmTrWhGu+goPCUh0zE1TeXaSb+olwbuq3iDE8w4755cc6xh1
         pLLksE+z7I7yVEKnmnW5xIetEevSD7ajKxtUsX+1aHJK9UDf0S0owIjELZcCxVaDPjsK
         Xl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793017994; x=1793622794;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rkisdwNIn8uTnkECMBdY4BzVA5wTAqs0WDJeDG4YWNY=;
        b=Skm3Fas1xKIrM0Uclm45nUX6pZlMEPiLF59N5ac5ct+yhNvY/6phkmaiE20nRnHadF
         9o6hImoWNMaE6n1yYixy03MlBxFQUNTXNM9RS6u5FZZBE36Rjirg9RFN1eAl+fGEXvuX
         f/y1x/A6mNIZMKvvtjgsMrS5eopMjfkfsZTzJkhKlg3OIWPbVucMgYiJQ26qmlNqE7kh
         c33u416Xl6oMjgvFbiJpIcDeveMAWCZO2OcOSuFbcYeIkwzErQxDIj9FWLYQdpkvUy5r
         IfmhyCDjs8N7O+R/VwRcb5nWoU1nFYgLB2d4Wu1gPFBSFyxlG0+yppUYohNXhskwL66B
         CfgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwK4lyf0mHu1ok/4N4pMzkwGnV9RZL3YypDt4n3pjfvjr8jd7aSankKFM0X7b00XcLZLn9CJbw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYM3bamAPs8i4aXHm/+lz2prNDRn7FfPo9bEoQ+KdQqrEAnqBS
	E4oA4B08R4HT+cIMi0zxo5i6aL72LF9D5UPwYpX9bnWix7D/zzU6ypF2Z9qmGumA6JA=
X-Gm-Gg: AYBFou3NriY+WKQ86zjOr4aDbo4FI8jK/zm5tZpfQgLPZQU68m05t+hyvWzNcBmIONv
	O8FqwmyH6C8G7RacyQ4jdf+jJ+Td2z9KJk2fuwqfow3mbadFrCOLZZJXfJL+IIuFhwN3UCtVzpm
	vAKIdMmsSmesW1NTbf4uVCuZ8I4jqS7n2l25t8J3fvOgTRBocsXDIcJ8SAkHPwd1/slo6Cj6L3x
	2qQFUm8qQzbcGdCED6+0P7+MtX93diQLnIKwoQgAi9ViI6XP51qdXptjTMgm9jRbJ3wfBc0ADKR
	y5/s8fOAVg9AJd46CEiEPHMgRWk9ydYdghe79tHERX02Em2zCMuuGLaJIGTefT7zw4qmkK00dT5
	whEFwu2a9RJF2emRBeUxO1sWHpCgKut7bh45oqmP6GHwuCI8bBRM2G7pkR6Hh87F34gLl3XrTKt
	aw2lwQ4LtP2YTc8O6GdZ29g4ggyHJERYjZOVuvdANjHaBfFV/vp+s9cPNq6Bv+VBVrEv0Hn/LNA
	is6OT7yE88dtTcQgN6JE4wIctrFfdp2yIQOPQyYhUE2xg==
X-Received: by 2002:a17:907:72c7:b0:c46:7643:ae91 with SMTP id a640c23a62f3a-c46bdbeff8emr745672166b.8.1793017994409;
        Mon, 26 Oct 2026 05:33:14 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:17d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7975b2sm320027566b.73.2026.10.26.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:33:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dudu Lu <phx0fer@gmail.com>,  John Fastabend <john.fastabend@gmail.com>,
  Jiayuan Chen <jiayuan.chen@linux.dev>,  Network Development
 <netdev@vger.kernel.org>,  bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
In-Reply-To: <CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
	(Alexei Starovoitov's message of "Fri, 23 Oct 2026 11:53:59 -0700")
References: <20261021155629.68813-1-phx0fer@gmail.com>
	<20261022054811.35008-1-phx0fer@gmail.com>
	<DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
	<CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 26 Oct 2026 13:33:12 +0100
Message-ID: <87v76o63qv.fsf@cloudflare.com>
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

On Fri, Oct 23, 2026 at 11:53 AM -07, Alexei Starovoitov wrote:
> On Fri, Oct 23, 2026 at 11:49=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
>>
>> >
>> >  static bool sock_map_sk_state_allowed(const struct sock *sk)
>>
>> Code LGTM
>
> Jakub,
> Could you commandeer it ?
> Dudu is clearly a bot and doesn't care.

Ack. Will drive this.
