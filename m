Received: from mail-qk2-f34.google.com (mail-qk2-f34.google.com [74.125.230.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A64A9D46
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551710; cv=pass; b=dfo1kARkGGU9lenn0fDTBYtQyQ0HwAvTyEkuNj9F4634KVSfsrshoRVAYYs9H15wcfUX5dct/lSspVfv5EK/dV0ydYgLNGGbXmmbKnsdmTAcvqE5kRW/9kuJuPZucIvC14ZpINPPaLJlu6hTfajHtmBQDTiUqw7lOFUeYvkKGHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551710; c=relaxed/simple;
	bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXw/dk04ppFz4V5MRIzj6M947qhu9m23zXajROW/vc/Nt2BJVJiFPLL1Z+1MzBIJqK3/PdKJ4pUcQds9eFphoLP5Z6XEMey7I9EY6LpZ2ouDBKk/9iYC84uOunfwQ4n5TzWV0bai4MTNL3gO2zl9y5ahiL4Z19a+pY5Cs5NV6qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qQck2Eax; arc=pass smtp.client-ip=74.125.230.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQck2Eax"
Received: by mail-qk2-f34.google.com with SMTP id af79cd13be357-939109f067eso70168085a.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789551701; cv=none;
        d=google.com; s=arc-20260327;
        b=N+237zPPv4ZjilLnImMi7tjX3CW+TnyK+XBRkJAbEO+18ru1q0C+Z5+/yiacSwFpdO
         wPC9k9um/IyN6xEwlUqbmu1XkOxoJu+CBhMpFvy/koim7THIR4Mlr5e1H0txcXOg8UbB
         1dqiScyunjeEyixKhB/TkOKCaNubTL5gXyTU/Z3nYwW7k5KdBcWxPl8o1bs6HTC9PGY6
         /f9ezIQEx2zNRldvQML8mNtEyesAMQUN8bJHnyGkR+NPt3cqOwIA4ZoV0Pj15eOtjcKV
         WuvnyvM3SjoXsA8+JUkdbJXbrsxnTv75XhnPwGPt/cMPWcEgyG5p4/RVXUham9Jev92m
         Ef8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
        fh=UHjOHk6S865wL8vAzVDHIJWIDVAU+syCKHzM3zLlBuM=;
        b=MHLHfX7qAeY+tpimj9dP+EZQhDiTQIEhNh/cBKPXH6bcaGtqfxXW5GEkj6CfjRTDOS
         l47z+cTuPDcE3CzITN8HkNhT1ZToOS0sreJixWDnR5NYovez0vjCCmFwd5DIrp3xT2+2
         DKVxhGhQO4Ul9J4Rob70vAUwc5ixalJGrtAS6IN6II85gOfnpe+e9abXo/VuklWi7GjG
         NuiA3eVUAHminNRXzVY7Yh4QzcJLMkgRpNG8FOMbksEUqAGR20jwchwVZT4//2f8rH9/
         jUIDtI4mDUb4yBvTv1vy6M9d5m17B3hRCiMcBpqQdLZsKotdn41udFQtg3ngPJ6wSu/z
         9/jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789551701; x=1790156501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
        b=qQck2EaxCKi4Uv0sJjK3manqk1cVY7UTs+3b6Rg7JosOC0NAhCZTy3X2x9wUG0VV7Q
         WcNv/i/HyuUlGMTnc2y4LJEMccBKJsEiITHqf1vysluHNcpxRYbmligHei4FYY4IJIV/
         QAr5Af0qjKwl1UtvyZaLvQCUEcZ6CpiU0WxdoAXkDzkP9lS3eQXamwqkwX88tacqgAID
         7XoO/Fb5o4U/p7+Xna7qIIL9Pn3KoSnMxvsv5/ekXojPfgns+1kJxR6QNqKQX3PD8Kft
         9O9F5sxZF3abTKexlCbyDCQy0usdH+BmLkdq2dp+QZv8pbE6/+wIulSeb4BaD05Dwh6d
         oBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789551701; x=1790156501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dd0XjmXLbr6av17ldrfsndZXMA3/+aCy2CJ+JrZ60SY=;
        b=rnPmy7gMmIncixlwu2pT6w+ggqI6e0A408U+hN1/OWmRC1kCFdSkVlDdV6fLQGc8tc
         C4o4973RcHBk4KTgrRFCWSV1tlgIw/CQHXajDRBTPcwuLzOVRUGpRo6bhUdforcfpcMF
         VyHDW3CuR0Szhxi6VxxWsAo9spieRVv8ZC8YIRHeCru8J5NWV4ZcO8HuRJ4uHBfOJYDk
         eCY/1OALgaFlg8H87KWZU4c0qlYg42FHOpD8sWGbOx+j63FdJbQNIvYP43cBVbQ/D9EV
         nKUXffhGCo8cTbyQpy2FN66UBFzLRFjhooJtN/MpUnNFkb4+lvmDMGKowGPWS/+T+CMy
         yHbA==
X-Forwarded-Encrypted: i=1; AKwUvByvKX2uKCX9bmI0iYtmmJTHbwTqSPsE91CcUudDVP8iPdRJ9eyrhkjhEgAj437M870aSfR/p3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++m2Wjs/+lNsfmpfYPuH5dmYpHJzsuBtTkuOOKt52r1NXvOu0z6o
	UDTysTU+gSfU7GbcwLPD164sIwdCI4Y0yqI7i2gXT134f+pRuWGdEuO0N8UBnBslADdXj6X89yI
	oo2jf+TNpQwNrmJIpk6EBV8WdvjYUy2Y2aMK/fdR4
X-Gm-Gg: AYBFou07tFnKdDHALAXdPyAgdS7SalDhFGixI/b6NGHVuntUaqYXQjyipiJ46cUGq5L
	I7HIkntrVco1O8yVxJahemY22MOoBM9jzfmWmjJQSc+9VzsgR4YJ7iRcOj+7rbOfkuFqL28nWks
	kOPJLyxCm/LOiO25NblQSluJiARkFwqVZHhQ9dqjc/NJ7EUaM8YuPKbSxtcp/4NXfoXf6X6jBL7
	sAjeS/6/XYpWOo0y0baG2HA7Kao7tnPzh3HSO/mFY97RUZw80RjaeZnmlU+bHIJNsQFx7urK3aV
	hN/33XIUeXKqxcVgxnKOW/thlXCAqOGWx1Ms9aw8Jn9OOO3ttVa1ybXBYyrXiv4hB4lUz6NSPiV
	o8trh1jRDSwx32r41YborbwR1Fko1S7qIhAPqrTDKJHqKmvKeK3V3poarWT6zebV+SzM=
X-Received: by 2002:a05:620a:72d2:20b0:93b:c22a:e98a with SMTP id
 af79cd13be357-93bc22af796mr17857385a.2.1789551700440; Wed, 16 Sep 2026
 02:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916041102.1914333-1-xmei5@asu.edu> <CAPpSM+SpeOa5uo5rffXejDa4g9VGphp1GvirJgUWze-O+cQyzA@mail.gmail.com>
In-Reply-To: <CAPpSM+SpeOa5uo5rffXejDa4g9VGphp1GvirJgUWze-O+cQyzA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Sep 2026 02:41:29 -0700
X-Gm-Features: AcwNN1UxUZyShrWWdOdzZP5TvGhMt62DuqGu9sAhw7uSD_TZmpKiYAfpJ3xalwE
Message-ID: <CANn89iJtyY_ooHfbqPw4=GVwXQeEc0k6RxS9dJGnA8TZgu8rSw@mail.gmail.com>
Subject: Re: [PATCH net] bpf: lwt: clear stale IP control block after pushing
 an encap header
To: Xiang Mei <xmei5@asu.edu>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+ff13a35f73bb7891@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:32=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:

>
> I just found Weiming post a patch solving same problem:
>
> https://lore.kernel.org/bpf/20260915170147.3943392-2-bestswngs@gmail.com/
>
> and that patch covers the cases I didn't consider so please ignore this p=
atch.

pw-bot: cr

Thanks.
