Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F640494A14;
	Fri,  4 Sep 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528766; cv=none; b=p1SQ8Ld+S98aRYXVku6xJ7j0FwFlkRYgiv8Uc/QqX6KRIxaZdUG4NhAaLWcPICuWt4M7mwbQoI5mXc/KE3KIRRZ/o037Npylgbp3d6+j6ky4cb2l/Yc48JvfF7WsUotM9r7dgN018BiDQb4JFriUzm3yaXE5w3Kuis9DXvf9V/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528766; c=relaxed/simple;
	bh=4K8Y4p6m6q1kUKavn4gK15eY1akntk0rLnq/eYiZX7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzuEkq2TLNGT8bWQj7Ua2wHdrmvkuqRhTwH02DohfzzcvgaRJphWYKCEKw1X5Z3Yg1RUg8EAmMt6YIKYnuA/TBHx0i8CociJMPO33JChPBelHQ4UokshECTjN6niy3aa4PLloTFjifONuiYgIINNahN8tLQ46asiaBhbNCxK7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cnickaWo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cnickaWo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0K8KyDZ9k/5dDTjWG9vt273dbI5Ay1N+S7a5mPQ2aJ0=; b=cnickaWo7QPjgpgVzXRgEIphXV
	/OAav2EdOXVOFGD/opMej/BzQ/z5hN6zoPQrXAykZ24vlLzLT0r05/4YGN8vSZ3/eXiuUTVoGtkFi
	Go6+RHd3OWDmjqfWYGHU2CArb9Ro4AjjjDx4n6q2Uqaogn0ELxcgazOFmn968N1htg64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2U1u-002zL8-Dy; Fri, 04 Sep 2026 15:32:30 +0200
Date: Fri, 4 Sep 2026 15:32:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v5 2/6] net: dsa: motorcomm: use max_ports from
 series_info for port bounds checking
Message-ID: <74410f94-cc37-48b8-8118-5fe45fc3fcd2@lunn.ch>
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <20260904095416.1692962-2-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904095416.1692962-2-kyle.switch@motor-comm.com>

On Fri, Sep 04, 2026 at 05:54:12PM +0800, Kyle Switch wrote:
> Replace the hardcoded YT921X_PORT_NUM macro with the per-series
> max_ports field in port validation. This removes family-specific
> constants from the common code path and simplifies adding new
> switch families with different port counts.
> 
> No functional change for existing YT921X devices.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>

Did you review your own patch? Don't you think it is now a lot easier
to see this patch is correct, now that it is short, does one thing and
have a commit message focused on just this change.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
