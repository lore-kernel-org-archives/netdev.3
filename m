Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E8348C63
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486969; cv=pass; b=hEhBDAhlPpLjcbVhacmhf4GvItaRbcppDpCcSEA2n+YUQ8CUUsDbCaYEPQsVn3DrZ+g5q9gX6SQKvuheNA9q5kNnsXLEriY3tkJlLv17ICiAlRZ0H/IjJRSnUiMCVuy4874LeUpctneTjeCkD8O+KErvMvlsfit8+9f+ZR3QGPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486969; c=relaxed/simple;
	bh=K5Lzp/jJC9s1zl3hyzvLKMRSNcWeuGGp7Gp8oRt5eRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0FqHnqxwyKb5POKk2zMye2MFg+FzFv+NikaZnCvFX1kKEHOcY2V/ucn0dEwt6nyq5V7gXcfMdnkQbbV2F9sMDnyTHqmVyDkp5d0+VjQUtsRsNv03xIUzlbMzma1xDSrVuPlU2YIgtUnKZkTmjMnrMe/iGRyj4IbGKDXOJIC3BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIjPqiW2; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIjPqiW2"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a777d4f321so30026841fa.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791486965; cv=none;
        d=google.com; s=arc-20260327;
        b=sJYwkvCul8ZJhiec87tPwZaHwg+tcRea029EC4M2ea95J1UH/nB2GG+o0WlLLwkxNw
         aN/OsJ0gb9ZxLX3TUsIBOkns64jeJ/eMYuUs1DxgEnZ3v6NGA754/NSZwSp1r6SjV4mu
         1fHSHsiSn9v32u1OFW2S/kGLltC2aBGSPY77lH26niUf0nFRmprArzArAoAT8y3vIWK/
         y9PWyXacujdRiouMa+i6KgurQjJ6EcxDdXyFsR3FCB5SC44DEGyhYyXqygLLkHiDAy+l
         Og6rSjhxN/U6nQvjIWLdIs+Vd/rXlc/RZCuTKVILHWQdsjZl43UGMxZxlln1kISOpo+4
         W3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vHNgfkuwp3jFs7mDECGk1Qye3hSH8mafgl8fIqaQf2c=;
        fh=0whuMXPYJONK9iFMQ2By/H1fS6MXgOQRIqO8CNqnAgw=;
        b=a8OaT1BtvBeiq9BVb8ZExQKuoI0wBsguk9nz1dtEDbBRUu74kCWZy48e5fo6QnwQ0a
         sEsyG9+OvvtCY5uMVI8uJdAEiN4eGzu4fgroQI5mnbIPUhROh/5c5VilOaWc3u2dJf2k
         BdQFkjJ/oCzp9o4s1wIyxx8zNxMfSRWxQN+o5akZHU+neGN3Aj3zyZyiv2/MTK8L+LEz
         0jaCsxRowKZTQh01QQYUcATLBVVwRVuNZ/b8f6B/siF8vM+jmQCuxO1zYfVfukjAJtsV
         of26/fX77Pex+3WfV0PfIc9G0ihVGl5x0CkkrTJWURsBd2lXVxIP3EZj1xOIWlRu6igl
         JyHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791486965; x=1792091765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vHNgfkuwp3jFs7mDECGk1Qye3hSH8mafgl8fIqaQf2c=;
        b=SIjPqiW258jkLCEAMGeTh/xiMEMS+VqcxARxVOdX64oFJXbBKBptE0zcJBUJs+azEQ
         257u7b0dg/NGcoDyb4A/LTwGtpZjozI4fLs5mJypal7D49UgtoZV31R+gbQaKpqxgsx5
         UZvRHPD4NyXL09+cexuMjMXeKH0lyegGs9Gv50xkEzgQSfA4UDygmfe/tkBSAQey5cHM
         ZNEW7L6jukNOyf7I9q7dqudktgfqvPjwRzoVfG0E0dsXuBLUz/o0FPx1gxvXgNWWBseL
         c/taudb8FK52JKtbGBsQcghG/+m8bLuVT8e3f8O6dLiwlSRR2dq4NHSaA0wZeEaB6/Gw
         gbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486965; x=1792091765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHNgfkuwp3jFs7mDECGk1Qye3hSH8mafgl8fIqaQf2c=;
        b=X7fIit653dQoDPp/0s42v4v3rbF6YSuTcLfSdf7WmppEoYKTqb6fjMNjwvpq6zc6zI
         uOblalwGgdGRclvVSiNBGFOhfJ1Y0Db3cNh1PgDpRUPUVySFcQVBR12cDc3ead18r0QS
         NUdxhKuyjsq35G8mC1bu6MBoOlGd0iQLqU0yyRNDQzIGxpWcWFtQMSDi31Q9gZj+HiPk
         LD2JfAH3OPEYVX4GWUkYymQMIJUpzwTQXcK7Xe0xHcUEfMLXrJm0foaxKr7JqxzUTJF6
         9uQ6uBRtGcS60V+sV1K9zZ/G8nLpF8QvaG20rXqnfN66re3ty7J7tMyj/wqe4CmQAq7Y
         acmw==
