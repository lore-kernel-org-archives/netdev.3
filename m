Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63A3C769F;
	Wed,  3 Jun 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491216; cv=none; b=ZAvsyOEYMtghKpBGPrpSA5iQx8VVBDSJ5ecFS+ksEPSy84N8kkKd7yP6fBKmWtpPeil2WMlQmKznQcdYtzhgYfoVbDEIvrWolOrOc/ygADlpC7i5ViNPFU6hZtHBrfoQC4WJsFh7FJEsewjVG5ka2fKXhJaIJNMnfJZPIXheK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491216; c=relaxed/simple;
	bh=0a77u00Cn4EaVqOsZqzGDCQxFKPaDEqfan7/n3ITd28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+fqNKskJMTGmgTBOdGteG6M8/nrin/Q74Y0zE6pmwf8Jaz6KtWlZhyfFPlI3M5bodZO+hvlPSqxvbfpoHZxBNhgPtsv0edT9ymisYKRWRbY84M2jMVwdIG0Lcm2aPaPmF7fAHdY1YAtx0cDg8HrkRoeUaqQQnhgP+qWPQc+C2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WWtIP2He; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WWtIP2He"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uC1PhjryjQEehRxVK6H0z0ohScXVNe3TGPj343eUIGw=; b=WWtIP2Heus+2IUH1D00ixJCf51
	DnBQTlSIAczHHayMHsqUWyBiiiEBDuzOxezDVdkod2+SvU2SO6w4EVk+PCAZWWT3RAyjDCg1iaWDs
	cdpb8wwhX6fTZil6QGQ5aSuvqGlZst8GYJ2UsPoh6IDwSzvqL7lw+NMemCAqnXPs9gy8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUl62-005sV4-2v; Wed, 03 Jun 2026 14:53:22 +0200
Date: Wed, 3 Jun 2026 14:53:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shaoxu Liu <shaoxul@foxmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] rndis_host: add Telit LE310X1 RNDIS USB
 ID
Message-ID: <ec67be00-2fd9-4fd2-9478-8073ef314e65@lunn.ch>
References: <20260602090528.2544-1-shaoxul@foxmail.com>
 <tencent_F1AF1F5AD39C56485BD16C6DB2415E5B9508@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F1AF1F5AD39C56485BD16C6DB2415E5B9508@qq.com>

On Tue, Jun 02, 2026 at 05:05:27PM +0800, Shaoxu Liu wrote:
> Add a device match entry for Telit Cinterion LE310X1 RNDIS interface
> (VID:PID 1bc7:7030).
> 
> This is a functional no-op and keeps using the generic rndis_info for now.
> Power-management behavior is handled in a follow-up patch.
> 
> Signed-off-by: Shaoxu Liu <shaoxul@foxmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
