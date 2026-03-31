Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D36423A91
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993904; cv=pass; b=m//pO9MASfensveZMdNEFNxAy7dWQ5Pw0GkzF3GR4cshy6uVZG7eONvqRy4MEedvjOdq0l82hmpE5udkjPG6wqXEehfab/j7wdzxXpRKrnsc7qk1pFUQuehczQBH8b1TXpcY3dblOSjV6Q5RFNFtNnJlfZBxKvuEN0UKPCP3bIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993904; c=relaxed/simple;
	bh=hrr43T3wZeGdnNlSSpEzZn6Mf3GJNQiRlS2puTZRyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvXbo91ZLJpQ+uizTLE1Dy4XhtN55tmQTTlwnwvo2fM+NH1YO7TJwECepcfYXy83yvHlt6CmpK2icoEtmYbf5T9ZHXqgE3sBQfZ8ISUYmY1latdg1DqjiqqU8YMWBceuSklv0Fa0RZLfq22SW/bSkY68vX7VE8VFyuqq8pvqqKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y76bC9xp; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y76bC9xp"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67e0cc7e216so752036eaf.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774993902; cv=none;
        d=google.com; s=arc-20240605;
        b=M3hSkPLzStXk9X2/zPizXZfNt/wW/Up1FcjZTVyUWldBpXvIzr12Efc8qZDPfxR9oD
         MDtw7IM3UjTNsYWO3YF5Vb9YWU4cLWB/BuOIdIvo2G9iTsw5d0MH11YGMVlSSS73M9HB
         tDBdKv7CG6zwc6j7tlQnealVNLlfIJ0DTl9qnDbWp5HpzMobiUpLWaaFf86j3cEfaInt
         RJWKjY7n/PG0pnx62QSMJGITeibd1qZ7iAo3E2MZyNeGltwSAMlv5vty3+CWSuVNQC1I
         NEAcEAmj8YAGeXHQ4fCRzSaiUyglM0oVz4tgjcinw7wBXHCrgp/8U8VZY/nanP+IXrgW
         Lxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nEZ6tlNn7ZzQooVuloz9P0Fl56ZmvUYeYhj/r23T1Hs=;
        fh=H8c9WxbJiTCOeqRsgzc/2tlfc6S4phJdV26sywHRpr8=;
        b=HFBoKK3uq7PLBuQX+lB5k6AjZn/Bm4bZqXSNqTBVUhGGwAS4umtWIjQEXAGNHPpW0V
         tWX35oh1AEvmhMHLsh0OTTB++hmsY0v3makXOi7m4Qa0YA19VDiSl3hrMAlf91ukRURO
         SzJCM8IJTsXnBdRXhfqq7ywAyuRnfuz83w/t+ngqb5fp0H5IimPOyzMBhofLeiHTFwRb
         GbS6CPPQT5xKqHGJWfrOeuNzQvyNTvJG+Ew/FHg/SeZCL5b1PxC8ASR04TaSWg6OVmx5
         9IxVNtVQS3vAZcQncSZ368OW2eW3fm+xsxx6XRIYCZHhp8rJRKDIuMp3XMh3tErMcHlz
         6kfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774993902; x=1775598702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEZ6tlNn7ZzQooVuloz9P0Fl56ZmvUYeYhj/r23T1Hs=;
        b=Y76bC9xp+4SGy+2UWPYmpTDl7UXR/i5528u14SlI9OlzTSj8v0yWkNZi0T5Qb0LQEz
         SqAAu6p0iqp0FMD4RTKjQWUKptXU/OUmCGk9Tkp9uZ+XDl366ZOcGJtt+e8lcdd1F+dd
         GTsENXF0/ErkesCi7b8jEHT0DtyFAAW37EGKscza/rFcpDqt6hJALPNbTX7+u2EHWBiB
         /YqLW85TkPOjNP2fbdz5dFjMiORvC4tiRIexWWSVwZQKhwZ0A49l42u6VR6zCtqrV0pc
         kRWNZnA5G+PxrRmeKe+woQEpFwc3EBV6XUqOTXZLOhkJwJgvC0h+ogVB0K3B/+ymMaXT
         GIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774993902; x=1775598702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nEZ6tlNn7ZzQooVuloz9P0Fl56ZmvUYeYhj/r23T1Hs=;
        b=fo8SjEQtV2ALv5pYsY3IbAVF2mpdaYZjr/LC/GB4F8BPcqMHNcUb/9kV8gNH6YVUUj
         QyV7AGKEQzOZTDk63AfqEV4lipfS+cpkyvMFGWW3mksAGgwQWFVgMHi/dfDjGpaPGNxY
         kEH1/cNdK4bDOaivjmMjuLSgTiDITiOwlARFOog5o5p/LHRQi+T9l9eJyzpn+eVSjtS1
         QBzt2Wu8+ylbSw7YQqQT7d9TA+EzckmMB/12p3mCrrmLZSM7LnIHyenvsF2EOcHVJ8cn
         Ko4t5Q4KAJFqeyA7lBLVySMhE9YEoNLwNzgVXiB7zYPJCTvjAmROWQcPoJP2c9GPCs2Q
         24Ng==
