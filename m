Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DEB363C6C;
	Thu,  1 Oct 2026 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842155; cv=none; b=E0zGIACD1zH8w4SEtNEZ+uSLTzIqfdTFCaWtpRab1VdsCufAqBW7VDaVVgRQnIEpYzIr+SHs1Ppn/dOvgOlMMxwwc7eOfPoqM400U5H8OpwpXcV8bulhoPn8QU1noEmDVUssqWgLkXhM1Syzb9WvLJIQ3JO0DSOt7bBvfTtlhQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842155; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDLb68Hx3cTvz+f2Cup54lV0iMOa6Bc5R4wGLFPoYBeITIHNUKjSJWWXre0elMDo5gr3h+2ttnAiNCEPUWBbLhfCBqZsl7PqURuKA6M+BROeanwLTcdS1gJtsJvOnmpXkb75NPVKxccYH7LLsHrmR/ZkUoaia6qS7tNxlEs6mjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6J1QoTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6J1QoTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5366B1F00898;
	Thu,  1 Oct 2026 08:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790842153;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f6J1QoTm9Q/JTfvD3wlY05wSEuwEknBo/UOWE8VZVpyoe9QHzlKbskXtR03JFwRbq
	 v+Ht3vVtqhyMxMyFtIq1pof4KT/4o7P900ZgqWVpEu1/cYWlvzmX/3IoKxdQfwhNdB
	 GAIi9uwo7R3BYE9r+Yjbz7OF3LXKOCpvCTO8wPRE+qNHVVEGMzjjUNJBwDIvbOJyiP
	 8mPNRp0U9DWBxoAX9QL+ZX/sXne0yk+6/FXA7e2uZ6gToHGX+bGYjc6kG7EqQWjqIM
	 9QnKyeO3xvTZq2jCpIfdB//Yv6bub8a021ENsQ94NpMt+cS9PL040QYqH6rO4DuseY
	 FTjKamuAd+pDA==
From: netdev-bot+sinfo@kernel.org
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Min Li <min.li@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] dpll: zl3073x: fix output pin esync and sibling
 notifications
Date: Thu, 01 Oct 2026 08:09:12 +0000
Message-ID: <179084215284.31693.16414064063107147164@kernel.org>
In-Reply-To: <20261001080648.1424172-1-ivecera@redhat.com>
References: <20261001080648.1424172-1-ivecera@redhat.com>
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
