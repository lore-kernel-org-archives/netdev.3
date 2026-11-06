Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793954968;
	b=li2sF/qj0suTbDGEDQHzoSSlnzQ0cy/Mc3ZgYAhsSr85uyBdRpk0mfV1ACJduyG6z3yQ
	 QjEkFV0Noa5ySvEXM6korc3XT4m3MA2nFIvkY9D5slp2uay+QtNX68RH4LAsWcsEZ6ji9
	 Barn8BLH/SAr4cH/lgTJx6GFH1pCfs/4oEUkNv63o5QSInZf8lUVpmpZSOPIwlan5g4rD
	 uG1BbAoAcKTNJTdu1+jzvSXewy95Icu70YGYGZQGaxAqxc1PGMfHnlscPjYdCWE8lKjJ5
	 6b4qFaRtEN42W0LqNRX77C8TeCX2nVXaG9l4D7ky1m65xAKfMCpTN8f6KMYQvNPOVNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aAUjBfN+Ow5v0eWrx+Nw5CLPKU13V24M0Y+SWLDXZ4E=;
	b=s0JLbrC63n3CoQho0oNFQ6okn+ugJg7pFNN30rvG5JQc0dEwa6JFoFXfWDaX77B7MdoV
	 x+9ZOAx1Ieop6xDa3oTIs/Z6Qn6jLrOVHpqOsdjqWsT/x/iJQvorEpaQZMPc9caoVIUsR
	 b2pgzczwK8c9rnjWYfM4TBi05PTEzRmlH/yMJwxS4aETw/q6Ee51v7nVAXemLEfu+tv20
	 ixCdSA1cDpBs5Gk7c13wjitjcaLTJC/EYBO25X7bEHa7jYkZWrG2vMR3OR66yPYr3yG9A
	 Uw2kkzAFhHA7Njhb5bT9kx/ClgF20zMbpSGHn0oUzwZMV9GCENojjutE0XOUdZq7t3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asa+ddil;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.138
