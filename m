Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F313489FB8;
	Mon, 12 Oct 2026 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809679; cv=none; b=B8pxHyz6LbTzq/kzIkfq63yAYX7skEGb29ACkNbY6WUA4moaunc3Jowgf8I0Gt+2cLIaYkqEQ9zD/dHP+t3AISY5Wq061FtraKrwYNpC2XJqcQ1ngBcvZDoDJ5wmnNV+WR2ToYdo1nM2DJCkbcxz5RWqt0cvm1zgxonrLAQHKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809679; c=relaxed/simple;
	bh=Iy4G3KkQgN/NGCU7Ua1uYFQsnWkG6B5FBxm3LSnuLN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgw1TqZYio7qFTQB4wotpcsCGg8y/chBL25g/TnQCDkQDexJCRApkvKcF1qCvHrDQN3HyBk2JjRlvD6pKzgA6IZNWrBlNml/zoTfZaSJ3jpHZNgUHXzI5u8+Hss9FmlL3dIzLZyYSVSLvvvqyYIDGrUlF3HBCFUGbIb8NIAsoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zv1e6mS4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zv1e6mS4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i4wR7/o0Lt0vZN0c0TRid1OYZdhYCCTPqOaf2Deqb7Y=; b=zv1e6mS4qjWBRiRy79gJIJEaGc
	8j4u2HyLfOKbOkvHlB4SCxfZnSMpiv4KRAvOjfkMeXWrXkIXTnYgbIAY/tgGQM2H/1ixGEuaWwGyu
	4Rz9hoy4V5GRaROzC7OETOqjo4++eiW0nX6myZdcTBSD7uugIOqtW3VjcHGhXCE14/BI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGFY1-00AKBV-BK; Mon, 12 Oct 2026 14:54:33 +0200
Date: Mon, 12 Oct 2026 14:54:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, oliver@neukum.org, giuseppe@southpole.se
Subject: Re: [PATCH net v2] net: usb: cdc_ncm: reject short
 GET_NTB_PARAMETERS responses
Message-ID: <66ef60eb-524d-46ea-b6c8-0543bb2c0c63@lunn.ch>
References: <20261011035150.53315-1-xinsheng.zhu.ny@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011035150.53315-1-xinsheng.zhu.ny@gmail.com>

On Sat, Oct 10, 2026 at 11:51:50PM -0400, Xinsheng Zhu wrote:
> usbnet_read_cmd() returns the actual transfer length, but cdc_ncm_init()
> only checks for negative errors when reading the NTB parameters. A short
> response therefore leaves the missing bytes zero-filled, and
> initialization continues with parameters that were not supplied by the
> device.
> 
> CDC NCM 1.1, section 7.2.1, Table 7-3 defines a 28-byte NTB
> parameter structure. Require GET_NTB_PARAMETERS to return the
> complete structure before continuing initialization.
> 
> Return -EIO for short responses, including zero-length responses, and
> preserve negative errors from usbnet_read_cmd(). This ensures that a
> zero-byte response cannot be reported as successful initialization when
> rejecting an incomplete response.
> 
> The issue is theoretical and was found by manual inspection of
> usbnet_read_cmd() callers with LLM assistance.

If this is theoretical, please drop the Fixes tag and post to
net-next.

	Andrew
