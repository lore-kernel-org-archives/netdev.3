Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDE577E57
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966989; cv=pass; b=sLTqBqTkrBy+UouEpvuMDT5aWY17xHu+2chcivIIZGZZtRpcnSEl0GIboPzPP8jLOLAzsk96aB1OnRyDOVgFj7WBbBi5euClHdgByWdHwZmYpyV7WzQr+ULm6/ebcT7E6f/vpAa9fHax4in11WNOlPw9O4E07j4ZElbfvyG/82M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966989; c=relaxed/simple;
	bh=SH32ZFxox0giLDqtaEHI/YB9kcrgRu6UQ2sDr9hVwuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f04AHQcgAXVkGJNfxKfsFS4V2L4QRuG3GSo/Wngo8GVGeykHIbA1/wggHIK8eL4NeRfYevTHHJxqcXRgtnLO1crqzDY8qnkl28g3hItTMPVTy97FUG/JnBsETXCw9spOcEUjMgqHZUS94S4hTwIdmkOvSilt5Jnviz1dlVUarvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdIrTcjb; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdIrTcjb"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso302476a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 08:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788966988; cv=none;
        d=google.com; s=arc-20260327;
        b=TX5jN4SuRRQuUHpCqCtZ7sJhNwfCfdr3Qble0JbKN58x4CnxXi9tzXKTHzP5pth3AV
         +vkewMjdSkW5S5otb1st2DjR5n65dAaBQIYG0JcLnp2lY9wndDMYPaDMtEvUDkzld7VN
         LT67DL1Y9gytQKTYvIVFX+cr8XCnWYkOHUWnbyEbdPfkoJpiJ34OF0wQf+8nU2GXF995
         lAc0DuuFdXorV16thQD9vrhLvs/beeRbF33kcLW2jdKCoH0KXGm5KWHGwpDO3gWahjJV
         ly7O66wtFsECApuTUi1hdht65/ylp0EQdihpTwC3ILCw2r1FTEZlphBGfdjprVaB4Ivh
         guUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SH32ZFxox0giLDqtaEHI/YB9kcrgRu6UQ2sDr9hVwuU=;
        fh=cyLnoRNgWsI3A4QXQScGCew77SjJ7QVy3ICAz+/IkRQ=;
        b=UzDghouDo9KCsGsE40Xp60BRvJM2ZW1mYDqg09emUf5N7MSeH4Yct2hEElGdeM3zEI
         WDu19xYam8Kzr3S8qmy3N1eYBuvgrfRJuKWjjUVRYx9yxaM7Jyt/Efk9gMG4OHLlgK9l
         1uLeKvZ44TezrUVc4KmviJCJUtdUUASB814Q2Cz17B87qFjxrbIdRmx0fas0bgiythyp
         zns6U1iZMeZIJlU9nO5CLflQqHs3lpVIYykvG2k4CanqRrbvxwDh75iL1VFW1HEMrSO7
         HVLtNebYbZVnVekgzL8KZ8JrMtFT6dwUVSAiqVZHQ/fL/L7+jIUWW4BhaR1l26+CvBmP
         SZrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788966988; x=1789571788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SH32ZFxox0giLDqtaEHI/YB9kcrgRu6UQ2sDr9hVwuU=;
        b=NdIrTcjbI84LlgQFZkH2Tggffm83Kht3pHZZcYrhzeVqRIj+dP6NoY9sQFZ0loZ7RZ
         aJ8c86lixckM9xMQ9A8+y8HzLSnRhJo/9+gx+DH8SLDQG2DIX54Lxcyn+qzAROLQghr/
         omXOebIkFWewVsfh4pMak3MYSxbw7VtuAGICjrfk7rkY/sCF+jqH5ZdBFEWqWnYgFufG
         Kn8Q6FHpEpGpJEesCcTryYFOI1vV1xkc6TJrNuYGXtu/0LOAku70Fs0T8RXBRBEcDY7A
         cLm58M+QG6SZqVgEtiU7d81XmIAeoZSQRbaMD01NTVh/XyaxD0RxRKtJsFcY5MFQCBbP
         b6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966988; x=1789571788;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SH32ZFxox0giLDqtaEHI/YB9kcrgRu6UQ2sDr9hVwuU=;
        b=ZfEM+T/DEKF97wbno6YeJMdy51m8R/xUXbstTI0jvt2yKmy3wl5myB496PQQqIrvt5
         MzfJcnlsUAGjv0miht+1ear8+FkvQmgrh9cPELP4Ty5mF5SZZvZKFhCVT7rx1NnnZGlV
         kaukjFkRzSJIlFAZTlzJTIalZbScA7/YzT+eOr92mtxjDkAUnGInH/rTb8YWq6kv1Ev1
         DUlN9juMxXrw415xyNDCy1rp4DSJqGeZZgWOmxHqRb8UnPqVJ8Po+K3ehuTcjWQiizBa
         ofCv4hsyPWmPYnxurIL6HNkJquPoJgSSmf7YT1daJdGmPcsP4Y31mIddhSa3ExYVNSF+
         CUOA==
X-Forwarded-Encrypted: i=1; AKwUvBwVQNHnugfhq0VoWbvyWmd3VMc8xSk/UHam+BMKWqD7Eo04cCMWMi3uWjjMalAEhyf32mHHhIE=@vger.kernel.org
X-Gm-Message-State: AFuF++kMJ/fPZfY8QpM5Z493xNqnw3p0g77eJ2hWyp1lT4OG0UvKbbsU
	eH3MwnH5t5lkWdHsZ2LgFU8Owcmxao3PNjm8DYuMRnUm8W7Jvfu3Y7cVvSa+b57+I6eo2/YEWlI
	ilG3lhs3xNiMU3F/NePDqd0OnwGPCNoM=
X-Gm-Gg: AYBFou2xu9qReTapMYb4xa0umPIBZ4Nc6MknUJdS06+IJAwJCvUtztbnjq7Ekqv8E1e
	RnA28eth6d5Qmq6FYMpmxUyyISnjxcbiTtr9lKzsmDzvTrZ7364zbXG40NS3ztwSShrFzDoKXtB
	N8Bgw/zH2nQ2G/skQ2dVF8IBCWao3S8fNuEI2MumBItZhXPyEXWaQMLLJhpJiSvhEQ5tEBTDWTa
	Reh/CSy773iA9xppNUunBWm9gYQjU3GQK96kxQG7BLQHrfQVkgZBr29zoTzpzERQOWbFzVTrrmq
	uWK4eizNYNQ8ZFX/k7BhwC/CoU/Cpns7AJYkdGQT62jybBZOLxunR70yn3uQupZt5yma9Bpx8UQ
	lhkAdminRckTcTQ==
X-Received: by 2002:a05:6a20:914a:b0:3d3:aec2:4dcd with SMTP id
 adf61e73a8af0-3dacbf56563mr2350571637.25.1788966987687; Wed, 09 Sep 2026
 08:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908203533.102378-1-adrianox@gmail.com> <87jyousvye.fsf@bootlin.com>
 <CAMGU2hX9GSFUqZZCx6j8wRbSCSi92bn24XmxNOXLoNc8iYqViA@mail.gmail.com>
In-Reply-To: <CAMGU2hX9GSFUqZZCx6j8wRbSCSi92bn24XmxNOXLoNc8iYqViA@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 9 Sep 2026 12:16:16 -0300
X-Gm-Features: AcwNN1V85pBVOpH70K4-xrUqSi1Bg_3u1JEq5vMRJMne0_aWS6Du7ciFoVo4mXs
Message-ID: <CAMGU2hURuqU3iAb4xE2dNJq7qMZUErQJVbzsR8vkriJJnqv93A@mail.gmail.com>
Subject: Re: [PATCH v2] ieee802154: register a device type for the wpan dev
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

El mi=C3=A9, 9 sept 2026 a las 7:06, Adriano C=C3=B3rdova (<adrianox@gmail.=
com>) escribi=C3=B3:
>
> Hi Miquel,
>
> I reworded the commit message and dropped it by mistake
>
> El mi=C3=A9, 9 sept 2026, 04:52, Miquel Raynal <miquel.raynal@bootlin.com=
> escribi=C3=B3:
>>
>> Hi Adriano,
>>
>> On 08/09/2026 at 17:35:33 -03, Adriano Cordova <adrianox@gmail.com> wrot=
e:
>>
>> > cfg802154 never assigns a device type to wpan interfaces, so their
>> > netdev uevent carries no DEVTYPE key. Mirror cfg80211, which calls
>> > SET_NETDEV_DEVTYPE() from a NETDEV_POST_INIT case, and set a new
>> > wpan_dev_type so the device is typed DEVTYPE=3Dwpan.
>> >
>> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>> > ---
>>
>> Diff is identical, why didn't you kept my Rb?
>>
