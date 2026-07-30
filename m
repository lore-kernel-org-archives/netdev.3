Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDDF42D778;
	Thu, 30 Jul 2026 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416268; cv=none; b=I1k165IGFSiEkpbF5qQVq3/vCkqUWCfHvl7Ay1xrOTuiwFCRkGOb75e+a0oqGveMESjYFWi5x3nej2T7kaTmFdRR14hNCYAeOZaktE3Qw2S3zqGRuSBJiU2FyFW63T3eV8QWZQriduqaWPDaKRCQNBAUK4SkuUjh8Iw6gcSGnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416268; c=relaxed/simple;
	bh=wN4vwMN0PJpm1LQT/APGgf2hKYQSeNBZlYxoVq1txsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbao3TEghULAl2orCOqt8vtd1L9AlwllbGP31JN20vCM2MjK/pMS9zYI2aJ6gE6Dy8j+cq6xnpoM2gzRNtOBQwhLXN5NVJIxcRu1oBHczx1yWfzOivBgmH92W8+sZGexfNXI+fcQnc10zqHZNWh5nvMg61VQKSMV6nKi1OCtXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YWoU/rGf; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="YWoU/rGf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eo5zjBds4/vL2gGPrcfJnsMCeXyEU5sylwTc3v/7lnQ=; b=YWoU/rGfBWckFZmmphViempVjJ
	V9Yt5qEeGhcQpiXcRLyWRcnPPwYgIOv1vMy9k5h1CQrlqXJTNl62xE57MuP8PduSJqYmDr1Yghcl/
	vNB+Vb5Qp2goCf/5HEXMJncocOFhgWyLE5J6OLfn3Ad9YyrZdMS9icYdVcHZpfZEi+x0zonwlhYfI
	LUcL0/LKfkt4DZ4yeTFJzNEisoVJvxf+7exESZen0S5N+JgA5b8tvoDL8l4Qz1mFITGIlgasDzJPm
	5VH6Y67pCEwuileE3S93DJeXzeFZFBOERso4dRfrI/Y78B5I0LP/RaxAuYbS34gl0bZT0PJd0XFR7
	X3hoiAUQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpQKI-009Fs5-1W;
	Thu, 30 Jul 2026 12:57:30 +0000
Date: Thu, 30 Jul 2026 05:57:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Taegu Ha <hataegu0826@gmail.com>, Kees Cook <kees@kernel.org>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ppp: use netdev_from_priv()
Message-ID: <amtKE21lDJuBtjGd@gmail.com>
References: <20260730100654.745-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730100654.745-1-qingfang.deng@linux.dev>
X-Debian-User: leitao

On Thu, Jul 30, 2026 at 06:06:51PM +0800, Qingfang Deng wrote:
> Use the new netdev_from_priv() helper to access the net device from
> struct ppp.
> 
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

I've looked at the convertion and it looks good to me.

Reviewed-by: Breno Leitao <leitao@debian.org>
