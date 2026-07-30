Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9C400DFA
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407148; cv=pass; b=ZH54nyuIPiTCo1w7ShyTEJ1IaMQypfDdEamydc/bzR9B56qhRCW4mOpUDvp1tzfWGgZQSNazYwX4jy0AxoQQHKP53AhguiUIIqGANIpUCDPopakftqgvWXoZT7ab4uxeGPLSivl0v+PFXb1uZxgMBTBodpOrjFPq4Zm6UuDnJ8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407148; c=relaxed/simple;
	bh=zcf/407tfjvynSAPl+YAoc8Cm/PJX5Tjy8uRWRPM6qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qq0vKRaxahX4MUUzz3w7xXMGoX+73YFlEEN5iAt9/1bx12GIrYItCPepqMbeYPny2aAQy0sew4txV5xVhvkemnGNwfQSVsYyaFKQeCS2fSr0eMxTpItSnVuICATzGrqpNRCPJRo8pG2VpQ0eGse49QK/JP3NgeBYCvr4iGHlNnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wdrlQrCl; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wdrlQrCl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c2808dbc3so12513241cf.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785407146; cv=none;
        d=google.com; s=arc-20260327;
        b=CHga7lrvYYDH4A1mrCV1r2GOHBA6TZxxyW+8FmG7fxSMy7DUlmn7Zgt4VTXNQiKOoZ
         cCyrGHCsfhfdlVUf/jqSY2DEIlRkicOFb5pjzZaAx/15JDe7vS8Y7kPFCHul0YhJ2VA7
         +qP0fTB+QBY97WppY+AamYUG1Yv2SfR99UgdAGwoe4lA7OmX185FSAu1sy5slF0AWuJB
         t7mtzDSbiIb6JN+KUupbAkgnS9Jpt/Dl7zSoPzt47KfHyEwQ+1omkJwUsH97YGQ1TkDY
         2q/x10tq+oLd56DAER/7EDy9Exoe3WGCWzVk4omj+vOYycwP70XGxDMM9n9xwKhIdAQR
         leEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fc7zx7iwgnSG9lznGKB9+VdUr4JPn+D6O7R6mZyWR/E=;
        fh=Qv/8J1KTED8g+rN/RcQhYo5ZlLK9hGdFKmxFibpU5EY=;
        b=N84HcVA4O8TKdQw4xVkL7YjwhPisiouOw8Rv9tz1ZEUoWpMs4G73mq05K3SzwYeJJz
         rlmfBoXxmUDCg3Lv4nG6YeAYdlEJEG0RBW7gr4Leai4QpUMdGCOL5yRVlVmXvCTt2LoV
         80CVerCK5FaNglshDHgHOyJARt7gJg31PWM/8ZxwAhgCANmnXZHoRnZ7GQnAsDrV0jW5
         w6h+56gee2h/GdlyuxACmcrPmKkIIzrBxrtw94MdFKZj6Ly8HDPnLTkJnNlrHzaCOIaa
         b7dF+skLlMS3JjvU2e07YaWXrrGATthJJzPnbsBtGjpvtoaqabmh0WKGeFLPiAxNaYo5
         H53g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785407146; x=1786011946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fc7zx7iwgnSG9lznGKB9+VdUr4JPn+D6O7R6mZyWR/E=;
        b=wdrlQrClj9zoGHNIFptmnZyfbdsIbcw1VUxX1XDG3HM5CSiy6R5bcVqs7oCsU4yo7Q
         U8EGcjvP9XFBA/R8N7xBTPKDJufmXz3L+9+do5uiSHWXuxnWXuOTaLGrWb9GHkgwBkl2
         edK3pKR34kjArOe94v8QHAE6eiwWRU1cv+A3bswHMZXVblOksiCuaPWhITouMBRJrKOc
         S+Cq6KSeXpNBUJjp6TZk1lJDtRDBljRzWwOwrnJgANgRTFNl7NQ0smdAbNoE2lTCYzxZ
         iAYXA3YfaEGw+Uq3F5EANFG6VsrNoXVcGkGBUb/sUkCSL4JVLvnB5mvXrJzM9YcSNpC4
         UR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407146; x=1786011946;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fc7zx7iwgnSG9lznGKB9+VdUr4JPn+D6O7R6mZyWR/E=;
        b=c7rsbS1DQ0ciWz7tBzALP1MKn1wn4J0iUNKiYwaib0odN1xaMbOuJOuIvmq3b16rWw
         mfg+BjeXA0TOk16VUe1OkEyJEiaqrIXlt0wsaBiup2enEr9Nv+O/TCp1jmozijkOMJiP
         85jT0ugnvfjfDLZvYoyIOPv0BQehYwucE8tPEHFQxIArJ9+2vpoO8f8Nlxf+XV6r+Q1a
         j0ldPD5XGNNUgldvKnOZYqHXFaEMu/ctiuhDtUnKMhHuDbzcZHnltXWNUwEVFp9M9n2D
         r2Aug/R+t6WY8t8Y9HqAb0ABpeM8FzQnx6CdiMFiMspzqC8QQKCUxafeuCg4LY6GO9Ft
         3xew==
