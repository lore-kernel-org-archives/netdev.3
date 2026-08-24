Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA73750CB;
	Mon, 24 Aug 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590808; cv=none; b=hr8qcbZGtucZXZoEu6Rdqtff+ViobSWMl2iwKbHJKw3BTvYSNmCJFPvJcZA8sdy9z1ZCUnyZxJPKLncrUYuQbJYZ5OTXKGBCIQ/m25t2hYZBYph23a1YNPuzguoA899lgs2hgihkSO6FoUBTLhaiYDam1LdqoFtc9DKe5ISFQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590808; c=relaxed/simple;
	bh=I4jaLVzNsjtArQyvVE//prn+aV5tdEhfVYE10dwUALQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETFfrdUpkSD75zCOjzGitAwMCH3OI4oGTOmhgyqh4lFIYLyiAjEw04sbnNzDwUgn5CKEDAQuojMoyQ1egVY7n9e7AtilaVT6PxxDMTreQq+F1eqOHFZDyDrHQh32KocRlTEFzS+pNCMbPgfdH1wMszlMclztItKABEjBO5bDCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5kNUgtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5kNUgtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EAA1F00A3A;
	Mon, 24 Aug 2026 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590807;
	bh=hv8q3TXaNThV8Aadg8NB+0l6AirvPjxyxujG62Z8ZMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a5kNUgtnNuRFOXmi4YqrubXqOp0JPlE5c/rWG8mUs+ujXJK1JHFnLi+DS9uFsraNy
	 28zal3u8owOUNIKLgSBGFL08MFk1+vd6PIvVnxXyhQS9Un1mJXqdhfaBZ8K75Irtqg
	 VL44EyWxvbqe9DAFue0FsKmTguH9VQADapH7DHURtCGoc8RwGlu5DxSlfLErMRM3L+
	 dUXIqq6Vt/U2RlkNo/DWeCN58Ga9JHkSuK8HRHCzjh5Wnh/h34iYIv1a1b3CwLQdOX
	 s7mWryiRus4H1Q/7mrrSh8RdMhZbkfz0eeMx/2YRb3sVYFujSiBDypPbAHIxfE3t3N
	 ChRgcq6Lb6TyQ==
Date: Mon, 24 Aug 2026 10:00:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <han.junyang@zte.com.cn>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <ran.ming@zte.com.cn>, <han.chengfei@zte.com.cn>,
 <zhang.yanze@zte.com.cn>
Subject: Re: [PATCH net-next v1 0/3] dinghai: firmware handshake, MSI-X
 interrupts and async event queue
Message-ID: <20260824100005.06661b18@kernel.org>
In-Reply-To: <20260824033249934VsArgTPOU_qew94PPABbD@zte.com.cn>
References: <20260824033249934VsArgTPOU_qew94PPABbD@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 03:32:49 +0800 (CST) han.junyang@zte.com.cn wrote:
> Subject: [PATCH net-next v1 0/3] dinghai: firmware handshake, MSI-X interrupts and async event queue

## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed
