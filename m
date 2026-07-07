Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF542367B85
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440527; cv=none; b=RuzdOV2CY2hSroMSfk1GI0u/Xa1WFB344Kffk3lxCnoyxz3hatsGIrCzFel/CrEPrfRpMaax2lqJ/nap+WNXtdN4GwPHkgM79leAKcusLMJc+5wxjQ8QxZQyy36HvrzOFnAXgKvawUmXf8z1KF04+kQ1pcIvmFbridexgmUVjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440527; c=relaxed/simple;
	bh=gYxQlABoejgiGiTs0GRyEyflzw66+wYXuoHMbNI/GrM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UcoFQh5cUJk2ilLJFPh7uN7PsbwTpMt+erAh2ifo/9oQwIbatKeCryzpcvBSKws9swx5/2vJjBfZZxPbme6BFxPFQ4eu3xnLenToVfPQYYcf35F+RTtZ552RG+nklODzY+OJhiSGkyUY0S6vFAfB2mtLLiDbMsfpkyfIXsuCcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=NFwiFwUJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="NFwiFwUJ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8482074a000so1707489b3a.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783440522; x=1784045322; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cMBdmbNnt7rGb9jJRQ/x9X78dUBABwOU7eEiSX3Y2u0=;
        b=NFwiFwUJDuLElpeLXlMcfWbWQwuWg7gzGSNfH+3OeeU1Lx0pzoXEsnBJcLN+yhU2CV
         cFULfNpRHhD1MGGLnUJjPVUzNc/vuvaCLdDzJ6gdD0Mn5EMno9EfEV1e/IVSTKfVNlcM
         78SQLM82LBHt3q0gEN18WScXXCT9dhovZ69VlTrzVVcDnon2AJKCffL9SkpbXtycgnyv
         VpaT9z9F94qq9um/SbouFMQbAu7foU01PczPXbKdIS68CpyFlS20tReMeye8dYpOrbP4
         ZLfMqSrEyvw1ui8MniJndKZoMZ+72SBxLx6r5BsQfMBPgBMxJ+4atZzbSDBblX6sWtY2
         5kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783440522; x=1784045322;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cMBdmbNnt7rGb9jJRQ/x9X78dUBABwOU7eEiSX3Y2u0=;
        b=r6xVA+D9HrtGZquLUoE4JZ9VNm0uGxIcVfm7jdoAuX1bxufgKVvFzI9pt53qaBYGXi
         l/Chs4zadxp01g8JNKFSYEbDtRc3Rs6t4Q2YYHeJZN1t5vQgcyIPSb0LCENBK1rOHWB/
         Mdmf89MlGp7iTp4TkAELvkHKMAuEdB2TKFNWOVaXl8LogSWVF4wB4CwL1RZUku20Hxq7
         D4oPmCPMF0hyiE29CXirYabnOHp+k2zfXamhYMkrmVxn5Xah2FGf7CbnYI6u9mcy2LEV
         RU9APYoIaY7eoYGTh0HRr+z1sHEZ/UIPyDXIsPoDohhwufCItY1J5ULDYpv4DsKJm6iG
         pmFw==
X-Gm-Message-State: AOJu0Yzwv7Ri+SMg4KUMWaMzpnYzhmOMs3s4XPBzoPtukb5N4h3G9gTC
	d1qiSPcanZjgzgnZoRPK57RCaJeg6Qf4WVFWdK9ZSLuEpTIvz9hnPM3ks1HesjL239I=
X-Gm-Gg: AfdE7ckD+u9AG6hLySMiJs6f7s9Q5qb9HcW6YcC5uugeJDLn0oozmhKSYFlAKEtIcwW
	PaKwoao5SeHk6WGVwwdeMWjApUXiLdqBjxdd9ixSzolEfZ2Srp3DkBneQDq9+2FFV0csWw1jcU7
	3d2v1dEhxsIzuw15S84TS6p+shg/NZA4c0Twb+uaYCPc0HtRwVucDjg8hSKJRxaougV+CnMSlL3
	3G31uJzBpyawq2x3UwGomiRIHuCnlbKpyQLIaSygePDnto0ZPn5xB0FUs3FHOaDw4RdD0yf8COl
	peuTlGC22q3jLpsy56pb27GEa6PRoQlI3mSBeSpyeaQ101G8B2CDkjUyJowW6R5C9V5b3vyscsM
	jQk1ZoDf6xFr69jIThm7Q75WFoxJxAlo4dPZEGRZwU6aDCKEXCdFTAgghcCbFy6wn7hIxWrJYYx
	vR/UDxDukwSyUeqhJLUbOAtHg72i61R3tpB7Vl/w+QfcxWrPjPZ1FY
X-Received: by 2002:a05:6a00:987:b0:848:2f74:1d59 with SMTP id d2e1a72fcca58-8482f74207emr3285927b3a.63.1783440521110;
        Tue, 07 Jul 2026 09:08:41 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6bc9f5dsm5702549b3a.27.2026.07.07.09.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 09:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 12:08:38 -0400
Message-Id: <DJSGWFQ1Z86C.214O720ENTA1D@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <ncardwell@google.com>, <kuniyu@google.com>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net/tcp: Add explicit tracepoint for
 tcp_syn_ack_timeout()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eric Dumazet" <edumazet@google.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707010151.43976-1-emil@etsalapatis.com>
 <CANn89iL23Rsu3iGXxhw4pAnCB-JgU7fnrryDLXKj4jHqSs=HOw@mail.gmail.com>
In-Reply-To: <CANn89iL23Rsu3iGXxhw4pAnCB-JgU7fnrryDLXKj4jHqSs=HOw@mail.gmail.com>

On Tue Jul 7, 2026 at 3:52 AM EDT, Eric Dumazet wrote:
> On Mon, Jul 6, 2026 at 6:01=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> Clang can inline the tcp_syn_ack_timeout() function during compilation,
>> making it impossible to use kprobes for tracing without preventing
>> inlining. Add an explicit tracepoint to it instead.
>
> So much copy/pasting for a very small issue :/
>
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  include/trace/events/tcp.h | 72 ++++++++++++++++++++++++++++++++++++++
>>  net/ipv4/tcp_timer.c       |  3 ++
>>  2 files changed, 75 insertions(+)
>>
>
> tcp_syn_ack_timeout() is hardly a fast path, so you can instead:
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 322db13333c7..ab2c3de19e46 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -748,7 +748,7 @@ static void tcp_write_timer(struct timer_list *t)
>         sock_put(sk);
>  }
>
> -void tcp_syn_ack_timeout(const struct request_sock *req)
> +noinline_for_tracing void tcp_syn_ack_timeout(const struct request_sock =
*req)
>  {
>         struct net *net =3D read_pnet(&inet_rsk(req)->ireq_net);

Sounds good, I will respin and just mark it noinline.
