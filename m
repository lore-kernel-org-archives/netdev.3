Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B73DDDB3
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171468; cv=pass; b=nbpG7IDQ3PilTrjOjq2cljP9lGl2aPj6gRE5HT0BVIGMXNCtbxepbqUfdfHC2DdCS8QY7gTvVG54S4RUaj7YXwU5mfXMDa8qjj047CIe+oBdN1GAGNMwd77jAkJaLRYv+FXLkn1XPWmtG1KvAaZuelwX33nXY6ooK6Zvy52ZP3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171468; c=relaxed/simple;
	bh=VQTKDVvDsPr390eFVd0RHXRO8Y8hCAK6QWLmr2wqQ7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoV3EKV7rCVvdmxFi/WC0IRTeWbpz+PfWIDWZFiXYNreYpECBpMBw6MUvYAvVIVUrhs1tpWQjjYuOn2p+icGFd2cNr3urkO/A5SrW45+H4gsl6nCG+e3+rnpY2UoD59eNsxreYQ5Hs2xNxeLbKU8XEOCdz8P+Ru151L/kocSu+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6uVSgGH; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6uVSgGH"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so2462492a91.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 03:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788171466; cv=none;
        d=google.com; s=arc-20260327;
        b=WgR5eicy6LsVoIgoJFGCygUHNuFtUSrCX7CCD7/elasgxt1s/9p+s70tI6BZJC+eil
         27oJWEtEwy9PhCNx0WcXBanG5q8eOAY0W8E844SsFbnhW6WOUMv2Dx1SYoMsZkrzSFY0
         2pdKGv0JyuXr+CnAzl+U7NtEuv1QMxV9/4Jc3boqsMB570A4D+ekDjX2t4WVIJrfa6LC
         Yyi4g1vOKx0CDp56CmEeWTACS1lYnzEB9zVX6t0gTSD6NGoBMT0lFapWxk7p0GINBQrB
         rKjpYRWcAv8+lLAmKVglboEUW3/32fX/yfEk+daoKEHjW883tyiALi7rOotCLm4IpYMZ
         Qm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VQTKDVvDsPr390eFVd0RHXRO8Y8hCAK6QWLmr2wqQ7Y=;
        fh=G6KHxwj5mrQlplOYyolUyBjU3A7oX2eCS7OxxHrIUkg=;
        b=ApfjFXM44Ru0yhVFrgCazl0sdiRGSDI0WQyrvWY8BlUVJheQsHWIq8Dl1SZaUserwY
         hZTCWgVPGVU0nmF7CMwfLeybILfNtI0hESwE5pgaFCZ5CKoWWVvzCwO6W0+upZlWrT2x
         bMbqigthJvVSevQHHSirKBXnboIf3bOTsHeth6MZ+qXRtwPoXE9xlkLHIQaVYetzHSa5
         YD5Ew9iUrunqxESZf09RVaqu+bw8C2QzXC8Gua+4XeBsSZFfIYRjCNlI05blcoiKFRFy
         IFvJ70N3MWIiV+AdVu2GvJs881vzRqatX7HxU911R8zLWLZinV9BRnuYG+wt00+ljnEM
         daMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788171466; x=1788776266; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQTKDVvDsPr390eFVd0RHXRO8Y8hCAK6QWLmr2wqQ7Y=;
        b=l6uVSgGHY9iXDSF8e0gSr5kBC/MoxoQLUSG2E+KoV52eFLiYZLlktd8flapMN3/VUv
         deG+OLycvtSjQmiOwZSL6CEqIOUfuolO7EeRx0wZYhbH0rnQfDtQIsKuwL7LgAWdi5o+
         p4m4FDvXkWB6yFBqbr4+dBauRAear47wT2pnPQkX5ZHokk9dPUaIvQiN4OA/6C0S2n7f
         l+dg+X67PD9DN+g+N/UDW9YE5aAaAu2yKBNPLA/rNXSXSMHM0yyzn6Y+ylwnXqCCOl4L
         bJqdq0lxyqeKYTcKZoTycDu0OaraEYgpgY6PobIGpunABv55dmFp4OWchtX0Al1Yvs7N
         df7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788171466; x=1788776266;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VQTKDVvDsPr390eFVd0RHXRO8Y8hCAK6QWLmr2wqQ7Y=;
        b=NEqqn5D8SbpYzXrWa/OuOFtZ307ruMBvGUV5+2Yu0kjSjHLR/UA47Qz1fohIM/STL1
         QScvmeaS4jzIlGhAh36cIWo00rNNWl2xJ+OZzkwIAEfFedFk2EA4EqQ/MVu8ANuB6sba
         UUW+bAepBGyqTq5WyArlANNCc7UmfAVsrQy29daak7C6rZuiRcde0osMxof2B+OecElw
         g9o9/LL6GoOWozsJI8nY+NbYQ7WR/HlNPa/BAfskCY3s3oT5Mjvfecra6IWMXiL6uD4b
         PcUsmUdUx8FPW/dKK/EF093Yuz33p92lgpz/A40hHl6tSBniYZH7p+vz8wAGHpjOwX9M
         yEyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlXvLVjzSazNWhRN+4ux4M2Uo316usmfeerJcgZnPnM/1HvUT/4EJppmogijlIRGYyLumzzuY=@vger.kernel.org
