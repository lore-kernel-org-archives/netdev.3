Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792477428;
	b=4mxbym4zGuAJedYIcJpu90nYjfOBt04crDBo2rcUxecboQEXUBXb3ei/ZLqdKBV3GYl+
	 k3GbFQyywRm+4LdtXeYmYEohLXdU8bMql625CXXIgJ9LL1SGfjR3JZgWh1HsjyyO78cVo
	 AIJQB+seXGJOECWFeaVBntAca4eUWyjYWP5ol4I+GIMUq1/hKreYcrOBYpMoVJgLi8RgY
	 6aHk1pXJuGKjEL7eOZWGHyyqDKBBPN4lUXs6ACUC6FhoeadjBy4523um4lUZPzA4dRGWF
	 p7s+mFlBtjeCjXmnObdHYUDUw7icp3dbHl7QLCvGPr3UgMH/Z3HtQOEzA9xfq3S4Urg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792477428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xY+9Gua3JjZJP919O7FVK4aXbXShPehswYzBc3Kq9+Y=;
	b=UeQsR1C/yQiyOGGJ5pvTYKz922HrUu/nM84YHSszAq3A64pXHIbijJisqHnZt0Ue+hkT
	 jj5Rh5tCeVw52MzFQ5aLwsd9UHroWK+ST1hdAtuHGehZu2rWZu8nS5U3BqV9ttT68QPxX
	 9cXYaaIoKgJQDtvMAwiIEja9YoKEdjJmYHUaDk3UCURxPvDw0nhYnAab5Xtr+TQBEZyTO
	 3ysI0mjHQIs1us1EikG5UtUBHAdvz+1ZF+HknKPNpsCp/5lTSFypx5/SG7RBpSD5w1J6D
	 3GLIygzGiHgywkFmN65R20I4CqS7ARAPQ96/t3HnFoWC5oI3fxF1A479PVFoOfwOe6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UWVA7zDW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB346606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB346606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UWVA7zDW
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ba328513b9so2538715e87.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792477426; cv=none;
        d=google.com; s=arc-20260327;
        b=ngHV92sZkQsBQqav0Pru+fSi2xbZs6mxXG2XrkSYtLrdy111TTCFx8k7fu9Nr29k1v
         tvFRa/FWebli32AMB513IGJNyV+jBJ8I/bgClbOOggY5535wER8xBx63TEnISua9N8sS
         E+Nva1M3AKKHm1b5jPneh4d/J020K6uovC2xHlyBEPytZYfXJ2e/o0exi8a+psVdpJFy
         JNMNGWw0vW3eh3tWB4QOCXr5WOos6ABQ7pW0i8PLZSup55QnDAs9+MyxWsSdcV0lPULc
         0KA9pN5VRU90DEU1bkIQelo2WhUL3VrMZoDb7rJIAEPYTXdREWMQPTolvx3Ny0uKZHG8
         0MFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xY+9Gua3JjZJP919O7FVK4aXbXShPehswYzBc3Kq9+Y=;
        fh=0R9vqJaxg9HLwZiqQcHR1kATDpbcFqTlrMKY9NEksLA=;
        b=jYWiDcmCjdg5blDAzKLxdaH7FdSxODtxq6t8f9s3+PHahA5AhKlFTlrXmj/YiVKs17
         WOAD1eLG3SWdw7oy1q8BVb++nG36M9ox3wi1xCgc/TUAeNXI/yVf5rBiWSiQD+YsR0xG
         JW0sTDQ9tZOy3c8pVf1QvGx+xYwoqYR8G48/3VSYL0vwt9D1ZHXMM92SzI0MCXTLCYMa
         b/zT4HxXvG+HAG8/8D9N+XRTkX/GBkIWXdmViiO/mhC8ChvyMLjaC8KehCh5XVRuFDC/
         DAvZuH+uImmZoBZFxoR6TIFizDKKUEboSVdkhqYa5y81n7wP/4Wn5/aqGU0hu2kNioBQ
         2PAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792477426; x=1793082226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xY+9Gua3JjZJP919O7FVK4aXbXShPehswYzBc3Kq9+Y=;
        b=UWVA7zDWow5j3cWA0r6ymLJXpdx0XwjnuBe+lZ7X2L061n0fnGuBD1AVqBAKeKMglN
         VLgIWUA2RbuY/fG4xjAmYsu/8zvtMxm4iElSgPRxT8aTB7ZDPuzgRUJlBQxHphUEd83m
         g/fBTauy9EAEjTXD0favegnkvkklGePd86UQBe75srwgVTQESwZjsQEi9qciwJQghdRQ
         tR7LJTH36tp2QIVbwsQlXrhDBfUUhTJLibLfncY9+f5bxkjUpOn23Epqghfu2rlKmF3v
         4cqV7o0595FIZeSMRJd1w6UjyEUc1JdY/7wyCgiymOyvG6ABMcr00qEUxsCy56chFotX
         FE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792477426; x=1793082226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xY+9Gua3JjZJP919O7FVK4aXbXShPehswYzBc3Kq9+Y=;
        b=ArvlRxdTPSJfwxLPcJUWyeGy1UpcPU0r+rKFhrmCDspV3dO7J9faD16cDq/1yhbDBX
         YxymqwE0XHUUgGtCH8mkxv9tSjEgeYucpTiINQqDAk2tcXE5u7bPi2hU2js+wdPqpiK5
         FWn+AROoQGjDW/bf4W2+plXgc0tmpaAnuOVc6OJm4XjodKDIJ0ffQ8GLsl+zymzqK490
         yKrhoy1Nc9vf7vT/veasv8KZYfnaSUOGlLHFkfoq9Mxq1Pc87vwYwWGb83SwVlHKmfWc
         TY/ENAja8hGevdmzKcla49X9xlPol28Z1xciqy86p2iFyrvc2JJFxNJm/zSHenn2pTmr
         BoCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjgW+0nXhdlOjEPbrD/hgWC30Clj4URUcmbQOtRcw92n94dwsRdOOh0P0kJN2s1jAjJHLTTc0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKm/sel6l23QchZPBP963xYtnmWraFdsaq2CE74CiEHZlIWd6cV
	7BTWDxBgWo5eWgpyL7NZPPHv/meIGjBDfvltFrurJtqau8alqU0Ya4heBOpwicyTz8XLUOnORVp
	1JPDClEHK3mQwtXkNuOuouzgiRpgZnMIDQ8VQ9TU=
