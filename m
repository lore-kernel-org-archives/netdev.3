Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887B3E557E;
	Sun, 18 Oct 2026 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792296808; cv=none; b=sxhhck29/e6KNGt8vYSXmF10gwlDiwVGkmvuy/uu/OaxZxpi0VDBvLCIJByaS0/iC/NBg0NlcJA1YEB1tHWzg84GAgGv1oJkMGV6YbeYDAhn6SaNZIRNkSvGPfNfLtgSC0p1wsE01DQXygPLIlt1cDaX/pNTXswAHAs8/FjLMMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792296808; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0tlL8dTfZ3TiGCUsXd8k1I0hgE9OvxZCE+S5xiIty9cE8Fpk2rDvR4TIdTxX7h/yZx4Sl3T500lSMU/hZ43CgL9+8i0lZAez6CE6ye3e8+NwIBHnqNiJfKAIFL/t2SHh8t5jAxF/c0tc2JceudhAjsr7C3AzS98tsddXrjftss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7Kx5HEK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7Kx5HEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4F81F000C4;
	Sun, 18 Oct 2026 04:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792296803;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J7Kx5HEKcXuYr7JtpahMWOPYxG5N1uicwaBbefkRu2xbO42MVQSzdAH/6oD05ZNIj
	 /btPT1OthYjHgYkNIHZ/cjNp7KPI6Lkq2av/JSQqLEHEmqg8DihDymwVtx4Da+cxoE
	 MlFjY7IhUu5wF1VKrpcZHmWbcuy4LcEg/iSYtuG5b+S8hmA5WGJPtU2UQ3rMo1gcDL
	 SPzbrA/i0IzqIcUoH7sdUgO9g205Lyvw8FgSiOLc4Y/Bq5e/mnbgF/t6EwyLyKrmNa
	 6qo+qso2he8i8LzOl1stRFeY05wlrDI6iTzl9Y54nsoisEslHYq852KNNndOlvDzt0
	 61u28mmG0T0Kg==
From: netdev-bot+sinfo@kernel.org
To: Jiale Yao <yaojiale02@163.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Daney <ddaney@caviumnetworks.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: octeon: mgmt: drain TX cleanup tasklet on stop
Date: Sun, 18 Oct 2026 04:13:22 +0000
Message-ID: <179229680286.3290.9156952367563364577@kernel.org>
In-Reply-To: <20261018040634.533757-1-yaojiale02@163.com>
References: <20261018040634.533757-1-yaojiale02@163.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
