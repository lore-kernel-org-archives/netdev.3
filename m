Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793345625;
	b=sugUxjOX57rgQFbw+9FHhWuxJb7KGAAyE/g/sjY1MiUbcILksqFMMmliS4+SmnXSCHND
	 NoVEG52HY6UihOuGz9VeuL171AA5I4pAjVf22bHEJXeSONpR32HXivM6xXyFyEqGaigQx
	 RxiNtKnWDnzKvOJDRL56fgsZCUY463Vpf6Tl3HQxtUV4EusfY3TlPKaIXrLd7hby/i2Vq
	 hqCAtgAt5qcpff8hr+CUgjPfnGHQEcnzx8qgRvRO3HtEooQvTpUob2hVrijEGv79HKeLv
	 F5zOHgumVnHZKt4WKG/9lZit5mYIHHK6Aq8pBQ67YNPXIhjeFyYkP8+qZwNlfXCl7dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=1GTpkLa+7xYJGLobDpsZFHMMxvretRmG7RRO+OCXi7NBZFnvmkR35mqdg+N8YqVdw/5B
	 kYrrMRXlHkroQdMEiG2ONQDzVFzlZtXg3UUQD9gWAMOhHL7enM5POYsz5lgXGaBoBVS/J
	 Bf7ojWL92UEqBdfdDNS3EZnClow8Yy/IjVMuxTfVmFXiAwwIpk8qKj8vHvA6SFiPyiZjb
	 rvQ/zPmf1UibU6OXvcBp2sRhAVZyQtm1+ZeBexORiTlcjlEpRkKHmCfyoqma2CuMaC3cg
	 m87dKCTzNNqO4vCAV48mDK9pm8sgQMaRDOd5c/XAJUxtD+EI46vTxYefEDGedH8msRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CH294Dhe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8E606A31A;
	Fri, 30 Oct 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CH294Dhe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321331F00A02;
	Fri, 30 Oct 2026 07:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793345624;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CH294DheZklHLltO2iVTqblhofl9s4GL2XVT7He5xOkbWNDzcbtOBzs9oEq87sUZi
	 7gaF6WXqHJAJCa99gnG7/WWoF6T7/rj3Tm9lJXBdyR0pMIRJiDYc1ozHZN079ve/cv
	 O04tDP/Z7HA4ai70m5OefwoxAp1ozInFjpbJPzConfIajbjsRqkPP/srdZhR9pcroo
	 Vu9PIUrVJ8CYVKfw+lBcvEQ70jQgYpfy4kr78PIy8wZTTDYn67bs9E7wf8NHj/xHl8
	 O/8hGEu+87J+LJGkhiR/CIBQoNcL1BZZ4vPocQ0MGJT1+sAKahdLORIqw3hA36y71t
	 1xwgxmnmPZmNg==
From: netdev-bot+sinfo@kernel.org
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, alexhenrie24@gmail.com, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v3] ipv6: reject wrapped temporary address preferred lifetimes
Date: Fri, 30 Oct 2026 07:33:43 +0000
Message-ID: <179334562364.3327.4964653900741882255@kernel.org>
In-Reply-To: <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
References: <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
 <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
