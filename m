Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311560;
	b=Acu7oOkjV4NWF0HiMEstob4lnlnBXL3dWoLGqh8l5b05Xrzrdj2/ioLRps4AZdnYQbY2
	 M8nydR076Nxg85q6vdTTnIaOxHV+SGcC78S0aT0JfXPQqrtFsEqD1YRPccwu5BtxvHXcE
	 jIyyLdZLYeeY/WoD/GnMSI3GkHb8qcLGhcCE8TpABDqGCI9E1jualgIv8Sjer6rcNaxKx
	 R+Yww3qWslDZ9rVIl45NASxcYkJehiJrp+qpfuPZaZ5pLxIrIUgXOMYCk0zAW6gFLcTW8
	 QDPOMqhGg38uRYaAwjXHvsofaytDyGno3s0NmU1EvYF0XnBc+QlMTksLt/sGKQ+uBcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=YPEmCaur62trmDtJpKH/mPqVCJXKqd0yRo3oXthugtl9j5yDen2E9Dglrqbgo7dKHU8a
	 dxCm1FYlNSyFO1QkcVChB/Gu7KYcykWx2pKaGN7HFOI7g2rssLkDzjjYqdmsRGgz9E/GN
	 B1nEwaK73GzIMiGC8/FUfgh8o4Ntq7iHWGBLO8uzQw3wyg6jfJIJy4mXHvlut3sJ3+Y1a
	 /GjIbctCq0I/LHHCUZQu7/Jm5bEPfXrCintgB012vd/EQH4Mend/47EapDOlVxhWr1mRp
	 axmAdg5OEOIVcWf/PITBbMFFptNYefvSi8fwpi552ULrG9lbysJ0/BNnQXLbf4+eFBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgOBzyu5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75E606A333;
	Tue, 10 Nov 2026 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgOBzyu5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235DE1F0089F;
	Tue, 10 Nov 2026 11:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311559;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bgOBzyu5TeEbdRVqTitoEWrlhyCpEJ5EoBbZIek0w3vtI4G0CBEB6YDDs0lWI0aWf
	 yoUUCoFhE9zS9nzhl5+uBtM82pvsZ5RdlAgO/DFeYbRDrk8pOwearQglS+gJkUKT5a
	 4fVkjINiG6Te8kj4cg8Nnu8YjKgPDMcuXbRreU/+JkLRvWoQ0SP4ttoAyIeyMAp7CU
	 t+MSqeMKCCuc8NCwLkuIrJspoqTgr/MxdsiTdJuw+M3PF32p4O0Lga/9cdJ2+hFRlm
	 06w8UyGFYP8e+yyjia0ISXPEiIvvj+IofGumf4WHdDETWJULnP3YhRRqcY/0Nfq1y+
	 9GMFGhWlR+f2w==
From: netdev-bot+sinfo@kernel.org
To: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ipsec] xfrm: account XFRMA_MARK in xfrm_sa_len()
Date: Tue, 10 Nov 2026 11:52:38 +0000
Message-ID: <179431155869.488859.10143317051771395220@kernel.org>
In-Reply-To: <20261110114623.2659197-1-yasuakitorimaru@gmail.com>
References: <20261110114623.2659197-1-yasuakitorimaru@gmail.com>
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
