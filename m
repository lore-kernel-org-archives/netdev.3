Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355EA3F4DCF
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130766; cv=pass; b=Ki2iy77Es7HiuouQmqy+fw2vmgJmpeN0C30u5KQOUnbdtHa29Vo2E38II7f60wssGTCX/a3wc8qsWHD59/me8eW6nx9ewf0NulXBYa/K191uAmrJCA5LhWxBmYK28mDI7q72MCDfzwpWJVgDSxQygm589nj+BQqqww5Uvs6lGJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130766; c=relaxed/simple;
	bh=SJ/khaFK3sJe4z1sQhHoFyezPzZi/kDXIfDqD1Me3v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnZmTBvbUwtJI5FKxcFLd1ooCLyWkFpjk+aj4hYuOGPGr4EdyF+7Y1EbUcmI9/3298VTlr7e7H4Ptqe9gTl44OsK2axq1hCiYhyxjK+7eZpZ38PyzeIAalnfIAAb/eMSI5KZhEQA74Up9Nns1KuNn3c6QaYdovgg5WAbujQt13I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=anKumAF+; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="anKumAF+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso685234b3a.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 02:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787130763; cv=none;
        d=google.com; s=arc-20260327;
        b=VyNoN9A3fINnHAfhMo2Tepg/ChoERDo6XyIPWrtI/aqMXA+0dOCWXL+ozpVIWcVwpj
         o47exL6oDpfWlOZA2y03KZEJs5uzlOhLQwRAy08Fs7usy6Mhuj1CFuJWyxUVlXhyTHsr
         gwiehPkpHO4I/Sfnb68OWsiv/15khFaTGlH+Wux0/RCNSQ4vrFGYgL4ptb87MbdeRzpP
         RLYaQA/PkBSqMYC1z257eUSYzTBSkwOBCImmatoaMDsAtvn1PgUp3nA8C94hRdgeoE7w
         HP2XojD7H9OoR4y8ilaP6XMrEUJq9iZm33yhadsA+vpUSgDQJrbnO+KGLFaUTYjP02ra
         eL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YbJjHZxytJ4ofb4uYwR0DiYjvjq5iTDV+fvDYEEjCvM=;
        fh=Y4ktfEyceSUQTYEsR/2vX7BA/ZnIaiFSYZ+rfMibtJM=;
        b=UEKdgyOuSlJFm2qKe5kjjxYmwF/quofnzdRbL2wnKe0ebI4vCYUzNrqPNqcnfuUZku
         H1teTQpcpLYrUwJwjpj+heAKMi+EY+u5Rpbi+r7jVMr2OiSRlpL1MXZz+wZO+bJsjOuI
         uIzTGEge+FgA8ubkWQ5qIOUY+h/S8I8hYYkVoIdCOsZPybGyppTGlLIDfIc+m4ZeFElC
         YlAE4f4RSd60FkyZ6Zc2lgrKl606jdqS+To4lE/8TlEy2HkP6yb9jTYBgh9kSSoTe3o/
         t6FZne4FAB6P8ZqH8Jq418I3k4SEdtH2j6n2k/Tyu6HsWDIlZkhOBQO/HmP7fhauZZjl
         BoDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787130763; x=1787735563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YbJjHZxytJ4ofb4uYwR0DiYjvjq5iTDV+fvDYEEjCvM=;
        b=anKumAF+/kS2V6PsLj5kwgD6gGyMC68H3XfhmtoqdcuvOfv9nxiL7sUCZmcTM10TMx
         Xa1cPGTO6w00+OHfpOyJASbbSJJZs0+TBhMSAv3wvIcLk7epwnels7HGFA2R3fXyhokd
         +5GsePL0dSRH+MLNXw+qcoRBPA14qW3rd+am4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787130763; x=1787735563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbJjHZxytJ4ofb4uYwR0DiYjvjq5iTDV+fvDYEEjCvM=;
        b=iTj8GhqlN/iMnwweooeMEiERHPTVspeeT7i15EyoyhoW0h03X1soIlSXbzcBwQuDWE
         CsdwKUDM9g98XvVClfMNnzJtKhEuzjeaaznUAcXxsC0RJ3ADVfA5VDpuGWAmYAsTYSq2
         kBr76vnIxfr5zDwvQOZX9Aad/bjkwSCSizuf3zzrOIp8k1+8BTOPnUWqcdwEqb1b2iY9
         A+WAP0seY5BNh4F0BABAysZBr0ytayxnMrh6wlSI/FktR5jaG+Jqn+9HnSHj4OICTVZE
         AsC58dOTJ9tyqJFe7u29KJWkd0XaOp5twyuOJ1aAek4UgS3EjA0m4HTh08/BSYKjzYUo
         qMwg==
