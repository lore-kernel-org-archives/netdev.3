Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792684021;
	b=pVSh65AaWXStFrNDMRJC8QsNla9xm+RbeVcaVbLxNshkW7uBBrldMt3sWm0BEn8rshFl
	 9UyccB/XBTR26TspjSj8p34Gu315HLwwHHCLj+8iioJtKYdIsNXR1mpXPMQK3GnTD//E8
	 5uJ46Wd36QpDqheirjTztMiJ+3D6tiH+UXIpoN0WczpXP7lqEt96IncdoGVvw+7BcJEA0
	 byD+h2BYjLQczvf1Pgs9M6jqAZERAaA9ylpzY8VrtQ5buXMwXs2QANknr0bixGJsW9duP
	 wH5zk8J66kzK30JUiZ6sUabs5spg2gWErSgVUjrBjBrkqcv5ugsLTnJveMnBlhsdJgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K87CCPS1qg3XSuuyQwUVQwMf99DWkHVL+uF6Y4gOyqM=;
	b=mnbvfG+t+w28udvB18HNq6eHO88refgCaN2O4YZJmykUurPfCWywVX6ba+hvxqY73MfU
	 2GMDJ5f/WbJUjmt+hfvCqWwLkt558cw672/2b5GeOKGYPLRYqMQjM58rQK+mXuT/bvoQg
	 IOWKtJIyqiKLfT3P4KXZ4881W70AXBVEqeNBe8FFtzb6+JmLgGm8OT6P4NGL1wJEx8gCD
	 /zEIIHXhdkwbkLBBMl7GbU9gGc8cMrYvMW6qIYfQWA8SKjLgRgEUnMG4N7k3WHP3xZmL+
	 V3tg9bXfw7JhcTp/oOxVwgUziX2jMf4WIiMhbeCV2sL29/JWqiV7m6IrPnc9W5YS3DA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D1606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E42D1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso8633b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792684019; cv=none;
        d=google.com; s=arc-20260327;
        b=qGRArxao6ylNnrkSiBbboeerTap/namygO3T7lT2ZWrHDRHZcBFQr7cFM5S+IzUX8M
         2nW6oTV5ikA/AImwH8dUVbCXeAsLwulAteG8UNXM0/RYseHTcYRGH8K30bber6s89Kpt
         Su/yUvhGwJ/F9VX88+kzbN8LF+GtLlVVk2P5WmM1NkhhVm5LSoT7NiPpyio9KD6koPjY
         gfVShW0DbccL0vrLWkrWLa1ZBw+GJOT60p/3Dt81IuxRjOtI5+NM+HVV73aiikDn9Rg6
         tTTd/mbKOJEwX/I9g4MhsOPK0Y2uTXwYLhGtWY5IaPCURH7S3bf15oe6Dbcfu2HEm33+
         owTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K87CCPS1qg3XSuuyQwUVQwMf99DWkHVL+uF6Y4gOyqM=;
        fh=J6u7NKbv6OYCSiqVyy1bYlLyBdb42GmcLXFlnQQ2Gxc=;
        b=LhFsV+pb910yn191/WlnQMyYims2tInErBZ5ct0UMlsmF4Cyw2bAJ2lPh39ajh3utc
         20rnHSpei1d41HxhegX4SZsVsYTHOnfq3n8CNtiRHTJdvKqSY6d6fgfjXtRNZ9FOPvWJ
         GAeO4/jrc+SyPLkdb9mBzgZKUS3PeCP2v0MXTmsgYLvAtODxL6muvZzuE1vYyvQY1wig
         LUALhRS9Vh5RYsnQDWEDpQrLwUeOoW2PLjThfVVut+S2eHUFZO6OqQkO7RbjupKtMnXi
         T0zHQP+JaOXaI13bX8KQImjjcUEuU9Hy/JvQZdhe4WiHNwk6sjxWyMMcl9wyNLzQimry
         J2nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792684019; x=1793288819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K87CCPS1qg3XSuuyQwUVQwMf99DWkHVL+uF6Y4gOyqM=;
        b=TsC7NEufCbv28J8S4G5i+oT1hwSTJtty6U4/45do0DqJovZpBLkWWvwGHpA23hWyjp
         BVHWoOYa3vqQKkpmcwBvjZtrdFEs/G9rrigRuQNPtiNZ24hzHQ3j3t2Xi0Vt8brw8wrl
         fcGX9wT57wm9lbBTyFcb5ZFrzncdN+VhBuGiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684019; x=1793288819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K87CCPS1qg3XSuuyQwUVQwMf99DWkHVL+uF6Y4gOyqM=;
        b=Xdmn/+7jEyv6bI2o6c/ZNHNSA6qKfezvdomNie6RDdZ5PwGOeR3t7Fd/9cykM30Rcc
         9m5UM2fJcF6wwWzwwxBozg8ildPu9OHZZoqLYb+fFRESeUYM7R+CiGLf7yyg1i6v+Nd2
         oVZcoNcNXG1+OpQNXjwJwx2jl1Pj/LUEoYb54RXgOdx+8Yicv2GWl7ZI7VaFRlPsm1yZ
         Ucy6HVKVqbTtoCtezgkb4b4/ow1spQp5IGx5FczKySZsG+EuxBtgcxJ2wz6pD+9E+90a
         LaGsGL1rRyVDzx5CJshIcSi/wX51da7LqK5QcwRqZU10dZizZFEgEkAkN3n/lJHotliX
         RalA==
