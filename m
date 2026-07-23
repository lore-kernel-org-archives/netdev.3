Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380B17A31E
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769553; cv=none; b=Txi5QdhFiErM/OL+qvwrblzAeo3pWp7hCNcqW8y96d9l1SfPKSb4qYDGXFiwdoW+lmzhqsJnzbDse+nf7lcEzMupBo+cDKaixV6NAAwkOPa178pQQc1SdZisf6WMX4AKc2ssuYqdObOK7Q30nlMLjpwnSVjQZjL8KuGoajnpMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769553; c=relaxed/simple;
	bh=yPfHWXecAhJNbJtpBip7OXbVeothl6xxuj73iOWRHro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+3Letb0Mu30VisZKuxQI7wHeecigX6O+McY76ijqMrCTV94iWO/WJQ7cvFmnutDpJMCvEqFlgyBJ6RDV8QvYJbXeAS2vUZowLnmK4jvYOs3xoNE+PCJfnl7Cs9PpdNIf8tV4l86rIX2jInNFc64DnEIQZIAk4ORN5Wz0OKsYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A88M5GOr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A88M5GOr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GUl9GfrIMAuCwpW/UcAf8a5IoCIG/9gP+sMaCQDdt+g=; b=A88M5GOrRA+QTs7oyHwVfOdFJN
	+p9HnCcQ7E3hvB6dKhz11rcqM0a+DLS7bDYA+7Dmxvq7zyR4FbFCHw2R7dE82kD+qVZ+qL8pG2dXS
	rOp7l+Necsm6S3T9wCWJ/WZe12qc0hBae1iTfLZRFYr2RcHgJ6mrPll3b+HNuM1tx1Cc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmi5d-00Dihv-1C; Thu, 23 Jul 2026 03:19:09 +0200
Date: Thu, 23 Jul 2026 03:19:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
	conor.dooley@microchip.com, charles.perry@microchip.com
Subject: Re: [PATCH net-next v2 1/2] net: macb: Poll for link state changes
 when using the internal PCS.
Message-ID: <2d4f87ae-f1d1-46b8-9b51-047b1b8661ff@lunn.ch>
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
 <20260721180158.13014-1-nwhitehorn@pa.msu.edu>
 <20260721180158.13014-2-nwhitehorn@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721180158.13014-2-nwhitehorn@pa.msu.edu>

On Tue, Jul 21, 2026 at 01:56:01PM -0400, Nathan Whitehorn wrote:
> There is current support for signalling to software when this changes
> via an interrupt etc.

I _think_ there is a missing "no" in that sentence. Maybe the whole
sentence needs a rethink?

Otherwise the patch looks O.K.

    Andrew

---
pw-bot: cr
