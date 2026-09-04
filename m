Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324123403F4;
	Fri,  4 Sep 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527676; cv=none; b=Y/VBI/EcnPRZIuPQI6mP9XmCujsjrw7qpZ0yDFyhBUdSiJcIy+NfpBxhPRlTa/OuUle03EbSWO9FZMnAHWgmcwB6QiViSPbxK+2DeUhZC0d/Lnh2McsX7QAY9JG8QE/Nw5Ve3oJVuouR7g0pkJnqLyUI9FrndFf9aTD1R/oyKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527676; c=relaxed/simple;
	bh=nASu6X5bRtXWlgtDABa4RdGRumEVcsi4pNULZvytxbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gybge0FIkRXEZs7a9NwL2W1F9do3VD4QFjYCBT/TAjVD7S9UI/qseLAJE4p3c+5Ni+Bn32Qvrj6oPpWcL7jOCLgOJyvp7dolc9HHGZGe6YQ1pRTSFNY/7u8+vJrCE/IKMf8yFFOxKWTC3xdEgjP1De52lVLt4NIG4W1VElKzgyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sx3DyoTb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sx3DyoTb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KEW5dy/2M8hfrCyzmTG+4iyZFp/UrtuyI+8EEJ64HOU=; b=Sx3DyoTbRIksGMAUoXS0CGiX4h
	1kgoX8uAnOvIA4fFigFoBNRh1hovGoWiX9Yffoc4Z92+nngStu//T6wWmwzJWNN2tOIyEd5Ho0R1/
	PnBUhW9ks1UNwUt+8XgEI9Fmlu5o1Nni/hfeee3R78ibUPis8g3mDOJYqLxx62tfqYwc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2TkJ-002ysA-V8; Fri, 04 Sep 2026 15:14:19 +0200
Date: Fri, 4 Sep 2026 15:14:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v5 1/6] net: dsa: motorcomm: refactor
 registration path for upcoming switch families
Message-ID: <c74536fe-6686-4bb0-b887-a04f77dab2e0@lunn.ch>
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904095416.1692962-1-kyle.switch@motor-comm.com>

Yah! A small patch in a series.

But patch series should have a patch 0/X explaining what the series as
a whole does.

git format-patch --cover-letter

Take a look at all the other patch series on netdev.

>  static const struct of_device_id yt921x_of_match[] = {
> -	{ .compatible = "motorcomm,yt9215" },
> -	{}
> +	{
> +		.compatible = "motorcomm,yt9215",
> +		.data = &yt92xx_series_info_table[YT921X],
> +	},
> +	{ /* sentinel */ },

There was a patchset of 33 patches posted overnight which removes the
, after the sentinel. It would be good not to add one here.


    Andrew

---
pw-bot: cr
