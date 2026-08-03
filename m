Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6819DF55;
	Mon,  3 Aug 2026 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721562; cv=none; b=oM46HoGPcHrBby6cbg1Gard9+0j9CoXLQW+5dMZTvDXfL2ydKxlTcrIoxIXbATWE6fUszv8O1Y4WQmFRnXgLqp+W5tQFVN08MNquByoV4TUK00LI/wyQbRmNzWAhlxQzbzbOc3gjSbt29Q4EdAiIaWIXAQGssFEHfeYamXCiQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721562; c=relaxed/simple;
	bh=QyFzjCqjY7uEZRws4LKtNTUJXsiwPaqTv20mgsxjKgc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p9SGXVxcF/PtEzNQBQ4FGSFQs/VU6cO6cg0HnkFwT8VytRd3quCL+QS5/c+kAstErh2wdL4Gvtijle1ruuO4M6L+I4Qa4R/uCmkRgkcrrg5S/gf14FwKto3cwyU/UyuqZ099+lcIGhdB2jx4rPdQB/5CZZQQY6z962WeZ4BWdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OayOjARH; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OayOjARH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1785721557;
	bh=QyFzjCqjY7uEZRws4LKtNTUJXsiwPaqTv20mgsxjKgc=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=OayOjARHKRkxNBYY36mKOZRTyJ27C6uYSTe2cW2bpnXWYT2urB6PBDeRxj5h2TFDK
	 saOMrz7UN98kIwWdnqp520JeIjAlQTFTAFQRYgI6HnAdfLIu9hS6PEFQYOSSTrqxVi
	 8nVbIIyjdu8ffvLct+ZZZT/Dmd2itjnVjO6Sqm81zjJrrBQuZ386DPMMxZWUduSjpf
	 dr7jZ1FzYX1/3O/GUv4x0QNpbgD8SFsauduI7RT1zjg9IIhYO96t12tDbPaVjOiKoD
	 j6Zs9/INLCrs8zT8i4a673yl/tfy2dwyNYCiiwySMKz9ALebI2znc6e7hTMfBXTf7b
	 HkU3dJkrz2OBg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8254365626;
	Mon,  3 Aug 2026 09:45:54 +0800 (AWST)
Message-ID: <7a537ca124f1b5d0b8dfbf9524f47ad5120e9dfc.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v11 01/10] net: mctp: usb: Allow multiple urbs
 in flight
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Markus Stockhausen <markus.stockhausen@gmx.de>, andrew@lunn.ch, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, 	chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, 	krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Mon, 03 Aug 2026 09:45:54 +0800
In-Reply-To: <20260802083528.490216-2-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
	 <20260802083528.490216-2-markus.stockhausen@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Markus,

> Subject: [PATCH net-next v11 01/10] net: mctp: usb: Allow multiple urbs i=
n flight
> From: Jeremy Kerr <jk@codeconstruct.com.au>

I don't think you intended to include this in your series? Did it just
get pulled in from your net-next base?

Cheers,


Jeremy
