Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D981C84CB
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855914; cv=pass; b=rsfBjOXKKD/4KdzjKcuI2Mq/6cQHTTVC53P7GflGxPlTFn+4wgku5FJDadtgyWuTMMHpO4rKERQbZJL+iXZIqw3LhBiaTbAUGlJZ9+bq38qLVSUCtwQctAMSPokoJyrfx0WjlV/bBethtV/LnaJBvk0+DH/4W1l8IUvL9S4PaUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855914; c=relaxed/simple;
	bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJd2HH2A5701jqNA3hB3mIcWd2emTDnIUWWFgntuZLmNcw8xSJqrbOiepZsylX2B5FfgVfK7s+8G0ud0IfTTtNyVJ12n2s3FWyFCfnXvB7R0xK+5sY589PYZFzGd396h80G1Ul4F8uPe9k/MHJSNBUHFhyf8LXA1NyLJO+ZEdC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXsEqth1; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXsEqth1"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5339733feb9so23565061cf.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791855911; cv=none;
        d=google.com; s=arc-20260327;
        b=R7ycxR5GEXAz5rvp+hrRr0SntJu1w/9bc5KYt+R0IksH+MTDzxA+Niw/vc9UJXNn+g
         qalcaGDiSRQUUTCkHaL7H0itt60wuSy6LzC1ww+VCgTHSwVbGHzQqEGPMNun9Xawqg73
         oCLBt18WYJZfqwLnus7Ip5kHDcBtY9f4BQY4wkR0STMvm7cFYK3+TO6He63ijE2ZVo1N
         VMc28KK9gEywvVOY2DI7OIuCXE+Jr7BgU3J6n9gw4p4bgqzbJEkhGBPW4nmtPTAHnnyM
         Mo3USkNJnpcy/mAY3vLfe/bRPwzNzvF04vXFS8efmKjLZTHq+4OKKQOnX7KHMqfWvq/9
         nDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
        fh=YYhea5ZSlzKoIXDQAau372PALS/kgz2oI2hw4OEeTIo=;
        b=XwDARcaq8BvjutRshw3XjR6irmyYavxckyx8H8Xc+ZzruZtDpf8xQRYXWSLR1kyFYj
         etW/2Z49YbLedVr0zGrKQt8+L13/bB9XjpoRQC0oh4V4mrOo6rSXNGq39lUKhpGbDsGR
         QL7iXdDY+BEMsm+ZKLZepAA/iZ4+GrU5IoTgz6mHl8+hxdD95svRqaWwvSpANEqMhaLD
         TtiwAUeiRY7Us+3U4+Y1Xy1KciyztnUUyOAwFEDf2g/lhqhsv1i7ngqnaw6S1VdFWixT
         6JQ8uJ9cucCKGqkpFAWS0bj4Pa7JsVXBwSDxiX3j/g00Vy3YM0KOYXJcG0hECyVy8fkZ
         wSpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791855911; x=1792460711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
        b=dXsEqth1P9jLVPPBygKZYVsdWxVsgJ001QvH6xJILCjdlHJNtXXFmUrPWXnAoaYPKf
         2YaADamCfb47RAK/+GZ5046cFz9FJJpDnLJkI9it/4Hq3rdXleE7Hxrl/O75O0aL68CY
         CcrmyphYhMN1nt6zk/rGRSdSOYgqW5fJK+YH8pY6JLdO/XMUNf06xVM9b1dvExYXqQ/2
         3bqQxG5m06URnmTFSCqEPcyziNcgwqLJfg6ayLpJ/z2JHxdF9KE7gcNPeWzmfheCD1Gp
         5mFlgszfUEdoVWbKZhQsP7WZsBQjnDTSjdR4BpWsN/47562yAJyrA1dDNr0BETOLfzg7
         CVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791855911; x=1792460711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
        b=bI2WspVqnnGR0DGugKfuNXS0XyF9qZ2tS2UiWXh+DGKAM+Hm9v7QWPaXnxqYXThTow
         r9DZhp9ONcIuDZ1G2VUN67QKdv972b/JMSVgemAfNrl2ciybsEI04cetN6zDQbl10wBt
         ISFerYV/0XlO8ZMQBK6lR+1YEAHeu35vW2JZKpCFu6Bplne3SYjrRP7RFmW3M1+S19W+
         +T4ulc4S+WMBas4/wt8oVUKaYWbHxQqTwOkAaN5sJ8xx01sZ3IqV4G8lRtS8+Vyx0ejj
         enAgL1GmaXr/zCNfqeGF5BymIwonOC7H2py8+bqMXf7ZK/L1amC1cX0+d/J387Dz2lRY
         u08g==
