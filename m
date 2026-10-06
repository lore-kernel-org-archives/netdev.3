Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924A3EC81C
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288908; cv=pass; b=G/eA/2c01IduHbgMLoZPtfdBuMxuaKCwsgZO/KfMJBV3ddBfmqF6rht3r7lTCRI1UMnZv/usZ+yN1g2KBKtBICp2gLlSWH+5QE0WOv7jkmhvR65UjkiDHh0PSZOPRGw3gkE+0KQFdQpgkqf3qkQVXAeLnjwLI8mapmDtYwFYFnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288908; c=relaxed/simple;
	bh=20SoLCTlUosZH3gg7t5ypYAOftvZZuBui2tmg5aXxP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK6fd8P5PKsbZF5/HAQTB0503ccvqO1K0pmAjZsrzlIQ1Vlyv7a75IG+XRhnJvXPNEFbieW20QvVfM4U6NMGex4wAV8bfpcE97EQHvrk23dJ9K0cTyRBtk8mXqs26GiwztdeQr7ZPf2NiRoHIRDj9o9kNROq9LAb4kAhx6GGa28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gd+rM08t; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gd+rM08t"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-881269371acso287584b3a.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 05:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791288906; cv=none;
        d=google.com; s=arc-20260327;
        b=MLq+VuNAInm0eMMiafAXFGRHGNY1ogY8gUSlQIcZ7hPpCQsp6CDMSobNVi+AWVBACZ
         W9EkuF16/baZwrGtroDNPKccLOuo50mVCy1yFPvnkR/mSPnumZZOHCq/NubViwSugG5u
         mPUJYlww3s/u1jwIZKhN8KhDUJxh4wAM6uPBJffTsOEuWRYIcBoWp59g9RX290voA5wY
         NwVpuvpbrjJ1NwEbY+RLp9ZSf/n8ArUwpGRAgeteP1nGX1YSGI5VHbSlq9RqsyHkKCrP
         Qj9UhXP2L25s2iJoScjXciEh/ePT9f3jIeTvQGGDVjSc5X0PdJJ28nrncU37FZkAyypg
         SeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhU5kMp1rxGMciu/YZ1tuWYg/j9SOf7ZmdFtxjzJ6YM=;
        fh=DXT9q+464Wyw7HxLu+KHMfVq4JaicOvTzz1/Gsy6DyI=;
        b=qZzDft+1gxaoY6Na6ojW+YVY9hD3/OYjmZ74j4RrkGhssDl7yXBnBN0ixVz/WnzxF8
         OLiynND6bk46ESKRBzWn74+dS1ELhRSOQFf9MiYtQJ9w3Qu68tUYqKHgLQAM2gtk2EJg
         /a9rHZFVMbfr2hz3+1+N3Rw6xteCzmjMvb4Tp6NBIo2kEL+FwzxbVBhgN4R7Gs3p/5eL
         XqoK9HR7BKSjQ7neLR8qBpREayrqHwmmIVlPLtIYQGB0draG/dr7smyaMWC+DEqad/cE
         94lN0SvlNkcTVI4yyL42g0e15z3qmokfMULpuSidvVc0sBiMu6i6YhLX01o/yhIdHroM
         wzkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791288906; x=1791893706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hhU5kMp1rxGMciu/YZ1tuWYg/j9SOf7ZmdFtxjzJ6YM=;
        b=Gd+rM08thoFmZVQsnxAwprenjbH0SYu18KM8fEyZ0sBh0rXCK7d7SiBMrE19MMoOsh
         hpz9SL3g1RbTJoXWYKTQXwhCY/gVs9xzpEt//LL9ObB5XLlLEg+govE7cZHs3b1iVL23
         f4SRZvH3Uq0pdAyZr6JxtvY9wS4lEQ19ofVanydHry/DcVrCMop0Xyrhvze7cQw1d4f7
         qbpU+wQk3L3Patl7MKlBTbPCmKWYzVWo3V29JWDQZV/l0o6BGjiTrKc/8nrns1bzHsBT
         +91vXgEIytdN87qyxJSm/HMb8fn6fuAKh6oGPG8GpRXxMdxNWFUT9X9SM2CkbPBmB0/k
         P1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791288906; x=1791893706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhU5kMp1rxGMciu/YZ1tuWYg/j9SOf7ZmdFtxjzJ6YM=;
        b=ty1HWz6784HFc0oP6Mc0/QX9YxvhcfeYH6eKkz9EJxCCf5FL7HuqmTESIVoV318uR7
         bbckd5ar3UlQQmn1tIS8pJK6sPqwe3wqoHJMs95gVNVkEQOpzDLHQrJjgJHFaModPV67
         tphizZNnFkXmbCBGeNV1Ke5knQ0A+Bt2Z4NlsLgpoyOzf3VleLk/oF6IG5ePtmqYAliE
         RdiYZFT+w6pl14nlxnUJgHQBtpuJViTj3q3056wqS8XUsqK+/D+bbSms9Bn08j3h6j2y
         H8+lCagb2BEvfCpAFvQ59xZ3k4GJikvOK2bsqjOLBdWomPdnLhjJnkb+2XfCedKaKvJ2
         YaZw==
