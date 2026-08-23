Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FD36A375
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787485247; cv=pass; b=YikQGZSnxKj4uVOr9LOcfjPFRy7zHVrbH9ugsoP0h6mlHJTiQsmLiBTtfyt27KwIRs5Hr8dnWaKjEtJopey41SU38FXn1m7irPFXIAWxXjVgxaosS0O4WbW38CR/Abc25VoMfQXA8UMp5dORidJbBB04zHzHUk6hbYawRXsXr3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787485247; c=relaxed/simple;
	bh=t1yOB6lXAkXZSgznHtcAAF62SrqAAlNeqdd99qDvIqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdDhDK09n91xGzQAsKko85xq1ZSxT2gFwYlT7SpoPbiTte44X4LVat2P3q4ZSQ8WGldrBfWKvWi7rLE6/sZQZ2swhdcjl+tT1JipjAJaZAvpFN1B9ix789dtRAO3zVfl9/GPmJ4mmkGbNj2Zl9ojz/8k3hLDn02geB7hBat+5mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4OSHurU; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4OSHurU"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-384c94c9423so341592a91.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 04:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787485246; cv=none;
        d=google.com; s=arc-20260327;
        b=rNkc+N/vsnroETvDUB96xLYNgUeckKHwVyOSY53HN2sbZghBu+2Rgxy/n8LOyh3daS
         uOPKELjA+/g7wbFwsfATn2XhhXlQ0E389DkMxizEequkCamoEIUEQmkH2bu+LuwKgJHD
         QOA1xkkJcy7UxFGmicZSKIDhWcdlipmIiqJ+BHwH3Ntv6V5R/ZmNUtowwN7NixpK0siI
         a2o6ETW1s1nvN1i9vt4NPq5T9krMhhZSBZA7uoQBCjqlYUaf9f7LmSc8QGdpmqWSSqFn
         g+25H2F4BOk+CNtVIBIVapUrCF1E2Dv9eccfXbUWg9tt8GuWMId52QUJDFkbAS/Xo27Z
         CHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t1yOB6lXAkXZSgznHtcAAF62SrqAAlNeqdd99qDvIqs=;
        fh=v1X3uVXea6BqgkPUeN4S/ZmjZeEpy4TNCZhxcX+5o1o=;
        b=WCYwf1lpK4HRnFdQW87TSTLB92NJGhmTxW+xqjvnzFORL7Pfz1Lf0zdLu8jlWNnmbL
         MTF0VekQg4/jKlwCc8oAy1fBsO9wnHvyB5kERHCjCSF5kUt21cP3HLzi7xlE4saGPIin
         xzcsRd3EAQvxZLwB3AEoaxeC3rRz2fUsyF0CIeWtBrHdKkc/qPbZifIN/oOoxik4J0qa
         JTyxVjg+EH7xcextJFaz87Usmj63YbpBE6dWWg2olDqnSyuFy0k91/+MHM0E1iMedD1i
         RrdW+eWqbdkchxdVuQjN/mWIXm67vZitCPJqZ/e9Gkh+bVNmUQ5NYWiWn2/jI+Mp3Y0F
         RLgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787485246; x=1788090046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t1yOB6lXAkXZSgznHtcAAF62SrqAAlNeqdd99qDvIqs=;
        b=e4OSHurUi3FPik7E2pe+GIl7rr52gHTBQdlGv4kvB6+3pFk0HCsB/cQ5OX0KLD0U9s
         0yx2zbTLUVfsHloogFiUPoVHNs8W6gcB+ST2ugSikvyE78qiVuHTHeuSiMyKSXIlEzfQ
         0JK98nEbQhNa0zN3KsSX23aLxtXoVp2o2gywwM7gkz4ffG7VgQvAB7Hm3jzEgSmJJksU
         uqdCVGEgWde25J+r9GyLYTzyXRH5Fru0mXNrB08RHzKZ3fF5PMamLhin10NCPgYrurDx
         RTNl5hRTEzpnC7Uqa817ba5GKWaEogiVSJebem4p8moFCoUyk7OznK7urbg52BO9VWaG
         kh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787485246; x=1788090046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1yOB6lXAkXZSgznHtcAAF62SrqAAlNeqdd99qDvIqs=;
        b=sgihgvWTqwyPU1Uod74bYgl1fOf2a8e3UJpieBuPxw785wt9H9XEFMNw0f+Rn7+B5D
         JibMnnCLjOJqXMDnO6Hpt536ZQI35bK0UcwnkURrpbRoZDojsfULj6NT0aEYzUvNeqlH
         PApOZXO0Fkli9FKa6daFLrVhUaCU6ls9BwU/6brzDkms3jYNISPrVV9tq4oKonr0ZOTd
         cwMnOlv8ax3RBnNiFT74OYy1l21ryeRZpF3J8uFx7JajsqU4w5Z+cEZLOpeiPAgb7Flb
         XMQ3P0Ux7pJ3xSQozvGBKqjC0xI2prlCyl4aQccfXwUvaXJAy5t5N6+ssziye6v1XMoX
         JsPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrO19m2hlaDuPMpAx+JkKoVh947kaQyPm+nPKIVF9MZgEdf4aNYTCmaC/lIgbNOxdklQcySfOo=@vger.kernel.org
