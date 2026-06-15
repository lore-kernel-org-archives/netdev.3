Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719DA40C5D5;
	Mon, 15 Jun 2026 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542484; cv=none; b=iNP05fXUH52dOw8kHG4u2vGLqoIwCj7MYkHHZhudNNHvX2VYeZ36/0qRafqqQoaoP6mOm//9EtT5VZvSLs4utyEHtFzXMB7WjU5ormwemUp9+bxq6F9/vMBbbjzoKZblWdV8j12zPvVRIwT5ChAUP22SPmQp5oBU3XYbJg5ffa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542484; c=relaxed/simple;
	bh=gjMpSipqjPjGZJLWCP8SG6eJxD8G/KsdWsp8Rd17QFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN2vacfX3Hojbgdk9CwsO8460+TRbatn5ysjVe1JyCHy+PcIf17mb0xcK1HK01jgH34pydvP+i/8oRgC/ux+EoKYj39WgrHIh83BC1SR2j3BvehzPFzgVu9VdJ7dtLfhhakPSC6kK/ZSiYenCFWe+EkpoG9N3krh8XihyiKGSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C1bgKSob; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C1bgKSob"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p0Vy+cDHRp/tA7DMVVnN+tE5yh185gbVqGxEXyZGlYs=; b=C1bgKSobE+REAxliCLXXYz5Shg
	f94pt2rfLfowsOfgrZ1tF1GZQXDET1EXafDV6K1Hhj/WSbN9PtNHDi5elVpXUexFM622oWBwfgVK6
	OB4CppzCBcEGH09SUaoVgSMwkK6iNVKzxffhDhrKYmgIpjlcleylBMew92/dgvBvkKDw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZAa1-007ppY-Oe; Mon, 15 Jun 2026 18:54:33 +0200
Date: Mon, 15 Jun 2026 18:54:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ehea: unwind probe_port sysfs file on failure
Message-ID: <46b04965-ab23-4696-a224-93752c48b28e@lunn.ch>
References: <20260615070033.43461-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615070033.43461-1-pengpeng@iscas.ac.cn>

>On Mon, Jun 15, 2026 at 03:00:31PM +0800, Pengpeng Hou wrote:
> ehea_create_device_sysfs() creates probe_port and then remove_port. If
> the second device_create_file() fails, the helper returns the error but
> leaves probe_port installed even though probe treats the sysfs setup as
> failed.
> 
> Remove probe_port on the remove_port creation failure path so the helper
> leaves no partial sysfs state behind.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
