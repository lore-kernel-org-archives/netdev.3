Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED09442FDE
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565959; cv=pass; b=BuC2yaKLXVt7VUWquLhYP0sKjqI/+GhusTjN/mqwd+aB5GY8800odoDWE6tFEvQYs9qjZ4+VPSGT2rOUHFe6/Wa4cCA0c6C8UYpfj4G+dKZhGW1WemMMVxkTiRc7y7nGISgGxSr8E5m0ji/an//xkUYNIh+jNAJWV5PLtsJYSvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565959; c=relaxed/simple;
	bh=cLC8ot5pIh8dTgfPfSXv0InXlRDbr7JPQ3f53NKUd7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJpVieufe2mXNJQuDQwk9Tds7324D5mgyFnCRjGJ3zI7SkzB5ruHesmivtXQFa5yfhXokbmdZHB/EIhEc3/qwWwFHe+tAEPipVPCK8crhtSytwuMEhJyMIN0hoORIzSe/SnRqaAgDOdcwH/5h656pvuA0gIJdSIBW2Yv+scpbjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ef3RavDi; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ef3RavDi"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8efcef23d21so102507916d6.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784565954; cv=none;
        d=google.com; s=arc-20260327;
        b=fPSvqbyhlbGQLL1vehMSuYfpikdQHBRgbE2oRvfzWTTQiBfCC/Jho4hVRCvfYdrvYg
         MIzMCdqyIk7Y9SnwAcWzrcXQHHisIMnC9BVHHXqm5JTyoS2Z8wMAYW4xIl9onSqDEo+f
         +vvLIK1ku0PMGLr+1wiM1Sa1sFEjYuZmTcDVXb7CfjsUQQKgjx4/4cCwWm4Cs2WZ8FDk
         fexeNQ7VmA0N2n3Eq7HX6A3f8XRTUZrPu9wH3hsST8+OolOl2OhrfkfdXQ+DtVZcW1tL
         XsoB9YpxJ1tZ+sE5XixBGKXEOZG/FIbRoWL9iiKDWMkE3n0tXTx6MPv3nCNvk/9X7biR
         ORMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GdwLLcl2D8Tg+THUNONwAYfn4D48wOZssB4/wTdyRPc=;
        fh=ROZCR13GUqm/DnmvxwUeCob8K5Xhn9IKj4qE+YDSrM8=;
        b=M78Qw0NQTP74FeWmJJ3dUU+ussgC73yOkMN/5br5GrltGQyiwdmYjqgTStCL8UEJyX
         kTpoJDWD/V+EMFELcdTWsE4m15qa/E36yubvZvi/cAqYmS3UPja4D4Sp1shhoitadPf9
         DhnkL+5LHXztxIFBp3q2DBYtWINoVPsb3vOdtvG4DnetQd2MGa9zCWAlFptoLcWG5Ji3
         toWwkG41JpznLL+2n4ZzzKWAM0I8gLc/xuJiLFadn3DJ+zDhYYCSs/Z13t02z2TXhxJt
         seeHMKQaZpTJ6oA4hHKLo/xHB9FJkadhwp4/Set/7LcBCinrDu5C6eRjYJ7PwuJN1g86
         CzAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784565954; x=1785170754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GdwLLcl2D8Tg+THUNONwAYfn4D48wOZssB4/wTdyRPc=;
        b=ef3RavDi6HFd+z+zH3QM6jISvan9h8Cr2f6izcVbqNYfbAnOetyu0v5IroONtZSkFb
         6Dm1YbNLisFXUgR2i3tq6YdUpZE/oAUJUqApejLJD4uwHlEhbXSvaEJs6GXqSgYxhnsp
         PeKUQv/SVRwLZ1IKFIyRz6O8YMTtF70CjWZvEfo9nNC2dbNw4Mnpn72zXcc8XvL4ZyYM
         R5Mbmt34oYBt5MhCiH2uRbIzP8jE4DqtoPnNZJAnlW72gs/9SoceHOZsSa3YmWTx6oV0
         uxhxZk3q34YEK8JdrcVF9E8RIhGdD1uZ8GH4CDYFRuLy6DrW6FK/Uu23NZ2vSzDAx2TA
         114g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784565954; x=1785170754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GdwLLcl2D8Tg+THUNONwAYfn4D48wOZssB4/wTdyRPc=;
        b=PS3zVXtFuAi2Q902wuwWZtYBcaOAUGWKD97JFbKYjrpRCgDdvcKU5oBD4pelgSrxcJ
         xc6iuBWGBjSdtufnjm5cdS4oL/jN9ly1LgMS4Ksv24JtTcewFiK7LWhNhO6r/ECxEUaX
         067ffqcdz+GiFxMTM2kXL0zIQHO4YXyPdMcTjV7rENx4EWRAHriscnGuS3GnVRv9rvTD
         SLdsAFC1nH4S1QVO0BmdaYRzsQbKoG0x+BYcxZiwYS1dPFNal65f5q09cbaSxP5xhmRs
         QfxGIJ7nMyXMghszscv7YxfkUv4MlsYSBJZqMp4yJZIv+pf2ePQCP+E3ZLo1Nx42LFDe
         7tEg==
