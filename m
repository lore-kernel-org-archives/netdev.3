Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634847279F
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844826; cv=pass; b=GNYFLt1RZolnwL1oVgcsa7BHxES4A9AQA3IGoHRf4wfD9n0xXxrHXuIC8hYXX7MM3qHu7GfCSZ8tj6r7Pzs5JYWE5ZLKlYiECkB+ZCmIVvzm7E+vozEjmyDbNeyfOYKbl7y6bCbYEiw/P909/uib4YbK9pdqBRnwBWOMcPRH288=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844826; c=relaxed/simple;
	bh=iGw11a7YLe0gPdwQyw3cFTQawIhOPAiGaMOvaLBDnpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfBkc/NmtENvdQggmK/ufmfheuOLsKl2fl9BMdkcLUfmxJH5G2aT1Jcv3YWN3eo0NB8DOEZ2EmACqjytc8PXlKB5qvijBaIpGGGkgia+Noc2T1NwHZ9gFgOk31TvtFT1jMN2ie57gYT7QAiSEYuyK0V72NEy5QCRprAmtB6bTZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4w4l2hm; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4w4l2hm"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848643382fcso79592b3a.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787844824; cv=none;
        d=google.com; s=arc-20260327;
        b=SvPG5gcUoLV5qxa/ieCPMfkmIM9BPTGylB/H0n0KVW8yGr1IY6sSwCJFmJTINbZvbu
         w5cpEC0z0cJdptYCh/jlvN73BpaWaenq+UJ0t87KtTbEfy3PFZNC73Xm4t8iC9RGTyxJ
         8UB9xzv0p42uz3orjK1euDU5fCobebMb65MvNENAzbMJH/GMcrlEMD2UZ/p/VwIp4JUe
         l2XgFqyu9dmZYqUS+nmPC3fwgFGxdG0MjCtsmeMIYJ6/JLK/rzaiMXIizN+yORZDPwXz
         bXXeNh5tSbWhAV9N0AQF/usEU9IzFGybqOHIzurNv5gwDCxtwtIbXCo6elyCyh15Yv0u
         XxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7LSVRo1/iukDMNY3pIO3IMwPa3nnSHwmCJBaTRBGumw=;
        fh=SNYqV16pLwUcQxJfi08M7c9+IC7AB9hpKksGKtKeXZg=;
        b=keNzW2JJXZyZ4EyQ8ae/QKkdL72VH42k702gKAYlUnAYpK52m1jMeovBQPXO4qI/wn
         C7ISv7o/nVkbC6pt606HEMrGFgS+n5A9AJ4fRlAke/hHMEAgGsKVa/CC3Jq264e/MqhO
         daMNMrG2SzVZTUCd+8/opApxXoY8DQl6IJeB42aonMa7PvU6Ap+qsLQlvkjea31Ujk5y
         tedB414mpteoz6qk+LJwmVLEUBadCXjsn9SZAaeSesSIp+4lIGywvTWXC3BojRvYZblI
         H4gV8ln95SXEiRgwg2ONtw9Ci4YE5bUU8u6Saht+iadnMX37sHJw+0m92ws2YDMRUuO8
         ZFCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787844824; x=1788449624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7LSVRo1/iukDMNY3pIO3IMwPa3nnSHwmCJBaTRBGumw=;
        b=i4w4l2hmWbfH34Udk/ZlhJD5hPDchbIcR4oCUJbMzVeKCapyirSvmHsvHgrxd/Ar5L
         pPcGE8/HlP7/LflTJVdLS9dLry7jV6vgoazchHTTjKcj/X0TFAnrV/x1WBNe7tbeFRsu
         aZeI/i8gQo8UbgVroNvGlkUSsPopoP4J+Kr71CueVJp9Q1uvR0xPNoGOxx3ChZPAZk2G
         31SkNapZliZm8nBZ/tUA/yFCl5gfA2dx28dIMulhob1JYLYN01GEWDp9wiY3Y3xFB0RK
         3t5D28aQkSmaaEPGYjGOa10ngzfVKGdib201A9JJ64ndeNL9dXg6m0Si0jG4w0khuUWh
         niAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787844824; x=1788449624;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LSVRo1/iukDMNY3pIO3IMwPa3nnSHwmCJBaTRBGumw=;
        b=UaoREYbjZ4QX0Pbei/CxJ/RHgd3AXpJHo/FLFWb+tGLMsx1K+FuDrsweFGr/e+Fipa
         rG9PVVUsBD5WfMIz/2gPaAyqtqjxDxA+BvSIIpIFq7cJPLbQuC73YO3eMk3G3QkTEUcY
         mP6JZM1td70cgRvQ3KpHarVkZVbC0m75qeYE6/75E4ojs1da3atPzrH0KhlUw7SGumwM
         Y6XPv8OU6G9vKNKcLlDKIfiWnRsry70jENveqNE0Ps/jlPP+rlU99X23IloT0R0G6acX
         OkEy+18tqjLXqi/a8h4iJtXWpZeOnXfXkhqI+eiugaF+Om3FSyq8rdQXUVGf7tTg0tXF
         hVZg==
