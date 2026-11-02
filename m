Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793597718;
	b=W04qJXRgSu1AHDGHQpB6ixMIeS4H1vWYLWKriYMx2sBgIorzZBaz6Oo+D3LozakaXFQ3
	 PaTzRauKTyfDoN3gDHoOTjgGj31qjtLZJz+eyIju031qEOJ+VyJGEiukga90cqiE/9u47
	 +JQceF+rSBnHEmAmAgIiviVOklpbRpFHO2JCYuhKvpSiVGt+uTlpNEpEJAvcArdEU161Q
	 BahxcIJtWuFodnz7hwEP7zkOfZkOG2X+FCmEMX3da35iDYZ460HbXAqzHskXoSeA62zfE
	 D4wqxpY/gnslQ173IhiYwq9qPoR2c4oYZvDbFkpfU4WxtZr04Od0vhRQAMMYMXE2NSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793597718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=W+hC4F4hAwm9joqKZ+fH9u/y7V0gzk8Wl/nmjTnVbjo=;
	b=orOXae7vgY5OUWyDNCpddmFZqRi4O6OGrl8ssuAy5jy1MhFietd4YqM0V3o3gwPWEqK0
	 4NficRTpD0XfTk/vytcrK/kk35f0ziEtC4slNMXxZ4F3LC0GiUE97+mEwQDrnUysn+LHx
	 S/wjvfcuyuuCpzNgnI6kZb5tvtcesBOCdVmjGhQf6peQYdcIiadi9XNaFoOMYu8qhQazP
	 91b9uppLxwfwJOk7W0snK9O8Jf8uML3kng2825ifYk8P3OKt28YZCF1oWnXct7eWTsaI6
	 tReXMh3vunFo6IIIgDCL2cUc6P1Ctmz/BDh+Wdoo+MmGtaDQeC0hOICUuLS5CkrTBIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gfRtvORV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AE606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 05:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C4AE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gfRtvORV
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1ae7fc5681dso4282c88.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 21:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793597718; cv=none;
        d=google.com; s=arc-20260327;
        b=Ys1Y8DXJw5uAD+0l4eM7eyPCv2l7E8OExZHP2Eu7jZr5cC1X6TKLjjC+WdDsJtK1rt
         i4hki+RqSwF0CKMb6fbvR1B+ABkUt8XN4E8XvlkWh65FiFFzY85BqN1e50vGU7QKL/qF
         6SgyjsRGB6bMn3zwk7y+DK4qOG6bYIoeIOh1yA1eCoeCi12Iqxi0F1Tad+va152wzoh2
         f3y6CFzSjcJSXrt4uI/b2p9WlZN4549ekc+/t4IuMW9uEjmNMs21ZzOfthYH5ZKR/iQu
         sZGNhnARC0qPywMz71wRbxWXzkoldDKpk9Fp7bU0cjeCYxn52gzCBKGLuYVhu+HK1u2H
         NFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W+hC4F4hAwm9joqKZ+fH9u/y7V0gzk8Wl/nmjTnVbjo=;
        fh=zI4lTI41gBRYVT+U1Z7dZ11rdTX9gzbpOcPVV3PQ/DU=;
        b=Q+FmwZYYJIH1v0ahJhj5DwWdDMJjeBryvHPeWOt3YUG0N3IzTZjBLaiq01wOY7EIoU
         WuImtR4IofCdyaqvXk1azQiQEEyrRssegaxnkIiAFbJ+L4Hael5gxdy+ixKw/NAbL4DW
         1okeslFx7L3YEIKIteV7jK27rll1qgobKhjE411eq6eCoggN379hRBXy6dg2DBR+cm8K
         5t5+vsoKZmv23Du8CZq08W7vRXPR9hgWPyVG8nbxsBP6DlizJJU+ybQ/NRgQxw0I7+xt
         5JfwGgFwjH6gNBYSRKz2NPUc3ckE9bxuZbi36134hfPqcG+WdGGjrd0uhT7KEMHmzT6A
         g5TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793597718; x=1794202518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W+hC4F4hAwm9joqKZ+fH9u/y7V0gzk8Wl/nmjTnVbjo=;
        b=gfRtvORVMla4nCBA+g1KRdGm5xy2G7i82zYfxIC7+MGS0ahIMJw5JiKT9JWIXkC1tg
         8b/PHZNBpPoZkQ+obXIaft4EJT4wp/aay3pkTQ9lii/Wf89lli9Y8f5kLXCLw2iPKUS0
         95vLNFULVmA75kI2rXr7AvEtdNCxPnF3OOtvJT3xxUXbFxJgZMzNH1AqrqGXdEmyjXnC
         5FkLZabGbUxMjxtJtNHu5aQM9j0sa3SpR2wY3XQV94jk/lGlCkYFJfBt2Ag1TUzRzI90
         xJaf22bOnYtQpulm09ttHnuLwCSXnmbcqtfmY0rkmw5bs8u/pNfZGmvUCH/wcrRWpgYE
         WSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793597718; x=1794202518;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+hC4F4hAwm9joqKZ+fH9u/y7V0gzk8Wl/nmjTnVbjo=;
        b=Z7O9DCj9Ee9gAx9RNNrWjJ0cQZYpaTlUqCD/robB5Oa8vieuCVoMlgUUHl3e+Elb28
         AazIj2Ko80e2jyjnta0PysBl8SFF4BWKPpg8GTuKljL1lOOmlfeH7Er1V6Yv/Lj8R7sx
         cTWjbCmlvhvNreK42x/6g7zn0D0gsSEwtLTRXMhx6FhjSX4jPHIRB7XXRQ8WrqKUfeEF
         c8wDEn3+JH6sg6XJIDnb0Q4zzM5/Tx+3o+/Mh+hSKuajJx+AMRFTpVpL5rN8/7IR9vs1
         2Vt8gTAERmlxjXALutPg+SBRmIDwZatoo3ZZ6uz5yvWud7MUntTBWrWAFlm54vQkVCiL
         yuXw==