X-Forwarded-Encrypted: i=1; AHgh+Rqr64Xhs46uuMadGEjYmu34DQuXKHWExJeomSMt4CDZ8nItZWpKVfqkaxibT1unAOYehvBJ4iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjgfz6VBzTsfCgD0neVjxkxzg4aGzMTqbQ8ods5P5eYh4RTFmC
	qdzw408qF4das1z3YMzEOqbbTDk2fruExy9CXUEUeQRdMRlHmeq5X1s3lNxOlftWJh8YPuuFHHj
	qehXXaUGy5vOmAXWP3POrEkk31mFtu9qQ4o7ucmuL
X-Gm-Gg: AR+sD10DcOqO8Zfu4KIGpyXsG4LEMOqN+So01Uuw1Qsr3dQE0VXvviqeXhJO7gmEvVg
	jKG5R3j3fThFCYlOXft6LW68z4lGg4qyOV5Pq2ECUnLYgjlxFoBV1hSvJM+3mUccHlOt9Py+AvV
	VCEXY2WQu5H0D18nqG4h9gEDDTLhhfkfMzeJD584/+/zi/ATK3CZURb56HOzsv/YRdCotL/tAmv
	S7ssHmMcH9FkH+ujWDvVElsbhhbEDa4Pj6HX3r9vsaLpouwLS3LrOnRVZe0kYVrEmRpEe+bJ00k
	oFJggJJd9hSGBxi6INnI3UVWx7eSyKautUWn7BG/DEvubGTuCC1Ak59gwliOVfeM8HmgUhf/hZz
	Z0NoxWKM3zqrekaIvEwa7UogUPRNITUOLDGIgc7th/DZNR4V/EfmWvsc=
X-Received: by 2002:a05:622a:a16:b0:51b:f549:c706 with SMTP id
 d75a77b69052e-52b3837884emr20867561cf.16.1785407145313; Thu, 30 Jul 2026
 03:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730100006.3547944-1-reshmaisat@gmail.com> <20260730100006.3547944-2-reshmaisat@gmail.com>
In-Reply-To: <20260730100006.3547944-2-reshmaisat@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Jul 2026 12:25:34 +0200
X-Gm-Features: AUfX_mxdU0hxe_5irveWIAWK6FUEPamSnd3mzndEsX-QxM0SRYdYJhcy9C-_U6Q
Message-ID: <CANn89iLqLYAE_ZbK8F1HNop7nVPAR8AaMD2ojk+XuCNomJPEUg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: flag inconsistent qdisc dumps
To: Reshma Sreekumar <reshmaisat@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 12:00=E2=80=AFPM Reshma Sreekumar <reshmaisat@gmail=
.com> wrote:
>
> tc_dump_qdisc() walks every netdev in the netns and can span many netlink
> batches.  RTNL is only held while a single batch is filled, so devices ca=
n
> be registered or unregistered in between.  Since 748bbef5fc6a ("net/sched=
:
> switch tc_dump_qdisc() to for_each_netdev_dump()") the walk resumes on an
> ifindex rather than a list position, but ifindexes are reused: a device
> created between two batches can be given an ifindex the dump has already
> walked past, and is then missed entirely.  Before that commit the resume
> used a position in the device list, so any unregister shifted every later
> device and silently dropped a run of qdiscs from the reply.

I dislike this patch; it will force dump operations to restart on busy netn=
s.

Most devices are created with a new ifindex (dev_index_reserve() is
called with ifindex =3D=3D 0)

Forcing a given ifindex is rather unusual.

I suggest detecting this specific use case instead of slowing down everythi=
ng.
