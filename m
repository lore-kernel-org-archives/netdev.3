Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4AC4192EC
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682665; cv=none; b=BdgSg32vk/oi8hHHKTRp4MoVK8VTl16EKB7lS/VRreRAlQPD/JThy2Ta+8kkTXEc8trUsg7GvORkKtEHPrl4XkaxhPXreiMOTMiTZyTo/MmiUvra7oxvlBf/zpPpKOXnV+qVqXVxqDH3+GmfutzCHRogx+LciAJ9VsC0z5DaqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682665; c=relaxed/simple;
	bh=dDBt4FHRZdJL9ffdilgluXXJ+QmyubtcY3PKYDWBMCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF1OuPmNYYbLiEqcirF6IFcLnuchh0LSrMXMZhNQa7FZLuftOxay2YL69I0tLqUu7eKtOxxUr395YsML5lPhnc3B52qSuL0PLozHCafVr2q29Rbrj1yEGDDVNhl5PGSxXeiVLDH0GdB+sD4DRK78Ta4QPUOSIyWw/Y+DNpwHxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAwpHPNH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAwpHPNH"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so778003b3a.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783682655; x=1784287455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDBt4FHRZdJL9ffdilgluXXJ+QmyubtcY3PKYDWBMCs=;
        b=sAwpHPNHXcrb9CIFGiXC+0tz7gpT6lI+L/fhMmTPo8zZl7VMYZ7iXDXrYKIHlDC5Iz
         +3T7r8UlDdWJeyGCrjtdMAufMyM6N3287omf53uHTqEEFvzCeYAItNe8qgvLWMd3kIJR
         oKTpvVXHW3hot4V15C7DGKOTLc6EHI/G5ehHPxq+5O2ZwTgTILp3NQnd3omTfy0sBlN8
         uIMYa7hrsr73TZUx29Sy8h1k+KPkUVkNn5VAcENaymoFgTexeA3EXXnLMsGNprFk9MNf
         K/6dQL/eOkYvjECiL3dIxLNrUNEhZfqpj4xhJN6QjXW25282pahMlkmnryJuCiPz5oyj
         TR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682655; x=1784287455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dDBt4FHRZdJL9ffdilgluXXJ+QmyubtcY3PKYDWBMCs=;
        b=hs9KK0dxW2xglsKE/t4zpxZwrYMLLmQLolxeDbXzv/ldBQMbBjjQnjK9ecWImBoyp8
         AQF5KbAz9g/ZeeO7cNTbCIWOjNAxqFfwJel9dWd2xI2YrKx3X1wljxUW92zy+nVgtc9x
         qimwhZmlNuN91Z3ANQCvfK+0h5Cx01BfxMVYA/DnbErgZO5sMXjVC5+ByakCGar9cJDQ
         mCxKkeB+Jwdxqhv6rzbAXHhKiRe/AMtv8OiGiJI8c2tpjlDT4dw+EukGrRvF15+KBdAi
         ZXwgUd6HIebOh7llradzTZYOQiI/aluD84AR+oyWhnhZzBsjjgdEsFXVYXMBqkX8d/96
         9yTw==
X-Forwarded-Encrypted: i=1; AHgh+RrTsIZbcA50tzCAetTVLBeA+6U6zMPxMnFDylGX+MPmHw/OXVTZxtnrVEXTSoEv5xAKYVqtLFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysjTc1+q7N1w/UH5d5bPI+MIFE74JICtFbv7dJpRvUSRPaCJLZ
	QAUnln40rcSwkf8VIHBsILcEwBwqO6md91VC0yk9hjqQz67Id4F3/DrYZ+8DGq8u
X-Gm-Gg: AfdE7ck7v+fmx6C3Sek72J1tgDdQR70BvIYFXzjTcAHa8fszZu6ZHgMaYtmRHYvt4UD
	MteY50ARnzC+41G11s770nQ6ZefYocHFS351pmXQD0k7sYk1DwHXTKyPH0Hrhxr2tULfNMpJvmh
	mIeuyEnDyHhEVO8P/44o4s1p0fhXyNwHX/YDLIkmX3xTzQE597ksTI8deO9A7Z9Uhipsigs0YO+
	wNnGzjpRQUvqi/lC/2C7basxsABSCZIih9OVU02cPgOiWf5QdMXfqCHw+0BryKXcXZIAiq69NNM
	9owqoltg6Ye5iYslPWMGI3TC6WxcD50iHAObXvqTvjH5k1G6Cf2y+HSfGdZggxpuhrR6HI++0ez
	t/e7ugi3u/KGhO7qhX4GepdsJB47cCOtsPMjafzBt5Q9bpGeGMtaHMIEbf9WlCvTcRoNgRh7YzC
	qQT3ZOAw==
X-Received: by 2002:a05:6a00:a86:b0:847:8704:1c54 with SMTP id d2e1a72fcca58-8484301d996mr10203899b3a.22.1783682655418;
        Fri, 10 Jul 2026 04:24:15 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm8541404b3a.8.2026.07.10.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:24:14 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
	Andrea Mayer <andrea@common-net.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Justin Iurman <justin.iurman@gmail.com>
Subject: Re: [PATCH RFC net-next 0/2] seg6: add support for the SRv6 End.MAP behavior
Date: Fri, 10 Jul 2026 20:24:03 +0900
Message-ID: <20260710202326.cc-justin.end-map@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com>
References: <20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+Cc Justin Iurman

Jakub added Justin to the Cc of the SRv6 Mobile User Plane v2 thread
[1], which I missed carrying over to this per-behavior posting.
Justin, the cover letter above has the context.

[1] https://lore.kernel.org/netdev/20260504182833.344d7b33@kernel.org/
