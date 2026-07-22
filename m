Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4E4334D0
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741847; cv=pass; b=kyaB1f+troD1IA/WXhoJBZ/Y/PiVpk4/RCUeHebJBHx+Uxz9UOHZGDoX6FtVWDldR3Qxy3ei3Alv5U6psa6/+iaI+iVDIKLWKjFHKLeWbH56Y/pTsdRjRllDVrYkb2ybf2c44tToqJUe9EVtqigrIf0U1e78+RThE/t1RTgocHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741847; c=relaxed/simple;
	bh=2YaGvSahkhYvJJeXrg0grDnzuLburS+MPL6TF8eN83Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJsKuKWul5+yRjthJM0k4+o7QQL8lPtj7VyJX2m4GCdjpvnDib6R4A8ZeGLHYTo7ykRawUOczwqikJF4NJZRV95fj/OUjwVlbBlW+F3rvldWvG9UtqHAiP2cRWVOX+VkWVQozEc6ZLV7JsXzWJlan7gEuYIex+zoG/8/ONFH+uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mASSLZrP; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mASSLZrP"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-848d21bbaffso365044b3a.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784741841; cv=none;
        d=google.com; s=arc-20260327;
        b=VCSQ3di0J6XvQ6OHCfAkMraK0sUKcWbKctevFf5YWZgTI466eZbRBCktVxif5qO74m
         yfLqqoxvBpj8K2YC4jaI41kS6oWFMuaVj+DOM4GpEmPRR6tMIoSWmvFnndi4LoAK4fsg
         x4AtyE0cuSaSyYwUsBBaeDQQjsFL+LIIljXpdlhhmZ6Qhb0829uNKU1qUh/FxlB9tEzl
         6XEQvqQ9iJFMcSlkYVNspNsEKZN+tROYTlXuHxdvyjypuDOrf35G2tBz5D0gNNdNtPeX
         InTWcw5M2w4JYsOKi7hSzOZFcWJ0opvdJUNI3TW8qtFCIZcyx5moJmoYwhtbsUMRLTLW
         gm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VEDltuycvPgxPShGpci6HVCtrtN6ph2YwVeiVOOXNSM=;
        fh=7qw51iZHnjdGejxQHp2ietF9GYtRpIyGyy8h9EYwxsw=;
        b=UK0dFEkW05JZ3ItliQ8FMVcYdDz2zh5wNS1YTxdrB7nNHBOYeljGtDGgrJ6YnV0UQC
         QAAqoMXxfy0swmQba+CJ8pjRZCHAlsBEvage4Sicp46nGzt9g5Rk374b+DV/88vbUi8b
         U5WwZGNiCWrjZW2MDZGSZ873hK4R6YEsTV2tSNlkJ4CD5nC4HwBjySF1+PhJAx0Q5Ou5
         dHNWXlnfNg8CHigM7r+jPtntQTnj7b/2Sxy4Y1HL5j4NmKaXVvvk/QJVgcBMjELwfNgt
         hGDw9RR1wxw+xenLuHdv8MZN//tDWzaqWYZ7n3/ypLIgPfTwoY8SA+RNrlR0b+/70L9d
         rGaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784741841; x=1785346641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VEDltuycvPgxPShGpci6HVCtrtN6ph2YwVeiVOOXNSM=;
        b=mASSLZrP1TaMQsEgyD2MId9Z/gJazfT1+/2etRXwYbWDKDrFz2GfiEHqRml+MmgsvY
         THpxA5X6tjF3kToqXM/zQXkKkyWwakup47K8tAys0Wdc+kdG/dcJG5XQV2VzMATcIwvK
         N9te9Kn/3++00HyINdffQLpVFY5MJht5GLOD5qglLD7niJvefBejWgQPwAM0ZOIHoHhK
         NV9+lO0MPLNe7B+qdltLKpNUgFLNwN+gtYDjbTWCISS+NFUqQL3dV0lTNUMLFjoM7iO2
         1nN21d9cwSlI9OCHwUXsDOQOHkK/gENW6ueT7riiJX6Rtsjqjyiup3fNZhOYHCqik1Gf
         G/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784741841; x=1785346641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEDltuycvPgxPShGpci6HVCtrtN6ph2YwVeiVOOXNSM=;
        b=eztKjMG3B6f11c8yRJsXQezEGYk1lpCRoucp+Ok+thXgb+BhdOXUt0GV5RFubL7KJT
         AZ0nYmk2bFwRTXDr71hLNfeQ2LBih1+gWjKw0YC1o3rZWCxzTAw43W45rLKPO/BAlxti
         jcgc8YesMIZTwQ+kGfi2vfgW7oC3uJBrM6REqljVa7gm1Ahz1aDMRBj6YlPANso66cbU
         aN3OzDizGp2zBF5c5ppON01dwK6Z0g4Nezvz4Rb1kWabaNbm7uAXVq51TcKeurKSyEcO
         OkVd//k39j1ef9LSaFc2bcj7SqPDWaL1UVZt7xl281CEnBChzHUsibn0LLp7neivW14O
         p6Rg==
