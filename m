Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E93126BF;
	Thu,  9 Jul 2026 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605496; cv=none; b=t/gMqW9nxfltwYjPl3jvQyoOur4X/foO3hero7N7bYoswLGjfq5wieSRiYRMc865WqrXRUvTkX8SnvVbzZE4sMVJr3Ovsuvr/HNASyn7uLemewKbWErNDyEA3cGDp3hSmOGL958qxQcOCXyddcNcjWphbcbecDMRHp4fksI8BDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605496; c=relaxed/simple;
	bh=3hwXFOzv/YTq/Wpo0kEOWr1fqx4v+yPB06CDQGibXQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDkUoF7UuRFHMWvOA1ynPH5yobTJJvy/4kxiHk+7o2R+y31aPTyWMOi0O1vEzJ6sZnX4sfDliMgxDKdY0/H9Dn5ZrkgvHL8cfXV69ddrUGWW4+bM9oDsp1ElA0Yn0iQZ0Mh7uCByzxdEystvxpGSXJcjqu/R09jfgzLj/H7W4us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FsTDzJUP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FsTDzJUP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3j5wUOy81jE85IQW1jkfY+qaRlufRS4VpmYySwqNofk=; b=FsTDzJUPGt8N4nYpc8afLFPlRq
	6M/4HGyszaGPq1I2VBGgct5CSRElAYMq2jKF2NlK7XRldUwQw9HOfyWvfo9n7XNw/G0qK9Pt9iWFv
	3A7mAIyFw7MQVKzbTsPIgbFggtRqTwbxFmHeP2khEkhdUaqJsRPCZLjfVHMiBP3BJFCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whpGS-00BVJu-UW; Thu, 09 Jul 2026 15:58:08 +0200
Date: Thu, 9 Jul 2026 15:58:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: packing: fix brackets
Message-ID: <c7a53f96-b5b5-4e41-b134-afb0b1518c33@lunn.ch>
References: <20260709121427.391749-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709121427.391749-2-manuelebner@mailbox.org>

On Thu, Jul 09, 2026 at 02:14:27PM +0200, Manuel Ebner wrote:
> Add two ')' to nested functions in code block.
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>

Please add a Fixes tag.

With that: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr
