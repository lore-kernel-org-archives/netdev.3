Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D9463B9F
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387894; cv=none; b=H5H2UcrqBuckC2FHvQVMJg1jXXQeWVqMDeHcW4a4m0LcUahSj05eHqSRR1rzqyvi/ncD0dkE4CAv5Dn867nmDzs0gEbud8g8ydW7WLwaWTDEPKZWhcPR6/uY/voOJj6N/+RkNv5H/Thn2/MlDFdYjbVD21hwoFzHdquF91PGZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387894; c=relaxed/simple;
	bh=GJ51L6PU73x/ZswKbfKIZvdnD9RqEya+4zhz7G51trY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cz+BOVV28r0OnutUXSDEP0Ogk6SJgAClc5HnsY03JJnbY12H2XBcS5207ds6ddNGEt3PLw4a12UaK4NKHmM7ryAVAHmOrGBdva7SZEV/nLKhwRIHz4aJHuwCaIUu64dPxXG0/kvMQDVlMZgi7zmw+trKFfiNp1N/6AZ7EkpgFrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUOjl2x8; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUOjl2x8"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93a125dd74bso128159885a.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789387891; x=1789992691; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j7bFRNAXoBM99MsZJViu+2uBHjKDkiDMMx9Fz+T2Tu0=;
        b=UUOjl2x8UQAgzCmvVpZsaOwU47Vy377ZpUUt83Uhca3/pmeJ6S0OgXaqkdWQZgSxlq
         WRxWxm6jN4njQ38cOBTvLyp46U2ryLkrIT/zuPZ1dTKDDZ41J1V3zAKu/WUe/UameECi
         CueYdZN4XGtJ3ppG/Z4N/IzKADVa2Xb99L1a3s/WQ4DjqWwr6bEkilaxeL19ualeHuzn
         qyTj+HmuRWVJuEV7Opo2CnJENwbVL0+f37KYyjdQhRQTtqMW8X8gEsVaWuUs8SbJHQO7
         otMhMmp+yGIh0bod0JxYia+MsMn7/DMizQ0zd0e+cfUXD2EYJEpqEY1BBqLANtwGJqp+
         ATDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789387891; x=1789992691;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7bFRNAXoBM99MsZJViu+2uBHjKDkiDMMx9Fz+T2Tu0=;
        b=GNPj9HVJXwTi1k8vbRhF4ftkpGRy+NznZW6+X6tBSG17SmkQRV9XQu4cEj1otTy2u+
         Bm0TczeXnHtaZmBexe+Z8tstD9PFrVgfLmKdGo18CWWtH09A+o8rcJvPptugvlhBApJG
         te/smu59gpqpWgDa3Ll1TGW2sJVsvhrMfPC48jGg4lh5oI7qeqhrytTr6q+1hayNbLsY
         xmpNl5ABVlLDP7UvMGWMitAaNxmrQJ+iY6qZu0o7cbHZng0FJVZX58exhUvn/63W0qxc
         NqI9IWLZRPkrQcXhP/otd6Mc0jRXCtye8roYYAwKi5YhdfB5d1jlZwG8W9KKtkDaMGcF
         uwnQ==
X-Gm-Message-State: AFuF++mNaiwNTn6uQv6axIZ3upcG0SbVqrY2lA0unW44GNu2Zfh/cxKt
	1HJXg0acagz3kGJ9AF0o4dpxXsHzV7sDt1D3BhUv/pMrrYqAACnLLbkm
X-Gm-Gg: AYBFou18QukKh+ipKH0jJK1eQCd+gU0FR1NkXQz8DuP9hQ/RN3E4J8EdRK96HHhe/hK
	Bs9dXfoIO5sY4/jWT8K4wKTsfh7xFKsofwBScXqfkBfPEuTkumtbH8uOvO5WbOguFTgRU5bCoTx
	tl8K0QxjXVhAVDlEE1vTBDkF3ZnmuZ1s1O641UG138rf1ThZPRggsU2PXbYSb9G20n3NLan7Aym
	bFtZ8kV5poFfz5VE17m6f5NVLfFmBgD5F3JTP/h17xydYVXcvG6/TbBq+fdsC8EtuEZzN6mMZ1H
	t90RxsUoBGtWQxsQzV3JhtSEo9AQaVS4dSYNWsO0PkxfJSyxP96uaSbnLKC67V2rNQIWXkByKJP
	Cnm3sHQkKhqtye8o7e9Q39tP26y0cr0baY/n/9TqoVm4ee5TB86TxbAc9oEKXT+WLLbLunpwpM2
	76auaSsV7xTrZrN5IeoO+V41SL8iJNU1U0ZLnxkMOfNIDB6kpNciexkzERtZovCW/KS9gkDnO2U
	okF
X-Received: by 2002:a05:620a:1983:b0:939:e62:bf0c with SMTP id af79cd13be357-93a29709778mr300022985a.4.1789387891147;
        Mon, 14 Sep 2026 05:11:31 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80462ccsm973006485a.21.2026.09.14.05.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 05:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 08:11:29 -0400
Message-Id: <DLF12GALA4DL.7AWICVZK2PY0@gmail.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <daniel.zahka@gmail.com>,
 <willemdebruijn.kernel@gmail.com>, <donald.hunter@gmail.com>,
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 3/6] selftests: drv-net: psp: check the ifindex
 an associated netns sees
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <davem@davemloft.net>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260912200426.121025-1-kuba@kernel.org>
 <20260912200426.121025-4-kuba@kernel.org>
In-Reply-To: <20260912200426.121025-4-kuba@kernel.org>

On Sat Sep 12, 2026 at 4:04 PM EDT, Jakub Kicinski wrote:
> dev-get must not report the ifindex outside of the main netns.
> The dev-get checks for an associated namespace are already there,
> add the "no main ifindex" assertion.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/psp.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/s=
elftests/drivers/net/psp.py
> index 5e87fb50c348..43780efb84ed 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -749,6 +749,10 @@ from lib.py import ip
> =20
>          ksft_not_none(peer_dev, "No PSP device found with by-association=
 flag in guest netns")
> =20
> +        # ifindex of the main netdevice means nothing in this namespace
> +        ksft_true('ifindex' not in peer_dev,
> +                  "ifindex reported to an associated namespace")
> +
>          # Verify assoc-list contains the nk_guest device
>          ksft_true('assoc-list' in peer_dev and len(peer_dev['assoc-list'=
]) > 0,
>                    "Guest device should have assoc-list with local device=
s")

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
