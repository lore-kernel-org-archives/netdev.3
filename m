Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503419;
	b=F0HdEsr5L5ol082DzSRTyZBtVW6T41Yl2UGym8z79LYh1WzKl1GnWglmQXNysXA5tZqC
	 eE8ArfQWLJxd8bs+gQuQzJAoJUwGatJ9Gi66U750Xs5kWoAoJf4dKZ4hZvsPe18nbYFHb
	 HIxjDqp6cm/WVwf7kjxQz8LuiTK0cuxeGU5NYrGcZMFTVfWfyGGB53ZQ4O6XeJyNFkOQs
	 VyOypqAUUE+CR2++gdyCOjlVKICCGFWVt+n5RUv8P+ksy7eFSPIfsa4TcI/m89pJTvz8S
	 KBAFA5dW2Zi57jMcljoO9+89NgKReRhU9JMnuGbTRLmB/NcBbh9nBbkO+dYyzKXuCcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503419;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IDIKLIBlCay0D/rJOxPmqKyRlqsV8uekf9GsZW7hCPI=;
	b=mW3PMJUGm3lGC04lN0/V6n6sX7Pm07fASFS62WIzfPiV4YFWhPi+pRasGb6Ndl0oDFPH
	 c+EFVrYDGQP/WMaj6R7PyF3kq+goTkhAlVEaaSNE4bW/4Gk4r7zQiVBAUnlH5gintZxSE
	 ehUNT0TlJGsX3EQQgIJAHhX8k/+TD25DEZ31y1DO5NxHyFY3iWkiynqZ80jnmCqYO1R9q
	 jwhlZdAM2yQt0UtiZPROuqPUs2y4QStEyZkZoAZ2EShtAueeZDv6y5KSObhXX91SmhwOl
	 qWJPDA/32XkCZRkrc4/CTbpLP1760m5+OOMrJ18S+ztH0gs9TNTVKYv+c1wkOagu1hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNbh2Mnh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC50606A330
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNbh2Mnh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995C51F000C4;
	Thu, 12 Nov 2026 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503418;
	bh=IDIKLIBlCay0D/rJOxPmqKyRlqsV8uekf9GsZW7hCPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SNbh2MnhgmzvPy2Ajx4onYNIrleMLoe5ucWW8C57OT4BH7l1zKjrZAt2pY/cpEJcL
	 4kGRLoKstjPc4XdaPTAPB1Y84rLXH4kLRxqfsNjCh5NP/9RYuqZly7OItPi10hlVA3
	 Fl+r1LsnA/OWmCRfrKszpL8oB4UC76nFHS0wRjQRKfquAgazXGLsFQjpTRNa9F+e5R
	 EcPSQpfMZPLvgDi8gG3Hqc8rSF9DHqBA7CCEEpkSzvgu03+599bUPRphOeZlv8cXVb
	 anb9zmHmXVNe0jD410KdBy8hEirszz/uLrYs8MEWLMIcCC9tAFkXtEkmMi75zxWb59
	 iWnyXO9b3kzlg==
Date: Thu, 12 Nov 2026 09:10:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: netdev@vger.kernel.org, skalluru@marvell.com, manishc@marvell.com
Subject: Re: [PATCH net-next] bnx2x: fix kernel-doc for bnx2x_rss()
Message-ID: <20261112091018.7a0e41c7@kernel.org>
In-Reply-To: <20261109211719.114004-1-ayush37735@gmail.com>
References: <20261109211719.114004-1-ayush37735@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 02:47:19 +0530 Ayush Yaduvanshi wrote:
> The kernel-doc comment above bnx2x_rss() still refers to
> bnx2x_config_rss_pf() and documents an @ind_table parameter
> that is not part of the function prototype.
> 
> Update the function name and remove the stale parameter.

There's a ton of warnings in this file, let's try to fix them all at
once or not at all (I really doubt they bother anyone since it's an 
old dormant driver)
