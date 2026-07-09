Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2691439331;
	Thu,  9 Jul 2026 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617353; cv=none; b=LxHAof4cYbwFR2phDSvgIrsc/Q/o2eRVRF9h6fCiPiJ3VAffMHh2rU4nMrr4/PX3DQHYPTsPdRHNaFkg+rTzRf269asJNT32KVbAIzDuSk3Tze7aB/fFRBC2Ik+EsofPuT/hYmT1/x9ZmiyVRQwOfgy/SRdUH2I2vv8IX9MVdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617353; c=relaxed/simple;
	bh=u6G1A1aCkpuZOrmz87C4E9FofJdKYwlSCQr/dvnfmdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTNjxk4XauaGkb+QD4/XRLdSy+Mk5rPbK5zPxDVu9kKzA8JbPVw8ajO6Nqb3BBzrYqhRd9vXBKUwKpmc8jIRbxG3FfUZ9S+CBDC9Uz4zrBPmh76Q/1t34XdSLnBZHnuxON4PV9+62IeJEFPvb6GHaprvzgzAskZo1Gd8yTDIOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqtIBsUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqtIBsUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98641F000E9;
	Thu,  9 Jul 2026 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783617352;
	bh=9yPWP2lzZBNwGOaUPhkONWICmeFNe6mj+Z8k6OaW0nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eqtIBsUnEwFBps7/bcGH5WwDQ1TP2792tgUoy8INOXjpsoxwrojURO3JzPEjMe7JV
	 T9p+NhLCzWpduMjTPa3xVw0qqUPd5T6dHtxpnxulpr6cua0iEXjbTKw8OSUveXv4ws
	 U5B55DzyAajr4BwGi+L4BpCahACHD7SCs2E81zeIplGl5FgGEoKfRn8iLwNNb9zo8G
	 vE4kE9JvWkc26g9IrfKFyWi92EDELU5ITv7zB2qRPaHj3N3xmRdeYzuXwr6quBQqSr
	 sdv+n/t9LR9HdoZ3srkUSxYHigQam/egFhS8U3ASx3dRW75nLLvFsV44ZnYbFfuiLW
	 EZCHQM85+MpeA==
Date: Thu, 9 Jul 2026 18:15:48 +0100
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: davicom: dm9051: add missing MODULE_DEVICE_TABLE()
Message-ID: <20260709171548.GW1364329@horms.kernel.org>
References: <20260704152142.50156-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704152142.50156-1-pengpeng@iscas.ac.cn>

On Sat, Jul 04, 2026 at 11:21:42PM +0800, Pengpeng Hou wrote:
> The driver has a match table for the spi bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

