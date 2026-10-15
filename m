Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8381545D85
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083696; cv=pass; b=Ep8nbV/qkLsMAmRWCpr4egCrI8d8VlxhReVhohG5eyhUKg3JAAxnyMlDKirHMQIBclTyhEh2CSvUO3MDwTfEh+mlXq7Rw7XyOM7ZdLe8cMhVwJlzKku9tY3BHRQHSqBsuq1BkpPyKHQNXBbaNkV50b2PNUIGTC/AdITdAAtT6zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083696; c=relaxed/simple;
	bh=2mIQHt2w6JreUbD2TROanCdTO/tWRibiQj9E4ij67Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CA5CYeikMCBv3m9foaW7vJ9C+iexTHOV2rqpLpsp9d/Tj7t2r3yyyHHrZp2zCuVPawK77ynWLP+N2128vyngHcU6f5zJb9Il6KqrcfiLslRo/DMbTB7KYh3r2BRD5TcgnOB2GzSkmE3rstJvbENxOt+iLWA54Xr0fRcuj81qGt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXS219N/; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXS219N/"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6df93f00f4dso1191981eaf.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792083685; cv=none;
        d=google.com; s=arc-20260327;
        b=I3AOu+bpxS2xGEUv+xEVdvRvFZZc3ihe23lnfnGn8t9aFVekoWB+X/3kZNfv+tWcRQ
         6Y4nwyiHMSxfNX8vgTcpoLmf1q0P4++LqdkftYcRZTGsmBzFt8a0+0NyLqW/9OEtNr+H
         JcuHStal9d8yqWoUXqC/f5+zAnrML4ctRogFFuJABDXkMd4rg4MAHYGFIw3HUbi3hBxQ
         ikWuubW7xEwf8ft3wwaKQYTTuQXQp1rYSNiCHaN81kqN8xZPtPePT3ZKycfGXSaZZGaE
         SFyovSY9GvcixyfZGb9cP/HRlwKU/L6rciYrFblKt+QsmyZqiNzCFkab6BixTAaIXDBr
         LdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sh6S4L6abExAyHv3Pko2Q7AmJzUE2jSd9Tm1J7A1aDQ=;
        fh=cCNdAQI1NajTnXS5uJPGIC/sStgAqz3SuqyM6p6GYgw=;
        b=Hwr95yEnmZkooncWLeUrLRzFUpcSlKrlNhwCpuhoWfw6gt/xEDQaMyF9f2H4P0Ik4o
         bO1OEgVs0RgQyb8S0Q+QHuGGHvUP1r1OmPJVWmOndobIOg2ysTebfrI7+pNZXgjEGlPO
         2L1hSDlz/Oi6HOd0kC4ySIptWl4zXvdcN0kB3Y+sylYmvwcqwRH6kMAWQjWoR/Ds+fMk
         3YgRuzdmPOgVbknKg2WohIXF5emYmUjqLa6wGRF1JTx3eg3NcfhHqNOnhTxHpPZLIfDm
         mbcDn7OH2t+sHHM7Iw2axQD3REa/zx0LpWDY3miHLzFvMPEGelPWhvZhENxUrKrECe41
         K3xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792083685; x=1792688485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sh6S4L6abExAyHv3Pko2Q7AmJzUE2jSd9Tm1J7A1aDQ=;
        b=sXS219N/BK3v7doRoTJuSwbMM3u+i7mG1OjRLuKIaIxEzfc7xP71hFvhP4Nh5PxNZX
         W3R0qTpBeM00jofQV+AH5Cq9abTr4WOgsaLeTyNRNvNPvhI+CAtDL+o+1iE3qxf5eMuj
         heMEF5BauCJE4VzsToIsOOVrPcB6VLRBRIRMHQxF9gCDl2qergXdIopUKOHr8JNp+4Bu
         /f/KYGtwqV1kcuudRPU2JDJRduhaCSQ8kjkbDrCRqvDH4Odnrpl2lcCnMRBeq7Gm484u
         h0ruf3uyp4CNnTn6hQsMJi0vd7TOkVaKGwJqVcIwOxHNhfzRUtDcl30Apu1PyX/X+bUw
         pz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083685; x=1792688485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sh6S4L6abExAyHv3Pko2Q7AmJzUE2jSd9Tm1J7A1aDQ=;
        b=u2Q2tJiB/7LeBCYFQ/DgojU5jdizTgbnuN8+VNjbOwvq+AfqGJmmUeqiGCklBaE8Rs
         cOEWj7kzDV+GZB2cMJ3A1ImDWHTAfjsAmKYdLIarwTZl49qn7QHgYueT5nkm7ZzktrHV
         0lAVKb2S25xXMpqAgE9x8vkvUPEmz/wO0rBL61RNt3q/ShT/LcB3h1LzeygwXwThzLLj
         YsymLYWsK0B373xUerDvjXuhIwk0IJxW4Lfs/iK/qvDRb3uhY77SneG8vmPfx2s5vOLb
         3sIm1S13/aQyUBrfIZhkoFAkMRDTI8/LjwiOUON9nOzwQMEgkShCVJyZ6ZSg01f+kCnq
         I3Hg==
