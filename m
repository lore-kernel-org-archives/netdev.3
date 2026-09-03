Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93CB2D739C
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476907; cv=pass; b=H38ZttUjHxYbGFEx34AmZQCm/aP4ev11zyMY4ZIve/Rsd0XoQKeSJhhlt3tx8jTqPKioFbG1pr2/OEVD5gGEoqyB8aIigtnDJhh/LNgaVlrHyRFouKKAqC45IEnCNEcL8G5cAjcp5LwBF85pa+rC/9c+4o/06f4rEPzKU0SJz3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476907; c=relaxed/simple;
	bh=Wb9TAkDXFYbHz8snijznaejIApfm/5vhp43Oe2r6EEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNLwhzmT18E8ufNQS1QiJ26QLv1Pmbfbm1kFOgb1rrGIfTRKHJErgdfsVv0t0fkobPx8jOMRKm8MFEHY8fW8JJc92s0gpXhDa7IDgmNm4QNHQcwBC5NGZJiseJV+G9XS+psdKmbZgw5vQGQ+m+H8/62qOd6yuZsoEvJ0GX/iuxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+PXVt6w; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+PXVt6w"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66e64e6e3fbso372083d50.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 16:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788476905; cv=none;
        d=google.com; s=arc-20260327;
        b=OHThPpcc7DjsVUpBJ/g/itwOuMpgFzP1AeaL2A5FmrH3g8JURHhTXk09VfWUNtDyLb
         Waw7zLW/8W90mjWVGrI1WXuCc21A7nZckVThE4WcXE9r+yS3f6H7u1R2QNy3yPkX8vrU
         ZhN86z3kIkzseNjzxGJMW7fd7rwZv+hGfqNslBxOgM+SF3jfgYNbuDiE/TZtDvY3nUJL
         ij96dMAqsjir+0aixX3WBFfOKnEdl+rapowpaqGavj1qsxUf+OA13FvuCnb/2Rg4F/hx
         Dkf/6jV6evqirHHS9vDVjw+o3ahccOBxzpTh0ITc6ySVkzFlQxHX5AF+FUDyPK1Zrquv
         aX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wb9TAkDXFYbHz8snijznaejIApfm/5vhp43Oe2r6EEY=;
        fh=Tk97VL8I8eTwvYzb5nyYTNWyvrYim+Rx3AKID/gH4/Y=;
        b=gYIEckQQpMKDtu/XWYMlJ96baTNl9l2m4GXa2xwXxFYDhVZ90wLp83jpvMVllP7PRN
         6ACammRXh9VeFO9V5pPxFsz1+HZBqxa73sX+5fLh55Z5kkyOyzGsxjkdczJv5zi71F8c
         vfVWoj05CO0egz47pmDa89YG0BlVErkUyM9Lwp9V7GwVdgQ56d0b1Fyis0cH9C33J4Ps
         Vs4zc6MihraZEPrrFyxgojTwggseQXmGpMOW/ZAylb1Ko8SU0PazqcS1TS4bKkwfDdU0
         zoorZL3MIK1BJCVFR9JBX32TQInPM9rVoZqLRj33lGnR/IJnsjn0CY8YHBbUGDo8mAM7
         YVAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788476905; x=1789081705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wb9TAkDXFYbHz8snijznaejIApfm/5vhp43Oe2r6EEY=;
        b=Z+PXVt6wctJwEQtIMg/LvT2dfIC8gB2NzLJ1INKgwGyJJw0f0fDYdQR061Sn2yTddm
         eOFCnHSizz8hyt3FDvkag5hOZp45Pm9THO3HeK2w8Ri4LZ9O3T7mUM9tGQaxHcw4AS+9
         6ORwYqj+RF71TJzOoZaLD3XZr0IVgTTuEdjI4+0GJUCPfU5gUjJ7GLWJ5lS7lhtsSMs6
         kj8Vn945gsj/XLmPKGu3ZGNhFgejGqM55EaZNEB2aqvrHkUkXcFTdujOKoByJ+KMM9ti
         w0Ts0XRnsTWvRPejVVaq6xKuFaATCyA8a6iBUaoZPudlL1b/K7M/v0qz7q12d2rcwoGA
         N/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788476905; x=1789081705;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wb9TAkDXFYbHz8snijznaejIApfm/5vhp43Oe2r6EEY=;
        b=K4WAZANOwu/dGEWGoA0Na+1ZGr7HrW6EkgSaZR23XdfG9/q8KeVLcS2YnOqNj+kzvq
         lMg9VKnxt99wxgLNDac/H2pZpbSKvLzG5KoGB3UF0m0WyXBDwwc1PxDR7Mkyqpzn5V+0
         Mcl+ThaCEqYsWm166Mi3QSU5spjgURPktqZA1M/5zn0Y+1jpY2LEtDkyj/KhLxP4FRaS
         HsrTfQaEL5+lZfVHmQsFCeY1lNvWCDCpwmxroIsra92bge1S3+4p3JGXlui+l5jpnuuh
         V7vT6Z1Kfogz0SOp7dkeou5OwrsMqDmoK0LJXSnVBt33ojmDSMuUnRx5wsRa+uEhVn6H
         BsjA==
