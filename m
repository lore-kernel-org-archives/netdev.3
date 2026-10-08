Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149548FF9C;
	Thu,  8 Oct 2026 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460581; cv=none; b=k2kjMEpMEPMVAwtIyv8nSGxb3iEkKy6EBA45eDHoxx9Dl5KcvfCfQ2J63fvKoNaFiZPOgrd3z0unjbVBdAPhm1PuC/XPf9YnG7OP0jyBRGpYcBq0Ci29dftWoX1coL2wNcEl4Um7cw6WfR4TssOLxnUkvj0ld6rZmsl4Z7SJnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460581; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OhSGSzsnYoqg7glUJ9KOCQ+4UI1Me14stZoFyDkdzPLgYVh6NyHVXB+9PfgTzGKQ1EjjcnK4jSo44q98rzr4Aavpde30mOkP3LVrUKxU6stlMcFhtrSmxL3DAY+G9Er3VEKXWe72ZJaBB4vvXjgQUnph3H7ZgvxZTpSCAOHHpS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aojpZ3td; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aojpZ3td"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7B71F000FF;
	Thu,  8 Oct 2026 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791460579;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aojpZ3tdXEgcuV4rNrwlbl/yNANDP0wXpYjtS0LJVv2dgpfg+hrGA8E4cp3jflRS8
	 HsE7Xs5ELsrb4lzuO3QbJw2XGdNt4ngqcx2D8+yh7MXW0CiyoIZIUIJs62zQ0H+Ts/
	 x4dupQVOPogznTyQWq4ewHeAx8cTfGfO/Nk0HrTUkMkk/mYRsAUxfW97zmXrUa9+LF
	 DGcmFjZhNOlkBgaqcfNQCB9r3KQjL92dfALPiTLSW8A8NyD2UC0cCgOBHdp3ubsz4c
	 TI1cxSaPEseIB0cT+7h3sDkHQI0u31yJ01oD09PHn+qinQhjbrkq7Rp+kMDa7ftNwx
	 kORVpyNwJpewQ==
From: netdev-bot+sinfo@kernel.org
To: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tcp: do not send a SYNACK to a broadcast or
 multicast address
Date: Thu, 08 Oct 2026 11:56:18 +0000
Message-ID: <179146057882.2527009.17504191776311042032@kernel.org>
In-Reply-To: <20261008114942.1376889-1-theodorlarionov@gmail.com>
References: <20261008114942.1376889-1-theodorlarionov@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
