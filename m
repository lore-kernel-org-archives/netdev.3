Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFB37B3E4;
	Tue, 16 Jun 2026 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575664; cv=none; b=nFudACp4dkWIpQ3tHTrxKrnUFqbt/hDaH8DRn3iDFCqh5kFJ95go2S6SJ9x/8M0Ey5XpCu0RXRV7F0xJKIAAnw9IrneF/ihmjb9bTtji3LmZ3wZrFOzlh3yhvMZn9qpLj9LhQjxlwn29z7wLKDHplC07hQKAsIeUnqla/eDme5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575664; c=relaxed/simple;
	bh=4JZKTxT7crBfVrB16b0OPjyYkMILNzEfJCNL/U2s164=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kjdo6ootcNAq99rQXEKUAU9rbIxCs+Wv0h7yvyo1kUIJGxEiJ6Y+LSHpS2EytsVMNAeZuDG3D5WCOk08m9meuEASRvQ4rJGXCYC7kSGPbA4XqUDsA2vFtkU4g+pCewA+Km9dPBulfY2+k1/xCoSnH1TzlYXaSvHSOSh/ZKWphHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXqksULJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXqksULJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307D81F000E9;
	Tue, 16 Jun 2026 02:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575663;
	bh=4JZKTxT7crBfVrB16b0OPjyYkMILNzEfJCNL/U2s164=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lXqksULJktIqCM6T02VhI+nelZ2rfCf3toSqfnzsCyCq/lJzkQtKC0CxaR+hTlJ+U
	 HbwCaSmweB3bsmIoFQXFHp0t9c6vs81sb6e/2bYHkKv2aQDFk7FoX2YXTIv+RhhKd8
	 WMiAcUy3Dm52/b6PcbMHcPvZF1bh6+CbHH4Vp+r92HUBOEWBYK0rJKlAWHdPLptFLP
	 7PO5fE9ogQQd0ErJZ+SAhOdrT2kECeOf0zGyMw8WwU5Y9ec7gIal5h+vWB0Mg4TbIT
	 HdGBmE4WGJGhTb0uE4gWRwQPDr/w6haGdHaqwrW2sr12ajy/bDCmZX4+6zL7mUfJT6
	 b9cysonDwstDg==
Date: Mon, 15 Jun 2026 19:07:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <daniel@makrotopia.org>,
 <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v5 0/4] Add support for RTL8261C_CG
Message-ID: <20260615190742.5b9313c5@kernel.org>
In-Reply-To: <20260615090817.429-1-javen_xu@realsil.com.cn>
References: <20260615090817.429-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 17:08:12 +0800 javen wrote:
> Add support for RTL8261C_CG and add support for loading firmware.

Looks like AI will have some comments on this series.
Not sure if all of them have already been discussed so let's revisit
this after the merge window.