X-Forwarded-Encrypted: i=1; AHgh+RqopNp0XzerikaraIwjNGTtENiHbxRsEd2zxq7bW+iOpkV2cAvQb6TckjhnCpkSjNiRTLuGNGs=@vger.kernel.org
X-Gm-Message-State: AFuF++mSE68s+DxKSkdHjs0AQX+ScV0L7qb2OOpFUuH7QpcoE4nWpgnq
	+a+DILQylaGp9FkOWVYfbtrIIqHu8K3oIyZeqdNrii38vYerzWTJOpvAIiqwtj90Z7bk6oQ4jcf
	z89S2Z7JoZvuV0BtK3PDOhsKKTkfSE0Q=
X-Gm-Gg: AR+sD11CVGPvCD4qdzfBu2t3f2BcwflLnot340UnQ691yLOjBc/EVf24zydWyt0kI2D
	XLOvLb8U2iXeFeM5Bx9zbKMaDXR6mIbo790ZjFIvdLs7IjwW9OosmtYeXW+sJO4swDEFjQ2zn5i
	xadAuwJRhGQv36seh2FxcbYbM3Tfw+UTFJU05tEkMqJg/S1Nrcc32ZOGvodITlyURXJbbrGkO2Z
	gRFCftkABJk2jNOmSSWEzurlgqbkrhYTHA00D9bUJvT3hDldgXMoVo8hXv+Ge5ZhpZBGK2NjkPJ
	6geLyQaZEXmsxFH/XhJYbwQJ09nAkoP9rY8SmluhGZUHypepPvXxBsSljwMWKJRIbZ9JfrOn6Xj
	x1gtKCq1kPyR+cQDYwDy5LVEoWssmybGWcsqXk8I2UrMH
X-Received: by 2002:a05:6a00:3e29:b0:84f:dfa8:57c5 with SMTP id
 d2e1a72fcca58-85374cb7bdcmr27288199b3a.13.1787844823992; Thu, 27 Aug 2026
 08:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826-sctp-zero-chunk-inqueue-v1-1-86769dcc7f8c@gmail.com>
