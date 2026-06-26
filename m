Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7B633BBBA
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506887; cv=pass; b=hbUH/s+Sih9ASgvOeB0hO5Wk+rEsC4VzndxsKouM+lh5yKqSpsPuai7wfPUvfKJLDPkAI2sZfZqxQi36Na4U7eV6nlzccvxzUv67vjDjzXB1bxOx14OO0KJ4YF1BBNxNMvWgRjsZHXxNvNWClNWIy50X3OPAFA18zcKGiBmnUHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506887; c=relaxed/simple;
	bh=KElP/Iy1UeyW/Da0/mMf8Kynq8HSdLhoCnepn/8wCxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT/+KtR9/H/xxrFeptR0MNIOOhK2pVVopp/qfBF+8o1Dqulyx2LrZoyqVxxrKPwifOnvOwOU35jsCubWpsgm+RSxrlpkJ6i1JQ+TX8RbNs0SOydDxwml5/mTn6o4TlRZmHuPKb9HGX7pAyLoYFjBAXAqYJTWEOkIz9nrJysMi8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qaaMTerd; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaaMTerd"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13981833e13so1829904c88.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 13:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782506885; cv=none;
        d=google.com; s=arc-20260327;
        b=cdTXxDOZ61Do6N6dqQJLBhV60HV8o2OpKTwH/Z8y9y5lBBKxIsjqxGvW+B7Nf7Ci2R
         ZhwQpwRmU6asF9Q+PiDAg314eUtv9Q1+WgrIyOBwpzfHSq3CTxXqrL8nZKrwzw3/mqJ4
         kG5EMNP3XIGeeoatWhPnwbojXM+3swGoQB6Tq++KP11L49qwnqhTf7vKPqNI/MEiJdv/
         2H2HZq4kZChwrqbwnuKVXH1ipgLsvXQRjak7zjGJZjboaJCUGkTr23IlGZ83nGmipeVu
         cBS2GJeIQ02rZymUDVQ99FCjP5dQP5KCxF9uAJ5DqABUVUDLJXk13KSVncSIdhBX/++E
         B0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KElP/Iy1UeyW/Da0/mMf8Kynq8HSdLhoCnepn/8wCxU=;
        fh=ybJ+B+d6mVHbGXWTP0zm/SXWEnnvogQiqHpPF1JvD2k=;
        b=gEvZ3CK9Xq8yh8We44rWIIhbj3dcOMaXhuQnw/+HR8nZGliQR26apdiv0WvQBq96jv
         Tj4d9+IrV2sBJFA7TO8c64B7z5oat4Y++Oioue1NTPm0igQJBWHRI114wLHn8o1NINnM
         THeAAJzq+suJm16FRXfD+AP7M0kEGesLdYraqn8kyiTyiy9adEcwUyHtkmV6KGpAxJ0U
         MGuFzi8esPzn8Eyc4K6Yl2SrfubnWfWpoL2/mFMBG2xWNc0PQ87P0dUo+DrhpGwrQOUW
         kfDetGJike/pleFNpEdiBjPog2147u0o2sx0MioRGfQqYZ922Pa+3IKxqeoQVDyb9tuF
         z6GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782506885; x=1783111685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KElP/Iy1UeyW/Da0/mMf8Kynq8HSdLhoCnepn/8wCxU=;
        b=qaaMTerdITfOXCEd0UTm4HJevvw/vs9CVVrNrzoqqKFBKsdWib1Iy5rGO1FJlCCBQ/
         f8ifRfrwrIWkHT3czl94uwHrch/1TChpngDeOQ7Z5d2JCZw2rBr0cN5OORxNrr211ucJ
         5iY/suWLSuQ7aKZQjtH2Dtrd7fvUaIIkZmLq6rXd0fcghA+rtzlkqF50mIDyW6hAqkd4
         +l2feFlUgYSUB8aWc3yeMD9wnesjOKc1BH2lb8nr+awjEAu0taUJIKg/kD0edNd9M7sC
         2lmaFrkSC5F8Y7/T8dgkwsrvH86ozYy1Qv0y+Fd2rWYs7VmabYYbrzvQS2+scDa/yhQs
         Yh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782506885; x=1783111685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KElP/Iy1UeyW/Da0/mMf8Kynq8HSdLhoCnepn/8wCxU=;
        b=li3s9qwg0mcMaFP+BTb/YAdn+2f8VGhsv9VFE3vrhNyRYGYxZW7fdqAq9y9BhVGunW
         s9kt/LXjx+elPZHRLqY3BErldUrZYmpvjeLXyHTWp5geSKwKFBITWu7eH0s7N5tTlUlv
         QaQCrhn01r9i9msWMFbSC3Tuxaf9C9C5ZSub7uzfvSK0zD2zb+3b/dKdOVAOuNLLXPd4
         YlmMA2GNh45jQ2hQVOjo3FRbXYhGnu7y7i+QCsPQz1mH9IKzMapvh1qVmsxCcWM8xUZ+
         l2RIxuuANxglTm9IBx9WaDKWwt90VME3PPEu7h4J875ajezocji63vUbsrDd5kf67RMP
         Xgjg==
