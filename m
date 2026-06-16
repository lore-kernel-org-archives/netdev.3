Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DD37B00C;
	Tue, 16 Jun 2026 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574962; cv=none; b=Z7+sN5/JnJx0grrXVF1fFOJZ6/CHilFK1dmzSAEIQiFGx44LGXn09KiG82YHYoIdcrT2JlfGOu3vk7D2qWMR5T0piG1pLMYVA+W0+y/JcFSO//pL+8KTDpE5hbTOFczkwii4BXYK4NFIRhFuDMToRHdjEYKXqFxj+oMSo8My0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574962; c=relaxed/simple;
	bh=fQtkxkv4iwwda9CvLFoQ2NMSdISXnwwAj1jyLXFeRt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7oo40aHQKghMIyrxaU0OH70p9lTuASCiMQk8wacnu+46wX74M0Xxw2JTV3tBK7UnMGbNSbxiU6yYgdviTnPT4v9VJVnc4dZAWVKDbMk6rJaNaWDljf2y+xQgWhi7mboTvc/ybMjvRBpWoQtvAPHJDyX91pV5fRFp4qPJwTQ4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3TzGl3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3TzGl3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C951E1F000E9;
	Tue, 16 Jun 2026 01:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574961;
	bh=wHUJ7g+qiRIYubby6MtjgcS+APjIZ/F12ijowSh41ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M3TzGl3DJj5wqJijREf3+nmmkXTB7FcH+0S3CHgtxg/qemPQYpJdZ/M8XPySBtIit
	 /g1aYCkk9bkhYS8hVKHHeTXYoBk3ol6g8UZTy4PE+JQ9UydnFjBRmKgrNDLfu9DJMe
	 xTS7QdYZhZHIGXsWnz7jZ15lp2f9y76+Jwt4sJbIGYrAGIhIgTkIgviLA+7sEN4Hgi
	 MqTl7KFmwh2iWcKVTBsdYJ0mDaIJR6nPA+JIvyhOxxQwNVSi59DKAQmJHoURGcdfXC
	 rB4WjnTE+AY67I9lKvSZM5+I99Tt6ptv1Z8phWcyBJRg9D8V8+qYoOf3Cbkpm/RuXU
	 ZGWbC7YHXZSGA==
Date: Mon, 15 Jun 2026 18:56:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, Andrew Lunn
 <andrew@lunn.ch>, devicetree@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>, DENG
 Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Daniel
 Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v5 0/4] net: dsa: mt7628 embedded switch
 initial support
Message-ID: <20260615185600.5797e7e1@kernel.org>
In-Reply-To: <20260613181845.111877-1-joey@tinyisr.com>
References: <20260613181845.111877-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 21:18:41 +0300 Joris Vaisvila wrote:
> This patch series adds initial support for the MediaTek MT7628 Embedded
> Switch.
> 
> The driver implements the basic functionality required to operate the
> switch using DSA. The hardware provides five internal Fast Ethernet user
> ports and one Gigabit port connected internally to the CPU MAC.

net-next has closed, and Linus W is reworking the tagger API in
parallel:
https://lore.kernel.org/all/20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org/
Please repost after the merge window. See
https://netdev.bots.linux.dev/net-next.html
-- 
pw-bot: defer