In-Reply-To: <20260826-sctp-zero-chunk-inqueue-v1-1-86769dcc7f8c@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 27 Aug 2026 11:33:32 -0400
X-Gm-Features: AcwNN1XAMiVsoB5EBb0lVJPWDu-w2mSOB7apmLRA0eGGSOgdyyJIgB72PmiEmJI
Message-ID: <CADvbK_d7mOaNRgHEbVAUgT28sy6jHr5TTvE8+dsymOU-UJDoEw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate chunk length in the inqueue parser
To: theminershive@gmail.com
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Yasevich <vladislav.yasevich@hp.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 9:01=E2=80=AFPM Charles Vosburgh via B4 Relay
<devnull+theminershive.gmail.com@kernel.org> wrote:
>
> From: Charles Vosburgh <theminershive@gmail.com>
>
> SCTP chunks always include a four-byte generic header, but
> sctp_inq_pop() currently accepts shorter declared lengths. A zero-length
> chunk leaves chunk_end at the current header.
>
> When ASCONF is covered by the association's SCTP-AUTH policy,
> sctp_assoc_bh_rcv() can continue before the state machine performs its
> normal chunk-length check. sctp_inq_pop() then returns the same malformed
> chunk repeatedly and the receive softirq can lock up.
>
> A remote SCTP peer can trigger this after establishing an association on
> a kernel built with CONFIG_IP_SCTP and configured with
> net.sctp.addip_enable=3D1 and net.sctp.auth_enable=3D1. The reproducer di=
d
> not require application credentials, a shared SCTP AUTH key, or
> net.sctp.addip_noauth_enable=3D1.
>
> On commit f967455fb2a5 ("seg6: reset IP6CB after IPv6 decapsulation"),
> one zero-length ASCONF caused repeated
> watchdog soft-lockup reports in a two-vCPU KVM guest. All 3 pre-trigger
> health probes succeeded, while 36 of 37 post-trigger probes failed. With
> this change, all 37 post-trigger probes succeeded and no equivalent
> soft-lockup signature appeared.
>
> Reject chunks shorter than the generic SCTP header at the shared inqueue
> parser boundary. Mark the packet for discard before either caller can
> continue processing it, while preserving the four-byte generic minimum.
> Declared-length 1 through 4 controls and kernel-generated ASCONF traffic
> remained healthy. The patched sctp_hello selftest passed for IPv4 and
> IPv6.
>
> The complete private reproducer and validation evidence are available
> directly to maintainers on request.
Please share the PoC with maintainers.

>
> Fixes: bbd0d59809f9 ("[SCTP]: Implement the receive and verification of A=
UTH chunk")
> Cc: stable@vger.kernel.org
> Assisted-by: ChatGPT:GPT-5.6-Sol
> Assisted-by: Vantix:claude-opus-5
> Assisted-by: Codex:GPT-5
> Signed-off-by: Charles Vosburgh <theminershive@gmail.com>
> ---
>  net/sctp/inqueue.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> index 5f988b3a8814..12a46868165a 100644
> --- a/net/sctp/inqueue.c
> +++ b/net/sctp/inqueue.c
> @@ -212,6 +212,11 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *que=
ue)
>         chunk->chunk_end =3D ((__u8 *)ch) + SCTP_PAD4(ntohs(ch->length));
>         skb_pull(chunk->skb, sizeof(*ch));
>         chunk->subh.v =3D NULL; /* Subheader is no longer valid.  */
> +       if (unlikely(ntohs(ch->length) < sizeof(*ch))) {
> +               chunk->pdiscard =3D 1;
> +               chunk->chunk_end =3D chunk->skb->data;
> +               return chunk;
> +       }
An early return of the chunk will skip the pr_debug(), which may not be
what we want. Also, I don't think we have to update chunk->chunk_end.

>
>         if (chunk->chunk_end + sizeof(*ch) <=3D skb_tail_pointer(chunk->s=
kb)) {
>                 /* This is not a singleton */
>
Maybe you can merge if (unlikely(ntohs(ch->length) < sizeof(*ch))) into the
check here, like:

        if (unlikely(ntohs(ch->length) < sizeof(*ch))) {
                chunk->pdiscard =3D 1;
        } else if (chunk->chunk_end + sizeof(*ch) <=3D
skb_tail_pointer(chunk->skb)) {
        ...

Thanks.

> ---
> base-commit: f967455fb2a5a2079b9eb5823e9ccf359174bf9f
> change-id: 20260826-sctp-zero-chunk-inqueue-b478dca552c6
>
> Best regards,
> --
> Charles Vosburgh <theminershive@gmail.com>
>
>
