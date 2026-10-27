Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793064554;
	b=mwKjyAlgMltW6Whj1WCa0lbPI9AeN4G8Deuh9dwchvjIirHYoNQ196JkjhwWXKsn/UjS
	 nxPGCKjmE1o61Q+KxpQfxYOGf8RsQpnn8aQUzgNb1Vw5Xyd/NEpjxECBN3vy6x0DkEda4
	 CkCpzdUA8m6L42vmiLo6dEADitzuqB9Tz3cDZiUR6V9h1TYaY4BSHXlfh4oxCAeckIEDs
	 CiMOrBrYlde9LJv/jZKJqCkj8ILZSV0JmTbejPiTQ7vQrBmUuA0Q2qaE5pB6TtuRWED6X
	 dvRZNKIcqvw6Zh6pvuNn/4ggM1YsiBH4Yz2CaeAB4pxqz5NF9L+nHj4N0LKm1yUOiBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=84IQRr6w/KA3TdvtIm9+wari4HH+7Z0Qs3aIIwubXlE=;
	b=4ohN2ff+CGHKvP2Ed8wy9GaNGkCcJ/tWS9W5LvUqIA2XQ+AN8+ePrKaJ1AQ+2XVpbnxi
	 ftV/mz+VGHiq6LVYRBVBsrX13LoAiotky+U4t2gGcVgnZktoAwWJ2HpgWxBSf0nMqB34Q
	 ASLP86vpvJ+BTbeAFrZbKkftedF1FvNvEc+RYbITP7UZuANhjKEnzxGVbwaESmX1ANOXZ
	 S41O+HDVgXOPIRdG1QJ7QqbpIpOPNyhfCbkHBwsxeDpuxyal3Sh5WSmKMz/pUWqBRoYRp
	 t/Z4maAzZOx1Y6VWeUQbGZRC6vvGyy3UApK3Aerda5BdV7t6TYqLp2YsIewRUUFLgoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YkTRUr5L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5FC606A323
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF5FC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YkTRUr5L
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7a6e560f580so2441680137.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793064553; cv=none;
        d=google.com; s=arc-20260327;
        b=VhywTXQ1zCweht+5WYOIVmVMy09v6IPsroM97+2Pq4NI6akMFzAdSUOBa8xf1C8BhQ
         0DJJMRS7zyxF3k7+89PpLEiSHWYXoBbtLtM58Bygf0R3BTPsR/QbnCERss5u+1P1+poi
         A/1y2PCgOCetFvMIdIeJmamToG/6MuipFdbYR+OGCaeuUD2m5GO9S8fxd+xcNY6cJa3f
         g3vI7UhcxjJYWtK/R2LCbSkTs+AFOCMFk7mgOmJLFh5b1d22+d4AYRUJDau0MhsnRazC
         IZqMvxczCDWCJpJYwSKms65Icus4C2m2323sTUkoiroRkAbCPQ5eSEi/Wy7H/pmbyAk8
         zatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=84IQRr6w/KA3TdvtIm9+wari4HH+7Z0Qs3aIIwubXlE=;
        fh=YcGNtFjZu312m3O1kdTOmQNMadkt83rsTJ9w02eLnGQ=;
        b=MJ7esbEoV8OUPcxNQDWyonaHXP70JVVaLtkwRVFqC02RM0O8TpY9TrIKqro5kQBQqo
         MeEKkkSPHB7buZXXPh3QMl2SMbqfK3fwcejLSMDgGhmtIeU/qlDmQmFjN+eTU0WJjrxB
         MmNRZoMYiSJrnN5m+Rn9i1XQwEk5LNlrcJ6vOr9+7YwIwZDADv60Dm8ldbeiNaqGD8jJ
         lUmrjxPmbHgeOQcwZV8oC3o7K36vQzMNNibVUsK5rprn1Fd9xiXKr36EYVwsU6eWW100
         g2uW2QVL8e3ErJrqZc+YJVWJMOZUKpUQ+aC3yw831ZdfYmiF+lH0rCidXONYsCbBlP7W
         3yvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793064553; x=1793669353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=84IQRr6w/KA3TdvtIm9+wari4HH+7Z0Qs3aIIwubXlE=;
        b=YkTRUr5L9ttq+DgugAQmFMX3DqlrTYePjh1/9NjmO92FyMd2+AEjJDpw7llqwd6mvz
         x/TWnLJzLcpwhYFWdT4NegxwC/EQ713v5iqHQ6KEjePdElMG32ehsgeIE+cDSWeuIbKb
         S4ZJUQtYvJvvvkvtxzxIPGw8nPe8CFoI1AgDcND3PKcrVuMviobxux2meehQeFhC+bZ4
         0GB4PAOi6oy9Uo7EDDwCBTtoVXUAh/Ausn32icEvCdhh2HNs7gltw+aQCxemPD1Z8iPJ
         55cp8Uv043ZKMM9RJ1RDZutabA24bpWZd9evPtm7IdyIY0KzxwtgnEtqBQ+GKs10mlGJ
         z5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793064553; x=1793669353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=84IQRr6w/KA3TdvtIm9+wari4HH+7Z0Qs3aIIwubXlE=;
        b=fwmB0ilHwzbfm4OfGcREW8W1lN871J6jCw7PwV+V5fFcf5lHWVgAKymOLpchlNfOY5
         Kw55scz82vUe3d08FcBbFiWNuQqTbq94n5YLCaPuWTxtgdhX8nuhUoyMXCzgAsw55tSm
         TNDu36SJnYALxuJtEkljlEwsEXPZ8h23sEV1ovRTo1lnnnw+e9I2pO288LQouWTUOMfU
         tYqxZd05rsxo/eey4APHVPRE+0XIDL+oRe/NeE7rcUd5GiXPC4erpZSfbNULtiViRnmt
         8mMI7VAhi1ryZpPk+F96ruGskfDvnhb0+lW9W/kZIgf9HuA/6w1EZc1hgEO8o7KL/0ps
         Eqww==
