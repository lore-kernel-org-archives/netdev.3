Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EED4BEE22
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827362; cv=pass; b=sJCtO4jZs38wv7gkJclAUPKXFPc2PI1QPixZVc5BuqVLhcUjrYHCBEX5SWIEv4JcjpM2RoYbqyFOUE3pJA7BOSTgVdnKD0Z+GVKJ4uyI8628JkQxngVU/iMZaIic0dcc/3Ks4ETpVsrKaN4hryqcoGI/MIKGnbmg91ErTwit4+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827362; c=relaxed/simple;
	bh=zXMowjKMhNEHQ2iLsSxX5fh3k3aLhcEQjyZyEdIYKOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5/ZUfGcv3ZqkfEoToK73//AELDve6auTRYVDfpF3HmzX8WD/p2CsEkIMnNE1+dgNvrKBrS0bl0AehF4BPyLcTjtQMOGiG4D+4RN8i/5zoLwvSegGe5pRz22wf8/NeyB2sd8jsUk36Y/rZv76dTESt+V6ZoLjiBsZW8RGU3YgIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjVsEs/i; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjVsEs/i"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ccc6b11a19aso698950a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791827360; cv=none;
        d=google.com; s=arc-20260327;
        b=eNJEEW+CGFNulLktwaPwQas9hxshpfA0XbHshCLkaqOABBvO8uDMkYqSESfAiXliFx
         keY/f1BHhQEOWThnPUHzG2M0NM1s6Ntt8xWcDlZruYmCac4YwT+w6zA3PmYXkw4h8haj
         pOdO8rbnupurfRs3+kbojLu6pOCxKaiVt01s0hoynbvqHQAIQQsNmjF6tCemmGBQWjeF
         xuxiJdlW6/Y9WOn1d6udta4ymhqkLjOdrPsuxFE3vIMxVT416QrSh53aQ3Emd6NG+Yiq
         VOoY83JVbCKi7Wt7ivoZh5507U5qzY3CUsEIN8efd66T1XGL9EUqSRB4jkfoHyhFXgWD
         umdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXMowjKMhNEHQ2iLsSxX5fh3k3aLhcEQjyZyEdIYKOM=;
        fh=OYUCG28Gy+3q3xAOGWntn2huampw8eUYyLzohcZpsaM=;
        b=kMOnv02cJSmdYDgpro1Xx8cYHjf2TlZYaoaBWD5G2vU7+i4rtYCgGg+g8gLO6dLjAO
         x50NdJLHmJ4SLO8MmeIdbZurhpcvXve9nHiCjxNmVMDkCFev9R9er16f3ZqWSNu/ZIf3
         9ouBCL+AJlHL5pcdSijPHllj1raOPwUv/Y0Da0Iy7V5V6+BhzManb1areRJDb7xTQGUb
         uXg0qvI3E9/l3dNbuVOCGjCXwrU/d0ERkLKkQ8h7kfrcvHFOZkfKBPnuo5T9Ib0Kb8oH
         WM00KgsTpW11wrfjG8C45zT8ZsZTP7YguIC+O/GYGnVTLHypuOiaNNXxLWJUgo0vu0m2
         zyOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827360; x=1792432160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zXMowjKMhNEHQ2iLsSxX5fh3k3aLhcEQjyZyEdIYKOM=;
        b=QjVsEs/i1gj7oOupNO6djz5HzvPI+SgcLMgPillgK31jjaFdJ9O0YRczAXp5ywQHII
         ylrjhlAkYnYsIRBuJBJVrwjasalK1KXBwHAMurelvKgyQ7hK3oIZjLsXp5eUQ8CD89Sa
         4UOYZcQeEl0SsVbCkfwQguVjRRc2dv6aAGrs1CzsZDZpOiS9pTNnYkcZkVX8sLKlxzgd
         0dvrLl2IqBKsY1AyQWDNIT4eddCLrN88ChvdSEVTMzPiYxHwNYtM2g15tFWfKxYQh89Y
         nIFg9rDIaOO+Pu2R8TV7TnH1scZamrqYFpvAEduaQEMQLqCK/ku2K3pKHpvxuIVICOs5
         CAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827360; x=1792432160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zXMowjKMhNEHQ2iLsSxX5fh3k3aLhcEQjyZyEdIYKOM=;
        b=L7/Bx+9Tu/FpVWSbIpt7F7ostUQKF8R07wwrRMcoJ7C3j2mcxKIWSBMgwgsFACyYgy
         aw+h/YmIDwmbSg4XK/OztlOtTB2g6+/qiIqVsy9FA06TFT6wxomojfNumJbP0mI2So5A
         DHACf91UuXSiQbdr595b3sauNL7b4KTBf8162I6NJQfX6774Ncw6H2ITdy9gkMDT/am0
         hns0gkRlLOerf0X08GD19dJIxcwzi+97jfJoJpB2WCmTFSPIPKWlNNZ8ebuvLbLxs9Ah
         937OijCfs8vsxmgO6AAnH081MkOz4wA6+Jz4i9PW8xbJAbk600kwkkqiVDc5kEhyQAZb
         i2Hw==