X-Forwarded-Encrypted: i=1; AHgh+RpShjW0OoDaE/Sd465uHdSnwMfNJ8o0/f0GnoksM0cC8CWCIyFeZVRRs1U+Wu6uHuCUb2X9j44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/6jHy39OhGha1SQ1V3k2egsNll+JwUZV99SKw83Ys4D1iFa3
	mpMK4iFsKXwGHmQPxawzZGA7kSuc4Xx250Wn3yDV+ZbjDBkGfkdg62f44XZdLocNhlTnNYksXrl
	PHBUvTKJ6lSueWCd9wQ0IKoDPYO3Ivww=
X-Gm-Gg: AR+sD13vxOwnohHBl/S9LWpPi2jCTtRxgt2TCGeLLHHhT/1s5zFecivUqe5vvzAM1TN
	EGT+YhFy1ZZz3/AHRWXGAifDa//nMUsgTbCOMBYzI6hCZdiMQkI7dXW2K81YAgoiJftX83/OY1y
	5E4JY0g6xzeEPDaOeoDPA1kaU4KjKLigcmRnQVaCLfKVajbbWSDwpn3BdG+6BWxtmPM+sw/hm2m
	sZKX32yHb+/2inswKJvBt1zN7Aw+jfdPJOvGVmytpiryO1XY3Y6cVeu7Ic6Fc2TY4KB2V/QuKSI
	lw6YxgqWa0Qyupg5xamQz6rHANusfzpmgRbA67cpjVAhRZbKI+/2TzsbTDyEgSunO2p+JuA=
X-Received: by 2002:a05:6a00:c348:20b0:84c:5b65:efbc with SMTP id
 d2e1a72fcca58-84c5b65f28fmr10366500b3a.71.1784741841115; Wed, 22 Jul 2026
 10:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721015532.120157-1-l1138897701@163.com> <20260721015532.120157-2-l1138897701@163.com>
In-Reply-To: <20260721015532.120157-2-l1138897701@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 22 Jul 2026 13:37:09 -0400
X-Gm-Features: AUfX_myJ7H54zIEiR6KqyF35o03u0MYAnnFdtC3iQwdzI9JYw7vCan8qRWmR7V0
Message-ID: <CADvbK_cP69nhZJShW4_vVf1zsccTW_xQ1bGJnYwbhaLCLLsF6Q@mail.gmail.com>
Subject: Re: [PATCH v4 net] sctp: auth: verify auth requirement when
 auth_chunk is NULL
To: luoqing <l1138897701@163.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 9:56=E2=80=AFPM luoqing <l1138897701@163.com> wrote=
:
>
> From: Qing Luo <luoqing@kylinos.cn>
>
> sctp_auth_chunk_verify() returns true unconditionally when
> chunk->auth_chunk is NULL, silently skipping authentication.
> This is incorrect when:
>
> 1. skb_clone() failed in the BH receive path, leaving auth_chunk
>    NULL. In sctp_endpoint_bh_rcv() asoc is NULL for new
>    connections, so the early sctp_auth_recv_cid() check cannot
>    catch this.
>
> 2. No AUTH chunk precedes COOKIE-ECHO, so skb_clone() is never
>    called and auth_chunk remains NULL.
>
> Fix by checking sctp_auth_recv_cid() when auth_chunk is NULL:
> if authentication is required, return false to drop the chunk;
> otherwise continue normally.
>
> Fixes: bbd0d59809f9 ("[SCTP]: Implement the receive and verification of A=
UTH chunk")
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>
> ---
>  net/sctp/sm_statefuns.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index d23d935e128e..89ed618b1de3 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -642,7 +642,7 @@ static bool sctp_auth_chunk_verify(struct net *net, s=
truct sctp_chunk *chunk,
>         struct sctp_chunk auth;
>
>         if (!chunk->auth_chunk)
> -               return true;
> +               return !sctp_auth_recv_cid(chunk->chunk_hdr->type, asoc);
>
>         /* SCTP-AUTH:  auth_chunk pointer is only set when the cookie-ech=
o
>          * is supposed to be authenticated and we have to do delayed
> --
> 2.25.1
>
Acked-by: Xin Long <lucien.xin@gmail.com>
