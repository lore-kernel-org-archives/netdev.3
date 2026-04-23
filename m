Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1C3321D4;
	Thu, 23 Apr 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954511; cv=none; b=S+ukjzcNWX9ol6umTXXmeuLIuMxSJT3g2OdPSWQCOcBeJ0j9MN1S6fjq854ICl7hi570qZOA7znkgsm7M4eN7V6lg7zWGZaJM1MEt/crV7PvdVlwyDvWvi3UF8CHpyuSf6xtE6vNLsU7EVHe8fYHTs9ZYhFikPgI8ZNDE1vKplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954511; c=relaxed/simple;
	bh=m3WdUh1eTSxaCkjBxdgf/EsAHUPINflLtxnbUyDiIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdkW4FgrTOsKBAizjo3VEmz4GEwH0gpBllZAEKPu3fl5y+p+oVi+xHIOCOukBIh5oSGs14TT3pUxf9jmXfc/zDDCTzCt9G1LNkyYQL3Jhyjql4yiIHW9q3clwGg72rD+iJ6zjdb9/wFdXnVUBDPhkLHJMJV0ROoSMMRfPo/XQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knHylu9E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knHylu9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99405C2BCAF;
	Thu, 23 Apr 2026 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776954511;
	bh=m3WdUh1eTSxaCkjBxdgf/EsAHUPINflLtxnbUyDiIXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knHylu9ER7yCBMJtyA2d82Fp63C36emKfNtvRDSoC+565P4yf/XAkCiCRjzZJ9FuS
	 aDdqlTGvOl1PBgMOs0LCRcvqO28Mt+xmlpqMUfDq3Ye+oIBNrjS5Y6sbs522HY5alz
	 ax1M0M3oFgVH4RUEKWIjDWGAtu05IuDxxi0DcTJpHHb8B4DR4lj9IJsfX4X6KR94Qn
	 ubTQYXNteY7R8E8y+aJg2KX1FqJO3B3YirNf0lvWP1oFZG2r2fEJfH1RfiBd421NME
	 nDh8zgZkmyiDOaLUGgH5evVFaJHpnSsjaU8f3GUbP9CFrdx2fNQUfRdPeUQQ/KBMy3
	 U8NzQz5ft6LvA==
From: Sasha Levin <sashal@kernel.org>
To: Jay Wang <wanjay@amazon.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 5.10.y] rxrpc: Fix recvmsg() unconditional requeue
Date: Thu, 23 Apr 2026 10:28:23 -0400
Message-ID: <20260423143001.item002-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422222432.7236-1-wanjay@amazon.com>
References: <20260422222432.7236-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Apr 22, 2026 at 10:24:32PM +0000, Jay Wang wrote:
> From: David Howells <dhowells@redhat.com>
>
> [ Upstream commit 2c28769a51deb6022d7fbd499987e237a01dd63a ]
>
> If rxrpc_recvmsg() fails because MSG_DONTWAIT was specified but the
> call at the front of the recvmsg queue already has its mutex locked,
> it requeues the call - whether or not the call is already queued.

Queued for 5.10, thanks.

--
Thanks,
Sasha
