Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FABB3A8753;
	Thu,  8 Oct 2026 03:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431117; cv=none; b=VkuSNCiROs1mymBUmTM4XhEj7DyUl4Quy1OFcHrrHr7MNHBgPM0TUOLcIr/XnLqXLV+pFyLoR0O/v9TRIk4YmvquAWcmJOWBh9qX6xtq9Qvpw2+cz6hVPG48gGLlqBeILwJMNQdm+trNSSkJrdr9S/GGaGsUthzXOVYlhMti6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431117; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h2AGNDwJ3rBVDKRXazGPB7cx702jidoirpfyEC5yOj/D14E6TETF80QVgAuww5y4poWlu6zCRKflZ07SZGiaMCMLoPjQlnXfjp0+nnzeIxjWqZ/azbf0+MPYff2K9v4CbOfS9MeoJ6mXExVue8x54amKfO3Kw+yFmfwgP+5ie6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vv1Gf8/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv1Gf8/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED461F000FF;
	Thu,  8 Oct 2026 03:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791431113;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vv1Gf8/K4oYenCuuubismz6olxkF2nKel+L6V2pw+3LTWoAWcV28h9b+TBI9QJAIb
	 oO03/O7gk2gf6aR48e6Lb/+1T7qsviZ6HqJ2GLYmCmlhwee82oj5R7UNKu8cz2jzr3
	 Z73jqtAUURePrOeG9htGDYpV+8e0odo7K9frjJQ5CEwpnaU0EK1uNqH9U3EGwP8CNZ
	 +xMqALEtO2fK40eFN41kTrOHe+EeWOCDv9/512lIJ3tEbG906aLr3rxh4igolYiq3e
	 wlwdCgHhS2iCoXeK3QGJC8RaSdeADFzK0HhmxibJ/4O7SGVO2uovZQzT7CGYadmq74
	 F0Zq6mwCiIU4A==
From: netdev-bot+sinfo@kernel.org
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net v1] net: devmem: prevent mixing fragments from
 different bindings
Date: Thu, 08 Oct 2026 03:45:12 +0000
Message-ID: <179143111228.2527009.8261160290330374252@kernel.org>
In-Reply-To: <20261008033952.1399670-1-almasrymina@google.com>
References: <20261008033952.1399670-1-almasrymina@google.com>
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
