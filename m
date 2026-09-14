Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98946C4AF
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391115; cv=none; b=RK6Sons5AAigDrjLzoP1ChzUgsPpc3e+bGdVmURoIeTYb3+RYlfcSnnUopgGtkbKsyM/ta8KRiCCm4eBmUbIBrSD7xqvy9Ra6MPmYp44LNZ8cCuq2Hmnxrc6VL2BA2ENBG5PgquDO58YcLrDbDnvYG5n804VKLrnmSD3e/uIXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391115; c=relaxed/simple;
	bh=upXhQjpBQFpFfGgf+4DrDtiEUX5Qlzxu54HWm/7D860=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZJFyY2goM7RWCAZ+Z4phoqH8pb6Undz1rPpYq0n/tNYGhGlBCDIOi+oPgXowQdiC0U7MZe6NCVu3KaMi5nJJdGoeTz93+Svh64DLYbHjO+vfOeUWDoomsEPiJxnHDPZ8fe751ps+KMwRjQbxzelbt9nZfOYKHz6VKqQ1h5NFMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aD5Sn678; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD5Sn678"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcdso15545767b3.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391113; x=1789995913; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=upXhQjpBQFpFfGgf+4DrDtiEUX5Qlzxu54HWm/7D860=;
        b=aD5Sn678RcQbNqY7E51gkkqxRLbfAIO7E3OTzLIwM/yMOTn1iRz2NG8KPfIWBMGMn5
         KgeYVNE1liDCWvPbUWYILWhdF/RfLoZJde873gU6xd28Zqetrp4MhjdFrj2UtOZHFcKT
         Sh7yh6sHeJgZEWvm2t0LNRxhHxKCfmzmdUdaFHvl+3Kortr6gVCIAB1qUy5k/vzrj1B9
         BZtEs0elY/VTn/6Ietca6f+GHhJSdzCimYKRS60youz6UXVHXR/9SaVU3fBa5AJHuqnz
         36rZTT/bNfeejkfqjRgPjYb8fEP34enIoewGQzpCpiWUZRhIt/IcOSTtwa2Vzkuds1Sh
         idCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391113; x=1789995913;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upXhQjpBQFpFfGgf+4DrDtiEUX5Qlzxu54HWm/7D860=;
        b=jUoWLo70+3/qswtZCnyqft15kUMofHjGbE4oUaaYmjY9DpiMacVEJD5Fqjnw40TpOJ
         gP1pKrtliVAQHzeFijYbq0dDYIahl1Wf0OaG+03tk7XeQU5IeVkbYb8SuOzma3/3Hqo/
         nma+NDcR5b1+xMWY33pkPyggCzOKmVJyrTCRP+fpZ1ZeZYGCSHUHtiwSU4K8jAdNL7py
         Znu3/F7Cx/QEP8hZ3HmKcGeEhcIZG99zgYkXlJhYG0YL8EC/fjJ/krnagiyq69Efhc4c
         vPJ2JvBDGbkI02G8IAdZxI2TItWQgpH+qqwnz+AeJUMho33DzGwe267YC82Hc3tO6P9d
         swZg==
X-Gm-Message-State: AFuF++kUzree7uOdT+ZT5W2hAM2ktJWqtgbEWkdoMbjWmE0fkxXydOql
	c5rRzsH3++3wFy+drNH43DpsKB+qulSxXtp4a+9wilLOk9/0bVCTPaao
X-Gm-Gg: AYBFou27fOj6fArHTySiiQn1EIxcCH5WsiGZjXD0CVqU0d0SYk8C71PvoS+sRLClqyn
	vwSoJlKX+vPoGUMo6cnkWeugSwGzkifCWByX8cjCjhD0bN7ERiKibwSozyaTuJ52PYP4cbXHuBA
	AKwYUTDiogEimZ6FKrlPTyQ69HnkPHaPlSKji2murfrwaDno3KJY9/g9oUpBXn1n6m3KiEN13ez
	G032MeylfQgsx3ljM+FSnKRYqfeoxZSEKK9RKlNHlBGOG/+NzzSjmEy8C+AQrQBwY22WEPzf5Pb
	WcFFcn8aBJLU3nMbDli5eX/ZyWn4nMvlEQBsXRN/sl8M9fFY+5NzF6YGelCM3FtJcdnMOzuJJQg
	+pPzpRYApFU6dJSgdbefBxS33WGiSIkI50J3qr5IWyjxkTpw6NuhNs03hJBERJwrtpYi8nU5+0M
	j6s6xp575rtZhffSUBkhhA+ofin+Ik99Y78IintHvvMGS6Dhn+5kpVuhBuTBlFC9tqmPMDL/CMX
	eCr
X-Received: by 2002:a05:690c:388:b0:858:ad19:324d with SMTP id 00721157ae682-88d1f213acbmr10131997b3.3.1789391112643;
        Mon, 14 Sep 2026 06:05:12 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8848711b85esm35905357b3.24.2026.09.14.06.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 06:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 09:05:11 -0400
Message-Id: <DLF27K78JBX3.1R3FD4BNRUFIJ@gmail.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <daniel.zahka@gmail.com>,
 <willemdebruijn.kernel@gmail.com>, <donald.hunter@gmail.com>,
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 6/6] selftests: drv-net: psp: check the PSP
 disassociation notifications
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <davem@davemloft.net>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260912200426.121025-1-kuba@kernel.org>
 <20260912200426.121025-7-kuba@kernel.org>
In-Reply-To: <20260912200426.121025-7-kuba@kernel.org>

On Sat Sep 12, 2026 at 4:04 PM EDT, Jakub Kicinski wrote:
> The main namespace must see a change which no longer lists the device,
> and the namespace which lost its last association must see the device
> go away. Check that on both paths which generate the notifications,
> dev-disassoc and netdevice removal, and check that a namespace which
> still has another association is only told about the change.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
