Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC43DD522;
	Wed, 15 Apr 2026 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267019; cv=none; b=pBiZt/CXP1+wij9SLucciyZotKy60gzcOjK56xAm//X/Hl8gcEdL9oVRUINsTpkucqu8VVaUG9KuB4e8N1uirhyFEZ9lNXWldPM1XhW66TMxeeFj24KJ4zQkf9DOcOTMp+9NCtXnQB1EshE0RXb33zVm7BLhasb3k1yJMW9QBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267019; c=relaxed/simple;
	bh=ESfl9wyviW3BAaunIcEEGUJMVhWPFL+JEtRC1hhT+ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD1n4daXbIPCrWL39ZblGL9yA8GPscFi9t+s7szGKIZwoekv8b24PJ0JuzmjTVxXWl7rTSSn/EnoxinyxehXvjqEQQUHQ2xIbAdk8VfoANl38FyRiKENfk+aOp5zt3Yn5t6SsUzOzxgttma/cbjnCRHTKv5WPcwkOyvP42sctLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RfhJOUJ1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RfhJOUJ1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZVkoxkuSnCO52305MbQjeIQpzm8gcFMJGu/eTORw+NA=; b=RfhJOUJ1E6ZDtSmO9g+85qrS9J
	AII2wF3ABs1a0Y/hN5f/T6Ewi2+BBhJKeWC1yVMxUJ1IOUyhIp2LxBqjkKL2g2SF6Ecc6iwU6qAcR
	jRg6jx2cQoXvgpWj/DFiboNwYIByqiRNjA2oWKwwx8xgxTIoHCBJ0KkNCUCRTQNxXhS0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wD2Bs-00GBh3-LS; Wed, 15 Apr 2026 17:30:08 +0200
Date: Wed, 15 Apr 2026 17:30:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Cc: hkallweit1@gmail.com, fujita.tomonori@gmail.com, linux@armlinux.org.uk,
	tmgross@umich.edu, ojeda@kernel.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: Re: rust: net: phy: intent for MAE0621A (out-of-tree C -> Rust),
 request for target guidance
Message-ID: <1133af15-676f-4d70-a57b-43e26e0c4e82@lunn.ch>
References: <AFkAcAA-KLHz8L2oAyS3qqrb.1.1776247198201.Hmail.2023000929@ruc.edu.cn>
 <AN6AigCwKNz*0oYAjaS2aKqr.3.1776262694321.Hmail.2023000929@ruc.edu.cn>
 <f57bb151-bc84-4c67-ae43-8901b09de884@lunn.ch>
 <AF6AxgB-KF5*XoYukJCGZKoD.3.1776265264920.Hmail.2023000929@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF6AxgB-KF5*XoYukJCGZKoD.3.1776265264920.Hmail.2023000929@ruc.edu.cn>

> If you have a preference between TrustOnX Player (TOX3) and Radxa A5E as a
> first board to try, that would be very helpful. Otherwise, we will investigate
> the A5E path first and come back once we have a clearer hardware/testing plan.

Makes no difference to me. Use whatever is simplest for you.

If you want to do more than just convert the C driver to Rust, but add
new features, made see if the LEDs are controlled by the PHY? Is there
an interrupt output from the PHY to the SoC? Does the board support
WoL? These are all features which the Rust binding is missing, and
could be added, if you have a device to test them on, and the needed
register information.

      Andrew
