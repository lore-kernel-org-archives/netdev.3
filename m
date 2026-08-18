Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB623859EE;
	Tue, 18 Aug 2026 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065492; cv=none; b=AtZaGbSgLFcu2NMwN90Hn+2DkJGiogiMIYFtEHQYsGg+sM6eyIm96/PQFoJjvpjskR8wHChbFHKaLU1EkGZez18YzlGxcCvM+cMsttG/Cqoai2fCngADNsZOqwPGevts6xcinN7mUi9sVtffhEYeOeHBIWJl/FgOiMYy6wF0c4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065492; c=relaxed/simple;
	bh=m7R4kw2oq3wo5F8YOmLtVdXLlUvrWnJ4bIKWAMHzSdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDMkDvn/Rc39+9jZDh2+dUXCW33k+rjdx2lGCg2G9XKNon6G9xr2IQXFwg2ZIxBu+LnHz0Peiyt/gZaSU04W14ee12UcEb9PJxgZ9Jg3Ogv7lwecDJjRjZwEtQNKMGLJP0gS5r/GAhhAwoUFZHetaJHjiD5tfnPFlN3X/iulc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg45YUpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg45YUpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F961F000E9;
	Tue, 18 Aug 2026 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065491;
	bh=QMF/k00A+M1XHfFhX1jiXE4OeuC5rRDr4p+usN3kA9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Sg45YUpY84v7AXDKtFlfxy1T2WdMBO8FkrFLsQndraP3QcfVMoQdgkIh9s0PCSKGl
	 IB+zjlvbby2cq5ZrsMufkYSD291FftX/t92jtRhM/52nV7ArGelIpte+mGJtBl9ccD
	 SpzdutzUfPWvn547irtkpDhZNNBVtQ8oq+9AgBVbR7XfFczHAEwCIeV4CR2be5ycAQ
	 ZEx8n45zUgUGx7/hTwt2Gnt9FdXeOuGdeRuOpwNF+I222+Sl+Oj84i8nYgUcBIU2cq
	 pKM0DL8qXKUg+xsGwl8QyJEbW354dJ5Hl5DRDq8B4waETfX/JmB5ogn7eSopDbsCbU
	 DNhjC3xqDpxvg==
Date: Tue, 18 Aug 2026 08:04:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 richardcochran@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 muhammad.nazim.amirul.nazle.asmade@altera.com
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: dwxgmac2: timestamp
 interrupt + Agilex5 fix
Message-ID: <20260818080450.7e010425@kernel.org>
In-Reply-To: <20260818132722.1852876-1-zxyan0222@gmail.com>
References: <20260818132722.1852876-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 21:27:20 +0800 Zxyan Zhu wrote:
> This series adds auxiliary snapshot (EXTTS) interrupt support to
> DWXGMAC2/DWXLGMAC2 and fixes a regression it would introduce on the
> Agilex5 cross-timestamp path.

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

