Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880874;
	b=aAqGd5AfjmnxP8u/3ey88ChRof7a1vej8oDQxSSqn13/WdJYFHCVN72hqp4hXawxLXau
	 lJauF22uHaRwPxHwiOnATo1TZElvfaziWFD/zMTX6WOu54rhTwCUEMfDS9IymDNQAq8w9
	 /wERjQ+l5VQzPou4PQuyErbVdKg0ektvXR3VNibdroM7QjJWSzVjaBjwDVmRL3fCvUTws
	 XIWw+qWMGTpIGm5NP3dY9bhVEs1nTiCW8f6A05E4TyLRTC4pkTAlchLHSxc4RH61zfLlL
	 yqP73NJN0nBGnQuJQ0B9NFNRNzFEYuDry8fWSvcYlwL7gWVTsWfpGspN11nRDnSel3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=xFUlG98oe/A9GWMhFw0N6hfqP/wG724UeF49Sov/aapb4tBQdH9QBUzX+QratSRTuZE7
	 PaIRENskucxkLjvNdYSubmtNdvxpFeGRMrkDduDcbdguCUUae3FlNF0l/vYuIDlKRkr9e
	 JOrXPXmjiFtl4aK0x0jZby+4yxlEvZvCk/5ySG7xBMTO3HdtR4jc/hjaSeanWvlFjNJ20
	 8Pu3p4P8M5esIuBtFLa8I419aoePyloqwkp/7n2+kYtUmd1S5F/zXtHnaHzWYQE2QbME3
	 2Gq1Jwtj5NZ24iBPpfaUgBZ3xKFi7fv4lLviJdXtnhv8/7cHBBklQMU9ygv5NmImFXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CADItmgO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3539606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CADItmgO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34191F000C1;
	Thu,  5 Nov 2026 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880873;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CADItmgOVxnJf+3oE8SsmeFTayXo2jvOcatV2siwRjq7DRgtvjeBOOU54Xgpdq72R
	 Z+OmYPXnqwQxE3ptsKiDhcDzoS9pre++It7qkcm+RQIFST6jsccRD3VjQ8dOpqNT51
	 6PXfohW5Czn2nm7gDNNFsLMrAoSvGNqjkPLbXzPNv5K2t359yVvN6e4WlMBgB/PhkJ
	 orRaIiKyJgUOKADfl20n52IRS0tNfBdKg6G4CJgIdtCYs+TrrvkoTSyJCNXh2WuqeA
	 K2G7KeFPNLWgfKLtHN0FUVZh7AziA0FYga+rdvspa14G1QqHPEVTqbQICB5US6xoxb
	 Umyqdjey6qcUw==
From: netdev-bot+sinfo@kernel.org
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 john.fastabend@gmail.com, sd@queasysnail.net, netdev@vger.kernel.org
Subject: Re: [PATCH net] tcp: do not coalesce segments after FIN
Date: Thu, 05 Nov 2026 12:14:32 +0000
Message-ID: <179388087223.488859.8944581143377701563@kernel.org>
In-Reply-To: <auxx1bK0QJfUvcB7@v4bel>
References: <auxx1bK0QJfUvcB7@v4bel>
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
