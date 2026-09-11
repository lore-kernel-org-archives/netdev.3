Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1149F112
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141996; cv=pass; b=i1KQB7QEufGcQ2kRsACAJqEXokCvhSgUbKXtLWo0n7j40A5YpmEN5IkqRni4alO8+0SGHJjYXAgxuw/ZjMehE4HVNysmGvg23LpvIGKrF5iOgrvpomThbv5Cvnos8cdavfxOFmCBYBnfQPFlaB4usKHvwiK43LpwFzxaha9+CCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141996; c=relaxed/simple;
	bh=F39xQOImaxJK8CevVQCFMKOX+9LgzBRLUqk9ae5qoSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVwIL4Jy7THc1atk6fbSsKxJK0Q6bUx+fMEAtKlW4M0bcXhlbqvcrc4H2a10sKdWZwg/rkkhUSg6H0Im6IDYcL/9J/gvMB35VSMzIEKh9Dev2Ijk+u7OGZUNiIJHQonoqqjZZOrsVxfBVxDcbog1kFcTmQkffs2MyURfP6p0Dtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gs.ncku.edu.tw; spf=pass smtp.mailfrom=gs.ncku.edu.tw; dkim=pass (2048-bit key) header.d=gs-ncku-edu-tw.20251104.gappssmtp.com header.i=@gs-ncku-edu-tw.20251104.gappssmtp.com header.b=TU4HrLPr; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gs.ncku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gs.ncku.edu.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gs-ncku-edu-tw.20251104.gappssmtp.com header.i=@gs-ncku-edu-tw.20251104.gappssmtp.com header.b="TU4HrLPr"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so542319241.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789141993; cv=none;
        d=google.com; s=arc-20260327;
        b=YdSo69D1wGTEciDEGpRFbR7kYCyHr/wnauZre3l+ZnmuYuVyHc3hqWKYWcX5U+ruTx
         NAyeBqluz1dbZHXFN1xDb6tK1vxnKtvi2LhkSgkQ88TzMRSHgHEYB9Rx0x+xj5kid9B0
         EqJoY9A73zKlmXXX+CGV+iVq/33ZOQqVlWRbgZ4MRKYH1wzmNd3kJCbiJdPUkk2PhOS/
         SzgATnZyt7Omuq8nwQBRSu/ZYLehVtoMl8JuJy9vDkcgcBovrEij/zCLqE2DdfaJoQ9I
         rDoS+BKzes6fTVDeVKMeaV/am90Bpl27wcK+l9OY70krAOAc1xLgO33JlkvZ7PnxSXJQ
         v88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1vv7gvwFES7J25+C+0P5Z/9fMTwoyrVRDGhTkAbqC3U=;
        fh=j3UyXn6+WE1xk4UtUIyxD7sCMht2pmDOo/wu93LSAVk=;
        b=gBsCUYW96JROqQIKi23+38DJlJ7NhccnUcIn+qH3HAq4x81LgExZ45CzwkrWB1XXpz
         JzGRyhcw3DNeQG51m+ND7fIKE2IfLbTlBk9NfXt90xykBlyVf9iml4G8/m4fS5XpD6u6
         HhyIQDUdT1T5MNL+bFtw85rWvUu1jor++KIcSP3UbbuQP+5P5Mcb4qZNQt5LgKdp+3JG
         i9qjb9MOqP/fbkDAQVRA5g7dFninAIhyI+s2k2/Z/UFaSFFPkxuG52I8OriU27vYg6N1
         i04P5nDZZT8T6aBUlvvyFsOOiZRfSkBD9VAUdZeWlkoZLbzHQI0IabnKDWnucoJyS+da
         NSQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gs-ncku-edu-tw.20251104.gappssmtp.com; s=20251104; t=1789141993; x=1789746793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1vv7gvwFES7J25+C+0P5Z/9fMTwoyrVRDGhTkAbqC3U=;
        b=TU4HrLPrlHtlktUhdsoiWo4rdxP2ayY2q7G0lhCV1Z56O+wKgWF4FbO87/POWyQT3D
         8vSqisFEbSw/zy5/zznoZO9aPs3wdgHfatIQSbq0D7vNIU23WQ03BPbZfb2P4KzUPcVZ
         jicdK18YP44TNI8NRW8TZ+YRvIP1Trz4yUHbDZC6vL31fQA7aQ276LSSp7/pmYMADvNX
         CVh9hm+hcgw/5BKM2gB2t0+HRIdFIIMbdV5kOkSKPE3IsXVQrigE8FSD/7cQHyOIhjjB
         mL+tqNFTJtZp3JdOwh06TTvGwIme1kTcNfhwxXXKuJCavsyxm1AQtpLMj2U79iMCOO7D
         pjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141993; x=1789746793;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vv7gvwFES7J25+C+0P5Z/9fMTwoyrVRDGhTkAbqC3U=;
        b=iGGAKYOkATFMiYAD37eaAAtEkssoAucAuoMjXqKcYSYwaZDjdgWh6nIikI7PoC6vmW
         +vwO9bjZ6Rt7DkGVpOQEe8rCxLRdjCnlyxXHrAF/CPqLb3r2dK7jmle95owXtJndfZmn
         Ft3TAPHoCPS/3vMoj9VsYZRRkeJCHmADq4uKa2SFuAZHV6FoDS120c7lvfwTbXZ69QWq
         /BC31+8VZxqN2E4Jdum0WTDhyi/tg8FmKNrLa945mzP2fDdGGSEWsaw5IyXwcO9qnofM
         vrQ2xiTsdS51LGFBQUMgNVnXxgaDJm0DjICsq2n28WTfLL5WTSB5Jxwz7Le7IqzsogN4
         Wv8A==
