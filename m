Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4B4B8DD9
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334131; cv=pass; b=buEkS6ygHc+OJBg7O9FaBhbe4a6HDgAve4vqX/ksa8hK+/3WqdfSVH+DinQ9QK+Ohr6CnhGa30UmD4pb8bZi2KXKDaTOjhDa08/uKcRvRS+UzgB69EcahYw2Db2Peg16Yngl1gAAprt2y0r+4RokeNqExtRjdFjLqoZTyEGnH5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334131; c=relaxed/simple;
	bh=th99PbLD8ICO6SAa3Y31WyZoBXmKw8CKschsl2BeuHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUN+9OobXWDOict78Ysczz0L+yQ6qDYYCSUyZkrcLIPFVWptxpC2HGD5f96qbAfceWl/lgvx7/ZRVa94/PaWmDbcZdjtU547BM63G/Qgm+XO9gtGhHSXM8j0hY+caArQ7JyDmydl8rerVl25L+XIv27aciGT7w72ZkapMtih/BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kucW23XS; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kucW23XS"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-495efdede87so40637b6e.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334127; cv=none;
        d=google.com; s=arc-20260327;
        b=rHvF26aSLVHoLFJdJbqr4oKVsqchx/i9XFh8Sip9P1mJ1kBM34qOm2IiZjttr/LrFk
         iWKib2V0dCbXlShpwXaYHEq2XlBqP+UwM82NwHU9qOWUfJNr6LoZ7ZPUpu73UWsBM6Mg
         26PwO3z8T+xosY70sB/HcHPfCZ9d8WTu42yjsO3e7oiecSZKlLOYXFvYxonuZg32NMj5
         nS1IUPODCnL/ol6yPlGWN1tC4K33RlJe8mr86GUYdVaJERyo3eeok1zlqNzIwDdxXry8
         nNA2WNi44uVdAHLWL7Op6RVcushugQOf/H2W78VytSt/FPnp69IglEhYzlYT+yw7aT/g
         WRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=th99PbLD8ICO6SAa3Y31WyZoBXmKw8CKschsl2BeuHs=;
        fh=/iUnljtBDVI90Sf8nePqrH3+qr9JtiNJtQF6LdMvhYg=;
        b=eeNPaoRmJMixJzQj6y/bowbq2jTg1hJGVenjIYO8iak7Pw8LjsN06S706V2moa64aH
         Yki56Q1zizEwe2l+C0G+xQcc02cuy+ZPOnku0571CILhs6++i2cY4CMlsXDNQxLTK5i/
         Qfky5hvjKD2lNJ9kgnYQ6xn8owKBh9rhCA9Apbl95QC6QnmYKIH48NAXtnj2GWNHHLtN
         wfncnNOvnTlsp/Q2w5rYH24Cx6EFCEqx/4pDynaDPKG6ShMKb0P1aVM27pIgHgz+v5rn
         +/9EhaQ4nSDnxNmaqGoJkuBKv53UK+/L9TRKeBWhPh02PPkI75M7FEp785E4B1nFdIns
         Sazg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785334127; x=1785938927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=th99PbLD8ICO6SAa3Y31WyZoBXmKw8CKschsl2BeuHs=;
        b=kucW23XSUxBC+k5MTFhidxzVy5jaFctqFnYPeJXZS0Ffq/n3MzBvYAlTeyh4J7X1sF
         T/pgV6wvFFNN7OdFLZD/NlPEpMJ0tYsMaX58Ynb/IXZOLGJTejUSqg+nmKtAONN8Q6pm
         6RGlD3xcsPTuehaXHlim0q8jociNvLY+Zh3o2PwnGc2GVyOiixzgmPFSpCoc0aUEFom5
         gW4Y3kyMcn0mjAY7NPizIKDkDwqPGmlNBDBN/KbvhClYnNJQdY04sw1WaKaBo1Q/3QS0
         F/J3QKXggfBeu9X6ElzZiYmN7kxOLrviJZyPjJW5TFW4s6MvzjOcZkZDnlTrSp8IyHqZ
         SuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334127; x=1785938927;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=th99PbLD8ICO6SAa3Y31WyZoBXmKw8CKschsl2BeuHs=;
        b=AD/KyPBHpUvewDIaWkU3Q+67twGOb6feL4McsWFfKfcL+dVVV/8qqJVOZSw8/qnp3B
         Pib5Efi/wPtKU/mnFAH55p0mopFboaV3MRRbfO0K4Ui0tcu/lBh2SAzkg8e5tgXhiPj7
         zm89mwHGgfPRzbUXGWDPPS1niDr905ZwXjsqJS+wWpW/OhGNgbWPr5Vd9wXwHOKM7jJK
         NKNN0P+ki0gzOah1TAQ4UM0LALq/xlr7+9CpMlJEjFRWoW/JoEnOXhVp5G4rISe2lqOj
         jG2F0OQyqPC7JCp/SaK0gB/zPTiGNWx+5sJKafaLaU2M7xs2/ug8YBlk5Fs3UraDz5mM
         +1/A==
