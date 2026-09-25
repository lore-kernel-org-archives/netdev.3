Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3E36194F;
	Fri, 25 Sep 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348296; cv=none; b=KluiugoJ+SFl52ot+P5/Ik3VHrKc1wVji5+/wSEvrSjy+IvigYwc/NJEacdHnflgAPrVARq2e3i90+RIep6TkMOfQvI+032RyXbtyHlY69FzxvePORjZCO6HHdm9swcscVGJQNxCo+T6NvIzpYP/+zKtEMaF6hzqkhaZsDBhPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348296; c=relaxed/simple;
	bh=0F2OIT6MnRQMXdLWrpLb2TyOXEnxtdzKajUPegIJha4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNt2CG5aGu8DLpoeDqLlOpu7puyW3kOsz6s4q+38QoGOV+GEXM7F0lavph2dxfs/8z8UIsBQGRUc4Cxsehlo/qIEyu4tZbc841QGmKtzZegdP9XUj5HW9FQJErGmD/4us0mBMD24iKG8hT56ghihruiP5w5ElgEG6OaeySF9iKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nnkd+hKa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nnkd+hKa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lOavYm1hTi0msU7PDlwE7ydIOrqAl7/uabqbE87HbLE=; b=nnkd+hKarR1b1JLzrM17aO82g3
	byV8hs34hkwH9FtRhG7GXp60QehgHvOw0x5i/9w2Q7l8R79OMsbsTWYOCchA4wiYwAdpjY4XTiadk
	qvGUFAj28rMF/OzDZnoP2ph+Wa3K8WUB4XLp2lJgb2nJkheiAw6xLhzPWYqAFl7paspM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xA7N6-007EWu-By; Fri, 25 Sep 2026 16:57:56 +0200
Date: Fri, 25 Sep 2026 16:57:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/8] net: dsa: motorcomm: Introduce
 yt921x_speed
Message-ID: <20a5b49e-c61d-4628-84f8-762c52e0b515@lunn.ch>
References: <20260923021945.2203368-1-mmyangfl@gmail.com>
 <20260923021945.2203368-6-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923021945.2203368-6-mmyangfl@gmail.com>

On Wed, Sep 23, 2026 at 10:19:37AM +0800, David Yang wrote:
> FIELD_PREP values cannot be used as case labels. Introduce enum for
> future use.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
