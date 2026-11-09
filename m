Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229408;
	b=11dcmH/0fGzuYtS0N5MvfG1vO24xYoe7mjahwOhx04MT/TZncyvR1l2mQf9w61LjSdna
	 vmA5yWRH1Mwx4FGPdBh2OnsLaofFLgOYeJ2FukSORP+K4hABCogAr8bkDz38WJePHpGOZ
	 ly+xiXycDG5wy5Ca9Bzrt/i+O7ckZl3814vp/mZ9zqPvk9cPsO0Y2VaSXBSYn4ctioQyX
	 wu6daB6uwXu9W5cn3lez4EPOsxj1tZrkJtgJKChI2x+8XO4f8aEf2xgKsJyv2j+MvOClw
	 RRkDtL4Yw/ur7jC6Tktisg406GCJTBMfiqNYKBC7uVeRq9PAZm+N7a6CObVFTqeaWMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=72Pzf80vHJ6tg7h9s2yhzIcCJ8giywOh4xxajI0FVfE=;
	b=uIoZ8Jt0jrmcW4cI9+8lgmjMP+X/OIiaLviOhCI6ZyM5WB8D4/YPiGMSG7jzkHx9CHhC
	 cHbMj7tjewld9jyw9IL4RSHtDd1R6ALiO2Qt2mFXaX2Gvn2vNE2VAcNi7nGCFlaQlimqT
	 ouHqkiFDPuUN27gGuLGshKoXU0i5hp4uznURrsNq9EF1Gc+G8dLWZ4oJJsjCGkatSEPhl
	 eGP6ed0eSC/pYjEOPoqJG/OAhYQYnJiIR/3O1gjgTe6O/XDXtAJxn41D6/9jTzHN9LNIZ
	 0HaUa56wliDmgX5h3MNbeUwY+frw8hK+o8o7BKaI+KUhz4H+Q3J2yUbTiBoLfBUpkRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Th6NR4gp;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFA606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DFA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Th6NR4gp
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91eb7d1478cso9159806d6.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 05:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794229407; x=1794834207; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=72Pzf80vHJ6tg7h9s2yhzIcCJ8giywOh4xxajI0FVfE=;
        b=Th6NR4gpQlycRBLRjBND2+14b1JRjtLWr70u04hTBSAFERKPkfJOkUTK3TEdNyfRL1
         EdEWi4ne5l33XwRwB0IMecrK3EHlMksJaS2H9i4GxM3NATIPc+YcuZaUQ9+Us4vYWqu0
         a7opGItIC1bBR5aL256gy45CpuBuBzS9m6EJBcNYglPbaUfm6KjU+s0vzQDbqgTEukLK
         odJRimkIhb3JTbg75cf4GygFLOX8zJGE50MS07jGUEVGREv1k3k6wsr9OKQCh/zuCr0A
         1EKAsR/Sp/3331X2ZIGFsUFaefJHCQulLSSxIfqaMlOUKO31bI9O+oU65URNeAqzzp5C
         bNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794229407; x=1794834207;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72Pzf80vHJ6tg7h9s2yhzIcCJ8giywOh4xxajI0FVfE=;
        b=hQpeef3S65Y4zGdL5byxt68KBse9Ei8eNVNXwWUVddOaDgVM/q8OUzBd5gfqEt8Z0V
         I9sEWQgkVDwMxo/BfnpiCwJlewTz/5MzxkkFxRKQFrjFNS6lNFdrH849ilpWGd5UaWQh
         kEJ+ybVcmu+m3laRX4GpX467XT9CWdaFeH7m/RW6QnSyecoTMejkpZVPjtHo4xJaeFQY
         olHDLmFq2A3Ccn7K7yBnvUP7g8Fil4T8IHGECQHuXBMiGlho8nScRo6XLdBkZYSNtw//
         U6u9gSqVfGRcJYmuMXgoa4BM2Rl6aiHmzdED6eylB+WRc3jFeaNGOJoH0gIj+dqgrR2C
         SMhA==
X-Forwarded-Encrypted: i=1; AL+hErHMaPJFWmx8tU6tkrrDI1pIqfRL2m9cTsdAtbEjM4T75aR1ZaCs0XUA8uHrrPVh2mtAA7yPSOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8w/cLGv7+ufc/akke9yAu3SpulrdO+RqgfyfQLdzGSwZuTCYfV
	Ra9SEEhekYNwMNVmgsJvDxJ9i9N8NKmnBjIHMVE2wDdbaUlzBeNlDZsp
