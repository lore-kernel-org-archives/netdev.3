Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B939B94A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108268; cv=pass; b=PrUIpQAU8OOlsK1CjEk3uiDkO3+9nxbyhppbZw8b9VMFPW/hVjwnP50Rrot1IOvSe9oZU+41im/iQ6bA0F8VDzzcYnI6ZbJWihx4zbawF367zBEwwarmmauG24GAu462tFWUK4y/5J37qIB36rC8pzRWbyWRZrGs7Uefw/1H7Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108268; c=relaxed/simple;
	bh=9V3KVTiyZVv6wI40G1w3QCcbEG+arVAbC65vd6l13bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEBIVzpt85lFi4j0kDxl7L8BtKuxl4go0cRkMnUBKplVteeHqYclEEKbIS8FZlxu6aTc1z3qffB0+9lfKMLlYskJ/5tOFDV1fVTtSiJpjuwpIiutIvEIG96HehRfBkI7v5npYJhbZDhXsghE7B5pok3vKWE9o1o4a0rorwHxvb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq3oTguv; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq3oTguv"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-482620dc91bso232588fac.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790108234; cv=none;
        d=google.com; s=arc-20260327;
        b=hN1P2pJBZkN15qNKlZ7WASMT1hSskA46sC42oLf9fEBeMe/ruUAEAx/PLAN3kzyLK2
         3TyoKnJxMl4fVWQpLSheCzWNVXYwC9ICuwmkz2OkZai5G55bHb6lrl90ihx0efK+cvXp
         wYj9NDR/zkSfjlylITqMFimgS5TaNn+8z9XdsQEmTuMXQwTrcli5KOoJujbHjov8/OyA
         q9RsWzJRrYx0w6LydkcY5XmN3DtRFEoN3Px/d1zoJTr4QsjLcdXNpBsJvl7zmgn5k/gA
         AIXOfT5P4xpL+1pQXwEZdgd8X2B0MT9NvCGuIQd2gs7cGKiw3w+uqAoCtn3Jdbcd9Lkm
         4DCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcJg5n7sOOPwVaLZ6LVxB6ocMORc9n4O7Z2iUI9KKlU=;
        fh=scX7Aoktii/AErA5jKPzF7LWRpkifX2biiU7OYG7bME=;
        b=XBt/bZA8mYy4veJaWA6brfOMeh2YVbzrQ12SktXYXJ708VAcLi14GsSpJGyOXmxuyt
         tNcMpGFneecCqHDsRdYc1azh7bGfen0t8cj9eaMH8Zn2mNjBjAQITiYVatqgazjUBtXc
         Y3LP/EqObw3L0UNXgGlfyvCUh1yOvym9kdbBkxEVuQQAaESlUzPcPZoTqc7uRakEIAtf
         M3OvpIgATiXvSGrnJd+L3ECWsKU0w+Tk5UJqbKiL3l1nrE5n+s4sVo/rbPtQ75GgUbcC
         51d9oSxSRz0QeLMNTV+4SWOyq9gKu1K5lc72IgglU2EFx3zA3ToakZy9P27CD7veNPMP
         jKZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108234; x=1790713034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QcJg5n7sOOPwVaLZ6LVxB6ocMORc9n4O7Z2iUI9KKlU=;
        b=Hq3oTguvc69DIA1IK9Dt/hXfKDIP2jJraAlmln35Hw6OEZ8niOUvVy/1g8pyYhAv/K
         zeE1FB+oepqaHnQMUa192kcXjMoyY2YxRBDhjS9T0i4Gu5C8FGEOEbdIjHfhf48Ft6EP
         1ee3XYzgbt2yaaQybkGgr1Kyp1hzPjAYBvghgP2BjN6vmqoPL4qeQZUy9YEhZyM9M6Xj
         0FXf+31QSTMqXJyyTa4VN9znpLW79JTj8OCFMJkppPHe8P7OlbRPdfoal6se6pa4ja6x
         htEB1ROUMFa9Hxa35Gap17GuOr6LEwNP0JHB7T3o7+axuRN1kcCZxdiZ64dTrpCzzQcA
         AOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108234; x=1790713034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QcJg5n7sOOPwVaLZ6LVxB6ocMORc9n4O7Z2iUI9KKlU=;
        b=rY2fllwM6Q7eTTGkFAiJ7z1JujLsc3kPhit4C6mSd8PjfQDlSUsZgmCvRYp/B5OhUI
         mFwudDNuWfQK+NdR/bqdWpxTAvny2Fgvi/ROpsSf3GuPZOsyPY3Xhxac4ZMEpSU70Or6
         G1mmUL08MgMS90ExMkCXA8eIz/+n4WoKMfntngszZ8sDDv/35jxK/1vwvNGzWgP2BcSC
         v/WygLBjpab9uzm2Q44+HjsAL5w74hmHB2JSnQa4z8onb8uO2zHf9ZcIFBxE0dfqzZnd
         Frtsj7ljq7M4b7y4zNhUanfRLt1kyiWbht0pwUqK10f3P4Z6xdsEtzxKNtrW2sugW69z
         5ZSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpDFZCy0v+vDX3Dh0MAeYuJUNr+Ajrjtsnb9EGn03htJKezvK0xC5qan+GRJO74WmBo+gCd7A=@vger.kernel.org
