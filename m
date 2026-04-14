Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11B3C1414
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160686; cv=pass; b=d0bdBKm/lNsKSA4dfzeJ5iCFdrTszty723xzJSZJAQwDXjxXYyi3q9/uk4XqxIdT/ftUjd1hqTciM8Om50SHoWUZLaQQPhTeF2HGZQAFNV/fgqQrgkPPLiMmGL4pjriqtMGaZy0qqDpkewFdazrQAi4XmGbnuU4NKcf9Kf4zE8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160686; c=relaxed/simple;
	bh=9G4aNW0qSYXCAoZGlzimeLIoaqXuWiYpcS90B5BpCe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaooMCDDvuKCageZRm+EF5pcjbCKOEX0JyOAhwjpQEtT0sBbhxEkRZJ9XhCm6F+NT+SX7wyciC7fgwtNCYu0gn5QBZD+DBdouY6sJHiVuGvtW2g5+2HZqWjFtQ85RLl3ayrOjCQGae1xvdLnV+FeaebXLcQyVJ+p5xPDdSxDNTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsKyQ3fb; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsKyQ3fb"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506aa68065eso41973171cf.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776160684; cv=none;
        d=google.com; s=arc-20240605;
        b=hMaMWY59jl72GYJFEcnAZ1aRfjiA2JZ4DYhytXs3bNg1sEHAGU+3Py0EyjLvfSXnlS
         3n7/nulA1tf2vi2HSLzgwZsNJHB31sb5FRise4jrRVpDnOiddlZ4Ed3GO+iy9jRvM6fm
         9/Se5kdFS4K5aQSXpiYYKzPutDuybG3LYpSOUdHSWD7CQ3kf6fbcwDIKxmJtznhdZEdB
         Si0cLpzM9HRoW5+r2M2mk3L4q2BkDeud35kTEQJ1nvxPdPB2Pxc35bvKW1v0dCcQ8HuY
         C9W0gatwiXTMg5IWVIhL2Da60LoAmNNNlKHwzK1++e+KcjWtB6QEf8GmH//mXSU/J9Es
         RXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lt2L91R0t0j4a+adrKa4HTX+KJG0QWfVScgNiR2mXBA=;
        fh=zWJa+rro9PZHuTnUo20D9GcPeJedeuG2D7mnbRz4WYo=;
        b=LZyYu3FRLwlDkV4B8c2yIWSozwxye/JLikevUzeBZjW4ug1pceMfh3frj064sg8tt7
         VZimtr/w54G8RnW217Sjr9ijsPFsEaPEhPYJjcc81sr1STy/CuqO77Nh7GoTh0hRwUfx
         YmKa4a/2/ZGg/iAWbPehn74lPuir4Z/wUpBGfTE/Wj6JLyFLQFxPKWDT5Z2p2xAJGpW1
         +8S+LA7VdR9oFg25fZDDV+z0hVq+HRuXFovT0vUdrVNHzPHozL6hM0xKwtjk1Hg0E6d7
         7Mrex1klbB8FVvMHmpzbgoDkQ8Le16oj/yiZeMeig2UvZHWeL+Wx7lJykPdvsvBtVGn2
         OYhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776160684; x=1776765484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt2L91R0t0j4a+adrKa4HTX+KJG0QWfVScgNiR2mXBA=;
        b=rsKyQ3fbbP8gNxAx7veUXSMDFp+lTdueolZ7ogKJj1W/BfO4COxVwBxhJwKOr3hVGf
         NaCseoibiFNuhc+10wvrCWxgMQEvEWJTJ9Q7XnSIjapuAH4xKJKSzKOA0v2htfk2zmBu
         So4pKEhI3ZdnnpXdUeTYEFCutOscA6e4COkRF1wzb5OQj0Zi+4gf6M1pGhGMXVykHug4
         Djuu68FcYqUapF0+iALxCEaQNajaYf7ALOrSmdxANlXEJd5LOUuQCQpyQDr1/0NQNKc3
         Rh5JswBLr2Du7deSD4AEFgE8cizQ4lwWpS+98MJxjRHrCO0o+KQo8f/3rViqPnIyNdOZ
         gCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776160684; x=1776765484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lt2L91R0t0j4a+adrKa4HTX+KJG0QWfVScgNiR2mXBA=;
        b=CbCfB8EuGrUElhCD+Ga1FPWDeqXtq4MLVnCyOGPf9GrswcCQOhzw0ZtZVt91qmx750
         R6O0jN8SHRS/tNJcZw2r5PqtqNhXcPxRj/PIf4sxbLK0v25pRTIBMn8of7ml26NgsYKF
         okF3eH726nM6CPd1gooW4ihn09WrUfMv1RYEhRa3bGkN57dfpi8i3J1CTC2s4bE5sOO4
         jIuDtOhNWe0fsCZtwh3JhLAVXVXA9nZznyewiUxfQuZii8t4h8dlDgne4leVru1WEBG0
         n5y2NQMrt1b1L2ebc4wPgXGlSNvzgy/XpnFIGZK6tJ1ODnMiCyuX2nDTQcP5hCvHsld9
         68ng==
