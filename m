Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013744457A7
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327729; cv=pass; b=B/FP1lNZiSCS44AV3ymKdCMU3xplEnJHmg4+7g/2lhNu3b/wvyIvKl7/zO5UbEV/KaF0axNELnjEDZ/yh6mfaizQYDcUaLkHGvUgvkSF7PkEVgwLJklvLdChbXTeNHRXMH9qvUADYRaWGJgaVDcXMbIkcXx+H22BJNqEQBYzKuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327729; c=relaxed/simple;
	bh=Yu3Nr5li7pjGiJseiwJRXlHFuiehekQ7GJvyTnmjia0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSTQw5Vm0gyGxEAHW/50XWGXp+61t29zqv3aASQe8AoFXtnT+rj4g8cqmxO82v+7DWB5PBvw4yySPiGQtuXAYNsosoP+YV6dieB/WI+u2l/Y+BgkqNIIkxzKYXN3CW3DEjURgBzd20lNYcHKAAgualXqyUDapgYH4Yvmstc43SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdcIL6HJ; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdcIL6HJ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-451fd21113cso754209fac.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785327726; cv=none;
        d=google.com; s=arc-20260327;
        b=aZgpom443mCHTLOj5N14CvE5OSjs9aV+LjLuhOK5EdzuF+0pveeLOXI6EAPLprCbKM
         zaAa0+Cp8jnm7vd1Ko4FUzoQzWZ//H8KS6COqzxjCtrYbjLCgCcms/j7qDfWBY7+A9cC
         2VRoJ+gdvu0WhrRnr76Kq4vLclXDkzsRjPV70zO9/5kTIVzrWOla4w3dGU5FALKNQdcl
         ZvNhmrDZaSV02xxhiw8Dh26ejmcgUnpCxFcLN9VwpO6B+Gf+QjYDw/EQr9Ap3q7SqzMc
         u8S/GPRIOc2rH2P06iK7iofEpJdzf5CF4US/P2URm5b5YVZ+j7xTUFUrXad3pS390g/O
         Zp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yu3Nr5li7pjGiJseiwJRXlHFuiehekQ7GJvyTnmjia0=;
        fh=mRDSWkA6iej7DPtT6JJUH70vzz1V7a0f3I6+zNjd9G4=;
        b=VQnoSH7hNNM3F9eNJ76Ke6sLb9uIENeANtkyruV856tIQRpshpc66hWMzPkQaQB/EO
         kuTlT6w7S4CyYvpE1CJmvpbs8aQwjjjkuskYKxc6VBmuJ3f6+JTwHrudZiDvWIE9jjS/
         8IaGiVRRiY6bkQ4zbJiaIRupEO8pjz9rd/AF3ORfxsI8XCbIGjXf2HbrPZ8LIuIQUNwd
         CRpAc4uR/DnDGXCn5hd/YtUdmjVpD/7VzddEER7oIDMRGc8Okyd0JjlJ9LuwhxvYVrCT
         zHZWMNrsCljGJ90W+IzzWkD//6LZ+/ViOabDBR1npQj8f2RU5XQoI0aC0ZTOCyVqdJ/H
         mAKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785327726; x=1785932526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yu3Nr5li7pjGiJseiwJRXlHFuiehekQ7GJvyTnmjia0=;
        b=gdcIL6HJgyjCZyT0hO5KUpi+gn5BVkq6ht5wbR1sg7aAJ/+D8Z+/p6T2Lxct0jdl3v
         TB8N6rcUUw4AlOWqFhLq4ibhaI58a2xq24ASYtM4GInbZhw4om/ggra8bp4Ay6nEKeHE
         bFi6YSaBnbgXNUC5DpIfp+f+g9y4I52c/0AEl3aSRo4ZC0ThxkfNPnvkVxLARFG/CtIJ
         jm6sb99lImRyjXWnuO44KW5mhYtmrKIJqaHesgf7cGsxC0jqKQMGdvMeK0l14MZ50JY8
         Qx/94aHKtSUf1etr7l4rH5fngBDt877n6z3sPKjXmtXtlYWt9uKsozPs1IKdaBEQYSY+
         AWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327726; x=1785932526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yu3Nr5li7pjGiJseiwJRXlHFuiehekQ7GJvyTnmjia0=;
        b=Zsebbpk/azfzCINQcpjJyBQ1ms1EM3ZvyqM4RQDcrF4Zq5/35ZUChFNsiBtIzRg6xl
         6/JYYhuZroKbOaH+vGA5oj6+esYPdt3g0Efm3Jp6JPGpTXdIuBPJ1J+6cAX5Iy8gKgl0
         eCNFMYIz22gbwy/SHBUH6onnq+fQ+9FSlGjlCal33islqvoovaI8UMo958beuot67z0S
         JJv7TojXt0QomQScJtZWIXXfHDTP031z4QcKgGnLEnh7eX8XowiwbHkRqDIbwbguytYt
         0V16PNU3WpdbXI+PA2ubTfY0h5G+/EERttGDf8Uwn3f8z6pnTpnGo3AqV673+nmaisaP
         CpcA==
