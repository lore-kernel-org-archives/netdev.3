Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909840;
	b=FFALBYGJBiapkTsv1UVLJiMKDHQec8Rgpq7sWNMnF1OtkCWtsvWEQt3eFD+ZykO5C9da
	 d6KcJImhpRfq3unOtrChmuYM32Vhg1VA3XDUk8iHPlaE8s3L/hBe0tR3MhMaU2xhQmmdw
	 kjpnkXhH44XOs3kXtRuP0dwH8CALpuEjofp+XRZzD2bnXFeUxj25/JkYutgaZJfVIV2rX
	 H9KW98E6iiAQsgo9Nnr/lewt8uDGGE/Vvzh06GFYZfPH/V+FUEYDzQYgZzdfj0AqCNYMj
	 faeGvSkJSYHHmzwCO8mSXOf3pbNLUk9uUtPYShqwqYedvZTNvDEMR8HZtHnLA0bhEPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909840;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=PLvEa/CZc+/2LGsM+w/5b6s1YyR3pd1IFYBO0geSLqPg6Z59exHW6wMtejuMgiF5tX7G
	 JsPG4ftHXTiXdoBa3wPATN7H7R9Onr4JEZ4A/zJtLsWGE1b4d7ZsHybRteEIaf88T1/f/
	 /jmY3bZqpstlpdQuU7SZbGzX66wMJavQttFYKZKVFH5uWjUA3IJ4LhjrUmkWXKospUmNa
	 gSQX1PwKiD4+9QRyLr0Lj0VnHRWkP9iCXhMNYCZJL3RQ9siJ7fMhYOEpmT0HjMJ/F/jwP
	 0ZEyoNNt64XuP39EZ+t4SP8UyV5UUQv2NOQEtTcqJHmUxbqnMRzjKmmPxmHI7XDvnjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+8rtpoc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC10606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+8rtpoc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D738D1F0089F;
	Thu,  5 Nov 2026 20:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793909839;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I+8rtpocashiiuqBGtkIB9ksSk4LQDcrIkatRmusZycFGibg1oP3yyX6NLzNaWNOS
	 QKlf+XmtrNO8oVduSgBiDOAARVTeWD9aBbyfrYtijLR9+KTk+ywyqHGf/2S3QLt14Y
	 9NrnfB06KoRW6aUVfrvHvenORIU+SVkTTB1XdxFDmLanMXYR8Jp7Oz4gAx1UJg8W3X
	 VpOKlCDloSIAsKZ9TPHcxyXzvFMtQ1RhV0YZruXRCun5XEKY/+xz1ObzBirBVf8A8A
	 6J4MYQaJ/8zCeZy4Z9QkTvSKDo43nSHY+va8eEPyngm1sB5xmD/SOZv6U0eAtedE/z
	 uY1n/cyz2o4Nw==
From: netdev-bot+sinfo@kernel.org
To: Matt Vollrath <tactii@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>,
 Justin Iurman <justin.iurman@gmail.com>,
 Alexander Aring <aahringo@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next 0/4] ipv6: fix stale transport header of GSO
 packets with extension headers
Date: Thu, 05 Nov 2026 20:17:18 +0000
Message-ID: <179390983837.488859.4719265601441033954@kernel.org>
In-Reply-To: <20261105201309.3182307-1-tactii@gmail.com>
References: <20261105201309.3182307-1-tactii@gmail.com>
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
