Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972630CDBC;
	Tue, 18 Aug 2026 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073713; cv=none; b=boJzbioAHz+re0wYXsWeCQWXU8rd7DGxiq06AT7dnmyJqzUOH+KKJeSNwelkcYqWb2oKkdLtQyoMzdaUvyNA1hYIFVQMgNFN0nQSzc6HU7wIw2HDY5nP7WWUebZTFvxteZmKXv02QEaOrF6RENfWQGRwGd9evEGJOERajkO7nRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073713; c=relaxed/simple;
	bh=AMv6yCMj2ervvOHOLVWwSEDUrbz3jXzvaLhHrbqxzLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unDm3eKgE0LmxvEaZLpliWS3XpOHL5WVpyg2u1N45iUu8WpeXfaDAHjebrbaCnCuKpDyLGWI9fsPnafmCfmf00FUu9jT50m6pRKNOKMV/TFNj8TJNoCGF/NjDk6r3SbmUtTu41FfMCPPaIxUCld95wE+wLgU7fWZDfc624xaqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnGOAO25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnGOAO25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526E51F000E9;
	Tue, 18 Aug 2026 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073711;
	bh=oWNjukkUyW2WYnB/Po+cgOxLX8j0rZ6dElF3qVSs6LE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AnGOAO25Rplq/AiFV+geJu9Uu7ZOaPtQpc9TzADCa8CLMxPBIjOWbKG5YroSjUCkh
	 1MIDKbJLedLLAJvAvozbRRoFRuJjouoGf8/shj16eW3w3dcXjNzcWbBL1BJMWMxmyg
	 OD1B8kfqK5vwwG2eZekiC+215RCc7hknlDh9kPvb1gv/Q4tjTQ+wza+7glWucoR6be
	 7KmCZLjckf0sZEg5SeFAwfR4CTg5OFPaVta3g9dPY5k+CjmsFIV9X27D25KcQTOiji
	 mzIFyFz8xcmnEiSdbJP+iD8o3s9nM2S9opz2+VDAwtyn+nH/WJlpSiTf9yT/ZDk2iD
	 w2t91Sp09G2Tg==
Date: Tue, 18 Aug 2026 10:21:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Winter <jjx@live.nl>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@rainbow-software.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v2] net: usb: cx82310_eth: bound partial-frame
 remainder by current skb length
Message-ID: <20260818102150.5b4a1c60@kernel.org>
In-Reply-To: <BESP194MB2832095AA142E77E4F39E33EB8A72@BESP194MB2832.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2832095AA142E77E4F39E33EB8A72@BESP194MB2832.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 21:54:34 +0200 Jason Winter wrote:
> @@ -251,6 +251,13 @@ static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
>  	 * end of that packet at the beginning.
>  	 */
>  	if (dev->partial_rem) {
> +		if (dev->partial_rem > skb->len) {
> +			netdev_err(dev->net,
> +				   "RX partial frame: need %lu, got %u\n",
> +				   dev->partial_rem, skb->len);
> +			dev->partial_rem = 0;
> +			return 0;

Always ratelimit datapath prints.
You should probably increment rx_errors as well / instead.
-- 
pw-bot: cr
