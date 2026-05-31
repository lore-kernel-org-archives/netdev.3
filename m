Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF273911C5;
	Sun, 31 May 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241195; cv=none; b=dw0R7m5NQpNQ1l84m6BkChaTDzzkZTAly8XPXHvwZJKA2Rwyin4eu6irSZMIOlwT5q5TbB4YzENY6IUIvJpv4tmhb/4b6vyRn8xNb3yHrXV05Vukw4BOHTcQ3K5czDXTfnmwlfCYRo76mzHCzqs4bpY3a7HaCG1JVHwShcCoGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241195; c=relaxed/simple;
	bh=tVSVhJ+jtd3KUuQBDtje4A44ZDG/J3xhoMi+m9aE848=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp3oEYHeqfj+7U1gthD7ycdXLb1GDeEprFYCAGMRUNw5HU2WmlN+uonL7HPJboysPR71wIgw1qKrkyHU/GedKjyuPH+mSURS5NXLYY43lJ5FJqewCFn4DEvT6bF21Wbofys2FtNo/fbimc4QpEFABJnk4BhezNFB4+GZ4549ltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AVWV9et8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AVWV9et8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eaw9BFSli01njN1ANjFgshb0jgxlvs3haCECARd8gsg=; b=AVWV9et8EmL6zAlijtpD4jBY9O
	LNfyy5hIT2pvEE3YcTlkfDWzETEh+BrX1+ns86rxxw0FYc7HaJ4rxsEz3kBZ22bk6Cu6hkKB2+F5W
	NuX+KVit3h/71Bnqu36mTuvVHkX4eyk5nhoFRT+IwzK6YLqhDZhrJmOZLAGg86uv5Q1I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wTi3W-005N7Z-Lp; Sun, 31 May 2026 17:26:26 +0200
Date: Sun, 31 May 2026 17:26:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 10/14] net: phy: ncn26000: Enable enhanced
 noise immunity
Message-ID: <bb0c6ec9-8843-4bf0-9491-f5b5041bafa0@lunn.ch>
References: <CY8PR02MB9249022FD77BEF360103367283162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249022FD77BEF360103367283162@CY8PR02MB9249.namprd02.prod.outlook.com>

On Fri, May 29, 2026 at 06:41:11PM +0000, Selvamani Rajagopal wrote:
> By setting ENI bit, noise immunity is improved and it is
> specifically meant for PLCA enabled nodes.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
