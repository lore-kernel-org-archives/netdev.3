Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FF2C3251
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725343; cv=pass; b=hrclrCoWdQqODCIm7U2y1yd3oegJyO7HIQWdKeyWrZSUoO43HthUnN2GvF0w3DLAvNBbUARKX+Hz/NvokOGGMKwz+nEbNzKQx8NudqS5gW3dqNt/ApcAwlFy37X/iTKwl3ObRf504WAhmoj05ffSw4FbmfHDFH16/r6Rz13MsxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725343; c=relaxed/simple;
	bh=OZnNnqgFsHkCRqKfrQSFXiPDZYX9e7tBQg6s8Ob3PWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQzGkvEFYfgSc17CR3qfPWByHM/yX1qlfFUjGBK2o1iIR92wOIx7dxISzpqciqkCwnnNj/wJD1aBB4PqoH5i8KlgdR2bKSS41pIdKlhbA12Byd1satUsnV/m7joH6MHNLYcoRtGc3HEw7aIz03mKqHjj7aa5/Ddz/p70mi2F/7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=wYuNoTUw; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="wYuNoTUw"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84874b52eabso12050711b3a.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784725341; cv=none;
        d=google.com; s=arc-20260327;
        b=YXvDqjlkIPprQ2PyqtKIWAq+2XJU1s8motCbLPvncQNLaFhkIpxSs0+At/pVJPvdBT
         s4R5r4r3RUKKWDs7FPea6cokcQ6Jzo3zUj7pGHzMwqfJyoUSGJeorAjnyzJB8E1eWFLb
         prWfBlO0DkzVxw7ylwCjFoAItQaqGpYc6/45Wo5Q6kW81cro7q41ELHxQgdRbcPGVIuO
         AIE9f88doGnapmpkfTpB2aTSF8VV2zwnBJqiClIoN0aNSUJlcqK1VwRWaQ574TH9AWW4
         bqAWtYi6ukLhJEb7z4JfEBcPCuXDkJs6OEx5pZY/4mXeNpo3Ui6OFr08kLukT2gaSGJ0
         2I1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x1WK+OR6h3Wjb+QfkdL+cr1HegHl7fq2gHDqi9EV3po=;
        fh=ywueJp2z/xmnQCDpyYG0TeYRVEnOEmEmMxl+4fVgMe4=;
        b=ANFGyqmOeFmj5DU4nwuXsijuq7KpuG6aObEgOf/+sx49F4s7+U9GlMEw7EpUVKPg/C
         szIsmo0DHKL6CB8XfeSFwT+qNcFLC5L3lD6HiY/74ZYgDbe5WqMSqFbsdlxkspx1GB4b
         R/IB8u+2os2ETQUmVNFehwyMeQheG5XpV1bhEIjKsPRwL3PZCMEX9ZPp0bPPqa3rSrx0
         kkoW6WH+yhVIVRQdoug7N4dlpqIS3NRI3QJ9swZtmar2ltp+vD94P1+lknYdm2Xb1BvG
         acqO9tFGeIdHZfS80aBcle0dSH3Wi6N90fwN+hordYyLPGeOsbfX2eZIOf7eWSb6mbEl
         xtMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1784725341; x=1785330141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1WK+OR6h3Wjb+QfkdL+cr1HegHl7fq2gHDqi9EV3po=;
        b=wYuNoTUwUUOhjMUWEfhP+Kj1FdbLGoJqyg2s62UmmbwAWKwhYAVmqHDaQdCBwTR2M2
         i7Tq9chNJ7AOKtzTef0H2JxsMWm4ZCfMOybjTzrNpjgSThBzqKH9kihEavhhLTIjtmyY
         /jb1NcyCCTBFPpl9i94Vog9dnkIa6Pp8C9KGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784725341; x=1785330141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1WK+OR6h3Wjb+QfkdL+cr1HegHl7fq2gHDqi9EV3po=;
        b=PwCddlOq6VV94DdVCnvK0DkuZ990/VLke4FdLWkrCbmWt2DbzEYPsM65kEMF9fYMqT
         eIy+oMQySPadUQckd4InzdNFvmtowfFAp6SXEKYEdZSH7wtYpGU5hO/K27mDJ3vV4oWB
         YBQAFH3YShm1WkzAnpRNMkKyZRuEJibIpeMEklXlWATqX9iFIVeoHxTxpG7Lyqan7BqF
         ROnfYw7437T2PTzltoPteqIYxsCQnT/1fJak7rrxXe2fqvtBqIc663IXSo9NWPwmK32Y
         Kk3txeOy5IQGwT+1lRS17tKNv705fo3s2LZBQ1nHeI9F6EiAbx/DwQMI49hwLZYje3QS
         wSwg==
