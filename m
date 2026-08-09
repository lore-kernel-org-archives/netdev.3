Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA84371889
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786270969; cv=pass; b=Evrh0DwASbu76dpBw2OinQ56pqThiPiXfFJ86Wei905A7cvZCCt7qhr9nOQ/8pvCUyRqdmCy/991u7Xa5tUK8KLMPmKvshthgnp701l4LzcKhzYTWajx34an3gScKdnI2aqmbHdJi7vJklRGSX/vJo2X/ySgmZ27rjRN7NNXrQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786270969; c=relaxed/simple;
	bh=e/JvLH6jpYx1zGCchMIEieNYvZrtfJh13sPXu9HcvOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeOv0NSESaJ7F7itvgzHlXJYIBIEK1eii7JgetStXKVu5hr7Zxrqs9KGJvPO8bj/abtV+t86MBbykRMPYdVQb5Y0b4FqO62MFUsRb6ngEuUWCqJ5td/FZPDqzgN6qZ8u889rVNoHHz9xlSmukSm9Dh3ySNr23EihzgXF5/XdCHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvD05OCS; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvD05OCS"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dcbade417so866320a91.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 03:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786270968; cv=none;
        d=google.com; s=arc-20260327;
        b=gZfR8pMD4Qs8gG58bH5y5QEcXRZ4FgafBwc1e3R0lu5Punx+Xse1l5TPxzKgUyroXq
         gjXSc0Q+F3+0XVDdKHNM/lp7aEYQsM0cD1uH+Jpyl/v1jTkcVfi6gV31G/ciWCxqW0v5
         qkDTUkH2qujL7CY/bFAKyPuof1udNZClrKf9eeBq4sMMh6tePy61UlqK9eP5ZftzrOWJ
         Xw8XIDcARpKOgySH451BuZygbzUTcbhaibKpUqddhBZTvIylawhviZn4IayAPLANgBtu
         2daPiGSdl1sTk62kC5MbJ/07S0vfmlzu9Ny6Obj4pkDyh2Bc5U/Rx/UFlknANsiAXARg
         eFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e/JvLH6jpYx1zGCchMIEieNYvZrtfJh13sPXu9HcvOU=;
        fh=f05ynX1KCZ5ehr3BhzyrJ4SpWJM/aAiuw/wr1RxJARg=;
        b=hklUm/OGH8pXeC4Ib/fkTyoEcQHp56OQsJ2YVL58dAFortEpQcasmzpdm0YhSWXuoc
         5DdGqVeCflp1tR/ireDvQp3SK6KKuCauGSwaCuczcFG0GeNGDCPs6iV1d+lVB4DBQVFn
         qc2qfwW8SeG2KjImQz6z7c5Mo6OYVM1EhHLFcObTdi/sGu1yY6Ow2c8T7kVGZpu6Zx+j
         q3t8zrxkY7jjEy4z9J9bP98BKJHf4SYSCuYCvuUKNxRgyPZsHX6aQkDoPiS1ZUFamMVh
         WYStuvNQK4QC1sR/V+u77Db8dyqmENXklYSd8qAFiXedMLZ0+tVGT1NwzgIaO+KcQVYi
         PxYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786270968; x=1786875768; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e/JvLH6jpYx1zGCchMIEieNYvZrtfJh13sPXu9HcvOU=;
        b=kvD05OCSUOzdjp5e0XbaFOx4X6wy4pZjfsfkP53cQ6vWtXMdl2wgRRRSFGpMEs9vA2
         thVvWTzD5vwWiZk8MpCsetKQr/B1WHFQIPjjnRhvoIBF/7M4czrWF185HedLO6NbmrmZ
         99GlUHSGFeRCjm1W/PmulSZFicmtgDGwEAn/O3emc5PX+1dBE8yFGo08mJjfusYO7Len
         HTRQtLA6/JwOyKeIHamqPK/BIf1Labvs+KrCMTTAo2CJ5rhd8OJXmINd3/gtBdlAp/o0
         0yltIna9LZKZ7UdUn/h8MpGUZWjKaLo8w6zhG65bZqkAHewTlkxVI2hJgJJyExDFowic
         iVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786270968; x=1786875768;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e/JvLH6jpYx1zGCchMIEieNYvZrtfJh13sPXu9HcvOU=;
        b=ZLOr7tjlszKFKgqbH+FGwrsLck8GY3MBOsTuOkndD/uYyriinRwGdNebHy/QlZ4PGh
         X7nie2UXJTnRk6K9ahKh+0pHus4bQSSb0/GK8htPclEqIZCpyhmDPv+dkfT9RDq8b0WX
         mIiZfegDBcSOcfnoP8lr7tGBB4gJUvG2ps3wjeCA2tc7AIiscQtwn/n7hZtepiwW0+BX
         CxmmPpGJgl+AB8a+ZP0mC4ELKnWPzlYroeTLLs3+RTIIezehrmAfBiWouT1XA9ljV94w
         s20BNA4Tt9TN5hHo1WmyuIOeIzCC4wowZSB3albh4ZbH6ohoH5tKA9bijKNE6bsBoRPt
         aiHA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4LKe0XDM5B1j6ZRt6MJCDM6JXsLQDS2IQjjS+9CxcagN6KqsM4kqAnNDmuxFLsyRGZqSzVzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9BkYl9Xbxl5eWujyxdOrcg4HzsChMHsHDKkWCaWml1DUl3/QB
	BqtJ3Ay/xL9DPAdNgXa8ULvVDgXTtVtYS5/0v8hQsLUhWxJG1bx2jAc32Hk24KasgwbchkvWZQy
	AQvVu1ZjFg5YZB/+6ZY15lVf7THSGF8lorXyUPNA=
