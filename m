Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793081675;
	b=Q5oA5GQlx4mJlRtJwWZIz6P4Tm0FqKhM5PcKNRx23mAFhX9hy+lh27tHSh+yNpZ/w+ET
	 CijPSU3ld14hWXsfReuiE3qdPpg87uirIyEa74K9C0FznQfeDe+qR6MwRISe3Sn8zNlY3
	 g1eozzhntYyTVlhDPURvkxkjinXEMNi1xKX7+8hARa45F+nxH4A+gSVcdwmZ0mzegulNc
	 G665LuznrQlP2SoXx9qQ9mj5fotgwC5tvHMSIoO43Lrez7eabmbMRHOdtAsr9jg54sCPZ
	 7IqeNlNIZiDHJPfwDLHmf8VerACC9ECoY/nyZmgz+f6Wg2jp2o7iVppwlj3nJiKoIlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Aj57gDgkYoxrbL3zRJ5xxNDor6hGOsBG1Hto8fARzGQ=;
	b=wP+R2UuLiFUe/4o8PxXG9cjEN8aW6hPqh6BV0JWwQmVc+Aw2kmrlLhsLZ2EzUSwNueUm
	 Fr2vhNH45hVVtRzI84YBQKitk8B2+Kxp6wTGR7aqJ+/VFCKZZKD5vyPywvFJlxC8Yb98N
	 S1/V32MTe4jJficboVwhM12OQPFdrZBbgzwzuDG2r9ZLfr2e+HIspbrexVSblYtE+MyQl
	 tCsrtFIb6O53Y1c/D607ipVslnlv1Jmb1shT+Q4jByHvYrk6sgG0cNZr4Mo00EaB5FWrW
	 eNOdc8nhVukI2Eqv6Kxb61WuMCOeQHBrTliJAb6WpyLme+TmM2XuRIMW8gsnuRCQ8IQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jujt5EfL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B6606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 203B6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jujt5EfL
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be4d648aacso3489304e87.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793081673; cv=none;
        d=google.com; s=arc-20260327;
        b=Ke0frcwmdyBk5+Xqsj76GFYbPJL4EiEIFlYLoxez9NKgva6hObQPfo9x3xo6ZXj6ch
         PzuD6741YfRGKdezeOdOxBfU6/L8f92HPT/UDcNNMWDStJqHKhdiymr83rSRO2b5kBLf
         c+k/mbue9MMD30HcqA2mvMA8BprGKYPlDrgciTLuiz7N6p8S4wwixDUgv0iPyzM/i5uZ
         Vfjme1/u1zqnRNI+lxvgskw17PVPcRwxrQwgj/rehfwuCp3hjHqw9UsM0FAnm93saB2U
         POXW28dtmKFF+LBOi8+m777RKkQ0u70AkWCBmxivJQk9Y9QEMB3bG0fqAw1ZEEquWRCO
         fEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aj57gDgkYoxrbL3zRJ5xxNDor6hGOsBG1Hto8fARzGQ=;
        fh=kCrkluS/Id7P58oqhawor+XLhL1t5FE/zMZ0XEG+W7I=;
        b=fcRNtRF97E57gP6Q3bJw/kCL2YIkvnRuZEMrFr0sx15na32SLKIMHy5k0NIYWQTqzl
         yD8AAP417x9dsbkWDFqpsiBxIdWqO4Z1loI2kLC1dSXhZ0WN7qrovfc83Ub9yB2eSJNu
         Z10BKNRebbGG7xVI5EOKUJSO5PUJsHOwwfHVBI+jaZcF//a8zLPajFm9Lz+lgQRDNn/A
         6R87fzD0PjeaJutIIjCwq65f5wckVC0s9FXeUxBxJR65KGhKi6TN5u0E4Ul2v5PM8FUC
         T6PdN0LKvQ8nfHLH0NPZ3M/VzIPmUrpR3kVt60BmhCCKkos0UdqcVdD8jPsxaFMLw0XR
         1HSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793081673; x=1793686473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aj57gDgkYoxrbL3zRJ5xxNDor6hGOsBG1Hto8fARzGQ=;
        b=jujt5EfLxkWfiU9Y4LvukWaGftjve6T81Pji1vz5Co5DA0S7dnvzB4wcmrcapqnPFY
         uHN2zOVjKMVDva+RzQWTQ7s7XpRm9IUxWnQ1ncEFt/NX2/bAIpgqIIS9d5+zb8uaBNRd
         u66QVycfeiGTQxRmzNPJW3WuBdHRZBUZeC+gJmW5xrVOzlESZ1T95qbydRaheqpvkO3J
         fcTGZ5NllHVChKMNOWQyUqVQ+WowGNwN4poykAPAJS7Ow1xwV89azF4nau3dDGt6pI1K
         d7lxZbkOBlukE7M841WRhcX04jaTj4wMAVQoI2nANEMUaMSJ7EsJ3/aht8F3X8xR6nc/
         wRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793081673; x=1793686473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aj57gDgkYoxrbL3zRJ5xxNDor6hGOsBG1Hto8fARzGQ=;
        b=rJbZWXepuya+6gIVwvNh0weMi6bbCqyyLU0/5eCx35aipgx+ya+vLbZyUSAWJ/QyiJ
         ms4JfHZDB5mitNjVbE8soi+t/23J6ypHhzT+DNQSwAPEFazyTwcA6DjrX/wlpglCnuWR
         r/npjwGccONz+RdZyLVNzc05+2rZlXRJNp6dnDmMHWR2hEhC+qZeLa6eg7QE0rweCts8
         +c90TDSZBXBdtZnP/AbFINtbky9nNuyH0RYc+pX/996yo7pfqrzk18qihgMite3LlbsC
         spjs00ZrqWYoJx1d4zn5aCBQKWf+yxGl+281zd48ib1BJ8JoeU3zpUn+24ejXr9xq8VK
         jUtg==