X-Forwarded-Encrypted: i=1; AHgh+RrwpUnJzHssY/du+14LXqsiJIPlfyCKADh7puA9uRBGCeSCNaiFaG4TghfBwOy3HgARgmQR2uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyws6qv+pxlOju41G5l/4eXvrz2kRiOUAW4GlO6KOYmsY0kuP
	QbuoB6Jb7HezqTaBx7uygIu+ngA8l0BcVjDFNzyF/y38Ruv4iaMKaSzi6xA3E62tlOExbjWNRqP
	jCh6+YkuBf+TnQDMi8Wb/EDmVsHpwBiw=
X-Gm-Gg: AR+sD12Atf0YHwsSEmO2p4I1Raz5jVXl3LZgcq0DPVsc70LwPMaxSOQY/ubguX+kmvN
	DBNVtRhN/Y5VXcP1wYhu4RPfzDNkX3IKKnc9ENeBqGds+wfkkvmVP2GRGj3T+xPKYFLh6+0ciZe
	9Y/E7k/3aYVe4BAVhtn8U5S59xqQEU3bpJM2zIfFW96fgjlhZQh9KvJynuYeqnQwDZQYBFLjeb0
	UMj7eDyOMwWytrYqluNScEENU9HBXan4ta7CIbkCPi6ranMyG1PIE8Nqdo5+zrzjsVE/jQU7l4A
	6OSY0YS1hcCJBG+dbSGxx6gMgXYEjzkWksfSlrOCdoEObHzguNgIEx1z9MxS
X-Received: by 2002:a05:6808:bd1:b0:497:d23f:e621 with SMTP id
 5614622812f47-4ad5b9b8ac9mr2927078b6e.2.1785334127057; Wed, 29 Jul 2026
 07:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org> <20260724-netconsole_move_more_final-v1-8-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-8-a5f7691db81c@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 29 Jul 2026 15:08:34 +0100
X-Gm-Features: AUfX_myXhOk8SL9iwWc4hd5pc9MGGXJoZ0x-OHsgxsB1T1joV1Iu4Pl7Hd_aZTQ
Message-ID: <CAGSyskVNyDYKnpw+dtjAxOyRBAp1Nk_9Ekg=mm5tMXMdz3XWXQ@mail.gmail.com>
Subject: Re: [PATCH net-next 8/9] netconsole: move local_ip/remote_ip/ipv6 to netconsole_target
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> With netpoll_setup() and the packet-building path now living in
> netconsole, local_ip, remote_ip and ipv6 in struct netpoll are read
> and written only by netconsole. No other netpoll user touches them.
>
> Move the three fields into netconsole_target and switch the packet
> builders and setup helpers to take the target instead of the netpoll
> handle. struct netpoll is left holding only the device-binding state
> that the shared netpoll transport needs.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
