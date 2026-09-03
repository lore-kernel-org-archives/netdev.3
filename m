Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B03F30F7E8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399515; cv=pass; b=QS2eyc9pbdXVHMKJKOPy2CPyxfiegXmPpg9/mEqMcux0youF4PwK94MNY4RBcbVgNl/Ha14bPVG4mtfZrMwIyEFLVD3zI80uK+kJf/S/FxicuFzYc1159ncqIiy2JEf9kWz1nI96gDSjYCIe/SKK45+hfkH01VyzDMqgdLHaXhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399515; c=relaxed/simple;
	bh=Az8ML3xziSsQ3jStY9KH6BKlBem4EKxqSIFS0wdqnVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtABc8Wfz0R9Nu9kh2ZfW1Stlewt7fFWU0cCxfLZ4rgdTnZ/PcwYpV4mjf0aWbvV0w+KfKjudbQ+RShT6kZsHtHU3uhc0dK3XKUPqDcI0vlKrKXnWqOe1+GkyZ3bLHBRaI2lzG4SxlMsqz7DZznZrE++zZ3qYDHZQ1cqLEQoy78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vepd8dJf; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vepd8dJf"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2198744a91.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 18:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788399514; cv=none;
        d=google.com; s=arc-20260327;
        b=EJCBKNRxFm2y8okwfuRK+uELNyhdrYeauzL1WFhXZje54LC4ZgIS1EVT+fWeFy6Vde
         kyEPeMnh5aBMN2MPOK08HA4l/nXsALavFCtqf/8xGO97n7hOhRP3k6WAiU/L4q6qhVN4
         QohQP6u4qb12sToJvnw2QRl4K2+0uJGwhyD+q4ok5ZNT2KtwIp3TbS+n8cKT4NKR6dHo
         wv5foAHwbYgMd3xGLPY1s8QCFE/ZrIVmhSIr4xhkaSt8CWKmvDhac4aSVlxEIC6T/ft0
         5twYiVvx+JBUw/vU0HMZUbi1iXiAK2yjx0ma44WPVHW9yrb1SbZwwuKoqq2ur2z0PovE
         lz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V64QR1IsR8MyGUl9CMimjz0m+06sJhfAIW6p6kz46nA=;
        fh=A5hWF2rbEoGUC1ObS8CX3E8YoVui/7uKD2VhEcrn1BA=;
        b=TsroB7yUO9jomm1F303hf3a0FK62e98ebCaIObkm+Ntge3AIF2U4lChMlIteV2Y0nO
         LkJPjMxQIWGzl53MQB8kJmrogt9HUApNx28GkqGngmBfXApMmQB1Vj1RJJBJAvcuXs6S
         h3AEE64HjF+x9obMieEnlaXtDEzg04f87EfUfmm+JDQaFmgc7CsJfV8FkrVuw1HYLlRj
         +RQoS7dwlx9Bsy1tYxD6gx8Tl0jWWOxp9+33naecwwhsheBSDP259e96iVCfbw6SvO+z
         KxUIJ9Pe2jDj4QQNP2HQw74rQ+uFh7xsp0ejAVz2g94T+ly4HsuRKJSEE6n/cVaXSo3x
         CspQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788399514; x=1789004314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V64QR1IsR8MyGUl9CMimjz0m+06sJhfAIW6p6kz46nA=;
        b=vepd8dJfi8NublaG5BZcBd6Vpdf2bPTIjyvOyDK5VuvsGHWkBIsYLirOjxDM089q/Q
         1Nvfauhjz17EcCe2nWmoHFN01MEPrNawi/2344BTLkH/cet8qW72iBY14EqnId8RD0XN
         7j9gyadvjtllmbxGdXe2an1TGWdKaLWv1p+Zw58bkOLBo6aDY8GjjzcDI47CopuqhflC
         NciUutCu3WEojcWL/0RAr+OVIQqpg/WRF0oAaDPChSK8kbTdw/bWKdNZcDqymDPfqAUc
         yp7i10H6llFarem8gCqoqrNvaT4V2gDSQUinwyouRvY92uiwTZUO+1Aqe75zDub5G238
         IUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788399514; x=1789004314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V64QR1IsR8MyGUl9CMimjz0m+06sJhfAIW6p6kz46nA=;
        b=cgGr4vFA4U9cl7oNUvoAIk2FUTvO7QZiqLl5rwZwt75AYNsy5pXGVlnVLT0eKxXl63
         s3zBkwdB6cCAINEmUXeC/qYDeN/qB+zgFtEBiMxHjRRVfeRW3zj09jjv4OXnGR5shyEU
         uqwoVX9+lElueINzR18Mk3K72/v54DL79tSbUf7EGcX7LWdj/9qJhERhFLSBLf+/rX0u
         vU03GipjoipLfDKvEFbSkuCkFBBknQkeuRju3kYBI7ZfCSCjJRTgvh6RoCCupstMCF2U
         BTYmzodvep75hHKLgLUOxRlZjSnNwUy5NZ2ftqnjwSKy1llegem/UrQ/lxGAgNueCsPr
         Q3fg==
