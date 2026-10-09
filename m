Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B953AF660
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562299; cv=pass; b=QBfct/OlrutC8QWmZasP/Jd3Jnw2amlj6lCEmS+aTcKT+598zF/SVTy/FsC+BnlPqVIExlNcf0Qaf4p1mo6zq/MqjktkDjQ7Y0frHNUr4ScTiIvtgmCTZ97ZhD6vL/yTjdoQVHjxHzHwE6do0B319y359B8CaOLFpgaPfUYExr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562299; c=relaxed/simple;
	bh=wruMCtXy7SaidqAshqYiUfIEclThOLN0o3WVP1sMiRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyU2KRIJ1qrvRmlRBpXfL6ILyr8X/ZQLdUHHGQw/d19cs4zgl/glCrqpYneWOTsVqn/YQ7oyxDl9AOo8khhy67uIU3wOHBjQQYeSI93A/d66J0CxmJc0SH3dZVzp1RWz/mMKDmFalj+2Ou8S1iel/MJ2uf5cSD8E9t0i4emybNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbAIioPv; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbAIioPv"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so12020a12.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791562296; cv=none;
        d=google.com; s=arc-20260327;
        b=ESPuiRoJw6dyrtTbSxGzIT/tBoXbQUfnhpyhsWEinUGfXfD6GkXjRWwMXrzI42JAF8
         V+6/IeVuO4KtjPzP7fEvrxJhJlubEo/5XSKAkxq89ayY2w/O7Ir+iXYCP69I3bxTernx
         C1h1E7PpFR+LJnF4C3J4D21ynGjVLECtQ8unDgL2KHoWEArr2npgYz471w8MMQItEF17
         svcL+xyug3gv92J1yAD9difXEqujzYMIHHEDO8VEDoQxbMjxTBV3g35LtNehsfDhxY5g
         HgrzD/WrJ4Bd/Thw/Rdf5GpYzuTthsVipcM/gSTb/aK49SGGK0ubK2/6SXg8j4sxR+po
         ExFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMY8+4K3G/+VX3FzbqjT/yR5SuMJ7etOIbd7i1CeENM=;
        fh=LhVFQN7Mq1C3FP9QDbBvuNHaJdE+YJGI+hT6tPWY4AU=;
        b=IP+tMTBmAYug0j/DtohCgpnMesw14iGUa35gzwgPZAnigA/bVBX3LEBASZk008JdV0
         bgaLw1lS/DbJM2fjWw+ECVo2H9Upy4z21wWFraYJ16SJjLmHnKJMlnlUqYF0owBeChwG
         /fb44NYA42MByVzW/GYcb8TE7RQUze3lwKigEh2uXrTPEYi3Ie2wZt3gUMbns1u8ljzJ
         BBbRv34PCU7d40IGGCzsON0T5PgwtoDPoDrY03P0BNWQxuil5Vv21WtP8kvmTWrkXuc9
         r9/oQKw+IZD9rsfiyKi+ecu3M9YuoDTAOTj0MLylvpG45NtLYyY7AuTpDYqARbqN/htE
         Wugg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791562296; x=1792167096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FMY8+4K3G/+VX3FzbqjT/yR5SuMJ7etOIbd7i1CeENM=;
        b=VbAIioPv5ZrQGr2UOclc2HATlUsoTuE/N7m6AKiGDp3g7O7YsQ6hHfnOE8YR1XQCpb
         2IzR/dN3t0QE/8paeKo4ph5JmVzXv9u8JoIFRwq37ewzgIL/R3jI7QxpjOA1BgDJE79S
         C8GKR9P7K088GxbjT6jaIMXWfnoTjtbDkbj2YeRxQhmvuydZF529udmbmMJY2v3xo5bJ
         UKEvMtA2SIecJn0WiZmcQJWtKl2x/vu/T7CV0CU2SRv7dRvzl37KMFgwgH9mnb1JZD2Q
         MfrXwHqYbcGKdTFt4B24/3mRCaDnf7QxWS1D8u9TCMWmGLO4ODyp9yo9j46/Sm6LmUsG
         yefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562296; x=1792167096;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMY8+4K3G/+VX3FzbqjT/yR5SuMJ7etOIbd7i1CeENM=;
        b=wYWXokjI9NBzqUtj42WKOd3mP6Yy8p3uWe4n9URm2pqkk3SZb0AujMFyV7qSWzRcmz
         2j1eUCZoeESUHRV+Mtf2RfK1R7N7GYE9pZAiJVb6FqKe4f1vb9lYPbdAfVzy4C314omg
         6NMO/K8ELUflktwDJVYxLD9NGxcLzbPdhWb6gimgWekFe1I4nLc9NtBF9AJgl9Eg8HZv
         7K8aJ/7pZOWB7HTWnCCNHaScLx0DMWgWTQfXgZjIXd7z+3mD9Fp7ffWwwUoCkbUhlCur
         N1wkb6UFIajhN2dh3JV1wTyhJmJaqbw5RVCQzMYtwOTcx/iShWBOcNBhM2TT15G+Y+eh
         jnEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYjsAhAs8dbxbbji7E2krXSKSMf3sORdrGW7krQj+DtMZavpi2+3h67tw4Hs0pAv/kK8OnEDs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrn8FzX7/cJ2EyNfflsDUV+e3ammdGq1eqtJ/PLBmUnSE5Tk5d
	aXnB6p+yK4rw9oc5ybPzDW+xURBA7PA3vCzTDmdjp/vmXM8Vwh5Wa4iizC+VUEFTLa2QOzkRCgk
	OqKsf3awDo0iEA51vjDgyycOKHyeSqoczX2vqHZ8I