X-Forwarded-Encrypted: i=1; AFNElJ/Tt/QpExXiU1tC5VyJHXc9sJKcVwejTVv735+BANczmcj9IzFEpyi0vlT1cJ4TlnBS1g7gFZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOE+r3ikLC6Vhwo4S5lYgpxwSu7+Nun+5FDzTNZKIZa6e1nIN
	CiRoeyGVL2VLWA3PRxluy+sDmXQELOBodLKMJBkwqh/P28NQABykxpvu1XYlQ23bBb4f2RTE1de
	ayGC6eoQJmaQyt5AsWYYVA9eFFQ0zNd3D3u4HTqmX
X-Gm-Gg: AfdE7ckt1+7EDCojZLrSKakAfBv05dBfi9wGc2ID6+yBhXSFUn1f7+QRkk+lDW0in3f
	66A1PpdcgRCqEz9s+H+P0UVlR9nV6zFKmBvgz2NZMlCkzCQ9OQGT4jZLVQ9DrJceB5cT68lzPU3
	kZSjfIJrQz+FTOgOOZZ28jFs09nJf0H2307tqkaFe/U7aM1OTo8g3eanSB76pQdtxFjbppNfKB8
	udYSGs2/6h4vEjJng5CUWID7y2EFDZnjnPRK0tShgLB8wgCbGp604WZbB6CC+RGq4yjZA/EhllH
	OXpzWM/b413sqf4K6E3f3JmlEtUi/ZLQXrQes+Y3o38N98Lw9RGZCdwMXIKqEn68v/1zDmBuCdg
	CgjCxhFSiGpjEcFYG3gBGkSx2elnt5r00WHipLSc=
X-Received: by 2002:a05:7022:5f14:b0:139:ed5d:7568 with SMTP id
 a92af1059eb24-139ed5d95c3mr689594c88.47.1782506884557; Fri, 26 Jun 2026
 13:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co> <20260626-sockmap-lookup-udp-leak-v2-2-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-2-7e7e201c951a@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 26 Jun 2026 13:47:51 -0700
X-Gm-Features: AVVi8CejzJHp_vEaY_FIRiYnk19hwrxgeyua0I2We0gP1Ictf7xHIFKUIkMHCdQ
Message-ID: <CAAVpQUCGpSWuei+cX9LL1WG=-14_FJU75G2njvvWCugsSMWDqQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/4] selftests/bpf: Ensure UDP sockets are bound
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:37=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> Update sockmap_basic tests to bind sockets before they are used. This
> accommodates the recent change in sockmap that rejects unbound UDP socket=
s.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

nit: this should be patch 1.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
