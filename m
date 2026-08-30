Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927F30FF31
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123127; cv=pass; b=FdfpqNJkN/A7TmJsCZo4VCDQKhE2wDzpiIBB5Es3YUarVyA16hWtd8WJMPSUEO9yZKAg/i6ITT7KvkSiyCzOop9KHz/ZukEIpkL6NLIAoo3tHCk1IPfinbfB/soEf80qodfPhnvRUPJs6eAf4r56QntFLqQDjBZwZmzlrs8a0Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123127; c=relaxed/simple;
	bh=AYjhl47EsIwn1DyL5gmpc8wtKBp5jDGTaUHfCK2SgJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPL72VZJ4RuN0W4iaMRie+zc5bJjycD9RTwa63hyhP+5AFD0RsRVPB2fkIbuTmJDIEyeglTNR5Qjqdxvyv8nmKlY703KpNPDvMKseQ9Rp6yiTFWOZh7C+E9YRoIeRxjrHu70+qMEJANcyZaTBV5fDlI1j4nJMWOhmxr6uvyHxE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/Fy4QX7; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/Fy4QX7"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a5f95a879cso8247a12.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 13:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788123124; cv=none;
        d=google.com; s=arc-20260327;
        b=Vrmh/5AHpBvzYXQKF1QBThSWmv2h21OxBhNQ8w9LM8wJH6CS2CRGa0QHy/NEwTkyHO
         Gh8yNxPkAU7VItCVC5EAM1k0A9uZhr0bC4K4UCJ0N2u5baZZwtNUJFoY1/6MBPrS1rJx
         c/d2ly/WFCWQlAagHrXolLv9qwWP1i9tYYQoMIGjwS568I4VV9oBQKzpH0AWVliAwUYu
         6tQvY+S2IHnRTsBebOZGjaZzUczW96g7Z6B3x1NthwmIBHx30et7LfntCF9kKVJ0AznJ
         sWly7jjiNgJ1RD3G0z2irnERHi95zY0kBD3UXzab+0DIQPHKcJ7B2r1gva7zsF+xhxYR
         1rmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYjhl47EsIwn1DyL5gmpc8wtKBp5jDGTaUHfCK2SgJ0=;
        fh=FT5uNrNTcCr7JVdsMPLdkyjjyGRkQmYB9mRo11PCoXc=;
        b=O4vMyoNni/toUGPnvjUDprGsCgnZ5lt+7oVjKXt+Hdls1LYO/5l/79Ly1mWW6MCNFA
         0hYEA6r0/A2GT0JFJNkBpP0DUh9Ci/W7DJ8eWpS0YyQxrnVKGNpLMW/5BOuereYpdJQa
         EvKAtj0fxe2CeNMIAAP/SzJ/zJA82mFF49cnfpR7mA1rkg6diG186qUrhIcCNzq4xA+U
         SbkU9bEQF9d1CYPGkBvZyKTc+fLwDJOMAQu0/hI4IczzUmz/dgD8DxpQ8uQUH8mAm5Nf
         zV9Xpyu72Ym3a2CQuZWnAbNf7gI+RRCtqMPqQoqGQwWxdquBm+RetPDFARntHjCAXvce
         +I0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788123124; x=1788727924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYjhl47EsIwn1DyL5gmpc8wtKBp5jDGTaUHfCK2SgJ0=;
        b=r/Fy4QX7ITrSC9mh4ISpwMhqu3ZZMZBpjsmiJ/bup7R88go4/YSnTewfLXnvVNPFcQ
         Xf4a8LH/x9S/r+UGeVDF8+3rnm654ZlWbXYGh0cYQrca4CIPlv2anlqD8HW0/EpFSp9j
         Um1trhjl2thJKxEWaWKf6hhBVKByqD3ahx8vPnhjLsre/n/0BuKtyveor99pvoSxVile
         QE749loy8Kv4lY289+wzZJ/KL2jeIJMANXoxX5XbNhEPl9SNUOU+Vq3ofPOLQItme62u
         Y668UQfr+sH6jFHUEGMPH0e1vFkN1D++wUPLurHsACyAERU/MO3tA3zYUFNrQhdYKWcK
         1H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123124; x=1788727924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYjhl47EsIwn1DyL5gmpc8wtKBp5jDGTaUHfCK2SgJ0=;
        b=AXv5uQzB0khPUyZOeCC+BFzrOBkMXHmWCbFapVx+AW6kajT3zOGGOQY+ooGEySFEps
         cBa1+dabN4Jz7KJtRyf0ThlpxrpUWrw4GQEdFtBIKJsIgOpkvZgfXTLuI4bqWvxSInS0
         hl4rHsTRKwqmCvYXJykID45oqo3C0olS6qAFyg/WTaVrWGPR2q7X2FfhAl1XsfkNeYp7
         OmiGftM8L8GclROZzEzlwfyeSRMqXf5GKyqcdQxg/mA3Z7chz6G7kjtzlURV54+HwZY6
         Tq4i84CpzWFx7djYXFg8pc4YBu82lsq/0MFfHpAkPVj82NVRWZSKIdItdS56V4SZIBMZ
         wzlg==
