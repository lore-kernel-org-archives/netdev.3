Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBF388E4D
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061769; cv=pass; b=XDzxwQTcOCEdjWDeLUH3bNKbt0Zz19V6fyUZJpbh4q2kh6RvM8Te0SnV40dx7Erx0oDzUkCgKX8faFTAptHO2EQ7Q4CGaqWtxdJVZ9tLbDu27/IsH+VX2QCb92EHoqInylKVWMpr+y63deuHE7Vc0/nvizNX+/T/2COhy1+NlnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061769; c=relaxed/simple;
	bh=a6l0vDCMPuYlmH+gGyufXe0r6qqx89ynlyIARXuIMnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH/9Nl60XPNQ4dYqGuZcA6IvNBfCHRMKGiAQE/Ww8KRv2hwWWmpYH+YFu81YbQ9yTjRqq5Wm2GAbeoaeqCRWQiRw29qfX+1Xprm9wh0F8M+IsG+54Y8hzeZ99iwaVp1dUHzHbVU2Tmjhy4Z91ZmmT2CTvF0j3tN0oJdd8KC3JzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6S7LkKe; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6S7LkKe"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25400so1151470b3a.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789061763; cv=none;
        d=google.com; s=arc-20260327;
        b=XyomG2elJLXs6jqBY0gEikI4AZb71kCjCrEHXxSAPRb27ToVfOA4N4H1yD0KfWRIp+
         jkrY3XpMrVUvOlG63q5Lh9A8dTx5ZuaZ83N42mMi8H1fyMQnGRI9fRyigc1aAFGGOj+G
         OV7dow56Nz2MQJkdKU+A4gkCxIgYEzqBmnsYo25JXwHtWtCFGitMZp1jEfIcKXBYE+5Q
         A9AJo+irWvQZgVQ2GX3tCOTTkBQ4pJ4+NKJuBBnR86X+uDfhVWk8h7DhQus7WHdn2bFz
         pDifUuWQ2x7FttSUFRUmjDz2bQa1G0HGGxS6ocj1Ed8DpuUQnauHim05bq2AixJsBfYO
         eGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7yMfDVXlVVMgqeRpRxvNlE/Fp1nnZ+1duLJy7uWmyCk=;
        fh=75wj3ig2jMMC4KL9dBuMSlCmIS9sAWtnpw2cOaqg/uw=;
        b=ngOxabKy9hBVQH57nHiP+odJpFp579xdHgA1/u1gKMtWa4Jceyxk/yKg+5Zazm09r7
         Jrw9EVU5DAV4JCsk0Y7t1+ZxkXJ2ZmwOulLuEObX2D2emDRScHYw64VSBa5PGLx+JFld
         H6YRWu3IBW8RaE7Kq8MiImB31Cy2fqlMFX3TbHcYJylNdtO5a+Xb9hPpgMlF2NInpXDV
         5IrZDfoOJzt9zJvnZiVORcylWNRyLEqxRbmkZssi9Fu8nPHYUjOPz7O8igOThb4LvAY+
         z0za+/oIkwcade5gfSvIbUMTunDA0v+wBUtrbysSiE5N3oFEqpZns5gQ9d4YhLZQLd37
         yo2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789061763; x=1789666563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7yMfDVXlVVMgqeRpRxvNlE/Fp1nnZ+1duLJy7uWmyCk=;
        b=d6S7LkKeE94cga9qFWruufnmPsidcUt0lvvfhM2BJfi/LPTpJ5+pG7HnNm2XEGDKK5
         wXBvthHJ7c9S7KrHn4U+zoUUQvfw8YouvI2dcEPdaGywiE3qZ7hwXvF58h3ZPnJC5sCf
         rwHbaz4bpxJWjUOgjXo7bPTAU5k1lWn6Ok7dwaIHwnIff9GMmVB1whv9UYtjEDjQx329
         ZOqA+Pw1Py1xLvDoMEtNZLHanfqGqj4WZ2Z4+SjY4kuNi1ikIcrGDMAIE58NN/XmSVuB
         Anco3vCrdI97cOpvhhtRuNXXiV11pV+SVcfqB4W8Xr+jbcyHFdu7bMGZlv91i8EO2uhp
         MfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061763; x=1789666563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7yMfDVXlVVMgqeRpRxvNlE/Fp1nnZ+1duLJy7uWmyCk=;
        b=E0/JP9GDSZDeWjmrmoOkXIWvvrSiIAIDuLR5vUXi7HmaL+CjZgU2ruqIuX8GXVyNar
         4oQ97E4LIl72KmbAtGzP6s5k4cba56hWU0ORbWUeWKydo5UT2aZ7jk/A+wxFpLxkORSp
         SKxI1kQ8O3gVnVSqUTdd7axQ6+Y3cPiArpnWF+xTq6LlhqNyVPryY6lvnVtq7srs/7Yd
         ulEIRFiBuAt/WR8kK1DHIs3QdguvlYa4w6SaligVnjuhsHGhCmMwFa8HSPVDyUUq6I7g
         hL5qhgyN+U02QZku58amZg5Bzw4i1kZ7BCJAHrCRr+fsYTkkvaaGdzzxURbi3UzaOgQg
         hHMA==
