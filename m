Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B53BBFD0;
	Wed, 14 Oct 2026 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958536; cv=none; b=bV/wm9b6pVGroxJWDlMTtCeMpOh3IdmRBfW/+PjmTQucQwWqq4yvRJwEQdSwI721qAZtvdJ64LzY1oQ6D0OvnPd6dxXdvqNKGrz7WU69i9yMnTnm+NFFIhNE5F+FNJ4rEZu9ZrLcbUB6QyzjQFpqT3PxNCX4lebln0siOKAomG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958536; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sd8Ub9WHu/JlJdmNPfoOTjWjhoGoa/0p3YksZ2YHwDrvVtepXc4dk6pagRpWvlM5hufceh+4J9bfGMzzKExQ+7WeL+TMg/Y1O4rX11JXf5JD1kgcq6qU3OD7vqb5DrT/AoOGKnEaTh8c+J6NQ+jc2z9hiKA+jX30NlgIZDLdKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQMAWO+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQMAWO+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBF81F000FF;
	Wed, 14 Oct 2026 06:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791958535;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lQMAWO+aHWDOta9ufAz3KSzaBd8SQBfWUAgAvYkx77A4/isvunkhYVIGeYLLZHwfX
	 DQGlurNek4JElNetpCOuHNCAvcAovSsATTBaF3LMQKCzD59RbRoIRk7UlcnK7dIe5A
	 Cqb6e8xO5p40gwDtdr+eejY7VzJ6ru4zjlc1J8dfj4KiI66cwnv0eaEfsV3DVeJzU3
	 GIYL3GA33lTlgcAjyZTcZxiYQ2Zp6x1nCwQyXLGqvTwZ8Xb+zh8zc1x7Axi3JZveJD
	 BW3f9Y8ptL0g2F4gjGuKyfJKN676fu2kbzxVkovgw+H2pqYxL+T8WXD88ypRTd3FNV
	 7M3esG/smXHqg==
From: netdev-bot+sinfo@kernel.org
To: Binbin Deng <18983559317@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: sit: unlink PRL list before RCU free
Date: Wed, 14 Oct 2026 06:15:34 +0000
Message-ID: <179195853422.285325.7443421936138356296@kernel.org>
In-Reply-To: <20261014060803.286885-1-18983559317@163.com>
References: <20261014060803.286885-1-18983559317@163.com>
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
