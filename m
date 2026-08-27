Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8F5733E
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852857; cv=none; b=HMR/LcnB4RdQehkj9tbqj6LF89PMm+h186a/r/AwWn49bacgy9CblUo3Apecx3BMPVcs706V3wXfNEJBkUh0zMufuu49oi/oqp2+KKVWWkxKF7dg1LE9Yx5balSdxwKZWO+GkfSI6sUF+J4MJqVDE9clbrKLSSF+6eQT5e7kj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852857; c=relaxed/simple;
	bh=Eg+Qv/iiwr+rC20BGSW6HXYU7tC5N1NGEE1ncPpNAIs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=i5dd1xEcu9RwQIMVDdhrDy2KmqI8xB5Cr1BTcPn8UULyw14fsfgX7MU4BKD+R6RpxqzhGUC7BHIJ8IW3yKbbKPJcQ3Eu/o7ff309t2km5yEc2+H/PJ3hXlu5K/Y7DD07e8i+psoc6BrVjuzF3SUZcQtZx3xRNyIOUKSvWKNxiCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpMnr5VJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpMnr5VJ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2544ff970dso18204566b.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787852854; x=1788457654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Eg+Qv/iiwr+rC20BGSW6HXYU7tC5N1NGEE1ncPpNAIs=;
        b=YpMnr5VJbf5uBhLMmQGk47T72fiaL9zGwTyEUDXg54GbxnuJLOhd9S/eCNn8nDPpNm
         RO+f9nAQI4riQ4pfgj4loIXO7y9CWhIohjzyjvR06gMLHm/fX2Jhd0m4c/E9NzW2qQfK
         ersj2dniPd8dunobJ6ItRJtBAok1PsCT9cpUkI8UueXa5JDoBMMyRu4C9vAuM2eWknGk
         eN2OvNNnXDbTW8ObaG/xK3HdXk8kU4wfBhefRihHG4Yv2tjRY0M5eJts0J2Cb0ja5g31
         YmiJp68BdZBry4dns1cq7ACIr7mvkaAMAwc9tDdvIFa9eMMV1B+ik/2dXEZvkc87DFoe
         2siA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852854; x=1788457654;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eg+Qv/iiwr+rC20BGSW6HXYU7tC5N1NGEE1ncPpNAIs=;
        b=OGEyXNE+8wQA9xAaDa6ptYu8w/A98IMuAFn6DuQ8kgwkXgcOad6ybqDZqtukNlCcvp
         W+vof1td82ifTAipcHjJ2SWzD2M7FMvva0TQOBATRz2+N5JzddN7Z6BAtCb2l1cVnG7a
         TZokGBZcsNSdQ/j3fJSeC50XVMqU6twAOZI8kGmi+3+rC+t/VVvnnFPRNeAyM6P+GgIk
         1r9UY8MTLf9u+cIw+FRhDY14U+x2WrgU1WhWKcDBn50WUJBI0QJSq0KAiMtQtzQAZ/p4
         uO8b2xxEYBlNnZ4UPs8l6UCNDmUZUxpy8qb+O+jUWFTcInxjVvH+X7luHEV7VV8h9UUq
         rolA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6iRmfZ7Rnd+uXg10VU4smm/CjFo/HXtfbQoQKs6+3sO+JhQUWzKtuoHAR+//U1AfS94JtYSU=@vger.kernel.org
X-Gm-Message-State: AFuF++nkvpQvFTpqv12P65THf+ZW2MmidNGT2xl0jrZuqwkaoIvFU5v0
	Hto48z+IpQ5AsEuGuup0YxFAmEXFwn6ZIevSAJfLqktRAib4SDSYoEofUbsL/w==
X-Gm-Gg: AR+sD12FGxfzGJ+saVPPRZ/hx0EPbLhvF32VUJZJx1c7th4Toc2EkcHkbtgGBwV5fuC
	X+euToBZfWMHPZ2ZD4Jwh/lc3eEKKfefwiyQwW13kHY1b0faZh9N14IuVA+X6totjJy+PV/G5OV
	s1VBIMg74LFHK9LbIGmdemU0wDbPUN6wuOWO3qgHzyeWqJuEYqIhQHcnzXAacH1nL9zcpqj6dNW
	Obzb68q5hUhjqkJMr5H/Ag94LxxwPmWvGKIlP8k2/+y+y19ApTyt5qyj6l3WWKlg3yrupU+yYQ2
	RNOBPKyoidTaDDSG4LH7BU1wS2pwKXXAguLbkob5BFxAincJoR94h6P5GAeevR5HAOeZ55ft0eT
	BbsRH3vqpRsCRtbyC5XpziCANQmgijKNNYKyI5TGwKTDm/74BARuNanLf7cjvHQ+ql5glIxjWp6
	YExb7xCe5zSynk6vG7dj4G55hqlNwv05Uw5EKHD26n+/fFK51oQmGBUp17LD/cribIRhDA5S6Bu
	9TWig==
X-Received: by 2002:a17:906:7947:b0:c25:4ba1:5953 with SMTP id a640c23a62f3a-c255702dfb5mr34260366b.11.1787852853888;
        Thu, 27 Aug 2026 10:47:33 -0700 (PDT)
Received: from ehlo.thunderbird.net ([217.196.163.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250f99f6bdsm647834566b.0.2026.08.27.10.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 10:47:33 -0700 (PDT)
Date: Thu, 27 Aug 2026 20:47:33 +0300
From: Bohdan <boulderobscura@gmail.com>
To: Mark <markmunene827@gmail.com>
CC: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BBUG=5D_iwlwifi=3A_Comet_Lake_PCH_CNVi_AX201_=28?=
 =?US-ASCII?Q?8086=3A06f0=29_fails_with_error_-110_on_warm_reboot?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAMSTZO=2dm21hYcKKeDGCTb4KJ6R0ukDAFBQtsp4QVzPmCfcSg@mail.gmail.com>
References: <CAMSTZOnSYZjqj4AyBpLg2hQfRs6JYZA5H26MwQ+G2WMGgNzBkg@mail.gmail.com> <025FFEEC-E57A-4C74-BF1E-D273253F4D9A@gmail.com> <CAMSTZO=2dm21hYcKKeDGCTb4KJ6R0ukDAFBQtsp4QVzPmCfcSg@mail.gmail.com>
Message-ID: <1EF6CC70-90BC-4B9F-9F96-9DB1F3A69F1E@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Hi Bohdan and Boulder,

Both are me, for some reason Thunderbird on Android decided to use "Boulde=
r" which is Google account name=2E Hope this won't happen this time=2E Plea=
se bear with me while I debug identity settings=2E

>I tried testing the mainline 7=2E1 build directly, but on this Precision =
7550
>the generic mainline image hits an early boot panic=2E It looks to be rel=
ated
>to the out-of-tree proprietary GPU module and its initramfs hooks, so I
>wasn't able to get a clean 7=2E1 boot on this installation=2E

We still can debug this, but you'll have to blacklist the drivers that mak=
e your system not boot (and lose the graphical interface in the meantime, o=
r rely purely on integrated graphics during debugging if they are present) =
and try iwlwifi through the command line=2E In the worst-case scenario, you=
 will need a USB with Linux distro ISO on it, and a guide on how to use chr=
oot=2E Keep track of the changes you will have done, that way it will be ea=
sier to restore the system=2E

If you use NetworkManager for wireless (you likely do, most Linux distros =
do), you can use nmtui to connect to Wi-Fi from there, which may be useful =
for further testing=2E

Hope it's not NVIDIA (it will surely be NVIDIA),
Bohdan