X-Forwarded-Encrypted: i=1; AKwUvByCk/KWiJj25bUIKKUnqoiIxtCDJPgn6jqaIV5oPYK0VCFi4wibWrYGH0srxDtWqjjmXUGZqNU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSa/bsiGjf0C8Fp+8oTKpyPbPClDLGO8SjPY+LkBT0EDpTAXHB
	1ro2bUjawydgXw4JPLtpBsWssNhwxdDktKyHa4Lboaq7WGLYyQR1yzAhYLy3X+3TnsxqCVaIL89
	0ZF9YyCPI/+F8Ss0irEYly6wCYF2IFoyz2XdQ68ly
X-Gm-Gg: AYBFou2IaC+kroCanUW0mSyptv1ALtuDfks049PK8p6Jb16/Zf1ZuHu6S3ozM2Wa9QB
	vc7OrbgwYAHg5dVyafSzHDPrjJZbp7MwRbx8g/C+8kcmj/NRfEOg2iJo4zuCOnqQAm2OucwRBwr
	2Big01YgKURGmslN5kOF+AIspBfEsJ83FcZHvvma4NoNIJeWqsdDEyf4ItnVB0YP4cTFWVnVXlG
	Ik4oEJBauvJTAVIQRVP8NT0pviKzmvtykjfW/qK5/aEpO06CyritqebFnr2EIpMwuj8/C1jcr2d
	ZVIkbU6c8/Gj75VprVf7XZjwii7Nmk/Fd/bSOY0d2OSU2byG0gsB0AiDSp88ty86CMTFSxiGHxJ
	dX5sh+o0EdV1e2shVMZNAEJZ5oFr5sL/8sdXbc8slTqt/ROQUYAhQ7M63QZRWUw6M7i72pgDXQh
	uIQSUQLUIJfraQOb4=
X-Received: by 2002:a05:6a00:ba02:b0:87c:9094:b72d with SMTP id
 d2e1a72fcca58-8a089c3e63dmr4812509b3a.6.1792684019112; Thu, 22 Oct 2026
 08:46:59 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022144653.60550-1-shawnq1@163.com> <76f5a903-90cc-4eeb-8afc-99b5cd89b75d@lunn.ch>
In-Reply-To: <76f5a903-90cc-4eeb-8afc-99b5cd89b75d@lunn.ch>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 22 Oct 2026 11:46:47 -0400
X-Gm-Features: AclHuK-D0LdlgAYPPPOkW4ENypnkCNUafVGtRqQogBa08w_vna_OR2uqMMb0vO8
Message-ID: <CAM0EoMnP3VkEV6fOAMdZ9ma9egUpV4AFfB+44k4VD7jx2dHPNA@mail.gmail.com>
Subject: Re: [BUG] net/sched: act_csum can checksum beyond a short IPv6
 jumbogram skb
To: Andrew Lunn <andrew@lunn.ch>
Cc: shaos <shawnq1@163.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 11:36=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Thu, Oct 22, 2026 at 02:46:53PM +0000, shaos wrote:
> > Hello,
> >
> > An unprivileged process with namespace-scoped CAP_NET_ADMIN and CAP_NET=
_RAW installs a csum action for UDP-Lite and sends a 300-byte IPv6 frame wi=
th a Jumbo Payload value of 0xffffffca and UDP-Lite coverage longer than th=
e bytes present. The jumbo-length addition wraps the pull-length check, whi=
le the later checksum path still uses the unwrapped length.
>
> Please configure your editor to wrap lines at around 70
> characters. Standard netiquette rules should be used on mailing lists.
>
> Flooding the netdev list with bug reports like this will just result
> in them being directed to /dev/null.
>
> If you want to do something useful, fix the issue. Please do it
> slowly, one bug report at a time, so you can learn how to do it
> correctly without wasting peoples time.
>

And worse:
1) cross-posting to the security mailing list on bugs that require
CAP_NET_ADMIN and CAP_NET_RAW
2) Parroting quiet a few bugs that are already posted on the list and
undergoing revision adding more work to reviewers.

Which LLM do you use? Teach them to read the mailing list before
declaring an issue unknown. Just because it is not already patched in
the kernel does not mean work isn't already underway. If you fix these
issues, post again.

cheers,
jamal

>    Andrew
