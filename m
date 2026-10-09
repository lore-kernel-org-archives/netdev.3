Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BA3EDE6C;
	Fri,  9 Oct 2026 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524651; cv=none; b=n+H7x1p6hC/ERLhdpyK52ZJ1Eci1wYl0HQNc41zom3GRDu1IE32gxVXGb9OqP4DgJvbMXGTu0pf/GjshGeb+QgorK1LHi80zm8W4SvF1WKp69MLp4cjm4UoTl5oEemrxAAiIpIGDJG9YquQI+UJWM0TotACl3GWmNlo7cycUbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524651; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EycjT8N0S54eniIw8c3kcUfisT59COwMq0muksFBIXUtGfh71pp1WmxPyBS/kKPKZM1zHOyXmsFdyNkv8/H6zAWViHS3kfGX+gk4ZCEmh0zZ4BEB52Uzsr84r8v7SHJy3yfP/mt5rkNpi5FSLdA5BU5QgfIl2WstpVfGCGJpHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/oUiw0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/oUiw0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8761F000FF;
	Fri,  9 Oct 2026 05:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791524650;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/oUiw0Usz/5QkhZs7kdRiF+nsCvD5va0m6qyk92dxiWMRhzydQhOUfvOxgY50HI3
	 cVF72DYoHAKk2lSQP5dW/jWENxdHtjK99haMw50KME+UE8ZCyBoBSbVx16fyCWKHaW
	 vTxUTEDrWpCI7pZmSJPcwuBrJ1Xwh2SnggvRSo29AhpYHHnJmCFvxUmXNAX3ssG7m5
	 6O4CXdOMlcSOgiZ3XLuntYaGX17Lp+RFz+Oyrj7fWEVC6c1d58eXAI594oHiBwDu4n
	 nZgAyPRngIMH/iPoNgq0IPhWmo9JXaTHZs6XZr+Sd/fap6onl+S8m9FaFBeGSm4B2i
	 iS15Ni54vJV0g==
From: netdev-bot+sinfo@kernel.org
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/3] ipv6: fix address publication races with
 addrconf_ifdown
Date: Fri, 09 Oct 2026 05:44:09 +0000
Message-ID: <179152464915.2527009.3889155025831898857@kernel.org>
In-Reply-To: <20261009054042.272944-1-4ncienth@gmail.com>
References: <20261009054042.272944-1-4ncienth@gmail.com>
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