X-Forwarded-Encrypted: i=1; AHgh+RqwwzJ3hcIWVaxd9bXBirzqqSaS5matqiokzzY2zsQX8a2iNkjfPw4ZVxsGBh0N6UWBuAcA8GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQZvWT0S3w3aGwTW73jow2HeOtpRVnp3D+OKqAKULCiYVuOIFu
	yKLLTOay+LkTffNH5//rwG6x/GF26uJhPEfGY3/2lwfNHcBUJqg0ZGJCaZ6cv7qpo/bOgnBhDK7
	a/WMpEXDTb6rssouIIiMssP79yO/V+0Y=
X-Gm-Gg: AR+sD12IIAOlpxrLAnBh6mHHR1GY46sP+0BQ/PL5ED7ps2JN/nC6U2YmnxvGYZJ5yWo
	4cgKSJax6+tjHh0trN21GuO2WDY4Dj6SE25W3XaFSACUzUHAZynlYx/AI2FJOVRtILhIGP68G2k
	g80M7ECaMBeo2hghh7UIC80/oJoMGMrRhzX8DBPIwHqK7nyZh9uekm8T8pYPNSd2KNIZq1qtm+G
	YXCxE8pn781fe2EVZB5/cI8PSBUNlPY5pJ5NHO9RUmjzEZ4dNVhIEKIH+ybkCcNCFfN9T0pB91f
	KLjRpAfN7M5znLIC51AgEuLgoBUvBMFhymMKS/PUiN6Y
X-Received: by 2002:a05:6870:e247:b0:451:cba2:10ad with SMTP id
 586e51a60fabf-458962765e3mr1107636fac.20.1785327725741; Wed, 29 Jul 2026
 05:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729032912.55800-1-syjcnss@gmail.com>
In-Reply-To: <20260729032912.55800-1-syjcnss@gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 29 Jul 2026 05:21:54 -0700
X-Gm-Features: AUfX_mwxHxLlLzvfY8UKucbgkMwP9mUlP0NW7afNP4hgJLh-et-iSEW_6sFpXFQ
Message-ID: <CAHsH6Gscf6R2-+Uyo+Hu6DqTC67DRO_4sf1crVXgM7u8g5hT+A@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm: do not take x->lock under xfrm_state_lock in
 the NAT keepalive walk
To: Yuejie Shi <syjcnss@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 28, 2026 at 8:29=E2=80=AFPM Yuejie Shi <syjcnss@gmail.com> wrot=
e:
>
> nat_keepalive_work() walks the SA list with xfrm_state_walk(), which
> holds net->xfrm.xfrm_state_lock across the callback, and
> nat_keepalive_work_single() then takes x->lock underneath it.

Thanks for the fix, but I believe it has already been addressed in a
different way at:

https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git/commit/?=
id=3D763fe700b7c58ad64fe5202c5638848244dd4127

Eyal.