X-Gm-Gg: AYBFou1zz52s8iFxWJofaemnLQY9w+xNmIlU6/eB/f1XZhJmQWnCwMcNx4AOaSuokls
	ye8xegmLMpSQUI4fLjo1ZUKpKm2OZoEcb5AfqqOyIGIKd6ovGJ//zQTAus7Venk0oPMB7jiOYZ/
	WVffYYTipSUwI+eLecBisTyIIjDZ/aXVUDh2KFvWU4QFk6gp5r6wlRk2CVDv2vVgfcbVe9IWJb5
	4NayNATduG9MVxh57xmVdqZ5liB9LKa1k7Q9CFTWVjmzuqaY1IOyigvoJydk8Ua9K5viFir+z58
	mfOsgs5wuiA+TLxkolLqK0wikgRdN3RhjqbPqnDM9CfasjlfOWUUedQXGGO1LLlc//BIfP4CGxw
	irjQtiyp1kOsZzkH9tU5t9J1VGOausOExLi7aCnEcy8I8WlnfDCyVRJUc6ic3YUj4gI0tzwbthm
	eF/Eyj9cZwiVDmZ+oKyOD/BtwMBRbxX7zUiOC7h2XOpWs2qUYGR9HtNUv2o04gtrgIoTJlTwPIS
	+8YbYbrX6lksXzFr4JMkJUDct3V1MiB4t82A8tkG0LzwjAGPkH5yw7RZ9p2N93Wole8JKHfv9qS
	+647+bJTbfoDYc/5+rmhOeYum3VEbaUw+A==
X-Received: by 2002:a05:620a:400b:b0:939:fde0:a71b with SMTP id af79cd13be357-947846073e3mr613394785a.0.1794229405262;
        Mon, 09 Nov 2026 05:03:25 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94782d61906sm469034185a.14.2026.11.09.05.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:03:24 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 08:03:22 -0500
Message-Id: <DMQP8OMF2NZ2.3K3MJRWBNXWW@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
Cc: <kuba@kernel.org>, <willemdebruijn.kernel@gmail.com>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <rdunlap@infradead.org>, <donald.hunter@gmail.com>,
 <andrew+netdev@lunn.ch>, <shuah@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v3 4/5] selftests: drv-net: psp: factor out psp
 connection setup
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261106-psp-v3-4-a8dd38f5a727@gmail.com>
 <179408516862.994134.13048510473902240219@kernel.org>
In-Reply-To: <179408516862.994134.13048510473902240219@kernel.org>

On Sat Nov 7, 2026 at 3:59 PM EST, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The commit message says "Here we are adding some more error
>   paths, so we just handle errors by closing the data sock".
>
> --
>
> selftests: drv-net: psp: factor out psp connection setup
>
> This commit moves the PSP connection setup and the assoc uapi calls in
> psp.py and psp_responder.c into helpers. Other tests that start with a ke=
y
> exchange can then reuse that sequence. It also makes run_session() close
> the data socket when conn_setup_psp() fails.
>
>> The caller of conn_setup_psp() not handling errors was preexisting. Here
>> we are adding some more error paths, so we just handle errors by closing
>> the data sock to make the code a bit more robust.
>
> [Severity: Low]
> This isn't a bug, but is the "adding some more error paths" part still
> accurate for v3?
>
> Before this patch, conn_setup_psp() returned -1 in three cases:
> psp_rx_assoc() returning NULL, recv() returning < 0, and psp_tx_assoc()
> returning NULL.
>
> After the patch, it fails in the same three cases:
>
>     rx_assoc() returns -1 when rsp is NULL
>     conn_setup_psp() returns -1 when recv() returns < 0
>     tx_assoc() returns -1 when tsp is NULL
>
> The v3 changelog says the per-version key length table was replaced with
> the key length from the kernel's rx-assoc reply. That table lookup looks
> like the only new way this function could fail, so the sentence may be
> left over from v1/v2.
>

Ah darn. I let local sashiko convince me it was a good idea not to
ignore the return code of conn_setup_psp(), even though it is purely a
preexisting "issue". Then, when I was writing the commit message, I
think I was looking at the code from the next patch where
handle_tx_assoc() rekey handler, has an extra check against the key
length.

If I have to respin, I'll probably drop the code chunk below entirely.
Otherwise if we can just edit the sentence:

"Here we are adding some more error paths, so we just handle errors by
closing the data sock".

so it says,

"Handle preexisting errors from conn_setup_psp(). No new error paths are
introduced."

Then it would be accurate.

> The only behaviour change is in run_session():
>
>     if (conn_setup_psp(ys, opts, data_sock)) {
>         close(data_sock);
>         data_sock =3D -1;
>     }
>
> Could the commit message give the actual reason for that change? For
> example, the existing failures can leave a half set up data socket open.

