Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFD938A29A
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791768372; cv=none; b=TOd8Segma6Fx/KkTt+Uvhj6v+t1YU3LyXmwW8uZScvyExeylJF35DC0g4SpZRsg05qgT0qppA4S9qrwPbBszhLNsDIBWnVAiidarC0qtaw5rULYyRZ/NqiTbdvmBP8IaeelIoj3+7oMSQXY8ZtAdo4xUf8e5/DC5ClMhttw8oTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791768372; c=relaxed/simple;
	bh=7yjAEKuRmZZSVW1wABNqX2gPlNcusDazDo3bH3zKwTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLJ//C0HlHGKsX9OH7jjNkRqB7JK8DzAFX1GWgXWt9oE3Km6K6nbOvsikJ4x+lFfuLuI0UHNqzyIBjKrU8a0lhVLF+D314azU20D/O084cdpxXtC3f9R2sMB8HB9rCN1SaqJuJIH/axnvcVI64aPW9+l782/k4NMbnsSu0pYUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=H/H8/mTL; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="H/H8/mTL"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6deeeb892d2so808130eaf.3
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791768370; x=1792373170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7yjAEKuRmZZSVW1wABNqX2gPlNcusDazDo3bH3zKwTY=;
        b=H/H8/mTLkyXvpKmYhg9xcirznaALpC4U1xW9lVzwYby8Iqd5A03o3rjoSNmrU7geV8
         TRKXpdraFBaCEkaSf4iPuyNdyciT++UrQjCcMb4LHQdlb533vkyEORPNcGrfM+eCFkV3
         xkqg7no1nZp7IV/hlM1lKa4rfzGnCJGgynHdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791768370; x=1792373170;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7yjAEKuRmZZSVW1wABNqX2gPlNcusDazDo3bH3zKwTY=;
        b=qjFI8DtARWQHpjjJ5h5zJJlIvGIKHE5o6lDzsYytmYCIXKV+7ZNCy/IpRfr+Q2tIbh
         PkMXqJWvugipf8E0AFU/MKRh+U8atsYKRkCcESMkh4gnyNSoVK06mMSqHYEdb05aMU6o
         SjzYm1Ab1A/KQzrRNbWM6NI/iKeOmLD8k1RdGbYfG4Abgh2FR9/ujHIBFydMPfFSBSol
         lnRAXedq8/n4TWXBpjbYyKsPot0PZMa6fpUAXbQn8W9aTlao3DRzB2aRmvIprGFvGPQ4
         l0fQCgbrzPY8L0hdHOEWq7DxcTNyinvT3EjWwrSgkONFWof33xfrpHpYk2DsawKjzPaS
         1W1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzHZqSNEFFt85xKn/nUyxeRCbf5lf+2zWeFtQJerTbq4NsTtcoQQuF5qt2QEadF7QICQFEEfHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQDKbJrQL1/SvEdUW5EZbjRq48EHtVKwXMoYyPwAxV31DmPpta
	vlYwt6HGN0iSJ/f9w/T1/iCr7dRl5VYELaBhrrNco6T+J5MGIIA+l+HT2xdsN/w2vJE=
X-Gm-Gg: AYBFou2/p5Oa9Jj+thzRNjtxL2/VLLyAbJGAkbniju9x5GukazBqAMi2+uod/S8rsnX
	sQwNpFh8IPuvemvrtRESg4+RVqWvT9h4OP4Qz9DpcY+1ADfPQ9Y7ycOS1jBBczSsSquRlEZ4lKh
	F5zJWVQOtHM62pY/x8LWCT/pIV4B8LS4ENdz6YtER/xzlSuW+kBkbERUtTwfn4a374ecjGP/8xy
	jkGyIPhZfZh8TzvSkDwi+jMBdKWA2y79AzRyI4tF/22V9RKDEtPoD3ukE5L7tUtmBYVaiXMXsTC
	lB2LjSGfUuqurLDJckNrkbhNWf7+PgtzlSwmE3FE1CowF5/kTTxwk2jM+sidNbbLv+d9ezkkhbd
	5lrZ5TMCZZMzospWMSit/WUaB6u3QwB2A178oeedZ/P5AdfnRDs+s7xPNIpH/S7fdFXUS2ml3FU
	AbadfAZBiOVDyt7FX3VZVbKUK2bP0odimDryKTj2oyMhYQUr3cQPLKPRQE/TeuayQXCkSTcdwqI
	MrQs63R+ww01QtBxJdJz4KNPXC77AN0kQhpbQzmwuotAacTUYablybCA7w5Gnxk/Q27k+2GEi/c
	LyWdVthlDUSsNbsZ3u76BhHBS/KckU0wiTrfhg==
X-Received: by 2002:a05:6820:a291:20b0:6f4:eca8:b1ee with SMTP id 006d021491bc7-6f4eca8b8d7mr1090389eaf.25.1791768370024;
        Sun, 11 Oct 2026 18:26:10 -0700 (PDT)
Received: from com-68297.corp.openai.org (vpn-centralus-01.tradc-corp.com. [172.169.249.3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6f634860481sm1584254eaf.13.2026.10.11.18.26.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 18:26:09 -0700 (PDT)
From: nramaswamy@openai.com
To: Eric Dumazet <edumazet@kernel.org>,
	netdev@vger.kernel.org
Cc: Neil Ramaswamy <nramaswamy@openai.com>,
	Neal Cardwell <ncardwell@google.com>,
	Neal Cardwell <ncardwell.sw@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] selftests: net: packetdrill: test RACK after partial undo
Date: Sun, 11 Oct 2026 18:25:57 -0700
Message-ID: <20261012012601.27658-2-nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <5ce181b5-af31-48c4-9199-feadf24af27a@kernel.org>
References: <cover.1791506907.git.nramaswamy@openai.com> <d0c538a03fb1cabd090927cb30a3b78fb485ba72.1791506907.git.nramaswamy@openai.com> <5ce181b5-af31-48c4-9199-feadf24af27a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Neil Ramaswamy <nramaswamy@openai.com>

Hi Eric,

> Was this test changed since last time?
>
> I thought I already reviewed it.

Sorry, I only changed the comment about partial undo to align it with
the second implementation. Nothing else changed. I'll carry reviews
foward in the future. Thanks for the review.
