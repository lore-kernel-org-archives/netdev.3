Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793961273;
	b=LakBeK+qyX74bI3ixJYBvJ1FMuR6f6sIVwxsRgjf4/gMYiDWXdZrJCnbS6AK3ASPnOWF
	 qQ3LaaOCXN9g3PXJ5cFVSh35ivcYgo5r8K9l/DAEom7SK30DpXCox1Sb1P2A6OJzUsaDh
	 npueId+maSXY8e4gHgxjf8vVi4PXHv6dXB9Tbu6tN+GXGeDE06TXMtFSAC8UsJKMryy6l
	 3dpjU1IlbhWH4cOrQ4E0Ut8hTCpzCCzH9kkHFfIPrjRD2JMjWHNXa17SoDoH7rfbd7/44
	 Nk8/Aw5FJcRmkHg7/zJXZBoj0Vrk0jF5WLsW2qngWfSs2ZN0ytPceINyf6+vo3qI2Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961273;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Received:From:In-Reply-To:References:
	 X-Clacks-Overhead:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yijtZQeMS2T2vulJllEh08u8WzAHH7tCqzIkmdxxHRc=;
	b=Y5je/1il2GoAgXY+wCV56UvNcdxb9Ijj/kCePSuyQzjGHF5KT1XYLcwpMloV5bgKTa0g
	 ANzxngNewnaTsYZQ5u1pyskDKintMEMLcCXbTyKohoIwhZA9Qk31hQtgI+a3Rer6E3xIZ
	 mNnYzdME9aNGYEQguhrkJfmMVpNkVEbXXFS1ghZh792/5yH4QoDjhI7mqaPKO9v28myAe
	 b2j20fNeSNfYnSwjQIqleLdTOd8ZJ48juBdyM/qpvJJC+N2SerVx6zT+03zpYRRu0cNCr
	 dbqDzMi+k06jSOdLytX6fvCNkJQsbrUZyW4J9mi2oZzMM45zcp01n9n91yfX2zA/UFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SOoSIbEk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qgpZ36Ct;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5563606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 10:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5563606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SOoSIbEk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qgpZ36Ct
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793961271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yijtZQeMS2T2vulJllEh08u8WzAHH7tCqzIkmdxxHRc=;
	b=SOoSIbEk+VwEidDd2eqmMY7xpnyIzNoIevLJj8cxb77Dt33eL/HXwMBYlHLRHo4F9CUdIs
	v1T+1d4hj2/iZwKzTD3d/wQTxnXbv6XwU5fOmOzOWsBTGn7eytYsWLEFtwuwwqlPcmFh0H
	RYmo90pH8r/xHfUppgvG7y1q1znlK94=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-UHGblZO_OO69fLxgT8cpGg-1; Fri, 06 Nov 2026 05:34:30 -0500
X-MC-Unique: UHGblZO_OO69fLxgT8cpGg-1
X-Mimecast-MFC-AGG-ID: UHGblZO_OO69fLxgT8cpGg_1793961270
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-86c3a053d9bso5668937b3.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 02:34:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793961269; cv=none;
        d=google.com; s=arc-20260327;
        b=Cg961lYgEYOeopeDyl8sudKMttL7tHGe8XI4eB4uykAV63Hy9sI5jGuKaQm4c8Z+l+
         RHzePqjRqLeerCw5Y04fNllqqAuqKJa3FFQVoT8RZNww6xo79FW44w8sUjIFWrkFy+Xw
         2x/qQhU8nzwCfSS9VG29F6dp2JCxU462W0IhfwbZ0wsQfGdsaSI5PcF3RwkOMAUGV9S3
         RdKKL+w7HcOjsF/KX/0PulPHjgjIegWV9aEy3h1Mu9F2NtyB7DZlrFQKn0fcdQB1XjEy
         ejzzJzIObSvTCh/S3ij/unmmWL9njNxPcOn8Ya9ZAKK2E1qkFEE4+PqO/J8HuJhiCsSj
         e5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=yijtZQeMS2T2vulJllEh08u8WzAHH7tCqzIkmdxxHRc=;
        fh=tauRhNqES9D12KzNMlDU6jLh3u9heFHIQwr7h7T5IAA=;
        b=mWdX7KDutQZs0qjWzcizpJkv7p533KoEEjUEnLCP3nSztvsVvdY8KzXIikMqo/koVM
         ehnaznP4CzoiiB3ejFfY7SFaFZEVYUjxvNJHi3tAtAVNBlbWdeU7mtU6EmIqJX+zuQTj
         gHQfI0RW6NU9W2xk24ufeH3S4SQFauQBu7P8PbXBTORC0/qYgDjlOerjM8RVtgFk7aoR
         VKyt+wzBA6i+OQIDvRfBasC6fmB9h5SOs3eTesP+FsCAiqYCvtRZC49M+9OGbeym5/Cd
         A7byV0P4+DsUA1YI5EMS3mIqdd04cqn8EUmn1nppUP3oLrHT9L+Rj0O6QTVe9A9JEj+0
         kNHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793961269; x=1794566069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yijtZQeMS2T2vulJllEh08u8WzAHH7tCqzIkmdxxHRc=;
        b=qgpZ36CtjCnXnK+qlpid5+8RtJlb717kJVPXmNL19QsJdwUzVBangA3BKsD0VG29Zw
         Dli7fE+aVoWZg8DhOXRill5nv9vnWcS0N09uC7RKmMQxsLxFJSVsbY4QHBj4wOfuox8e
         tD/Kq3iisgYlyxjFVTCbtmYCZoVOyhiX6yqC/uRld+rp4SxpsEY9LQv3IT+3t85TWgFD
         erToRoPdiHuBbGYqirBX1eAS5bVWJ/3x+i7iArNo3XwFMs2rBCGDO7KXlkCYdee0xD2M
         vYQQag6hUp3pcQux5vBWTfw4jnOn9j2hTRq5q+UHtCBQPoUJoQQikNAUeQrF4NaJMPgc
         1d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961269; x=1794566069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yijtZQeMS2T2vulJllEh08u8WzAHH7tCqzIkmdxxHRc=;
        b=ozovK8nDcLaNQONoGTXsHmtb4JDmlnPnPdE/+i46dVZ4cSBeoMwHi4NlOXSQrpLUCr
         0kICgZXQ4Af6zcoq3cYyjm4XGg5jZCCUZvhx+hsa6QXgje2uZ7ztnaomOo7QU34hLeFd
         ZXEB2wnHLvY6SCXsztg9YccRwnhMwDS1xAkZO/44imY2WqB10HvMGc44gVL3jUeIxRLA
         5KN1GuKWFnBIU4GWGCLHktDCm/WRPs+GYJ3fFQLYSTuYhT3uaeDn858EbNrxusvKOzid
         sFlSt3jMVKLJ9QZpQxAav5W0plX25f15DdIOvIFzr3Qpr41HFX8k9hsINTpmui0G6I47
         TrNQ==
