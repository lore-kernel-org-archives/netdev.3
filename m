Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479992;
	b=Dmruzf3GpB/RqdVy8O1Z4CgLyPPgxiTKRVlMBeiShQ27uL5wB8vZQmXMpKPHi7yKXY51
	 hxMlDNqfs9wLIs9FOzntqWkR7Ukgc4kmvHfsfoA+YKEqrOrP40tJyuszwT5Q3fimO+KVC
	 O42bwGK01GhbA3ADyL/LGIGob8SnNtHiCEs+h9JJkGIQHMXsmQM6KivKTEAXpdnM2/cfl
	 00+8d9nhGlrIXQwK40lB14hxYtumwdkfQXIW0TxotaCtoQOb8vzdO3W3JiD7OVc1NiCxU
	 5goKh7sZIlHZNxTzHUGz8VbKhU+JXd2ncDKSVeaxbh+9iQe8/Hoz6n7nyQANpHNwSrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479992;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UEaIpVDMpEjiAIF56in2S6IKYHB7HBFZdWcGocjQkD0=;
	b=T53S1aVj9p2818o2JioMJJDdntOVi5kZbFnpYXrauY5V4uVS40jSIHTBXB35xKDP/v7I
	 50h/Ou9GMxzJ0V8MpgBaiz6/FcpqC7veniiypEX9ZmH5LRIXzeKUa+LriDWwdG9BdZIhM
	 e//DHgmZRUSnJ2bMyYVGIhcLALraFVaAifKyT18Z0inSEiv9DqDGdhu5YFpP/g3xN+wXm
	 Fd8VEpTR0vcZPtYW0TjsicWk29lyFdhbyv9wzT/txWEXL7ItKG5hQo4Md1B0Vv+WTWoUv
	 kT21q0GcpZwlwFWYfpqUbrOvjEKY0HTzoiSYK8tIo71og4wyHaulczhNDkLAI+CBq0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3cYEAdH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A0606A31B;
	Tue, 20 Oct 2026 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3cYEAdH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F7F1F000C4;
	Tue, 20 Oct 2026 07:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792479991;
	bh=UEaIpVDMpEjiAIF56in2S6IKYHB7HBFZdWcGocjQkD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F3cYEAdHeZswP2tA7SCBbjmk+czWVCQ2y5EVu3O4kt3xV88xmTaizmIWlyqHHozMe
	 FQ+GGHsl79NoONOgZvmc6X6WrskIAJc3bg/nNIRqd5Pe9tXVCZYFpQC5AHHRWWkPge
	 X57jLSoQtE/X2zZ3dd5T6k2F72OSliREGhehzqChAZwRt70gvpLwMT80FLsWp6+2vf
	 vizMu/4/0X+C/7PnzO3SaDz/3/U5GcU/Ye7gam45j0fhusd0qzHoSFBlZp8TFzblmd
	 QtPhp3PayuTnma5v15JhnevVUqHOEGDNmm9ZHRSP2vJyeWBa2g8zJmKn1UoD3ZpZA3
	 nw9tbqw1l57+g==
Date: Tue, 20 Oct 2026 08:06:22 +0100
From: Lee Jones <lee@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, Joris Vaisvila <joey@tinyisr.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v25 04/10] mfd: an8855: Add support for Airoha
 AN8855 Switch
Message-ID: <20261020070622.GB1206986@google.com>
References: <20261009161102.38961-1-ansuelsmth@gmail.com>
 <20261009161102.38961-5-ansuelsmth@gmail.com>
 <20261019164248.037971c8@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019164248.037971c8@kernel.org>

On Mon, 19 Oct 2026, Jakub Kicinski wrote:

> On Fri,  9 Oct 2026 18:10:49 +0200 Christian Marangi wrote:
> >  drivers/mfd/Kconfig         |  14 +
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/airoha-an8855.c | 579 ++++++++++++++++++++++++++++++++++++
> 
> You didn't explain why the MFD is needed and more importantly what
> merging path you expect. We need an ack from Lee, at the very least.
> Given the merge window has already started I don't think we can
> do the necessary dance in time.

This patch is orthogonal.  No need for a mass-merge.

I plan to queue this for v7.5.

-- 
Lee Jones
