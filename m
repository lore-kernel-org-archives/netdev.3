Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793712174;
	b=QPyd5Agx0BfqgWVTRqb72kX9b+h7TSEVS8dLyUhJ5xl2mA7lIBJfW/4Z4BRjKWBSN57k
	 5elcXW/zZdr2N9PYAcOosNTZQSp/JEmmjKv9k872CIsCCx3l5qbqXq6W+rvJeEy5A9AB4
	 1uqpVfuUrcLqXYBt6g7/LI63pneg0/4d9IdS4iL+WYgtlHN0ephctquCKZIrcOT5tQFNL
	 blWz8PXhod+7FTIUXpziGmPgfQr/8+V9gwwYwBByzcB5plpkqJP6o5ZXGhx6D0aUYyJ+8
	 fZaD+Im63IcDi6F+/KzqZt9vx4ZNmOVwWJIfGqXkvBzmb646D1rM9etVszh7AfRBpiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=9KwHQjKFgpi0i5HGrc0Hhrq2/ezRelX2eB7Zkx5u6DY=;
	b=gbRtfY4QLpMqFx/MfBf4p6hBNz+pzEDdkZIT5zmIFT0R6517w9/O2wYTUnjPdr+mQeUP
	 FRRi5nXP3VCT7d4kl59un81WlrM2+XchYKyG55jVls5V+BBckzD9UYue5939EIiC95q9H
	 mz7lG3M8RpYcTUtRydu1iLe3JaaAXyeSLutqvA/jV5YU7jDrhylYJmPCMcfWv68twt57l
	 EPUd97TI49rxoD8DX0rvAxCKLikoZjVmiI6YH+z/zyvGUG9J15LLUOWwtWKoydHtXZn/m
	 HOZIrZ2mGWHDFJq92WIPiIH75IbiM9VHkvmPx6w1MW+CEhLHmmxoEV3RM3K/Pzgz2lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LLh5VG3m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BC606A32F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D4BC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LLh5VG3m
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so7034542c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 05:22:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793712173; cv=none;
        d=google.com; s=arc-20260327;
        b=gLyWHWYx1pp+kRto1DEyiTMHbag1bnz6c6aYhuOZ7JUXbP08D0vnOaubr5R55nkEFR
         TGCjMB8HRwFenFJlpOqT5kUuYqGcRlLllO94rJ9kFQo7CLTqRAUnuSfdTAokCzJn8tnQ
         WgtH1zMstxx6XhWR8DHCHMzEX8lxIGZidWE7z4xcXALCA7OTpJMJiyY7J3JaI0yuDQcK
         mcWIkaCjYZk45TslIk+L12looRUv2O5p1T5Efu+mtCUjlSLfVmMSGU1EEeu1QXRMnOtr
         bFAU/z2BAeVvvX1+lv3OuaWNqp/y6kkZz3M5GgqV4LaplO4Ewbt7+VktYDOGqtZ6yRXH
         /XMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9KwHQjKFgpi0i5HGrc0Hhrq2/ezRelX2eB7Zkx5u6DY=;
        fh=8mvxw27cMHR1v4Sb56csdvR8zJXEn8t7VsNS/8eHB7Q=;
        b=c+72IyTLNcDvC5/erZehnWwNQNJCUEzEGBuhk1sfulJMwYG6a1GQ4GAi5YH8aTxlvS
         IWWpHWjC6joy6mhFm+I9bf8u5CmzTh443dP3TeneydmLITF7qqh8TkVxZrNYNEhDwNx5
         eGqCwytIsRRGn2njB7rlckI3YSxVVVzQjjH6knsq4IsPuQPgph7NY7TBgi/vd6JM4GQJ
         IIcd0JvXPkNfcxAYiTO/DbsXoE1940yQFkvodp0nLwW4hTsLK1s6J6nTMw0TN78ks0i6
         vY2Wrx5IOCQEklNu5+2dIonXa96B0l6p7yhMnLhiXjaGWiNbidFIB8I44hyqhZh3rluT
         vpXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793712173; x=1794316973; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KwHQjKFgpi0i5HGrc0Hhrq2/ezRelX2eB7Zkx5u6DY=;
        b=LLh5VG3mzq6P73mPT2KOAC9nz25lAyw+SDCybhoVaLrd3LAVuKn9AZhFQT8xGoUAd9
         iQ0eRBok6NHOOLJ2ANEl6qkXp/wt5IFJ/+Qx2f95sa3nhX6NdymbhjVQnrmkJ/AJnFto
         ZIaj8rqgn2ZwLoTcs5CAJwz/kV3cklSf03nxZajGgeydaiA8pC2fG3kAnmNZPwkGTiar
         qhI7W8mhvvibw/2NFz4T7Lt6IwCOEsfbpbsMtG1d5ds7bewzjqZ419EleHQXGlcPto1l
         zCyUnm1bouoFLg00MNC9RnFVmUD61LraI9k0+bE6MoTfmm/dW30/DztVcoNEf+rF0IJg
         a5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793712173; x=1794316973;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9KwHQjKFgpi0i5HGrc0Hhrq2/ezRelX2eB7Zkx5u6DY=;
        b=iR1URaUCwth4fH+gVY94ufkL1z//OzRgYItvFAeCk89tEv8u0i2mS0MZ2MakYARjIP
         NADJCl8VGisNkpttLIrMjkGbcfBKkY82FxcferELkjFvR5abWz+vWRJL+dB9KLJI4Tj7
         P1AV9kTLzTy+6p7ICLKiuS2eUsJb0nr2L7zYB9n/2peo8tzGpzdG53rnYUA6AnZXwtC2
         vIzbTkrOHDw3cMSpNVzPXSlb9es3aZj33INAkNEXrMH7ue0LhSynZVAM51gT8ZqDl3lR
         25r3AvPS9SpWNEyCMmsIG6Zn/Hn9944m8zfnoVMeXmg/TIcFXjnVGfORg0NzyNFCq8ha
         dPrg==
