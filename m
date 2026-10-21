Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792559970;
	b=V9LRQAQnkRFDhxwIByAzPccI93FOpgofdKT8ULuMtj4c7PstQ/nDRWZXDqbLsOxBB3Yf
	 6hQH22o4A09bmLv+JGZEVjXZV67kJeL6EAX1nQLDYC0aFBITAe/5x3PAS5IMb4R/yLKWz
	 sn+a5xjAXr8x5738R/bVXZUH5WMrtSgRrXh/vntEgK4e9rLPjkQBF7/V6LpzJnEyfNwaV
	 keSRdQHk1+2HJoSoonD2uISTgs+v+0PKr/QlWzDDx/Iia4xwMZf37n2Ox6kHb+K0FxRiV
	 YA5FvhvGnLTNefD+Rk3vRO3CJfJqAoB0WuJHJOP9/a5qtVrnpVbosOU08NYR2797NcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9uqKqqj+8HuF/4UwLYBXNktYmhjJbDw4iO8neStrQWU=;
	b=bMmbqUD1jBiNa+cFsoAiLFC43ZIB3LDkbgPujtdw6Kv7k+/AdFx+CzsELg0iKTWy1LMx
	 nGpaRHHjiWPa+Im0d7QRHqSfKAHFAvL3C1aWSWpF3v2ILBc6f0YcAquh9uat+N5EJxpvM
	 lrD0gy7h2kPnDlgyIx0Kcj77SuFFLjLKk93qu+atIfebZxRVuPI9ZfICEkE34JLqKY/Ha
	 DiaMhYVqNIZCXc0+lWSa+DuIq6j9iYLsFy4OYXjgxwlR+dOQwtH+IwtKBGHVEXWwl9ooT
	 SVFHzcSdfYp1QMNM/7ZpTApwk9EN6qnFVyTSeadwvUZQNqf7QnaLB7vIRLoVI3eSsoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aVjPZq1E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.137
