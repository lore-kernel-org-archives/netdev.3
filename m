Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598413;
	b=kkwFk9GAQElKWZu4tJnB+0hgnJt+iDRnenbQIgy5LZ4b75YyCykONbdHbjuIfkzP5fQO
	 9Pit+K9eVe/BEmvnkQ8Y4ylu7E/PW/P2ax4DJHfJdOfBPtk3/agXXAdCU2WGLYJKAuY5G
	 UlRuiS13jaDIMuIAda3u1uoWd6att5rQK3qd5kfldWxB9cjcnbvhDYSQKhF5wqH6qUUiM
	 7LkAO6DV1ylwMDeszDHy+Q13qAzgQ3uad+dJrHp3tDx7YvDHXzx15ghctu6yn4vhpvdnF
	 TuidDVphtvGFeKj8hBiDPax4fzXwp4YaIsnUB0L8cGlOT/85duSfVNAAaPZc3/l4/BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598413;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=iToQdD7x0C4OcSO6pRTgbUTrjDhTUaXBpJZn1RQhVSyza0MH8lbLALqfp0XwO1y0sIzO
	 8u4Ek0qWiOO2sdpvgyuLu5obhzQLssvFZG8jRtdpki62yQqRzTamgkdo2E6T5II+eXzhY
	 staVaS+PapjT8oIz/uapzEeTisZYeJU8OvS4st0jJdaL7autmT033PVyUgziGobBxc1Nq
	 lLxd2xiogsjeySBk+esVFJ6vDVBOne48yTzHhus96gx94sEJM7z18eJMK4AfYP9giPRPT
	 ORXQ+YRULZsjcMK2A77Rg6ao76QfpuUqPxIq1+RGxLRV17PFJRzC4EwMlPpeFbQH3FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkxAlDUK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AC606A323
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkxAlDUK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ACA1F000C1;
	Wed, 21 Oct 2026 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598413;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DkxAlDUKPZXTZLmniOgO4CrAbxzGiErjRIPe6lqwyuikemDIWUhQLgM1Is13SKmTd
	 0RBrcAuiEvMMc5A4LYiU29YrkRoPymZYfOs+0solGwR9WeubPJfEY9QN3ioreBb3B+
	 hkpiOkI1kc4log01QjXAV5+TBEyrDuIJCrlL5Oo/7NS/UUTVhN6GjBxhVo34i7d7yL
	 XILjxDUbmHZ/RI6QkADCFvefAF+xJWo66xzp5ei1CYmBhYLL9Qw+PhkdshykfJOdBo
	 xGbpN44iMVAlBpoUguFhuTFEgxUMyaMVONo3+DRAaqmG5r9+Ky0/SxYj+NZ4Ol407y
	 3UiUwd+sBApKQ==
From: netdev-bot+sinfo@kernel.org
To: Dudu Lu <phx0fer@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: reject flow_limit_table_len values below 2
Date: Wed, 21 Oct 2026 16:00:12 +0000
Message-ID: <179259841249.3290.13674474861641412332@kernel.org>
In-Reply-To: <20261021155505.67208-1-phx0fer@gmail.com>
References: <20261021155505.67208-1-phx0fer@gmail.com>
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
