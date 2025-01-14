Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02D1CC8B0;
	Tue, 14 Jan 2025 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897745; cv=none; b=uLGu2pN3aHYkp/eTZ1dVXvSHiAiDLlP46vTB5f9+doHRFM8UhuExYPMAgVRr+GwbUxf0H+g4/zAgYu2PyTgIyJjFvjN2ZC5RipPV07o8YryAjJdf8NoiL4+sWvXWK9IUuaA7VettUgvijWYSpnpk1acQrcOvwu1Wdj2IyFFV48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897745; c=relaxed/simple;
	bh=mAGMGtQrfQ3/Drlhgn5zGpK+PDYQqfFjj696cQz6oLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlFCmUcDwYO76dTMn0fe5NTsEZiVItzLY3KrzlpO34tN82eZm34j2/m8msxzTG00d43SI3D4PETS563zpW9ZIRANeE9B2v+zzQDI1iBcOTx/qiIYzJT+iz70GsvZ0QEYVaekm5KkvaD6TsQoRqJeToQcVpP4zxF/eG5VRvgiL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuMe8JFs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuMe8JFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEF7C4CEDD;
	Tue, 14 Jan 2025 23:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736897744;
	bh=mAGMGtQrfQ3/Drlhgn5zGpK+PDYQqfFjj696cQz6oLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LuMe8JFsedYcMeGaVXORNDg142CfYmNisZhtpqwVCaDZpjyHVd/hXlD/qXvosjt8I
	 A/POYMUWNOMF8A6PZ2mQ4RofXjmzJMKcVB79uodPNCzRZaVJA8fiyr2ll3BZ/4IG7s
	 KWAioX7Zj4HiHYTBKMOL5fz1c5swL5Vp1qad4HzDmQzlszZZ6rg9bBHqZDU0Nai7+S
	 KSwyb2dFL1xQv9w78LBlSTP+dxZlyvM7xUu7ERqFcwUXujEJJCq7kn2iw4ByCVOQNn
	 /CHuc6vQhTEleOA6ddE2V+QDmJN9DnL4YwlxMLHkoWVvOcl/PtRh4JTTjD5ICYGV33
	 1eIaBKz8ypkWQ==
Date: Tue, 14 Jan 2025 15:35:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Joey Lu <a0987203069@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, netdev@vger.kernel.org,
 openbmc@lists.ozlabs.org, alexandre.torgue@foss.st.com,
 linux-kernel@vger.kernel.org, joabreu@synopsys.com, Andrew Lunn
 <andrew@lunn.ch>, schung@nuvoton.com, peppe.cavallaro@st.com,
 yclu4@nuvoton.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
Message-ID: <20250114153542.29d10a04@kernel.org>
In-Reply-To: <a30b338f-0a6f-47e7-922b-c637a6648a6d@molgen.mpg.de>
References: <20250113055434.3377508-1-a0987203069@gmail.com>
	<20250113055434.3377508-4-a0987203069@gmail.com>
	<a30b338f-0a6f-47e7-922b-c637a6648a6d@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 02:49:31 +0100 Paul Menzel wrote:
> > +MODULE_AUTHOR("Joey Lu <yclu4@nuvoton.com>");  
> 
> Maybe Nuvoton can set up a generic address?

FWIW we prefer people to mailing lists in netdev.
Humans tend to have more of a sense of responsibility 
than corporations :S
