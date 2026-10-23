Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779176;
	b=DgLhhE8m22edNCR/Ua6cBwGNy/aSzd8mX7wisaoiP8V1ABISZ0s4uj1rtSUE8y4nuqRi
	 uG80jB0a3pY/KWulVNHO5WTsEN7AxC99XN6h1KZggtOU8z5lKMQHiFyk2PtuZApdyx8eU
	 QHFur3bQR340M2StQ4BmTEnJwDWse/Itj2f9MU/T7GNjDoExYixlC7hdILFNR6ErAZwy0
	 QIUY6R4LNwGSVw1EeW+Ntzs3pkCAVVnbdQOQmX8c71yTcVHz19uQCQY5DEd2r5rCOXJz3
	 Sq5u61Tlv/bfaRF+bo0QjPhEP3fGQu7PeoBWX4I3H+nNcq8uQFWVKcCxkfV4bxlpGXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779176;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Content-Language:To:Cc:Subject:Autocrypt:Organization:Content-Type:
	 Content-Transfer-Encoding;
	bh=ybs/XGpYS+OAN0wKjpy7Tl63LguIEGcfjLWwIk6zem8=;
	b=pSNjZVmaBOAtaYWi5YNEbjMDoLfZRwGkGVKvleVxErWAQp9b4kQSnvBAONY2LW6KMHpq
	 oLEwZWv74ajsZ9Lo2siW6kGiA0W5FFjkDZzFTFpwvkH/2g1fU9NdCJV6nXQ6qqpTiBoqH
	 IVPKS1r/3YMzJqfdhrsKk36MYlML+pKbYHP5MRMqaQ9Cc0QsDrpnAkn5koL54fQO5QivX
	 Fwy+D1RZEBsAvorfyajBWjKHeeFyWdZKc/zybp7y2cy4Qe3ZL7duwkV8vdlcaOJSioaG0
	 9u23ezLjuLsygMmluudaY44yXwvCKyHZsV4lTskxlfoc/UrEHBGB+RdjGO9qybKdnzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIOwmXWL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B4606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIOwmXWL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851DA1F01825;
	Fri, 23 Oct 2026 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779176;
	bh=ybs/XGpYS+OAN0wKjpy7Tl63LguIEGcfjLWwIk6zem8=;
	h=Date:From:To:Cc:Subject;
	b=dIOwmXWLF0/g6VCPYYA89cQNAh4TP05npc2/egUBBM9PZ91RcbqajVzqfsToj51/J
	 aMf0DUkBpk1LmoAWW57fJSYZtLwJxjrHuOeCHylUO40Ksjd3K5dJ84ysW/VNcn8LHk
	 JG5ljHiBgABC1ghPGOOz9x7c8wMGikUv4mJpxXjdfS47J8wlzEq74YdbRO6r/Gycr2
	 phllvroMdb2UnayMblkUR4pL1sWked5qQ73zmQHPnIk0IHa8KMj/lW/ngn1ZCpRWmP
	 J9BrvtSN7vq2Op+rFwkjaklejvajLk7IWq6F6PH6/N/GBPbqfMFhT3137sbms8MAG7
	 b9BPQE62vWYzw==
Message-ID: <374b4465-8b45-4285-93aa-533a4a0cff33@kernel.org>
Date: Fri, 23 Oct 2026 20:12:53 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
To: Adrian Pielech <adrian.pielech@intel.com>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>
Cc: Netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: [TEST] Intel's Netdev-CI: missing results
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Adrian, Przemyslaw,

I'm working on the Netdev CI, and it looks like the Intel runners are
frequently missing results:

https://netdev.bots.linux.dev/flakes.html?tn-needle=intel&min-flip=0&pw-n=0&br-pfx=net-next-hw

(Look at the non-coloured blocks.)

It is not very frequent -- once a week -- and when this happens, usually
all runners/executors are missing, but is it normal? Do you mind looking
at that please? 🙂

Note that when an active runner doesn't process a branch, we cannot mark
the whole batch being validated as "not causing regression" because it
is lacking some validations. So when this happens, the end result is
marked as "pending". That's not an issue when it is once in a while, but
better checking why some results are missing.

Cheers,
Matt
