Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BFE2D46C0
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242597; cv=none; b=FW/kmOqRaJ4v0KJt6o/P+MgRIFq4uYd2TjleTXnIY7xzGypOUa4VizskQMy1TjqKTH+rYHnW0eBtJmsA4V7/3Gr68nVs6g5aF7cHVhroFubTLEu5WAWEpHYkTkgeeMXsyegcjAcXN+OdTUqNrc45W8hyBd/GY0zvuJXARpYEPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242597; c=relaxed/simple;
	bh=UZV19VbibPNwF4F+AjCkARvER7vjt3sF706JglzTd8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxnGNwPkYk1CNpihhv4X5lKj0MmV9tIm3ZmWiEXLvvPY0/X0Uwm0Qe8x2KcqQAv93FlvSn71x7m0E1BAiQ9sxkqmvtvd3xfCFv/occlR0frbubUUlxXrZLXnXTds4BOxzOH2fht8/6AbqwCIjUUxS7I75DTPz2meg36RCiGPons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64c9ebd1369so2407379d50.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 17:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772242595; x=1772847395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OwYEc4mDrdmq/G7hLgokF2l+8tR3VJ7jYqQRsGs6NZo=;
        b=olJ3ULWLlnO1J7wlrxseUzoshBDhNNy1zqFsHI/dKgrf3zsBAGgg1MeV4KSQJVNZuG
         fTqEoK7ygd1gYopvzmhIhRHTAMdNpgwx18B7mku9FZhBRd9OKoyCAXoQNgYXrV8yLYMW
         CKjUQZKwbuHm21L39Aj+gvnscN545z8fFAHMRflI94XYWebeUfcQ+XYBP3h2QJJAhI3J
         eS48K7HdfwBXM+DXuTpYiKlLqjEXdPimzSgzbnyc6qoz45aAVnNF1qtERpYDPKqm9XRm
         sMX98gZXy/wGaeB0ntWvDWdHCLjQxlAVRlYffOe8w0kfI2bjFGAUapMPYpCd78B1D5s3
         Y5sw==
X-Forwarded-Encrypted: i=1; AJvYcCXJwDaAicITxaFHrLn7TGm2VkoV5euRX6DIUq/aCPI8rYuaY0IRY+/5Chc2n35dg3jtRidLo+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2j7sCOdIBsMG6AmO6c3tpWsZ7WZXUT96YKaxZ/UMuy3BqtLe
	EdC85gA48G3D5ameK3D3Mi6hcsi28wmZpcfZmZtDYVcjcpri8eqMSvP4fQ+E6FmF
X-Gm-Gg: ATEYQzzBabygYawo1MoL93zh7UI8NbdMEQ9YZqtt12MV0Z7YOG84jI7GIJGHNxu1+TR
	IOl3DPLvmAAYiVd6OZBTc0XNVia2ZMb5UhvuFBQzANjZZ647p5gqLd2abZ8bCwybX0wluX48dkD
	3MpsfUAAEJkeIBbeXKBZURu2eAjm9m+5El7Pxpnz3S1W89fjd4lBfPUMU85jlvLP6I1szM2l9HD
	UAklzRGDpwpEf5HEJTl4GW6CQDGRvdbTeGdgn9MvZvAKUTnbDJX1XdK1LjebDpWymvNuFxXgGiw
	lQaNFlF7Z7ZRRWMT85sfySQQQXgQPiuwiZiC12Ov4o6vnDpKGwcopYMB842St/oWxJdFBZQr7bk
	zZvt9/sMioe4eAxRmGCbgak7vXDQypvTQpBYLZ0aE5cUXFT6vKbaeg0oDWrmvLxSEygwjBY7H3U
	lUlrQG93mfWG4xyaPHrTI1UM4R2UxlVjEaSmluknl/BgBJaUtXy3YHKkCHnkC+NVWybtt8loWX9
	f1UeqIsCTAkzeg=
X-Received: by 2002:a53:ecdb:0:b0:63f:b4d8:1f32 with SMTP id 956f58d0204a3-64cc21186e5mr3171743d50.20.1772242595484;
        Fri, 27 Feb 2026 17:36:35 -0800 (PST)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com. [74.125.224.51])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7626e49sm2918187d50.11.2026.02.27.17.36.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 17:36:34 -0800 (PST)
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64aea64bf15so2355503d50.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 17:36:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIUqNpAvacc9v6n614Smf12QYdPtls2+Zsio9zeOOjoYuTzx5zre2n8x8KHa169IC7AzKJvFY=@vger.kernel.org
X-Received: by 2002:a53:ecdb:0:b0:63f:b4d8:1f32 with SMTP id
 956f58d0204a3-64cc21186e5mr3171717d50.20.1772242594546; Fri, 27 Feb 2026
 17:36:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-netns-redundant-mount-v1-1-0b1ebfc1c79f@black-desk.cn>
 <a9197cec-d406-4201-98d4-a06820b220f3@kernel.org> <CAC1kPDOs4MP0=89Aa=Y_nZmVY2_9WUgfQs0x=wd-FPMFedrVqw@mail.gmail.com>
 <6fa8c88e-d1fb-42ba-a0a1-f8aa6802b454@kernel.org>
In-Reply-To: <6fa8c88e-d1fb-42ba-a0a1-f8aa6802b454@kernel.org>
From: Chen Linxuan <me@black-desk.cn>
Date: Sat, 28 Feb 2026 09:36:23 +0800
X-Gmail-Original-Message-ID: <CAC1kPDO=nQ4gGQKoHd-YT8sC3kitw=XHJcmEi61vjoJ3=b=+AQ@mail.gmail.com>
X-Gm-Features: AaiRm53evMe_67xPTwum2_lgdnxA6DOXVy0_G8GV99EDIH5QpA0myuYwXPSb20w
Message-ID: <CAC1kPDO=nQ4gGQKoHd-YT8sC3kitw=XHJcmEi61vjoJ3=b=+AQ@mail.gmail.com>
Subject: Re: [PATCH iproute2] ip/netns: avoid redundant mounts
To: David Ahern <dsahern@kernel.org>
Cc: Chen Linxuan <me@black-desk.cn>, Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Lennart Poettering <lennart@poettering.net>, 
	Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 4:30=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 2/24/26 6:21 PM, Chen Linxuan wrote:
> >> with this patch I am still seeing 2 entries:
> >>
> >> $ sudo ./ip netns add blah
> >> $ cat /proc/self/mountinfo  | grep blah
> >> 337 92 0:4 net:[4026532418] /run/netns/blah rw shared:344 - nsfs nsfs =
rw
> >> 338 28 0:4 net:[4026532418] /run/netns/blah rw shared:344 - nsfs nsfs =
rw
> >
> > It seems like your old `ip` might have create the /run/netns mount poin=
t.
> > After remove all netns then umount /run/netns, and ip netns add blah ag=
ain.
> > You should see only one entries.
>
> Fair point. I no longer have the patch, so send it again and I will try
> a test in a new VM.

Why has this patch been applied?
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=3D8=
2c8b9fe511e6c503ef60c16eebc7a715c3189eb

What is going on here?

>
>
>
