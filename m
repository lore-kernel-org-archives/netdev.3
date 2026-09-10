Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94E4825B8
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048090; cv=pass; b=FhoiKK6hCf7AH7MuFYSzf/Yln8od+F1wl2d5MzMmvcbxUfz/OdQhU1XNtL7KDvKlU+286mRC6PHYDcrLQ6v/WVg+BTB7VX6x2LOYp2qkXgX4OyUl5VlgXhMsGo8A80WwGKYwRXi6utwN3KJMnQ6QJew1pTqxp8wPTur7mGtS7Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048090; c=relaxed/simple;
	bh=FxLs2vs/J2uylK62rLnK+7N5L66TpTnceqzDX1Jt2Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UM8xi+LKVkl+tPLh+skQD6HKKw5VNQlcOZoygd0BeiRMOoDt7aTlmrYdMDMLmfYPwagpCme1ycA2JO+OK9UTRpDkbvBUx6DqZCdvIf9AFToL5XkZkMbMKKYa2/eSqmtgt4FC9WjQfDVzHUVqDVZqyE0eyDk96O4fU7oTjI5uUNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRB2mlx0; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRB2mlx0"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-86a31708876so417757b3a.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789048088; cv=none;
        d=google.com; s=arc-20260327;
        b=XB6yARMSxI5VpVGUniV3Y3kow2pFqg1/t3g6Uuu0QweIOVtQU1GkWkE+8t9YU4Dy5T
         aezCEECkMM1NE+IRt6RIb/nX46zIlT+KOipAT+J91SKWcsdSOPnRj3Pec9f6XAf7z0cY
         yqqbBqvPBKiNMRrMgPRVnY2s5L47EouYgV2oZ6I2UYPzUHWgRdwvApziDlWxJM/I4X7Y
         buX4ma1QUDQSCIBkVusfRGThEiUijcQdPoO9hOK8uU5Np/Nb/F+LeXtahNgFxlLRK8Xc
         IEEv88PqWf7y2SadIJ45ETiQQn0UVBBmrE0eWLIrI2bl1nLrpTs5REgzLXyCdnsa0ZIn
         O8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FxLs2vs/J2uylK62rLnK+7N5L66TpTnceqzDX1Jt2Z0=;
        fh=XV6CV123N1IyvSX/OLKqBhjKbI+t7KiCbFGE2FKlwkc=;
        b=LtfXGw940TdFmMWbGlGW/AbDxCUxAAFzkibYEs5G6tTLiFcRXH1njJ8r+up8ee2IiW
         fmBP8ihs7Oz6XkTSU6rJfY1fRuRwxBXtGN1JxIstPCjVHldQVMzi0g4WxE1zOzY1zUHN
         hcknCTCgYkNrfUtV9vh7PjxuuDcTocOuayDemV/LRDj4FOWEfz6A2Lrvty4QbfZSn4rs
         PTyS50za2GhYTVpSa9TIhTPY3XkHCXrjIBcW+4vBWoqBN8YTS0H535SZXONYMDNSKolt
         iSBmqxfJAquTGT47l4UgYrWJxqKGJhYcYXrh8H5h4gAUTPerTAs0zp57ARgM8xMslFv/
         jRmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789048088; x=1789652888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FxLs2vs/J2uylK62rLnK+7N5L66TpTnceqzDX1Jt2Z0=;
        b=rRB2mlx0lMjhbda3ADle1Okrab0/BJMgO+TvIq9letyyruGzERKDKSc1CaDRbVKPJN
         m57pxE6+7GkLMIuzTjA118c3ktnZX5KyN37I9hLuK4U+CLOv8s6o/NxLyCQGpuxWeKin
         bomxeCgwVhhJAzfXDAeqfYd4C8kw9JWSpAfRHV2iXmy7QVGG7lCzy8Y28G08aXnWiJJI
         /OOq6SxdiWxc1FpeDbL8FIut7pwTJY61GcULqa9I6CfR3kUHYQ5JLslfnmHyh31kN57y
         evtrUbrp+J42Egaxq58lcSOZLCfWnVWB3C3EO+XaatLGh7zBQJ1urvX0KDo/TJZ0kVtP
         kCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048088; x=1789652888;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FxLs2vs/J2uylK62rLnK+7N5L66TpTnceqzDX1Jt2Z0=;
        b=Qb3Udm/rHRmyxCejmyArd++Mede/vmW1KkpQae8ZICjVBM0SCLpXW1fCiTEVpiQ2wE
         1RfPfdjvg2S0wHeLNkNc8eK7myxRUFA6kBiLKvYDjR/mg18vy7q9cJwg9oaa0rDFQTmj
         G82k9d+bFsI98lqLkF1rVnf47diLkKMx3IITzU5g2jvD1ySFkV4yGP5b15C/Mp9dpq/2
         8L5E31A6efmRHd3ahEmK5INBxZnQlKEXr0kqTsZ5x9nbpbjzfAF04NOfjH9c6VyWDWAH
         7dsGzuzs+rDUQId9DUBrUO+wSDZPXsApJJO4Pw+Pc1zbYGJ4GhySdi43PUP7BPKg3bvq
         +yNg==
