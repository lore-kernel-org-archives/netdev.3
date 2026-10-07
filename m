Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A330C168;
	Wed,  7 Oct 2026 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336150; cv=none; b=dh5UUBvXB8Ng3PnSlwAfuRwdA1X2uXPW7vbhpzM9QY2jmPNg1eLEOR8Fq29TYg07l+BkPdcFP+KNHYaHMSdujqxdDckI/5jNCziyIGNreEhDQEtGnvwSuQK9cx7v14C9eVqADOVwjLHDUJ+U56EL44z38Redb2Go3NW25hti5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336150; c=relaxed/simple;
	bh=sHCNkGo1kkjgF0kaxzsDLcYiXAZXHSi3zn//anF1E2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qeaa34kWd20p8OaSEeeOvZa0fr7VZQWaoVu2V93fvnBobO72Lw8FSibxLa28sZhI6F40HRT+LtHf7+9cqJZYZzjc1xznc+HCmLPDa+GIOhuimlbYjXlTXUXo8nDu09GaYCIDfpobZzw/2iPcy9XCJCzCRlXuk4hMIZu6gYTPuCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHyaMA2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHyaMA2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A171F0089B;
	Wed,  7 Oct 2026 01:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791336149;
	bh=sHCNkGo1kkjgF0kaxzsDLcYiXAZXHSi3zn//anF1E2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iHyaMA2IvOT9s+f3hOkG41CllDrbf63SX6TfpRlwiGYZxfKb8nd/eJU3wuykf8+5X
	 vLeMzz23JSgM218q10QIiR+1PdYr7ngeN7dzVrg5IjaHOFf1uYpvpQjCRS6/m9efxi
	 RZFASKGhR/LH5qrvYc7qSAWmOpXkFzkxnkney1K5XQ/TWDHeOnn52MgF6ai0yHZ12t
	 fNsJ9RsS950tbXE1n9kd/pSr/A/YXcJy2d+dyFnv65RhBCtuIWBdaZhlzVWbmwt2Qo
	 /evPGqCLToCycCv2+PiuaPx1Q3o1FWsZrzXO1t+2BnLjkphkJR28V2ZKVHXFkBqr1n
	 1SLUVZwUcbtuA==
Date: Tue, 6 Oct 2026 18:22:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jiale Yao <yaojiale02@163.com>, Jason Wang <jasowangio@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tun: Drain eBPF RCU callbacks on module exit
Message-ID: <20261006182228.39ae8072@kernel.org>
In-Reply-To: <willemdebruijn.kernel.2bb89b342a6a7@gmail.com>
References: <20261003093822.544964-1-yaojiale02@163.com>
	<willemdebruijn.kernel.2bb89b342a6a7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 03 Oct 2026 14:42:11 -0400 Willem de Bruijn wrote:
> "These issues were found by a static analysis method"

Thanks, added.
