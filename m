Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792534217;
	b=yvDtP6KA1apuY60DwIZGBPamEBUAxZknP5D5VT2MFUee095PzztCwtb3PiZGwcmsSpXh
	 NG0ERZnSoY3k+TaTOd0bUsTp1VXRaoYuK4JmbhNBq9NpzGH5SBiuupmlTzQBGj93bFlig
	 ZlAmHW7lLb3D0P9UUfFAVvkqo7GZ0XUI7s+RAfTmClfYZWDOYIQRLOQ1TMZfAiKVtOT0/
	 dE1J06kTuzd20BlLGkXa+mSZpugyV6mBeSoF3KdRIxLWs9RyGjUaqRm2gM5WZuem74nzJ
	 //FB8FFzCYgqz/bTFnqPb2O2r9OIR0RazBg7zP/yLq1RUkS0DcBsBrVVXwKjKvgpuOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tl7GK25Ew5sPTNDqInllcRJZPijbAjxuuEYSDtAi2Yg=;
	b=LfxZNRXwxMju3PHGUjI7ihx6b+kaXgZWBdSJDbsbcu7qYRCBnc8EcZJwoxfed6oTSyse
	 URzAF8Im2rCXecvKHjtC9/mYgRSaOH/KXjJy5ob9blebdLmrmjGPQ33kFEW8qEvwU/Cmg
	 C4kbX5SAyiQn0tu5AI49QEEbKjALINqZG8Xw5WRH9LmbMAhIgQ4IXPUkYgCve9nqnLjo3
	 CmCZuUF7KSho0o67ntLfrWhEG3MpD9dw8ZMrMIQGW4rdvXEzDu1GiuTAQ5HL/rcvY8Yux
	 by+6qyo2SeNjzS5DOJUTp/I+sWcA0KHaDahbOe0iAM8CT6h+Q6WJ17Ibdxl6KPo9SmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I9foUfAp;
	arc=fail smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C2606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0C2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I9foUfAp
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2074a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792534216; cv=none;
        d=google.com; s=arc-20260327;
        b=Lk/bonH4hDX4PmRZ1qiFajztvn+aLuuRMNeL7V+o8Brci5cHsGkGCyFrQxrwm3+bIH
         uhaTgUnU9x2Im79IXXdCkfzveQ59XJ9825gHXV05Nd5ac4qPig97PQuc15pYnNnkOld1
         5QHs8iKbnR+KZwUTz48SWiPVWwQCSxZarnEBld5ownZNBDw7Amk1b36v2DI0HSwYIoOa
         +ATmLV8gzbDR/pGSidxXix2EZ9paLQC0Qt5qmjRa0Td8dCvDww0p0i2jYdmWvUUGe9Xu
         UhHp+obI4IKUutKJn0TLfLRxClWo0vaQAyUYf7XzoOK+qtfsHtBH6N8k1Nqa3TCmjQQQ
         9n/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tl7GK25Ew5sPTNDqInllcRJZPijbAjxuuEYSDtAi2Yg=;
        fh=h8hBcefETGeQ11cy5DgoiL3AmOFJnEiD6eSSmIGrmzM=;
        b=eEg6Vf4uGosrKNykAUgU4AzHQpkEjFzTyw2pUcdRh2vLw2IpJjjYLys+Vx6LJKBaAr
         sCXwxeovmZPGbkIuxKcy+tI3mxBRWcWbdYZFinoohRDJ8BnD9gPbSXkwSWqeEcDB7bZy
         TxxGNSnZy++uWZHoEC4cKtXFJphEOvT6kbPV7uLylEbL1f6txmrjtdBK4CoHTFaVRIet
         rHragteJlfv5bcLafgNSzNV2n9Ot31LyyyCJTRKUDsLh/WEdTNPNMpDn1Q2WA7u4uBGu
         iJ7QXj/4pBWA5ic8BdmI91aHSLgxm6ANEAYfHFKlg3A8Rv8P8TPIOZAVuDcgbzucgPC/
         Yz6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792534216; x=1793139016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tl7GK25Ew5sPTNDqInllcRJZPijbAjxuuEYSDtAi2Yg=;
        b=I9foUfApie8pgiZYfjauz9V97l8g4NY7YWU34Ms4vzqIiWzmDpB6SAaaxEekO1Ln4b
         c8MNWhWbPFk/vCJM+YBYqGFY57jiIrZ+7fJImQDXwBRlBeaoLdQ1beDrYnDSzhfJiCib
         hsFfdqtoj/lDRsFzW+hluaVqKh8H89NS+SuLcpfXQNl4HCwmaVmOYfxihZP1pizMtFk0
         SdTKRjQiEYXwKziMKFxUVXS2nBERdwR7JzAPUl/fDLwyJWWOy88RBh7nm8CKPWyw4nuJ
         ROWXaKIaP4ZdS/NK0g0qbrZTY+3srupeCZ3c6wEcJ3wpqH8EuhEd00haIcRuxsSlEVYn
         tUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792534216; x=1793139016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tl7GK25Ew5sPTNDqInllcRJZPijbAjxuuEYSDtAi2Yg=;
        b=Cc62g4UTYt0YmQASue4+RnJHuxXH5zZUnUT5gNYMimeQAofVmfJ4i4OW9DNN10pkYJ
         vPSwL5U+iHuqL2zhAfMAwCodPFru7hj7xFCXNAxMTn+beD1zQ/At6e23kOWPSr0JjFfM
         Y9MmJoym1CWNHQB3f/IXtlw7yMuyXMn607ZqO+jD0q3M15w6XvALORXTEJkZIc+/IwU3
         LzX39RLJzXhi5H2sjH9tc7bGa+qNkgSfXEAmffGGrmJZFP19uySEhJKyTzO1GlHI+Q3X
         BUY6FGMe2ERJoj98Nk1unUhDp2MiMnXQ8Kv3gsaaDdHqRfUV+JzenRYcs+8goEheL0+o
         XpAw==