X-Gm-Message-State: AFq9FYKZvvOYxrqB0RL72RxWkcRSxJyXhJpK1LyC0za75U5u9meoYQVT
	iry3ndsPxNqBbCwklNLU5A9rTAwnV0muLrCpjhElNGy49/lC2pSlXF2xLRyafVPcTY6HrWg5x4m
	qY4GVnbrqUPgkziVMbNrCCjNtN6ZBnnPpoOrjSiBo
X-Gm-Gg: AYBFou3V1yhA9lOSw9tr4x0jbWwfwb0Ahg6yI2hhOXdqr8BT3vL/xTRbnjNxaSu2XA1
	jqNIRmhNr+CgHPnM5wp/8vfymulsEgmgDP20EGFOLX5W2sP7ZIgLgRsXMx8PI7LsyAMM1yyRfDY
	SkH+CnzoBtKE8XBXHuHQmmfHrEFrydEbrtYKFnvUVqBgRnjKmBuj/5hlQRqq6lEVh1Erj8SpEzt
	J1M0xNd5nmU6y0gEVeZdctihOxxk4uYEU0ijN/g1UkvdA6NN1ZFdcJ71nAx1+y28Xc0UD2AlY8p
	v3YOJllJ81UBhRv4A/qeKTqxYCPNWYvrVYc01NhcFgny9zCoxVS8MtwszGad2CMZRCyvdU233ON
	NeNmTF+IC6NaZ9VVNEETi1Va4AuOQ4Z0ZmnE0srBkvUtBD+RT05Axowx+iIIrzuEMy7ZBTxQ=
X-Received: by 2002:a05:7022:7f0a:b0:149:8916:defc with SMTP id
 a92af1059eb24-1a9546390a4mr1658978c88.0.1793597716672; Sun, 01 Nov 2026
 21:35:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101075145.698399-1-sgzhang@google.com> <audwphXNeZhVItS0@google.com>
In-Reply-To: <audwphXNeZhVItS0@google.com>
From: Ray Zhang <sgzhang@google.com>
Date: Sun, 1 Nov 2026 21:35:05 -0800
X-Gm-Features: AclHuK9nicuZoXvOoxzdD_K3_bDawbdxZQ3_9KfsA-zXkExzJY5UTfRe7i8Lwvw
Message-ID: <CAPqVEODgo=mr+3viog+bY1XOKHLcrEVhs4CtZ-SiSYT4Hh+gjg@mail.gmail.com>
Subject: Re: [PATCH net] net: count last skb of each sk_backlog pass in __release_sock()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Decotigny <decot@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 9:15=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Sun, 01 Nov 2026 00:51:45 -0700, Ray Zhang wrote:
> > Running 500 concurrent TCPv6 streams (neper "tcp_stream -6 -T 1 -F 500"=
)
> > on a 2-core Cortex-A53 (CONFIG_PREEMPT_NONE=3Dy, HZ=3D1000, LATENCY_WAR=
N)
>
> I guess you tested it on 6.18, but note that CONFIG_PREEMPT_NONE
> is no longer selectable on arm64 since 7dadeaa6e851.

Right, we hit and tested this on 6.18 -- thanks for pointing out
7dadeaa6e851 and for the review!

On mainline, cond_resched() in __release_sock() still applies to
!ARCH_HAS_PREEMPT_LAZY configs (e.g. CONFIG_PREEMPT_VOLUNTARY on
32-bit arm/mips/sparc, or CONFIG_PREEMPT_NONE with ARCH_NO_PREEMPT),
and landing it in net lets 6.18.y stable backport it cleanly.
