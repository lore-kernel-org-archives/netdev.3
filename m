Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894A28505E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916551; cv=pass; b=Cy//Sf4yGOV1crLecVY9DBT5wyEsD3frCEVDHqmjOidDSn7X4QTIoBs/1fOs5cAl/HxziK1oawjf9HN6yB9URWXTb6T9NCRpg5a3c+PmfuUxc4d0YmZ/xTF6w2F0O6ugi1qXPiGzYIXS8LZWyO5eT4CrOABoi2rR1pybuOPsNF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916551; c=relaxed/simple;
	bh=MQSwhbdiJCeNBOXOMm+u2E1bHED2yNrmentBhrbYLAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzAw1Vb3XfuJDLqK9OY7lmnJdWaTchJNxcbYXwvZJ5TR7IRjI9DKAvt984TbnDm1zOHXnt1LSatzwbClZIp2cIcOhMSUd88CJ32TkKn6YSvLo3r9c3LO9kvVWcXLX79KpmNbQSElmZAnzjv2Pei8e1CAUtmVo2DvF7pIBPw/CTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgRfgUkj; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgRfgUkj"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a49dbfaf25so433301fa.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 18:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788916547; cv=none;
        d=google.com; s=arc-20260327;
        b=rNGCv3nco40PLXPW1NC+0JdhqKg8Ft4yxTfFz/BgRi4u3tLufhJhwVkKq23YHyqKRu
         mjebKIR++mKBO1Qh4ZsZTBfy8eZfQukcHobTyrmEz9zA9/38MKh52nF/0W8y4CNX0HX6
         cvwUE8F3//7x7O9tcTEfx/1rtWHUCotNcV7ULxP/yrgqm1JKUQ1TgcrWDzYCPdjVrgwu
         SUooWHdceLaxDRc+lHSs2zZVD6I7M5F34+BuFItTSXmf8S3I0ZbrU6A8QkZZqATB3Rp6
         xIOljvoUK9k4OL4YbbON+1E7twtzFsTPNUV/juVNTncAtfOYQ7pmco+yRYp85nQv2Wiy
         9svA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0TTx+LiFvOB0q6Xwa3UfI6WzvnZa/o+6Kwi8basQ/fc=;
        fh=bpUJ+/N8iRPKNLDVp7fTGjjYRkMQO1l9CZpkclsuYNQ=;
        b=IAeQBiXKP6SlubAk/czdHcMjlYqnBkmtuDayh0w1nrMHik5ENAe2D/d4hj+u24n/WY
         Zhok3WMTw6EjK9PXfStK5p6hM6VwWu0OrMFu1av4alslGAHq1/ggeIS/yfQQx2FLstwc
         p0AFrHoQnK5s/+jUrzVjevtmvbU0WO9hWONxZFaQl5ZYX1CMCXQOjI/upbOojPUZNvVG
         /FvQKRdv7T5dhyu46MmtaD4y92IZRwLBdWrLWf1r6ufyixqy8damUyx/157HPmFVPm7T
         CDZPij+qaaA6PowOrqlKzg/k9E1S9q1FfSlP9J2/aqy+QUFoa7zBgqhVW6pZA9rP2akz
         2wSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788916547; x=1789521347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0TTx+LiFvOB0q6Xwa3UfI6WzvnZa/o+6Kwi8basQ/fc=;
        b=XgRfgUkjK6mNHRl7hxl+8eb8pymDKZQJ9YyHy+h/PGbdlwy0AuD5A0cXWgrHr5/ukK
         oOppDsIAZziIHEnfOpLUdDKA2iObLQuBaiCXvoXZz2Py+C004F3O+MECyqYYkbW5lE6z
         NQIvpbeTRn/ZySrrDtqP2LPCnqXOfUKfn4KmsS8GM/JDzMjo+9FtbngC8kCf3robtOLf
         PR5g6WghGCLtW7T3RdHc/aoggsu2UpXXhKrv98Y2b28UujQYwId7MkzpFZb71BnjXsfV
         wKgbuEO0KXkZLaIsBn1uEz5FdxFOjlliHSZnMvsZmkEdp8aQI6n4DzjNIcKlDQxYB0/B
         7KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788916547; x=1789521347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0TTx+LiFvOB0q6Xwa3UfI6WzvnZa/o+6Kwi8basQ/fc=;
        b=lmns5jypXYSZpJOU270ldwKB+iY+oPIH9Co2MbUSaMi67RVcoGLIz1C8cE6B+kdeXi
         dI5CkXbcekf2CzIR2DTzRdokdp2Huei3y3PQ8vueLIVJBtmJLtrkr2KgQs5WvSYOs1Nf
         I25fczLBMOkhcM6qFf/YYsgrD6g2yoeLUNygUaDSfUBSrZ2WEGf9ThqhbIndpVS1jwdA
         7vJS7aYcWOF8huNBfHMee1PFgEZTuVvemer7mCIkYU4Y0P76wUgEmAFoQjrO+J2rmUlr
         xWcK1uXkTHQR50xcsmVngdOyDu3/hd1E9mROMKNSW2e4wuvBi04BWi/pYrYiTWRS/OJ3
         Kt0g==