X-Gm-Message-State: AFuF++mZSv2fgp2V4VHMfGAJ4JUfdZMzdmnguAuhlZPr7afOST9HR6Fr
	p0dahMtog54NOUt9lYHLg/erEZYgfmUpMTcbsN4S849GE05sfEVt+kW9Q2S/VcCbUamrCM9Ywne
	islRrRdfmY434NMf/g/imhYOR/gD2De0=
X-Gm-Gg: AYBFou3QbuL62caQO8hgG7ywSnA+/nBM/W14ybjsz1kJxEWJ8LcTScNO1b63EpJeB4w
	vVdV/Me0snxu8wOPbQaTT9ytIWp1sm8KHGAMHqNU/1tPJXhOUhetNE9uAXmHx0rmBT8J/U0yzBm
	Hd7saaDClJNlU1hEZKZbu11TTY6XcGPCe5fujV2B37iHA/83tNZ2jJGNiK+2Br/8jlwnPISsoG2
	tr+706TzBY347FfBB2Yrj3eUewMGqqMeGVvrglCfZbmEuU+1hWQML6rdIzZKIap7JgHtt7QVuzV
	Zi6Impw/0hMKgEdLh3bFOxIj+zVGHVYMan5w5KkcoCqGAA==
X-Received: by 2002:a17:90a:e70c:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-398f86c8470mr3621002a91.21.1788171466470; Mon, 31 Aug 2026
 03:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831085217.391-1-strst.gs@gmail.com> <CAOiHx=md28_BmsDOsNDp0XbUpfih=P+-+aDYb6tiWPJTCu1drg@mail.gmail.com>
In-Reply-To: <CAOiHx=md28_BmsDOsNDp0XbUpfih=P+-+aDYb6tiWPJTCu1drg@mail.gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Mon, 31 Aug 2026 13:17:35 +0300
X-Gm-Features: AcwNN1WvGkdBpsPub4-3MErmFB3mqxt43hKt4ol6YxN8L_iUqUyc5DLBohOg7uM
Message-ID: <CAAsRjRktqEx+-CLDO_q6rLUBe1dtRQPH1NkX4xy7ichx79yGPQ@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] net: dsa: b53: fix 8021q uppers on standalone ports
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

On Mon, Aug 31, 2026 at 12:34 PM Jonas Gorski <jonas.gorski@gmail.com> wrote:
> I really think we should just fix up the in-tree device trees and then
> complain loudly about the broken configuration on probe in case there
> are out of tree device trees with the broken configuration.

I agree, fixing this up in the device tree is the more robust way.
In the meantime OpenWrt can carry these patches as a band aid for
the affected boards.

Best regards,
Semih
