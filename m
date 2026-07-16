Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7A3B47F7
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186700; cv=pass; b=WPEE0wl+nIcjeAqabgdH5amBf8yfaOZr5noeFmK3nRnxIAoRW2cbzogjIhr+hzJpZCdz8Rbh1/ucFGQal5brvZaNy533HiFEbJ12Zt54fGIVPHdWnVqw846LDcu1q3AZSRdW4RgORA7vleOhLyNMFyGXzI5W6YO8EFk+mmUp7ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186700; c=relaxed/simple;
	bh=fELdVNgUfm69Qj5RibNKLPZ9WDfUpgCmxr2Ii4NefZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj4tytT7GlxQIOmjTWMgGAzkk6TrOrHYuPgfYe369+wLN5ddG13hwMGiOvYKVhQqHRSe5fklzDkDRBHu1Z82PPRY7fqLWDztOaEPizPKvoNbc9I2afdU4dDR5FKar5s2I0G87FJEChBS3IHai+KKBFbazJqfdqkBVLQScRwDJM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9NcGz2T; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9NcGz2T"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81e86df8987so250857b3.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784186692; cv=none;
        d=google.com; s=arc-20260327;
        b=QZqJ6ET3JYPXb55Gml5yjWmtX6glQfw8+UafuEp6hc6KjVkv/4/6eYCKD3L56CQRmH
         Hdujr1MCKMDadO4Jr00cSl7wj5wCP7hvQpCKLS/0fQ+lBENXEWChn4kTyZ5bBC7Yercl
         y52ShDK921MUz+uOtYR4pG6KoySISX73pQBO+yiV3cqbC4jqHU/BE5RPfyd34rJR9VN5
         TUo0khMP4g4D6hpt1MhUFqxe6fC8iq/DOzMrN1RneJx1NhxBF6Oxn1NAbEVwlwhWRYtj
         lfT12T9MuD62kFOxuB55CzHq7SFLYwtXOhmoR5SjPLoJhYJZ8pttLGQn1ZDMLoWroGwv
         qmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fELdVNgUfm69Qj5RibNKLPZ9WDfUpgCmxr2Ii4NefZM=;
        fh=9vPFQV2YGEJZ159MygS+M/cXlmNWeLaJnsoJ1GXSsWc=;
        b=N5RCKYaAlZhZa9m/ayEpkRQDXMi2aG2x6svc734suXzjZsz/m7Fg7mnIvf9ebTdK4u
         D6OQohXieGetRe7DPjljrPY6dXQ9CLBXh6k6zVwYgIMj4eokFfFsthHIuqStwU2yJIl8
         WzVjxeYklgJgteXX2UsnADT4lse5bx77JhEUVDqq5Ht2PyZLO7H2LStCma81UBI7zL+3
         T1Q03WszIRv9Szmgq+TbHgKx4UppzXjxOTxPBS9tb7Gzh19aM0Fuv/X914TWmKUw4itl
         Rz3ZkdvjhcWD2k4yXOa0jA+VUSbCcJOGEmT80bYgY2fggriDR487P7JTub7xNO6JvNs2
         RQGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784186692; x=1784791492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fELdVNgUfm69Qj5RibNKLPZ9WDfUpgCmxr2Ii4NefZM=;
        b=L9NcGz2TP4UeU0tHwCMh5F6/MXbROc30URF8gpeygPsXWqL3MajhEgFgiiznuq6phB
         FlsoB7S+smV+9MZ8GxZRFtkEfTBK6kHPKAeyTacMaGl/5ek2PzRAdGCXYzHDImz7kStv
         NbxdO8RNIiMiA+qzGaU5HlYuiuV3MClB/ow98OqQyvmCxiWzOQa6hyCHKrNzJLIqNcfo
         m1VcAzI64KD1vUIdEygdiOec1qOLdKJFwgXqvJ/h1Lfj5TuAEzxH6/LCEol/BkAPFQJx
         +th7AegeYBosJ2VhAiw4zsUrgMqWakSZTa3e9zuC9rkIZTqIpM1t5EsRExBCxDjM63hp
         zPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186692; x=1784791492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fELdVNgUfm69Qj5RibNKLPZ9WDfUpgCmxr2Ii4NefZM=;
        b=QKDNf+q8UBNOQSE8tVXbN5kUoEjGuXiNXWyNdwiJacNeWanU0yPwwDw/2lfRhhHG6V
         T+p5hlOy4BsHdq5hd4RPhYUckyV78bSzVSHyrkFFIdTcfJrnPnZjbOLymBUxkowWyCA7
         F/kCjBF3zyTdPdf2EY87587kmHBZNqoWtToivyzqBjS5RZOFR+JIiryg7dCjJ+EwOlb/
         XNtODbEjszTSAirE3JThFDQucimDKWkCD9+0iP6G+luHMeuDT/+72q4SR1JTl2I/MHsY
         fkdIWk3cfTh0KspAuHyRQGK+M4guwMpfsplYcOOXs2Qq1I2tk5PXoA3KD1mMhFZDKiZz
         K2tg==