X-Gm-Message-State: AFuF++lt2nMJCV1KyNXcIZsl8bJsw4h3ujwHLYT+A/ta7WAWXVfqPcHR
	qpRJOpyHjPG5cSDqI7o3jmPPUYuipWhFZhcAUslvIqHVwAILjkjM3ZIVOLUympSRH1qSbbB8NYn
	J5X5RboLpYyyuuLAQ74ydHOKIj9AAorFfgS93
X-Gm-Gg: AR+sD10kJBursHHakjf/1Onjz1oy9C+V72/eMorgKgcu+mEnj1KwDkyGAnkN4avmrUL
	BR/SWfz02m9Mz4+K1Gij72SeSFyN+/N9Zos16XnfQlCiaWsXM0fZPIvyh2dkT6WmSMKK+8USP8Z
	XqHUquffGo25UAG6IRqIhmJqrgqAe0SQdYaS8mbcxH2gD8849ze93FW6ekaL3EJ+p/bUSoLZJEM
	LHb1PLXUG/ex/JBFmkAvp2G/DZWv6Fv80ptyKiRNH5XpuCheAMxV0HDYBG66DJ6tHuWqpNImM8b
	gptEta4erhQFOm8qMjYCmKL94a0Pdn1Lka2Ph7EBbl+vucgqY302uQRmBXhLjfGdHvQ6bd+UD1r
	kD/rLY6C/lyWNTSoOrQsIj/+fkjulB1nw1eia2CMPeueAhnlNbJIhWRgQmH7z
X-Received: by 2002:a17:902:fc4d:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d64a9a668bmr165095525ad.0.1787485245660; Sun, 23 Aug 2026
 04:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823103644.342849-1-springbreeze@stu.pku.edu.cn>
 <CANiq72mUbkEcvffQV-mNLfCxGkgTqwq1qQLuWpENsUCCBAHOqw@mail.gmail.com> <AOUA5wCUK5sso-ea1NbU-4rk.2.1787484007018.Hmail.2401213299@stu.pku.edu.cn>
In-Reply-To: <AOUA5wCUK5sso-ea1NbU-4rk.2.1787484007018.Hmail.2401213299@stu.pku.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Aug 2026 13:40:32 +0200
X-Gm-Features: AcwNN1Uws01evHg50TElosuDV-b_vS4j4csMx5AQPXdF_CkFs-0dBW7hZfXwcMw
Message-ID: <CANiq72mQ8bfEw-NM4phjgp-QxEP5RpqNTkXrjjGqkX+VukqkaQ@mail.gmail.com>
Subject: Re: [PATCH] rust: net: phy: fix off-by-one bit positions in device
 status accessors
To: springbreeze <springbreeze@stu.pku.edu.cn>
Cc: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 1:20=E2=80=AFPM springbreeze
<springbreeze@stu.pku.edu.cn> wrote:
>
> Thanks for the review!
> The literals were a stopgap; the code carried a TODO to replace them
> with bindgen-generated accessors "when it becomes possible". I checked
> the current bindgen output: it now generates layout-derived accessors
> for these bitfields (phydev.link(), phydev.autoneg(),
> phydev.autoneg_complete()), so v2 drops the hand-written offsets
> entirely and uses the generated accessors instead, which removes this
> class of bug.

netdev may prefer the minimal fix for backporting, though, i.e. the
improvement could in principle be a separate patch.

But, of course, up to them, thanks!

[ Please reply in plain text; otherwise, your message may be dropped
by the mailing lists. ]

Cheers,
Miguel