X-Forwarded-Encrypted: i=1; AHgh+Rorjwx/uBrlRVYdnfjp7AgI+BTYyrXdmZvU3lpyDCHGoSaO9SuqTqCc2cwQKUjWpHJ1l3rjICI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8J3RowQknZgtAMPJX17k+iqfh+NdqPy+PU+5l7jfZplwmTC01
	XbgMpebFZRbHjXG5fsqzlxw3Ko3w6FPStqHfofguFpqGujBR/Y8gxuGZarES6C2s30BRK4JNzKB
	OVLIW92/WSNjHcHExiQ8198h02FX2qvKMnu7Bccnf
X-Gm-Gg: AR+sD128Q+fqO58a3fkNYhj+GkRVtvAW5pbkaZysMmj/8yEEgihRxQPkLhJE7H9gwT9
	WLHdpmNsWqm801SwC+Qn5q/t8fbMCU74mRearuo94YrleqrT6qTNNjlHpeuHz+/JlQ/SfjUWpmk
	b5OWFpczUiOPbkbROvcvOQvucECSFfmjBYySL0BqVtifY+Re+HYN0e6xjulJDIJA4cbi33fU7Gt
	FIZ6ySuPYVGYHToONeedcZNASRqn2GXwP5ezB+Qc7eL/RxOJzr+dAygHrBXAiw=
X-Received: by 2002:a05:6a00:3e13:b0:845:4d71:8d15 with SMTP id
 d2e1a72fcca58-84c294d4123mr23854118b3a.37.1784725341085; Wed, 22 Jul 2026
 06:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034514.23053-1-blbllhy@gmail.com>
In-Reply-To: <20260720034514.23053-1-blbllhy@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 22 Jul 2026 09:02:09 -0400
X-Gm-Features: AUfX_my0C0KHqyMOZgzByQsBTKPe8yiG-Ut5JoGHQ0amBUxtv5oVWrD_6PYXlto
Message-ID: <CAM0EoMkDb2tV7gQ3=CixSd4iZz29jNyGdbSSq9-QgZKny6UB=g@mail.gmail.com>
Subject: Re: [PATCH] net/sched: cls_u32: validate offshift to prevent shift-out-of-bounds
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 11:45=E2=80=AFPM Cen Zhang (Microsoft)
<blbllhy@gmail.com> wrote:
>
> u32_change() copies the user-provided tc_u32_sel.offshift (unsigned char,
> 0-255) into the kernel knode object without bounds validation. When a
> packet later hits u32_classify() with TC_U32_VAROFFSET set, it evaluates
> `ntohs(offmask & *data) >> offshift` where the left operand is a 16-bit
> value promoted to a 32-bit int. Any offshift >=3D 32 is undefined behavio=
r
> per C11 =C2=A76.5.7, triggerable by an unprivileged user via user/network
> namespaces.
>
> UBSAN: shift-out-of-bounds in net/sched/cls_u32.c:236:43
> shift exponent 32 is too large for 32-bit type int
>
> Fix this by rejecting offshift >=3D 16 during filter creation in
> u32_change().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
>  net/sched/cls_u32.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 8f30cc82181d..e7a9a49353f9 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -1107,6 +1107,13 @@ static int u32_change(struct net *net, struct sk_b=
uff *in_skb,
>                 goto erridr;
>         }
>
> +       if (s->flags & TC_U32_VAROFFSET && s->offshift >=3D 16) {

Remove this VAROFFSET flag test.
It is possible that someone could make a call from user space without
this flag and use skip_sw and it ends up in a driver which doesnt
check for this boundary.

Otherwise both Victor and myself tested with POC and were able to
verify the bug and the fix.
Please add Victor's tested by and my acked-by when you resubmit.

cheers,
jamal
> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "offshift must be less than 16");
> +               err =3D -EINVAL;
> +               goto erridr;
> +       }
> +
>         n =3D kzalloc_flex(*n, sel.keys, s->nkeys);
>         if (n =3D=3D NULL) {
>                 err =3D -ENOBUFS;
> --
> 2.53.0
>
