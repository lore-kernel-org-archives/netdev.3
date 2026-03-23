Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632B3815C5;
	Mon, 23 Mar 2026 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304325; cv=none; b=JvChuysRX9JFqvzLtFvkoiL3O5vQdXXxDXJ8yBArSMaNJhYdkf1b6/ljjY+YB/xkUxx7de5ZsPBtOY+DHUByoVYaCFTCTo9m1GXtjZwYD5YUoBABjUhHep4SEcq/UOFqSw//aQcVsTBV/7cQ/DX82OuQAw2s65Zw9wN/NHQJSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304325; c=relaxed/simple;
	bh=TXAN6qfhEdDp+ymhStLlsAYy1NChaJbLVrt+YTIiESE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owI8uo6iuAa3tBmeuyGK3QRveJSr6h6ih9yBwAifvnokROS6A/WCml5zRVR0Tp2RBRaCBRcWFMg2tS7TDZXWu11vrQ9Enf/8Fs6eOzu6uiAI0R+C6JFrGcRt9dJ26WQpMmZ92fnch+Kd6oKaQLgkybPUoQQ7+Qny6ipxAPGPAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d67HOB/S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d67HOB/S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h0qLw3uDMbiv6CTLU/5iNVz59YvSWpc0zZbRwGEV7Go=; b=d67HOB/SxyxpTUYFegtDu3Tg8V
	wqccElf0pB/Y825QhxFOKUVQDVTr1gB1bPhaEIF7me2OC1XJQ5+l7qg42Sts9MEVk+0FDGSLkAXxI
	yS4KIf+HpF9OwYKzwJWvcl/Xztx6OiQe2mAs/yasodlOQoxAxnj2+3JQ/5jLPgTutaQU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w4nbc-00D0FP-BH; Mon, 23 Mar 2026 23:18:40 +0100
Date: Mon, 23 Mar 2026 23:18:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	fujita.tomonori@gmail.com, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, dakr@kernel.org
Subject: Re: [PATCH 1/4] rust: phy: add read-only device field accessors
Message-ID: <ec1ecea4-2744-4bf2-9003-d13ae7ca8543@lunn.ch>
References: <20260323201925.8405-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323201925.8405-1-iprintercanon@gmail.com>

On Mon, Mar 23, 2026 at 11:19:22PM +0300, Artem Lytkin wrote:
> Add getter methods for commonly needed PHY device fields:

Hi Artem

Please always include a patch [0/X] which explains the big picture of
the patchset. It will also be used as part of the git merge commit
message.

Please set the Subject line correctly:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

These patches are for net-next.

Every new API needs a user. Please submit this code together with a
PHY driver which actually uses them.

    Andrew

---
pw-bot: cr
