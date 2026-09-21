Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB34E73DE
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027055; cv=none; b=rs4rVNPSmIbzdM21hjXxH+cs5IN4UnIGdlOO14S6+CtDtuqFNg90N0RWj2s4N9LpFnoPaSI5fqsNAQAyYbOERKqTIHxdDfHK/ULygy3p4ZX4nwCfV0X2v02Me5GQ6ryU2cMShDcuexd5WRKsuOswY8vMTSHJ//eOAA+XNZ38p4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027055; c=relaxed/simple;
	bh=ITSFGhBCgCYWwEXlvak+PK/ROh9aqcx9mXeYFcC0aJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjKhL0CjSKjWGWO+p/byFeONZ+l/YRZp6BidP8JaMwH3hwDt52L5DKN+tl43qUj/FG6SrtZc5g6L6Gyn94wmwxfEAxrVDYMwC+/wgHm9CdFoblIITjhfARiE2srEaJiJC1SLJngiumTUiVDD3LVpAWbSsQ0RlWkmav5mBEor1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WexRML7w; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WexRML7w"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f88so2165638f8f.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790027052; x=1790631852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITSFGhBCgCYWwEXlvak+PK/ROh9aqcx9mXeYFcC0aJw=;
        b=WexRML7wNY9HYHVsSLgAdJ1X8hq8E9SbazwD/0JPQLRmJHuWJ2731Zpik7tOudgSOa
         G9juTmXT56C9FkAAZ8eESwPY8of6wjvVYqMKruOfiXF5yt29+ui3kaahHRldS6qbQmQJ
         UBzumqhrIJEYjckC38tUy8qRCvTpTkebtoo2koAPc0KlxXXACERqEHoNodtQiXHJx3IZ
         X5iNUM33fTgMrGkW4XIZ2tOMWtVtrGY+5lB3QxP6XjUTG5Dg4JZGj5Tngo9kqajI0jX6
         F0fbrX1JJYL/zCrnLaS3gjrsC5+MATlfb3ABcPwWKd5N3vOsYokY0J8WtAIvZm6UqaDW
         Qt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790027052; x=1790631852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITSFGhBCgCYWwEXlvak+PK/ROh9aqcx9mXeYFcC0aJw=;
        b=HtHPAwawOCMJZJ2yQfOr3eORd3wy9f9YXHMe/liE+RaKFb+E7yqE6Jq6H4zgPsl7nA
         qN0LGjx1YdsKyHlqqy5H4CjFRV9ocPSMNHLmLfWZcVPmOHWzlu0yu2YSWymLRfhcL/IR
         eXromoJEPynXzS1qK5djket/sRwb056baBWWYt5+XVreMCcOELxSgCq+wGWSPtP65q5s
         QlEFewzjLINhrJvfQNvRiDRi/G4ucCQJiDyA1TPqkJVBqp6YQFzY29iN5rb80RNSw8fN
         wi0fRBhG+FmIBW1QDKl0tkbbsMvzPbHanyVyO8dpZ2Uj84+qLKP7cVhbAxv0ePcX7FWD
         9FnQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2sCc03y2gxGjDGdV3X9dz2aqSQppkSocYF3f+fYCELDVL255ZMwU++cBN4mF74SNIg1aY7Ms=@vger.kernel.org
X-Gm-Message-State: AFuF++keYnRy6z1wplBzeheUjeunTIm16vBXWg+6JKTg5qjmrXMwCFh1
	z4uJ0Pjwoglf9H2YnWDFW1eYDXuHtjSppUAepTRnwhlTEsizybXVNuJ6
X-Gm-Gg: AYBFou3NGajmJePAgfT3kUFhTHFnv/GM2EcZ27wraK2OOWREZTrNTlsX+fF0oGB9pYw
	FANSsmZ/xRfhvu41+Lr6SO5SrbRlRYuyJIytemgxh8rM11WYIauokVAgAmmEAo0J9Iwr/4p3CqF
	Gw4ZYsSqEyHieESBwPKwjxQagSTbwZqHr5QvM/qY5oOaUOcHgdHYsDiSFAYt+F7K3vI5zjyiMzU
	/j91xgdXMkVbzJ6PAL8nwFdnNOyrgKJ0wop1v0djwEqAnIC42uDSPVe9mceX6/37dnbxNporv3u
	qDiknRisRpCDzOoO4Ix+ovqONrCurtlqsWUDK9aDquinGIOiGHjK+QFhDQd7g8fZJwskGMS8JCm
	mzEo4C9IfCWMJ1MKBwV2SFlPYmbzjwckt3dXQmrVu9uj9h0tdHFVJP87A6hNAUL/QUD9GGlCMNJ
	wiyWKCwF9LClOgEG2rXaLlFFZh1W8WsyzBhCZ/S1QINFIcVxkcatlz0NLtaef/QxgOsR/bB+xX7
	PLJdIANXZW11bR+h+PYfkWCNMlc51u9PCxDpbQAYIz5aPP1
X-Received: by 2002:a05:6000:2410:b0:486:f404:e833 with SMTP id ffacd0b85a97d-4871e363fd5mr17751590f8f.44.1790027052088;
        Mon, 21 Sep 2026 14:44:12 -0700 (PDT)
Received: from linus-personal-clanker ([102.164.100.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886224427bsm447839f8f.8.2026.09.21.14.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:44:11 -0700 (PDT)
From: "David .B. Dull" <monderasdor@gmail.com>
To: adrianox@gmail.com
Cc: fw@strlen.de,
	horms@verge.net.au,
	ja@ssi.bg,
	linux-kernel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pablo@netfilter.org
Subject: Re: [PATCH v5 nf-next 3/3] selftests: netfilter: ipvs: add per-service secure_tcp test (David Dull)
Date: Mon, 21 Sep 2026 23:44:05 +0200
Message-ID: <20260921214405.7003-1-monderasdor@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921213031.6160-1-monderasdor@gmail.com>
References: <20260921213031.6160-1-monderasdor@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also to avoid misunderstanding. git added the signed-off line unintentionally. please ignore it.