X-Forwarded-Encrypted: i=1; AKwUvBz/uD3/D9yAsC/iKAhE5YVZOn2X4fzQz5bwTy4p1PpLW9x06YLxeQ3azDdbbTA95K5Mv2vL3+s=@vger.kernel.org
X-Gm-Message-State: AFuF++mC3VJkJCXiG2JG4whA+KtBlNBb9fxn8NIDhLHTtko/ZLx2AfMt
	s+jTS5FlQfExqOVb+Run0sWRRfm0fOjzsRVijsV3m7xRj84765Miu/a5ZDlZKCo1YW03mFGYv0H
	6psFosJBFIbXeiMia61yFzCO68QzCNuOuvMOX942p
X-Gm-Gg: AYBFou214PRhxYuFIQXLOO7+7j2XeUzb+0tQ/nEO3kdLrD0W8Cul+DqlCD0n5kD3Vnh
	9D278WciTLYZJEUQPu41Btr/mxr6QbJkUcb4vBpGlyvTcP9KukY5lMJU60H9PFLmgjwSSylE9oO
	U4fLFHzLyNTp3cn+O56Oty8mnYAm614mG/kxa6zgWD04qnFhSoqOeBi6bEk38dcdT8VA5kEWaWV
	KkPM8+Hb4OtxOLpIV33HySqNsFcpfdhctTsbeNpXa4a/+CR7CBHSM74CQawwPotYsoYAijX6hWl
	zEWLj02/liaJBTNYWnrzBGIa5//F8v01xfasy0qpaydVwfjNr0XEoUx6wFMjfJRZf4y2dPPH+4O
	Ix5nxwy3N
X-Received: by 2002:a05:6a21:8284:b0:3e1:2422:1d4b with SMTP id
 adf61e73a8af0-3e124221e5cmr890709637.36.1791288906570; Tue, 06 Oct 2026
 05:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006035108.3101440-1-4ncienth@gmail.com>
In-Reply-To: <20261006035108.3101440-1-4ncienth@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Oct 2026 08:14:53 -0400
X-Gm-Features: AclHuK-0rgBX0Rc-BZAEtLzd-Bv2KqLRMjK2L8kmkoDKLlRupZOtGrn3yq5-x8I
Message-ID: <CAHC9VhT1upbG7_0pB6KTZyBEbycbdkaWCw=-rYARmkmBF519ZA@mail.gmail.com>
Subject: Re: [PATCH net v2] cipso: adjust cached option offsets when removing CIPSO
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 11:51=E2=80=AFPM Daehyeon Ko <4ncienth@gmail.com> wr=
ote:
>
> cipso_v4_skbuff_delattr() removes the CIPSO bytes but does not adjust
> cached offsets for options that follow them.
>
> For example, with a valid 10-byte CIPSO option followed by a seven-byte
> RR option, parsing records rr at offset 30.  Removing CIPSO moves RR to
> offset 20, while the cached offset remains 30.  Consumers such as
> ip_forward_options() and __ip_options_echo() then access the wrong bytes;
> the latter may interpret packet data as the option length and copy it int=
o
> fixed-size option storage.
>
> Mirror cipso_v4_delopt() and subtract cipso_len from the srr, rr, ts and
> router_alert offsets when they follow CIPSO.  cipso_len is the distance
> the first memmove() shifts those options.  The later header move and
> network-header reset relocate the bytes and their offset base together.
>
> Fixes: 89aa3619d141 ("cipso: make cipso_v4_skbuff_delattr() fully remove =
the CIPSO options")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> Changes in v2:
> - Replace the parser-invalid 8-byte example with a valid 10-byte one.
> - Move the offset updates beside the other option metadata updates.
>
> Link: https://lore.kernel.org/netdev/20260930140400.2955466-1-4ncienth@gm=
ail.com/
>
>  net/ipv4/cipso_ipv4.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
