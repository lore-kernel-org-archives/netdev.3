Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DD2D3EE5;
	Tue,  3 Mar 2026 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545462; cv=none; b=lzd2Clcd4hhC/XtXp4e6SYKr6crWeJFEl/K5bw3O128iUetB8ztlyUwa1Ka3ZCQ6QTs6BdSfrK+TC9i81FSQ+ABj3LqBWNe/n0jtyA1Thf6p+Iv+mlws67Qv3eROdCvr5extMb9Ov9bsz+YJEGgrk91R9M3us4GRR2mIQSTAaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545462; c=relaxed/simple;
	bh=SM8CDKHTLfZStBdV6dP4UCK4RHnUUYiivZCe+7F2yeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVBWyGuXoDjvY4A4I7tLKYLAkqejcrvCMD3aLut3yz0MXMv8r/CInUUbs6mXcKEOMafI6OU6e++gfnwyOT81NjLOB9kNEfOd3xbjWjGMuvGHAK02uLRB0dZ3Odwz21FwQGJbbxbhfF2wfPWOFBI9iv3lbTGIbmM0IMig+sX5ALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GES8EzSh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GES8EzSh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lTO8+TYA6Tnx96yiik/stw1atxvhV7xNTPMgP84TLpU=; b=GES8EzShQBOiSKLc/+MajqA43A
	+7DaUuek9LbU4yyTInZhF9CawrrwbwQhxkQIwOQ/hBneTiut+B/bUq32OxEmavKZ80udWQ6QjsmmR
	Wf1H6Plfvpq1xY1JzrewuzrFG68T5Ghvvp+3J1lItR6wo4IojktlsYKcz6GK4WfoqgFg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxQ2m-009rVr-Ji; Tue, 03 Mar 2026 14:44:12 +0100
Date: Tue, 3 Mar 2026 14:44:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: maxlinear,mxl862xx:
 remove port label
Message-ID: <10a7e43b-794a-4425-9e96-4a41f2e25736@lunn.ch>
References: <61579de297eb636ec5f1e6c97d453e26abb0625d.1772507210.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61579de297eb636ec5f1e6c97d453e26abb0625d.1772507210.git.daniel@makrotopia.org>

On Tue, Mar 03, 2026 at 03:16:23AM +0000, Daniel Golle wrote:
> The ports in the example device tree should not have a 'label'
> property. Labels for all user ports have been removed from an earlier
> submission, but this was overlooked in the case of the CPU port.
> 
> Remove 'cpu' port label from the example.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
