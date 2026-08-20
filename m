Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8132E0B5C
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212711; cv=pass; b=nxUg7lJFNX0fAKFb3geaMnofWNj7ErtB8sfzw+CuCV21oLPAPIX4sKq3X4+A3dXyhw6FZdKuou44xNj9AIBFVTPPeYSBSmkUXdzVyyW8YxoqDyyWha+ek7Dx376YmRYuh4XkFPOtakIfYaOewA4Kktg6FejlywRmbfoNoJJgudY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212711; c=relaxed/simple;
	bh=ld9tX3tNqRAYZkztoXc81bDrAANuLRFFkOUuCv57/8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ompnGbtr/PBa6O7bEyaFrKS63VNOyBZLDCNPoci87Fe9kYHwCgE7aQMOdxWVtnEZAglQju91lvCODNLawh22oKRoFTp4TSS99SUWRcLDgOwlQRkjbW6i3usV0iS0ai6rqrLy8Vi/N8kotBQiE/Jd+2wH651dMXW0sUu/K2fI5E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=cl2dz5uq; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="cl2dz5uq"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15d47266baso204538066b.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 00:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787212707; cv=none;
        d=google.com; s=arc-20260327;
        b=W0GxKXOXT1qEvdbHCrmlKgwGRebrzZcH3BaEShaMKaiJ9PdLFjtG3BA+pCiuaio21F
         2K9KwcNL/S0Sr5sGJuzZdnAM3MNOKEn0x98jSSdNQaN9H0Pzj2xOHsWtA/9jd7KrGsyD
         k2q1DV3XSni0CarLKbpzhpQxPROHOTCKkC25fGIbkFuQZIXz8QrsPq+ylP8HjtCCK/gL
         AvnQiW4vjXban63tu1P3AISGVInXyPOlmO9NT9JPTwiSfJNKb/XZDTQF9P8AOX8IxXUz
         Bt4HxWeYHCZrKXtQlO68V+7O1hIYAKSOD+Ip0oBm073ULd6CoA0/aayShsakctnTTp5O
         izrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ld9tX3tNqRAYZkztoXc81bDrAANuLRFFkOUuCv57/8Y=;
        fh=pK6sp88Bpa+RD/7aylOxxAl/xIAnFih5RsUyal9/Ks8=;
        b=eYSuwWprm7Ii/W/jnIw6N1KHSNgva7ivAilZvWgy22hv0w0MyvjZKluZF53eU8bJ5I
         BdPQ3eJA0mZX+UeXARdJ+Mt0p8LMpUNGA77zBMMrJTpnWxcoss+UOe8fIN5CzUCbZ/QZ
         HarX0nkeYrAnmKAEV9X3CiLcp6Un6ZTEyFIGrH8LHLpYX00Ili94gZroYFNFyM31kAJm
         apOhYClROIPpNkz1R3oMPslo1EMXnpIGYV01nCBIQmQIX4YiwjXmJH8136mdV+Aa/8Mp
         Rql6DlIoQ4rzSmR/7ij22gNZPZSl1IIBNqYZpX1m35hr8awjDVWy/q+YZlq7xOmtny+I
         sdog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1787212707; x=1787817507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ld9tX3tNqRAYZkztoXc81bDrAANuLRFFkOUuCv57/8Y=;
        b=cl2dz5uqdczMIf1RYj02u9eZhpUWvHot+RwvYiprJYj2Ow9n/mOW9DnAl4Xl2QObZw
         HjumdrYnmSn7dkvJDbUmHhBdjBG303xALjDDM+zypqxh+fDcyV2HIfiD4JEs0s0zRCp+
         UrVEaGptaxx1yI0FG9fFMDo4MzenNax3+sxR2sZRezNl4s0kj46qBzI0EsR8bGjPqx4p
         NN28O2vsGP1yRgp1i8WH0h2ZD1QbX5ndNErcV3AOJIGrhB4FqYVFjW5Tq9WcLLcx6Gg8
         DZ+6SjFsxImq6aPV/m0eZnwRjMElqw7ETw43HQ1d4lSy8GNvA8A5XktM6rGj7jS3oF1Q
         NDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787212707; x=1787817507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ld9tX3tNqRAYZkztoXc81bDrAANuLRFFkOUuCv57/8Y=;
        b=lUib63+ar1yhFVQPIvsYvocggb52Q9xeRO9Nsb2/EO2abSJ7VKoJBmGgf9YYc0m+Hu
         ulUMYotUWBhLYXSKoW2sgcz4O0gHw5nKBZGoE5zbVYqUTD8fMfsudXuUh/qZm9vkXJxC
         AZdsDUdeyxwokqXhXo9YOoPZeEe1aNPkPHffuaCHVecd0Cd9iNHZ4fTc8pyRS+sn+EdM
         OuQOXAigWmYO83P2DAaANv8A5dzrb1dD4J6yusdEdJsKPsV4eo0R9rZC9rJA3qs2Dcoj
         454DHSe/OOM7l6W6+iRjYz390zPrZRDhMjs7r7EU7RU3I1864GxIFwzNVO/6JFtpg/bY
         tTtA==
