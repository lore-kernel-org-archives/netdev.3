Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0ED3806D6
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013057; cv=pass; b=Htai+n7OVA8/2XreliIbLSlMuCLpDP0tFBwwZjnxAZiVLeq1pVrtcjdDC9y3mFl9h4dQAb++hOnOh01lhWtm8eH1lzT2WFlrsXht6K8rq0YM9qeJhxf+TO4W58UlMh+gTmCA7ReBl4UrzfJN5TAfaAcRBgmtjnuZJ2kTXLaBi0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013057; c=relaxed/simple;
	bh=l/EAaO5OOE4PvdFfUPVYr/0nOobA9KoQhMRWAD/2oro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6+PXQJflJkt8+YVIjFJbNHome9bIDezz+c1WRt5eb9iXtEoLJ1TN0J33D2ijiR0SbCIFe9sXPNZoO3ZT7dF3hb+Wqt95Nwx+dzzYV++N2bRV09HlpWvHaipciuQZ3gK4num2Hn7snQPGS4i7MQL86u03LhUsmjiT+Dev1fpwGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBDAHhO7; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBDAHhO7"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b899413537so1527214e87.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 21:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789013054; cv=none;
        d=google.com; s=arc-20260327;
        b=OtQW7QzrQiy39kSdsTTW390BTKWrVsGaTMA7BOgHF8kUl9FuZ3Z5kaRGAP2IdRhG43
         iumZOhRFPLIHTsJe5QWKOTD9XYY9hen9Hh+R2D0/T23RJFLYt70ODMaTXJ2UjWMIYP7O
         ieHecfiJEjgdXDFCKZTzZUSFap+iiElc+vpdU6LCOgGmSZhhztTY3hHxxQl0HBpvA/Rg
         q6/g+6dH7TJSXL4kc33XXMHPnAIJtnZQGFZH2SadQjq8PHKvRwiq3NJm01JdobRtnnV1
         gxQdlE6YoK9amlKohFY1rmhu3wbuJgS7l8BZEeeCqAs/1WpfBOXud8kVVL8GiwU777Dm
         ERVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l/EAaO5OOE4PvdFfUPVYr/0nOobA9KoQhMRWAD/2oro=;
        fh=cmal+sq4pwXYOBS2k3ajZTPe2O13Wxh7UF38zYkMzR0=;
        b=H7UKyIO6qThYf31dAcG4HVbd6rOeFJuusa1OsuVZSCtKIKPa7Mo2+JwmNzp5mD5fVo
         1jtmoq3OYA46Dwvy09fcYpteTaVjLuStDIYAJAlAY4IAaklycVmZt/qhrbKYQgypBxYb
         W69g2nlKbSJwWD9MV9g3IXo2LXMRweHd2Zg4rv6hLjbO9HpVbZXHAeis1ePWNG25qEsm
         oXvtYYs+lQpVq6fJmIx4B5Eg88/AMG/Jb5LAhylG4jkokpIn1WHm5R0cIZg2Xwe5vVe4
         dlkEzUEJNJy1sOnTQR8fx7m4MDCAfllJPfVWEpsO0SwmnfZm1T6S3u/22gM1bhFz4xfA
         aBgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789013054; x=1789617854; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/EAaO5OOE4PvdFfUPVYr/0nOobA9KoQhMRWAD/2oro=;
        b=eBDAHhO7SNBvUTl9gFLG2JawKkSkcw8t2NhHylZLkuZ8xcTxvUpyBM6OvS3q72aA7v
         OBYn9g/5fJAD37HfiLmEybbkUafRLd4mDD6Y5XMHKWwwY805d9OIaOvUsVrCqCyy6UmZ
         eM9TnrkeLzDjb0TaDz9S8PdGMxV5uP62S86oJvzR7ayNQc9kWHmHcmZ+Oq8c5sS0eTnQ
         ib5qCZluqH6NQtxJnybP25yCvSt/eV7fEsUT9hIENgqR3ZS+FlKYTSiJhrlJ3ArfNOrV
         OgqrMwq9L2n0boVozthUUOC3Qi4E8uxEGAB8NBCJx1qlGXC8CWansOjed3LDRmyIbZw5
         qjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789013054; x=1789617854;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l/EAaO5OOE4PvdFfUPVYr/0nOobA9KoQhMRWAD/2oro=;
        b=mz4KPXnEwlCtqRImzHUbnxGNOGSF8ow6p3/UkhW/2eXp0rPdg1Bxm5Xob3TgUU2Bmf
         WxSFKOH++I82cpGfruOMzDsFnyKx4yojkvsb1/eNa9nQePzA+j5QWyfyUaWiwzCJbe/b
         XoFMNvckrsD1GN2NHyIrMSjJ5XSY9lux4my9Qd1QMUEzpd0MNOkepOasQSkYpWCTEpGt
         XaadHQ748nZy3RNSNimZlnTByXRfD/peA2LIOEKEfLausFV3nN8IJFywcoPTX35uwwc6
         r51leOxnMUhtfrI7KXm+TV9vtGr2FKSsDjrWvQh7iIqXb3+Wtezs6udhT7nVTinG+Aor
         7TkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwD0V+F3HDsNJA5lf8kcIi08RF+nI4wwfwdy9VhjrI4FssVA4n7z5LLcHLjG8atAkfFZIWsgUg=@vger.kernel.org
