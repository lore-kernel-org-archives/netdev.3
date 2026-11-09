Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240038;
	b=mqI89fIttWfKVLRdbrvc7m7ttyapv5AL2QEsuKRvkt52jwe4b+kvhqbuCyiCZuaHK2N3
	 drnYKvSr/hocevGg9CNGv0MFpc9kELY5gEdVfjLvbSzP7lyGM+tUoZlyRkWb3cFBgNwE3
	 f8L67yIsQRNxQPQKrzJv7AYwBSvilHNst4bIKPDoHBFRzbhz+Dj674rWcU3MqKAbwstpc
	 FgKWDcEuzD0p8mBVTrHX1rceZRr559x6kElXdamphvLlyGqSUpw8NGbGXpWDgc76ky6Pd
	 69ghixf8j4Ng3MBZjN7ZzLw9IdiTfbdhvMX6pDQyh6hsLYbx+0CvqUzjjcwqa0k07yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240038;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+Y49uBzkhnU3ZPTcSM7Pyf7YSy58R7jBFM7iD/6fUE=;
	b=wK8FBd37/Aex6ZCCqXZ1AqVEmw6UMmZrXWGVagDdYZly16mQkkaoRk0ESiP6eNl8I+0i
	 HTKbDD7Tyuj8WJ9UDzgnAh4ShR4jhyaVi/hcSn8WqsJ9hBdHAw+zPANsjhio08t/FhF+X
	 lmoO6u3/gGAi9TLp+lO1shj8x2li2pJjexIyGeTg85thDP5LRW2E0syb8sDu6cc9TarJQ
	 G2yidaWPjMDaDAfiK1Uia0ib1hASAnC49+RQphZIRon7WAVbJT/RN1i8WMpcrQ/itqeNN
	 HpSqzvSVAcyHbG3ZGBszSa35gTI6IPvLzuSfM4E60Of/eIuTUDrYgXBVHuC9LRZtz5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlqkuxlr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E74606A333;
	Mon,  9 Nov 2026 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlqkuxlr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1241F008A2;
	Mon,  9 Nov 2026 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240037;
	bh=/+Y49uBzkhnU3ZPTcSM7Pyf7YSy58R7jBFM7iD/6fUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nlqkuxlrx+pk/IDb+g68m2oZMULIyFqwV06Bq+tmLvuxM3TL5cPMheGAiYtaqoli0
	 vItSaHNoaBFCj101owFeIlRbr9gbNLZ9Q+WTAmCS1WOg8WVy84gpy/YHSSqMLEX17q
	 5YXWrSOMBlLGVpH4tikl9TrpUw+1qGjrJhFvEQlM2tezt4TU0JwM+MpPbSbflxLGds
	 W1MbmN51WBkfEuhxZ0TSkUsYhEOtcyEqfflKrEEluN8XYGPvcYXkil6S6tDxbbF/s8
	 YPGKEXwN+BpHgrh9ysNmsu85hpSoadE++u/VBnGPmbr4tqxJ5goZpZRz9BM4xCX6UZ
	 TQ1anO/qAJiKQ==
Date: Mon, 9 Nov 2026 08:00:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org, Randy
 Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, gregkh@linuxfoundation.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 14/14] docs: netdev: align the security fixes section
 with security-bugs.rst
Message-ID: <20261109080036.11bf06c6@kernel.org>
In-Reply-To: <20261109080240.29444-15-w@1wt.eu>
References: <20261109080240.29444-1-w@1wt.eu>
	<20261109080240.29444-15-w@1wt.eu>
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

On Mon,  9 Nov 2026 09:02:40 +0100 Willy Tarreau wrote:
> -people use the mailing lists and not reach out directly.  If you aren't
> -OK with that, then perhaps consider mailing security@kernel.org or
> -reading about http://oss-security.openwall.org/wiki/mailing-lists/distros
> -as possible alternative mechanisms.
> +people use the mailing lists and not reach out directly. Fixes for such
> +bugs are posted to the lists like any other fix, with a commit message
> +that does not detail how to exploit the bug. Never post reproducers or
> +exploits publicly: maintainers will ask for them privately if needed.

Please don't insert the wording about not sharing details.
Vast majority of the bugs have no real life security impact
and we have to keep asking people to share the repro.

Can we instead add a brief "please follow the standard process
described in the $security doc" ? Or, maybe even better, can we
delete the "security fixes" section completely? it is very old.