X-Gm-Message-State: AFuF++n4yrLi9BGp7Fj+QKFYVwzLe8At3LLYj4s9p2xYoLT+/SPqdPkW
	zlw/R+lDtvBRh2+u/F2lb8Cjzwmd9XLOTt8LKA2HX9lS5I7K0P7oWGRpEUmq98aW2LE+nxrw/ge
	EgbdvaDveYPI9d58BNWVX0boOeY2hJlg=
X-Gm-Gg: AYBFou3+I1USufYKuwh02LtJFUkZ+X2vG5P5vcHOwd8rofO8mZkR9wTHyr1g9G7liOp
	l2gKuOxHeRFp3aMiAGbIdeXrGqeyr0Oh97ZTWK/Zw/n/emRX5QOoE8CDQrkWHAftzNbH60TBQIB
	Uwde1C7UW8BxfULQ5ymn3xj27alNfB0jaFhicscM27prxhqpGitYBQwrgMZQYcEbzkWCkzvvnZE
	32AsZP0SvmpW/H0zlpU2Iv5wJgkE/M9fyyRBdF0WVklzmTpIMkVbPuHyT76kNCzrri7QwPw91X4
	v24vzV4EK0/HqpePQRx0K68xDZp1rfxH+ZDnFQZjP4ZMIRop+fHR+93n2fkTT68TPTYsyo4=
X-Received: by 2002:a05:6820:81c9:b0:6c9:80d8:a207 with SMTP id
 006d021491bc7-6d2d2622351mr445563eaf.68.1790108234294; Tue, 22 Sep 2026
 13:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922172028.6269-1-emil@etsalapatis.com> <20260922172028.6269-3-emil@etsalapatis.com>
In-Reply-To: <20260922172028.6269-3-emil@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 13:16:57 -0700
X-Gm-Features: AcwNN1XiYZPnaP5SRicCGj5AlCNONGjzkq8fstgTnhVQRWjQxe7fEQGRoeX3cmM
Message-ID: <CAMB2axOg4d9BtEiSe8f_gRK8HW71XcxCJZhw207evsB+cyn_nQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 02/11] selftests/bpf: Test dynptr slices past end
 of skb
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:37=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> Add a selftest to ensure dynptr slices cannot include
> past the end of the linear area of an skb.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../testing/selftests/bpf/prog_tests/dynptr.c | 10 ++++++++++
>  .../selftests/bpf/progs/dynptr_success.c      | 20 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
> index 5fda11590..439656036 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -9,6 +9,7 @@
>  enum test_setup_type {
>         SETUP_SYSCALL_SLEEP,
>         SETUP_SKB_PROG,
> +       SETUP_SKB_PROG_NONLINEAR,
>         SETUP_SKB_PROG_TP,
>         SETUP_XDP_PROG,
>  };
> @@ -32,6 +33,7 @@ static struct {
>         {"test_ringbuf", SETUP_SYSCALL_SLEEP},
>         {"test_skb_readonly", SETUP_SKB_PROG},
>         {"test_dynptr_skb_data", SETUP_SKB_PROG},
> +       {"test_dynptr_skb_slice_non_linear", SETUP_SKB_PROG_NONLINEAR},
>         {"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
>         {"test_dynptr_skb_meta_flags", SETUP_SKB_PROG},
>         {"test_adjust", SETUP_SYSCALL_SLEEP},
> @@ -94,7 +96,9 @@ static void verify_success(const char *prog_name, enum =
test_setup_type setup_typ
>                 bpf_link__destroy(link);
>                 break;
>         case SETUP_SKB_PROG:
> +       case SETUP_SKB_PROG_NONLINEAR:
>         {
> +               struct __sk_buff ctx =3D {};
>                 int prog_fd;
>                 char buf[64];
>
> @@ -106,6 +110,12 @@ static void verify_success(const char *prog_name, en=
um test_setup_type setup_typ
>                             .repeat =3D 1,
>                 );
>
> +               if (setup_type =3D=3D SETUP_SKB_PROG_NONLINEAR) {
> +                       ctx.data_end =3D ETH_HLEN + sizeof(struct iphdr);
> +                       topts.ctx_in =3D &ctx;
> +                       topts.ctx_size_in =3D sizeof(ctx);
> +               }
> +
>                 prog_fd =3D bpf_program__fd(prog);
>                 if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
>                         goto cleanup;
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
> index e0745b6e4..b668ebd61 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -10,6 +10,7 @@
>  #include "errno.h"
>
>  #define PAGE_SIZE_64K 65536
> +#define TEST_SKB_LINEAR_SIZE (sizeof(struct ethhdr) + sizeof(struct iphd=
r))
>
>  char _license[] SEC("license") =3D "GPL";
>
> @@ -211,6 +212,25 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
>         return 1;
>  }
>
> +SEC("?tc")
> +int test_dynptr_skb_slice_non_linear(struct __sk_buff *skb)
> +{
> +       struct bpf_dynptr ptr;
> +       void *data;
> +
> +       if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
> +               err =3D 1;
> +               return 1;
> +       }
> +
> +       /* Ensure we cannot read past the end of the buffer. */

nit: maybe "end of the linear area of an skb" to be clear?

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> +       data =3D bpf_dynptr_slice(&ptr, TEST_SKB_LINEAR_SIZE + 1, NULL, 1=
);
> +       if (data)
> +               err =3D 2;
> +
> +       return 1;
> +}
> +
>  SEC("?tc")
>  int test_dynptr_skb_meta_data(struct __sk_buff *skb)
>  {
> --
> 2.54.0
>
>
