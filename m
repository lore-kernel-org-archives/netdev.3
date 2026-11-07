Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794016995;
	b=2slYVd+2fuHb/uZi+QUaLPRwmSlUq2vCmxYHCnJ26y2swVlECmMKeaa20QEuGzshsIxq
	 Hnv/GAsfx3TZ7ca06u1iUSAqzf77IQHIz/XnhnsCWPzy/rEb8dnqds7JeOgSIAzI1L/Ng
	 A9RFApB/fs2t1pDNLWY74FLHVrcM5lhGHFHFeQJbNeOorw6VgirJ+RaLmqIMsl5Q8DKFy
	 05YRQRCC9nOTXR52VjksXR7nzLKJooGcjgxLd6AEYylfN2exbx4bAVs1KHEGNHwkJ8sc4
	 2rpe7G6ZUDTRjrVagI87WThePOQkdhpRxXPr/3a+PZVaLk6/u9ABmXHSE3wE5cCgKhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=uBvVdSJFRMwmcimjlEgQVos7C2jTDNbNYsRZ09W0EWg=;
	b=XiY8Zn9pFXpJvqDB0IzE1w/i4c22E88FitWZtrv36BPCgFdQ2l5J/YNA/g5n/Sst+NsA
	 a1KL/9UZHaXStLYtkucTqFG28D8EUXfU9LLSge4POApVlwO/SOc67RdNdy9CCJViXxrNr
	 JnNz1+C/X+E3WbkQQ0/6UYYX4e4vcFL+QHGgIHllSdV5e7NrGTk05DWRnpUq9Sg++Fvem
	 jTF9nNPgUQQ69CILy6jSaj90ErobOhNiC83Iynxx719sJp/g0Qp2V52Sw1s+JYURJUYM2
	 Vk0n++2DzR/gL8sD+UjeSOUO/TegebRXmB1wc8b+xQXuuC27Esymp9LLOOXmOqE2YUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYmNNCZ5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA3606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 02:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3EA3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYmNNCZ5
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53dda625f63so986253b6e.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 18:03:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794016994; cv=none;
        d=google.com; s=arc-20260327;
        b=XRbGKK23waE+t0zxLLkPUYOXQTbBnbMxyZvhTH+RaBh5beV/SsTigArBwam0Dxoq5m
         pTDxDalkmIG7olg2QcNCZUmc7wIB5RQ29ws2bfa2FkdEhyfHtp1cqhEuST9X9cEEVJ0I
         P+Y2Q3HoykuIqWV4D6ZCdsox1J6MSInORkMIhPuQkenucHRTqKVfhnPl7VW3FzelbbY5
         wsX5aByEygI4wCgb/1/8keWpwid7vs6x7dP0QfyweJ+RfF5m6LzPkForEx5TIKIyifhF
         UWRM12Ue2U+ZEyAblXwIWIrc34Ni5SRu1fuJrJRX0QbNXbLR6vhTKIRrBg/CcSE6rPdt
         Yvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uBvVdSJFRMwmcimjlEgQVos7C2jTDNbNYsRZ09W0EWg=;
        fh=apboHd9+R1dvvCkJdZDZKmUVNsbKVTk7ZyeK9b5N4V4=;
        b=I1d28Oxrog94IPpOHDQEIPuLs0rwK8CsfzYJh5SpYNf2y8NPyi47anhkjq5rIMqHSG
         j68mWI9bBpkMaJGXB1lbfgOisLnMAujajXQJAnVcWwJif0M8HbmLoll0GPc3qMcC1fJt
         vV7Tm9wYshbocY5HXp4XKIf7nUbE74UW5v54lIutgOAJ0PCkmvFocSx+slwh12WsUAYI
         FxDmS1+PD47yLIbeLPp8UYs0spd+Ru2gdWx/NXfb0IJeI06upJKsfoHpZ/830b0kKViR
         UmdBX6Oqg6zuPD2QlyZvScJI2xF33A7r02e+sYVnuG4U1l79l04eRlObWFSQvAJDQT0G
         45Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794016994; x=1794621794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uBvVdSJFRMwmcimjlEgQVos7C2jTDNbNYsRZ09W0EWg=;
        b=qYmNNCZ5NqWdPMJP4+WM7EmgiouVGnh02yTLr0djfb8MbKlCc0yCiEYt51b8f4frXZ
         BmBfsn+8/kP6jX9RM2fvk3nyVEoYQ8F5stUxHs4+OEFeiOUZUOv/qCGymZV5QFadXaag
         96if04qj5BaEEd8QoUpl8lFXGLaYfC87Zv9mh9iP1jW3pG+ZewEjbxgMlDd0mqPFnnLx
         O6Z52+NXdR/QD4Rx1e7YyUwP1PDOySI9XLX2BPx6jZE7AINSs3oRyDsCwiyO5+Etbmdq
         RHjGhRHlSoCWPDrKo3IfZB8l3CdQQEHnDAbL3KP8bp4pBrdIJMV+GbMGQXAr4Ls6MdMZ
         iEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794016994; x=1794621794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uBvVdSJFRMwmcimjlEgQVos7C2jTDNbNYsRZ09W0EWg=;
        b=mc8DtPElq7fGSyrb3cBbLryEuzKVPbzjwTJZtquwiFEXhJsVQR1zK1G05/8bRB6v5e
         y263txrSMbkZgPmvpg8/+CAZ/uSsHJRJwLBxBBIwiuqGb4ytkGWmKJNIogFL7sxzf0br
         hkuBubXQF+wNtGEujmp6OP+8ajQcKLF2H2EKq8Yi189bsOxlub8oYqvXwOFoMDIPulcf
         mBZ1Tck/PxrkAMI7rNNNhWJvnjKgOVC5AibM3DPYuBa51NW7Ttt+P7+01EAyPl1pe441
         fg8uoCQE5XvU9zAKIAneFpJx19qu71V3B/YJg2rql+OMqei7bUSmMqgzx6X5wGs/+aWD
         jb4A==