X-Forwarded-Encrypted: i=1; AKwUvBylDqsnndAzZHBTlHbaNQOyr1rQh4Wm434nsScHiFXDPwfYu/mfGViPnVM6KqtTMfAHkCprpcA=@vger.kernel.org
X-Gm-Message-State: AFq9FYITj+CU675bpPUatmQcuSlEMLSQs++rcqVOok2LPPTKAJmTHml9
	jo9njI4+rRfUn5UnCpKD9Y8FzdRoa3JFh7qQ03jIpBOpRO9+ybtu4C4UDCu37NO4PHotravafe6
	VCRbIlULOGf6IKtRPDEHZrW8uSm7GbA0=
X-Gm-Gg: AYBFou12ZSfs4L/3+pHoubhmxvLrcBIbB53bWwClVebUhVrZqsVSrzh5A0nQtFRBFFg
	1sv5KlOZkKabn/nOWT/0qfWlaGOoFpV01o0b95+lUHeX/sC6yD9Jw+zUdBlQQqBwBv7HSSAy9Ls
	vS3Yri4xfngkP1oGfMSjWSKDyG8RwKAjMEkK1PFVOUXNh/bgsNXM9izvdrcsVvkRzmqBHhRiXyE
	DstYDikysDjvfBBTi2+xcQ7AkuI25mnwk2gjTzVuNVcO9wYPdPnWTCB+UCaRdRO4Vo9FZ+9fXzt
	MVfit5WkiQnVi0MNa7FmVYXMu+N4sCrPMx6QrFJY9sowmtvGvu0Y1Hhvcbz2VKrL8t6wnA+2vm+
	5jHN9EUPL3KFVgPM5A6DZw7eFaUnKjeFD4PKovf49Aldazzcg+s8hCBRMC1WZ4MDm3EI=
X-Received: by 2002:a05:6a21:4c16:b0:3dd:85a8:4c57 with SMTP id
 adf61e73a8af0-3e16be08b6fmr7486829637.30.1791827359557; Mon, 12 Oct 2026
 10:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009074244.3718-1-juny24602@gmail.com> <20261009074244.3718-3-juny24602@gmail.com>
In-Reply-To: <20261009074244.3718-3-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 12 Oct 2026 13:49:07 -0400
X-Gm-Features: AclHuK_YBZf1ri3NIcdgg7Xs_NZXFV2yTbwpgrbst429Dk2_CK6dEWVN6lKvZyg
Message-ID: <CADvbK_cxZLjVYKw40-A+=42pCJpx1m3Dtao1Bv7tx65X5yHZkQ@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] sctp: re-point retained control chunks on
 association migration
To: Jun Yang <juny24602@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	David Lee <david.lee@trailofbits.com>, Kyle Zeng <kylebot@openai.com>, 
	Jun Yang <junvyyang@tencent.com>, stable@kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:43=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrote=
:
>
> From: Jun Yang <junvyyang@tencent.com>
>
> sctp_sock_migrate() transfers DATA chunk ownership but leaves retained
> control chunks pointing at the old socket. A later retransmission can
> therefore access the socket after it has been freed.
>
> Extend the migration walk to cover retained control chunks and use
> sctp_control_set_owner_w() to assign their new owner. Reuse the DATA
> ownership check so each chunk is processed once per pass, even when it
> is reachable through multiple lists or retained pointers.
>
> Preserve a control chunk's existing authentication key across migration
> so its final release can still generate SCTP_AUTH_FREE_KEY when needed.
>
> Fixes: d04adf1b3551 ("sctp: reset owner sk for data chunks on out queues =
when migrating a sock")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Jun Yang <junvyyang@tencent.com>

Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.
