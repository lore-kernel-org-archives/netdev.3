Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020FC3C4B81
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905916; cv=pass; b=m36B7yOBoXnb6O6p2zfJgsgNZkfczzpJhCTZRajQ35nsuW5xHwxcjqsiPZ9gtJBiOS+oleGUDwb2Dh0PlYz0CsMq9PdE3RdaIZyz3qRGN1CNnmui+vNxdHcpXZTQwbiPuXZ9YGduIaLqNnST39+7fnF+K8RUWB78NXGisRF4kpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905916; c=relaxed/simple;
	bh=Pds+LOkGVAgSxpMXhUeFRjdCbiuBhmIYUWCDN1J8IqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKwP7o7FnxLwZ0zpxnh9rqLYMFRcAp214xIIg6RzaQGWtPcfJvASWkH3x22kQlawMZQIvRXdku8Am2xpq4DmPpnDjsTNrFvnz4XlzmozwUS8Unx7LMujQgGcAO3zWlMjK35WIykcfPQZCy13eabszUepgk5nx1vVPZ2S6KdWwzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gMdZUn39; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gMdZUn39"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a34908so2001702b3a.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 05:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789905913; cv=none;
        d=google.com; s=arc-20260327;
        b=i8ROL89AmL2ad4BVZt43LzQ/cw2qXcsTKJNT6O6Uk0xspQIjlYfptz/8lcW6fC4MTX
         63rPyrAZHq7G1rc2fcprkIdVkH+11FEUkwO3HGlvJA8Gv+O+M2Lh3GjEUA1BJlb1YMZX
         vj3lPzxBxmmVghpWSPfPC1Xr+lujVQHHbxdmF8I3JMZtuddYcl+8+ATYrSaFreLBcGxk
         XiEIqHEDYkv7B0UdgXBu0Liyfj81yX9WfBS5oZ7Uo/7ZAkz2HexvuPkgPyFi05iDjv3N
         5SOPAuL/91fcpGSCRW3SEt+GOGjj9i5RbII2UHUrMUWqeUQL768KjGPqY7Gkg13dGn7P
         YQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nHm5mMazXjZC7GmzRs1/UHPmMvWJrDDsLFEQJ6iHd/o=;
        fh=/4/lXUJspZem0s+CC2eqqE9hXuS3+EbaC7WEU9coT+A=;
        b=CusvbnZpHcVfxFo8oht+U9cjr6e4VFWracmj9wD44vjUp4xL7nHTA/qgtjlIiqg06s
         v4ZdwUF5pD4kIRzRdqzoVVthzEBJ3oVJdupZfJwHd5mbDzpafWwNOvlE72ofw/L/gRkz
         xEyb53UzrkGlgGiDkZQMhR5jykLUEgVM+0tNZdAVwMDQWlLFQ1M90yCnJRlxf0Q0LfYm
         aHHfWrKXpndZr8YGnDjYk2ZLw09Fqz0pMFXqpksDgNTfDG+hfq/mwYbv1X/aiNgUbQha
         wz7vhwJrY40tmpUyVCB/2vcHOVP4MMl/5iV8jagnV0dYCPh6jWo0l3FwZDC5BYlj3+Z0
         hZOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789905913; x=1790510713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nHm5mMazXjZC7GmzRs1/UHPmMvWJrDDsLFEQJ6iHd/o=;
        b=gMdZUn39ik4a0ObJpLWq4Ld550bwgv5KSiTRnuUJ2PK1IWBjGSbS8OFGG4hl+f8zzO
         l9f6PQ9G7N6LVEeVgii5eR1mSVxjDqQo1QACEZ04iBis+yomoUubOjx4tX3d3bTF/1uX
         KrQlhIfZ8vwpuD5i/tqyjuabxl+uwCq1Zgu7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789905913; x=1790510713;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nHm5mMazXjZC7GmzRs1/UHPmMvWJrDDsLFEQJ6iHd/o=;
        b=nkEj+HqhUhak8O3C2nYEyvZj0DdPzCw8jmxhICn8/GwfNaJ7GGWpI0pYs9EGFglvJn
         NzeOC1NYCQPWaB55bwjnDdBrnp+7/UBW96PYjCw4LqBdCQhKH7MM1A8/Cquu2rZvDZo4
         3XTuGY+FuA7QNVEqLEEtg4NhjQFK33DEWfK/45ll/5L6m9XWPMls5TbDSeR6D9w1TtxZ
         63mnHYAEegc6IuBKYTs3bmDh2nfc8SFgUxLtQE3RDXEWZck6LbJKaYl4+t6evODiTemo
         /pZ1D1ufXE3bxvhRHweMEDLtnCHcxF9OT7xCkKEjOiNO23BrSRKwhXRUJwBaA/pLeSTy
         qnMA==