X-Gm-Message-State: AFq9FYJDrLLZHZJhw/PJOvpZ/AggEBFC/VKZxmeBEk8O3bD2goAy6udY
	ovMweIHAI2SyCwpgVAKzf2ANZ/42EypZ9fGPZfp3xU3jugk2S/A2AX0CGWUmpTY+uZ1UIJpaiEl
	AXyCRqBQomymGVTTUh/Kjz3p0MEPZTME=
X-Gm-Gg: AYBFou2frwArKV5N9/Vja7tC15s4n/8du61VVUtRbFtY7pgaD9XU3KZsKCmJl6meW4+
	ZpZH50tBdjl1IzNwsmjdG8vJyWxIb2M5t0JR9sjGs+kKJ3uT0O/bebDazyWXyewvMJklYZkwI74
	HLHxibLcrH7wCeQQb8Ox+DFyc4ChBuIlh59snrro/KJFEplqoBzpJJocwq0NB+0y8iiOdvdVJVf
	137Q0Nd8YCgnmNrKrmgT3a9g+7TWZD8KAAYhKtRDvp2GHxS0JGgeYi4JSd/2SNTMVl7TgAnSzN0
	rpNMSMn6Nlw8W2on5RqdtseBksebqKowIfay3gsBy3buZMebqY+jeZGX6sFmxoAyYA==
X-Received: by 2002:a05:6808:14c5:b0:4f1:9d5b:3113 with SMTP id
 5614622812f47-50c5bf0c17fmr17222792b6e.67.1792083685196; Thu, 15 Oct 2026
 10:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791980149.git.zhilinz@nebusec.ai> <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
In-Reply-To: <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 15 Oct 2026 10:01:13 -0700
X-Gm-Features: AclHuK8i-euzJcQWjKq28ighqiRw5kdDd1_oZsY_AjK3q4Q3MZriRllLYnxFA0A
Message-ID: <CAMB2axNZ=Js_-jGodWE22VoeVmR=9AL2V8jr_t9G38eAaMs_ZA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] bpf: reject raw iteration over managed sk_storage values
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	martin.lau@kernel.org, daniel@iogearbox.net, leon.hwang@linux.dev, 
	mattbobrowski@google.com, menglong8.dong@gmail.com, kees@kernel.org, 
	bestswngs@gmail.com, memxor@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 5:24=E2=80=AFAM Zhiling Zou <zhilinz@nebusec.ai> wr=
ote:
>
> The sk_storage iterator exposes values as raw PTR_TO_BUF memory. Attach
> validation checks only the maximum access against value_size, so BPF
> programs can read or overwrite BTF-managed fields such as __kptr without
> the verifier's ownership checks.
>
> Reject value accesses when the storage map has a BTF record containing
> managed fields. Iterators that do not access values, and maps without
> managed fields, retain their existing behavior.

AI is right. It also appears that iter/bpf_map_elem may expose special
fields as writable PTR_TO_BUF. Could you cover that path as well?

>
> Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/core/bpf_sk_storage.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fa..b54fd90d4bde 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -863,6 +863,12 @@ static int bpf_iter_attach_map(struct bpf_prog *prog=
,
>         if (map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
>                 goto put_map;
>
> +       /* The iterator exposes values as raw buffers, bypassing field ch=
ecks. */
> +       if (map->record && prog->aux->max_rdwr_access) {
> +               err =3D -EACCES;
> +               goto put_map;
> +       }
> +

Could we preserve access to non-special fields of the value? Since
max_rdwr_access is an exclusive upper bound and record->fields[] is
sorted by offset, attachment could be rejected only when:

prog->aux->max_rdwr_access > map->record->fields[0].offset

This remains conservative, while allowing users to place special
fields at the end of the value structure and iterate over the
preceding fields.

Please also add a selftest covering allowed non-special access,
rejected special-field access.

>         if (prog->aux->max_rdwr_access > map->value_size) {
>                 err =3D -EACCES;
>                 goto put_map;
> --
> 2.55.0
>
