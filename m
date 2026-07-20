Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A03D1A99;
	Mon, 20 Jul 2026 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540859; cv=none; b=kZt+QyVQsMNm0aZV/biqzjFx3bpq5SDkZUsHBZ5I22Ja9IcchKtAKv/MSDZPyNfCage1WiFjlObC5av1roTs8dKB2W+VR9pM8fR2B64DgKLfHeEambKxpmv0dnw0mqBKicow2+ost+am2nwE+JuQdonhkAR387CCnQkwJ+QunAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540859; c=relaxed/simple;
	bh=u0umNnmUv8nl59ZFfwBLEx3ih1YkOUievgkIpPyxUI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1AZx7ScMmXPBB2oTmNvZpSYzYwQnURxosuFCLY0Lv5GAC5sLPRhYPWhpgVKBQPpGJ1PpWtxB3Cjz/iBpnU0u4wFvNUMQ3R8JzysrF3BqBlxlOMK3eb5Zwzb8gpMIhMde/M0qEZTEfx5pGq8Itw+A07kiN3+J8Kp0qxPZbJ0VfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Z1FK8FVA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Z1FK8FVA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u0umNnmUv8nl59ZFfwBLEx3ih1YkOUievgkIpPyxUI4=; b=Z1FK8FVA6+6CZmZx2Mm2CKvAVO
	8PhgsxQ9ApLybTYbNbFn90PkGLXyi7ago1hTHx64iXY3VqlmQ6AFObfaEmpz0uskZ3ccsodvnZEzR
	+3vFlgX5HRrXVNRlAbAdcas17SEAQNmgBnnVYoy20shKbDWq3bUi59w9GZpWqLDP0Gb4yku9C0k6h
	pKHkBzWYlN3Tw7cBu6ggdmFwMbeeeXc0liEGP54CnFXPhRusBid7GEkQABtFQOzGxOGgktLP5q7E1
	U6uy38WX5JucRSGswm882DbB8kJPp/+/X0GUgytOlSNF34a/QAZNdZztCnD5mELAwcSpR7mXH0oPj
	SqfIWGfw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlkaf-001Lih-07;
	Mon, 20 Jul 2026 09:47:13 +0000
Date: Mon, 20 Jul 2026 02:47:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] e1000e: Fix out-of-bounds MMIO access by validating
 BAR0 size
Message-ID: <al3uh7OU2OtkEkSY@gmail.com>
References: <20260715035850.588070-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715035850.588070-1-pulehui@huaweicloud.com>
X-Debian-User: leitao

On Wed, Jul 15, 2026 at 03:58:50AM +0000, Pu Lehui wrote:
> +/* Minimum MMIO (BAR0) len, the largest offset is lower than 64K */

Why "the largest" in this case?
