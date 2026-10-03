Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F043AAF78
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791054605; cv=none; b=MR/RsAr2DJrG7F4BipnmGxcBCY7i+2TF5KyFaVVJinQ5j/EWozXmnURbZqVfEilsypuiBZzyR7hqgtpAHl/RDhyEfSr9YmgYBr4KKS9o/1dpiZDB7eAc7CphYOIuA8ztj2DKg41oqbw4tlRl8EOlP5q42UMtrALPMng8uO7VuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791054605; c=relaxed/simple;
	bh=9l+OxoriFoC+RlasPPdzwVFacd5gBceiA+dCH9ReKVE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NcW4OdRa2tYBDZ8Ob0ObCwIj+i0qqy/dyLDoDkZsgzYdHnJpHwxvWA2OYXTCV14+D4xW0dpBmYE19uxyoGd1c1pO/0FpYP0yDJWqOW6oxn7UiM0zHfKKJWlAKGp40Jx1O0JAbHXm1i8rgzuCazPZZIS3u5rR5wj0zeV8K2P9U/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdS7cG8E; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdS7cG8E"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43ac8d1eso3234517b3.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791054603; x=1791659403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yDs0pXY6srbOEiXUot76qwtYxxK6XW85+69Qt317Mvc=;
        b=FdS7cG8EV78IUzZy6KVJA87iED1uNRFeq/33qMg52NW9O8EkDcBoNMJJ9OdhFrezsy
         lKi53f1pSkEetcPDw8EsZ8eprVCypI3XEZxPqlDEAADLM+BDdHk6RMUw6KXAbgpORZ6B
         Y2SRfjoexwUFB8HVav0nnYPnQnXvDGlhUrxMj0hmSuNP0qOS64vQho61VSDBkjhHeZ1V
         Ol3W6vTkP7pAZPMVss08Ky5yXgJ9azG3CX3TlA2tSzk4Yh2iSvIOGBZqNrT+gyroOxAy
         9UMn0SfRJLTq4HX4raUVgme1XCQv8GdGOwkY9kjuiUiF2DHUdtj+RMdjbUGgL4vNvfwp
         9vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791054603; x=1791659403;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDs0pXY6srbOEiXUot76qwtYxxK6XW85+69Qt317Mvc=;
        b=MNNs4OkHZqRQ+5GnvQu3h0wto0zVwLJNkZmPVQby+kHXY6QqvJx6AvO/kwq0CSjPEh
         1zZutzzCut76+qkH3mIS9VXQe58Mb3R4a4+n2L+a7NJ970yYkzCLlQ1Toc2yHezDP+RV
         /fMASWjFx22qPZsLd4uj4fQsxW8vEN5NjjUfbeYL85j4pjQ35F+YqqySYi3ck/itJbqM
         X9MI/t8sbdy3LcUEbHHrKmPbqDWGrnhIatV8p5Fyzynyr2RbmOj8q+njZYw6yBjA2PrU
         ebrKKQJf+t/CokJnXSDehrrN57ESeaogAuT72ZrYsypEKdT3Gc1QCw0vD3sFrNGGNmKV
         jhIA==
X-Forwarded-Encrypted: i=1; AKwUvBy9vZn0SJcdWvXgngkIFd6DaYRpjthjC67Uj5vOr+SogW3vrb0xkj0XkRAlkiyDI8kqkm0W7T0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRzdA6RaedH2I0SlCF6m6IT8Ew56qUOyNiR57DLcLHHMfOZPYO
	FZUUfwjBCp60CMCpENmlDLHAhuVjTmdS1i37yT5oAuSy6nU6H2KVxRN4
X-Gm-Gg: AYBFou25GTouHS9XqH7PKh0+uXhQgw1UswSpAxIsqMsT46xDKbMbySmOMrFZGWKfCxs
	qCwo0CtbDnaVmnUEyWJ/edhyLREsCKSQtki2h56fcU601+sSlT4kdPkX1CkQH2EXv/0CfqSU09S
	6ndNstsfFmH1CWsyCZtw3hv2yUKvFTmlEueecXcb12RrBfhlkX9MnTbEuSdyd9Y7bPJnmOKY0XS
	qxcZ7pNpYR+vsVEfrPJ4Sk3KJ9B5BMc0j25diF7UrxL911Qx7zxZicT7sbVCeA5xdxRVDiC9GM0
	OLSh1cmiazfJed1HWxddt2X9lsS3+78iH2Hwe7l6LEp3p5pJhO8FyNE7dTI8ahJBPQxleZUgo6Q
	bJ9LM6E/vQF8H9vo3RkRwDzwKLNmP/GSdHU0kmWQjUXNUhyCJ39w4zw2sCo1P9vhNmayI1GzsaV
	fEpdoP4FOBJjEwg330RqB9kny3Du9qN3ihrPR3iZAST3sxom21luPI+AKDVZaI7XzGJwDxD/Mx4
	j7hiI9tw/20/5V/4DWv+CK9trk85v9T6bJJwXvdD80Cc80z7Dg2
X-Received: by 2002:a05:690c:698a:b0:8ae:c724:4297 with SMTP id 00721157ae682-8aec7245b3amr5485017b3.3.1791054603263;
        Sat, 03 Oct 2026 12:10:03 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae334e967dsm22735867b3.38.2026.10.03.12.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:10:02 -0700 (PDT)
Date: Sat, 03 Oct 2026 15:10:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Wang Zhan <wang.zhan@smartx.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>
Message-ID: <willemdebruijn.kernel.b74149b7fb41@gmail.com>
In-Reply-To: <20261002175950.2243500-1-wang.zhan@smartx.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com>
 <20260930111526.2183107-6-wang.zhan@smartx.com>
 <willemdebruijn.kernel.134bdb5c71ee0@gmail.com>
 <20261002175950.2243500-1-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v4 5/5] net: net_test: add tests for TCP
 re-segmentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> On Wed, 30 Sep 2026 15:53:09 -0400 Willem de Bruijn wrote:
> > Given that we have the above (concise) testcases: 
> >
> > Do we need to add the below verbose code? What does it add, just the
> > TCP specific path?
> 
> gso_test_tcp_resegment() is a v1 leftover, when tcp_gso_segment() needed a
> max_segs exception in its "untrusted source" check.  max_segs is passed
> through now, so it is unnecessary and can be dropped in v5.
> 
> gso_test_tcp_limit_l3_proto() was added in v3 for the L3 protocol limit
> lookup fix (1/5).
> 
> gso_test_tcp_resegment_l3_len() was added in v3 for the 64 KiB cap on the
> grouped output (4/5), from this sashiko report on v2:
> https://lore.kernel.org/179002380484.2160803.13955762820082413555@kernel.org/
> 
> You are right that they are verbose and one-off.  I do not have a concrete plan
> yet: I will try to trim them, or just drop them and add a selftest later.  Any
> suggestions?

The trade-off in added coverage vs added test code (that also has a
maintenance cost) is subjective.

I would maybe ask the LLM whether it can generate a significantly more
concise test that gives the same coverage. Initially they don't see to
optimize for size. It has worked for me before.

Otherwise, I'd drop 64KB limit test gso_test_tcp_resegment_l3_len, and
possibly both.

But as said subjective, your call.