X-Gm-Message-State: AFq9FYIrT6kz6DgpwCznzqLtwiLJTqhNxJpiMTgw2b6mauz0s5Cciv4c
	ydPOz+ShlJWdT4KZQdbQ10A9kciR0EnJBY7aGRxpWCzIH1uOMMMFaD5mXY4V8I3O3XyNRig6VlK
	VdkhZzv2ACiR7zvVdjas7uadAPftfP04=
X-Gm-Gg: AYBFou2dF9hz5rRJD1ozWmjlSebN6JSYxX/Yt+WV3p8kMcm3xlu06lC7UkdrNEoJs1A
	2IHTYAaQ0o5525pJVgLRqhHFEV1I9FJ7GZlc92MxIpT9pBQtI2verZuHN5CXLUQt56emzRi+pBh
	9mSs+IQGCNaQNVb/PAhh8dILGyOng7aQvfpeJY8t/zSAju9nu5wPjNbDWsKxfXn8SBUi2OfbuWf
	Vp0AOAVC4ZF+mOD04IFd295agCzHF/Oni9grw+p7BsJWkCX4x/llbFo9wnuS7uEphP2j3+TPBFa
	iQCg/fp0nQ9wVQVAXXa0QWttc9gT29g5WwpqGjRZxUFZC9l0WzgtD8S1ko2tMH9+/Ctijw+xVzD
	SAlK0p03W4OUi9zVNaiXV5VsqBajqwar3jVfNdapv5e+pDjUS7BYUu7qV4Zlx8CYFsL+raBEdus
	3QzNHAHmwaeVKMQ+lpc33WWbGvQIjP/iwZGOiVaueNuXMrkzyPmfc=
X-Received: by 2002:a05:6512:1247:b0:5bc:f2d3:f940 with SMTP id
 2adb3069b0e04-5bfb71f7292mr3160287e87.56.1793081673092; Mon, 26 Oct 2026
 23:14:33 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026095208.58504-1-yzwlhm@gmail.com>
In-Reply-To: <20261026095208.58504-1-yzwlhm@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Oct 2026 14:13:55 +0800
X-Gm-Features: AclHuK_cgrQyrWKFQVlhzabXNnx79zQhN2Alc0sBaVdOJyWNDAmLNbsinkEAfZw
Message-ID: <CAL+tcoCsZs3JL4CdmAP6oNk8eZD9tmtzyeQEeBnb1m9+ypMp9Q@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Fix fastreuse cache initialization on first bind
To: Zhewei Yuan <yzwlhm@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:55=E2=80=AFPM Zhewei Yuan <yzwlhm@gmail.com> wrot=
e:
>
> inet_csk_update_fastreuse() initializes the reuse caches only when
> tb->bhash2 is empty, but both inet_csk_get_port() and
> __inet_inherit_port() link tb2 before calling it, so the first-bind
> branch is never taken.
>
> As a result, SO_REUSEADDR binds never get fastreuse=3D1 and keep
> scanning existing owners, and SO_REUSEPORT starts in STRICT instead
> of ANY.
>
> Initialize the caches when tb2 is the only entry in tb->bhash2 and has
> no owners. Timewait sockets are also linked on tb2->owners, so this is
> equivalent to the old hlist_empty(&tb->owners) test.
>
> Found by manual code inspection and confirmed with GDB. Binding 16000

I thought it was discovered by an LLM.

> SO_REUSEADDR sockets to one address/port in a KVM guest takes 4.18 s
> before and 19.4 ms after this patch. Existing bind/reuse selftests
> pass. Analysis and testing were assisted by an AI tool (Codex).
>
> Fixes: 8002d44fe84d ("tcp: Check hlist_empty(&tb->bhash2) instead of hlis=
t_empty(&tb->owners).")
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Zhewei Yuan <yzwlhm@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!
