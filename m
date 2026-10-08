Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52387367F2F;
	Thu,  8 Oct 2026 03:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431124; cv=none; b=rW7Lb3JM8sT64G8NFrs1UpXfUrfpnT+CHH8n8OtjDj3scYATu+kQkb9Cht4SYLjCCAo43XNrpYJ2N+yUL1flFi4SLpuHQzsRdYI42nDMUbsglHODY1Oxel4EkG7SNQ+g+4ZWFpbPo018Cs0lLG5vXLccXvgOQSoTdAfYule156w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431124; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V3kdFZ0MG6yu52epGYTGRSxqvk1yMbB7BQiZJNVTD+jnewOx5v6U+RGmLHUwVxTzfKP6oxFYsaOkgpI/TCroZNcorRO0CZM4XQphz4ENcLo2gWioZmziydcaRZ0m2IEvahN+XPz0MuMpo2PzJeCwrXjHJHyDH+nMa8umWN5Sf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+JmAgoG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+JmAgoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327771F000FF;
	Thu,  8 Oct 2026 03:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791431122;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b+JmAgoG1EzJ7HH1X264Utfo9uMjgYuHAMfB9K2bMGoB+yzM7JcNawQYGlF1D3jMC
	 rQdXAtkYOerRSqHMUuMZPAGoGLvXYBs4N0IxA2G9cEb/DTMkGXzCiNg8OjkmsEH9V4
	 eBSJJZVj7bd2OS3QwhhwvolPGYsB/1aE8w5TJt0ELJfNjsNw7Q0Cj5rcYRH4VjaJhk
	 Yf5eFv65Dw/l7qb/3U8Rla6ZQ0Te+uA/abKmwsW5u6X9u8hDOONDJ1Pw3B4wDyflyf
	 keH0eGnCZEWQTC2SJRChWv3b4sSabXG66tRENKsnx+oC6egPum64pEzFeT1zEXulJj
	 +4gqg06fPXpXQ==
From: netdev-bot+sinfo@kernel.org
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Kaiyuan Zhang <kaiyuanz@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Antonio Quartulli <antonio@openvpn.net>,
 Pavel Begunkov <asml.silence@gmail.com>, Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net v1] net: devmem: prevent mixing fragments from
 different bindings
Date: Thu, 08 Oct 2026 03:45:21 +0000
Message-ID: <179143112175.2527009.14016536712256693673@kernel.org>
In-Reply-To: <20261008034027.1403188-1-almasrymina@google.com>
References: <20261008034027.1403188-1-almasrymina@google.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