X-Forwarded-Encrypted: i=1; AKwUvBxoFlyWC8avS7zGFmtApCi6lIMrFe0bLbLTUd6PR8VZ51ffpXMwNltXpdVZTO+J6vXlLw2lw7A=@vger.kernel.org
X-Gm-Message-State: AFuF++nyAGabiL+wi5WnAmGo9WzQh22gBZNkYbjYGDRaP/Vk+eS3CRT3
	XdPCNYFKfEwNyV9djsMXAO3WiskRyIfJVP22GL0cYLc9o5bpFklI4olsButNIX5DBW/+ehhkGVd
	ZumqrxQy39lbvpEKHGCdtjVJxe/FUY7vL/3u0VdpL
X-Gm-Gg: AYBFou1Y8+MFWAq1Wt/aAmeObWiUphbxeYzRKASsuzVC+ReKvkXIVNHG3lAZDlHeiI+
	5kyy5LJj3jfWf0j0a9uacsDkAnYCMJMRBupr3R9E7FA6vvgstcCbcVyjwDkNig6Xd3C1V42suzf
	Zay8vUZJwtlQWXoHtTDaDL94pJqGGUd+68PmJKAMXtyQMiiC+JUm00SsQ2Z8PjicoG/ZKmE/Md7
	+puXqSnCpcpSk0BFVFOo/+NmxNKzhJ6IU71V4ka1OIJSwye+KUR3S9BmUIgxjfkm/8jLmjmSSFp
	q3XNht/bXW4klrDV91etNwOV0UfI7Fc65+YDCZgC9wH5my3k2Ddl3Z4VnmlqiToB+nyT9sGNQX7
	fqCZlaHcforr8f2HSXx8uXSLgtvk29xPNvZ4mKMMFstieFBBtztqUXpuNCDGkfIRZheB5mPfY8K
	LP7pJ2R39g/9sc
X-Received: by 2002:a17:90b:3fc7:b0:398:9be8:ea69 with SMTP id
 98e67ed59e1d1-39aee251837mr14335412a91.22.1788399511412; Wed, 02 Sep 2026
 18:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAE3jtcL0b8YsNiJpcXkUVoZRxFetU9o8z=JVNUCnDXN=seUmg@mail.gmail.com>
In-Reply-To: <CAAE3jtcL0b8YsNiJpcXkUVoZRxFetU9o8z=JVNUCnDXN=seUmg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Sep 2026 18:38:18 -0700
X-Gm-Features: AcwNN1V2Dk1ZXSLu1Azh2xjqw6dIZJAN5we8KwxOa0fvJ97gB8WYOupXivWTtro
Message-ID: <CAAVpQUC6RHs+ODtKtgSDy=oxV12azk5QkjO50yUDJpOAHiv3qA@mail.gmail.com>
Subject: Re: [RFC] splice: add wait-all semantics for socket-to-pipe reads
To: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, edumazet@google.com, ncardwell@google.com, 
	alx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:53=E2=80=AFPM =E5=A4=A9=E7=8B=BC <rockeet@gmail.co=
