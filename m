Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7203DA5B0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538255; cv=pass; b=rEQcAAxkcg/LFQMZGaCEmYs6PCO2Nt82sHnQTB7plVY+RxQwxD0zDbHUrS/4heyv8DmhLg8i+O/Ro+si/VYeEtBuJSKU6+GnpLr+i/LsqxhiWGLOIuEblq+H+X7TjWA5zb0mBwZ5V0jfLa4EJeP5qtI0lBCT4IS9UAyy93Oj2wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538255; c=relaxed/simple;
	bh=VliYoNm9L/I+WmONyNulPZNlcTjT8AH8gN8t50yoaHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N29Fgl1If8XEfBQ9EXpaxDpahQGMQlcEcmzAfklQFyt5ctVPRrxFRvvxi2pnsgR/+9kbFxCLLMluIbpbNG6joFI+miAw57hMzHqs+S+3mBpixxxMutUpNhcY06lb51nIm4uQFP4RctH8elf5/y8OHKsk+sYLG12UMAPFI9P688s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az0+OWr6; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az0+OWr6"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c6b4783778so339602b6e.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789538251; cv=none;
        d=google.com; s=arc-20260327;
        b=OheUKMx6+HN3/AhdCo1UkF/QXujrq1it7cUcErmTCZVuQAm/Yr0PoRtr+o9c37suKj
         R08ih1AdL7SvOid8TvMZzrpkNqe6WPWroA/ve5CM+hncPIAvCzjiI1GsflH+Kw8ABu1M
         2QboSd4eGU1ZIq6M2PagudO7nM1Fru6LVeGogqxHCrQrwEUCpDJ4yoCDADvzmwmfvIPK
         nLcgo+kkLmaOYQ0BsQDwt3wsrLdKOJbrJ0AXE6jdROu2Ehm5dEFoWICzLWVxPcVHttgN
         kK8u1Bg+f/ZCofGBSZbr0zGerDcIxyj5JTHolBvPyM/3Xsw33xsE7bJ+NJfkSwDcTsbs
         JWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v3+4CHA7p/PtNxnOjFIKd8kLmKZDJTVsu5fi3JRfwyw=;
        fh=1ElksJ7/6rWfYvJaT1uYeNmLmyJA1DSFxM+IQU3X3eU=;
        b=sX79CyQLNQGsJX/ad4X4FkTHmwS4XPgVOMzKOpvsMPD3WtHO5r3KB4720WzlgHnh/9
         eH7RltRD7CjOuTGEHrNVzIZ+/SD5k95cgysQjwbbIDb4ChPPekS74rJ+5Vzo+b1/2j+T
         +XJTKS1LQJAxG8HLAX1G5mMg0QYKlpvFDEHrmSuUDQ4beGQSKpL2guhkHSInfLSXXtUV
         vejnhm5EV4Wx0nmn9NHp85zOiccOOhl+0dhxapNxT+tsAJkTYrDPEJOlbzbSvlhAkvOT
         pwFLKYvYiCIPv6XNsUdK6VLVQJgeKA17SqBea7w9ELWymJitoQucti/QqT4/FDYBfkDs
         maIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538251; x=1790143051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v3+4CHA7p/PtNxnOjFIKd8kLmKZDJTVsu5fi3JRfwyw=;
        b=Az0+OWr60rLJHtTlKMmI9DRZbdc62TOiS5c0GwojfzuXmFa83X6fZb0cwswO7rmC8m
         REVgwEJnZq4/NICAtFsS2+fDJ0e2Ej8aFgW0AMGvTDEkU/QGOk1WOqFgsaOrfLbQCABU
         4iML7gU/BiY9WP1fXzrPo7/Idadxfqggz3YBQ7+XIJ4zlIuDeKZL69i3rKmYxmlMlePv
         Ereuxpr4j5JowoR+D3nJHudHSgkEJ7Lv78+H0bP0U5f4V/rk26tnO1ab0P0A7bY/4rIK
         N/bN9oDOSlUlPYO+lyuazpXovbf6utVWhUAowGvmm20wC9f9OGmFB8SVEut/pNTah7aE
         37Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538251; x=1790143051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v3+4CHA7p/PtNxnOjFIKd8kLmKZDJTVsu5fi3JRfwyw=;
        b=kyBfZpm9QdrXIdYzDuzigcuBbUIxIb3vyZD+vKRIeq9SKy393x8yEpIV/HsYRVEOxp
         axCToWl7mJjCWDA7NpKq9pshywnd3hlcW6AXn7ixzUrjkp7FgO5aXv5zeKX8kzXKeSIj
         nt9qYbPMM2iNr2Tjiw1/1lIyWa7ggliwz4REy3ju8yR3VdPVKQtJFDjlkhqLjZLE8KxX
         ZNIEeXyxPyHRHGUVZb/elyAeCnW8cjrTejFmSTQ729TN3q2KIaZUYJM09UIQyT9RdA/Q
         rWZ/Ciluca4mOhqQ4PIkD7nq1H2JjIv5bK6b9n34jOP9Kgs/X4u85FS5SR8iYg7iyIIz
         nu1g==
