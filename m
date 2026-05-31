Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E73314C2;
	Sun, 31 May 2026 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239047; cv=none; b=o4uYB1VIXa74kHqwvfbhYcUgJN7LtGQY9cqCQC0yghnvbarFPEsddwxSqrL1uIdcLNpxK7zb+wp/XiJNDPWlFdjYkOIF8+SIqZtI2xRzEOj0dCZW2cpPx7FAIn6HMEZHy0c+BuGe5UWE0XfyXLkWu3TQqvui6CAWpRjHTZOoiq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239047; c=relaxed/simple;
	bh=PgOuWZx6HD1MimLLI1ygmbfIZOLLz3qaV7UX/DnO1UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnWFFQr9YdvxT4Z05asqKLpWnmyD4LK0SauzPL8KuxY+OAIYax38kjaY1UUo78I87Gk2T9S/uRfoA//tvvzTGLYhZy5bQmW6V5YNyQRMXAT1dGr1jZCX1zcpLu9vtWw5OPYPV3sRx3GrPUFrAS8q6IKgyZPoXI20P078gUW0KBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WcEmBmQ0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WcEmBmQ0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NjcM+4Qq80pLvRXfHqoUZV/PS9M0NJAlBLCKN5qYbhc=; b=WcEmBmQ0KxAX8O//+hrW8tFzVy
	yeXJJTomVgKUp0qkOpj1WAQ7Xx6+870oFtkEoNQbPU3oVoLVHDPDXL5UCY/u+gF8H+p3h0sEJbmFH
	Zg0XBRDpgSfiXz5J8BLjaSu6X6zlGdDW4e11MHPGHqKYEPJHUtkh0ixlwIOmIHvMt17U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wThUp-005MuO-LZ; Sun, 31 May 2026 16:50:35 +0200
Date: Sun, 31 May 2026 16:50:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Message-ID: <cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>

On Fri, May 29, 2026 at 06:41:00PM +0000, Selvamani Rajagopal wrote:
> When MAC-PHY appends FCS to the incoming frame, FCS,
> it is removed from the frame before passing it to the stack.

What is missing from this commit message is an answer to the question
"Why?". Does the stack do something wrong if there is a FCS at the end
of the frame?

   Andrew
