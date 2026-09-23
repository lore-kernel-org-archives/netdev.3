Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6DE42901D;
	Wed, 23 Sep 2026 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156502; cv=none; b=UwGjojRieYVAKWzu4bmb7GWW0mF9UXbyWbwGMW5etiIl7Ps4eH+8uPPgVaHebHfeV+DgiMn/guj5uzbnFNrTuNq4hTzswpIchOUYtsZHHT/IJbZlQ56G/1GmR1O6tkfoAqdnaU6bOnTWzTIoe92v7ZuzP3ayPImiEMYmHNObvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156502; c=relaxed/simple;
	bh=H7g9+yDN3x5kwltj5KPOLI2Ok2pctzcjorpZkubHj0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imkCAxQggVyt9jDqmCCiIvJfQCAMNhLkHJB+MyVU2BeZpI/kh4PDmIHe1knTL3Vdjp3FgIM5/CX/ZEwOrithJ+fZgE7E7KOl1TPiiTdvx5TRAyN+/KS0rPv8FPkKrSdJDt7v5/IQdsaTVdJ/zjnYAtXO3xgbb53+us/a8BQe+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OLRLlN9l; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OLRLlN9l"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9525CC21AAF;
	Wed, 23 Sep 2026 09:42:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 941C460580;
	Wed, 23 Sep 2026 09:41:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11D91103293EF;
	Wed, 23 Sep 2026 11:41:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790156495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=14/vh+QzZPhsx5uvQM0Uz7p1ZDkGwAb8ilKyyQwVJng=;
	b=OLRLlN9lAltV/1QbWWGR8Pkwn1w2rOSYmM9jOs/uT+NrrfciKSQQCasv29uuO5DEMaFR58
	kiPMFvNV8H6IE3jBlcPiiCjNNx/R/Nqr7q04XX0GiAX23f/h6yviJEx+jFfsPPAqEmwuyY
	a4SYRoP6aAFTY11A/ccCU1un7OFtTElsmd2lrlkZC5q9iPcW9SWiZ2VatsdINJfOxhKkgm
	E3GL4eyV5t89ETSfKPYSgaPcJGOaWJlASpKxlHRm6aZhaBnOD95TDLcy11Cl565UDL4dnK
	Z7zC92+KvlCltjZzeUQtLgh1HOnkzmlDpGYVQ6ysLRtkFvkjkVGCoyg1+HiMbg==
Message-ID: <5135e15d-b6ac-476c-9a7d-b7d64e4eed5c@bootlin.com>
Date: Wed, 23 Sep 2026 11:41:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 0/9] net: introduce Qualcomm XPCS support and
 add Nord Ethernet plumbing
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Serge Semin <fancer.lancer@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Richard Cochran <richardcochran@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Coia Prant
 <coiaprant@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>,
 "Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
 Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/23/26 03:07, Mohd Ayaan Anwar wrote:
> Hi,
> 
> This is an early RFC which adds the XPCS and ETHQOS plumbing required
> to enable 10 Gigabit Ethernet on the Qualcomm Nord SoC. This is the
> first time USXGMII together with an external PCS is being supported by
> the dwmac-qcom-ethqos driver.

There are currently 3 in-flight series that adds glues to DW XPCS and stmmac: 

This one,
The Rockchip one from Coia [1]
The S32 one from Jan [2]


[1] : https://lore.kernel.org/netdev/20260922200336.2201212-1-coiaprant@gmail.com/
[2] : https://lore.kernel.org/netdev/20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com/

MAINTAINERS entry for XPCS says :

SYNOPSYS DESIGNWARE ETHERNET XPCS DRIVER
L:      netdev@vger.kernel.org          
S:      Orphan                          
F:      drivers/net/pcs/pcs-xpcs.c      
F:      drivers/net/pcs/pcs-xpcs.h      
F:      include/linux/pcs/pcs-xpcs.h    

It would nice if some of you could help maintain the core XPCS driver, and make sure
these series aren't stepping on one another :( I personnaly don't have any XPCS HW
for tests.

You don't have to do it alone, multiple people can co-maintain that :) Maybe
Synopsys folks can also chime in ?

Maxime