Received: from mail-qv2-f10.google.com (mail-qv2-f10.google.com [74.125.230.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4869606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4869606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asa+ddil
Received: by mail-qv2-f10.google.com with SMTP id 6a1803df08f44-91e7a9d74d2so3677066d6.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 00:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793954962; cv=none;
        d=google.com; s=arc-20260327;
        b=SP7SmhEI21z/EzjJzo1mK+YxUCn09C2aY3tM+xTnjgcL3b7NhpbSJXw5/+hARMv59X
         i6ER0uepXvlzFkhR0sBm0baIvdY6XNB4NjCXazFIQMZBYvqj2zE1mSxu8/VZ76Hk7Rgc
         AMOY8ByokVyEYf5cCfd2/R0FXiAFIbZqAkG0q7k9NC7xlGWZkHIMZ/3V1QZ+8MEJbfd5
         MDExmjmzruhpdZQi4zbgcipZbyw+Qs1K83pG0cMEw7Ys8HY0Cpf4UaONCeHuO6XUUGMG
         niw40HTmIDsI2rPe4eYJFmD9CeYMWFOJ/4Ra70shTvqqK3a0dZBpGzrFmigtgFkGGPDF
         Bwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aAUjBfN+Ow5v0eWrx+Nw5CLPKU13V24M0Y+SWLDXZ4E=;
        fh=OOgitwruX6EBA32MWtJp+Z+1PM03ogjTJZhfXyXLlyw=;
        b=ppRwr8jlG84aGvBb+9pkhPKYaLWxOyray5tuEe4mfQubKMwKpoSBG9HsI3w71HyqMW
         rftTZK+eOpHb70/zAhuK0F5Rvcb6K3FR9oSz4ru22/PzkA//99anzgX7YfDCqfHSiRvI
         ZdeQgzuEZikeACPpXnQ+q8683emKwE+1bnuNf3Kt/Tmbxf4BlGfhynOzU/hciYCPmM1l
         fXMULG1gVqztSMHkZxweWp6xIazvOjG2x457QgHx675P6QiGMlABMQ7/vprSLxVte/yH
         ecN413X++nml8/XYK7Sj8ZVhDRhgBA4ZsbzWQ7Stg4od1jVZZO5MMGwVG5XKH/a7+M5S
         2GRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793954962; x=1794559762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aAUjBfN+Ow5v0eWrx+Nw5CLPKU13V24M0Y+SWLDXZ4E=;
        b=asa+ddilQIBt7rRbkAhfVSLcu3rbxK5KtNYOTTFYcdrXxl0d4ILbCyDMEn4N7t+1Ze
         A2fS/PZOIFZxHBd2qUuC5smzQPY4V6+4OUoRjjoqx7E1c1lja8qvDXQhkbjo2Rf6msGY
         EbF1Dfek0kV/aabmjcMvXAeLKSN3r2ip3j1MAqE+pWO2chbYMxzvRYCS6Dee1Wwt1g9+
         grZfYhorONBWSSaCEMPz9iTqtdLhSTED+tb3azy/hcGwgfQAr3A9Uu1+g+Rs+I58dmt2
         gp6r7W8wjH+cj5j2vbjbGlti3fW59fzt3h5c9nJdjM9rQ09jmRxHl8TCAezFQ0R3rv3j
         0stQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793954962; x=1794559762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aAUjBfN+Ow5v0eWrx+Nw5CLPKU13V24M0Y+SWLDXZ4E=;
        b=OVwTnlGMpyJo+KjppQh1+wX7yM0fNYyNRTOVstH1RP8HJ59jkYIOC7kfws7VtD8Cxl
         AC5DLPmD+gpTt4iJzxTpqnbQnddDvSQYmYPknugzVLSjuBkE+k8YA+kI2GYZf7vrsWoK
         MvZCe1FAifHrjWpjt7f8fINM5YeEVYvZSaLjRzXQSZky/Qr6TV6JIvb8gf6KSqt9XcCp
         j9mXIAwT29otmYvXupTsfwNpL8cjtUGpa1P02SUHB2i/w3km8nSHloIv359SuIA41M+z
         Rbsn7Sf4zbJcQNnKcJApo6sEIj00Ox75qUCzjhaO4DJKqxl0zN2nswWVHuCQcbD1juOV
         NZHg==
X-Gm-Message-State: APuU4Z+zk1Xccr98zsev7cAVCGupVsU6O0khBLed2vywwUyttoTEFtcC
	boKeU2JqyfrQJq3QYxkXBKQuCz8QM3H2EmZ0ADJcZE4gCm5lnB+x7ICv7yfc/WCkoFRR6u1dL+b
	26pz13Is38I0FIWy9TVCJxtwogXw4egk=
X-Gm-Gg: AYBFou2y2tCEYj8NN6suCk2dylCj8JSrm6ZSULXQdtAa+qbzJpAVDCqrgSH7vzHj4f7
	FM/Nlr3L4yrjXfSeGdgLp4bWfeqZfznvtPpS/dwS1LjYKpv1h05F2TwNuAoPg+crZbArfBDafZk
	ZtqBq+pOhgOA8hCJ4EbQf5UyNMx9VXxLs4JgvzVRO3QHOhCUQ0aV3jUvC0ZfD5kznS9KUQsED+8
	cElHCvucAOx+vE+EyWx2vmpw9PIfaLfJcaeKlpsz6UgRC4vYXh/v0kPfUfJ0KK8gKpOamSODVJi
	755l8JE/h1gCEE363MPHvCSLaNddhUcGQoBw/OGqhUwSSym/cDsjf/LEjw0emm47Bhd9KiSxUX/
	TrK0QAew2XTn36lMJlT/jEtC2Kup4v6sxMh/uVA==
X-Received: by 2002:a05:6214:3289:b0:91e:a362:fde3 with SMTP id
 6a1803df08f44-91ea993442dmr23957856d6.51.1793954961670; Fri, 06 Nov 2026
 00:49:21 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com>
 <e4054f5a-e60c-4253-bccf-d05cc7c615b7@nvidia.com> <CAFxp=AapgUYLUhipVjR8oM0fRDSLDX60AQf0UP8=U4M1ASqmOA@mail.gmail.com>
 <e6a557b3-2986-486d-9679-e7a4fd1cee5c@nvidia.com> <CAFxp=AbmdmTsj4ugjxdKhRR=LJuuC1yr7DFnLCSgOpC2g9470g@mail.gmail.com>
 <atZKOtjrb9HKSNHF@dtatulea-c5.nvidia.com> <CAFxp=AYqVgR_Eahz2QsC=cCdxo5GmTwdHcgBdXRGf9P+v0OJxQ@mail.gmail.com>
 <d6c14ede-1cfd-4800-a8bf-5093ab8c000a@nvidia.com> <4cd75251-fbc4-402f-8939-1f6133f3b40a@nvidia.com>
In-Reply-To: <4cd75251-fbc4-402f-8939-1f6133f3b40a@nvidia.com>
From: jiabin deng <dengjiabin2023@gmail.com>
Date: Fri, 6 Nov 2026 16:49:10 +0800
X-Gm-Features: AclHuK9b4KLW_6Y9nV1CiuE9RC4CEq_MHrw70_JTORdOcq5STyTgVC_EA7ZLoD4
Message-ID: <CAFxp=AYboDhxOr5NXQajLn5rpi2Zn_o4EDJ7GxTZrnp0Ogd7ug@mail.gmail.com>
Subject: Re: mlx5e:zero-prefix corruption during TCP DMA-BUF RX - help requested
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

Thank you for the confirmation. I have now submitted the fix to netdev
and copied you on the patch.

Subject: [PATCH net] net/mlx5e: SHAMPO, Disable end padding when
relaxed ordering is supported

Message-ID:
<20261106083719.22798-1-dengjiabin2023@gmail.com>

The patch is available in the netdev archive:
https://lore.kernel.org/netdev/20261106083719.22798-1-dengjiabin2023@gmail.=
com/

Thank you again for your help with the investigation and for suggesting
the fix.

Best regards,
Jiabin Deng

On Thu, Nov 5, 2026 at 10:14=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On 23.10.26 15:14, Dragos Tatulea wrote:
> > On 21.10.26 07:19, jiabin deng wrote:
> >> Hi Dragos,
> >>
> >> [...]
> >> Thank you for continuing to investigate this issue and for suggesting
> >> the fix. I also greatly appreciate the time and effort you and the
> >> other maintainers dedicate to the open-source community. As a student,
> >> I am excited to have the opportunity to contribute to the community
> >> and to learn from this process.
> >>
> > Thank you for your good analysis and fast response!
> >
> >> I would be happy to help prepare a formal patch with the test results.
> >> Would you prefer to submit the fix yourself, or would it be helpful
> >> for me to prepare and submit it based on your suggested change?
> >>
> > I am still waiting for input from the HW folks to understand if this
> > change is needed for all SHAMPO cases or only specific P2P DMA
> > cases.
> >
> > I think you should submit the fix as you did most of the work. Just
> > give me some time to check the above. I'll ping you hopefully next
> > week.
> >
> I got my answers. Feel free to go ahead send a fix. If you won't get
> to, let me know so that we do it.
>
> Thanks,
> Dragos
