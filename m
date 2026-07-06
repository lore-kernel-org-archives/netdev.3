Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1D357CEB;
	Mon,  6 Jul 2026 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351581; cv=none; b=odYasxRbne+hL3ArxM5o/0sMsxMpvrDmpexaRv67TVtDlo9FmUJwTD3PZhk6eozJlTPP7fMH/KCo5f93CDDMHt9Q/yD8rZjeBWaNvGvYyzYU/M9xxm9h0rhwE8hkE3uhiOaad1Lmo2FuKed88wuA9QJFrV0RSKAUq56pZjLizQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351581; c=relaxed/simple;
	bh=HjLcgX43TSsmDj4X5Jf6ec52cpvE40fjmaXz31XX4Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qq/8OOsC5KBTUk4PhgXf+bbZxwYYQlsXOZ5vcG1ZyEIDOjbL8Q2s+qYtMMxBwPUeezeiwNWutI7PiaKmUL3bnRW/9fcZH2ZcfAAGnHp3cOy/SPoX463gugBAr8rLoStJkLDV/aOL/RYyscFgPZJtDP0hqOBIXgNQQ0WFtX+ghpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CVyaIHJN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CVyaIHJN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+V1nigvTOrL25m3BVNeQxzgne5PTFZRS7Z1mfPjmWbA=; b=CVyaIHJNxFc5fyAKdRd72cOUn9
	2BmJhcsQWld0LJ7uXlf8GPkHJa7klZHBlZ5tBz6BdzphMuQzds+s0RyjKiOwLoAFLr4m6vmnwxjAM
	ZMO6UAZ6nIEm01AeoL+L/Nl26auWwwGe4+uTi/4zBn6UQ5fOGRqmV0cRtuzIRknfDCBY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wglD0-00B0sr-Dc; Mon, 06 Jul 2026 17:26:10 +0200
Date: Mon, 6 Jul 2026 17:26:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Elad Nachman <enachman@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: prestera: validate firmware header length
Message-ID: <ff1d3744-b61e-4ae3-9041-297f398f28a6@lunn.ch>
References: <20260706092602.79240-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706092602.79240-1-pengpeng@iscas.ac.cn>

On Mon, Jul 06, 2026 at 05:26:02PM +0800, Pengpeng Hou wrote:
> prestera_fw_hdr_parse() reads the firmware header before checking
> that the firmware image contains that header.
> 
> Reject images shorter than struct prestera_fw_header before decoding the
> magic and version fields.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Please set the Subject: line correctly.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
