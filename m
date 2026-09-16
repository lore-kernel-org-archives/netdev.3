Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710BF370D6D;
	Wed, 16 Sep 2026 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562883; cv=none; b=Qky7VqJ/Lg0sY7U2oHtdhgTKL4/V6nLqllpt82IG0u4x4sdjr2Y9YYlcKY4h14r9G8MrpPx+Wvfr9wDsRJgCD6eC9ntlqYPBcBB4FHj2PTdgMibW6WBeSVPc2fCa7aPibcnQLeJfuhHT/U6NApBNkHftW8iNa6iAN0g3BkIkIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562883; c=relaxed/simple;
	bh=R34EB5qFvvrywXo1K+BTEbmF+nDTnonFgX4fLLYengc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr/0fMpHwHsXIjV0vV3BQ9g5l1Vlb7c79JKdCR0NLmve7uGBNs+GRcWboNQVZKn1Rcu8nTM67Oi12L27PcdihQ21eMmtrYczUi+l0qwYO71j0FioOqDGqn7lZAYnFYaPutFcwTMMcJYdEK2W026DkcH0P00wGMcTcPJ95Vrsudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1mtH46k/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1mtH46k/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=faRlwFMysTxCjCo21JyJKodaamvxM72G1wUYp1D5DJk=; b=1mtH46k/iB3pekHOQEV+cEM1ut
	F+lI7wR3/mfk4GNMtuZnHrrN/6iRkS0AFwqwccVodoYvFd0wtZ6fvDIMLI1iJgto9IkmlGdnL7f4v
	dRiI9+s19Gj36Mgpz1F1ctGswc/dzR6UQkUw5E3q0dyU8zjlQyhfesoNGNgoRKAwktew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6p3E-005Tll-09; Wed, 16 Sep 2026 14:47:48 +0200
Date: Wed, 16 Sep 2026 14:47:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ethtool: Fix bracket
Message-ID: <725e1e77-89e9-4077-b8df-2cb7b9be0cab@lunn.ch>
References: <20260916123458.314458-2-manuelebnerli@mailbox.org>
 <20260916123458.314458-5-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916123458.314458-5-manuelebnerli@mailbox.org>

On Wed, Sep 16, 2026 at 02:34:55PM +0200, Manuel Ebner wrote:
> Add missing ')' to sentence.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
