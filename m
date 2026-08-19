Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20693BBFA2
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155312; cv=pass; b=gDiEETsdu93tf8oSjIDFs6Cs7fj0ZiDmXvLAGTmCi6fcA6cjkOVJpHwmNsOXqvxGiy2vLLSZ1bb3JxqbnyYRbeEZPdANaKQNs+yUWF9jFboU6t3AutC8poXy8RPT9fBZOsU/m5jXUfKgMENf0Td/adm076Ci1SdCWMUZ3cS+7Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155312; c=relaxed/simple;
	bh=43WgxPth44CuqYCSLaQiPb0iqpI35dSY+V5djWAef50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6MUacQ2DCs3WizyHHaSaNmFBdSq3QA3m1AJ1dc91QTyA9sjEqXoLZYQfD4VHZ9MShv0yhSxJPY7O6bG9YI2vEQV+qwEaKkpfktxAcQaG3GbKI1SSmMNz3TZk0XKEttZ6bMv3cm7901403yx12dJJJKFjTMBtaq9yr1ANcmb98o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wXRSAFWU; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXRSAFWU"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c2a818fc4so7876891cf.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787155309; cv=none;
        d=google.com; s=arc-20260327;
        b=NxCbglitZHFurpx1AK51faHvTajlORt9UN/G0ZVUtcV/paA4D/KkI4P3S5GVSGfWM+
         d8v2ZS7CMsPAcR1VKHprLL07fVWHo6Yq8m4fHnmKIVfnHEqUolWtf/yJKTBYrKrvE2pQ
         24IJsjA8S+B5PahnYoU/+XZx0TkUwxQnXsuNpIRES9ojGagPusCyUNPFdu09a4uz25J0
         8bgiWxp8zP0EZXJqXJIVtz6wZEppyloKySjK4Kv+BnaylDdA7mpUIF7lpgRe1mOOFZ4i
         NOolJc8p0VhjuVmG3YYYJRvZB6v6/tTcYSvfqCYgYUcHYzHUHKNiRZH3vbJywXdgEwjq
         EgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=43WgxPth44CuqYCSLaQiPb0iqpI35dSY+V5djWAef50=;
        fh=X8BDq2/KK+aalG3nUimw3vzOLwCn/tnGxVtO1Bv9toQ=;
        b=NkU+B9JJrqzT4g3ujqhBUjGID6MXel8ofE7Bt1V6GFIS8fHOhyzYhVxFUvSpPUBlm5
         dufZItpWkiEO8tBMMxUUPrmXfvT3kk6bEwOGMfW+ZW8AO25Jm6n8CzokFfrALb5Unl2+
         x1YFJVsxq7bgESYjjb2+cBm1hRnNCSjIj71aW77ymiSEHo0Em260jOwDa+pA0UeBGxzs
         +NTYhcyFt7s+J7IeGsmJSNl3kF+FLgkEKc6NG1coy0my+DFi7hw/yYgweKsidS6qtfqe
         EnYLe3AedbdtvW0kdYRvzmX9IDwgbv+TG4hmiRRYPC2AClruidyY0hGSHUS7msFzakol
         b1Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787155309; x=1787760109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43WgxPth44CuqYCSLaQiPb0iqpI35dSY+V5djWAef50=;
        b=wXRSAFWUQQ3TQOvrajf8zo7AJwTr4d6Mc+0HJr5FnBuVXoyZzeqGce4jQ7F2VNh536
         aLi5qEb8YIBAN7lmwSx8AsWnD0epiqSQQfSqm56w+rHdV5ed3VE8f+c/+NT4YZ7XpuZN
         ZHuYMbiKNDTLenDwJtYWgR4QmkhP5JWCc6pK7nr8hsUYTCO12QrcNZVboC9NXkZ2pVAc
         xZ9leFfMfdHDO75eDTJyLc4XMY8ERs5U0AYJnC4f/hSB9ci60sRvVXdZ9wP35vrvTyFx
         BOm+IfwEXX78KV+lEYzbRz8kzn5tSjudTJrsWMF2NTC20LWpQ6so0MP6laq/wU1niqai
         qOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787155309; x=1787760109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43WgxPth44CuqYCSLaQiPb0iqpI35dSY+V5djWAef50=;
        b=LPAQ0m1Nq0rY/7H8pqYa7Pc4LeB9cBNmX5sA95M6sp9WllCvmuxhbElahO0sF+KUDP
         dugo7kRSl4K0UaoeHIjxbyhpYm5n8LEkU2PgeXWCMMk5D8TmjKvdOWWlU4LSUIUZS8oC
         NMx40E1gOX4+YrIRXFd0meWV4+zKrCicm/D6rjAYneem6sgcVP4N+WZPP034/B8bHbLz
         Ntx+D5vZJuHAcRVsJd0PRg9EoxW7kRIg2Lx110pD+V28640zd/jK+fzWgxLqz4doJ1kG
         dRQFQn1Z8pY123fjpGnWrZp2xwQltNjKRP4gz78Pd9m7L4Ycu9aqPYJKP+f1P+QgJUWW
         MRxQ==
