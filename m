Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21164156C2;
	Wed,  2 Sep 2026 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352361; cv=none; b=CEK90mf9Q/tVzqtjp/+COabbI4zG0ydXIi0fHdWlXBOA1wCU69+eW4VktwVECWURr37CuCSFvipoOgETyRzLQCqHDqAN2BUtAufEWE0HvxeVfI/KSefuUnWtm/cKKfW9OJG1W2S9ofyIn8JJ40JDWrs6ftCosdrMKYfW6gh0pDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352361; c=relaxed/simple;
	bh=voQg5/jtazeWBA1cn1jMM5yUo42OQcWiHEGzaE/cvYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTCv+MawrWr5SCz5LKTBfZeAa2pUQ5fLWyn8iGTFz62jy34+YA/KmUVSk9h4ivAlm5NO0mr9j10WMqLjuqQg1Gv3hEcD7BAp8HS5hqz29A5QdAKycm6iJuC+2Hby01olOMawjWSRMCx6ITy1rJSpdM5V8RoIbGeVNLonOd8QNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CyogocRg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CyogocRg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z1eKUbyqN4hUT7iQUqaZY2NzFw4Kd1O4h42f0UCWZe0=; b=CyogocRg5iMNBCX3BoVVvFEtvy
	MAgBAbbdPJPVBNASbm+/CYPtYgTlHyJ7x2hB3kTw8Po3UC15daMQfUxFXlbiebN+Y5OtGw06Iq3mD
	ZbGacb9C5IwLpjBXQhZlTva+Dk6B9NtA7GDPG+yFmbXLKK2Zz1OgzfrOGrQKzfwMrYXw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1k8m-002W7V-7X; Wed, 02 Sep 2026 14:32:32 +0200
Date: Wed, 2 Sep 2026 14:32:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: air_en8811h: refuse a firmware blob that
 is not a multiple of 4
Message-ID: <930ccc80-c7cc-4e92-a10a-bedb9431521a@lunn.ch>
References: <20260902080525.2211446-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902080525.2211446-1-f@lex.la>

On Wed, Sep 02, 2026 at 08:05:25AM +0000, Aleksei Sviridkin wrote:
> The download loop streams the blob into the MCU as 32-bit words and
> reads the last word past the end of a blob whose size is not a multiple
> of four. The shipped blobs happen to be aligned, so the overread never
> showed; a truncated or foreign file would carry up to three bytes of
> whatever follows it into the MCU. Reject it before the first write
> instead.
> 
> Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

Does this bother people?

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

I think this should be merged via net-next.

Other than that: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
