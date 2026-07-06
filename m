Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6DE3AC0C8;
	Mon,  6 Jul 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351818; cv=none; b=p7vrWcq9qadcKYwYtf1W0/iy6F2sJjoQy+30T+W9nF93z/Avu7cPk10D2Z3gjeZqiWslzdkpCjnt51/R3ZElWFW+yOhqmnCYvX3p3+gir+5AQuOaoRNK1/BwB7DGFhoUoqo23uNNFm8m9bOgf14kqFPRuazDVuGWYjOsF7IB0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351818; c=relaxed/simple;
	bh=MleOpKofFzVawe6uTLddUk+lApt35cgcpODJ0aaRBWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVv3tTnjkK3Z31hkf2M3t66fssqXUxqoCsf1TEX70kEMi2dIUMUQWegwthyBZIGKUAE7v6+3HuQn/uVZteoGseMdwnFgGut49ncvHoM8AjYSOmLQEle1k+87j8MQG78c5FFQZ1roQ5hFZZCLBnXsKeFJYzZX//spIW3xv8zmShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E8BOp/wR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E8BOp/wR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AP5wTuaPo3Dol3BwSEGO20w5gsoh6qKjitaUY4BlCSM=; b=E8BOp/wReMUTZ9cBQCGyWZJ5oC
	Tgm2xBrLydJykxJIJsey92NL+3jsyzoHTLZ9OUpAJ2QoYk2b+HW0beC71RRus+rSLA+GCIeKN+J7p
	IxvtjobIxHnFoKBmaDhHMT+Co6m/Qat2QXgpLtLmHrXcxrOiaAw5l/VhOWRXiJb6hgow=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wglGq-00B0y9-22; Mon, 06 Jul 2026 17:30:08 +0200
Date: Mon, 6 Jul 2026 17:30:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bnx2x: validate firmware section bounds without
 overflow
Message-ID: <2b37879c-5ba1-42b1-9d13-98acfcd5ee35@lunn.ch>
References: <20260706093403.81017-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706093403.81017-1-pengpeng@iscas.ac.cn>

On Mon, Jul 06, 2026 at 05:34:03PM +0800, Pengpeng Hou wrote:
> The firmware loader validates each section with offset + length before it
> uses section offsets to read data from the firmware image. Both fields are
> 32-bit values from the firmware header, so the addition can wrap before it
> is compared with the firmware size.
> 
> Validate sections as offset <= size and length <= size - offset instead.
> Also require the firmware version section to contain the four bytes that
> bnx2x_check_firmware() reads later.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Please stop posting patches. I gets very frustrating having to point
out again and again the same errors.

Please work on one patch. Make all the basic errors once, on one
patch, until you get it merged. Then post the next patch, hopefully
correctly.

Please reply to all your patches with:

pw-bot: cr

so that they get dropped from the review system, so they don't waste
our time.

    Andrew