X-Gm-Gg: AR+sD10WZnoV6p1d62G2GQMxOkHJJJqJNhsOqixId8i5bhhKM0AxpG5dsvOI0nyffq1
	5jL6NBW7LrRpwX4w6Pl/H1PG3Jtoxez+550k7UgU2O7fnl6aQh/cP6s91McH8lI5+whmt98eOYj
	v88O4coOlGM7TeFZLNG+61T9gBI8nTxSYLUuscpPlZB2uwvSgcXG9jmX3o4pdWinTbaGE4JVyVh
	dy4XUryT3dfizjV0QJTJhTRdlnng6bK6pVYUfQgTD1BUipYYw2ZmbJ5/K8BZzwJYM2MLPQHsa4f
	M966X8ynk4vz4p+XA9qNF8d6+vQLM9ybIW86hv1QvFg9NQVJAm9e+loRQQ==
X-Received: by 2002:a17:90b:5244:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-3903c5b685bmr33853201a91.16.1786270967895; Sun, 09 Aug 2026
 03:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809093934.28098-1-zajec5@gmail.com>
In-Reply-To: <20260809093934.28098-1-zajec5@gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Sun, 9 Aug 2026 13:22:36 +0300
X-Gm-Features: AUfX_myh7q16v7xxRJSpvNHInaxVLCmoj-FFtPZ3KmF-USlHk8XIdHKxaJS6W_U
Message-ID: <CAAsRjRn6Jji6x=8KcSPviN9KAWX6sUaf7jEvruF_s_3pyOdmEQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: skip EAP mode setup on Northstar SoCs
 when using port 5 or 7
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"

Tested on an Asus RT-N18U (BCM53011 rev 5, CPU port 5). A build with
4227ea91e265 active and no workaround reproduces the regression: a
standalone port stops receiving entirely while its egress keeps working.
Untagged traffic on the wan port counted 9 frames out, all 9 arrived at
the peer, and 0 came back in. With this patch on the same build the port
receives again, untagged and tagged both, and the "skipping EAP setup
because of not using CPU port 8" line appears exactly once in dmesg.

Note on the setup: both builds also included my pending b53 standalone
VLAN series, the same on both sides, so the only difference between them
is this patch. The tagged test passes only because that series is
present; on plain mainline the tagged direction still fails for the
unrelated reason that series addresses. The untagged result does not
involve the series and shows this patch's effect on its own.

Tested-by: Semih Baskan <strst.gs@gmail.com>