X-Forwarded-Encrypted: i=1; AKwUvByjbIlt09K0Fz0IkqbULWCusahpSC3d5kO3SUdbxShyQ+K75rcoUsGLcf65HbBdTakYbOFUHk0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIujLdQOiUXVF5NNoJnbY0dnCICY1gQe1Wi1lBDH5IC3Ta6dmxR
	j3U8pf85r/1dmmWYmo2OiwYQN7RbZUH4xKYYt3zQVx8OqT6LmYVZVR4tErEs09+7PMWkMCjpRw7
	gsO5PyjJWP+A8oR+lTzoet5rQkQO5LtU=
X-Gm-Gg: AYBFou1TZ03umRbMf6Y1pDIG1Cicl4IXQVqc7geppX9SOFdUBrLhOaL9zYu4/eFRCow
	WtEzEmVHlA1/c5z1LyNrViWPjnkAto/09i2aF+eQB7RXcIzFrDHQYgu2RkfhSgMci3IRFUjGjQB
	4ir/zRSx0eufSRVJhDs9E1BcBEw1CcXdxV2yRLDpZZJAg3Rw37ynbVR52mLaKZge66UABLnI/nt
	KRrXcoSFsWSd6VeROv1JDIFVRsOZvFUm2Vs76Qe7J4JnV6GRluCeLRwppzEw1Zc6fnXjbWTKReB
	EHd9h1mrPKn/OPl4vzutwAy4ZOPVHY9iI7raTAXtXBoZ22tzeUrkZXYswHK2Wly0BblSSeGx8QJ
	ie+Tcwm1FzCtiNsfbcgyv6tcriQpfV7IouulcGySc+VrzRng2qy5azZMqkxuhbBnCtwQe3A==
X-Received: by 2002:a05:622a:342:b0:530:430d:87f7 with SMTP id
 d75a77b69052e-5359fba77f7mr196535301cf.47.1791855910479; Mon, 12 Oct 2026
 18:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com> <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
In-Reply-To: <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Mon, 12 Oct 2026 22:44:55 -0300
X-Gm-Features: AclHuK-kA8q05fe6Esk_oixM2BCHb47BieLQLjZDYfiDhY6CS2aMRdOMVHtXa5s
Message-ID: <CAMAsx6fKVQaYLzkK34v5DRkmQS5Ym-XqwNh-+Jj_Uue8NJCNUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
To: bobbyeshleman@meta.com
Cc: sgarzare@redhat.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com, 
	jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com, 
	edumazet@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	bobbyeshleman@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 12 de out. de 2026 =C3=A0s 19:51, Bobby Eshleman
<bobbyeshleman@meta.com> escreveu:
>
[...]
> + Movement to an unreachable local namespace results in sockets being
> + closed with ECONNRESET. Peers are not guaranteed to be notified via
> + an RST.

This reads a bit differently from the sysctl documentation in the same
patch, which says:

Connections established before the move, from a namespace that can no
longer reach the device, are closed with ``ECONNRESET``.

The net.rst wording also covers moving the device back to init_net from
a local namespace, which this sentence does not. Maybe use the same
wording here:

Connections established before the move, from a namespace that can
no longer reach the device, are closed with ECONNRESET. Peers are not
guaranteed to be notified via an RST.

Daniel
