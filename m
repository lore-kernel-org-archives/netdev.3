Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D3371D11
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794564; cv=none; b=NDJ+hA9yZc5wKSWs0I7xbMX5pQ2wbm9Bai/n8FwTbqA6iEKyzMSm7TF6JA1PE+jDGiE2PQhi67weI7BEKG23NZDI4hgoVBhtGgf2shSL0Ia06SZM1AhyVogAuKeYexYzEvQsiBvJi3jSydqy4rbmjZHkDIJBQlZBpcVDEIiFEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794564; c=relaxed/simple;
	bh=AaxiIHkgLD4ulKUYLI2V7jffRjIqGmFrLAV4aTnpvCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEQlqUk2pR51z/viALd96hvnusx07772ZfrAls7Q3GBC4vOSk+DpuwkRxIRh1hLQPi7CW7oH/+Rp6UjsL0AHSTadh0mIWm+C46uePkFK9ONYBae+pZvOSdRcBCjNWkZEgSn3SQ6+JRwgGMReeL4nK5JCCn7d4/buUfztS9to5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=XxPrzklF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="XxPrzklF"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3a706146559so955165a91.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791794561; x=1792399361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pMj0ZDjWQZhfS34YQOf6RUS2CPztBt6uEwu8EUdNqqU=;
        b=XxPrzklFgCfxJ0icsOck0/YeI3vC5a/MjtrVKqB25Ylm2MaobbQFurVvlEtZI50Det
         2IbOcwlL+p8/FMdhmlHJpU6kiufdk9dkI/q93PhkOu2Cp3Y5I5dANkcwfmBek0ofRdty
         zjV69LDvJZWf/oPBqRfx2xmCBLSUmOYSSUKnnhtbVJy2r9EIySoXpmfopr7P70qNYA7J
         pk6LzZI05XLCvIOAB36v7reh0dfN6LewH6vDkYLF2QEqbIY+/Ns83xQaKak9zCjXXBe7
         2xIU4U1hnjC2j7IkRCO3yS/4AfXP3vMQ0kKKuDJE79lYJK3V+DZaeHdp4KTuqxBy+TOg
         tB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791794561; x=1792399361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pMj0ZDjWQZhfS34YQOf6RUS2CPztBt6uEwu8EUdNqqU=;
        b=ul3e2Ynt4nfACgYh4uQjBL1B/BmFMuQfboCXrWpzUjkV78LzzKK3jt6r/A/rRofIix
         j6BV52DKDMXplUQpoM/ZK+ADUZ79lmJU5bC0ofdAW9XtNk2HAbS0X5e6XPV6Dmi1aUL2
         J/tgXGPbKrk02qhpURziAvznH/fUb4DIzoOb0i1TGAwVWoPkBd4loXL/5ynH0bx2ouUN
         GCxKVuk/u3fTp40r0VTcvfoHPsPM1eCfO77cVhAqC7uvrluBAJ4qzvHuL7SQC0lA0v9z
         NCskd378rdhsZT3JAK/gA6xFPsQt/0tcwSBA1DpY500zP593O5XREAVIe1zwbquda/Nl
         OA1w==
X-Forwarded-Encrypted: i=1; AKwUvBwh0U/IzwbnrlqYFD77gFJdiKTYhnum5z23txzAUk1nIpXhVvGV5qcMGLB1hJiv4r2tIjtEoag=@vger.kernel.org
X-Gm-Message-State: AFq9FYLq+ogjmfR5XIPseRUCzVd8LMeqnkEHt1imt72ugKN1zmeT0OvX
	2VII+cy7aBDi2rQA5ikWMBmpfI8nUsECR5eemwRQ/QO45TiU0nYKCm8v+JIpEs77iQ8=
X-Gm-Gg: AYBFou07k0OX80q9Cm58fmjnFze/wFJlP+P73pNaxgdanr1TRXqEuC63h9k2zRxVI2i
	EIWH7GDpY9C+aVRaVf27eSzCrHkIMEbJJa/aVs+f5eoHnjVRf9lYC4t3Z0TO+j9vE90c5AMbxIb
	TtglPkjvZJrRYpmogECnNW+vUDWNNVhm3O+WxWaeZcN3z+19eevGbm6mBhXNG1aCrYWSYYK8VgD
	Ua5n5GJw29Su2zMcpDJZ1m28UQegN+7doJ0X8zqSSTXmGGGdSVntelj2CjVpAaiXjnKJDxkc251
	3oYW70048JLiZhRnQgbw8fWJ6CjWM/oOVs3Ob0mCoHq3Zx2t4ZNc7o7i/pynd5ShRlLO/1JUB0m
	LSlbH9t492uanRxL5A4HyRdf01djze7jGqoucYL7D7BU/1RDd2RA6EDCz1NE5sogUcPvzZc13mE
	5wF3Xx2yq6B2Cjdc9rI8Bi6nEyVqSNKwhkn6MJA0Ep5QtEcsVAt68egoF9egdCVsES/K6VTe0fo
	eiK2w==
X-Received: by 2002:a17:90b:5886:b0:3ab:be66:ddc8 with SMTP id 98e67ed59e1d1-3abbe66dfdfmr3137834a91.14.1791794561283;
        Mon, 12 Oct 2026 01:42:41 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ca0033sm15363658a91.2.2026.10.12.01.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 01:42:40 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: Re: [PATCH net v3 1/5] eth: fbnic: only act on Rx completions naming a posted buffer
Date: Mon, 12 Oct 2026 17:42:21 +0900
Message-ID: <20261012084221.2285031-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <40b3432d-b597-423f-9279-ab4aa1157f44@gmail.com>
References: <cover.1791775409.git.yhlee@isslab.korea.ac.kr> <25ce85c9821fba5d94932b36b9c9afb9a2fbd12a.1791775409.git.yhlee@isslab.korea.ac.kr> <40b3432d-b597-423f-9279-ab4aa1157f44@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for looking at these, and for the detailed reasoning.

You're right that the buffer IDs, offsets and lengths are values the
driver itself programs and the device echoes back, and that a healthy
device honours the headroom and placement the driver configures.  The
series treated the device as untrusted, which is not the model fbnic
uses; a completion that disagrees with what software posted points at a
software/hardware state bug these checks would hide rather than fix.
I'll drop patches 1-3.

For patch 4 I missed that Daniel already fixed the same reference leak in
1c85ea5df86b ("eth: fbnic: put back netmem reference when
xdp_buff_add_frag() fails"); please drop it as well.

Sorry for the noise.
