Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A42BE639
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791416209; cv=pass; b=q09i9YdyGgoyfhVjVmmh5cXAApMiUE0eEInOvuxLODhppjQG4CdNYwB9bcXpzswHERTAEFVVe81xMJH/vPUXylBQcjC4mETTjzlFNOw+NThbWISWau4PfweOufqjugttiChq5X662q9QIaIJKJClqUW0sBUdUN1qPiTF3QqZZvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791416209; c=relaxed/simple;
	bh=YW7ppVeoRLVQCLnGvfkZ3DPxaXrIg4n4TYyY9tNYUuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRrxfFrSlizar7jHSVSsvS+rjBI1AxEcL7iumSUkkueKHpeb7leTeylMmIR2OouscaHGMxLUNTa1mIES6kWRPFhZInV2WMhU4YBFAzAxm1Yy+6d9WVZMsb1bqz5xd7G+QDY0fpjJKRcPpHp3rjJ+ehpUOJVFPzr7a/++5T/5X1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSXDPnFz; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSXDPnFz"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-677bf06de21so4552643d50.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 16:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791416206; cv=none;
        d=google.com; s=arc-20260327;
        b=ZyUN4TA/P+a5FltirM+JnXEpUh6AAo5BdRNYE4u4uGRcAflBM9rKVeV2cvrCf99+Dd
         FscDuxlsJJCqz3CFkOW9mM0D1v/Wfmp/OX8UjJJ2uoz06m4IyhtP2s78puOWedQRVkEc
         xSYTFIYeNGizw0e3gbpOXVzN0UpvByDtk3VPuFCH6UZvjaxIfgcFQA/bRoWkMiwHjGmm
         tvE8PitaY/UQe5oRyCbXwhnq6iFs2vQx6tPo6qu3SAK0+RveejVQ2elqcOWeYU2etV4T
         /0rFAP3IMi2ghrh4wcff9jgo1EZRcnVSiROkSxB9CjfCeANSaGEWfkTSHehqpKiMd+ju
         m/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YW7ppVeoRLVQCLnGvfkZ3DPxaXrIg4n4TYyY9tNYUuU=;
        fh=E/oLRROGr8rl83+936lMngF+qbYTPVrgxnG015hGaWg=;
        b=bBFgJt8PflBoL/3NtHjOqjnnyjGV2v+tmQ8nSsKzbE4OuW1xRZbXmaTulKTlxfx7xW
         qAmDsgDdDjWg6sVxqI00i/OIAXmbFnIXwhmJhv/CEoQIeTY0MHMUqWL43NnSMoUoRz0a
         jvN6opS7hRwxuw0ZXrCIjG9ru4J2Tjv04xxyy1oytvrZ4rlRwnEirCZsHkBQ93PbG+j3
         ykq+Us6OWLHM2pTQCL9+x0wF6JDR6FdDyY949pt4iKdhV/4KLQknnm4c2n8TycZG+oxU
         S0ueyTNWzD10aH/utDj9Mi9q2QKa+CzO61fJ+VhcoUOICThFh/+ebPN/OohgOteXh7ds
         KIkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791416206; x=1792021006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YW7ppVeoRLVQCLnGvfkZ3DPxaXrIg4n4TYyY9tNYUuU=;
        b=qSXDPnFzOgu1X/v4N/tt4GN26skSKHLDR0E0tu7JR5k8wGhuC8zYDK2vhdNvk88i1A
         I+Xyx6+Dh+AhvMnUF7ulNkD3qLEfXCV1xPEmVAkRRBrHsAdn9fecAo+HoGop13Yr1mwJ
         wHHO7dqerVtI8ScFlq4mhdTKxthUvVYEVk0zHQz9beaEkWuB0T5h59+7b3xmkFanfK02
         4N9iGuNMwiXgTs2lG8t7AOe6muH9E9eLWRr5hzPDCdb9qx/OnV/tgiBzWweGmUuiSObK
         +GoXxtqqdIXOYahnOCJlS7vENi204Ob+SsyBFzoZoRMPQbeLf8AH9XZSjgPWK6s1yuf5
         ARdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791416206; x=1792021006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YW7ppVeoRLVQCLnGvfkZ3DPxaXrIg4n4TYyY9tNYUuU=;
        b=e4dzsMb5aZ4h6WAEMLu9zlLp+NMNYcd9XqiJbEF01cy+MgZM4w068/QSx0oeL6gfXP
         z+zkm7t1swt9SVg0jpaLlp7Ts6I9SC1hEhSdks2yvOlGxlH8Nfui5sRUYGiITQNOpzIV
         o8g1OwxJeJXiuVNI6C0QLqjje6UVmJBs2qe4OqOeIuSZIBkRCWwsHPjFnmBdABeC64iD
         NwPlyf6ZD/aIzm10OFJ5+5v0wPzyxxoU08fa1Qqbl+y41mfgp3+Hl0j3Z465PuvjUG8c
         /PR4BV8PuJW74xXrZzFMZiEFfGvarA16aVv+hHoS7kEcmD3uxVt2kjw7F5dnU2mrrOax
         a1GA==
