Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020E37F011;
	Fri, 12 Jun 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281739; cv=none; b=AhfSkDc4jL4LnpX8BfRYamgF0BqZnK+1MVSwwTBoLqAvVTacYS7Q5KvaHzC+8XFyyJyB5MzaT2AMeOgeKaDJApK1nYz6wRezEiHqqqq1JJ4B/fOxwJg9DMldW3MQXibhmwP1oyC5dm83XuAt6Y9m0rR4tDPJmAsnHMVHhnMCbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281739; c=relaxed/simple;
	bh=PZmMTZXzRt+C99kbXOxkubEIlf4jhXp0qRPcLgjlSqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmwXAfsdvakQs11w+LWMf5Jga5WhD1fcr8xhXVFAt30pn3KuA+0EittEXAIXoSMbxC9hYzuwVUQnqiUnFS1CcqC7+GW+DjCeitFv3TO5oNZLEcyfwrMvnB0oPRMuX3okcSJMK1grML1Lg3n2BAdrwZ9GM54y4xQ0QMiub78nPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMyYsFKV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMyYsFKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721D61F00A3A;
	Fri, 12 Jun 2026 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781281737;
	bh=+YkxKUKI+ttSACYhasK/qyZ52eMUZtHTMnbDNaJgTnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eMyYsFKVUI/AjLu4yjm2YPH2WCOHHt0vmajj/lYGVjak2UUxMEoPXOfcSQd6EBfR9
	 aOjYNII68yBM3a4I/TCiIw3bRZKAN+l6K6VvvUqD8aN53ypgvtHXwSyKJUGBj8P0S3
	 r5Z21FsWp3P5LFTPi5nbgn4RFu1fKWS8vAqAPIT8fwAmc4Oljdi8XoSaJqg32wn65u
	 pAfPPEonX3LBEnxBELdEb1nRhciHC6EM5SDFFzTqOLezeUD7OxvInbS7j/0U8jF45e
	 mCHqUhc167JQC28Br+UXJfsFJpOyjYK2/yr1BZX5jRJAx8qDNiG89SIj0ROK6QV0oh
	 2nIxjNmVpkwYA==
Date: Fri, 12 Jun 2026 11:28:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: lizhi2@eswincomputing.com
Cc: pritesh.patel@einfochips.com, linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org, edumazet@google.com,
	linux-arm-kernel@lists.infradead.org, pjw@kernel.org,
	pabeni@redhat.com, weishangjuan@eswincomputing.com,
	linux-riscv@lists.infradead.org, ningyu@eswincomputing.com,
	krzk+dt@kernel.org, pinkesh.vaghela@einfochips.com,
	linux-kernel@vger.kernel.org, alex@ghiti.fr, andrew+netdev@lunn.ch,
	alexandre.torgue@foss.st.com, kuba@kernel.org,
	aou@eecs.berkeley.edu, horms@kernel.org, mcoquelin.stm32@gmail.com,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, palmer@dabbelt.com, lee@kernel.org,
	maxime.chevallier@bootlin.com, linmin@eswincomputing.com,
	davem@davemloft.net
Subject: Re: [PATCH net-next v8 1/6] dt-bindings: ethernet: eswin: relax
 internal delay model to range-based constraints
Message-ID: <178128173639.1162200.4235173600332300329.robh@kernel.org>
References: <20260610012727.848-1-lizhi2@eswincomputing.com>
 <20260610012849.874-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610012849.874-1-lizhi2@eswincomputing.com>


On Wed, 10 Jun 2026 09:28:49 +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> Relax internal delay constraints for EIC7700 Ethernet binding.
> 
> Replace fixed enumeration of rx-internal-delay-ps and tx-internal-delay-ps
> with a range-based definition (0-2540 ps, 20 ps steps) to reflect actual
> hardware capability.
> 
> Mark rx/tx internal delay properties as optional, as they are board-
> specific tuning parameters rather than mandatory configuration.
> 
> Update the device tree example to align with the relaxed constraint model
> and remove delay properties from the example to avoid implying they are
> required.
> 
> No functional change to existing DT users.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---
>  .../bindings/net/eswin,eic7700-eth.yaml       | 25 ++++++++++---------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