X-Gm-Gg: AYBFou3mVpg9NEyT0a+uB5WhyeauKWLTjvEH1qsOjWVwyLXMF53QVVb0ou9nyJ9nnSP
	TRrWekWCQgUimm6KO48wXsaIphtOpr8KqJ0Nh/duEyIA6rYzujouaxaHhGUfFuFyaN0Z3cgX+DJ
	Q/1jmWIRv1RY70OrVQ/1iR+aJ1tpLKPgZxWMK55KLKHIrtqZcWZZvGueUORNwq+lUBELSoPLLb4
	8yG9nkMWIZgyW2U3xU6ghnL4MFPEviZuisNPcfC7fy30HmtHvxhJyTPSbVDLQemHnrad+F/VlbG
	qkaQcBAvC9diWR2Q5ku9xHS3vyHPQmlesBB7HQtSslN61MbRs8rsa83tYprFMzuveM/YcTY9YQT
	9zgae5tkIoc3YPaqmOizsENjDk9WRdGuNEgoV+zXefJ6V3jxOWu2UGpAMux2KKnh0FHFrZQ==
X-Received: by 2002:a05:6512:10c1:b0:5b8:f4d4:7ff4 with SMTP id
 2adb3069b0e04-5be50a74cc6mr2861942e87.53.1792477425787; Mon, 19 Oct 2026
 23:23:45 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019082214.102398-1-dmantipov@yandex.ru>
In-Reply-To: <20261019082214.102398-1-dmantipov@yandex.ru>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Oct 2026 14:23:07 +0800
X-Gm-Features: AclHuK8JKD5Z6WDYyq0TEA6JyqRSpdqT95b7DSefRKIlR8POo1NdSXaCNKLZsDo
Message-ID: <CAL+tcoAyM0uL8UWqYMH9=bCrLwtqorAKHqm=v1tQ95p2y5AqBw@mail.gmail.com>
Subject: Re: [PATCH v2] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Eric Dumazet <edumazet@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Kicinski <kuba@kernel.org>, Levi Zim <rsworktech@outlook.com>, 
	Denis Yarapov <yarapov_d@mcst.ru>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	lvc-project@linuxtesting.org, Sashiko <shodan.ai@mcst.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 4:27=E2=80=AFPM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> In tcp_bpf_sendmsg(), the value returned by sk_msg_memcopy_from_iter()
> is checked for error but not propagated to 'out_err' label, so error
> handling may not work as expected. Fix this by assigning error value
> to 'err', thus making sure that error won't be silently ignored.
>
> Reported-by: Sashiko <shodan.ai@mcst.ru>
> Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