X-Forwarded-Encrypted: i=1; AHgh+RrdLOw0nTWAd0gFAKCnUarY4CA6+W0J2fNVLDIbrKFwQ4Bqx5tT4zylAXgZIDpqL5F5+N++/c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyfB7BanbEpObJmxH1rPmBPKVj7rQRJkBzbjj2UVc37xKXfSv
	/fWXhFpVP4HQgR5hKX+n7C6qb9W3u6lrvncoJnOWWiGEeMvekGTVJ1nCJYHwdsJYo851aMI8Ej2
	dzbj+F7fJ4jSlaNlTt45c0pcebeVTd0K43crkhGpg
X-Gm-Gg: AR+sD11t0z2D76faMIPUvSQPiyzgAP0Fd71ExlbvQovukUhdCENxNnIHBK9lSCWCGRU
	pLbHm64G4Va6GAAkz3evRji4rYE2zpsBTFtU2ouMEmxd5LvYVKM1K9XNJYIq4+kp0oDlIf8+giY
	hGVb9X6RLX5RfMIQUeCm4Yn+wHEdcNTclHcJB2DYSiBw/i6nuR++i977n6akIAlxgtd2Ds7lcI9
	axgegcZVEKoRQn04Kage/wnnVG5+P5DIb+JSIMcqKkDvj1ZWsBiJVFLLa9WzEx6VxB3tlMbKLSz
	ssRUJj6CdlG6Sms4bpRt7DpkAkx3Mz4PYvjsxvcgB8MVgw==
X-Received: by 2002:a05:6a00:1caa:b0:845:ce5f:c926 with SMTP id
 d2e1a72fcca58-851d36d2914mr5653030b3a.1.1787130763432; Wed, 19 Aug 2026
 02:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805102505.740806-1-david.lee@trailofbits.com>
 <CAM0EoMkMcpE4JZdroYvVuPRzUC8Xwbwv3p4+qkABj=Qk55kWvg@mail.gmail.com>
 <CAC_etQEByQLf5pMWzbyVfT3xtzereqEgu+XZYmwDjyvpRCzxjg@mail.gmail.com>
 <20260812182246.3df00681@kernel.org> <CAC_etQFk=tGLvbHPmQwOyrYWgRtDru3dSw4T7sZ-9hvVMy_J-g@mail.gmail.com>
In-Reply-To: <CAC_etQFk=tGLvbHPmQwOyrYWgRtDru3dSw4T7sZ-9hvVMy_J-g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 05:12:32 -0400
X-Gm-Features: AcwNN1WN6Ku-u_Q_Xha2kQBI5qXmT4SIrLHTkniqatJNHPLUkxztdKvFQIJG_Ts
Message-ID: <CAM0EoMkv0yLNez7gvNo6=qTQ4rLmbyZL-tiiY6K9tJAuH4WPWw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: defer qdisc freeing after failed creation
To: David Lee <david.lee@trailofbits.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 5:06=E2=80=AFAM David Lee <david.lee@trailofbits.co=
m> wrote:
>
> Hi Jakub,
>
> Apologies for the confusion. I've reattached the correct reproducer.
>