X-Forwarded-Encrypted: i=1; AKwUvBw3YI1/E6peiy+3FG+Ttup+HvD0lWNAcaYFLjcS2un/0+fjdaR5zaWdtEsKv+za4Fl12Q6o2Kw=@vger.kernel.org
X-Gm-Message-State: AFuF++mybq7XrYeHcwoztMk4vLXbK+Nrcp7AklYy7IGrxT98HibFWY3r
	W7AUV2rvjGxwdEQF3q6i0qR44RTQsIrKOMdzFa8DQhTg6IduThkdiMJc8Ja3GnRZRFIsP5ZDBIJ
	AAjzKCurFena0hak6NAGzJbsr+1tdZc9X5UNpjUfcUQpDCVvItR2yU4dl
X-Gm-Gg: AYBFou1EcECq1Fn8XRvV3WlAIsx42CP3XGsp4jGFr14Kzsm45MlbVidI8cQwdglloV5
	6QwGaggc7VR0TMcXqvMHZUuxD9TUBFgY3k2tvWunPjKKTEn1ww3NB8ruatFUdM7oQU6u2UoyBxN
	NQf6Dh1iEOR06gMmn5+glrljcQVajtk6qqfXiq6xYmwuV6NLY6UMffQh2GL7IPYJCQpWY9u8T7s
	27cl4qGZnBAABp7irbKGO98E68e4adQFXCAQlLTmdzrhwPvbdT8rjFsy/ke/S9Qwrz/crqwJQL7
	nbfS0+fRtd638208oS1qJpXBjbzeB4HEKWi7m4kokNc=
X-Received: by 2002:aa7:c4ef:0:b0:69c:39f5:7e36 with SMTP id
 4fb4d7f45d1cf-6a6334422ccmr20461a12.0.1788123122697; Sun, 30 Aug 2026
 13:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830142333.1741155-1-tristmd@gmail.com> <CAHS8izPvuOBx08kGEp+sFR-VjCa=Ta4Ub=EVb1kBP+ROZOMYnQ@mail.gmail.com>
In-Reply-To: <CAHS8izPvuOBx08kGEp+sFR-VjCa=Ta4Ub=EVb1kBP+ROZOMYnQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 30 Aug 2026 13:51:51 -0700
X-Gm-Features: AcwNN1UQs3VpoPc5tVAlx3mcW2vUdqnrQx3Tyi9lFFLFEIZgxoe0lirGis_pFI4
Message-ID: <CAHS8izMK_gXiyd=1XEJgSOD3Ybzdmet3ucggboyy2vAsWRFLsg@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: add missing permission check for bind-tx
To: Tristan Madani <tristmd@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 1:51=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Sun, Aug 30, 2026 at 7:23=E2=80=AFAM Tristan Madani <tristmd@gmail.com=
> wrote:
> >
> > From: Tristan Madani <tristan@talencesecurity.com>
> >
> > The bind-tx netlink command (NETDEV_CMD_BIND_TX) was introduced in comm=
it
> > 8802087d20c0 ("net: devmem: TCP tx netlink api") without any permission
> > flags in the netlink spec. As a result, the generated genl code does no=
t
> > enforce any capability check, allowing unprivileged users to bind
> > DMA-BUFs to network devices that support TX netmem.
> >
> > In contrast, the bind-rx command (NETDEV_CMD_BIND_RX) correctly require=
s
> > GENL_UNS_ADMIN_PERM (CAP_NET_ADMIN in the namespace's owning user
> > namespace). Both operations perform the same class of privileged DMA-BU=
F
> > binding, and bind-tx should require the same level of authorization.
> >
> > Add the uns-admin-perm flag to the bind-tx command in the netlink spec
> > and update the generated C code to enforce CAP_NET_ADMIN.
> >
> > Fixes: 8802087d20c0 ("net: devmem: TCP tx netlink api")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
>
> This is the second time some AI finds this 'bug'. It's intentional
> that rx needs permissions, and tx doesn't. rx bind takes ownership of
> an rx queue. tx does not.
>

It may be worth it to add a comment at this point for future AIs
reviewing the code.

--=20
Thanks,
Mina
