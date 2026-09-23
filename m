Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B02D47DD5C
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157405; cv=pass; b=KIOKxrlFtvobWDUXch7YijKZsJXJXJiy8wupxL6Cv9L9J0T0QmxEtGaPENYAjW2Ra15JGrfOuRiuvHfDUiWncYFr9TmNOElLB1sTKfLy6rj+sMdS6UuXa06Pcg/FakAIfhxNIeZAtnJF73aysXAOuMzRzxnp4vMdl1DhzCNALNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157405; c=relaxed/simple;
	bh=gepP1A9ysh0N6NHB47FJTCQrzM4iGML9jXyRBN95fA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdIcADg/jOIoa/27+Mr6X9DqiHQAUhl4QjtvTTvmQMe6dDNSjHSA+Ay4wnVCcwGip8htNrJd+d/BfP8SB39cx8hDvQ5x2TTdcy7hDsoTEf02MvFi8S3Pt6gCxxXDWD92hssUpwQjCUI7aycOnCzOnmdD/vCjU9OpAqMzpgQCqaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alkira.net; spf=pass smtp.mailfrom=alkira.net; dkim=pass (2048-bit key) header.d=alkira.net header.i=@alkira.net header.b=NPk+ydVG; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alkira.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alkira.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alkira.net header.i=@alkira.net header.b="NPk+ydVG"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8674704dab1so733484b3a.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790157402; cv=none;
        d=google.com; s=arc-20260327;
        b=JASnCiUX64950GBcrKb8+sgjIYFzrW2/N4FheCfAyMA/tqws4lmYxHkgoYuC3qYp6I
         WTmUH5f4SUEXLyz4v3Ev9udUpKAZW6Z/BFSqd5zoxmETXUIv5TohYjJL8XIQL5ibexMP
         pyTc4DrrFDJy3xZ+zTTYfOKVuc2BvYgjlPs+Iq/4tU3NcIl4Nz5nshXHCNexC7T6L52g
         1YX1VVKew8UZXaYWI32kuhwGEJ62fGY2RxqVC1I5MBNqT8W3iP7IFEu04dC99K+ulNIq
         SSxKeVjcrGWBxShbtvCoLJdORgrt+JsDb1dh5maeytTKt/+zv8Umugh548RynxE7FdZ2
         mBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cpgKIz/nl9xM6UgCUL7AH6mkw+l4ifqbDGv3fT/fFSE=;
        fh=7MOJDvNNoshr7w5yRSZKGyxd0WW+XTRPcCgXOmC4y34=;
        b=rc9QcmUTZc/k299uuCcVOVEiSb4oQuJX8oh0XiDi+rO8ngFXr4EyIAteklwqAEDa78
         3UnMkPuchbwGtbsw30R8kmisdSrpoh5HqiSD+/4DqW5EsRf6CSjyULmVsTXRgpfSH+XC
         2Kxepdra6tAnWIUxKVBAfm8NC/n9wsAW3kOByeDyrpFU2ECcruZ9KUPWZbPM8rPVNQhO
         T1lc9qN9LsPd3vikC4nK/dedGrl/CmOB5ZOWOFLi3zespoze1ew0dW6DOFXxFJ0fMirQ
         4FdeiAsUOgTVjLt9Egeb0Ubk4YWfT1i5yCRio6sV4f94del0VnXLrqBeJEFsHo0N+rK+
         6BPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alkira.net; s=alkiranet; t=1790157402; x=1790762202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cpgKIz/nl9xM6UgCUL7AH6mkw+l4ifqbDGv3fT/fFSE=;
        b=NPk+ydVGBcqG37jr3+4H/Wbr5Ko3cBO6T6DsA7KQdjHHvJ57IYYwYY7g4FluV0I4LA
         lKJxUqUtOqakKD9KjFMSPrZ7ZI6OFLYqqUUKxOtxsppeOxKsT3BB9OyaCSV/erfYlsPm
         YSYBl+GnPdBmfRrbe8srYyhakmmKtha7IC6yoIT2WQMX9lE5K2WhPH5u1XvkdYASs0aT
         /OI0jrZUEdyMTRqkUhgZsF6/I4SiJVA8FRKarCJ2TE2oM3PWS+R4NiyPmP30AT9s3eY9
         qWeSnmvRz2pfQwAkzMFizI/bw9f2KizImUWuYXO7s+G/+jdwFkZdfmdJn2/Dhoa150Gj
         l5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790157402; x=1790762202;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpgKIz/nl9xM6UgCUL7AH6mkw+l4ifqbDGv3fT/fFSE=;
        b=O4NLNQYVI7haV/ppR9sz6atywhrNnyKegqQXRGYl5pjaQAsPo/ePgFAzC073ce5xwx
         sy6QnkGkO16F3Hln7lN9po/eSGE03t244BRiosZNqz+u6GYjZP0fwgPtkV58ukh1JcxO
         lviuDAZNI5nt/Cfj32xRzbpAc5bIsvC+f6KHp2JAcrm0CrSbEtXRgKTHZg24bLaw9W5h
         40i7aHutii4BC8q+KqmnYKypPE3SCK5q1z0DSHn2q0Uh9XubZJcpjWE8/y8WTOw9d5Aj
         fSlTfTvfWoSE1LSuc6ErVyPPQpOM4uSmw0wWJ5aezPLdaLXTZWBSscb6D9+GQqM6t3MY
         pszQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHQYMGHvaqDM+d9p3WdkG14QQYE7F0RcOoo+BFaBo6AM/6QS2fQMIiXf4veiXTJpZkTkiwIUI=@vger.kernel.org
