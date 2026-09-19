Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABA3033EC;
	Sat, 19 Sep 2026 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789855970; cv=none; b=D9zw8cVHj3oPhS3w76/wm8kpHrTyRHnNf1prhRkbHIJ2USt+N521Cl3/o9cwgh0M+75HJpo/Ll9y4tw9bVAIGeUdA9ZyWSq1r/KBsb0LDeLtuQDituC79CzCmRvhWnTKhWkwi0RnH9dj6XLncdupKv81DirJxRnu9K/Dqd4lIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789855970; c=relaxed/simple;
	bh=yaD9KuxnnxEht31Jw/hLQ2v7YUhIPtSJvyVl3qLWnwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klS6fpW5nAV5jKMLAQWVEwVy7x7gJvvEl3W0FxoFmYGY0n9pOOdrDh8WecN4uNuMxSpMCYQ6muwbFFG62vIA7JqII6xiF6FFeMhSwJlddBU4ec66VBePEJt5TV6E6d2SYWDxi/2BjIoljtki/8qEDAjJQrGlNsH5QrWlXchexls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9yg/WPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9yg/WPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273AB1F000FF;
	Sat, 19 Sep 2026 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789855968;
	bh=sLFfSdp5r6lSPoY5NuQDQBRmAcElYvXq6kqTb6Kizvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m9yg/WPnjwk4HEBXMhBcTazuwfS7PTf2Mwa4dBhpcgKpRsWxTaYiwBdGKEdHa/Igg
	 ePWVPb7lfNd9IH5kPeQ3dR0Q8SviEXgd1gKOlZXJ3OA9dR7YoRdBL3B7F14Ak1HHav
	 97DylKErgRY42Ks9wNAbGg4UtCD3/8VMqVw2COw+FtNGCSOwXLeyTTaZLKGYSEuuk/
	 J3zWSh/MDkSR2BLJycdIZXPK8b4E5sZh3/bCchT5WZU5SHPGDRSsJfR/WdbIRJv6DH
	 rX3vayqPsKBMgSeRr5u2Q9+0gIMV3QVpeMLzjLBnE17/j+wh6p0EluQ68cDzF6htV+
	 Xv+3YAjHZBT0w==
Date: Sat, 19 Sep 2026 15:12:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v12 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <20260919151247.1a340644@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-6-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
	<20260916-ax88179a-v12-6-60c04c9924a2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 05:24:05 +0200 Birger Koblitz wrote:

> +	/* Stop RX/TX for link configuration */
> +	tmp16 = AX_RX_CTL_STOP;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);

don't you want to add a wrapper for the commands? 
To write a cmd from a literal/immediate value?
Something like:

	ax88179_cmd_imm(dev, AX_ACCESS_MAC, AX_RX_CTL, AX_RX_CTL_STOP,
	2);

It'd save you all the temp buffers, which TBH I'm not sure are fully
correct since you cast u8 buf to a pointer which may need alignment.

> +	tmp8 = 0;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
> +
> +	tmp8 = 0xa5;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_CDC_DELAY_TX, 1, 1, &tmp8);

Please wrap at 80 chars if it doesn't impact readability.

> +	/* Check these packets */
> +	hdr_off = (rx_hdr & AX179A_RX_DH_DESC_OFFSET_MASK) >> AX179A_RX_DH_DESC_OFFSET_SHIFT;
> +	pkt_cnt = rx_hdr & AX179A_RX_DH_PKT_CNT_MASK;

Please define shifted masks and use FIELD_GET() FIELD_PREP()
Sometimes your masks are shifted sometimes not, makes the code harder
to follow. Not to mention that this is much shorter:

	hdr_off = FILED_GET(AX179A_RX_DH_DESC_OFFSET, rx_hdr);


> +	/* TSO MSS */
> +	tx_desc |= ((u64)(skb_shinfo(skb)->gso_size & AX179A_TX_DESC_MSS_MASK)) <<
> +		   AX179A_TX_DESC_MSS_SHIFT;

(eg. this mask is not shifted)