X-Forwarded-Encrypted: i=1; AKwUvBwpzdW5C9O5P6N8GQ4IE5sdIQFdwYmTJBTJMP8kgqzoFJiNktWF2NREMzBW3UL5YSER84D17oQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m7pIBvNAB/4R0s49xY1hYdVFwopzv5ZAu7BMJY5E97fq+ijV7U
	2Z2XKUwqxRX7j3+B3EiOYax3G0xEfEvsMGrk3WdipYXsA0BVaveSWFFWkyo5izKdzAX61EhYC9D
	KDeYJQkJC7IrhFcnf2i1jHCsYEdN1Lzs=
X-Gm-Gg: AYBFou3PJnE3xBM8MvAvXzMYj8QRIZPlv+Q+z4QY15LY9txZpRnRIS6LDdNWqfK6MQO
	PWKDbTR1kd5KITlJD354yYkou3zbgvhP8WBtKXeI87vkc94zAc2YF7efWUpWfDi/YydpLCgst+P
	npN5zgR59hrQgePizTIyV7yoB92uU0SuBw+4H7uMXRxK2xoJ4Po0WU/uzjyXZYLXfXxrK90dvYO
	dcDmRIwlPIYl96xVI7KADY//FmA4SkWu4ss04GCW7/YpRF1HYYzHMsb/qBhRBpGpqxlFTRQ12+o
	xqVhkl06/Rc3GPMmvGMTp98DfSjmTzVv6vw+yD11fFPSD2r5FqrvBmrNq0/xd3UEP5ORwBs9FqZ
	0iM125Z7//ghKdHSQnKuA4eRHkVjP+QAmoaqSXGLDvp1mocCbonZD+yg=
X-Received: by 2002:a05:6a00:32c4:b0:857:73e2:9107 with SMTP id
 d2e1a72fcca58-8616c8498dfmr51907934b3a.23.1789048087728; Thu, 10 Sep 2026
 06:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_dWeqUFR6XqC-BqjjwsWJpNjEeER-fJ2SVYKhUObkMm1A@mail.gmail.com>
 <20260910020748.3643902-1-scott_gzh@163.com>
In-Reply-To: <20260910020748.3643902-1-scott_gzh@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 10 Sep 2026 09:47:56 -0400
X-Gm-Features: AcwNN1XLYo9Tpctj6btW9Am1OvR1X4vsOSgww2ik4xoSX3FAmeg920CXO7UztCE
Message-ID: <CADvbK_dPtNmc=gaAy_u64JkV9_+nPHT-oniH=0vReKp=oJfJcg@mail.gmail.com>
Subject: Re: [PATCH] sctp: hold shkey across socket migration
To: scott_gzh@163.com
Cc: davem@davemloft.net, david.lee@trailofbits.com, 
	dominik.czarnota@trailofbits.com, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kylebot@openai.com, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:08=E2=80=AFPM <scott_gzh@163.com> wrote:
>
> Hi Xin Long,
>
> Is there any progress regarding this patch?
>

I think you need to post v2 with the tag issues addressed.

Thanks.
