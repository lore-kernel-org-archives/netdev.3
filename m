Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14B2F8E86
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787273663; cv=none; b=RAzNqh/ARA6I2eJPdSHUJVawvTxJWp48tqay4kjIyHUn0QCkz9aFu8M3Oza1kiT1GUTlQYyMwnha9c2Vk3iT37aIDJ3et7Z9X9xMti7Zbi3/WUHobxPEzKGp1wZW5YbEnGs/RDOrrdVqW4PPLTeTXKvpMa3vKIgvdz+wHpzLoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787273663; c=relaxed/simple;
	bh=XqQqpSG58PbJ/r3abGBHnp32YeXgC7IxyFH42Awq7xQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q7GpmHR+L0n9L/l/d36iogFLnWe/SJviwaAWWizuqTZxqMStEUcAZMhT1+wKO4I1ZAWCg4RdEAyOpGEisPUJYod6zXvE+X6eWhMdwrFT8RpD7wrFtTfzJu+RnU5Dtc3wxuWNdDi2PF7J+xbgNyxEjxC3GyfrH3Wer8ieFmF5+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFynoJkK; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFynoJkK"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90c522298d2so3483996d6.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787273661; x=1787878461; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QrF+c9pcp51i+6eXP3FwjKOzeP4Wb3wAE/9LLnA/5VE=;
        b=hFynoJkKUYpNMrsiP+KC4+h/hztZzmJmly2wwvZSWX7WvuW6+QdKQG9ypK2jZuBALU
         FgCUGmYgNZeIB+6On4AYp8CyHh6smh9NG8Y+GuUAbn7fEW25Ja3h+2TucP0WW9bo0Q8Z
         MaNoPyCZUtUkgjMjnZMCCKTdW4+WQSP6LgfQh/Bm7S9KKx2hCgl6PmIEeUUKXAljGP6J
         srtEQheR58+amDYr4kBfOSUvRwshgLvINGOq0mubMM23/cq8AqwrqJZ5jkwWyd9RkZn2
         b9pNuJ+5VlYUBT534VGzYXyvwqFQFhJQocko/uisSBLDVfDqDA5dkHhMs1IMJH+jLPTx
         Vo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787273661; x=1787878461;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrF+c9pcp51i+6eXP3FwjKOzeP4Wb3wAE/9LLnA/5VE=;
        b=VuMxu37oLeRP/XuzekyNxHxKFCXLnqiDY5NCowuPDksYgHLv+KFpajCWSuM9Xz+8xM
         KAnfgBzo9Oo8rn9ddE3OG6D7ujdX1n6eq//4JQkzlNMVUSJ2dQOuyNgi4/SKG+KiyWx9
         131j8BXay+C1Cg/rostbo7Am5xiPOQgPJiyX5YY9BHcmlxTZaRieeTMZx5ZO3tT7ZRq6
         e/5uPy7zbncnocBkXiQ8tQFRv9e+YyYxzqCU6TrWv5CSrK4Ax+4B3YOPjQ3CgvEpDLi8
         kCeVlU01N5gzS38VR+eiX/oqcAjlylkUrk/5i9pfRY4lc6r7KSIlbdsSi0aBpBgYTg21
         60Gg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6Rw28yDOy2IYmvNCgqb9aDnvldCD65UUS6P5b9j15qOesGazH9hEo9JxTS09Vmsif4iknEco=@vger.kernel.org
X-Gm-Message-State: AFuF++mLAP1u84Rd71Q0ej4DmpNMw2vB4UCUGch1W6WsjgOevh8aDCMu
	SFuA4EpBzw+7s3sM+9J5flnjTGoZmgq6B+xzB8VAQtXz3nitQ4Ul+Z9b
