Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EDB3D3D05;
	Fri, 27 Feb 2026 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233086; cv=none; b=YlLA7FxiqSK42O1Lgr7r7ctCQxMLQXgjJpF1/iUCPwmWj1hbMi74AbOXsVa/Mv5572KCXnlr4m1XyvzTOU6v1b3EItBnKCN+FxAuxo/9bHPAnlfxpa/llHZeG1/D6YgXGyNyssnEoCgqvcoaXaF9gNPW11EfCT9omaS4/92TJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233086; c=relaxed/simple;
	bh=CTPec1vkBun2UMZ1ay+In7KcaklYycpXjh+JvdUoIbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE/XQABrzxmv++JFXYtWI+KZb0dQR8FXl8TONpm/m8AlfKbJiHhQSutwc/URU0xNC4Ue7v1H1lLeAGIDYcoAZoL1FINvfJo49etRg63h9D2ajeFJYBxbdf4XfokPjyNrsyTjzuT2ZZIGYQqBnIZvMJpo9v+bwS1WNws+fwEftOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fg7UU5zL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fg7UU5zL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=em5H893df71FG0+5xZNsjJmkdr8PevVd3q53cCo+Z0E=; b=Fg7UU5zLrTZfGVCk3U8DaIdji1
	CH92B80bZOXoB++hwJNiE6pEtu8ZrSbG04ZwuzEUSOLXf94YEyijwmeG4HtU336VyjSrA5m2fhvEd
	ramf/cNoIpqFb3YZWoZcGx+/T8ql1ysZ9UA6ulgIPj3BBRLkd4g1bP66PSqHnbMXACeM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vw6mL-0097yC-JC; Fri, 27 Feb 2026 23:57:49 +0100
Date: Fri, 27 Feb 2026 23:57:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next 04/11] net/nebula-matrix: channel msg value
 and msg struct
Message-ID: <52729f62-efac-42ba-9c66-81440e9a5ce6@lunn.ch>
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
 <20260226073840.3222-5-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226073840.3222-5-illusion.wang@nebula-matrix.com>

On Thu, Feb 26, 2026 at 03:38:29PM +0800, illusion.wang wrote:
> For compatibility, the msg id value is fixed, and each msg struct can
> only have fields added (not removed).

... added _at the end_.

	Andrew