X-Forwarded-Encrypted: i=1; AFNElJ8CjK3LVHQG0/HJjDfowODLYLtWTyIO9SVvQWHOiDUBAL19Pn8yc3nALUuM7pp2JOEKUvc9OeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPJ1tAyYzRgjybjPGN94x8hUCp2ucytfYM6BYTc9l5+vTYoU+
	z3wuPfoAIv46O9CaW0pbXdztxMYTLQU4WnPlu7e0/o9jNdgXpLT4k1tMrSfr48DLLX3l+O6vXP3
	mH03U3RtRSz41tZqpZ10vvnd9KZ6GiVZrbfKUobn3
X-Gm-Gg: AeBDiev8RK/UfDPRf6oIB+wcsYyRCilF2ZykFTiYhpIGLvVoraARW3a+3/tOXWKR4B3
	gtSLGZLdgRilE4esgxgjsLXTm3hntxRU7g1smEXdBCk95T35GCcc/19qk1MrrZbNT4dtMUiZdXA
	7sUV6L7AGaRRD7Xq0Moiu7IJ+MDXgUBocxLFsH9+zWnuwG3+vzQGqlaWFl1GwTr+OZp1y1Zffkf
	SFOMGPCVRVp6xiFhFzR1NelV6HmjnK7kfwwjkvMn1BNHK43rcH9okfmX1GmNkjHl3oVL4Wu+PQy
	fUVZbVaIQRkTQ5KhbnVaF97biQ9sW78CStUAYl/wYt1U69KrIg0B1eCcIktHPEpw47b2krMc3sK
	IQ1TaaAk=
X-Received: by 2002:ac8:590a:0:b0:50b:4537:2e21 with SMTP id
 d75a77b69052e-50dd5c10684mr241979191cf.45.1776160683955; Tue, 14 Apr 2026
 02:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adkMqgP6QeBPgqP9@p100> <20260411052037.2013228-1-kuniyu@google.com>
 <20260411130958.70202bab@pumpkin> <49c05cd8-5ad0-4015-8f55-fed3416784bf@gmx.de>
 <20260414103633.4d5fe92a@pumpkin>
In-Reply-To: <20260414103633.4d5fe92a@pumpkin>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Apr 2026 02:57:52 -0700
X-Gm-Features: AQROBzD2w-k7YonaYKfDIbemD_J7tzVfxbt-N8Q_GrDjDbdtgzVEkik3UF74vmc
Message-ID: <CANn89iJv59ZEeaTCY28emRPr2LGAD42hukmLnYU-KfJJs052xQ@mail.gmail.com>
Subject: Re: [PATCH] net: Optimize flush calculation in inet_gro_receive()
To: David Laight <david.laight.linux@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Kuniyuki Iwashima <kuniyu@google.com>, deller@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, linux-kernel@vger.kernel.org, 
	linux-parisc@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 2:36=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:

> The network stack is supposed to ensure that all receive packets are
> aligned to that IP header is on a 4-byte boundary.
> This typically requires the ethernet receive buffer be 4n+2 aligned.
> Unfortunately there is some ethernet hardware that requires 4n aligned
> buffers (often on SoC devices with cpu that fault misaligned accesses).
> (Just writing two bytes of garbage before the frame solves the issue.)

This is mostly true, but depends on NET_IP_ALIGN,

On x86, this constant was changed to 0 back in 2010.

commit ea812ca1b06113597adcd8e70c0f84a413d97544
Author: Alexander Duyck <alexander.h.duyck@intel.com>
Date:   Tue Jun 29 18:38:00 2010 +0000

    x86: Align skb w/ start of cacheline on newer core 2/Xeon Arch
