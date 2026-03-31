Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9410244685;
	Tue, 31 Mar 2026 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922243; cv=none; b=YmbPW2P6nAEozgNXZGfzpCvRDf2sZQxsD9mihU7uzGGrxIQxY1291bxkoDfePCpofXd4X82FSPzfdEhjRJW7PqiDkrN2O1ElaCoSM47QCejHAtjYSjWUJEl1HMiM/aVo0EA8rDIpR9Dcnj3WrDt8BZdQssuMN9vW7DAZURDmB8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922243; c=relaxed/simple;
	bh=f/EwwW6tcN2UvyZZQmwbxNur0FnJEb8ki7XcMTnc4dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjLdDlLC/QE1cBiTTQmV26+bEJi0nIGYswhHc/Xt2G6CG89O36i04GCyfWeJ1JF045t/Sjf/bnMYb+IK9wvldKfnrB/jSsdPu+eRfhYGVQeldYb9NWvYCQ+PqVUHiATNtdoHYz27PS98XkKiWHbrEVRXaPr3BgSjlPKv288YL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpVEg82b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpVEg82b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AE3C4CEF7;
	Tue, 31 Mar 2026 01:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922243;
	bh=f/EwwW6tcN2UvyZZQmwbxNur0FnJEb8ki7XcMTnc4dQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YpVEg82bro2aUVhZbRspwHh/UoocrDHywMdEDcxO95S/KMWV2ENKq1aZ634vQ2/TR
	 nJbjTHpAI/3aKjD1c3T0h9zlV8xF94Ne7Xwr1wRdgiuintzzklS45x5r7Jx9ptkPbA
	 kVynj5SFj7eJImQ8neDKkM+WgyQhdG/a3thsLACBLRogriz4xzRI0/8Vemxzcj14RE
	 a95Lo8zKsAfReYuRfq58Ik+Iiu7CLv39UFpIkWaec+epsulUkKgBB4qBufzGaMOIc1
	 EsgLzVobIAE+VsJFfjRlX+kz9oBHBqoNdnVSgGBw6dt609OAuBTPW6WtZi5SkA+coy
	 qEO+GQvhAPAcg==
Date: Mon, 30 Mar 2026 18:57:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>, Conor
 Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Ivan Galkin <ivan.galkin@axis.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Michael Klein <michael@fossekall.de>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH v5 3/3] net: phy: realtek: Add property to
 enable SSC
Message-ID: <20260330185721.4b94ed30@kernel.org>
In-Reply-To: <20260326210704.58912-3-marek.vasut@mailbox.org>
References: <20260326210704.58912-1-marek.vasut@mailbox.org>
	<20260326210704.58912-3-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 22:06:35 +0100 Marek Vasut wrote:
> +/* RTL8211F SSC settings */
> +#define RTL8211F_SSC_PAGE			0xc44
> +#define RTL8211F_SSC_RXC			0x13
> +#define RTL8211F_SSC_SYSCLK			0x17
> +#define RTL8211F_SSC_CLKOUT			0x19

> +	/* Unnamed registers from EMI improvement parameters application note 1.2 */
> +	ret = phy_write_paged(phydev, 0xd09, 0x10, 0xcf00);
> +	if (ret < 0) {
> +		dev_err(dev, "CLKOUT SSC initialization failed: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret = phy_write(phydev, RTL8211F_SSC_CLKOUT, 0x38c3);
> +	if (ret < 0) {
> +		dev_err(dev, "CLKOUT SSC configuration failed: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}

AI flags that this, did you mean to write to the SSC_PAGE here?
-- 
pw-bot: cr
