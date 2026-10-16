Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50EF4CB8C8;
	Fri, 16 Oct 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158802; cv=none; b=o+rrEFKElHj1N7W5bEcYJem6Eyc4vcuvo3QIg/88oH//90WAlTUFm8WFkeX/x+i4+KFTlMeVn+ODDksq3eHRF95Fy1/n4cCljorOZRXkpa7QobfjF5fGOEfpMErdHBzfda9KkdLMyigLorC4nMtoGgq2AGITrElI8OUuEybNqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158802; c=relaxed/simple;
	bh=ZefTqfyaugMOTcSREbhZrfephi7hVcxlh9jDp46Gask=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH13lzotaEeziNXpnAwXFFB0s9VK831VaJIhe9f3ayqRnt07TAzfz0TbZ3Go4H+/h9Ef51qdDRA4Ovf00GU+AV9mFnoglEe9+6G+C8iz5DTBuz+92Ze2g95jrXWF73WyTC2WsAssiOLVMuPWloWUqfAzkXy0NUr09cmm21e6vWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiOYfL40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiOYfL40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0CE1F000C4;
	Fri, 16 Oct 2026 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792158801;
	bh=5w0Kc00l7vNH6aFbFh1J6AyHjosBdNaXtwhFEc5dl44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AiOYfL4060GZNNvWhhdBnBnoYsQzLR8kwMOJz9QCK6tTpr7OsYa5udSKRfEuOR+3j
	 Xpk6EDpFPHtieo6J2rpQQOxzNkv46m9qhGakyxjSoe7Z56hy+8nTXVw/I6sDu1dnH8
	 LaI4V9VRko7PaYRxtwdDeqtiZzOtfb74wt9AjrQNhjWkIbdjekl1l36NhxJTnQPhNs
	 abKYE1fKdYQtLgYqHww69QSoz3r8XlL5CAMsj9nxVPf52KLI1JFtd4ip+CaLIY3MCi
	 a1jTZj0J4I0P0ESArCSl7mXfv/sQkh7L81YFRtrXdKxWXy3z1+qersIGbHGq9+QtbV
	 xirEv1EPEI+9A==
Date: Fri, 16 Oct 2026 08:53:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ali Rouhi <arouhi@sitime.com>
Cc: vadim.fedorenko@linux.dev, ivecera@redhat.com, jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com, pabeni@redhat.com,
	conor+dt@kernel.org, kuba@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	Oleg.Zadorozhnyi@devoxsoftware.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	cjubran@nvidia.com, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v14 02/12] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Message-ID: <179215879728.1780041.16503599921080906388.robh@kernel.org>
References: <20261016005823.13690-1-arouhi@sitime.com>
 <20261016005823.13690-3-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016005823.13690-3-arouhi@sitime.com>


On Fri, 16 Oct 2026 00:58:25 +0000, Ali Rouhi wrote:
> Add a binding for the SiTime SiT9531x family of clock generators: an
> I2C-controlled device with four independent PLLs, up to eight input
> clocks and up to twelve outputs, described as a DPLL provider.
> 
> The XO is given either as a clock or, for firmware that describes the
> oscillator as a property rather than as a clock provider, such as ACPI,
> as clock-frequency.
> 
> The supplies are described by their pin names: the core and input rails,
> the GPIO rail the SiT95317 has, and one per output-driver pin -- VDDO0 to
> VDDO7 on the SiT95317, VDDO0_1, VDDO2 to VDDO9 and VDDO10_11 on the
> SiT95316.  The driver does not enable them, since the boards so far
> power the part permanently; describing them gives a board with
> switchable rails a way to say so.
> 
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>  .../bindings/dpll/sitime,sit95316.yaml        | 214 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 220 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

