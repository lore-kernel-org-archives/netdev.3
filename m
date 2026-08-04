Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202F4570F5
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857816; cv=pass; b=NTcod7eh04nq5P/XgALNsbO1VzoIWrONPbGKAuk2H//1J4bNrNLszS4qXnvfk5/9sFqmMIKjeXb516O6qNx6DJ6ubnkRUOgfbTTozkZI5/DEB0w69vlxZnC1VYj9x2T/g2tQRdXwBma2i6WJhlI1r2cnkUldki9+24j5dV6uTzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857816; c=relaxed/simple;
	bh=QoqA5p+Wuo8wFkgQJ36BVaTJYSEKleUgWMC9y+XvXXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOwC7LuMI8AgGWC3pWTtzUTG9VOtH138SteTHOJVdOHyaSPVWFeUoLmo120+WHdDW8cNs8sIjKu7EGSPXDAxAf+J3VQd+riGKueXRk/lucfnZK0B0KQTqLPfD319cNyRCKBcCtbEznzUqwaRUv02WXCH+sX0U8F/1vBEtY6BOU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjc2wqYS; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjc2wqYS"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cab97c86bdso131935ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785857814; cv=none;
        d=google.com; s=arc-20260327;
        b=GXxpme7AHlp83MtrlKSYSUH+/odwptMNJ68Xpx6XgeM007kfZv9ku5VjiSP/7Dp6dS
         KKdiA97MtSCIs6k3a9TbFesFwIQC+GNJKkoCyynSXhw8kEFCYlnlxV81a16ow7HMoFy4
         fGvY+88/wMu8ErfdeinSFBUAVQuppsXI+2oxxmlS+NN8rtPWwSezCMX0EBMCP4F0zbKO
         mF2oQM0c+lXkl9Wyd6XUnS/8p4v5PfzWIMYx/FeEcCF71JjWrIizTHjLsPWRxucZJ36a
         jwS2ag+hVdRY9Cy40BYUfU8G57VtU9XcfH8jfr1qO9St1Ky1jso0JJUJz1BmnrcDY3rQ
         QQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHvR8jpL0frcraM9Qb/892YAD+UgJpqS6viyACeo2sQ=;
        fh=A8pq0rKAB5cbTjfMHGCyqThCkW0TXyatxEc24nOAoQc=;
        b=JWJyX5/RQYf/1lim8UQzKob5DtUPsl3ZeTnNB75J+0+SCZbL44jcFYnWubu36OZJhT
         hfT4XcmK946qAF/FrkTE6dZBy02tkkTnSwb9fSAtHyjbWJcFlB9sv7Xo/L9PfZCODR6d
         bdr2tgaBG5D5BYIQHMGLHoCFyDrBg7A6bCef1dPulHKeC7JOHKNfhofxyVHgS7UDIuo+
         NXN0G64cr0FH/fdtP8Rm7gyiv554Ihl5TNQgzbU9zXP+nUV/o2qRUtgkXBRoYPV3Oebh
         /unzkTyrUqAFwnsbK5l/L8WCdu/7SQHNi/3qFO225GGdEcT59DspLKYgUAQlBVokn+11
         jXIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785857814; x=1786462614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NHvR8jpL0frcraM9Qb/892YAD+UgJpqS6viyACeo2sQ=;
        b=gjc2wqYSvgYNem9/nmYs8R7KtoorjHj45j9gi0iDyr5VnjGjVTz3UbFwZToiddK1Og
         JV2TX2qr0p4uTcVy+Vu6RXQIv1N5SbqpOVXqLrq9WzwphcygK5qM9ll8S8KywzU6oIy0
         M6CZGm/U83hu2dCceVc6GFFSRiBRX7K5lHfON7v4MSo2sXyVoxW86VlXC5Mr0jS6Lg68
         Ykm/PJPDaFrpyH5jH8gTdz+R8w5eUXAEInZ0Nsrp5N503/cRzhZhQdcxS3jrP/WqCMgW
         A5fPds0SlrYBobx7j4OtNGCgYoXJHjkJbo88v+QxBrLFYSbjhSxv/h0R4MEwIv3xCq41
         /+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857814; x=1786462614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHvR8jpL0frcraM9Qb/892YAD+UgJpqS6viyACeo2sQ=;
        b=D+vkkHFlJqb/s/LvXDFYVJMlfmCec/HaZnmYqzASbEAnvUdjGUf8YxLHHtNf3UkErj
         YCCJc4ZF2uTO1SwyEQUFlx2FO3JsAVmjeA4A2QO/7rFN06W/ED4StYQVKiYjH49rl38i
         pXgkJe/uLnXjp09dIh4HEVDrDzZsecKIjiBULnojUmry+G0vbzQ1xLze4QArLrDTW/Mf
         XMlxrDS1YiCIyKAbu4KKd5ERrftRky9aVz6ibKuEVycf7o5EZ65tP+6aYr4qIrwssqKK
         rheW3AayIo6WXxovXQ8aqobQ9MSSoVoAhAlKWA4qnDAruurxrrRZnBfNLX3vwqnUL9Rx
         61NA==
