Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3E3D4125
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791349218; cv=none; b=FFxyvZa9HP52E6kPsCuZZq5ji6kFtgGlXdxE6sXGoe07kAHGgOtFbvhvABirovJ+oui4di5l5ayT8wenXKO5cr/rje5AbKeejhA9QceTRTmaw70xntw2/kVLWjMoew7gW/sgX01Rs/sj2Xv1xP2ARTSwB5+K0rQ+px7LNTyAWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791349218; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxnvOewiqoYhncXTVngQ7UrjFBNN0s9Ua5mghumkWwtYwTnaWlF+mo2czF3XaczkYCGQAwKTOe75dAxA/5ZfgKyCKHnSKQHJ2h8WZ0se3hkd0RCjbDKO+DzmsVWEzMIuPS9hq8PyKuuTwH5T922eLbuUysKLiSbC6BTWHOVuUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh9g+aPT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh9g+aPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9331F0089B;
	Wed,  7 Oct 2026 05:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791349212;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uh9g+aPT8cjmLDgmt32p38no31mi9DQuf4+rAKC9tQkEM1sIzboL7aQWEdEdmQnqy
	 xf723cGCBEr7hzh6QV8eTrQCr0USIOtgBL6ViXyFCdxXGWD8GZCh8TOnDZxbXjffXt
	 aS7vBIXo9f8zH/XRCL3iu3xGwmwLhWXvRIvp3iDKwY+mJ/clVSs3Vq6ovfIEmMzCrj
	 e04Mr+VuKrJozZ639ssCoDJk0/pn9My/QBnqx0xbbhcI1LqiZpdDtZIG9HeT51UdlI
	 g4AyM9+hyCL/RDyzkG9dFZDPte5QqcHh4zTaijhjYXDzZeE9r6X9IwC/i9KtlK4T2a
	 fhDgEiDggHMgQ==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] flow_dissector: avoid u16 truncation of hlen in
 bpf_flow_dissect()
Date: Wed, 07 Oct 2026 05:00:11 +0000
Message-ID: <179134921160.2527009.6970913813334453403@kernel.org>
In-Reply-To: <20261007045616.445596-1-edumazet@kernel.org>
References: <20261007045616.445596-1-edumazet@kernel.org>
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