X-Forwarded-Encrypted: i=1; AKwUvBycYE6g+65wACeTvAYhO6bTg78mizDB5jftgJVf40xLaSx9nrr9LC/t+hSBchrP0mY+adV5GuA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIw9fCmn0NFXXkCsYcEG/GgarjgT+NavgedLMgLmD1C4GhGD+Ab
	oSOdmybp7AM/T2zqs8zTc+2o+Mz0G8KAAnL8V13ad4qbIAxcF3hPj7w3s9RPV94gBKDgiOGTTSw
	b4U5Ofp1gvzuCZLCfhP1vNenVUlzvNvI=
X-Gm-Gg: AYBFou3QV2ClrwGgEOAffX37zafUNfLuxXYaPJudTQR/f/QDL71kenQRLq29YweHsuP
	AH35f4YLKyrc3t0+4mKsFF0M0sdKTkJo2qwl36+dVrOF4wlcg3Czxa4cO4TJhmPLpmzVpMv2HCO
	iZ8voKwaggguyTEHuiE0USKbFRlnxe5oM05JgdOqCAirJbDB5KDlUDc5smkBygHnB4UW2YNO9nB
	jYU1VNhUld9UMzonzlMZSFrWK4hViQvo43b3UIF6Eezrn48jbyt2guDHgcubwtKYeBSwVTcXzAU
	pv7S93T1368h95ypCAW9z2jebuEYORxTyoZSFdfK0W9N2D98KrtQT4eYcmWqJjjDUCeOjl6Lfrm
	hUGRRHHq00jYmHTyoEYGkTDjDu8ngeR9u9DEe
X-Received: by 2002:a05:6102:2b83:b0:7cc:2946:7f80 with SMTP id
 ada2fe7eead31-7ce5cec77eamr3450776137.35.1793064552665; Mon, 26 Oct 2026
 18:29:12 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-ynl-ntf-bucket-v1-0-65aef308d62c@gmail.com> <20261026155912.3f357085@kernel.org>
In-Reply-To: <20261026155912.3f357085@kernel.org>
From: Demos Ra <demosthenes.ra@gmail.com>
Date: Tue, 27 Oct 2026 08:29:00 +0700
X-Gm-Features: AclHuK9v5pC2fIsk28H9ojMmCXZBXOGzRzyuFF5WM_mPlQLHT3DDQVbWjT7EEaE
Message-ID: <CAPtXtrn56LR6tqHc3uZE+cKdjKBSbY9ixHuQib3YimjjrFVbnQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tools: ynl: generate code for rt-nexthop bucket notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: Demos Ra via B4 Relay <devnull+demosthenes.ra.gmail.com@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Unsupported functionality is not a bug. I suspect you just fed
> the Sashiko report to an LLM and posted the output.

Understood, I'll send it to net-next once it opens. It was LLM
assisted, under my direct intent as a follow up to 457dc9fefe9a, and I
take responsibility.