X-Forwarded-Encrypted: i=1; AKwUvByzSI+FeX2zJVFQMKMSqEveVH+ljNzzWCQBDi/GcT6fLfSpqycI+YZeMZEtX41aBNzliwB5Tm4=@vger.kernel.org
X-Gm-Message-State: AFuF++mMG/wpssjRhYTuQ7d969upJeBrvP1R3M9zB4ISXOsJ6gQEmJDs
	+vcGUkShAVRbJ9CamvIasV+jNVgFi06kfPlBFbw2h0f8/TCjFPUILoFV62LCEkjbnA90f6uI3a9
	KUFTE2b6j1OO5mSTvywW+w3ObIXDRcVzM6kv4l6ym
X-Gm-Gg: AYBFou1+N4XRijnnLR2PATGljCTiUrNw5knzMKok7xsAP5C9Wa6X05BJYdISy0GAQ8J
	PJYmO54zhWSUkvg+8l4kRHAMNVKbFCBbRvlKooX8gddDqumjBB0G/KCnyITC32XTjBN9PWZbn8C
	yRi+XRIGYqCz924d9ktqRPX0jgfbgiftWVT1ktAVlmnPQGOXmX1Tfg06Dnrqq5n85+nUdgjqwai
	SA3ej+DeSKRI2zDD7wbtOsKiCREvUehk6qQ1uwTUF4EBMlPsOcRtmRLIAYrDToeC5YxHdzOW6Ob
	r1RbtVwreeGGMxeYODA11wWla3mTekDkRRMy+V6HabtQ3uYuil36MFhEOjpeONsXLFnUUDnNuHz
	GEyGkvAy2xBrCoJ++2tYAQzmnIiPi8jgafW3fuc9UbCyhyq0NgD/dHGPVjQ==
X-Received: by 2002:a05:690e:2546:b0:66f:7c64:9d47 with SMTP id
 956f58d0204a3-66fb5a0145fmr581822d50.23.1788476904148; Thu, 03 Sep 2026
 16:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903221154.3359889-1-kuba@kernel.org>
In-Reply-To: <20260903221154.3359889-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Sep 2026 01:08:11 +0200
X-Gm-Features: AcwNN1XgOOlkD6IjYqQcX9yRWJhIU1ldziRRdTxsQH2MEwTOdFnDdwMT2IMxI68
Message-ID: <CANn89iKQN1i1XswLUpvc-gHQLQAz+qqOSB1g-YCKo1UaYDnM3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3] netdev: avoid skipping objects on race with
 device disappearance
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 12:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> If the currently dumped device disappears while we were mid-dump
> we will get the next device without resetting the sub-object ID.
> This is quite unlikely, it was reported by an AI tool not a real
> user. Let's fix it for better dump consistency.
>
> We only intend to cover the case where device A disappears
> and we skip over sub-objects of device B which was stable (B existed
> before and after the dump). We don't intend to provide stable
> results for any device that gets created or deleted during
> the dump.

SGTM. Note an ifindex can be reused by a new device, we might need to
add a dev->dev_cookie
(64bit unique number) like we have for sockets and netns to also catch
this in the future.

Reviewed-by: Eric Dumazet <edumazet@google.com>
