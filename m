Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065480;
	b=mRC6fPrD9NLoRSKY2BagLmEzmI1+qEdayEbQLagLBmvatjuShbvtFR+am6ZmKmJCAy5y
	 8QpzFPVg9X9YQuvvMlPc/ud1ROupH0AfgYWcF6YLr21y5He1JUwv0J942QRis17cfY/ci
	 s4T/Ivel9TVQBMLa3vPqYc3wwxk2zFg0bYvDZJVuY5DtSaM0mn+DzErcWI14jsB1VHBCI
	 lIjHYUTA6cxqaQsFp8LnBV9IviOZ+hgSdf3SUdtEnNNM+Ew8brVQ2nHLwJQCNXw6rNKKf
	 xtWI1fPsXQop4kaoLtZRSIznhMQKJf7NKCIAejGgmiq33uKnbMP+mftpK1k+XmRpYsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=GE/82ShbIcRwbD2+3lSbiGiVVzvkCNAlFwZbNixlf8ErUJrzJfHWy0XhlWqKxt58XG18
	 FHNaJGzIy1IWS7gO4mMD/LRtsahKaL0YMrYeRERv26sRRMUWZfyyLQhCRa4HAtbpYTFhN
	 il/HSSU8GO2uYW+6gYbd79DNYZ+IqcNDgIOzccYiiSZjLhsh93izQjq/ok8MoCQMt0MVI
	 Za5VIDkCXNNewSPr2n3AieWjR/HPiuHscLkMtDjm1VXzQPZ+YnJEvHhelRZNiA62oyk4z
	 KxLND5QlM2Nhx+UnENwBMRqy0aIskQRSW7PWbqw6J2sBLthvd9RRU7kIcsiyHhWTdWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMOWIFxR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F10606A32C;
	Sat,  7 Nov 2026 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMOWIFxR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ABD1F0089F;
	Sat,  7 Nov 2026 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794065479;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IMOWIFxRujqZ9/MDxSl9Y83wSxAgbgWAc3vLiZwK+BWY34yd3y4F7kVE7Kse/I1Of
	 W91OY44I18UYNgMA0p1jWmG23isWpPg0KIpvXGt6GPT7kF/l8nx/PTrKG6mwPISqP9
	 oS5Dsx2lnxUi/qXfirR9Ac2MVNIDOx+dL7TlHfGvMzMcc7cP6omb7sAYe6lTgrn/OO
	 uz7z5NImtPxpwBZ9CrKYgT4MK50O27y3m+Ue/mWXX+2b4Y2Sayu1L1OkMkGtiohurl
	 rhB8Ph6vlbRDCYiov+4WVOlhzbG5dqNm8iIN/g8I10NcjYBNha+pKk+QPdjqIkyyuo
	 z2vLXNTXbRU2Q==
From: netdev-bot+sinfo@kernel.org
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Thomas Graf <tgraf@suug.ch>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: ipv6: reject collect_md tunnel route without inet6_dev
Date: Sat, 07 Nov 2026 15:31:18 +0000
Message-ID: <179406547854.488859.14783951723864254644@kernel.org>
In-Reply-To: <tencent_CB9E1044AC97882719FF3A9F5B410A562408@qq.com>
References: <tencent_CB9E1044AC97882719FF3A9F5B410A562408@qq.com>
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