X-Forwarded-Encrypted: i=1; AHgh+RrjDkVwNCbjOeKxLUic32ZGhX5BBPYDf/XCpSlgXqrwBwMulVVWrxLCPKTo1LpaKcK8YxA05UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CEEhJWWMd7aAWRNLPpGM9STSxnFiHkDXe5Gy0kTYvtpf1r7i
	F2N7oGoOOhG2JivFZwgikP87CFgmmTVBDw6+gQs7sSLJsXYLAQtm2zftnhw2rvjYeWs38YY4yT/
	AeUzSySqqQHWQIIQ4/KxJWjbevx+cnk0zNb7hYWcLxQ==
X-Gm-Gg: AR+sD13t1lJNH8/U6TlbrMDNmH0g2kZC0vWynx3k8TiTV6WE/tr1GnB4Mx+4VIGvbfh
	Wl2w9w/6a1YHPZKzadbzAWiD5mfEcwIp2vo9rDfuYwLT+1y+LCFSoho2JD1SdaGqTt2uBTYNOh4
	qA06d+n4UBd+ATRrF4+NLoXDf6Ex7JTvMv/NVj6ycZWVGYiNJDsN2gt5i4wk2M4zER06W15HTVX
	Zg3T8AoCqOJypEHSTRZ2D+hIem5I3ZdLqbvtvduIUPTVaxODGCr3UuABA6ntPuukXWq7JcD54lu
	vyfXbZ/gTS5039LAHJ8F4dNOG6fs+aLLeq5tNjVsHZWKQBZP1JavsPpP8V4dHeYyPGRvklpetfQ
	=
X-Received: by 2002:a17:907:1ca7:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c242a6a48fdmr650154166b.9.1787212707445; Thu, 20 Aug 2026
 00:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625114216.2507435-1-louis.scalbert@6wind.com> <fc98de42-02cb-4de9-8986-b77414793df5@kernel.org>
In-Reply-To: <fc98de42-02cb-4de9-8986-b77414793df5@kernel.org>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Thu, 20 Aug 2026 09:58:16 +0200
X-Gm-Features: AcwNN1UKxrXTkwbNlKylbgQIYr5s0mfcS9Y7aWl5a9E0h2lGjgRRNbxcs4-1fwQ
Message-ID: <CAJ5u_Od76V6cxcEUT4h4EQQ4opJk9tLYHYWum7tWp0t1CWjGZw@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v5] ip/bond: add lacp_strict support
To: Matthieu Baerts <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	andrew+netdev@lunn.ch, jv@jvosburgh.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net, shemminger@vyatta.com, 
	maheshb@google.com, jonas.gorski@gmail.com, horms@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Matthieu,

thank you for pinging.

There is no version 6, and there are no comments regarding version 5.

best regards



Le mer. 19 ao=C3=BBt 2026 =C3=A0 18:46, Matthieu Baerts <matttbe@kernel.org=
> a =C3=A9crit :
>
> Hi David, Stephen,
>
> On 25/06/2026 13:42, Louis Scalbert wrote:
> > lacp_strict defines the behavior of a LACP bonding interface
> > when no slaves are in Collecting_Distributing state while at least
> > 'min_links' slaves have carrier.
> >
> > In the default (off) mode, the bonding master remains up and a
> > single slave is selected for TX/RX, while traffic received on other
> > slaves is dropped. This preserves the existing behavior.
> >
> > In lacp_strict mode, the bonding master reports carrier down in this
> > situation.
>
> I'm sorry to ping you about this, but I'm wondering if this patch has
> not been archived on Patchwork by mistake:
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20260625114216.25074=
35-1-louis.scalbert@6wind.com/
>
> I didn't see any reviews on this v5, and there is no v6: is there
> something to fix?
>
> > Link: https://lore.kernel.org/netdev/20260603150331.1919611-1-louis.sca=
lbert@6wind.com/
> I'm asking, because this patch is required to execute the
> drivers/net/bonding selftests target from 7.2 released this WE.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
