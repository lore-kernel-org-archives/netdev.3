Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399074;
	b=1qUCCP0vY4LsEXOBFjJX3MGP7obfjqr9TNB8W7uCafKki2t5gFj1eTovRmggfB4wLX/A
	 H4Lv0VJ3RtrZPptplRZHB5CoiaQPi+yUsZR46PcUmYQaO0/moJSjeVq1CwKAZZMfbJFRK
	 vSWB9NhqH74v4UNj7WC28VeQZER3oIVLWWVXdWEYuXuAvsZiyEOFHhKwMFgvUeg5wlMJH
	 WNBSE++3dPcW9mLEuVCzd7FJJQSgLpbw0V/14jSthe3vakG7/3zMUctSq1he8SxEdE7UE
	 aXNywQUfv5zmTtjqtYI7yt7mIzhGXQJ99wBDSmscSpS76w/gWEdXJZOrBMNCIgnhRQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399074;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fbxzzxjgLjleAkhOGOsfzoqFi+tsHmvvOMZXGRY0Cfk=;
	b=hw1fcJPylu1b4+GmkbRQChRc80xXEULGSAhTt6OG+CBgjBpvnhbmthLp7GnsPttHMV4O
	 uihQh4MxUgjDXiOAuZRyHTguL3/kEU9YNrJ3iqTcAu1n+ufOb+/KImAufLWHpv5+sKU8O
	 YS+x2VSH995H85Wg4xCF8ufYAHS7sGYeL6rhpl/PaUbkFiOEYF26TEU5DjiRQtemTGxmc
	 kqjJO41WYaTN+fLQ4giMwgTmzgWjjsPD3OXFxv+D2GZ9kfV2OZd4fLFWRCrb53wknW0Sw
	 lA2VEhHfHRKPBpGUq8q0T/FYPi3RxY0YdXY1Oc8C3i6EUN1Rt1nHA9ulXlo/Nb0gfbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhYkU1DJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10786606A325
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhYkU1DJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A5F1F0093A;
	Fri, 30 Oct 2026 22:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399073;
	bh=fbxzzxjgLjleAkhOGOsfzoqFi+tsHmvvOMZXGRY0Cfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RhYkU1DJsq6pltOKprBpwOKqISzGjvjLEDlnmnLRCX9+0B4zMYnfVvAzlHTis0pcQ
	 u8pCN/dvDKUGVK1rO9KeDfnGDBCBZSP+93/HnKrAwnv5k1+X/t+g1MlqtkWC4xlnUz
	 pwonyqCHymq6YBzy+Gytdwyu+kPEh0lR4ictR5UbbHroDP4Ktq0CEKRfvrDgQUGcgX
	 mHUTUeiWf2ahw6nVoaURLHTa+urnB6Sv5jsMb6MXJxKvZpJcx8HzwyinA5A5F6FSNu
	 phoXRziZtNrCMyvj5qbfwfD5/ppl3gTKvSpuue84AKv8OApfm68QkhI3KRdDGkSo/8
	 JIlhTRBIT0fZA==
Date: Fri, 30 Oct 2026 15:24:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: dsa: mxl862xx: bound FDB dump walk with
 a read limit
Message-ID: <20261030152432.7a3c9cea@kernel.org>
In-Reply-To: <tencent_9A3D612B75599BC18E420368621A5A296A05@qq.com>
References: <179327344028.3327.14084939226295973095@kernel.org>
	<tencent_9A3D612B75599BC18E420368621A5A296A05@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 11:33:12 +0800 memoriaru@foxmail.com wrote:
> How discovered: manual code inspection. We were auditing the
> mxl862xx driver's handling of device-controlled API responses
> (firmware as an untrusted party):

Why are you "auditing mxl862xx driver for handling of device-controlled
API responses"? This is an SoC driver AFAIU, if someone loaded untrusted
FW into the SoC the game is over before it started..
