Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE8279DC3;
	Mon,  3 Aug 2026 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787647; cv=none; b=KcytEUaDScJW5m/VkBgyOF1Yjw9mrU/J7PQSnsN5wgjIr5RNJdvPf8v7if/TIdBHkjAEX8eFMgYkbiNdUoBVdXg5DWHbrVMlZXZsNtEgek8Df5F4G4MQiX8H/LBgd4XFmJ5Hs5uV67mEjK7Bk1fcAEh3TTrBypftkF27ksfN730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787647; c=relaxed/simple;
	bh=lZbjiDC7Rtqg11gEONuqQwaDjP63ff9JnrmIAjg+VCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPiSqYsnRCaHB2QWQ2JqeDAnXTSrfcttd6SRMgqhAAtfAzcwNHx9O12XAQ+cHG58WpUlfyvI8E/wQ4O03Ahp4UKoLn4GAwStfsosJxnx9FTUgsjDygT9dyZ67dXJIdUztUH8G6lFqg/pTw+obITw4aX58Ehk0q84SqiZ4TBDSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT5vhIk5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT5vhIk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F261F000E9;
	Mon,  3 Aug 2026 20:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785787646;
	bh=e39MQLmzEm13xsHUvYuilV4gvsHUy5xvSqXb5GKctEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YT5vhIk5Xe1jIlhcCog0v9bEYW5AVSSEsWY6r3RMI/k2SHdTgC6y64Z1c8cLEjPM1
	 GWxdS58H2jGD6zx669EUzcQX1NIzvZdAUiPy6+VIS5jKrjJxId8RT6D4ZhtMMymbd0
	 36ql3QCSH4+7lKb2wb0I0uKj8cC2GDHfHWtcIH61PaziQq5xjN7+mR8Z/rYBdo6zHj
	 sD/yhxw9Pt2m2Fg8Xukhl4gAl4DGJXMkul18YTjfmKBT0oOEBUMnw5fdRzzqqUBpkT
	 G2sMIGTnT20Du6zYa8LeL1lhy8No4Z9ikGCGm0q05DysSqsHfcviUm2RWFc+HKE1Uf
	 XAg5DjGm8IGBQ==
Date: Mon, 3 Aug 2026 13:07:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v12 00/11] net: mdio: realtek-rtl9300: Add
 RTL83xx support
Message-ID: <20260803130725.672120c7@kernel.org>
In-Reply-To: <20260803171853.507506-1-markus.stockhausen@gmx.de>
References: <20260803171853.507506-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 19:18:42 +0200 Markus Stockhausen wrote:
> v11 -> v12:
>   - v11 was sent with the wrong starting commit and with leftovers
>     from v10. Sorry for that and thanks to Jeremy.
>   - Allow to support devices that as of now only need C22 read/write
>     helpers. This avoids to carry around unneeded C45 code for RTL83xx.
>     The feature is implemented with an additional patch. With this 
>     drop RTL83xx C45 helpers. (Sashiko)

Markus, the community funds for AI reviews are painfully finite.
Please do not repost your series more than 2 times a week, especially 
if no human even looked at the previous posting.