X-Gm-Message-State: AOJu0YxktfDLeNB6P+iKgEJdBjpccKoioaP/CMvIFQsA+5aDMES5TL6E
	SAFaIUIoMEq7Ii1e2+acHtTyyfp9EHFRgbyccegXkTFbbMowUQ5TM2rjtOJquUfGvmt6kKa7Ele
	L24RnolsJDBbSLnz6OI77NCJIb56VHRV0teo/9pVt5OJ1g7sk5JPW5gct
X-Gm-Gg: AR+sD10U7pA8OrGOthWFDxlSKwsidOtUWGUkAxGRicGoowCPf/XpKbsYEp3mQPXWaIZ
	kYVyBCIdKwHaJkRqxZ0JECXlKsRk+6mKziaOjxb8UiYxJcrFrmRORILkdQMQUND4CeApDNiZqrY
	HyYQ2CAcrDmUDuEzwVfRY1gqj8+fPR5dgIIDYwVFtUy2EkJ1IuDKJSk+TXqiKx5WkOQHBdhOpFz
	xGm+Cj+WCOqXau95D67N60a8b5Pg2mrqcjK4WC0Q/FiDP0HvDPc9E0y3FDc08vEFWfMirUpv3j1
	gnhvuilTpoq86Qn5uYm1R+xl+lyF+mjY4WTOTj4OmArq
X-Received: by 2002:a17:903:41d1:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2d0bb0c2b23mr1282675ad.1.1785857812960; Tue, 04 Aug 2026
 08:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803171441.408014-1-almasrymina@google.com>
 <20260803171441.408014-2-almasrymina@google.com> <20260803125414.500138af@kernel.org>
In-Reply-To: <20260803125414.500138af@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 4 Aug 2026 08:36:40 -0700
X-Gm-Features: AUfX_mzy5kYFIzbtflFGs3lGly5zlL2NqHWr9z7AMn8mNiMPfUlJW8TL4oWNol8
Message-ID: <CAHS8izMK_GNTmoUnkNB4iJv-7msx0F+vugg+-dTCcyRxyk3YQA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net: devmem: return EMSGSIZE on type mismatch
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	kerneljasonxing@gmail.com, kuniyu@google.com, bjorn@kernel.org, 
	jiayuan.chen@linux.dev, kaiyuanz@google.com, willemb@google.com, 
	asml.silence@gmail.com, sdf@fomichev.me, bobbyeshleman@gmail.com, 
	fw@strlen.de, Neal Cardwell <ncardwell@google.com>, Ralf Lici <ralf@mandelbit.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 12:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  3 Aug 2026 17:14:40 +0000 Mina Almasry wrote:
> > When a devmem payload mixes with a standard page payload, return
> > -EMSGSIZE instead of -EFAULT. This enables tcp_sendmsg to seamlessly
> > fall back to creating a new segment instead of failing the socket send.
>
> Sure but AFAIU this was discovered during a ML discussion,
> so the change is an improvement for net-next rather than a fix.
> Do you have any reason to believe that real applications hit
> the error?
>

No, I don't have a reason; I just thought it was a straightforward fix
you might want to take in net. I can definitely punt this to net-next.
I'm a bit unsure whether you want this series reposted as v3 without
this patch, or if you're going to take the other 2 patches. I guess if
I don't see the rest merged I'll repost. Thanks!

> Also please add cover letters for submissions with more than 2 patches.

Will do, thanks! I'm slightly unsure about a commit message that
basically says "Here a bunch of fixes to devmem reported by sashiko.",
but I'll give that a shot.

--=20
Thanks,
Mina
