Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B03921DD
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366626; cv=none; b=tYNqNk/VU6IkXPpSURjyQE+mMsroalwUxqTgXQgax8pj/++5ki4h5GOSoBUwu0Gduwy46Pd+OoYT/arKShy4Gjz94c07LuiSBQdggJwRdZQd8nZZeTI6bL6V3jSDgtPP5YzjV5ai7xltrI3sOEKicNLdeBd+7NzUjxkIZsfu/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366626; c=relaxed/simple;
	bh=KqPlkqD/YJwfFW3mB0vqqnoMCB/bfz6awKv7n+djo4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmRq6xV3+9klWahjQ1W5QPJVE5cHNtyKtmyCwFmJx/A3EFlwo33WgcKJvLkjdKLiXeU9dDoFOSGUgusyyMcxRbiarWIcGwtJcgvhemLvQG/LatinvZ44GHiYbQ/05uIVZ6ABoY3UgDFtX/35Xk/tDi8lW6KD6wPXHHwpwEsw64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1zD2TzU5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1zD2TzU5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C9+TVGTjtrTKdhCzzdpQV8rc5TK6TPWoiE01v+tdIn8=; b=1zD2TzU5ilwu2Eu2otIfzPj7ND
	e+QOm7zxzsydsJV+lgcCrr739NWZutfJg4/rTHQNIanrn3d2EQ1hu/YTApprIrynwLWwHE0/zDP16
	LgBDCCRQeHJccaG/yaAVeZzqj43/uSBW0yfKYWwc6H3qONhdIzMCDl88Kpb4UNRhVvaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAC8z-007I9L-T9; Fri, 25 Sep 2026 22:03:41 +0200
Date: Fri, 25 Sep 2026 22:03:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lane <software.research.development@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [net] Search for net subsystem rust abstractions in-progress
Message-ID: <ff9b5057-c720-4e5b-b1b9-6c797c856ff7@lunn.ch>
References: <CAGchGNseHg7k=Ubtmck=Tc0U3z=wJefEE5kKdH1wxOH5wXS4PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGchGNseHg7k=Ubtmck=Tc0U3z=wJefEE5kKdH1wxOH5wXS4PA@mail.gmail.com>

On Thu, Sep 24, 2026 at 09:48:13PM -0500, Lane wrote:
> Hi,
> 
> I am following up on some advice given from the Rust forums where I am
> trying to move some of my LKM's from C to Rust. These LKM's,basically
> create new address family protocols using (for starters) structs and
> functions like the following:
> 
>     struct net_proto_family;
>     struct proto_ops;
> 
>     // Add a socket protocol handler
>     err = sock_register(&proto_family);
> 
> These do not appear in the kernel crate. Per the
> submitting-new-abstractions-and-modules section for contributions in
> rust-for-linux, the second bullet point says to "check the mailing
> list archive" because "part of the work may be already done or in the
> process of being upstreamed", so I was hoping to see where things
> stand and get advice.

There have not been any contributions on adding new address families
from rust.

It is also somewhat unusual to add new address families. So before you
go too far, you might want to give a high level description of what
you are doing, just to make sure your architecture is correct.

	Andrew
