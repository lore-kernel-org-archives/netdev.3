Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681663;
	b=odtsIYMpbPIXYTqsQyLx+yJOvuUfbm1FhV3GG4Bni2tM6UMqOqSOGDh/JFrjmNTSecdz
	 QGtmkoFSHy4BnD2U7cOys4NTC7OXlbIfx7AD6sWF45braHMF983oimxch8GIYKUWblnQA
	 VOJug9j0yNwTylFXo0pZ8dydheQRS87qWHXKhUxB2SpkxcZ1eH8e1jlGk874JxgQKdFdh
	 ip5dAHrqen9dnDZEE4+gk5nCFry/2/g/x5YC/9GDxQgJL205FzkjLGs3Z9MZlIiBA+iyA
	 J4AxsrI5U+y/tMKxnK81fb2pdjOqeWovEfxEVgS+ClUn98vhy+ckGoREXS2yxk7O2dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681663;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aYu5tL+PuCH4/RQGXsSk93otf+EFvcsy01l4zpCxadM=;
	b=U+EiMTgsC2tdPxcbJxvPCYXAIuXdmgK3MtGxyoj3+SQEg15pOTwcQgtDtSElulE8QDI9
	 TcwxXBHXNzrYYjdajftYdjVS3w6WXS0hYoFsmaUfG1v6FXeFTHcu3W9W1EXb6lMe9CMS+
	 +QNbgwlaquM+FzucTRkSD9W/FE67BBMdko6dyNTWAQMdUJlZ8JlhaIPMmHms7lRq4fSV4
	 wTBeFkQKSslj7ozobsW4j3hpayVDSDVi+hT6+zpFHTnyJt/0UEv8EuZlQ0owIvmSEgfxy
	 VxegWdPL/WXvAhYeHE9C4RQdKHHxL6afFVapibhQNny2cqm8xD/eqEv2Eh7eLzQ7n+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuadTE6M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F1606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuadTE6M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994521F000C1;
	Tue,  3 Nov 2026 04:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793681662;
	bh=aYu5tL+PuCH4/RQGXsSk93otf+EFvcsy01l4zpCxadM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VuadTE6MoCKOx+0oPsRFSnG2rej0fmzfB+7r5UCHDy+qPvps5uuZbzwvYrhKQcHa6
	 Kg4XCJyQ3UkyVvCc+euGzdVeZL5MWKR9SCTNO2uGH2IeJyzvkPSyfUT0eSBK20Mqwr
	 U3bQRwWf082m66vmwAfg+eRRInA2muDoRf4yM2cEHZpTZKxInK/UFR5CuE8e5Sctp/
	 g3Nl2y+kW1xpiW/VdyBv2JGE2KooBReiDKUK8Ayb3QCrcGY/NH31vq1Tu0/VvbkeiK
	 5C29f08XNVnQ59i7OOkHACcgGhbG/48jZJfE1ZxdNrY2GFRiuiago4XI93AoMIArof
	 +DdtHlmnplFXg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 1/4] selftests: net: py: add metric output
In-Reply-To: <20261102190827.989117-2-sdf@fomichev.me>
References: <20261102190827.989117-1-sdf@fomichev.me>
 <20261102190827.989117-2-sdf@fomichev.me>
Date: Tue, 03 Nov 2026 05:54:22 +0100
Message-ID: <87a4nq4irl.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> Add ksft_metric() to report a numeric measurement of the current test case
> as JSON, right before the test result. Each metric states its goal: higher
> or lower for a performance metric, depending on which way is better, or
> zero for an error metric, so a consumer can tell wins from regressions.
>
> Values are plain numbers without a timestamp. A helper for other kinds of
> values, or a timestamp for values sampled over time, can be added when a
> test needs one.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
