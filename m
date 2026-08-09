Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CAC377AA7;
	Sun,  9 Aug 2026 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287689; cv=none; b=XpDWmd5Y5tROIVPmRahQfnvjO292jyTAiSYq+UQxTyWqQN4Ci2BuGkIpa8guFbM/80yflIDnXg3FOhiE3JA22p9Y3YF9/rl31eAN58Aj4by1E2dw5YF4SVegK8eUaqNjzHeeVWsAIDRzq3Owg/JU7b2++C558C5qoLnKzP14KKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287689; c=relaxed/simple;
	bh=mT0+GczftYmj59hM4nNaFtbOVk3JYWmKgEO4aEAQgo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxH1LkHd0GVvkM7Ew6XG/HTcae2lqSv4G6KWFGX7FmAUtJZCyIh+9kYVnf+B5/WJaTH+WEn46O6/xlsmTVW3R9TExRmmSFquH1PHg9Bn1n9Euk2NBG1VIhccLx1+h84k/rg/VBfafrrG3FhxYAO48g7/nitk7JiYaRbibLJK3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CbQeQwWR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CbQeQwWR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W+Jzq7q3tOTwgDaafaDaaHFu+4OcAkTnu+fB+Y14bSk=; b=CbQeQwWRkolx83pK1SFyVShmTx
	V21M12KT8IZNTDmxzaa7vfMEhpHdGMLq9LQSV+9MgMSzkFZDklT8C9YJglIC0saENBcK/Rl3WqZFF
	XEV1Yz9D/28s47Wrn+t0Pw9/GcwXa+FOjf7wqRaX3/b5hZnAOdMasK3lOZy7d/mQ2RSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt51a-00Gp1L-JX; Sun, 09 Aug 2026 17:01:18 +0200
Date: Sun, 9 Aug 2026 17:01:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krishan Singh <krishanmohan298@gmail.com>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: sfp: fix hwmon_name memory leak on
 hwmon registration failure
Message-ID: <46e6ca3e-722d-4fc1-9835-26a3fbe0cf71@lunn.ch>
References: <20260809064504.70579-1-krishanmohan298@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809064504.70579-1-krishanmohan298@gmail.com>

On Sun, Aug 09, 2026 at 12:15:04PM +0530, Krishan Singh wrote:
> hwmon_sanitize_name() allocates sfp->hwmon_name before
> hwmon_device_register_with_info() is called. If the registration
> fails, sfp->hwmon_dev is left pointing to an error while
> sfp->hwmon_name remains allocated.
> 
> Later, when the SFP module is removed, sfp_hwmon_remove() only frees
> hwmon_name when hwmon_dev is valid. As a result, hwmon_name is leaked
> if hwmon_device_register_with_info() fails.
> 
> Free hwmon_name independently of hwmon_dev. Continue to unregister the
> hwmon device only when hwmon_dev was successfully registered.
> 
> Fixes: 3f118c449c8e ("net: sfp: use hwmon_sanitize_name()")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Krishan Singh <krishanmohan298@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