X-Forwarded-Encrypted: i=1; AHgh+RqpX1thXE5zXB/5YLDuiZXcVSfmWSehhv8KQoB3Xy6IXIo3LN6RTJ3kGVyE4xEECbsEsIPlGW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgKheI5JVKsyP2o8uMYNF+1l9Vs5I6hvJ4Tl2U0uXPOGtZuzc9
	Bltfgk7QDtrqgTJnhUF/rjTzqM8xZCN7qcfq1qB9ME6G1/tcVNi+FzvgLsrpHQXIv7w5rcjeujW
	EAR4zXE2AS525jP3tTnbOMt6WOJnpVCY=
X-Gm-Gg: AfdE7cnqkkaSKpjSgVHvN644v39Y9xQ1JmdD8WCPawvrXs/z8mVxTQMGluyhZ7dun5j
	bTa/x8s+lbIc+o+079XG7/C+wKd858QcEyJA2tq7E8pHfEsiKU3fm9C5ZxbYHlViOOaKTdkEjkn
	KhMYvMeaimeqXejR42ZOvRkHJRM10o9WFtryyB01MtDgx8ShS8MyfUAViMAp+PXEOBK0dRKvzgn
	mY3TfaNkDTYzAeBxUlsGpdEsHoX/5TT1QopBxSwxK5S2kTH9mG4vn2tIkD2be/BajkcDohaBEzD
	orTT1BeozNKy+5aqtCegHtSqUgWT5J3JGkyjkqpQjuV5OA==
X-Received: by 2002:a05:690c:9c13:b0:81e:68a2:89d5 with SMTP id
 00721157ae682-81ecfa907bbmr51286927b3.55.1784186692044; Thu, 16 Jul 2026
 00:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
 <20260715-mv88e6x41-fixes-v3-2-9a8702b27ecc@padl.com> <a607d5f5-a315-493c-971c-d5e8cab33941@lunn.ch>
 <CAOiHx=mZeS1dZ59grQrf9U2QP3OKEJDahhYpLx5_tKCEUty1yQ@mail.gmail.com> <540B5427-A5BE-486A-818F-5D512E1BBE4E@padl.com>
In-Reply-To: <540B5427-A5BE-486A-818F-5D512E1BBE4E@padl.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 16 Jul 2026 09:24:41 +0200
X-Gm-Features: AUfX_mx8x0SnzLn3MawpGikjxpJlE45znbmocte-C2xgpK9_atcx3sOhcq66xkE
Message-ID: <CAOiHx=ky3Z70k589zLG2k6zqhq9O0m+=ivm4VCZN=69+r+M0cQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] net: dsa: mv88e6xxx: flush the ATU when the
 hash algorithm changes
To: Luke Howard <lukeh@padl.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vivien Didelot <vivien.didelot@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Richard Cochran <richardcochran@gmail.com>, Cedric Jehasse <cedric.jehasse@gmail.com>, 
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
	Christoph Mellauner <christoph.mellauner@joyned.at>, Simon Gapp <simon.gapp@gapp-audio.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 9:09=E2=80=AFAM Luke Howard <lukeh@padl.com> wrote:
>
>
>
> > On 16 Jul 2026, at 4:52=E2=80=AFam, Jonas Gorski <jonas.gorski@gmail.co=
m> wrote:
> >
> > Probably also needs to be not attached to any bridge, right? To make
> > sure that no additional static entries can exist (because I think
> > these are hard to recreate).
>
> Thank you, I have fixed and tested locally and will include in the next r=
evision.

The more extensive alternative would be adding a way to replay all
static fdb (and mdb) entries to re-add them after flushing the ATU,
then you can allow that any time. This would be also something
interesting for e.g. b53, where disabling (the global) vlan filtering
in hardware means you cannot add or remove (static) entries with VID
!=3D 0.

But either option is fine for me; my main concern is avoiding a desync
of hardware and software configuration.

Best regards,
Jonas