X-Forwarded-Encrypted: i=1; AKwUvBxIwTULpzqte0NxD+jZuvidQSfTUL7PRMDfgJOJQM0MP8BYlJUSATsuoa1Ca/AKID3+Fx4VlEQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n4Kbeu+4ZyAfYAomhA3En9xQYd6LmupWy1rNCz3Hci9VI6RBZ6
	lSbSQmzQ77qmXAouqO8NcXCAdttJ3epWNLZVNYN1H1tKIlA6aQJVpjpB5TC3E+peaAXgFIBFpAH
	5FyrLwRBnazxzLKn9UqLTn/rQL7oynGE=
X-Gm-Gg: AYBFou3G9eJQVma8QiqBbXFCv2SjNXfl6Ut1fQKdwftPPi93yXCMIcSy+B3IXpvlFtr
	azSB6ucbLhCTqfSbXIXxKRGuaaJ7fxlls61QCcedE3sy8iORha7ZbBA2oUKlCQPJiHZlhhy2pzJ
	xATtGxlmrCz6MqGbKtg+5hQnfMcTlbb8/tK5Iao7WrIVCc2lYZm7luz95VmK/PFv+9/Eo0HYyCn
	+aYUwaKjpuE4npG9HI26fsRBoLrmvMbletpBFyDEowC5TlYPW8CL8/LmuqHg8odEVnA17FhGELS
	eTj4UFfgMhbTxTmotOpWUm5zKC6DQbiAtFN4EmV7HxXdkpSCqAmtkgREKPQL3BywQA==
X-Received: by 2002:a05:6808:6d97:b0:4c1:760:e5d6 with SMTP id
 5614622812f47-4ca4a3fbdf8mr3171564b6e.5.1789538250754; Tue, 15 Sep 2026
 22:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916050830.8774-1-emil@etsalapatis.com> <20260916050830.8774-6-emil@etsalapatis.com>
In-Reply-To: <20260916050830.8774-6-emil@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 15 Sep 2026 22:57:18 -0700
X-Gm-Features: AcwNN1Vq5pvkGB5jsdSy_GgFG1r64gTDSSL0mN1c2qYcfh2-PyhJyxDpFIyNp_4
Message-ID: <CAMB2axOAut_9utesiV9mG40bskrDscu+Gu9FUMNRKZC+hbd8UQ@mail.gmail.com>
Subject: Re: [PATCH bpf 05/11] bpf: Reject pkt arguments in mutating subprogs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org, 
	Nicholas Carlini <nicholas@carlini.com>, Mahe Tardy <mahe.tardy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 10:10=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> The verifier tracks changes in how PTR_TO_PACKET registers'
> bounds are modified across subprog boundaries. PTR_TO_PACKET
> registers are actually passed as PTR_TO_MEM, which is assumed
> valid for the entire call. This is not the case with packet memory,
> where a pskb_* call may invalidate its memory region.
>
> Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
> may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKET
> because we would also need to somehow pass the PTR_TO_PACKET_META
> or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representing
> the pointer in the subprog as PTR_TO_MEM, only permit it if the
> subprog is guaranteed not to mutate the packet.

CC Mahe.

Hi Emil,

There is a related but separate issue [1] addressed by 8fe994c80af2
(=E2=80=9Cbpf: Consolidate function call pkt_access validation=E2=80=9D). I=
 think a
long-term solution could be supporting ARG_PTR_TO_PACKET for global
subprograms. For example:

int parse_something(struct __sk_buff *skb, __u16 off,
                    char *data_start __arg_packet, ...);

The verifier could require a real PTR_TO_PACKET at the call site and
verify the global subprogram with a real PTR_TO_PACKET, rather than
converting it to PTR_TO_MEM. This would preserve packet access rules,
allow reads from cgroup_skb programs while rejecting writes in the
callee, and automatically invalidate the argument after calls such as
bpf_skb_pull_data().

[1] https://lore.kernel.org/bpf/aqkhifLvyAhw66jg@gmail.com/#t

>
> Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> Suggested-by: Nicholas Carlini <nicholas@carlini.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/verifier.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d852..507bc14b4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10375,6 +10375,16 @@ static int btf_check_func_arg_match(struct bpf_v=
erifier_env *env, int subprog,
>                         if (check_mem_reg(env, reg, argno, arg->mem_size,=
 BPF_READ | BPF_WRITE, NULL,
>                                           NULL))
>                                 return -EINVAL;
> +                       /*
> +                        * PTR_TO_PACKET get passed as PTR_TO_MEM, preven=
ting
> +                        * us from adjusting bounds tracking info.
> +                        */
> +                       if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr=
_slice_pkt(reg)) &&
> +                           sub->changes_pkt_data) {
> +                               bpf_log(log, "%s is a packet pointer, but=
 func#%d may change packet data\n",
> +                                               reg_arg_name(env, argno),=
 subprog);
> +                               return -EINVAL;
> +                       }
>                         if (!(arg->arg_type & PTR_MAYBE_NULL) &&
>                             (type_may_be_null(reg->type) || bpf_register_=
is_null(reg))) {
>                                 bpf_log(log, "%s is expected to be non-NU=
LL\n",
> --
> 2.54.0
>
>
