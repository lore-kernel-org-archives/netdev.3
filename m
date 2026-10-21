Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598453;
	b=bM01OPMxmwRB+Grcf04LhU1Q78JShKJy+koE7MRsDIKHfJpXz8HaUdIkx6U9RH4KRuo3
	 BYKgqgQDwWHH/AYn5qwEADmOeB6lchhWGLCSUuQSf4HIKQyeWzzL4sWTnKUehAuljv4qI
	 Ou0d8jrzZGZxLwvOMW+FHefm/viFqMCjbbQ1XazYxai23MGVUx2A6LRWOAgVpaDW8OTol
	 HQVPN6XLVK11bvnIwj2jMLz9vfvPHNpomRPwIxrs1gdfnwL2DMZi+Fq30Std5x9uPQy5O
	 NwUVYlu/4zBuBvF4CsTP5Rke29CVJI/QzGdxBz0RikvqP+DS0EDCbrDSt8TI4o4zSSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598453;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=bhoZZANj9eBPbV4F17nrupG+hcIUx79bXX7E+dsHGPXQ6MsfCU7Mn0Xt4Glz3Vz/CGCs
	 1nnoQziEWz664f5Nx81ZboZGDKZ4utG1fNGBtgf6khD7MZeK9Zc/azJqh3MxWUg0GSXPa
	 awca24voJx7uM1jo/9M0iGmLN19WRhErKidRc3ldrwuNr/eoqtwOt9/G4wVw2yC11ZuYT
	 JZVPgPSVJ1P8qfCvcH85bxibYu9I9aaj8ha7uef0Onem6GqgHX4EZdylBB+Rgrc7WfLTi
	 q/pkTp8xMJOm0NZKEgZ4AWRdK/tJDlWpV+8XibD6VfXLe57n9G1dVOjVFJ3oCHc1kHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cH4FVE7N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B1606A322
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cH4FVE7N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED97D1F000C2;
	Wed, 21 Oct 2026 16:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598453;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cH4FVE7N6jnPx9scAniFhExAf7eg+G8qzjnt+EC6IjGcQEceoLbGfGpadBru0yhMw
	 y8Y6jw6PsZA1alPAMIqbsc8IcNN6NysZ1kzrH9FXmT10o6w4FHImvRGjQtl3CcM+b4
	 2WU4/zegRg6X6JB0ce/tUH+5ZQPUzoN5i1mTSP1+fzdtBa7i9h3YqSRmSivRR6h+xS
	 ijGsy3JyTYPPGLFo5RFroO5xjX+Ej7CIgNtJDHNfTkOhUPCDTZlnqsKhC4rd/NnRaD
	 5Jc2KbWYXgJTPd7qtUEnnDNIgkCJKNyVMuy8qH8h0nyQH/xi/dzP65Jgo9i0ncuWjb
	 lDY8J35eDyLgg==
From: netdev-bot+sinfo@kernel.org
To: Dudu Lu <phx0fer@gmail.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org
Subject: 
 Re: [PATCH net] net: page_pool: bound queue_idx before indexing dev->_rx[]
Date: Wed, 21 Oct 2026 16:00:52 +0000
Message-ID: <179259845250.3290.4918122391861397887@kernel.org>
In-Reply-To: <20261021155611.68473-1-phx0fer@gmail.com>
References: <20261021155611.68473-1-phx0fer@gmail.com>
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
