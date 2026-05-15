Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BDA3D1CB4;
	Fri, 15 May 2026 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819882; cv=none; b=idW89sgyZ9ny64b1oZDm3bgxBv7BUyAFk8X8unWYtGg/gWOQ57ZlGMwxkP2VVYfRyL3vd03PlcyWuvdiGc5ZimS3nnfO63h117hu7Pv8Tbis/+gKtxDj9THj5so1GweXAI7lqM/oeAadpNHtpnnzU55NkHx7tuwzKiRAAvEGiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819882; c=relaxed/simple;
	bh=D3ywJOOdtSz+6gpEUbKTjvqIUtsPJPyem0eB1g5Mo2I=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=mGvAO+ZDkBf1oVeG6LKgUkTt7vEd2so9lXOVS4ridgoQa9Wh8u+27R4/ForHK4uGaMy43SCidVOVHlUIHgbRkJbXjh0OKnfKqqyoirbYoSup4IGcbCg+1DrLM/gclSAKNhHLyGf1OiixHtx4OicQHrBNbA+YNMdnrsVz9RLg2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gGvZQ2w5Dz5BNS0;
	Fri, 15 May 2026 12:37:50 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 64F4bjtb084514;
	Fri, 15 May 2026 12:37:45 +0800 (+08)
	(envelope-from qiu.yutan@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 15 May 2026 12:37:47 +0800 (CST)
X-Zmail-TransId: 2afb6a06a31b4ee-c5384
X-Mailer: Zmail v1.0
Message-ID: <20260515123747432jLXDLIyJm2pu_tVAMf1am@zte.com.cn>
Date: Fri, 15 May 2026 12:37:47 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <qiu.yutan@zte.com.cn>
To: <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <kuba@kernel.org>
Cc: <dsahern@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.chuan1@zte.com.cn>,
        <huang.jian@zte.com.cn>, <zhou.shizhen@zte.com.cn>,
        <zhang.dongyu1@zte.com.cn>, <ye.guojin@zte.com.cn>,
        <yang.wei20@zte.com.cn>, <zhang.lin16@zte.com.cn>,
        <li.hao40@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dF0gbmV0OiBuZWlnaDogUmVuYW1lIE5FSUdIX1ZBUl9JTlRFUlZBTF9QUk9CRV9USU1FX01TIHRvIE5FSUdIX1ZBUl9JTlRFUlZBTF9QUk9CRV9USU1F?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 64F4bjtb084514
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: qiu.yutan@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 15 May 2026 12:37:50 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A06A31E.000/4gGvZQ2w5Dz5BNS0

On 5/15/26 10:55 AM, Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> From: Qiu Yutan <qiu.yutan@zte.com.cn>
>>
>> During the initialization of arp_tbl, the enumeration constant name
>> NEIGH_VAR_INTERVAL_PROBE_TIME_MS in the statement
>> arp_tbl.parms.data[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5*HZ does not
>> align with its actual meaning (jiffies).
>I think the macro name NEIGH_VAR_INTERVAL_PROBE_TIME is just meant to 
>correspond
>
>to the configuration item neigh/default/interval_probe_time_ms.

Thank you for your feedback.

The unit of interval_probe_time_ms is milliseconds, 
which is user-friendly. Internally in the kernel, it is actually converted 
to jiffies. Using NEIGH_VAR_INTERVAL_PROBE_TIME to match jiffies makes the 
code more readable and developer-friendly.

>>
>> Using NEIGH_VAR_INTERVAL_PROBE_TIME is a better naming choice.
>>
>> Fixes: bf48c3fae6d7 ("Merge branch 'net-neigh-introduce-interval_probe_time-for-periodic-probe'")
>
>Do not carry Fixes tag since it's not a fix. On the other hand, it is a 
>merge commit not a regular commit...

I will remove the tag in PATCH v2.