X-Gm-Message-State: AFuF++kIKJ9//S07muFrTnvUzq2AC1q7RuMvdIPJa0f8vpbdC90J8jLG
	H3rEH1PpZuFhn9514JpHSAIobs/bykeXOVIiN4olQK0u/nKmBxkpKcytz0LAuXKTFuI2WKppAPh
	Ygv8a/ATalYULGN2BbJchuQXYMa0NKhU=
X-Gm-Gg: AYBFou046scULCJe9tfbdzfteQzA+JZeQS0Lb7HOwtfZ70lpVuFHMI3CezZonSIXfjn
	rbxQYxzERRcAo8d1/cdOrz0Zn1uR6Zh07B16O8c/zKih8BURY0KYkEnHNRsYlz5UxloHzPiXcJq
	Uke/ltmc/MS0CxXrAoGpS5WXWpMNgzraGFdSQPMABNWpLhJtVb+W+bDRMMD27vMks0F4+Uq2PMh
	h1d2lx2jvA3iBE//7pGzhKq88fclNjRpZGtyAgu4enP6G2nSF8rfuuScYZVcOKbWeX5+XLVxZAh
	u2DhdrdR4MG593CH2wNrhWntZeLqDWR6WleGLuRhDK1aCWX219ZB7kN8zjW64im2H9pl5wJds/S
	X2gRVYaON/Gd9Wtr4pQJKSc7hmbldTi6BEmUJqWMSjg==
X-Received: by 2002:a05:6512:2c98:b0:5b6:1883:b1ab with SMTP id
 2adb3069b0e04-5b8981081f8mr1128634e87.40.1789013053655; Wed, 09 Sep 2026
 21:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905093932.43726-2-sigefriedhyy@gmail.com> <178901169340.219967.5720246601361596190@kernel.org>
In-Reply-To: <178901169340.219967.5720246601361596190@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Thu, 10 Sep 2026 13:04:02 +0900
X-Gm-Features: AcwNN1UzE9U2hCIXKFIf4HaPYtniZ-QsUnDUKbE5iwtT7QXVPA8oUnZsDwBc8hM
Message-ID: <CA+7S2vJN-Qg2PuonpuJBrZBpVib6R7=k9Qmx2dFBG-1Dm8niSw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] rtnetlink: add AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, donald.hunter@gmail.com, 
	edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, kuniyu@google.com, 
	nickgarlis@gmail.com, pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, 
	horms@kernel.org, sdf.kernel@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The comment in this sashiko round is on an old patchset. I think the
following comment is worth fixing.

> Should ctx->addr_idx be reset when the resumed ifindex does not
> match the recorded one?

Good catch, yes. I'll reset it in v4 when the resumed device is not
the one the dump stopped at. inet_dump_addr() has the same issue with
ip_idx, I'll send a separate fix for it.
