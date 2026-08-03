Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EC9410D06;
	Mon,  3 Aug 2026 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765275; cv=none; b=Uzq5/hkjQMxXMx8W9Fpqy5THde2151lDdZqnfEFFtttPhPS8whaXkjovljNMre0m2DQAT4Sd4SLYIL4xRuLiVsH1VRTgbv3oazha5hE1yJ1xQ2OiJCZru47wIro1Slu5azAndsw0QlJFvHHV0np2/MJvhnbtkFVxJjc30LouKpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765275; c=relaxed/simple;
	bh=uMR2wzjAHumjCFpq8CHfoC4l0oLwZhmUUYYdpoGfwLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aark40Mlt0nZWGVH3YSCDzc86u2YyODFkFobrBv4kvYPwiDLj+n2K6Jjr9eHmKE6/48xR2ZpviCkfXhowO9CbpTUJhnMJL9g9emfxeEJGFlMexGUl5JPWJGoHdLnnTRohlD8NIWfEu0yGPdhmPqsPBKy4RRmpJ/UeIsn/9PKjfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=truUKiVE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="truUKiVE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48E381476;
	Mon,  3 Aug 2026 06:54:29 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FA373F66F;
	Mon,  3 Aug 2026 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785765273; bh=uMR2wzjAHumjCFpq8CHfoC4l0oLwZhmUUYYdpoGfwLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=truUKiVEzJC/b46H16TtYHBYwRnreu5zys6pASHs9n3MH7XCBXxmN1sd+hSZFel2k
	 mKrQ4aXd2emd5Sqsz0/Tfsp2jyFoVpuP+Q25sbNx/jRYTsJPVXhtA7YOC8+YffAvW/
	 o31zZWeJCMTKa1R/KhhlFbgtjsBrAMHLAGMIiQmI=
Message-ID: <ae236186-e984-4fa0-ac70-f321068576f1@arm.com>
Date: Mon, 3 Aug 2026 15:54:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] net: phy: add X-Powers AC200/AC300 EPHY support
To: Andrew Lunn <andrew@lunn.ch>, James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Maxime Ripard <mripard@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saravana Kannan <saravanak@kernel.org>,
 Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <d2a1f26b-a97f-4cd9-993c-5dbca530abdc@lunn.ch>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <d2a1f26b-a97f-4cd9-993c-5dbca530abdc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 8/3/26 15:52, Andrew Lunn wrote:
> On Sun, Aug 02, 2026 at 11:14:10PM -0600, James Hilliard wrote:
>> The Allwinner H616/H618 secondary EMAC is commonly connected to a Fast
>> Ethernet PHY in an X-Powers AC200 or AC300 companion package.
> 
> Is there an open data sheet for these devices?

Find the datasheets at the end of this Wiki page:
https://linux-sunxi.org/AC200

Cheers,
Andre