X-Forwarded-Encrypted: i=1; AKwUvByxujx+Zt87E5z/wQTBM7Z2k8jv2IqH/1VcoSIfZfxbKfpMoNRvLvtIlSZnPSaX1M+H41FnQmM=@vger.kernel.org
X-Gm-Message-State: AFuF++nnNHyqHYf1dGMnyb+SlwK3ofbB0nUcr311iZWkGqj3Zz10i5Y3
	Xm9TxIi/2oIbtmFiFbqwkQWgVMyx+pIACeK5mdaPIPzKZJl/x5ePeinfOLfThDMYW7IFKhOZoaD
	wKyLw7bXcMQ8fo4x71xjdKqsvbE+WtfHEFgKKGCad
X-Gm-Gg: AYBFou1sZEdolEp8CrosZZhc2G/42B99kyfWbkaD6oXby4/OU7gc6RfVXqmbAratVoy
	KxLeU1UAouqfbxwFSQQxU1LcYnC8OFkqmD0ShbmzGHUe2FzdK1A21YCkQb26v0Ore6EPicz9ktf
	5NsDk8jw9ajEewcROF0wm5EUOC80abExCTCOCGyTUi1G5WVHASfa5YgOf1ZZCMCp0YUcgTApmJ0
	sGdcyjsvSVk1Eejugy0V9g+ijIG5hBMjc7k6qIepYi7toRZ/fEZwr+wTCVJwJxwQe0uhMfnalZ8
	S0be84htVovOEAhMvCZ3Vu3lk4gspg1slPpNkZVxXV/3VX/4jLKEWkwbEDQqlrEOB0bVnxUFmgF
	i2CAHDcZ0xHf2GZxHuF4CJTQbJVxCuhGIOnzvQqQUwcW4Hf3KX3ECjvTwzlNl8NcED4yhZ7SkHf
	/dgNM+2C4pji83q+D+56Qdzw==
X-Received: by 2002:a05:6a20:4313:b0:3c4:2b8b:e88f with SMTP id
 adf61e73a8af0-3dacbd27664mr14564033637.5.1789061762965; Thu, 10 Sep 2026
 10:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909234422.2416506-1-kuniyu@google.com> <20260909234422.2416506-8-kuniyu@google.com>
 <20260910171301.GA1902749@shredder>
In-Reply-To: <20260910171301.GA1902749@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 10 Sep 2026 10:35:50 -0700
X-Gm-Features: AcwNN1V9J6YTshc17jbnTB1tqFhPv2eMLJH7ZsFI1lNcn9awKdB9RRv2-EIvf1s
Message-ID: <CAAVpQUD3khFs7rPwRwYLOmda2FLiryYvPOo3H3dWrCoCwiAjKQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 7/7] ip_tunnel: Support per-netns device unregistration.
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 10:13=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Wed, Sep 09, 2026 at 11:43:50PM +0000, Kuniyuki Iwashima wrote:
> > @@ -920,6 +927,11 @@ int ip_tunnel_ctl(struct net_device *dev, struct i=
p_tunnel_parm_kern *p,
> >
> >       mutex_lock(&itn->tunnels_lock);
> >
> > +     if (!itn->fb_tunnel_dev) {
> > +             err =3D -EBUSY;
> > +             goto done;
> > +     }
>
> This is a problem in network namespaces where fallback tunnels are not
> created and the pointer is set to NULL.

Ah, I should have used check_net().
Will fix it in v3.

Thanks !

---
pw-bot: cr

>
> Before:
>
> # sysctl -wq net.core.fb_tunnels_only_for_init_net=3D1
> # ip netns add bla
> # ip -n bla link add name gre1 up type gre local 192.0.2.1 remote 198.51.=
100.1
> # ip -n bla tunnel show gre1
> gre1: gre/ip remote 198.51.100.1 local 192.0.2.1 ttl inherit
>
> After:
>
> # sysctl -wq net.core.fb_tunnels_only_for_init_net=3D1
> # ip netns add bla
> # ip -n bla link add name gre1 up type gre local 192.0.2.1 remote 198.51.=
100.1
> # ip -n bla tunnel show gre1
> get tunnel "gre1" failed: Device or resource busy
