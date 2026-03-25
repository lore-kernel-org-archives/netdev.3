Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B78413227;
	Wed, 25 Mar 2026 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461818; cv=none; b=PQeQiqLu6fXFYvZJZoPMGkbRQggcNh4mZxAsJl7dgOAeDRvtJIkorlPuugn2He2Uv9YRIqEyEeVXnaEq3BeWASrFyjqMaC47sz9t/s15JkX0RXYx3MMaRJ3XVUsDabYb+maAFq3z4LJJ4rjE4KSWzMEyE5DeXFxNZ69l5lKK5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461818; c=relaxed/simple;
	bh=z+3MKcnaVgxUUEFrOwwtAjO55jdTD/Aap52HWyvjU10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO1xr1L0aAwIHfowoBnCGlpvlJI3JDi6kJOuTX27cI52nZ9BJtfBqgEfK5+n4yNwSQ73DK+/+KgiHANxhOuVnoHrj3xYMTklDU+Sj5cA6yLK/3ySrMy7mI8R2RZ8/xdH2YIjwcqY8hqxtq7tY0LpRozz4iMEgAWXDw+BMM5L74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgbXDzFK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgbXDzFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8DAC4CEF7;
	Wed, 25 Mar 2026 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774461817;
	bh=z+3MKcnaVgxUUEFrOwwtAjO55jdTD/Aap52HWyvjU10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgbXDzFKuEwm0erfN2A14a6MqFPpdOFQ+JZrgxmk4/cS1JbAJDF8DZga7kHsEW5bZ
	 zDYC9Jir/eUEG4lbfiVZe4uP96ssgyIY6mC9r3aGjmXQ+dEfU+oewxtydbBUifUGEg
	 qTuY79FjkjNFPwzlz+1D0lSMPKb0UQ/USGXaohr0W/6ZhTtG4INz1/q9/UDHusbsr+
	 tfkSjgKZdLFKfiygvCDhjoEEIJ4WTeYnnVLTNA2ZfTTtVLbiBJUxuK0ALluwhxtlfH
	 5QX5ElCYZzn8oYIv/rLT+1Y7hF027n1q3Xh4asYYc2UnGeCba+yIuvBc+ygqYIvYKQ
	 ZZNqfjEBOpdLw==
Date: Wed, 25 Mar 2026 18:03:30 +0000
From: Simon Horman <horms@kernel.org>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH net-next v5 3/3] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
Message-ID: <20260325180330.GL111839@horms.kernel.org>
References: <20260324073017.376-1-lizhi2@eswincomputing.com>
 <20260324073408.439-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324073408.439-1-lizhi2@eswincomputing.com>

On Tue, Mar 24, 2026 at 03:34:08PM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> Enable the on-board Gigabit Ethernet controller on the
> HiFive Premier P550 development board.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---
>  .../dts/eswin/eic7700-hifive-premier-p550.dts | 42 ++++++++++++
>  arch/riscv/boot/dts/eswin/eic7700.dtsi        | 66 +++++++++++++++++++
>  2 files changed, 108 insertions(+)

Unfortunately this does not compile:

$ ARCH=riscv make allmodconfig dtbs
...
  DTC     arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dtb
arch/riscv/boot/dts/eswin/eic7700.dtsi:300.28-330.5: ERROR (phandle_references): /soc/ethernet@50400000: Reference to non-existent node or label "clk"
...

-- 
pw-bot: changes-requested
