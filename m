Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365B38551D;
	Sat, 25 Apr 2026 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777109604; cv=none; b=NHtzYnCHyZKSWZn4YKH8FhV7zRz6nq+7J/1WBGQdnOdxBkxrVmFmtZzZfFMdRP/VQi44o5Ezur+4qZfmCS8oJ6Sb5pUydUSpoRCnURw3Sm4tsOMHJmMVOKUuIlDrWGHN+EO8p3TfpgPE1RUHFf+czExIXL5Z/CVdj+0/pXcuFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777109604; c=relaxed/simple;
	bh=vTnWUB3963217PH6E98v4MIyJ/E5FD6u2p/ki3Ycw2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwslgRnWNVx7vMC/1kbz6rJlnyI+caPp9NdhR+pc4hyo0a7vmDMMd2mxAaLh/K16H34GhY1NSk420aDKfY4ZhdO7E7S7TItHR1QEaTyMZXWg9D1rr4aSoBeGbfgjJniVtyOgaZqYhgHvRhBxDWe4LDpHRXA6w5LnVlVS9W9VGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT8Q+d6o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT8Q+d6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AEDC2BCB0;
	Sat, 25 Apr 2026 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777109604;
	bh=vTnWUB3963217PH6E98v4MIyJ/E5FD6u2p/ki3Ycw2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kT8Q+d6o6nw+n1KPS+w1ZpJZl3Yc/tDH77v0iMYo8pnCj7XYzNRzqn66o/+5loj06
	 us0LWHBLCY0Uds+AjizRvxUzdDxpq3OEqzBhXN2rZVTAMXy+1f0/ElBO/GRYjTafII
	 ldWiYfqhzxYU/08LZsfArV9vUlP5cCPZcSqTpvY1DmjbiIjpyE5zlnOTAyKkpa/TEz
	 kYlnNDET7XxapKrMtaUi5ICdwN0WGH4T5M8XKc9kB6tRx9nDKJ6mbKKcGns/l2lZmQ
	 l8DJu3YF8zaf7wa6vfbTLogAeRe1ENAnhvwLfA+/6d+R4wvi/Nmd5X+oNQN7v3KF1Y
	 GNFTzaymKptEA==
Date: Sat, 25 Apr 2026 11:33:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com, 
	ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, 
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com, horms@kernel.org
Subject: Re: [PATCH net-next v6 3/3] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
Message-ID: <20260425-woodoo-righteous-earthworm-0ed34c@quoll>
References: <20260423085501.760-1-lizhi2@eswincomputing.com>
 <20260423085650.820-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423085650.820-1-lizhi2@eswincomputing.com>

On Thu, Apr 23, 2026 at 04:56:50PM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> Enable the on-board Gigabit Ethernet controller on the
> HiFive Premier P550 development board.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---
>  .../devicetree/bindings/mfd/syscon.yaml       |   2 +
>  .../dts/eswin/eic7700-hifive-premier-p550.dts | 232 ++++++++++++++++++
>  arch/riscv/boot/dts/eswin/eic7700.dtsi        | 103 ++++++++
>  3 files changed, 337 insertions(+)
> 

Please split the patches.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