X-Gm-Message-State: AOJu0YxhAcpiZhFG8fj2hq4hXHy4tZwE6ZrWW0HE4CxQaKoG4XPDfHEt
	H8gjPDC7QLri71IoBqyF0unrPZlJtWgPu/OoNnTM7Y87jzeHkw4EEPpYU8+HA9DcMoF1nEasbin
	D3H3LClW8tr81moESOuH7Wzfoy6q5Ku6yr1BVYaJHqMlcsJdhe5LLjJNCYIQ=
X-Gm-Gg: AfdE7cly0j3uPPztsV+AuVmCaGibCkSV1yRyRmOrLuOePQFePh4kbY9i4ns4mRrcMcK
	TT7PRXuz6n7AS1IXDonaBxWASoXA0Qd3PxivhNrxl7RNYiS8JYjX26O3O2/ysRh3O0CtDd15QG4
	4PfAR4It6tOqGeRyIne0ziDGZoAXCafonyzLC5us1lTfBpPkXCDEeq8ORf6WdaSju5X5JYSjsUg
	6WlGV9gOjKOjoDIDaipF9EG0q/U+UzKaOXnyZe4OPI96R7RsWJk4wqbwm9RlxYiHSbmC7xuWhLj
	1PPGkJ4ZIETsac/8ubhQlyp+wcjnchM2ba+1IajQ1iLyzwP2u4fbYGA9mCynrOwGviAIcMllMA=
	=
X-Received: by 2002:a05:620a:1a01:b0:92e:fe10:3ef4 with SMTP id
 af79cd13be357-930b416cd6cmr1462059285a.45.1784565953237; Mon, 20 Jul 2026
 09:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717081443.809393-1-yangyx22@mails.tsinghua.edu.cn> <20260717081443.809393-2-yangyx22@mails.tsinghua.edu.cn>
In-Reply-To: <20260717081443.809393-2-yangyx22@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Jul 2026 18:45:41 +0200
X-Gm-Features: AUfX_mx_QTBHnNcHo-EzNtIineQrXil4DzAF5RnVr3HpqgIh9UQ6m863CpRTp-A
Message-ID: <CANn89i+TBXezN9MMoUZbig3F8DK+J+-MN+P3F74V=v04CXMMMA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: challenge ACK for non-exact RST in SYN-RECEIVED
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org, yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 10:15=E2=80=AFAM Yuxiang Yang
<yangyx22@mails.tsinghua.edu.cn> wrote:
>
> The SYN-RECEIVED request-socket path in tcp_check_req() accepts an
> in-window RST without requiring SEG.SEQ to exactly match RCV.NXT.  A
> non-exact RST therefore removes the request instead of eliciting a
> challenge ACK.
>
> RFC 9293 section 3.10.7.4 applies the RFC 5961 reset check in
> SYN-RECEIVED: an exact RST resets the connection, while a non-exact
> in-window RST must trigger a challenge ACK and be dropped.
>
> Apply that check before the ACK-field validation, following the RFC
> sequence-number, RST, then ACK processing order.  Factor the per-netns
> challenge ACK quota out of tcp_send_challenge_ack() so request sockets
> can share it.  Use the request socket's send_ack() callback and its own
> out-of-window ACK timestamp to send and rate-limit the response.
>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Fixes: 282f23c6ee34 ("tcp: implement RFC 5961 3.2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>

Note : Please do not add a Reported-by: Yuxiang Yang
<yangyx22@mails.tsinghua.edu.cn> if you are the patch author.

The amount of noise in this patch footer is quite annoying.

Reviewed-by: Eric Dumazet <edumazet@google.com>
