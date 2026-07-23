Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4B4D2EE6
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813551; cv=none; b=JUZrIX2rqCdRLAuu/Rlg0Z9HQ2PM0sMVA6jkZcukJotDMPgkqg80RYgxWmsUDUXoOCNEoV/7JrL5NLLyKRMQ0Nd6zv0UPk0g5SWKUCCzxqXEn392bS7vAZNZ4LDr/GsuxcBzzAUL4x24D8zHtqmaGORdFHwp50onvwgqyLcTHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813551; c=relaxed/simple;
	bh=+0vACtKkzl3AM+jipv0+8L7rcACtOOg37wCnFYZzMck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpgTp5+QGKJxAdUlFw99lUf/M3GdqxUbVRMfmpiJE/Num4jAmPOzNUHIutFOmUn2e5ZxnqL6M6xEnHQgOa4bND8p6twAVQEDySf6s9rZPIt1t0bibI06mwkQJ+vXWWzux0qMOBxlAihxRGv1r2YJKTP9zkb6PCtvSlSGFS0e1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCC21F000E9;
	Thu, 23 Jul 2026 13:32:28 +0000 (UTC)
Date: Thu, 23 Jul 2026 06:32:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: luyun <luyun_611@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 01/13] 8139cp: fix DMA mapping unwind on TX frag map
 failure
Message-ID: <20260723063211.7443fbca@kernel.org>
In-Reply-To: <9fc1c459-f72c-4b94-bf1e-290920c68d23@163.com>
References: <20260717103724.13971-1-luyun_611@163.com>
	<20260717103724.13971-2-luyun_611@163.com>
	<43379065-5916-42a7-8ecc-4b875ea53d22@163.com>
	<20260722124349.0bad10cd@kernel.org>
	<9fc1c459-f72c-4b94-bf1e-290920c68d23@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 09:57:32 +0800 luyun wrote:
> I understand and respect the policy on orphaned drivers. I take
> full responsibility for these changes, but I'd rather ask than assume:
> are statically provable fixes like these acceptable for an orphaned
> driver without hardware testing, or should I look for someone with
> the hardware to confirm them first?

Please don't send any more patches to Linux networking in this release.
In general @kylinos.cn are very low value, y'all should try harder to
focus on problems that matter.