X-Gm-Message-State: AOJu0YxAXXC+XMFYGx7QSkmKCdLCAFqBouGbvRxB5opd1aQJ4BnDBZ+Q
	xPrvJYqxqHfozuJ6d/ne23+XTEOaDfut0zE9bMhhBpUwY77xzEJsr7EphiPJwqbBp1z1kaJbguM
	XRKcwp4oJNrVK3CHWee7OeEx7xD2ftKDvI9nVh5s4
X-Gm-Gg: AR+sD12+3G7gRR/j/RaEriuofNdPIB22f2OYPgAUKu/kKNrEl6He3ydQNnc0SQ9K8eH
	rb4HFqloYXAygV/xVUMGnCe+T8uUwzXiz8sSIU9Ft4VK+PEajv8CWlDoyQXB0QZ88GLY4HXNx1C
	tutJoIzNMdPenghPvgkW7g2yxHrn3j6U97J+H/Z9xAqBQvxZbGXMidWlyHscHh1we1Zrq30vJHY
	oc/8kaq+P8+uKLTsz3Pq4RLUaDoPmy2uOLER0ggzP1Sxq1AbxRuleAKhU+p7rNB5ZKhsSnrdQwC
	hQkAt0fHBUB4Vi9Lrd0q2eQc3J8Ea4LO9GX44eWn+YKtONeiExoCX0HWgpPQuMlKRU7BLT6a+im
	xTHOXiqHIqkz10njH5wKdczntqWA8fzGudYMJpXJbzOuVlXZLf39voBgp3jakZnrUJ9rDTQRGOz
	25AY2HnaMBdrYA4WQ=
X-Received: by 2002:a05:622a:1f87:b0:528:22:8c61 with SMTP id
 d75a77b69052e-52dd5caceadmr58314551cf.38.1787155308636; Wed, 19 Aug 2026
 09:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com> <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
 <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
 <CANn89iK+xzagk9faUSjHQj+9kTnWn0wg6tRez5XtkE14G+SCvQ@mail.gmail.com> <CAM0EoM=6C=yarfbjtegiobdK9jvLzLwJSSMxFBYDiG6XtZQ35w@mail.gmail.com>
In-Reply-To: <CAM0EoM=6C=yarfbjtegiobdK9jvLzLwJSSMxFBYDiG6XtZQ35w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 18:01:37 +0200
X-Gm-Features: AcwNN1UxvWHBCT8HDHQEZVo6y7JWszgVh6-23ZZ3QgUYycuQqHowaQerrtfBw9s
Message-ID: <CANn89iLD-c930HoW0tf+A3c+5ANHv7iRzy0wFt-HqNFswtee9g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 5:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Ok. So one patch per file?

I would have done that, but you are the net/sched maintainer, I will
certainly respect your choice :)