X-Gm-Message-State: APuU4Z83eSn/i2AibvLVUhN9Jx/idnv9QyRXrvKQLKwBAsFzqjGveKce
	c6+RldM+B8RUAAWXDujaGz5Lj4S2p53nYqpQnSB7rQXKcEokDwVu3k8Izb652tvB4t7W4+Y++WV
	Tc+jt6hqFLHhfc0qrE5sYXZOX4qbZ/bH4Fv/YZwU=
X-Gm-Gg: AYBFou1/ZmVsTEdjZP8dNrA0zF+RW1SheCh/GjcJZ6IqygkJHVdDLUXbTOjiyyruW4x
	iOPess+UQW8oxWhuZzD1VvdZWDzMCyJ5W4p4yZh5dS9sbHZ2TbEqb3WLE/EiFPv+coj0LcfZtoi
	slIT/DtVEJWcQbShBrGAN8BcLnpQcmO9qZggsNSlHcn38YJI8JVKCf9FPx2qKasmnpKd7I3e3mR
	dep4GYklzyhKAg14n16mIxTiBrLm5cwyN5b6KvzJAnMMAvfi1+A2OYVTKs2UXgf4Kq/oXGQJ8pr
	SPzTadS9cBMg8GlOUYPSan8+NBvFThcMvaMA6lebGLtAKWmuettCnGc9y5peE2Fa3gyEtAbgz92
	avSA/jKBRiczPrRb3sbZvDkzwA8zSj1LhVwwuRyHKuW0G1RxSdUZ8qofmzY9JvFBo0x3N6yk=
X-Received: by 2002:a05:6808:1506:b0:4b9:e65b:8c30 with SMTP id
 5614622812f47-567e154aeecmr3107364b6e.30.1794016993742; Fri, 06 Nov 2026
 18:03:13 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107015447.335056-1-mmyangfl@gmail.com> <179401683893.488859.14756679871319417849@kernel.org>
In-Reply-To: <179401683893.488859.14756679871319417849@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Sat, 7 Nov 2026 10:02:36 +0800
X-Gm-Features: AclHuK8qmYKV9rGbhU5WORYEBGRTBaOnxnVUQ4immJpreIZflrHaqZuZv3O6ShA
Message-ID: <CAAXyoMPY8QEdrpKEdvB4ceZQkikDHoJdERd1eWcO6E+8bVfS3g@mail.gmail.com>
Subject: Re: [PATCH net v3] net: dsa: motorcomm: Prevent rx_bytes/tx_bytes underflow
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 10:00=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

code inspection only
