Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90934366074
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788734597; cv=none; b=mpaax2vId0Zg7qVsxHWKKexLzXDSBvZTwpecHJ26CrDbVzEQE9mK5Xggw0jRI0ibQozRYT1KxhFU9Mk98EAxpad5ZUEYcTizNEO5Ik8gW+rv744kphUz5gpY+SiBphkaS6Gcacu/Y6IdJMn/04bCFT5HrXmU6fA+7QeAkkkNlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788734597; c=relaxed/simple;
	bh=Pcq/yHXyY2gKEUlDt6j/YkWYa/p2zEQafAqOu3/IQao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZtb8PPjbNh5Tc8KH1plsrv/OMZ34xqhX610KeUlQL61s1dKuXDViW9bZYhE6ovCc2RU71UvfUGtriZtPOP7/+EtkpWnoxifbjPyAUM/kwxE+275wrc1Je9XeWYgo2AatDJZERwOqTQQUlcFLUXlx9mF/bQ3ZS/ww0fVj9h2juU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtdiaAPH; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtdiaAPH"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c95395230so26879581fa.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788734593; x=1789339393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8mHFwNZadgFReOS4MygTWKIVF3yi/nmwidj8kYpqc8=;
        b=rtdiaAPHXkzGrEC7bzm0KI1x0xlsTsX3Vqd39qIjkZYq3oD36IG1uG/7YT4Fccbkob
         oTDNH4px3h2ECyFOc5AiPj2igMyT4S5va3lqOwXd2ODt0WuNC2hfRSWKEUrqSyirUMHN
         4RsXvD/JclO4SNaEiavWR5CjaIDjx+YnKywZ1f6iP4Swg2nwoJuF9ODQsmJJCOJKNuE9
         xzJPVrUcrt7caoF265vcvm+wIHi2tHl3OFvysgLrZDy7K7lqFzjawEFl1aoB69B0k44S
         ZqP4ilvIM8vZiRVeebhXmDCB7uhxV3dmMCNwAwhBEWIpH7+A/y64o34EtfoHURsMLXyX
         H20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788734593; x=1789339393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g8mHFwNZadgFReOS4MygTWKIVF3yi/nmwidj8kYpqc8=;
        b=gUApJ29lmgyCK1HzdvvSvIEEMO5oTx1aMq6tprurZN0DnKe7XUMyOYcM93g/oT62gQ
         5rov6+bAREQMajQT5MHKoymAAt/TFyyek4m7SztxVsx2k+wdzbhywz1tAPpIXsmKOPrd
         HBsx1fED14Grhj2+rvCCLk8vxaK5hXZc1nAht6QE7ZZsKWj0FO5w/i40INOuxeZAUKbM
         nOM1eYuXSjc0Fdneqp/yyfya8hK8iaOXI9CRGPz0BupEHmtkt9vGzaeKqKAqCQ93Lmkp
         SF3cUGgYhrvlL/cBxUFhTLo8vBI0rRScG67fVX4zijrx/ZnKqHHjMkZVAM+xsAO+tz+H
         /5PQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFoGbL+fuFsg6d9JP04IB2HGTefkqSo9jgHqluG7h28a0rvebOc+0rsT/I2ygkHFGYZPy88uk=@vger.kernel.org
X-Gm-Message-State: AFuF++m6yyCeGZ6wXQq8qKHOd6Q/7dMUgoPkpszK5yVM/njvQyjmXW+Z
	zZWbvW8V3LXE9F9BF9tcs3MPFZLAYLiUx2TtA9WsvpQ5V1HfsV0WXymC
X-Gm-Gg: AYBFou1jtpXvkhLkon+jqEqO341shBovTf2WRYdVO09TcC2wdIHvtdAEqO5OYwQ3+NE
	sjgfVeVFTEuWwIiqbbB+tCvsuuQkZeDMVpzZQu9NxPIhI4vwnMH9UXS3k0xFEMnyW/Uztnd4WRn
	jMtOWC/ySuZnkTegfxQLwph4WxdwT8CrYYF3CObv0eEchtXa5sCANADwaifYd8y/uxhmnjK39er
	PLRveTZfuDkU0cAUkBp/EqmdvhIJAg//wcV6J0EARvVrGL9FOP9xcIzP7FpukaCPBZSD/UqgzWn
	f/OLRoAK3abYbPGuIBtf+ntwnx7KO6Kf2sPQ380SPHzngQawhIZtypVzkocotReqWdzaxZEUeZ/
	1HmWZnAwMbZp+b+Blrel46aNLz9AvmOSW5SUm0ScfuqtNQ02XbIwvYIfRQr1cYz+rlD0pUDz4G1
	YmM98g2RLFK3t5dups7uf275jhuVKzWC/hnFaLO2e8rg1pwEYufU5B+Hw0hkfhT4c5Rr9wEPiy9
	zLOjRuSyyTwCwaw+AZmoxf1JOI06PJBlBLkn4Ji11XjMrKZ1vdu5+jyRw==
X-Received: by 2002:a05:651c:a10d:10b0:3a3:7682:49a2 with SMTP id 38308e7fff4ca-3a376824d2emr11745411fa.23.1788734593302;
        Sun, 06 Sep 2026 15:43:13 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a3705f37f0sm23059141fa.41.2026.09.06.15.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 15:43:12 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Zixuan Chai <petalzu987@gmail.com>,
	Ren Wei <weir@nebusec.ai>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v4 1/1] ip6_tunnel: snapshot encap in xmit
Date: Mon,  7 Sep 2026 01:43:00 +0300
Message-ID: <20260906224300.21884-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iKeNgRxhkUvxeMmyAJGcT+3hpbWaM+VubQ2sBVGSDeouw@mail.gmail.com>
References: <cover.1788262122.git.petalzu987@gmail.com> <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com> <ap2ksmdL1FFulLnF@lore-desk> <CANn89iKeNgRxhkUvxeMmyAJGcT+3hpbWaM+VubQ2sBVGSDeouw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Sep 06, 2026 at 07:54:34PM +0200, Eric Dumazet wrote:
> The general answer is : convert tunnels to RCU based configuration.
> In my quest for RTNL-less ip link dumps, I converted SIT tunnels to
> RCU configuration.

I have ip6_tunnel and ip6_gre done the same way, after your geneve
conversion: the encap and header lengths in a config under an __rcu
pointer, changelink validates and then publishes, fill_info without
RTNL. Seven patches, built and sparse clean, waiting for the nebusec
fix to reach net-next so I can rebase on it. I mentioned it on the v2
thread two weeks ago:

  https://lore.kernel.org/netdev/20260824194741.215979-1-iprintercanon@gmail.com/

Two things I'd like to line up with your sit series. Your patch 2 and
my first one both touch ip_tunnel_encap_setup() and the encap ops in
ip_tunnels.h, so I'd rather rebase on yours; is it close to posting?
And you put sit_parms under RCU as well, while I kept parms out of the
first round because it keys the hash. If you'd rather have parms in
from the start, I'll do that instead of a second series.

Artem
