Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0201C5F13;
	Thu, 23 Apr 2026 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776986420; cv=none; b=MIzfCXEzJO0nCuZt+KaJQmKk4T0yfNmZp38g+VcbBjgFLguxLNV+PizCDmjJ2VtCK9S4/uZZa4zOMU8uKMAub7f38jMrRlNgxb1AnHY9CP96ER1B79S3MX4PVjTC9pn93i/T1daC5ZiC6kD8BFuXJBjk7mhdUCpmy93ZBb4wRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776986420; c=relaxed/simple;
	bh=xdRyd6XOk3HtE2QEy255v7EcCcrw4GVj39w+yRAyxHg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GvLyT0hKXrhS4a7/tb1tB7ocFk57u9miFy7RwHitjVqY+T6ZtMIuUiiWeVeEYuNkbEVJlNY4YVO99IpyTd4lAB4KafqiVIINW7sgjyV36X99tUslX+rHA7hqzjSE1OQiqe+vjuXtsvSnpJYBnO1UjelzTwVRuzZgCXUPei/hXXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 94BEE92009D; Fri, 24 Apr 2026 01:10:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 910F092009C;
	Fri, 24 Apr 2026 00:10:27 +0100 (BST)
Date: Fri, 24 Apr 2026 00:10:27 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew@lunn.ch>
cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH net 01/18] drivers: net: 3com: 3c509: Remove this
 driver
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-1-69517c689d1f@lunn.ch>
Message-ID: <alpine.DEB.2.21.2604240004280.28583@angie.orcam.me.uk>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch> <20260421-v7-0-0-net-next-driver-removal-v1-v1-1-69517c689d1f@lunn.ch>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Apr 2026, Andrew Lunn wrote:

> The 3c509 was written by Donald Becker between 1993-2000. It is an ISA
> device, so unlikely to be used with modern kernels.

 FWIW I'm still using this device and driver at my lab:

eisa 00:08: EISA: slot 8: TCM5094 detected
eth0: 3c5x9 found at 0x8000, 10baseT port, address 00:a0:24:xx:xx:xx, IRQ 12.

No issues in a decade or so, so why bother doing anything at all?

  Maciej