Thanks for reattaching the correct reproducer. I have run it and the
KASAN use-after-free in now matches the bug exactly. The earlier log
showed a different issue, please ensure logs match the bug and the
repro in the future to reduce review time. We run every test - and we
will vet your claim; so sending the wrong log consumes our time for no
good reason.

The fix itself is sound, but it requires a v2:
Per request from both Jakub and Sashiko: Inline qdisc_free() into
qdisc_free_cb() (or make it static) since your patch removes its last
external caller, so the standalone symbol is dead weight.
Attaching a C poc to the patch is not something i have seen; make it
separate. So mext steps: you are going to send 0/1 with the attached
poc and a good description of what changes you made since v1. Then 1/1
is the refactored patch.

Keep Fixes: 51ab2994c387 since the that's the commit that made clsact
bind a shared block before creation completes.

cheers,
jamal

> =3D=3D=3D=3D=3D=3D=3D=3D Affected Versions =3D=3D=3D=3D=3D=3D=3D
> Runtime reproduction: Linux 7.2.0-rc3-kasan
> Confirmed vulnerable revision:
> f5098b6bae761e346ebcd9da7f95622c04733cff (Linux 7.2-rc5)
> Latest inspected vulnerable revisions:
> * 62cc90241548d5570ee68e01aaba6506964e9811 (Torvalds master)
> * 9d8da8e0a9bce4a340af60dd0446bc7eb8d07587 (net main)
> Introduced by:
> 51ab2994c387c80b45caf8b8067b3f3b97771d25
> ("net: sched: allow ingress and clsact qdiscs to share filter blocks")
> https://github.com/torvalds/linux/commit/51ab2994c387c80b45caf8b8067b3f3b=
97771d25
>
> Required Configs for the Vulnerability:
> * CONFIG_NET_SCHED
> * CONFIG_NET_SCH_INGRESS
> * CONFIG_NET_CLS_ACT
>
> Additional Configs used by the Proof-of-Concept:
> * CONFIG_NET_CLS_BPF
> * CONFIG_TUN
> * CONFIG_USER_NS
> * CONFIG_NET_NS
> * CONFIG_KASAN
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Step 1: Build and boot a KASAN-enabled kernel with the configurations
> listed above.
>
> Step 2: Statically compile the attached `poc.c`:
>
> ~
> gcc -static -O2 -Wall -Wextra -pthread -o poc poc.c
> ~
>
> Step 3: Run `./poc` as a regular local user. The program creates an
> owned user and network namespace, two TUN interfaces, and a populated
> shared ingress block. It sends ingress traffic while repeatedly
> requesting a `clsact` qdisc with the shared block and the invalid rate
> estimator.
>
> Step 4: Because this is a race, triggering time varies. The validated
> run reported:
>
> ~
> BUG: KASAN: slab-use-after-free in tc_run+0x5e3/0x620
> Read of size 8 ... by task poc/...
>
> Freed by task ...:
>   kfree
>   qdisc_free
>   qdisc_create
>   tc_modify_qdisc
> ~
>
> The complete KASAN report is attached as `splash.txt`.
>
> Best regards,
> David
>
> On Wed, Aug 12, 2026 at 9:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
>>
>> On Tue, 11 Aug 2026 00:58:27 +0900 David Lee wrote:
>> > [  230.057740] ipip: IPv4 and MPLS over IPv4 tunneling driver
>> > [  231.667279]
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > [  231.667738] BUG: KASAN: stack-out-of-bounds in
>> > __ip_options_echo+0xdf7/0x1860
>>
>> I'm struggling to see how this is a repro for the qdisc lifecycle bug
>>
>> In any case -- if the fix is really correct and there's some real repro
>> shared off list - I think you're deleting the last caller of
>> qdisc_free() so you should inline it into qdisc_free_cb()
>>
>> So patch as is needs to be refactored. But please don't repost just
>> to refactor, we need a convincing repro first.