X-Forwarded-Encrypted: i=1; AKwUvBwWuE5uqKGplOeo0oVOIFk/Cq7YTHHdoZsuFu2tslnFp+gcBBqtDLxxGDrHNMAf96SDH+DKPRU=@vger.kernel.org
X-Gm-Message-State: AFuF++kDktpY1JLEPVleYszn4EhkbNWrVF8Dm2N2K48WUnkW6ose0oUC
	6qKtPx5WWKQOshoPovwxklF8EAK8xAyuB7ok3q0SLqJMWCL3kvCq4LL1/bAOqDwfMsdC2QaEiJt
	fFo1wFe3OhSjkzUBXGH8eZxk9IjqtqPY=
X-Gm-Gg: AYBFou2fLzDXXpVanr8FD25VTjalOahmHDhDQuh0/ezMfU50eGHrlpAzQWlLTfa4w9u
	z2/99zKEQCvkbl6gSGfme35ERGmms9IiAAh+GFigDB/w9MdlJiichxzgRALQBPILS5RkSJP/AFY
	ZmMWdqtpd4mwA+gG4ITTvt2+Uqn2dJiwVw8IDjBkdrzVBWnrZOhPck+cIalRO1DnMOI3JRqsF/7
	+jeB8wF5iAcARTjapU7FKU4yYGYFz1BWV6+Km4EL/YgnHXJJzu0qfF6xexROEarrbCs6qRuTft2
	VMIyYksinDl6jPNC6zLyULoR1+k5bZSVaxq1ujE38Y86LFI5Bd23KiyQfu9WTfzJ8A2Ra7g03EO
	6LQURvdNIMTc=
X-Received: by 2002:a2e:a98c:0:b0:3a1:eb3d:d30 with SMTP id
 38308e7fff4ca-3a371ba9be1mr37005571fa.10.1788916547185; Tue, 08 Sep 2026
 18:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905093932.43726-1-sigefriedhyy@gmail.com>
 <20260905093932.43726-2-sigefriedhyy@gmail.com> <1673485d-5529-415b-b1b6-60e27291e3bf@kernel.org>
In-Reply-To: <1673485d-5529-415b-b1b6-60e27291e3bf@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 9 Sep 2026 10:15:35 +0900
X-Gm-Features: AcwNN1VKTW3usIKu3ouYSVflf7oviyQs0HuBjHgGBr26olQ879IgU8NHIR61XhA
Message-ID: <CA+7S2v+vdR-=XJYNrmY5djFPW+4uLtHJYaV3iDsmuCEQcB9FMQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] rtnetlink: add AF_PACKET multicast dumps
To: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:56=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 9/5/26 4:39 AM, Yuyang Huang wrote:
> > +static int rtnl_dump_mcaddr(struct sk_buff *skb, struct netlink_callba=
ck *cb)
> > +{
> > +     struct net *net =3D sock_net(skb->sk);
> > +     unsigned int flags =3D NLM_F_MULTI;
> > +     struct {
> > +             unsigned long ifindex;
> > +             int addr_idx;
> > +     } *ctx =3D (void *)cb->ctx;
> > +     struct net_device *dev;
> > +     int ifindex =3D 0;
> > +     int err =3D 0;
> > +
> > +     if (cb->strict_check) {
>
> this is new code. It should only work with strict checking.

Thanks for the advice, I will fix it in patchset v2.

Thanks,

Yuyang
