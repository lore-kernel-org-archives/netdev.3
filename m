Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128B3D88FE;
	Tue, 21 Apr 2026 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783653; cv=none; b=i0CH7xdQTV4oJOnGFLB5Wnc/LCri3ToaZZjIaNTsEsButOz0zgQ7hCYTQlM7dlreRZHJduXevhjRrbizV4xkqZJ2/mOI8wfWE1xxCYSJNBrTxJ+b28fjH3JuUMeq/yb+otxACuYnP4R4lYCwcUP8d/sdgTwy+3q8M6aR7cXI+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783653; c=relaxed/simple;
	bh=S71aeDdfdUpaY9ncl9282fIlS1rXtwgai7dP2peK30Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRfXSIP0eI03++Ofwbno+WrUSLNre5sJJY6R0gx7puKWa8L0cu4c7h7R+gylwHrphYni5+M3prQnZ+VzRCr0lFEwRgX/dxS+Jl/wQXQS8977wodMTKRcfyNKcq8NobyjEdrYZ5aqt9PLBCkQRw73M+1OYjn1ntgqFZ4uzsRr02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xWibt7bq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xWibt7bq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e2fHqKRUy9mqbMrFELMAWKefaWvo9sHLNyaqno69yn8=; b=xWibt7bqToDChpom3yJjFAAZnm
	K6WwQ3YCNkbBqUb3g4rh8bjGpOianr+Lx6Gi2N6lIwxNNjk8cRV95tlB6HPO8KYFEVvTUUw/XI4t3
	S3cuvRLKg0cj8ClVdEs1bliro4DDfiexDBKGWCiWPLI1YXV2UkIZTEGfDhHES5zrvSQE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFCaX-00GuiM-2P; Tue, 21 Apr 2026 17:00:33 +0200
Date: Tue, 21 Apr 2026 17:00:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Steven R. Loomis" <srl295@gmail.com>
Cc: Dan Cross <crossd@gmail.com>, hugh@blemings.id.au,
	Steve Conklin <steve@conklinhouse.com>,
	Stuart Longland VK4MSL <me@vk4msl.com>, linux-hams@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: Discuss: Future of AX25, NETROM and ROSE in the kernel ?
Message-ID: <123aa13d-17f6-45a8-adc8-0119139197e7@lunn.ch>
References: <54da3df9-6c91-4df0-87ff-1975d536761d@blemings.org>
 <CAEoi9W5o_twDPYMZDqajqz+UYJm5wOvAx+hUFefXmU=vUbOgtg@mail.gmail.com>
 <CAEoi9W6vTPPHh-NBKZcgmo7GKTecQw1UuZ4HjwNTzqvNXWC43g@mail.gmail.com>
 <7a9547e1-9958-4bce-8547-71a93153a0d6@vk4msl.com>
 <c412bf83-e8cf-4a3d-8619-63f68e108399@blemings.org>
 <CALJxBtX_T8sv11ank-arLfoVqJqXegi3D_ZT9ZFbMHkuf-2RAg@mail.gmail.com>
 <5549733f-c9d6-4bae-84e3-285a317ee334@blemings.org>
 <CAEoi9W4L3WTVv5Hhiec8D8J=654h-p+Mh_Nd9bbm_cDyardsVA@mail.gmail.com>
 <5880136B-67E4-4D7E-A64C-FFF5A3E4A56F@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5880136B-67E4-4D7E-A64C-FFF5A3E4A56F@gmail.com>

On Tue, Apr 21, 2026 at 09:43:52AM -0500, Steven R. Loomis wrote:
> So, is an important next step, having a repo with *just* the ham items with its own build structure?  because there are a number of other modules in the repo mentioned:
> 
> https://github.com/linux-netdev/mod-orphan

Please don't top post.

This git site is just to collect the modules as out of tree code, so
they don't fully disappear. They will just languish here and bitrot
over time.

If there is going to be an active Maintainer, you need a full tree, so
you can send git pull requests. Once you have the tree, send us a
patch for MAINTAINERs, adding a T: entry pointing to your tree, and
set the L: entry pointing to your mailing list etc.

    Andrew
