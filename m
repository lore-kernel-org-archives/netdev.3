Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C836CDF3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748997; cv=pass; b=pZLeNjzNr/12zryMs0zJ0sCaKaOBkLlwYqJuWidVSw1PTsjGRxlCNofm5t0CaNJf0KsY6+nSJ5sSUJN7RUjNVRs83KhU+2GU+HBkg6hWUMtqIyO9FyOKIs1j7mF4kpRxAxPSIJyribiD3YKKFbqfdd/u8ozWTMmouKJcn4q9pW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748997; c=relaxed/simple;
	bh=EiJruLiXHTfayUASqh6hHsZKhodXxKj9AET02kAAvEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9vEdEYlqiI3T3nwcz41bMwioaRn/e5KCbAXk6M2ujC+1HjgQy+W2sx21S5zJjTp2zxmaUXYdMyTNkobQij0JeOq6VN8W8zum/6F7OHbZft1lE+928MXbhKYTDpb0y3KyaXkaYuKDq1MkGxzIBxt2rbXVJpypPH3jRK+8qNjzk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mt+rTJbn; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mt+rTJbn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdf36f63dso18355ad.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784748996; cv=none;
        d=google.com; s=arc-20260327;
        b=fXSIGVSwsRLLWzacDTFRGvypMRvqi0+JEWN2wxGgWNfWdf9SkfFL6VdNF/zmwlP5Mj
         zfKRVPepCf4p3DEyaz7k3atdOK0AuvIh+ShGmjdKoOGShiShjnGUTTdjfANoUctZYcFz
         NUliQ2ujXSA83ArIbg61wNeLxPw+jC5zdddZRVF+sbL8eCx4zXM07/aodzBiXbyKPgyP
         OAguShHwijeAdGOqMQ69Ec4dNYFgyB9b53Y2l5EDwTDTB2tPuNfqjB/ZJacVRGhu30VL
         KpvZIatWemf0BoO7umTqYX/US/nZjD/Ea0o7ggtWAYbZDu8Q6MzuI7T9sb0+JnJOV2jL
         8ukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EiJruLiXHTfayUASqh6hHsZKhodXxKj9AET02kAAvEE=;
        fh=bcKy/GiNFFEKblLozVWUe+9ePgoCjUvPhUCZcCfeIko=;
        b=eTQYt+RMV4WLTC6etQrDESMWHuTAE26EfBbpl8KGFmO9g2Cdmjpx3Hbb1EOnLAqiD6
         FDH0A1qIJcNFv7swUx7AVWMLRKxLGVwymskJDUHtsLF0rOWGklEXNZrGsezWfQJPjriK
         LmIF3esLKnUWNgRjdkQpxNksj32dcZAtS91xjKDlrHBn2ueUmZCMABmeqtMsZ2yxT7yp
         rAQE6Tpfc6Syv/OAWMtkpYM06ZcKnbz25LrNLxa1ISxFd+TdFhQJNOXRchXhzyn3hZmx
         y4OX2i8k6LYtUeXYIHZKkTWONdEBlDgv+Y1m6r7ee+kWmGQz5y1FCAtkhS7JBFpsEI9T
         tx3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784748996; x=1785353796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EiJruLiXHTfayUASqh6hHsZKhodXxKj9AET02kAAvEE=;
        b=Mt+rTJbneJ8KMDAOmOQFQIOfb3epyDddyOzbPUtq6ZCK6J8rffp9e9DyD0Vw9BKd4K
         GNOtRNtwrBz14vebfVOd/iK8mAhpIGJ0bBbfbkdd+YWvwfkRO7uMz+Ol+3MhWL7PKr+c
         EcYxZgNaZp2A2NhpcnM99xtimwpGXpOKk+sPVjxAjLPJrYDD5w9AD1koPWsrcoXeT+Es
         adsMLNuV7pmELIix1+vOswMMpzit83Ca6HDAMEJgzpg08M1LG3vGkbqa1p3wBAt363ok
         JJvS2z1c3Q+WDqUUyaWHfDoqFIKU971RKwwdOnMF0bUQdmSk7caDWWbhohURmKvwI/Rb
         7yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784748996; x=1785353796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EiJruLiXHTfayUASqh6hHsZKhodXxKj9AET02kAAvEE=;
        b=myQZuFiM32b88yxas6KxEHIX20fhLPhsoAJ2z78+EvH4/BgDfDw+zkE0k85G8rctKe
         9Uw2MtalJr2M/no0N3YpxUU7FwTvrFFXf76mSsdohgiDMRYgxV6HYNOXRjePGzWHMopk
         26P/DZcr7rLC0vdrpDSTwqFoOnA62hWRJwVjmj2acvGbDaG20Fz7SYTDv0i44rBclWbP
         36Tfmx7eEo6pTaQRFjT9REpXwpylQy4AxM68keHU0Czlu7ZD0HDxT41KAf3IL7wjl7zx
         b550pvCG2epUHZdZYTg9dO4W04Y+6RzTSXBsTuaMIv++1TUONXjZ0XKD34paYgrp3mFn
         FTVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpg+WOnQwz2fP6Az8r535DgqwxEOJwkpERSVpimkSiITmMx9KsOF+u1FxsjOx4EHswmVJLkCwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbCR8bYoWPJij0QQ5fU+s0ZFX68RHjW2c2A6KwZceXGrHCsZV
	jbgHzucvinHTxvwftUsb0fozHcjqBf/aRUBKP+YwohItuKdHavfYUM/1P5kD7oj5CXrldksLdN8
	FIwpQn+PZFfWcBt9rJYY3bfQCseoWZhO8Gvnca4du
X-Gm-Gg: AR+sD12Xlzq/7NgUFdAGuCL/ubjyGvKBvzUHAeCwtQPfPuZEyic3fc1mP2whRpylEaK
	AMON2jHIVZqN2M29+t6oxKGdTgBQR/GABZZ3ZgkAn84n3EJZX6laEbzvXtJ3o28JfW/g0txOXLL
	zPLFmL/QVhXJw5hsK53SAbfPGO4K60nhUvQffP8A3WCaTbUqQrvFicrvf0bvivN/oK4U6MpMhNl
	ctG3mlsrjEumxmfFpEz4kYjliXw7Boc8zNRB3WFWG/kOJWbGlUTPaAmjI0/jd/P1TEJRYqX3tXN
	aZ11d/dpyzmGRZWO
X-Received: by 2002:a17:903:1aaf:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2cfa4ceb478mr1045345ad.6.1784748995228; Wed, 22 Jul 2026
 12:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784726895.git.asml.silence@gmail.com> <29bd4fc069bc89691868beba0627ffbe570c2722.1784726895.git.asml.silence@gmail.com>
In-Reply-To: <29bd4fc069bc89691868beba0627ffbe570c2722.1784726895.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 22 Jul 2026 12:36:22 -0700
X-Gm-Features: AUfX_mzcuelw9SCeU9LLkBiRe_JuM68jGvxrXASgyh-gCe9WcYipjorhBZQSx8Q
Message-ID: <CAHS8izPxL_YP7jrwGESHpcEQChqYo-ehNr4_RygcUbeHBF7D9g@mail.gmail.com>
Subject: Re: [PATCH io_uring-7.2 2/3] io_uring/zcrx: rename ZCRX_NOTIF_NO_BUFFERS
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:50=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> ZCRX_NOTIF_NO_BUFFERS tells when page pool fails to allocate memory from
> zcrx. "No buffers" could be more confusing, rename it to
> ZCRX_NOTIF_ALLOC_FAIL.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>
--=20
Thanks,
Mina
