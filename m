Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127930DD3B;
	Sat, 21 Feb 2026 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771636936; cv=none; b=tpx9yLyPXfOinI2sB9N4a6/6yV+b2dmxB7fhSjxKp9slROHbzG/pOS9VVnxE9y0ONHtXZaCI3meEU+HFP6IzFmyVetCWyaczKys0KEtRgnzPH3/GFjLceG9iXhezGNXHMQBx3NCTLPqOk5u6T+2ASv4Ks2jEk2pW5KqwuKwYTYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771636936; c=relaxed/simple;
	bh=aX9Y4KpbIVHDoodg66Zf2zxcvm94k6KeNvCXLyotGtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IX/xxOcx79yNjFEriMBpzcRkNuu7sGffE8IMV+97W6Qi1nUP7UBvDClFWDdQvnyLEglSlDsba9D2kQ71AgrScjj55l1I9a8LPZkiG+CeoYvee5ceLmSMvaLl1QvWVQaRT5WxSeJ3z4FLQeT3MRqp/TyCiv0VrrY2vccICsAKEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2/I2jLM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2/I2jLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0439CC116C6;
	Sat, 21 Feb 2026 01:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771636935;
	bh=aX9Y4KpbIVHDoodg66Zf2zxcvm94k6KeNvCXLyotGtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R2/I2jLMJeSDpf/vhW977M2D5SdDzkKv8cpUWEHVwOI+8VwaKbDFUjt+d+KUnPhYO
	 H7/9QQBgNqhI2N+8OfvVINqUEYVLOUB2AMLRyj1jOKPfQAWvexB5ZvDEZ72LypBPpa
	 /0T1/s1Lyfg38nCpM25MDOTlvcU7QR+ljJE4ZlQtAIyqU1TDDI/8SlVajRowYjoLjW
	 MBUc+dVRQUKBfcSc2j/qU0Xu+QbXV4a+Fbac1rUdszenwDv9EWulD5GZGrSmxapDpc
	 tg8+2ZCiwK3TfXeAxL+mHdi8lI25OgwIFjpQ5Fc1bAdC2GEy5f2UY66HvHpkjCAWfq
	 U9UmiN4aYNi0Q==
Date: Fri, 20 Feb 2026 17:22:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: I Viswanath <viswanathiyyappan@gmail.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, Jiayuan Chen
 <jiayuan.chen@shopee.com>,
 syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
 <sd@queasysnail.net>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki
 Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
Message-ID: <20260220172214.7a12e722@kernel.org>
In-Reply-To: <aZkHFB1yH2ooiukD@mini-arch>
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
	<aZURjBHTHRvjP7Ee@mini-arch>
	<20260218174025.2fe593d3@kernel.org>
	<aZdddVNRy6sYiUEt@mini-arch>
	<20260219121213.5b5ab0e7@kernel.org>
	<CAPrAcgNP0av_d+Ai175QoEu5shjHXEEtObtqkhcnKufpHwHWDA@mail.gmail.com>
	<aZkHFB1yH2ooiukD@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 17:15:00 -0800 Stanislav Fomichev wrote:
> Hmm, interesting, I haven't seen that.

FWIW it was one of the "public TODOs" I put together a while back.
Not sure if the version posted by I Viswanath was converging fast
enough to be worth reusing. Up to you.