X-Gm-Message-State: AFuF++n7gObvWgrsROx+otNucJBWoJdFtyk77QKkVN0/yrBd72RFddJ7
	PFwT2e45Vcyth9s0Dc73KC41X1tT5SUSFFKOCG1FKUkens/vl0khClxrgaFdGSS5rEC92uuWNbo
	61Cme44hCOrBMDDalO9yI6DtWTl+DCXHrRwyFIhfc
X-Gm-Gg: AYBFou3Q2ywqk3Dq/06H5r5H5He/TJIxD5r0LMEqLaK96N/vKdau1uik21Ex27JR90I
	DxJNGR2MLjXjUMydXJ6B9BK3BDyfaJGvi0Kln0vHKILJgS9oXm53RMDrTWxOOHvZ/GHu3YPZt4o
	eB3rKvzrVO+Q4FwKns7WvI8rzMM8w582wUn3yXZf1xz9HKvmgWI3d6wSZS1wY11EAHKX0dzw6uj
	9X8qCH+POW9/be/7zjJ/o6FYiIBA8Rjp5dnBqTvMgzhQvWn7JsXpaFN4a56OG1esfIzjyEj7Qld
	t+r0XK3cRN//woAoBGzusLnduLyXk5onBgVBi+0Mtt+yfyDWcUPnBhD1itHqd+1TaGo2MBP7EsB
	uxypqA1QP19kO6D+tvq5EQwCjUrFgv4qGUqrYyQ==
X-Received: by 2002:a05:6a00:94ed:b0:871:eea6:95f4 with SMTP id
 d2e1a72fcca58-874dd9f1531mr12709221b3a.19.1789905912782; Sun, 20 Sep 2026
 05:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918133953.12494-1-bernard.ladenthin@gmail.com>
In-Reply-To: <20260918133953.12494-1-bernard.ladenthin@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 20 Sep 2026 08:05:01 -0400
X-Gm-Features: AcwNN1VWHjL5gXLaf4uBnqjc-2_JaoP2on92zf6me_43_PIz9GVDuLCSnLdPu08
Message-ID: <CAM0EoMkcYCAD9s3YCeOcDjTaacfqDXKWST+f+oP9_D2jAkW7FQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: fix potential stack infoleak in em_text_dump()
To: Bernard Ladenthin <bernard.ladenthin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, alexander.potapenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:40=E2=80=AFAM Bernard Ladenthin
<bernard.ladenthin@gmail.com> wrote:
>
> em_text_dump() allocates struct tcf_em_text on the stack without zeroing
> it.  strscpy() writes the algorithm name and a NUL terminator into
> conf.algo[], leaving the remaining bytes uninitialised.  nla_put_nohdr()
> then copies the full struct to the netlink response.
>
> KMSAN on Linux 7.2-rc6 reports two kernel-infoleak splats from this path,
> one triggered via "tc filter show" and one via a raw RTM_GETTFILTER dump:
>
>   BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x1c9/0x2620
>     nla_put_nohdr+0x83/0x130
>     em_text_dump+0x291/0x550
>   Local variable conf created at: em_text_dump+0x5d/0x550
>   Bytes 168-179 of 199 are uninitialized
>
> I am not certain whether this constitutes a real security problem in
> practice: the test was conducted in a controlled KMSAN environment and
> the leaked stack bytes may or may not carry sensitive data on actual
> production kernels.  I am reporting it because KMSAN flagged it as a
> kernel-infoleak and the fix is straightforward.  I can provide a
> userspace reproducer on request.
>
> The original code used strncpy() which zero-pads to the destination size.
> Commit b04202d6065c ("net/sched: replace strncpy with strscpy") replaced
> it with strscpy(), which does not pad, creating this condition.
> Zero-initialising the struct closes it.
>
> Fixes: b04202d6065c ("net/sched: replace strncpy with strscpy")
> Link: https://lore.kernel.org/netdev/20250327143733.187438-1-richard12031=
0@gmail.com/
> Assisted-by: Claude:claude-sonnet-4-6 [KMSAN]
> Signed-off-by: Bernard Ladenthin <bernard.ladenthin@gmail.com>

Thanks for providing the PoC offline.

Tested-by: Hybris <hybris@mojatatu.ai>
I reviewed, but I think ACK also means "I reviewed". So:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/em_text.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index 343f1aebeec2..4132f8c3c5fc 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -113,7 +113,7 @@ static void em_text_destroy(struct tcf_ematch *m)
>  static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
>  {
>         struct text_match *tm =3D EM_TEXT_PRIV(m);
> -       struct tcf_em_text conf;
> +       struct tcf_em_text conf =3D {};
>
>         strscpy(conf.algo, tm->config->ops->name);
>         conf.from_offset =3D tm->from_offset;
> --
> 2.49.0.windows.1
>