X-Gm-Message-State: APuU4Z+bd1JxPAR6DksEUDgkyByriOX/sF8ThgTHiGlxJsEWktne2fo0
	S7xoVdP272qTeEGpOjpiPQdzRTSIheBKI2B4Qgi5yJ65uhVk3OWDXHAJqPynNy6jGi547K2rog5
	GEp6xTyhzak4CR+/zi+nKhw6h2wWt+Jo=
X-Gm-Gg: AYBFou0JSIWQEGmml6y/b1ZW52ZbW3tlfQ4GSWzLqOGDUa6wlYNlqZ7BWTtqhnTTidY
	Ubb/U0XHQDz8vzjWiAJbI4mBMSwUD0QtazIUh5IjV40RkNElBKP6Tit0OVV9gDEquRh+4Bxoy89
	Q82QY/7skCTKxDOREiINV+H/7jP2SoQkf8c1pxNOagQ3obE3iJ7FiKyKq4sywpPm1Km0T+BbTFf
	69wPlBj5SFy1cZiwecSGK0HGZ7BIZDuLetOEaYwITQLYM755C1xcIZkuUqYLBZ43gCbjYnOB/Ki
	E8kLgcxTTxpSe6/I1rvOe7DuaWSxQaQWzsDj6HFsUqN2VSeMyJqp38T3WyndrEEjEd2hVMXXshR
	oeMBR9bE3sLNG207N1f+mCATETxyFGT1vkeq2
X-Received: by 2002:a05:701b:450e:10b0:14c:637d:682d with SMTP id
 a92af1059eb24-1ac5d69f6a1mr19043531c88.43.1793712173117; Tue, 03 Nov 2026
 05:22:53 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101150240.66292-1-timur.stukan.linux@gmail.com> <179354572351.3286.5042962273582442842@kernel.org>
In-Reply-To: <179354572351.3286.5042962273582442842@kernel.org>
From: Timur Stukan <timur.stukan.linux@gmail.com>
Date: Tue, 3 Nov 2026 15:22:41 +0200
X-Gm-Features: AclHuK-C5xGCzX7-O3YYlIZKLZWlvhm5d8m0-ahEBg7449qGEWBHvcs7hKepSTA
Message-ID: <CAF+_u5DHF4UW-8p+BRKzCPWELOLVqhnO5Jz+WiJR0dL_BWS7rw@mail.gmail.com>
Subject: Re: [PATCH net v3] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Hangbin Liu <hangbin.liu@linux.dev>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Fernando Fernandez Mancera <fmancera@suse.de>, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Nov 2026 at 17:08, <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,

This was found by manual code inspection of bond_miimon_commit() while
working on the bonding driver, and then reproduced in a VM with e1000e
interfaces.

Timur.
