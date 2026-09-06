Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0F33C1AD
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714568; cv=none; b=Mpz/TRgkynimQ6Kn529mBr2uNyi/w37E15BS+g02U3XAL+vdaUNzuGO6jEHEIibizuX87FmB8ib9LjO8UHBNzphVe7+GRnlMApeXETH6KSSw4AkxAcSMl3n5tV1giIr0t+S6mzH9aBv69Mmd3jsZXvkSUwbl61d6qE/3dzeaBRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714568; c=relaxed/simple;
	bh=kwIQkP/XpcdYd1ifwR6RBvVzjzYlUAzVO3Rm/HIniyU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kEwFJ1o1gVHoXSNxGCT2vK+kYVbj5zMfLF6u2Ktp3vkhNGK+kFBk2vNTtffgk41feJqOWzUL7sk3DqEUxwishSVVZu54c6McFYv0n1fhVoklN/iKzReuEseGP2+MF2oKHozHMT3sxANtQB6JK/lwSiPnc4fyVZlVEfmsIhnmMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p41F30/P; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p41F30/P"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8664769db58so9097917b3.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788714566; x=1789319366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OLktiA9uI3wr8iX7SREQBfG7Q19A9rLrew3z0lZbG8g=;
        b=p41F30/P050BVtjH1FtfGSTlCccqJkG6sbioflyM87QBfFRMeNJA0ZhsYOsNUuSdgt
         L4n1CU1LG43bDA6Zs2tX6GCQp4zzSNBkxvwRdw8v2km84xlIfpM5+QlzhzS7badOr7Mj
         pqv1Dvcu4G9luMUnPXflUtz27WFZqU8E6r7rvxx+ARBCrt7bPIV+ZHN3OQo1PaKnPOJS
         dMeUdG1TSBfdSsO6zHq6cySzYTJokfcXPM2K8FzpYFEZ/mWmgACDTyQ/RlZiKS/Wogzt
         +cktIfs2neGH4CHQmo78dceRzdpStYZpF9ALHbWemVabI4ys0sfwUqMN+TK1KGA8yN/S
         UGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788714566; x=1789319366;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLktiA9uI3wr8iX7SREQBfG7Q19A9rLrew3z0lZbG8g=;
        b=PlHYws6v8h5RSbTkRi/tdpxA1s8OVyrgkSbzcUGtvmFANgvU0/DzMDSLI/4mBIBrER
         9JCroi9wOG8R0pOwUOXmJazZyVobeN2vrmzBlgpYaNAB1ejPtwUrqY7uxSJs1SC8GKl/
         hfh3YMvYB+DNW/Y2mYZNwQInhoXft0HHczHFfeXcFRZOLfw6dWW8RXee1et/NuRdReLZ
         lkO0VgbmJEtoz/y4o94A3Th9JlHnfL0CU9otC1/b0qOtHZGUAkIhhnJ7+wF9jH+2Mcl1
         K094ybdd/i2v+92eUDIT3ZdokmpNAEqfzKOzRQNBxpDtkYnQ4Q7P9Uz6KN3RTYEbtMu5
         6A5A==
X-Gm-Message-State: AFuF++kRB4qmzFN/E0DuuAvNxk3NkzVsIxZlhtbB14kQKGS8b1ruLAM+
	RQvNZxWSXPI3hOo7n1dq/TwtHOzP1tCkxYyvlKTekuhhKK3gUTchkLZZ
X-Gm-Gg: AYBFou1rf9IarRNjyhhamnODTh++TslIP59IWaomJBPctOzph9Zlwrv0S7RXtzlbHK2
	ycisuDTo/dX+XTDOZZXep58nvnUG9prdHiTsOK+udWYP7gB7OUeptahOK0KYtarvSmijnPvoEyq
	fANARsYzD94ecRArvdJFxbZpQXXwd/iMkNZZjZeAeS89lAxxuyXMqK8MsFjHwtoiGd2bKAOeLbb
	j48LQy7gc35oKK4qpBDQZr5Qh+ik9RMc1xBVUK7ZpDXtbfda5fMocRbWxYx70kacKlLq8TwYIER
	BauTQb62wMxqCnKiOF2FuyOWYS0xZPEOI6oVZzsTQz0K2G6IGYJiY0GY4q5sI/Yn0dm0K4R7kqc
	7XVrB402Q7HQ+fIPKR+SaOObd88L/X6Y3V+QqFDafPnRBALYtBE4TMcsv7q1cpUq6BFuhh0i8fB
	+QfTspDtAVRyJs8Bof3ju1ohn4o9gIh1ET6ctht6KgqD5eV1Ql0PlWYNkJmFu/mKFtEnAr3MJke
	YZZHePA/L4xmRzv685+LbFF0jLVB9Wx518eB/9LMg==
X-Received: by 2002:a05:690c:c4f9:b0:874:f21c:2a0d with SMTP id 00721157ae682-874f21c35c3mr20020327b3.69.1788714566358;
        Sun, 06 Sep 2026 10:09:26 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871439c4566sm58475247b3.4.2026.09.06.10.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:09:25 -0700 (PDT)
Date: Sun, 06 Sep 2026 13:09:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1a11ed358eca@gmail.com>
In-Reply-To: <20260903-psp-prep-v1-3-d47e9c4c375d@gmail.com>
References: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
 <20260903-psp-prep-v1-3-d47e9c4c375d@gmail.com>
Subject: Re: [PATCH net-next 3/4] psp: allow drivers to omit tx key add/del
 ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> Drivers that don't use an SADB for tx key storage don't have a use
> for psp_dev_ops::tx_key_add and psp_dev_ops::tx_key_del.
> 
> Allowing drivers to leave these as NULL gives PSP core a simple way to
> determine whether a driver utilizes an SADB, which in turn could
> affect how PSP core chooses to handle certain situations.
> 
> For example:
> - deciding if tx key deletion needs to be delayed during a rekeying
>   event to avoid in-flight packets using old key handles.
> - choosing whether or not to report device stats like SADB usage to
>   userspace, which only make sense if the driver uses on-device key
>   storage.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
