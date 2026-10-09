Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02247252B
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532456; cv=none; b=ILx4iCg8Dz75HKA5+JdKEFHIbkuUM7xRow69wMGlnsZxQffJM0HXs3OH8dh3W9Km2p2/qNQJ/YtLkwxEZUtX16ov7x6uGivBM3xWo6QMlT7wOnNogjIoYEZqSyIRC9jvKmNOsNXGyNB9mQfpf9X7KisxBsuyff3XkiJJzYgKbVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532456; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CuoQqUw6QfXYmRm2mHNfwxC+JDeCFbN8pJ6H++u0/vakBKvozjuYzLzYzObO2AjTXNsTk0WKGZzfT8gLJSAin/mhP+WemBd5FJf6puv4d25sVj67JTk+IR58+ZGyyGqLixIp/H+6WeROxi0CVzo6nCv7hBpzvH6x35Nv331oyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqMbTQMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqMbTQMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642FD1F00893;
	Fri,  9 Oct 2026 07:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791532454;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fqMbTQMpsT59Q5eu6uWtoyoEMlAoiCZuvFsrzDgl2YOA5LOo2MncJ9guXMLxrlIJ9
	 cjSJSszeJ5m9Skwj9vZZYY66bcgC6faYPERUEHFsHjuwB6MTDi04xJ9BVO7bfXdFd0
	 zfstGC1dvS0wKVnQgi8OE59xVTnSN0NWPMR4RQT9EYgKN/ggZMsU2ekFhb31FTWSOG
	 kIxBCfw8RdlAc+P54uUXV2oSXHXL+cUcCzU8tHS1uS1kTzNvCYNh/vlBlpLU0mnod+
	 jjh/kDLtfbgkMKE+dBh4zIgFlJ1dl2coEDLpR+q9Ju5aqtfHkTFvYRxaTp4iHIAy7U
	 hhqj04oEqm4Iw==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 Baul Lee <baul.lee@xbow.com>
Subject: 
 Re: [PATCH net] ipv4: use RCU protection in inet_netconf_get_devconf()
Date: Fri, 09 Oct 2026 07:54:13 +0000
Message-ID: <179153245396.2527009.9050120062583330752@kernel.org>
In-Reply-To: <20261009074906.729877-1-edumazet@kernel.org>
References: <20261009074906.729877-1-edumazet@kernel.org>
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
