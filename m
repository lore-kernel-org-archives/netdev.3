Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793673900;
	b=dPHk45qBViwA3nYvhmlMG6KMIXcdFwdnDpxD+txnEYCkmS/x59GAZbM0tUbc8NCRmt4b
	 7ZBGc9KcIFhTGq0jbsudK/WFOg8l5W2CjBI/tTSepq054jJeKauosstVP+46IM6eZKt9l
	 XlfQkfvcgcHLk5LLRiezdCVmVHmmajOkgqcusG61YPkO+H+oc5L6OWMgMhWxVV6l9QzTO
	 y/rBJJ9QGZKltefpLwu3Bw1qHhPQ+blieST/+ylK8C6Db2C6Du6OYc+DYnNpQxpjPeJ3z
	 9QuJB56zpHtfQN8XZO22XZJeyHga2iKUv3is87UCKLRqbzUhGaOh+Fgnk1sOkB5amxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=89u8IRsq+x1BWnVnaXXxXmgEHUj3lM/X6xy8lftQEfg=;
	b=3F47mWaXTKZ0iC7eyUXmQHseSDjw8yqOi35eqig/NFbiru+VeQNs5Yms3dxhJ6D7dQZL
	 jrbcX1lRlh8/7zubbKvTqwZS+IIeQb0AYJnMhlolPJbBxP2iI3TZTvnhIAjDCiCvlfpM1
	 5XOYdH3XT4GzRQt1/xE6DeJZCG+eG+9o1os6vQ7/nOK0oaq5JoB9aW7udHdrGUqGYKpnU
	 q7DeIiWFbIkFJk5s19/U+y6inBQijgrnTxjnR/jGlMU8M4j9QzwZfcPg005JlC262dJ1a
	 2B/mcRoiM0uBwUn8DksA76C/qdqpgcO8Tbkdlo8YPLhXZwHUcbsaBm55/cV6ofz+Stg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LvfFySYa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ACA606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9ACA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LvfFySYa
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so2529a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:44:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793673898; cv=none;
        d=google.com; s=arc-20260327;
        b=NbNfZXdWWRrMzQXDVsPg17dOa3REDScCnmCub0yHuJ8/mXYWEirA43onswYfyS0O+V
         YtHgzDpO/DpFgVDl3rpcK/eb3SiglSKuzWDKmHeQKGdF8hWde6q8XDycVCftZDE0JNgY
         OF2TRpyx9HYAqwYi8jQbgSRDzZgGQWWFNMn8fedcrTMHfFKc73aOB0IPNZ502C+GJhZ5
         6+AbjB1522pphgIB+ghPLwuEdcdUpJo45dZpesMg0h2ibt71u60FZWntLXDomgvhtG6n
         dLXM5LshX05ulywNuSr2jlErWHl+5w0qC3rT+MGQf+OI7L9lHCoVA0KnyX+6JTXvc3ik
         n9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=89u8IRsq+x1BWnVnaXXxXmgEHUj3lM/X6xy8lftQEfg=;
        fh=TpfHGdgaFPrvatGXVAHC+5P6c2KPc6I/fN2ZQ1c9g5o=;
        b=G9LEai4BsCGr5que1v/S5BDdNrX8W74b/5aek1+7h92Xs7QE3+LRL0eGErnlY/dKv/
         ZNTPe0MBV7Us6h4qWNTHvV+SCaB/RTJ6BKgishRHrtbDuzFe9gcMavOIKVX/YUF4ha26
         s9Q5MNx1OMYYthoOw80wB6YNfUVt6hBJQSpEES/CmazjF6DKFD9TleR78qva/Pdw+slF
         D1c/0mj78e6rf9B5Gx7YTTGDsjXa6DgFeAqa5SLyT9v2JZ2iEYsJjvs4YPz11g2YzDfH
         gzLWJPz7VSATqePYpyj/7dhlQLCBdfaTRVV5NV45deJwT8qz73esmJCTmsOLq8WP04Kt
         /cAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793673898; x=1794278698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=89u8IRsq+x1BWnVnaXXxXmgEHUj3lM/X6xy8lftQEfg=;
        b=LvfFySYaF0Il+GWV1/jDYKuktvhbo7fL23kHIDhy0ZMh0t53q/cpuvke4F3GjgTB4K
         /mVxRquXrjUA4YU7Md0uADdeSauLE2rNJ5rp6LBXYCkZwclIhKM9afQXQpHnkkg/++P/
         sbOYFXn6d3qzdR9Az3rDr14ECxuTfJuBVv6AOnitaMwNLEhCaXDDW0aEJZo4ORtRnT5G
         2GtFQhsa1h4j6LdUOz089I4fWS/PvUnzegT/n3smUcNhHSt+6e7blGpOgOcMElV57gzx
         27OIAmxq0FAeowRdMX3a5woRvnqrmkUULH8YKp7zeikr/im7xdfFKrn/y+zA9Pz4FuCt
         FvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793673898; x=1794278698;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89u8IRsq+x1BWnVnaXXxXmgEHUj3lM/X6xy8lftQEfg=;
        b=UkmC0sCCDdSep2ChSC6vbA/mfVCUqKYGytGRS4fnmtJEw0P9596BWPDhQXkTdR6UIw
         1dGikEy3dv1C/F77YNl8v4+LTOxFxpBeBbh3dj2zLNfdAXS23thTZkwSJqj5SkQrJpKK
         3q8vtVYuILtAsJn9/3gG0m0EEEpmjwR7Koec8fvOmuySMqvv1Sa1krIuHU0Bly4vLGX1
         YKh4037z3lZTo/pii9nr1+5yLmKmrERh0BIgVf2Y1QY0uEzsS8shJ0mW9GiisrC8cl5b
         py5XSSzHuJlP+Sukvxek3KhTXSZSDv7sO53mXXOtN4/7j1kTPQMvXubuEXMaRZPmhW6Q
         SdDA==
