Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F419D8A8;
	Sat, 13 Jun 2026 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781376599; cv=none; b=tLDOK2rS9thdLjrbEHsB/d7OpvMGoON24YGZm1VHF9Ps8T4CsW7afVc0IRssjPPglwi0XlTRC/oGn22Pyc1O2s8z9o96s4hQeQDjzDBJ9PwTjeKYiGljXEecgZQvgTL7lYAHsQNlVaO8xjDUDG7CfEiRWHj/0DpCOxNp1kFnRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781376599; c=relaxed/simple;
	bh=RlRUfgopsbWVaWBaOek+H2Oc4hnhMw4e9+ZafHhhHuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7yfzQle4ryF+l4EaYnR5D5KqhBPWJz6NphqJ6fFJ1+5bkavVFOEac8FCX88zdQm4NO9s2VnjAJRIzxwqnGFf5+u66p0aBUL27dvXmlycs10qpTXtajaDKEJrY5N2DTC/j1KuE0Bv3z1ZiiJrGm0pmmhun2tWxZy9aqJOnl/uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYTQa-000000002X1-3L0y;
	Sat, 13 Jun 2026 18:49:56 +0000
Date: Sat, 13 Jun 2026 19:49:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH net-next v5 3/4] net: dsa: initial MT7628 tagging driver
Message-ID: <ai2mUbNT8acedvc0@makrotopia.org>
References: <20260613181845.111877-1-joey@tinyisr.com>
 <20260613181845.111877-4-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613181845.111877-4-joey@tinyisr.com>

On Sat, Jun 13, 2026 at 09:18:44PM +0300, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch's tag.
> 
> The MT7628 tag is merged with the VLAN TPID field when a VLAN is
> appended by the switch hardware. It is not installed if the VLAN tag is
> already there on ingress. Due to this hardware quirk the tag cannot be
> trusted for port 0 if we don't know that the VLAN was added by the
> hardware. As a workaround for this the switch is configured to always
> append the port PVID tag even if the incoming packet is already tagged.
> The tagging driver can then trust that the tag is always accurate and
> the whole VLAN tag can be removed on ingress as it's only metadata for
> the tagger.
> 
> On egress the MT7628 tag allows precise TX, but the correct VLAN tag
> from tag_8021q is still appended or the switch will not forward the
> packet.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