X-Forwarded-Encrypted: i=1; AL+hErGvZFIRdfjQYPcdI3Hkk3dGgEoSDMlZV+SYJcbym8aPMrnIdyJxm0j7ZM5c1rEuTPjCbPxT5LU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kkbqd2HV8n1QUWNf6zBFOagzoN55QCDWX88OrSgrj5VlN8CvI
	h7LPez/ZxsHljGXentJjTY8ZA24ArT+GJnEQbDor9ChzJSSXjGCXq4fhQ7hD0rG1ayPtdzYMPjn
	yGNVuEi0AfNnSbE86vEd0lWQLBnwRBWb17KelU1hC+5eiT5MaMgSLPROsJM3PQQ8SnYG9uSRotP
	sz+YMlxPCqQrfrtWKy6CMVnhfJ4yVJjulM
X-Gm-Gg: AYBFou0IV3fOoGPkaeTIx+qEz8S3ZZZiHwvyjV1ebfeg9p3bJcFQfMZq/xjvpOpdCzO
	eYO+/euC6LcA0sovlTRIx2JFcoJyjwx9/XVOnZ0hpQadxZZVGHrqHquhy0jMkWOgR+UrPnqAuDn
	9OeYMFQnPZEU6tLaARJoBL5c0u8y5Pj/hkrXEbi41fgxvILilZ2qcyHa/EbceTZSPdc20w1L01O
	72bXVLTorPkwwzI
X-Received: by 2002:a05:690c:e3ea:b0:8b3:5037:5023 with SMTP id 00721157ae682-8b350375381mr15827b3.15.1793961269423;
        Fri, 06 Nov 2026 02:34:29 -0800 (PST)
X-Received: by 2002:a05:690c:e3ea:b0:8b3:5037:5023 with SMTP id
 00721157ae682-8b350375381mr15717b3.15.1793961269050; Fri, 06 Nov 2026
 02:34:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 04:34:24 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 04:34:24 -0600
From: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
In-Reply-To: <20261103200036.65764-3-tianyi@cloudflare.com>
References: <20261103200036.65764-2-tianyi@cloudflare.com> <20261103200036.65764-3-tianyi@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 04:34:24 -0600
X-Gm-Features: AclHuK-sJ3dqIJeSdHUNf0o0AjI3dtm9DPHkP7CfN-2qlw2BH-a46hIByak0TW4
Message-ID: <CAPB2EArNk4KzPSGD8DXjb0o=pUZ8RFUm=U3ZVU9GRNMzj0OVkg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: fix mac_len of skbs copied by generic XDP
To: Tianyi Gao <tianyi@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tianyi Gao <tianyi@cloudflare.com> writes:

> skb_pp_cow_data() copies the header fields of the old skb with
> skb_copy_header(). skb_copy_header() does not copy mac_len.
>
> Generic XDP uses skb_pp_cow_data() for programs with frags support.
> After such a program, the skb can have mac_len 0.
> cpu_map_generic_redirect() and tc ingress then get the position of the
> Ethernet header wrong.
>
> Copy mac_len in skb_pp_cow_data(), as dev_map_generic_redirect() does
> after skb_copy().
>
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

