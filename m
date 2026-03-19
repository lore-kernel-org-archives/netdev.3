Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87EF3B19D6
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912450; cv=none; b=M6c82KYITYkuCdLEd/wBi8l7R5eFYQtPLIFImwFRCE0gkZtSzozMVQAl2a8HxAj0ht/BHgOLR2tHHJRnzcNZU9QP1BfUOf7f+qOdkwEEH78I3A0DGTJdAMboKWyd8lUmW4DuvcYJ0lb1D/SKQr0mwj4S7osFoFtTCP4Ms0mKauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912450; c=relaxed/simple;
	bh=YBr0RMfpQC77N2Tw0uYXor4vrcMTlYczB9RmdO2UYQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dp+YhGbLN0L/8YVCmhthTScM0bZPmCwUiOohdfe6QSc+G3vuDzAE23KhgiT7/CYOYiBoU9QaZVM/fFo8sf+G2kYTRvs5M8YbbEqoEMw/o5tEeBDq442t/VxRwWzMYqpHSPh7Snb7/9djtNjgPolgItaX+3hMBxTgIl6Uxvg2r2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w7e5uTs6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w7e5uTs6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7F2F01A2F05;
	Thu, 19 Mar 2026 09:27:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50C095FDEB;
	Thu, 19 Mar 2026 09:27:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3160A1045069D;
	Thu, 19 Mar 2026 10:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773912439; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FP7F4nTHlFG27/CISGHeaKs9d9BlUYCXNg7iUfWv3u8=;
	b=w7e5uTs6/Ao6I2+J9HRPV+9s0P9xrADU2wYHCjvEJ75/h1Ai7VNj5hv0drvySEN4YFuhrI
	rOYqwcG/Xj17niBcKP5dvAiEYKf3OjkQHrgRGxAqWUz+a/eofun08kE7WF3zJRoc6CZYkf
	aPbnW2s6SS9fU/c2b2rMskel0kwI0kt0p+tkCJlre1ijHWDhEIAIUMUodNmSAgkmIfS8HW
	qUWalD0AN1xo1Hs+n/o93Zm3bexTaOJoGddiSIkldpVDNdPgd1qh8eV7LUo9kCpwkSElaC
	NzeShFn24Pai0P5nZYaadQUIoadmnqyj4NbkTNM52mDXA9s57Q8nz+JQVcUfIw==
Message-ID: <97bd2ab1-a8ff-4c0b-a328-952139f18fc8@bootlin.com>
Date: Thu, 19 Mar 2026 10:27:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 10/10] net: ethtool: Introduce ethtool command
 to list ports
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, =?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?Q?l?= <bjorn@kernel.org>
References: <20260309152747.702373-1-maxime.chevallier@bootlin.com>
 <20260309152747.702373-11-maxime.chevallier@bootlin.com>
 <20260312190705.0b3a3f78@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260312190705.0b3a3f78@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 13/03/2026 03:07, Jakub Kicinski wrote:
> On Mon,  9 Mar 2026 16:27:46 +0100 Maxime Chevallier wrote:
>> Expose the phy_port information to userspace, so that we can know how
>> many ports are available on a given interface, as well as their
>> capabilities. For MDI ports, we report the list of supported linkmodes
>> based on what the PHY that drives this port says.
>> For MII ports, i.e. empty SFP cages, we report the MII linkmodes that we
>> can output on this port.
> 
>> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
>> index 6e5f0f4f815a..90674aed7777 100644
>> --- a/net/ethtool/netlink.c
>> +++ b/net/ethtool/netlink.c
>> @@ -18,6 +18,8 @@ static u32 ethnl_bcast_seq;
>>  			     ETHTOOL_FLAG_OMIT_REPLY)
>>  #define ETHTOOL_FLAGS_STATS (ETHTOOL_FLAGS_BASIC | ETHTOOL_FLAG_STATS)
>>  
>> +char phy_interface_names[PHY_INTERFACE_MODE_MAX][ETH_GSTRING_LEN] __ro_after_init;
>> +
>>  const struct nla_policy ethnl_header_policy[] = {
>>  	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
>>  	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
>> @@ -421,6 +423,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
>>  	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
>>  	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
>>  	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
>> +	[ETHTOOL_MSG_PORT_GET]		= &ethnl_port_request_ops,
>>  };
>>  
>>  static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
>> @@ -1544,6 +1547,16 @@ static const struct genl_ops ethtool_genl_ops[] = {
>>  		.policy = ethnl_mse_get_policy,
>>  		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
>>  	},
>> +	{
>> +		.cmd	= ETHTOOL_MSG_PORT_GET,
>> +		.doit	= ethnl_default_doit,
>> +		.start	= ethnl_port_dump_start,
>> +		.dumpit	= ethnl_port_dumpit,
>> +		.done	= ethnl_port_dump_done,
>> +		.policy = ethnl_port_get_policy,
>> +		.maxattr = ARRAY_SIZE(ethnl_port_get_policy) - 1,
>> +	},
>> +
> 
> spurious nl
> 
>>  };
>>  
> 
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2026 Bootlin
>> + *
>> + */
> 
> so many lines for a copyright :(
> 
>> +#include "common.h"
>> +#include "bitset.h"
>> +#include "netlink.h"
> 
> alpha sort
> 
>> +#define PORT_REQINFO(__req_base) \
>> +	container_of(__req_base, struct port_req_info, base)
>> +
>> +#define PORT_REPDATA(__reply_base) \
>> +	container_of(__reply_base, struct port_reply_data, base)
>> +
>> +const struct nla_policy ethnl_port_get_policy[ETHTOOL_A_PORT_ID + 1] = {
>> +	[ETHTOOL_A_PORT_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
>> +	[ETHTOOL_A_PORT_ID] = { .type = NLA_U32},
> 
> misaligned bracket
> 
>> +};
>> +
>> +static int port_parse_request(struct ethnl_req_info *req_info,
>> +			      struct nlattr **tb,
>> +			      struct netlink_ext_ack *extack)
>> +{
>> +	struct port_req_info *request = PORT_REQINFO(req_info);
>> +
>> +	/* PORT id is required for GET requests */
>> +	if (tb[ETHTOOL_A_PORT_ID])
> 
> GENL_REQ_ATTR_CHECK ?
> I guess you'll have to move it to prepare cause we don't get info 
> here :(

Sorry for my comments coming apart on your review, I'm getting this new
iteration done in-between other tasks  :(

I can't move that check to the prepare_data() step, as we need the
request->port_id field to be populated at that stage for the DUMP
op (for each port, we set request->port_id, then we call prepare_data
and so on).

Maxime