X-Forwarded-Encrypted: i=1; AKwUvBwhoy5QIZHGnZEHSI7VZBOwG5HF/75VOVoN+t4hOX0w1GQQ8e8mmGLnM5bPn0bzZhx9r7PtIoI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX4sT7qCz+9g/ctppJf+n4edhL73mlQBxRvmZR7U68ZbJp0Fxn
	00htJN7N4/quy2IedZ1Q2snUm0CcrPxl8EFUlNrKBlsG8/9+NNyhe0MT030az1UThD09yKn8m1I
	hbNKNUlA8ne43MOgfGI838FxpYICabkc=
X-Gm-Gg: AYBFou0DxBGOH6R3ixwUvXm1KF+i+XdAkBG7uHiGIMw4rUBZXFuTh81rWHYHnqQWugl
	Ptgyr1+cwklxD4J8S/FtIsa7bT3qUU4DOUgheKPqd2NC/898HvMXi2P7Wi60TVqKWRp6iVgF4Pn
	JxuvB9P+AJEnPAiYlax7nj10ZmwfW8gHHmOgOesIqpJ6mlf22nB7UA1vlgaHuW2K81Lbatz+Cj5
	1D4g4BuImh+nZo9uap8mKeFHcHlLHKMlJz1HDUezINMo5HmazHPlOF7dLj2JISwIWcW51RxuS2I
	+dfrWlBCY5EC2GTwr237aa4crp/F5nDCfQX/lYsbf5eqJRZuAaxJSqFS4f0+P/1oXy4G9fN+jJR
	qrAvgX5OkilF0XKM01D1hLgQBP+OMX4xIBi3xxH+BrGXTvxo049H4+OlDPvbNmtWlluHpHVOY2R
	k=
X-Received: by 2002:a05:690e:4853:b0:677:c24d:ebfa with SMTP id
 956f58d0204a3-6790a3eaa26mr994855d50.58.1791416206358; Wed, 07 Oct 2026
 16:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a012b4923e189c4c593ef4f471e5ff0edbe9030.1791412497.git.mst@redhat.com>
In-Reply-To: <0a012b4923e189c4c593ef4f471e5ff0edbe9030.1791412497.git.mst@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Oct 2026 19:36:09 -0400
X-Gm-Features: AclHuK9jyyf5sYugVmTQQFcLaa4pyEtdizNnLZGPpZtB9PsCE0-Mfu-D4Td6hn0
Message-ID: <CAF=yD-L_sv90qxUxEh6HRrz3mHMRP=WK3smkMMYScLAnJbgTpA@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: validate checksum_start before completing checksum
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 6:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> If a packet with bad checksum metadata gets into the ipv4 stack,
> skb_checksum_help can corrupt the network header and cause a bunch of
> mischief.
>
> This was discovered and reported by Paulos, and has been reporoduced

(minor) typo: reproduced

> by others independently since.
>
> We really shouldn't allow such packets in, but as a defence
> in depth measure, let's also check before we complete the checksum.
>
> A more complete validation at input is forthcoming, but needs more work.
>
> Assisted-by: LLM
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Fixes: bfd5f4a3d605 ("packet: Add GSO/csum offload support.")
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo=
@gmail.com/
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Cc: stable@vger.kernel.org

Reviewed-by: Willem de Bruijn <willemb@google.com>

One point about sending as a single patch touching five separate
modules: nf_br_ip_fragment was only introduced in Linux 5.3.
Such a block is probably easily dropped from a stable backport.
A single patch is likely still preferable over splitting into two
(core + optional) or even five (one per module) patches.

> ---
>
> Lightly tested.

Tested by me as well and found to block the known bad input.

Touching five modules is not ideal, but could not find any other
approach that would be preferable: low risk of unintended
consequences, out of the hot path, and relatively concise.