m> wrote:
>
> Hi,
>
> I would like to ask whether splice(2) could gain wait-all semantics for
> blocking socket-to-pipe transfers, analogous to recv(MSG_WAITALL).
>
> The concrete use case is a high-performance S3 FUSE client.  Once an HTTP
> response header has been parsed, the response body length and the exact r=
ange
> requested by FUSE are known.  The body is moved from a TCP socket into a =
pipe
> used for an fd-backed FUSE reply.  No userspace data buffer is needed.
>
> Today userspace has to loop around splice() until the requested length ha=
s
> been transferred.  On a fast local network this commonly turns one logica=
l
> read into several splice syscalls and scheduling transitions.  In one rec=
ent
> profile, 3,475 S3 GET requests caused 25,463 splice syscalls (7.33 per GE=
T).
> The profile contained no poll or setsockopt calls in the hot path, and 80=
.86%
> of the sampled CPU time was in the kernel.
>
> The obvious workarounds all have undesirable properties:
>
>   - looping over splice() in userspace adds syscalls and wakeups for shor=
t
>     positive returns;
>   - poll plus SO_RCVLOWAT waits for data to accumulate in the socket rece=
ive
>     buffer, adds another syscall, and couples latency to an advisory read=
iness
>     threshold;
>   - recv(MSG_WAITALL) requires a userspace buffer and loses the socket-to=
-pipe
>     splice path;
>   - increasing SO_RCVBUF does not make splice wait for the requested leng=
th.
>
> The current TCP implementation is already close to providing the desired
> behavior.  tcp_splice_read() obtains its time budget with sock_rcvtimeo()=
 and
> loops while data remains immediately available.  However, after making an=
y
> positive progress, a later iteration that finds no data returns immediate=
ly
> because of:
>
>         else if (!ret) {
>                 if (spliced)
>                         break;
>                 ...
>                 ret =3D sk_wait_data(sk, &timeo, NULL);
>         }
>
> Would a new flag such as SPLICE_F_WAITALL be acceptable?

The use case makes sense, but I think it depends on the numbers.

Another aspect would be whether we want to add a new (potentially
buggy) feature for a single user in this AI era.

It would be great if the change is proven to improve performance
of the official client that has a lot more users worldwide.
https://github.com/awslabs/mountpoint-s3/


>  For a blocking
> socket-to-pipe splice it would mean:
>
>   - keep transferring until len bytes have entered the pipe;
>   - after a short positive transfer followed by temporary lack of input,
>     wait in the kernel with sk_wait_data() instead of returning;
>   - use the socket's existing SO_RCVTIMEO as the total receive wait budge=
t;
>   - still return early for EOF, shutdown, a pending socket error, or a si=
gnal;
>   - on timeout/error/signal after partial progress, return the partial by=
te
>     count, matching the usual stream-receive convention; otherwise return=
 the
>     corresponding error;
>   - retain the existing behavior when SPLICE_F_WAITALL is absent.
>
> SPLICE_F_NONBLOCK/O_NONBLOCK would remain orthogonal: WAITALL would not c=
ause
> sleeping on a nonblocking descriptor.  The destination pipe must either h=
ave
> enough capacity for len or be drained concurrently, as with blocking spli=
ce
> today.  For the motivating workload the pipe is sized for the FUSE reques=
t.
>
> The important property is that data can be spliced into the pipe immediat=
ely
> as TCP data arrives.  Unlike poll plus SO_RCVLOWAT, this does not require=
 the
> whole range to accumulate in the socket buffer before transfer begins, wh=
ile
> still keeping the wait-and-retry loop inside one syscall.
>
> This appears implementable as a small conditional change in the TCP splic=
e
> read loop plus UAPI documentation and selftests.  I am sending this RFC f=
irst
> to confirm whether a splice flag is the right interface and whether the
> SO_RCVTIMEO-based partial-return semantics are acceptable before preparin=
g a
> patch.
>
> The userspace implementation and CI profile that motivated this request a=
re
> available here:
>
>   https://github.com/topling/ngs3fs/commit/4b8f5a69ceebd9211021a5d1149637=
3d63f2e43d
>   https://github.com/topling/ngs3fs/actions/runs/33586457571
>
> Thanks,
> leipeng