X-Forwarded-Encrypted: i=1; AKwUvBz5jzuggg0pC3B2xkIHpbLj5aiO9pJ25FKObo9bi6QWPpnVIWmIBNVHJGYYnRPBckHxinKA6PI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUmOskis67+Wb1MvqRnnrKYDLxgs2uqTItP+t0MoDXIimRmEFM
	68eZS8LjwJow3L5NXqJ1GGSidKRSHKv0W1iZZc1M30kg9ZNNFXWJQ15Qb8cEvljklG/uBsoC8F6
	zF8ZoMMjujyYFtIJEMdQNu6rkBgKHPwtBWdVwnmli
X-Gm-Gg: AYBFou2irNyTnuc5mVgqbVucAVNSDBXQXtwnR9mlLTwZCv9Q7h96MLemxDOV/HJ8djA
	qyS31dxmrsbO2ANt9UsHvOGdmTOhKQFyYzvxDvMehRBNdf+rEj6vbxWIq3OYfHttjNGa+nB0IrH
	yKjixJ+X1F/RSDymLeqt3q17B4WM5QfYfB4zv/GXhsGi6yLeZJg1rB1iQtgmmbQ+mAulUdEZwPH
	8ZEhBZGie30NWBR8pKyYPft0Mf/eTqKKR6NjYhgblOD9iuY/CFgYHhyWS6+0rzq2+LhysiXmnPl
	m+ceMB9Id/n6U4ivoq9+UxDT5s0PwoobkdbCBK0vuAPURO9hXbbqLLLlooXoLMHwPouxckopy1v
	SuohrfMqX5wmfpzU97Im+RGhry/hb6kZOQfn1TuC3Eg==
X-Received: by 2002:a2e:a7c1:0:b0:3a9:849c:b169 with SMTP id
 38308e7fff4ca-3a9a2ccce5emr14774661fa.26.1791486964690; Thu, 08 Oct 2026
 12:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008173334.2881475-1-brianvv@google.com>
In-Reply-To: <20261008173334.2881475-1-brianvv@google.com>
From: Li Li <boolli@google.com>
Date: Thu, 8 Oct 2026 12:15:51 -0700
X-Gm-Features: AclHuK8hC5pBINOHNd6sNHM56enXqSpYjYbwB1ohtsEoxneiKD6Ai1AkI3QhDQY
Message-ID: <CAODvEq4UbfswP9fQdbjOvwiDE2bopLPxiBHr-5+e40p=OVpkrA@mail.gmail.com>
Subject: Re: [iwl-net PATCH] idpf: wait for the reset completed state in idpf_check_reset_complete()
To: Brian Vazquez <brianvv@google.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>, 
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Emil Tantilov <emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Li Li <boolli@google.com>


On Thu, Oct 8, 2026 at 10:33=E2=80=AFAM Brian Vazquez <brianvv@google.com> =
wrote:
>
> PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode the
> function reset progress as a 2-bit state, not a flag:
>
>   00b - reset in progress
>   01b - reset completed, written by the control plane
>   10b - function active, written by the control plane once the function
>         has completed VIRTCHNL2_OP_VERSION
>   11b - reserved
>
> idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, with
> rstat_m =3D GENMASK(1, 0), so any non-zero state is taken as "completed",
> although only 01b carries that meaning.
>
> That only works if hardware moves the field to 00b as soon as the reset
> is triggered. On the devices tested it does not: PFSWR transitions
> PFR_STATE to 00b only when the field currently reads 01b. When the
> function is active (10b) the field keeps its value until the control
> plane finishes the reset and writes 01b, which takes a few hundred
> milliseconds.
>
> Consequently, on a hard reset of an active function
> (IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
> driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
> reset is still being processed. The control plane tears the mailbox
> down underneath it, VERSION is never answered, and the driver sits in a
> 60 second virtchnl timeout (-ETIME) before going through a second hard
> reset which then succeeds.
>
> Make idpf_check_reset_complete() wait for the state to be exactly 01b.
> This is the stricter reading of the register definition and it does not
> depend on how the field got to its current value: functions that are
> still in progress (00b) or active (10b) keep polling until the control
> plane reports completion.
>
> Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/etherne=
t/intel/idpf/idpf.h
> index 470bc23c844c..ce8a1bd0ec8b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -166,6 +166,8 @@ struct idpf_netdev_priv {
>         spinlock_t stats_lock;
>  };
>
> +#define IDPF_RSTAT_COMPLETE            0x01
> +
>  /**
>   * struct idpf_reset_reg - Reset register offsets/masks
>   * @rstat: Reset status register
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index 2c148377540c..a827e0fa67c8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1870,7 +1870,8 @@ static int idpf_check_reset_complete(struct idpf_ad=
apter *adapter,
>                  * register for us yet and 0xFFFFFFFF is not a valid valu=
e for
>                  * the register, so treat that as invalid.
>                  */
> -               if (reg_val !=3D 0xFFFFFFFF && (reg_val & reset_reg->rsta=
t_m))
> +               if (reg_val !=3D 0xFFFFFFFF &&
> +                   (reg_val & reset_reg->rstat_m) =3D=3D IDPF_RSTAT_COMP=
LETE)
>                         return 0;
>
>                 usleep_range(5000, 10000);
> --
> 2.56.0.385.gd3acb90ef8-goog
>