Received: from mail-qv2-f9.google.com (mail-qv2-f9.google.com [74.125.230.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8F606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 05:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA8F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aVjPZq1E
Received: by mail-qv2-f9.google.com with SMTP id 6a1803df08f44-91be0d65430so2951956d6.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792559969; cv=none;
        d=google.com; s=arc-20260327;
        b=eX1bOmxGMsZUPkjMxG7ZO7Gc5ov1/LW4S7v4szh9pA346YbvRLaioWFB4WzUYBeng4
         65RdYKLsToFJdwTOul47O8h5EDMv26gDzVT/tj7qasB/39BnfL8q9bOt6kR8hxSwPJmi
         J6r24bzOUWt3nQFg/r/qLESbsAUJpw7hLte6u0AqXXu5Bli1QZXhF69K89FDA+wF75Pf
         0wRXno/JPchj1ErsPkQPxDUe0BsN0kEccse1ihEwaBweSsFS+2eWr/xt6CYfoYkAchgf
         IuAiDRzOp5RyA0KdYhK9YilRLOQpLvQ9WyJ0A4uJ0QXUXgNS1IJTFG/mT9lp0vIWeUbQ
         innw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9uqKqqj+8HuF/4UwLYBXNktYmhjJbDw4iO8neStrQWU=;
        fh=OOgitwruX6EBA32MWtJp+Z+1PM03ogjTJZhfXyXLlyw=;
        b=I0k3UNP0dZVJnJ7kiHo3aBAX0y/Ze47TZxSc+pLd5SFJ4RvkdcZKfyxkTDNr6levNm
         RchRH9yMS+nUxVLqbucOSywF0QdS1owa3wwk1qBXGHptzgPbI+Ki4obJWxeI27VYc83j
         /yY5ovA+Ng0jrzW0lpwRn/40LhR6kpH7G2m9/j2qugeOdRLXvOfD/0JYoVVC1REwceex
         PXe4xFYk8tnHuN/saJsybxVFRoAWp8+WbsritSO4aPsBM8g/uBcI3vf2XWUcyGJEgQL3
         czT6skoOItxriZgGIX7zlOtqTIiPtqsv8JGz1DXDDrk+IlOJ46NxFUl04XbOwbB2G5k0
         Reog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792559969; x=1793164769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9uqKqqj+8HuF/4UwLYBXNktYmhjJbDw4iO8neStrQWU=;
        b=aVjPZq1E/HN0ooxmfaDLMMJuvgPHVsz/o5hXBGbHqg8vDvcweXb9GqZSJt01UUMgAG
         hnvogqaLke2I95SyhZdwq2/8ulSO3bn9Txi9jsuhj/AtK9FGIQTXgZJwmZ2l2ueClds7
         bbna/qrr1aQ+L+VpW2RqkgJaPK+EEztBoN6sJATt3Kf883d+ddPANumGD+JJYLhUc4Ek
         9NL8QPVWzGcxlzT61KA4NV08+uAgLtXZNQofj+BBanas3+uykbhhw/uSCbuq52eI8O7O
         0oOloZeWBk6EgfO+yG923FgrCV0mBpGfxsVFByCZK5lZm1tUxEebG1UqwlkArcHAswC2
         F2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792559969; x=1793164769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uqKqqj+8HuF/4UwLYBXNktYmhjJbDw4iO8neStrQWU=;
        b=OJ4OqRrfA0RUaJpDv/EzBQa002G/BMqX84K1V9/xAZs/xXntEtzNwbM+Ic+NYT+tAj
         caw7Ly13LR7FtF/+FYKwpPOLabw1vdiefGjatOv8/l02tPaO+cJFfpV7ij/IU8d9m8lB
         aUUiTp66JD5XyJOp0aNHeE6EFc1F4nsTP1uDQ2JHyuSsO11PmQKQFBvhF1ZK6yRkyhqs
         SUSbhJ08xvYLt2AaQx4zfzQUYapRL41gMQqdYSOl0OVSOAaXXziubL9geEWzguebUU6n
         7XO4nlORIFy99u3mD7yKjmoh842vgGTUtLNiJFonD5EaQG0h/7Pa77/rlIBlTIRjUv92
         CTaQ==
X-Gm-Message-State: AFq9FYKm36lcBv0/jSGHqLBGWyfhJ15zn5qok1ntLnyCUPUIcgCT9D2F
	6C2g77d7+5C2WNtJg9jykhXo2GLO4DuY00epAjXxhVLzSq5ryszxhMaHrz5HjbdP9LEbSVGVWEx
	NythU4qprtTBy/PSWxGHMAbYOtUnOLw8=
X-Gm-Gg: AYBFou1+PDsWJA0qcEgMQpLr0t8mcsoMlzaspIU08wriffhIBhjROojyOw0bHjtHgtd
	JpDRmCi4IEXAMasaHGFxhZWHHVqqYmOxDRhJW24ZOI4xb4MA4cE0y8pGnOo2Z2Si5g/Lh892JJF
	b/Vw1QQw2YyASR3PPpNo+2EDjw362pP+AoARdcl+TVAwhw9xxTlDE7jvRJR7oWfK++tewEt2VOJ
	vQxnI97nS38v1zm+OBPFjyjBQXAuMjxFKACcvzaEfh0NwMuXiGTt5WuUabBHCw/KUyJKJfyADSW
	a+G+mBjU+qkIhKgXb4CTqPrT2qwlKIqqQoRaM0OzM1jd7ikD/CcY5pJh/Q3RgcbuQyuJBbBBS/k
	HWUmp3v1xpKCA6li67w9X0NlvoUCM0HvhWv4s0A==
X-Received: by 2002:a05:6214:469b:b0:91b:51e1:f7ab with SMTP id
 6a1803df08f44-91c12e4019emr19213576d6.5.1792559969112; Tue, 20 Oct 2026
 22:19:29 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com>
 <e4054f5a-e60c-4253-bccf-d05cc7c615b7@nvidia.com> <CAFxp=AapgUYLUhipVjR8oM0fRDSLDX60AQf0UP8=U4M1ASqmOA@mail.gmail.com>
 <e6a557b3-2986-486d-9679-e7a4fd1cee5c@nvidia.com> <CAFxp=AbmdmTsj4ugjxdKhRR=LJuuC1yr7DFnLCSgOpC2g9470g@mail.gmail.com>
 <atZKOtjrb9HKSNHF@dtatulea-c5.nvidia.com>
In-Reply-To: <atZKOtjrb9HKSNHF@dtatulea-c5.nvidia.com>
From: jiabin deng <dengjiabin2023@gmail.com>
Date: Wed, 21 Oct 2026 13:19:17 +0800
X-Gm-Features: AclHuK__j4Lgn5ynMxaPYgSOVDVnSg97JdwTJDQyxHwLpuuEj80AGCA2S-JXDoY
Message-ID: <CAFxp=AYqVgR_Eahz2QsC=cCdxo5GmTwdHcgBdXRGf9P+v0OJxQ@mail.gmail.com>
Subject: Re: mlx5e:zero-prefix corruption during TCP DMA-BUF RX - help requested
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

I applied your suggested change to `rq_end_pad_mode()` on the receiver
and reran the standalone GPU-memory reproducer I sent previously. With
MTU set to 1500, the single-direction test covered eight message
sizes, with 50 transfers per size, for a total of 400 transfers.

All 400 transfers completed successfully. Full payload comparisons
found zero failing cases, zero incorrect bytes, and zero corrupted
intervals. The zero-prefix corruption observed in the earlier tests
did not recur in this patched run.

Thank you for continuing to investigate this issue and for suggesting
the fix. I also greatly appreciate the time and effort you and the
other maintainers dedicate to the open-source community. As a student,
I am excited to have the opportunity to contribute to the community
and to learn from this process.

I would be happy to help prepare a formal patch with the test results.
Would you prefer to submit the fix yourself, or would it be helpful
for me to prepare and submit it based on your suggested change?

Please also keep me copied on any further discussion or developments
related to this issue.

Best regards,

Jiabin

On Tue, Oct 20, 2026 at 6:56=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Hi Jiabin,
>
> On Thu, Oct 08, 2026 at 02:48:53PM +0800, jiabin deng wrote:
> > Hi Dragos,
> >
> > Thank you for following up and suggesting the CPU-buffer comparison. We=
 have
> > now completed both ordinary CPU TCP and CPU-backed DMA-BUF receive cont=
rols,
> > with no payload corruption in either 400-iteration run.
> >
> > Please find attached a standalone GPU-memory reproducer with a README c=
overing
> > the required environment, build instructions, two-host execution, and r=
esult
> > collection. It includes a Python TCP sender, a C++ receiver using the C=
UDA
> > Driver API and Linux device-memory TCP interfaces, and scripts for SHAM=
PO
> > header tracing and offline byte comparisons.
> >
> Thank you for the reproducer. Unfortunately I didn't get the right HW to
> reproduce this.
>
> Pasting from your previous email:
> > One possible lead is an interaction between SHAMPO end eadding and
> > Relaxed Ordering writes. In this version, rq_end_pad_mode() disables
> > end padding only when LRO is enabled and write RO is supported.
> > SHAMPO therefore selects ALIGN; at the same time, write RO is enabled
> > on the payload MKey when the device advertises write RO support.
> >
> > Commit e2351e517068 ("net/mlx5e: RX, Avoid possible data corruption
> > when relaxed ordering and LRO combined") describes a related issue
> > with consecutively placed LRO payloads. We would like to understand
> > whether SHAMPO might also need to account for a similar situation.
> > We do not yet have results from padding/RO diagnostic experiments.
> Initially I dismissed this commit because it seemed unrelated. But now
> I see that you analysis was probably spot on.
>
> So disabling alignment padding mode is definetly a very useful experiment=
.
> It would go in the lines of:
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/driver=
s/net/ethernet/mellanox/mlx5/core/en/params.c
> index 70a855c6d19c..794d8be88f0c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> @@ -911,10 +911,11 @@ static void mlx5e_build_rx_cq_param(struct mlx5_cor=
e_dev *mdev,
>
>  static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_param=
s *params)
>  {
> -       bool lro_en =3D params->packet_merge.type =3D=3D MLX5E_PACKET_MER=
GE_LRO;
> +       bool no_pad =3D params->packet_merge.type =3D=3D MLX5E_PACKET_MER=
GE_LRO ||
> +                     params->packet_merge.type =3D=3D MLX5E_PACKET_MERGE=
_SHAMPO;
>         bool ro =3D MLX5_CAP_GEN(mdev, relaxed_ordering_write);
>
> -       return ro && lro_en ?
> +       return ro && no_pad ?
>                 MLX5_WQ_END_PAD_MODE_NONE : MLX5_WQ_END_PAD_MODE_ALIGN;
>  }
>
> Could you try this please and let us know if you still encounter the
> issue? In the meantime I am checking about this with other people.
>
> Thanks,
> Dragos
