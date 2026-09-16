Received: from mail-oi2-f32.google.com (mail-oi2-f32.google.com [74.125.231.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99D418A22
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.224
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586829; cv=pass; b=TxXjpr/4eAkCdmPZWLhBwaAuR4IakJwAqGgXvX9XN7hwi/DjoZ1X/F5G5Aw3rNlhk33YZbDVV2FBGaT0608mZCm9pvELzLJE23rFONdatMz/pxSreqkQMuuZMsg07D9RzmdYfKO2uqr3gp+FPfxjTO7h8XnA9s6WXQP1or9yoe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586829; c=relaxed/simple;
	bh=OuBImfA2VtpjROUE4x9h29QyIc/c9CdbVEUrPXOnFn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKtF1odMm6FcwffxrOOYh327OUa+QNeufmDefO+zGQWVOiZQ5kiIAnloWFwnAdf8L8gfiarSwG26Y7/WvNxV9sWi8fGVEB/mLiNYOMEIZ3f2XOKElnUTYt6AWilW2maOANP1C9AUGgNaaZYQ8T9TkiZcIX0s7F5zdQx9UUMzw6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L43aTNMG; arc=pass smtp.client-ip=74.125.231.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L43aTNMG"
Received: by mail-oi2-f32.google.com with SMTP id 46e09a7af769-7f4f0dd5507so17460a34.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789586814; cv=none;
        d=google.com; s=arc-20260327;
        b=LnvEvg9roLxxbvKfFklo1HwW8Mskn9TwjukC5xjczqn+zARQdEwm+/Kcj3hrBmZAAM
         Ucrk6+s2CtPmgSvQKyECqdVmeM9C0P2aOGQe0glwgr7HKkcmlZJYUONX+nD5SBm2tpvq
         FB9VOB7ENyLt7RjptPKKOHjWsjkFtvv2zHz1wIbWgM2V2aIFeP+cOknOVwDBAyNegO0M
         Do98NabzJWLK3Ag3qfxgW2qZriwdyO42iXiYpu6s9QP66i7uefCuD25Sk3cIP2r0FmXp
         4poA4fGySCMv5O+sELkHYJo1xB9RnqgISCHsLVCTxYgdI91o/ZWHOqEfgdK/X2RGPQ45
         89UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GqRw9HltWqM2sAD6nJCLGSalO5mjXMLxRfeaddbbUlA=;
        fh=FRodeysEZFPZ8IlvHgcjhKpZM5ODE8IZm/11+Ahuv9o=;
        b=qzC9//FA97o6Q5rEuRSxM3aPVssO+KIOOFJEDhYWG0bz4n5r9097RJnQ95MQ38rwj3
         AtLoJUJUmfoSAGYkp3AGS7fmTmMyeMj5VzCYCpn5eNX2WrRJeR2Q0wQRHESY+fsAtw9m
         jIWt9lJiJqiIfWphkkBE7VeQxdHzFud3oiuFRwFf9kRqfhObt6eqiQVBRlP0Trp7KH2G
         AVANH9x8KR3Qkb2vDCkBV5v5i4iQmoMA8s6H8zYp1KiVZ9m7x8G2g/rOduoLdInQAhui
         sI3RkLsYA0lrimWeMCy3ZKAXWqZkWlhzJF4AYua0xi7EopdNbi+Jyt51b5vY/ahgDXyZ
         KMBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586814; x=1790191614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GqRw9HltWqM2sAD6nJCLGSalO5mjXMLxRfeaddbbUlA=;
        b=L43aTNMGj0WsEFPWzjUtSxP8gV5PBz69FGK97PqP81FFSg2XNjHgT4Nw1yMIeaJUlp
         8cwX9nNrP/BZjYCF9PsY1MgeXFH1LqBRG6UXcV+Ixms2eY1BnGiEPTzMh+LVUJv/PTc4
         K/Kc4PxU4GHEoZ1VLBDjYIE1csuBS/zRz/rLseR2Bbgk3bVYCZhNBJiXQ5EBDAt8uMAY
         NsSTO+0bTMs6lEoRrih1gLCuV3nUfYDuCPX41P1lSzZ7izuxrlwMRNbxqL/coKLf+mUF
         k7l0bWFv5zhCtiNyvBByq1hB/vsXaQwJs5AR2JZROLF/CR2CnU+YUTG3W0rgh3bEL7hj
         XKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586814; x=1790191614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqRw9HltWqM2sAD6nJCLGSalO5mjXMLxRfeaddbbUlA=;
        b=q4ekwgAubwlFW3sz/nVv7KK0+88lOLLOOzxNrfnN5+/RA4njhKAnN3FlbhC+guLr/O
         u7G5VfaIxZVExZegBSJNdzc7JzwJcCaLKugbwBubbFgVN0/+K+Uc015SFdwa+BMHtHj3
         veashLt7iYE/CJQZovQztXIeW/9o2IUdMKaQ48K8cQTZzcNauPVXe7VoZJ6lsML53QW/
         6FYvzDqLvbq4rQOYZ/iNgD3vPSrqrVv1yBLs7hvwG2XIyObhKtfXU8JaR6LKNv+abbmN
         vkZS1bg8jlvrzoSmQlfAN8q3n9NagIE3DZFYDOfEML1msSD72kkDryWy0BwbRc1hdzYP
         tlVw==
X-Forwarded-Encrypted: i=1; AKwUvByDsHRfnhbkDi5i+UJfxflr2X60pZ6NdpxQMMUAYFz4F0FMrRQRVBKRQQzx+/SpUxk1tUMsP04=@vger.kernel.org
X-Gm-Message-State: AFuF++kyiCZkkiDbQHbz5DnEgtzr6OXFpTaBvjjAsqcHmNKQUxUudeGz
	cAv8qxnKffA5118V//DBApK12SG+mYAE5nR85882VsluOGspdcQFLwNTsiPL0BfYVbXnXijRh9F
	qzRJSbQPUeVl5nlXwDVqErnZx2mndXjs=
X-Gm-Gg: AYBFou12vvS/mroGtUmks/Kzkv/YLMRdKGBE8WWRgtaMD30Wea9vAq8RchtDJrZQX+9
	YScpp0tMRiE983hWL4cldnuTvC+WZEogi3KfiOeRtY8v2+FhVj4lgpT08iyam2u58KKNrM7qsN2
	92TTaLSf9HNMsfElJ0XqJngYsSY7u6RSiK7hlk5eZk0kyJqOGUylSi+DAwUwsCklc62/l504tN/
	JHcMxd1IkvvOwN7TudjgRGnH6m9Y7Xp/NPZSs7SvXoQutSMLRnjTvGvEmbVeX3AA+vYp7PZFjql
	lo0gLrmAOvWsZNXMLsmwJTT1EGuCA50l1Z3hkEDRTyZCFURFnuaBY5s=
X-Received: by 2002:a05:6808:238b:b0:4b9:e5fa:8a19 with SMTP id
 5614622812f47-4ca4c17d6e7mr4445335b6e.30.1789586814265; Wed, 16 Sep 2026
 12:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916050830.8774-1-emil@etsalapatis.com> <20260916050830.8774-6-emil@etsalapatis.com>
 <CAMB2axOAut_9utesiV9mG40bskrDscu+Gu9FUMNRKZC+hbd8UQ@mail.gmail.com> <DLGYLT5UIFDA.38RG9UBZNYI58@etsalapatis.com>
In-Reply-To: <DLGYLT5UIFDA.38RG9UBZNYI58@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 16 Sep 2026 12:26:43 -0700
X-Gm-Features: AcwNN1V67fVu0jyiCVA6Tar7WC_uaAL4bPriMPLTUZNtE3MtDtEKZZbaOWcawGg
Message-ID: <CAMB2axNHEidSAzh5gG3UJHeqzK4VZ_Rsy+wvFt6N-q-qBsm+5A@mail.gmail.com>
Subject: Re: [PATCH bpf 05/11] bpf: Reject pkt arguments in mutating subprogs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org, 
	Nicholas Carlini <nicholas@carlini.com>, Mahe Tardy <mahe.tardy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:41=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> On Wed Sep 16, 2026 at 5:57 AM UTC, Amery Hung wrote:
> > On Tue, Sep 15, 2026 at 10:10=E2=80=AFPM Emil Tsalapatis <emil@etsalapa=
tis.com> wrote:
> >>
> >> The verifier tracks changes in how PTR_TO_PACKET registers'
> >> bounds are modified across subprog boundaries. PTR_TO_PACKET
> >> registers are actually passed as PTR_TO_MEM, which is assumed
> >> valid for the entire call. This is not the case with packet memory,
> >> where a pskb_* call may invalidate its memory region.
> >>
> >> Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
> >> may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKE=
T
> >> because we would also need to somehow pass the PTR_TO_PACKET_META
> >> or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representin=
g
> >> the pointer in the subprog as PTR_TO_MEM, only permit it if the
> >> subprog is guaranteed not to mutate the packet.
> >
> > CC Mahe.
> >
> > Hi Emil,
> >
> > There is a related but separate issue [1] addressed by 8fe994c80af2
> > (=E2=80=9Cbpf: Consolidate function call pkt_access validation=E2=80=9D=
). I think a
> > long-term solution could be supporting ARG_PTR_TO_PACKET for global
> > subprograms. For example:
> >
> > int parse_something(struct __sk_buff *skb, __u16 off,
> >                     char *data_start __arg_packet, ...);
> >
> > The verifier could require a real PTR_TO_PACKET at the call site and
> > verify the global subprogram with a real PTR_TO_PACKET, rather than
> > converting it to PTR_TO_MEM. This would preserve packet access rules,
> > allow reads from cgroup_skb programs while rejecting writes in the
> > callee, and automatically invalidate the argument after calls such as
> > bpf_skb_pull_data().
> >
>
> Hi Amery,
>
>     that makes sense to me, especially since this is a feature expected
> by existing programs. The main issue I see is that since we want to be ab=
le
> to pass it with subprogs we need to find a way to annotate its current si=
ze
> (maybe passing it as a __sz that is checked by the verifier to be <=3D th=
e
> range - off of the pointer in the caller?)

Yes. Supporting mem+size for global subprog similar to kfunc is
another direction, but ARG_PTR_TO_PACKET is simipler considering there
are other complication with packet (e.g., pkt ptr invalidation). With
ARG_PTR_TO_PACKET, the global subprog can be verified with a symbolic
packet pointer and establish its range through the usual data_end
checks.

>
> > [1] https://lore.kernel.org/bpf/aqkhifLvyAhw66jg@gmail.com/#t
> >
> >>
> >> Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
> >> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> >> Suggested-by: Nicholas Carlini <nicholas@carlini.com>
> >> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> >> ---
> >>  kernel/bpf/verifier.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 6c6b8d852..507bc14b4 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -10375,6 +10375,16 @@ static int btf_check_func_arg_match(struct bp=
f_verifier_env *env, int subprog,
> >>                         if (check_mem_reg(env, reg, argno, arg->mem_si=
ze, BPF_READ | BPF_WRITE, NULL,
> >>                                           NULL))
> >>                                 return -EINVAL;
> >> +                       /*
> >> +                        * PTR_TO_PACKET get passed as PTR_TO_MEM, pre=
venting
> >> +                        * us from adjusting bounds tracking info.
> >> +                        */
> >> +                       if ((reg_is_pkt_pointer_any(reg) || reg_is_dyn=
ptr_slice_pkt(reg)) &&
> >> +                           sub->changes_pkt_data) {
> >> +                               bpf_log(log, "%s is a packet pointer, =
but func#%d may change packet data\n",
> >> +                                               reg_arg_name(env, argn=
o), subprog);
> >> +                               return -EINVAL;
> >> +                       }
> >>                         if (!(arg->arg_type & PTR_MAYBE_NULL) &&
> >>                             (type_may_be_null(reg->type) || bpf_regist=
er_is_null(reg))) {
> >>                                 bpf_log(log, "%s is expected to be non=
-NULL\n",
> >> --
> >> 2.54.0
> >>
> >>
>