X-Gm-Message-State: AFuF++k/dugPY/5Y4bm3h5Rhsiq+JJrjcgnvvS5LgLH+/MNdADHAIg80
	pjj19P6Hi5bt3lnL8Sp6dLpLOwxmt28oTcd9PIfdiEC1KSKwy64vEgUrSx4ZNXOx8xdKjGKcj9X
	RGqVldQxU0Qi8qFwGXoS3x6n5fLx8IWi31MNTbuClEg==
X-Gm-Gg: AYBFou0F9gUtxHK21KKtP1nVzlhzCZUWAEI05uy8+YfmBWASmz6EUm8O3gpZqGucxfE
	9pEXTcr73Ua2fAIfHm++SKRMUSJjv90yXVKq/Dz+90zaqiTyb109XMJudiWWNXchveq1o5Vh9NH
	5TVnXBffaIwe2Db98Zx7zYqkbBUJ8P99JDMA8/5eV1dKieJAi6fh3JmOVLr/9I7OXkaLq9t5RY+
	KcCbk2pYHeEMjvNRpKkZiE3ZoEaLuGDITKUtJi5OxW5ajBjKF2MGZIQhbzrMO22bZInC9JaSP00
	DX1eqdPH4dL4za6nOYGyiePQ/9/fl+2ga9o4j0KAYaw9BUw8TEbmGl+t6S+QvEVfjg==
X-Received: by 2002:a05:6a00:8005:b0:87c:d962:72cb with SMTP id
 d2e1a72fcca58-87d1d4b9b3fmr1845440b3a.40.1790157402155; Wed, 23 Sep 2026
 02:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMcJb7NLooAw=6Vyzbq-7JnE9L=gfTbLL0Y=L1pTFMTg3Vf76A@mail.gmail.com>
 <2026092316-mouse-scallion-6eb2@gregkh>
In-Reply-To: <2026092316-mouse-scallion-6eb2@gregkh>
From: Kusuma DS <kusuma.ds@alkira.net>
Date: Wed, 23 Sep 2026 15:26:31 +0530
X-Gm-Features: AclHuK8wU4Sksj2iVp3kwEncGRLBwmdao0VGz_A6m0crpM3c4XTeRAUiXv8rTnA
Message-ID: <CAMcJb7OPfN3jSmaqW14CqBESDv=m7Lc+CQ9hms6kVKMWoeHfCw@mail.gmail.com>
Subject: Re: [6.12.y] Please backport 8045c0df98d4 ("xfrm: Fix dev
 use-after-free in xfrm async resumption")
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, 
	Chakradhar Kar <chakradhar.kar@alkira.net>, Ramakanth Gunuganti <ramakanth@alkira.net>, 
	Sripathy Ramaswamy <sripathy@alkira.net>, steffen.klassert@secunet.com, sashal@kernel.org, 
	dongchenchen2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for replying.

You're right - I had not checked whether it applies cleanly, I only saw the
change was small. My mistake.

Is anything planned for bringing this into 6.12.y, or does it need a tested
backport first?

Thanks,
Kusuma D S
Alkira Networks



On Wed, Sep 23, 2026 at 3:02=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Sep 23, 2026 at 01:23:01PM +0530, Kusuma DS wrote:
> > Hi,
> >
> > 6.12.y picked up a bug without its fix. Details below; the request is t=
o queue
> > 8045c0df98d4 for linux-6.12.y.
> >
> > The issue: on every packet whose ESP decrypt goes async, dev_hold() is =
taken on
> > the ingress device but dev_put() lands on the VTI, because vti_rcv_cb r=
eassigns
> > skb->dev without taking a reference. The VTI refcount is driven negativ=
e during
> > normal traffic, and a later `ip tunnel del` then hangs forever in
> > netdev_wait_allrefs_any(). The process is stuck in D state, unkillable,=
 and the
> > netdev is pinned for the rest of the boot.
> >
> > Introduced in 6.12.y by:
> >
> >     4236c30b437b ("xfrm: hold dev ref until after transport_finish NF_H=
OOK")
> >     =3D mainline 1c428b038400, backported 2026-06-19, first in v6.12.94=
,
> >     together with its dependency af4b8c5e9d6d
> >
> > Fixed upstream by:
> >
> >     8045c0df98d4 ("xfrm: Fix dev use-after-free in xfrm async resumptio=
n")
> >     Fixes: 1c428b038400
> >     mainline v7.2-rc1; in 7.1.y as 63a300151999
> >
> > The fix was not queued alongside the commit it fixes, and is still abse=
nt from
> > 6.12.y as of v6.12.111. So every 6.12.94+ kernel carries the bug.
> >
> > Confirmed on 6.12.96+deb13-cloud-amd64 with a strongSwan tunnel-mode IP=
sec VTI
> > under inbound load; kernels up to 6.12.93 do not contain the code and a=
re
> > unaffected.
> >
> > The fix touches only net/xfrm/xfrm_input.c, net/ipv4/xfrm4_input.c and
> > net/ipv6/xfrm6_input.c, against code 6.12.y already has, so it should a=
pply
> > cleanly. I can test a 6.12.y-rc against the reproducer if useful.
>
> It does not apply cleanly.  Please send a working and tested version if
> you wish to have this applied.
>
> thanks,
>
> greg k-h
