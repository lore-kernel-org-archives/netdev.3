Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E983385B1;
	Mon, 23 Feb 2026 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869045; cv=none; b=PwLSaiRf+b9vdlLLD2ItydhKSDeR5yvocOQ1+xH2CnyOuogsang9/6LFFP472KJSw+Gc1BVHLrDrkra/+b6IE8DLCQBWPxU7X4JaRbiG+OD1NouH4P6DzdKS+DQy5yl0Dl61HwoMtNr5N5698kdFntuXnBIWTX+rtcfdtQRwCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869045; c=relaxed/simple;
	bh=qltNpxVS1O/Ej3OenO1iVrOJiK15RWvrrThFE6tLcuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMksTmfDup+L6C1y5LlCtXIscB2i5KmQ7CMFDuBlOlNnQlQz7k8/DclngvOgL8rOcdNcqmFAcy7yERiL/6Y8wUb3Bl2QaS+M91PxOMCrFVFDywGi8v3ZrAoXtldXC2yRUAl2BnYjBcWAJE0G0RxNjxAytDaGmeWDseXmv6FyKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huuADg37; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huuADg37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A82C116C6;
	Mon, 23 Feb 2026 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771869044;
	bh=qltNpxVS1O/Ej3OenO1iVrOJiK15RWvrrThFE6tLcuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huuADg37tL1SSfJ6E5JHY7F+eKGmWwAls/fUsnj/NXSp4aqFc0tIfMy2WD4h595ZM
	 YZpv1OngXUgtft8weAj12caAtFF2vQE11IYR8Twy9hntIFArBY/oHdvxDpYjXiPBeN
	 PMkDT8sJrGWmj1+rtx13sR0jtutaep1iHYyKZdHhTb+icML+mAzjODD7byqya/WK10
	 l5QhE/W6VHFwlWI7YsF99z2MTD9a+abVocQ5f3H1wIKu0B4u2/iwoSvu2OeapnwAvg
	 jR/SjMBOI0u8eCwwVoPs5EhSFGa/xJjNGXK6ckIP+gwIIVivVA5wH2s+Y7BqdDjc33
	 CJNvv10Fh/L+w==
Date: Mon, 23 Feb 2026 17:50:41 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] dpll: zl3073x: fix REF_PHASE_OFFSET_COMP register
 width for some chip IDs
Message-ID: <aZyTcWMAIzVOSz09@horms.kernel.org>
References: <20260220155755.448185-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220155755.448185-1-ivecera@redhat.com>

On Fri, Feb 20, 2026 at 04:57:54PM +0100, Ivan Vecera wrote:
> The REF_PHASE_OFFSET_COMP register is 48-bit wide on most zl3073x chip
> variants, but only 32-bit wide on chip IDs 0x0E30, 0x0E93..0x0E97 and
> 0x1F60. The driver unconditionally uses 48-bit read/write operations,
> which on 32-bit variants causes reading 2 bytes past the register
> boundary (corrupting the value) and writing 2 bytes into the adjacent
> register.
> 
> Fix this by storing the chip ID in the device structure during probe
> and adding a helper to detect the affected variants. Use the correct
> register width for read/write operations and the matching sign extension
> bit (31 vs 47) when interpreting the phase compensation value.
> 
> Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