X-Forwarded-Encrypted: i=1; AKwUvBytSYVPUd4hHgl30SrYiyF3fcoExrhaOhhBhO0Nl9KHOIzhx/foiWk8ZvGdP2KDbfyqFhT+9mI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lw9fYbT3xX0+HzCZXR0AqHb7+QeaQUsQgP19870CgogsHX7zm
	2eE3iEDBwdmUTqWzAMKdW6jMwMeAdewwHypH3sZJQs8Vj97+HlX/oD9ZgkRjmu4rtfDJvMudRyt
	L8RlXreJJReGdLRtE3olWSPeHBjWOj/dUMURjJkGP
X-Gm-Gg: AYBFou3gEAFY0J3zdTcTwJn8SBVZC+XI5nhDh5wvkiwW+DIuRhMpMmeWH8pODLPkbXJ
	B7wBJCWY2MJSC54DZVm2jVQuDj9eYwN61pn05hdPg8dUMYmSATchS3MqoHerVHq+N5DU8l7WP02
	bhvZmw3n7ViJ0mpPxhlKKq9uECSj+RpzcmKQZiNfnrveKFByKYMSQ/TE090Bea7m9kTwddL2s6A
	Dhn/+HkfbYiyT6/2T+YPz5Hao2oqTDhql/soTB7K+SObXUyavT07pEHOrZVHMJQ2MV+KMqCYe+n
	WNRYIY9hhgKVYxSu/1AhRfUgRSafNTfpOLqSDdFMwli/oL2PcmqvfLhezNJQSS3pUz6/aMidAGA
	jjBu6J9++dqd5UwBA37u+fJvdOo2BywBeCMmfJ2Q=
X-Received: by 2002:a05:6402:c503:10b0:6ae:1503:5a27 with SMTP id
 4fb4d7f45d1cf-6b53e77d7dfmr15648a12.8.1793673897842; Mon, 02 Nov 2026
 18:44:57 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
 <20261103-b4-skbuff-bug-on-followups-v3-2-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-2-54ad0ab57614@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 18:44:46 -0800
X-Gm-Features: AclHuK_1VZQHRWxizHvXi3YYj2JpXFP0z-SUn-xp8uKayImpXDLfb9CCDHak1Q4
Message-ID: <CAHS8izMK8nrYny_jc-aTbjwP8tsDkY0a1ed7F=GfwzfXWm8o=A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/15] net: skbuff: add skb_checksum_full()
 that reports failure
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 6:28=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> skb_checksum() can't fail.  When the range runs into unreadable frags or
> past the end of the skb, skb_checksum() returns 0, which is also a valid
> checksum, so its callers can't tell a sum from a failure.
>
> Add skb_checksum_full(), which adds the range's sum to *@csump and
> returns 0.  On failure it leaves *@csump alone and returns -EFAULT, or
> -EINVAL for a negative length.  It is __must_check.  Its frag_list loop
> sits in a noinline function so that taking the address of a local
> doesn't give skb_checksum_full() a stack protector.
>
> skb_checksum() becomes a wrapper for the callers that aren't converted
> yet, and still returns 0 on failure.  Three things change for them:
>

Hmm, but do we really want this intermediate state where skb_checksum
and skb_checksum_full exist? Why not fix it in one go rather than
little by little?


--=20
Thanks,
Mina
