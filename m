Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE13B6C05
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532508; cv=pass; b=KNzs3wYkKJQJbt0EvgeqA++kkONiXg+FJ7xUbPbu5txpfv1SJKVWC0fmtcelZTiRcKEKIEjlqVrQD32L0qUGIBOY1BHnA59/UKZSNv96IsL1NUh/l1QMf0ZcHy+3hqEHKuXt3LjUE/aNTCi9FfWvTyNXJd3Ed9UMt9iMC2C9lFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532508; c=relaxed/simple;
	bh=zOameGH6/OEUoKK6HYEkXmK9tvcudG/mqRanKrPNPYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZvgePWEdXs+UZtGZk6AHZVcLOSDVBOB1sCbTFcWY0zREJse966EZr/cDCg97FQvHPgiBgntdik+ADV5scQfOrKb1v4LuFiJ78osTUUgdVDIncu2V43j/FYv5vkIBt3fxNrKpixzw85p9SViicB5ZhLJ44svcOexIq9Grw6Asro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSZhYZ4m; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSZhYZ4m"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so854795066b.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 00:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784532503; cv=none;
        d=google.com; s=arc-20260327;
        b=hqpaPUdDxVazP56JdOkXy194EZVALOYcwAkcbQJCurqR/D9VAiuB2TqL2BHzr9Jb9k
         vwFLXtdlyq2DHhH0aGxfsjbIUeMYSJb6a6GeewgV64BbuphNgGlzNLPKSUaSNW/awQg5
         747n2kLz3AR9t729U0HURke3pRTneEn93PmC3AZKb8URmbA0pBuXgUvBYVKYJlksb/10
         q6bijH9NM6to1k3jXSDEC4WtxtftocWNpwbP8JAJFOGPlO9OKDJHAFdmSMp5kRbbgHCZ
         qsw6yd1WYc+A0tLRncMuK4BeVzeD51EYGaMqTa+kQ77VdjY5Uizzh95FIFtqWswvT9FQ
         +Ung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zOameGH6/OEUoKK6HYEkXmK9tvcudG/mqRanKrPNPYk=;
        fh=Ke41lnSIYIRB+2dUMQ4Lmy6OE5ZZl6Pcd66v+S/OTJ4=;
        b=DoLHGogdTxfguTuDpDB61mVNQpJIHj4J1E6BGTtSHpzMxI+PL9tiDw0XCJeKg/MibW
         J/EpNMtUOzldDwgJJmguPTIpU8Fd9OnCDDAWwwosH0Ib6FH15SfoJIJNikmxw4pv10FF
         x/+59M8yXB7uTChmwp4yyv9jxZ7GiSPMijevq7YwcBRjkvLcBLXOeVe+NjpA3ab9BZyB
         En4/tW6mGYdYpLDca3I5nuWRJsOQ3e83PjvzEI2hS8bJ+YpIH62fb0Sfob1B6tykhTEn
         CEfim+8HjxUg3XLwcI89oW61cz6pL+e2y9HwSrAAkmq7dTjULwd/PPFtUBxq2aUL3SpM
         Usuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532503; x=1785137303; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOameGH6/OEUoKK6HYEkXmK9tvcudG/mqRanKrPNPYk=;
        b=eSZhYZ4m3jBCtBwUTKeANz6SZCrnZJlwTCX5Ac030souiE5H0Ok7NmkJY0rmfVFGyI
         GmKlq5tkb+ogFqkFTKC5gpX/jhF14g7UblOYJH94Pf87FHBYzYoxYxmRAcsYKRPuagtQ
         fwnnBcDmJzzQ1RWE66Qua7zD6e/eJ8QH5mGExohXybQHtQAkHHc1d6wB+UhhLZe7ETOX
         o4UIosLgxFuXoKHkbLQzbXb7V7To0nszsmqLz1CUxxMIT9jSL+/JeDpzbCWq/xjYxsPN
         DrlzSwrvLHmAOOYw01ezfsu/2sZ27n4uhpQQd4uzR9LR2fYPGFVSQezStg4qjuKovUrf
         FBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532503; x=1785137303;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zOameGH6/OEUoKK6HYEkXmK9tvcudG/mqRanKrPNPYk=;
        b=eZ1SkTfmC2WMBk6Sab20uU91EWeiv727y5nSToHNSP2g7AovZpnMs4sk8lqeFQGEM5
         F8eTihcCjtZt1m7WYwxF6CoPNB+tBjDghOdpvf5QbDHTdlhebIf5QfPGPgv8hB28Ppdm
         7U3GOunzVn63Ii0mikdikcyPCtfpSqbRJg2fOMXAra7TzO0yiqNi3NmqOTvhS8gfinvx
         SxDBR+bbFjQhY+w/PURGFddgJYOKAywb7tYuwWtms8/xptoO3NllLLi/m6RDEu6rgdvZ
         6kLDsDmtSJLl3G5WhJnc/UJUPoJra3LPoGNgAhX3rDoBOjoIg6Y6qpn/bFO4Jm4RKE9X
         SOhQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgIX4TpCAuVy++1xEfUYF2ri1bPaaMPKIg/U7wYEmFJVRU6EiKUmv9PNSQ+cKINKcQz6r/t5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5olqRqvJPT3+sU8yH2/vtoPzZwLASDDhea0cs9/gJXfddrOG
	jub++472FGtW2o8kZ7JkGueV3ZZ1ourmeJkXa6cD1eeO8aRClNtxuq5N630myVZIVC2UsFtTPIZ
	iyJRfMX+0sGH1oVZc/4dw+XnJrXH/4iw=
X-Gm-Gg: AfdE7cnL1j8sN74eCJe5/yhdxL3ZrRb4YtEAKsacN1kI+AIdeCwKFQBHidTiXq0xVRs
	Ugs+pav0jQiUKJ3mVY5zI2E01aoPxr57QsXJsuho1XHfFTky4T7xLnd4hlhgYtJm1A9llAF7LNK
	gNa0JrrAaaO/bPoTxMGv8SJIKvfWtMH2krjl1qSTX7I69wFyb+6JZ7z7/l4wyVTf603Tw4A8oAh
	sc17C/tB+jVvRpMRMufaT4zwOix9UiA+M/oVFEZ5FCMlsf4POvWlWSRqNjP
X-Received: by 2002:a17:906:9f86:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c16b46caaa0mr412710966b.9.1784532502689; Mon, 20 Jul 2026
 00:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708042244.120898-1-running910@gmail.com>
In-Reply-To: <20260708042244.120898-1-running910@gmail.com>
From: Zhixing Chen <running910@gmail.com>
Date: Mon, 20 Jul 2026 15:28:09 +0800
X-Gm-Features: AUfX_mwe82m4YG-3igmBeLL6jF_Dk9YtmsmD-ZDr6CUc2kXzqFMRk5PklqZl9K4
Message-ID: <CAMyuFdVWgvx4yafBQfbTt4Do535p3PF0LCpZ6Gma0WZ-De2kyA@mail.gmail.com>
Subject: Re: [PATCH net v3] gtp: parse extension headers before reading inner protocol
To: Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Pablo,

Gentle ping on this v3, in case it fell through the cracks.

It refetches the GTP header after pskb_may_pull() before checking the
extension-header flag, as you pointed out on v2.

Thanks,
Zhixing
