Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432E4A0126;
	Thu, 24 Sep 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264724; cv=none; b=aU3keDky+dQWzKQqMkGFIsB/1/oS6uz1F06TBeZUdOmOar3Lyun3o92FsTpCPv9KFlraJSyJwQ44tO0lG3RpIMwxz677H9drhgcLwYG0SBfhuVTuWcOofI7fH8l434+zgeZDQQPKOVgh6lPu1OfU5n0vqnZbw01raiAm2wz9edM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264724; c=relaxed/simple;
	bh=o5XfZnBwKP4YXIB0EJxf9/ByjaFULvwCkCKlZa6GXm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G19wgpulxQY36gkFeyrS5Q+ka84S+dFbQu6k8ZbNjqwJGINzZ5HEosgbJz0BnGCzUn6AkXrcS3SqMG3f3TeAu6pDwUNBcb7OQIiTRsdVQBTR5JvO/HCxoaG5gqP9DBnYzJhYbxaRWkjvQ2N95YMkGGB+ufLBqrCSGDxFOMLyync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdmuJUyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdmuJUyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A041F000FF;
	Thu, 24 Sep 2026 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264722;
	bh=kdypyC2EEaeoSTkqpgQwsJ5aZ5bx5ISsf4WGyRg9+mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JdmuJUyFJfCQDSYoka49s/bPfPNeRd/+KyYjOoltcgZ/TG7cv0M1iWhMnHj5OzR8t
	 5Ez9OVkkMo/OfynzZdT4w9mu1477zd1w13qkPhDKqif4kM9zbqHRZjPoLrGWEf2TRd
	 bDOJ3BMvL8ucqJdNzk1iwIfN+fpLPwSLgQCuI1rBBaz8sNnS3MPT/Yxvy448/OVKjl
	 JK6ezdFQ3rGwis+4YU5ReIzsr/DRltjrQDTB+Z259nFZ24Jea4QXucL3emtraPYHEN
	 GDHh/kVPTKn8konttnYh/E4/4dG7kf5W5UjRlhR9qkeiUcRHN9Yj9gtuuAbWU8eHJH
	 a+rbrvPe+TOfg==
Date: Thu, 24 Sep 2026 10:45:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: chester.a.unal@arinc9.com, b.larsson@gmx.com, matthias.bgg@gmail.com,
	edumazet@google.com, Landen.Chao@mediatek.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	arinc.unal@arinc9.com, kuba@kernel.org, naseefkm@gmail.com,
	davem@davemloft.net, andrew@lunn.ch,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	angelogioacchino.delregno@collabora.com, olteanv@gmail.com,
	daniel@makrotopia.org, linux@armlinux.org.uk, conor+dt@kernel.org,
	sean.wang@mediatek.com, dqfext@gmail.com, pabeni@redhat.com
Subject: Re: [PATCH v2 net-next 2/7] dt-bindings: net: dsa: mediatek,mt7530:
 add passthrough mode
Message-ID: <179026472132.335875.13282217589562743925.robh@kernel.org>
References: <20260915174643.253660-1-cjd@cjdns.fr>
 <20260915174643.253660-3-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915174643.253660-3-cjd@cjdns.fr>


On Tue, 15 Sep 2026 17:46:38 +0000, Caleb James DeLisle wrote:
> MT7530 switches can be configured to blindly pass packets between their
> CPU/upstream port and a downstream DSA port, in particular, without
> altering the MediaTek DSA Tag on the packets. This mode is used in some
> integrations where an SoC integrated switch exists, but a more capable
> MCM switch is added to effectively replace it.
> 
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> ---
>  .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml       | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