X-Gm-Gg: AR+sD10veTliOvqr068xH9yArM/8jGxzHdSe0p6+g5qzs3AAj5aXddH8kZGihlejRtZ
	iqdxa6ZDa6jwBNB1hU6favENAKn3AjkvSMtTQeYb54GGsOxTANEp2GoZTzrx/c8Hazehyyvw72E
	1ighBWoIE9sq5BaurIuJcBaatuM1vqL1aFJn0NkHMgXGUb0knCtoQ3VawP6E+tqB7K6VQc8H/rr
	0BWDtTkuzPa9AhtXAbMNLm8c7Y2W2mQ+tyQd1w/xcZn5CDaZa3jzSIsMbfPGHLAbiOl1I8/LxPh
	pmmy6nksjhWATLD2JIUeLUbyj8kqH+JsgsYlTSrfpfxQSoOIekzakQJD23GFoaKma66Dc4IVtlR
	QZ4M73AZyjtsQrw1Lh3Eo3bnFlg96vy8wPhNd5p4BdG1rKsBDiqZabTu1I3hYssiFEPRWIWs3Fp
	/ndKgijhqneMDGNlwH2fk7ipAGdlcoV7/J8K04vHIK/6fvYAqyXp93pyPkfyi1VdkbDI7yTsSpw
	p0qFnZDS9qwvwg6rsyd
X-Received: by 2002:a05:6214:27c6:b0:90a:7bee:1bf5 with SMTP id 6a1803df08f44-90c809432f1mr23497426d6.2.1787273660820;
        Thu, 20 Aug 2026 17:54:20 -0700 (PDT)
Received: from smtpclient.apple ([165.85.199.100])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2a35basm50032116d6.35.2026.08.20.17.54.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2026 17:54:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] NFC: slab-use-after-free in _raw_spin_lock_irqsave
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <CANn89iJbOs54esoGSukvMiYnXQkHadnC7NgQanbAXOeiHXOsjg@mail.gmail.com>
Date: Thu, 20 Aug 2026 20:53:46 -0400
Cc: David Heidelberg <david@ixit.cz>,
 davem@davemloft.net,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1E58A29-96B2-4BB0-8840-8A168477F48E@gmail.com>
References: <20260819050031.2725592-1-shuangpeng.kernel@gmail.com>
 <CANn89iJbOs54esoGSukvMiYnXQkHadnC7NgQanbAXOeiHXOsjg@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Aug 19, 2026, at 03:48, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Wed, Aug 19, 2026 at 7:00=E2=80=AFAM Shuangpeng Bai
> <shuangpeng.kernel@gmail.com> wrote:
>>=20
>> Hi Kernel Maintainers,
>>=20
>> I hit the following report while testing current upstream kernel:
>>=20
>> KASAN: slab-use-after-free in _raw_spin_lock_irqsave
>>=20
>> on commit: 3aa1dcaa4f6f5ae08936491e08bd456f331f2d40 (2026-08-13)
>>=20
>> To help trigger the bug more reliably, we applied a minimal =
diagnostic patch
>> that only adds delays and print statements.
>>=20
>> The reproducer and .config files are here.
>> =
https://gist.github.com/shuangpengbai/f7dab4725e2a2d57b1d302714c93c549
>>=20
>> I'm happy to test debug patches or provide additional information.
>=20
> Thanks for the report, could you test adding one skb_set_owner_w()
> after the skb_copy() in nfc_llcp_tx_work() ?
>=20
> Something like this (untested, not compiled) patch.

Thanks for your fix!

I tested the patch and reran the reproducer. The bug did not reappear.

>=20
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index =
cac1b5487064d0c5b4966bb6a75aa26e67131049..49cb632268c0c2841e3b44dde124c796=
6267b709
> 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -786,8 +786,11 @@ static void nfc_llcp_tx_work(struct work_struct =
*work)
>                        print_hex_dump_debug("LLCP Tx: ", =
DUMP_PREFIX_OFFSET,
>                                             16, 1, skb->data, =
skb->len, true);
>=20
> -                       if (ptype =3D=3D LLCP_PDU_I)
> +                       if (ptype =3D=3D LLCP_PDU_I) {
>                                copy_skb =3D skb_copy(skb, GFP_ATOMIC);
> +                               if (copy_skb)
> +                                       skb_set_owner_w(copy_skb, sk);
> +                       }
>=20
>                        __net_timestamp(skb);