X-Gm-Gg: AYBFou1EDQAeWNQG//INfBzk2TArWfu4RU6B6mfwj3WZZj02OdCV+1xRMF4WvbNGyIu
	SDGrNaSAImjscLhEGe27lrUIaw+Eyxl9fcKZRL6Zu/guz2zyUJtnFXlpkY0uXw4DY+nW3taME33
	+RSRTKpgk7e1LMIWKjjDAAx/ftsURg3TL+PZA2U4rpts75E70DKAb3IONlXZKZIkKr79nGs+5FI
	oiHTfrqL/XyJAw3NP0Axwr2wbB+A4GLJfEInVJlcs+3NWwIdq8gd8AvzmPFjpKsQ4nP6cV6RDkv
	ML/cDvos/trzGflU4ZdUUtk4z5HioVkwvGES+dxGAkzmthjwaGvDdUc=
X-Received: by 2002:a05:6402:404e:20b0:6a9:f353:ef65 with SMTP id
 4fb4d7f45d1cf-6b177f1c488mr52368a12.5.1791562295275; Fri, 09 Oct 2026
 09:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com> <20261006-b4-skbuff-bug-on-v1-8-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-8-1b4434c5357c@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 Oct 2026 09:11:23 -0700
X-Gm-Features: AclHuK9fcYwhDbADMIDURGeGAhGxa_d-APkp5QvjpXYNwtTkKCU00ou2GsgfiEU
Message-ID: <CAHS8izPxwo35ExaJvK5FgGG3TGFS5uGybk5O=ZoY_1=z15Z-ug@mail.gmail.com>
Subject: Re: [PATCH net-next 8/9] net: skbuff: don't BUG() on a missing
 head_frag in skb_zerocopy()
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 10:10=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> skb_zerocopy() BUG()s if @from has no head_frag and the caller passed
> hlen =3D=3D 0, meaning the caller didn't ask for the head to be copied an=
d
> the head can't be referenced as a page either.  The check runs before
> anything is touched, and skb_zerocopy() already documents -EFAULT for
> bad skb geometry.  Warn once and return that.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
