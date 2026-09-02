Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211EC4A2071;
	Wed,  2 Sep 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360129; cv=none; b=RFuz1ha4b/hXiKZRN7ofdW7SArUXkdUpFxNbcH559EzLq2wRX88ghd1esCa+eH1nOUN0rCLFMGaHQ+U280sr6+82IxK0JJIkC/l5AvKztiBBqXkx2ax65W8gNvbIWpWLnOV/YeB8BZwv5QS/0SB2V3aJ+kHwRDhilG63HPAsHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360129; c=relaxed/simple;
	bh=7fHX1vOba3XvrWKgZcauSuma4kByD6dun/YWzWSphvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt4a7v9uUB7QjwsHecPQhQFmdepQYSf6yofRqb2Q/uSaQMRFk5QmouQsRh4tJHF9osfaQ9OlQ0NuR7HbyBOS+OImzYKxIeJlWXEC9LyHSaRkYUatJYaw8ZeaeKpnqmWrFL5TSiHJCL3XjiBNoLt3F1+JL3WsmzW5zJzAngubM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HVGQovKb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HVGQovKb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c1vVGuEllToV8lJdjrCj0RutdPyXrPDANwjNbWMtCnk=; b=HVGQovKbs/ku9EAXArWQI5ZTaS
	RntVZJmaU0qBjmKKhKxNmxj4UiJqVaYHiDtuuoTdzzIm0YknBLJ1tVMfYmh6aY8YEp+zpiHBCV0V4
	BU+3DiZKTuHxXfWW67L0rXUpoXewcbsJjCRE4pBMLET5lS5kISNJiVKGrrUXf9m+ianA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1m9l-002XEm-LI; Wed, 02 Sep 2026 16:41:41 +0200
Date: Wed, 2 Sep 2026 16:41:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, linux@armlinux.org.uk,
	enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v9 5/7] r8169: add support for RTL8127atf
Message-ID: <caa39770-3e00-4bde-ba4c-bb6e22e5dc0e@lunn.ch>
References: <20260831053745.1197-1-javen_xu@realsil.com.cn>
 <20260831053745.1197-6-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831053745.1197-6-javen_xu@realsil.com.cn>

On Mon, Aug 31, 2026 at 01:37:43PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RTL8127atf is also a fiber mode card, but its sds reg base addr is
> 0x0080, which is different from RTL8116af. Add 10g and 1g support for
> RTL8127atf in this patch.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

