Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5FF476075;
	Wed, 19 Aug 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146653; cv=none; b=BZNgGwNSvW8EYkZWD6ZDGtr+hGsjsd39NG8F6F/N3f9doggJFy/ArlPu6Fq7IXNhFnkJtQNJI1p5doQhzpbY8u2Zkn7ymStkQ4Kqt6BoLSzw8OYF4ZqGVsjkWxz7kuiRLqcqLut9d1n9YtfpkszDrEhix7i985fVfCHK8NyO1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146653; c=relaxed/simple;
	bh=f8h3PfrcfKD7gnWkGgePfnp/14lh5j/+3IeOS0dhm6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/7lOdLPwLdyY9t56pvMGT1HYW6vTPY+EXIROTCiRjlhBSAIftVnZ8cGlENm7TVc6EbffkB584EsfXMZ8RaL2OOMrn8sYcrlN5NNiT2RankZenNmJPXLxhX/tUpMdHvA+tLLtUvRYTrOmvAe1eg7c0q0nWlKxV/panYoWrdZ6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tqZ/fVN1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tqZ/fVN1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YVAVuyXODeFlDiX8gMSsHIVfn94W6ipKT3DH1TMZmUk=; b=tqZ/fVN1h2CRFq3XgewINkvyOo
	wGKXmrl/SMezVAvG8t+d+bo8QCcWAZW6hRJqA/v5YBnOwUOQbprFspIhgE7yw86g8hPy4xBSdoZ3s
	JOdDgEEiA0hJudlFDghBlroJKtwFzRSJdgB2zZ3i83azTO5tPTd4QLH0E5eGvQ/HjeHM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwgTs-000c5T-K3; Wed, 19 Aug 2026 15:37:24 +0200
Date: Wed, 19 Aug 2026 15:37:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, maxime.chevallier@bootlin.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v3 3/5] net: phy: set PHY_READY after LED setup
Message-ID: <b497c7a4-3d25-4d48-8b24-6d5e1cca8822@lunn.ch>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
 <20260819060236.24665-4-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819060236.24665-4-xuanqiang.luo@linux.dev>

On Wed, Aug 19, 2026 at 02:02:34PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> phy_probe() sets PHY_READY before calling of_phy_leds(). If LED setup
> fails, the error path releases the initialized resources while the PHY
> state remains READY even though probing failed.
> 
> Set PHY_READY only after LED setup succeeds.
> 
> Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