X-Gm-Message-State: AOJu0YymGY10a72aZzV2LjEZ/jW6sgjRGic1gGkRuZWwbmpCAlZ61+FC
	5ZGTPubZnJ5CW9oJGJIQ4Tr7J7YMWWiBNfsFDnTcslgeiOicLYAWjqi+EGd8VfdWBrqnBWpmKhw
	rRZQmYc4qiK2auaVK4sIl/IG/Tym0dNo=
X-Gm-Gg: ATEYQzzPox6KhFplwnhmriG1YhYMqCd2lkTDmPNTWrwn8qgBcUL8GquN8nBOqGBzGEX
	3HmIurGbRQQm6jV56EXQniF0RG+2qy8QZ4mfz4mnhgeiqUCsyz5E73SSqrXgnAhwlzIcfeFpCQ+
	KQ0jKW3h5M9pLayZTGrpuIWunNZ/zhTm1WkN8qbyZitkipiIkNPxeolC/aUtwAaPdIQ4C2ckEvQ
	w+r+5ktGpcBvEvh8/f6wLBJx5cT1YsHe8vROGvpBD+e0kIh1S1mvypUEM2D3qXs7ChUgcB63AbZ
	EQb+sw==
X-Received: by 2002:a05:6808:bc7:b0:467:1bcf:ab6e with SMTP id
 5614622812f47-46adff7f2c4mr458557b6e.2.1774993902042; Tue, 31 Mar 2026
 14:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
 <20260330223143.2394706-4-weibunny.kernel@gmail.com> <1d013236-e945-46fc-8acb-c7ab9ac32a1f@gmail.com>
In-Reply-To: <1d013236-e945-46fc-8acb-c7ab9ac32a1f@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 31 Mar 2026 14:51:31 -0700
X-Gm-Features: AQROBzA-qdAlwunMMcGaUtEq9SmOeiEX8MRn9iZ8xO_o4vWZuNsDd9Pp88bGi0w
Message-ID: <CAGqc4nX096xJKyxdXrpXkHert6uCqHLKo3Z2idw4UXSdKw0O0g@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 3/5] psp: add a new netdev event for dev unregister
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 6:30=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
>
> On 3/30/26 6:31 PM, Wei Wang wrote:
> > +static bool psp_notifier_registered;
> > +
> > +/**
> > + * psp_attach_netdev_notifier() - register netdev notifier on first us=
e
> > + *
> > + * Register the netdevice notifier when the first device association
> > + * is created. In many installations no associations will be created a=
nd
> > + * the notifier won't be needed.
> > + *
> > + * Must be called without psd->lock held, due to lock ordering:
> > + * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_lock
> > + * and takes psd->lock).
> > + */
> > +void psp_attach_netdev_notifier(void)
> > +{
> > +     if (READ_ONCE(psp_notifier_registered))
> > +             return;
> > +
> > +     mutex_lock(&psp_devs_lock);
> > +     if (!psp_notifier_registered) {
> > +             if (!register_netdevice_notifier(&psp_netdev_notifier))
> > +                     WRITE_ONCE(psp_notifier_registered, true);
> > +     }
> > +     mutex_unlock(&psp_devs_lock);
> > +}
> ...
> >
> > +int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops,
> > +                                 struct sk_buff *skb, struct genl_info=
 *info)
> > +{
> > +     psp_attach_netdev_notifier();
> > +
> > +     return __psp_device_get_locked(ops, skb, info, false);
> > +}
>
>
>  From an AI review, but seems plausible to me:
>
> psp_device_get_locked_dev_assoc() will proceed even in the path where
> register_netdevice_notifier() and psp_notifier_registered stays false.
>

This behavior is intended. In case register_netdevice_notifier() fails
for some reason, this current dev_assoc will proceed but the next
dev_assoc operation will try to register_netdevice_notifier() again.

>
