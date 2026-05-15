Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F53F86F1;
	Fri, 15 May 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859365; cv=none; b=LxXj35cW74vEgHFfZvbePkPs67DkTVWOMmba0yqB9k2FJH5yrhsIdz3NQ6aupiAiJpBGD9KTrPks98HVDG77CPlWFE+5NN2Vcp2nVxqBbokTjVDPSMt9UQwFA2jqJX21suk6701t/VTIoj0JWl4wHyRfWKCajFG5JiM0aK5C/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859365; c=relaxed/simple;
	bh=l8VkPLld4hjvvdPlQLvoSP5ZeyUBY7LslnUOfwHo8iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3uTuZSCw4IUsJhXkhGkZT4r4FA8udKacvPSCguQHByF7SB0g/7vkgNlK/FYZCo3Dl429Sz3+03YSp6BWNknM0TL47oi3ANzSbpDDC0tD/G7+Pl2dELlWj5hXPhPHJzD9hGEa/oaaMOIsREyjhrghtC2Eq8kmFWpNjcFjkyNvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TeRb9AF3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TeRb9AF3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3mNCRFoPPfrcZYZiojI7XDP281Kb6OBeB+IePmQYfqA=; b=TeRb9AF3Y101W9tklLe/NluDbt
	Thn14LpXFk9VHvLBdQiVmdQAzFC1XnVAcVtElRBlfCJqZ+TS4wEO385bPOKD9DNW7eIyBWEuV8CON
	vSF7gtb7sJ+BOLvIbef/9L6fpT42lzHFs2qV0sE7A+OAYO2PWsYOb/HDb5oYBxjjmOEg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNuZn-00359q-H6; Fri, 15 May 2026 17:35:47 +0200
Date: Fri, 15 May 2026 17:35:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, marek.behun@nic.cz,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [RFC PATCH 1/1] mv88e6xxx: Cache scratch config of 6352 in
 setup
Message-ID: <ccf88f9d-9617-4ee9-bece-d2e41081bcd2@lunn.ch>
References: <d979651d-bba0-4042-8e72-609b56121682@lunn.ch>
 <20260515145042.3091827-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515145042.3091827-1-fidan.aliyeva.ext@ericsson.com>

> I have one more question; now that mv88e6352_g2_scratch_port_has_serdes()
> never returns a value smaller than 0, should all the callers be aware of
> this fact?

You could make it a boolean function.

Shall I change the checks for return value on this function not
> to check for <0 ? All the callers except 1 will be refactored to use
> serdes_get_lane function later, so it might be unnecessary.

but if the code is going to be refactored, it is not really necessary.

    Andrew