X-Gm-Message-State: AFuF++lZlaCZonFM6wj6Tichv/AYlPQHLIX7XPY6oAs88JeXCcvI8bif
	YPCznoFdpLG91a+fgEMXnFohfPlMDJ8rlcLw+sKSoUPjaensVwtRXZi4fCopD+K1E4XVXgp9mlQ
	rcGM0ifTUzOBaSblxBeIE6e2qDxfXfazxUoqEjT/n7A==
X-Gm-Gg: AYBFou3Ut9XgJFN/UBis1T0dq56uIo76O4b1RLUhWl+xdMFouQ0/ooR+RamcdX4DYXx
	Gwjqoa0J7gtAGcATen2J0lSQqjoDM9ttC/OaFSo5rzUqEuB7vxs7Bj6dVb+UU0VPp1n1GqT0R4W
	imHb5MVUZvLGGAX6vKJ5/UnAjA9AfBYfrgWJizvOUVlxPa8HEZbaQA0NL8p3EDMI3QRSRc+Ujyh
	08MIE/LdQkpO/CLUOtYz+jREIhwz0ElMX4DbOACneTRxVizC7so4tOdN5gkYvkKLs2muKx2ra40
	yg6OdVHuIX05IGBFHRLlYoFhjHn60fN8mdIHPEDHGwUEKlX/i0x9G9zNzsXnRTAwU5KQFlXy1YH
	G4h0uhczoAUEx
X-Received: by 2002:a05:6122:3d0c:b0:5c6:5daf:52ea with SMTP id
 71dfb90a1353d-5c8462d0000mr7158736e0c.6.1789141993589; Fri, 11 Sep 2026
 08:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906145643.219609-1-f64116045@gs.ncku.edu.tw> <20260909180851.01488994@kernel.org>
In-Reply-To: <20260909180851.01488994@kernel.org>
From: =?UTF-8?B?RjY0MTE2MDQ16buDIOaclCBIVUFORyBTSFVP?= <f64116045@gs.ncku.edu.tw>
Date: Fri, 11 Sep 2026 23:53:00 +0800
X-Gm-Features: AcwNN1UWcuwxZCQR1n7msY-EQ_gz2d88U52Op93xGQ8dQ4m1tuBVPc8TQvU3y2o
Message-ID: <CAEqcOowoHcmjpU5Nub5k+YVV1tHb7oX9beoTLE25ho4t49LB6w@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: Add TCP payload verification to udpgso_bench_rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This new option is not exercised by any in-tree test.
> Do you have any special use case that needs it?
> Otherwise either its useful and in-tree tests should run it, or it's
> not useful and we shouldn't merge this patch either..

Thanks for the review. I've added an in-tree test to
udpgso_bench.sh that exercises TCP payload verification for
IPv4 and IPv6 and checks the receiver's exit status.

I'll include this test in v2.


Jakub Kicinski <kuba@kernel.org> =E6=96=BC 2026=E5=B9=B49=E6=9C=8810=E6=97=
=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sun,  6 Sep 2026 22:56:43 +0800 shuo huang wrote:
> > udpgso_bench_rx supports UDP payload verification but rejects the
> > combination of TCP and verification mode. Its TCP receive path discards
> > the payload, so it cannot check the data generated by udpgso_bench_tx.
> >
> > Read the TCP payload into a buffer when verification is requested
> > and check it against the transmitter's repeating alphabetic
> > pattern. Preserve the verification position across recv() calls
> > because TCP does not preserve send boundaries. Restart the pattern
> > at the payload length supplied with -l, matching the transmitter's
> > pattern restart on each message.
> >
> > Require a nonzero -l value for TCP verification and retain the existing
> > discard path when verification is disabled.
>
> This new option is not exercised by any in-tree test.
> Do you have any special use case that needs it?
> Otherwise either its useful and in-tree tests should run it, or it's
> not useful and we shouldn't merge this patch either..
> --
> pw-bot: cr
