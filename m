Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF35481AAD;
	Thu, 20 Aug 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247998; cv=none; b=Rhd5BDX+1yzOqTI1ENIIJOnx85khGyuCJArzxBSlCDrPejFFJULTcMb8N3Wpi5CsQXT620x5xmg8UUlHBU8UHmvXfTJko9IXgMv0p81NQvTyJlFd3opHAM51p31WUsXOkHK7BsTvzrzldaZMrwsaiHXrZ2oYKUVpIL5oQGSp8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247998; c=relaxed/simple;
	bh=hBFO0t+w7ehL89/fNqoYsATcKgYD2lXsBbRdYb+YgTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUAsIz/f2oszpIhNfaO4Y8t71xEoUHDcqLixPvaZv3Enz88EjP6ynkaTHuys/Rc6vB7PbTIMK7Pa5K6h5pljFAgNL1R9R4PCqQmdWiG4LWwABHNOY3ZLkmuVwK4yGgvFk9H5yLPtED3tfTNPp81Jmq2RARzzVUSkM5bo1Dzq9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe5s15W/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe5s15W/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E021F00A3A;
	Thu, 20 Aug 2026 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787247997;
	bh=hBFO0t+w7ehL89/fNqoYsATcKgYD2lXsBbRdYb+YgTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fe5s15W/kjU1LPAZh32P6KKck15wOUBb3bi0SzNSRSUSOq3Kuid/v9d4iF5bHhvJa
	 FSLIeEIPfT1KxUP1GVBhkSAYXN8Fj+9aljFzlRBncpl6fSNzyMZDg4WMrq1GP6QTEl
	 kttYeBmlrOQ+YcNy2cD2eZ5CxfqjyFxHYIgXeRNZVd6MuU/03Qcda+w2P3zss9HmWK
	 fZnscgyDlokZgXPHMiliBwRiCeYv0lJKKuFi2yTeig+G4Xo2R7C3Coyj2ESuWxsvgs
	 C/E7u5z3dxYx7limoMU4FurEYLNDRP07gG7mYxGfYZnwMddFTXhBq3W6Wt9To0qAkE
	 /yXM5MJybnodg==
Date: Thu, 20 Aug 2026 10:46:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Xuanqiang Luo <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org,
 maxime.chevallier@bootlin.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 chleroy@kernel.org, linux-kernel@vger.kernel.org, Xuanqiang Luo
 <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v3 0/5] net: phy: fix cleanup after probe failure
Message-ID: <20260820104636.162a6421@kernel.org>
In-Reply-To: <305b44bc-0a98-4481-8f92-b0c18a590b7f@lunn.ch>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
	<305b44bc-0a98-4481-8f92-b0c18a590b7f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 15:33:28 +0200 Andrew Lunn wrote:
> Please submit for net-next, once it reopens.

FWIW I'd prefer to take these sort of error path fixes to net
during the merge window. No point backlogging borderline stuff.
Any particular reason you want this in net-next?