X-Forwarded-Encrypted: i=1; AKwUvByrDfj4TVPglAUUlzILFvz2IBG4DJcujER21dt8zmFY1jjH+FN/QAKW1GOaCkOEoFTXTFEF/pA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8+bDgKNtenu5tQd/UJX23Ds/A6iAudQVeRY1cmIoO34vAy40A
	wMscWNzzJXM4EfWZk9DRq3T88Pgqq04bW/3SUAU0ZCt45uMImdhAWrhE/VMKM9/pTOqUfs4dwaQ
	m2M8krqn3Depv7VJdS0QSlTu5tG56PUp8k1ptufYR
X-Gm-Gg: AYBFou22Wt0/y+mE/PeTHpcAsyK8xi414jLPNc06MinigF6HbJdqEVjXC4IgNbzONSL
	SjNyVp+dtdUn6LzG8QxXAIfA+8CAr1ufVAoPGNZXwKdZ3tzSBzFYXWVY4a4NbP4/+rCmbehR2Mo
	zFX8J3/QloaFtcZnxnHhhmEjawviGUdMgAqAMcux0zdW38PnOXf6sqm0vig8hnbFRJn8tQcRzmn
	yNP//+29IqDs7oobCvpmPdhX5JW8krNUdCMcQBABlFI5gw+Wl+gGNjPlY6riL3Op8vWSe52Ojb4
	GcGhqMzc4CA6/wpxL+Y141Wk6iVX6ofHLVJVsXz6jDXNQrx2umUdD5o82xbdXIt1EvwwdcFjtA2
	uRhXNQT7iZYNSMKdDH5TRRGWlH8Kuw4fg/g==
X-Received: by 2002:a05:6402:550:b0:6aa:7db5:ad39 with SMTP id
 4fb4d7f45d1cf-6b3e5a00af2mr82366a12.5.1792534215024; Tue, 20 Oct 2026
 15:10:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014173945.373295-1-almasrymina@google.com>
 <179249101026.3632927.6502845375265155678.git-patchwork-notify@kernel.org>
 <CAHS8izMRSU3AyVf+sP5uXShiSKuLumZwT=fsgW+bhJz47UoPRQ@mail.gmail.com> <20261020150307.258b00e9@kernel.org>
In-Reply-To: <20261020150307.258b00e9@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Oct 2026 15:10:03 -0700
X-Gm-Features: AclHuK8BsF2XH95JeQFPf6l-JaNozEbyLRQcmco_5nfrlR9V-h8rfRnrpx5Opf4
Message-ID: <CAHS8izPZ18v_1CnRkaAAA=d94wutJhoOZdOFO_1CEXSexd_=EQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] net: unify symmetric netmem and page_pool refcounting
To: Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 09:23:03 -0700 Mina Almasry wrote:
> > This is awesome. For years the skb refcounting annoyed the hell out of
> > me. I couldn't fix it on my own; there were too many edge cases I
> > didn't thoroughly understand and could break. LLMs made this possible.
> > Thanks!
>
> You should have followed more modern naming patterns tho
> get_netmem() is pretty bad IMO. PP naming is object_action()
> so netmem_ref() or netmem_inc_ref() would be better, no?

Ah, I didn't know about the modern naming. I made get_netmem mirror
get_page. I now notice it's folio_get not get_folio. I can follow up
with a cleanup when net-next reopens. I assume that will not be a lot
of code churn. I was also going to try to look into deleting and
consolidating some of the now-redundant ref-ing functions anyway.

I can also make it one of the design pricnciple in the page_pool docs
so that the LLMs pick up good naming practices moving forward.

--=20
Thanks,
Mina
