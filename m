Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F545525A7B;
	Mon,  7 Sep 2026 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811340; cv=none; b=FWoxAmYTKBqsRPqFR4xhzmdZaV+JKtApqMbf82qt3oNGpYos7G9cKGl2W/mmxIfduTumVznkMB65lNs/2tEGWeZjdgSmuKYhCjgWgRRqsyU9CFLUlYiy+IdW1Fa+uFgzbk2rCilj9GL1eVHhJueUDW5YAUv2ViYvnDBa+ZOKBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811340; c=relaxed/simple;
	bh=MQuEfmpt8D2Nu2024dMAIrcGCtoxKdOYoGqGy+isXVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiV+kpuRu1AMUvnTBkHTGtnluSv1c+nC2Cm2BB4TppHTo9UdjObg4k4bOoRqkGLeu/Czfwu3CqMLpl1BqHIP4RNqJOmdvpJae36oczdmL5CY8cwR4DjwRD2+H9drT9oVX5JXTk98F2fYXNLlcWPEdLzyELnDFjsUgxcrryQypgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vvy6qy+G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vvy6qy+G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=38xx9JHUIgaWRgzcrrca3bUqWG6/EXX4KaIy5RjG+rc=; b=vvy6qy+GFiYtl0y+oCTHTi7ww/
	cYhHLa2W9D30ij0IsA1k1iafeOy3Po9bCqIvxsesBWC+WmVDGNNyqD8yo0tGKoY4MO/TbN4LKofGi
	QHfHTjDQT6YP6/kcfk+Vuy/OZiSrkwRmTm3Kt+kdWSP6n1AmL2kPss6AMQrDY/ILdXsg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3fXf-003cef-71; Mon, 07 Sep 2026 22:02:11 +0200
Date: Mon, 7 Sep 2026 22:02:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/6] net: dsa: motorcomm: Use u64_stats_t for
 MIB stats
Message-ID: <ab2ae325-3080-4455-b1a4-f1b7a3fc56d8@lunn.ch>
References: <20260904162952.709368-1-mmyangfl@gmail.com>
 <20260904162952.709368-5-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904162952.709368-5-mmyangfl@gmail.com>

On Sat, Sep 05, 2026 at 12:29:46AM +0800, David Yang wrote:
> 64-bit variables might not be atomic on 32-bit architectures, and could
> lead to load/store tearing.
> 
> This is a verbatim change that replace every u64 statistics into
> u64_stats_t. u64_stats_sync will be equipped in the next commit.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
