Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880461;
	b=5I1aAP65ZQxIl0IYivu8PWDVlGvARU2WEoF7hejygyNARVzgBCtYtZ11Bre01osf0cX3
	 XI2Wi91P4IPkqeMWndR3/12WG3vXNuj+e/64Tcc8ay2TN+8M5BeiJsiPC77BBMpbcX1vA
	 AmCThoQJ+eGWaMnXUXgHUD9RwsnRAE7h+2Ety6Kd0QdnSMOmJjpVb1GiVyTcy5p6giA++
	 60lSkcipCPm7noH3ifcrEzAMHtyxvTf4Zip+UeEW69UP2pkXaEjRtyVAHzpdI8EVAdYU+
	 1HxYLARtF2DPdGcn5ZNoAMyjkDw0ew/nxvbykASqzrGXYaEGq6u/iaRscv6vJtd5e+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880461;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=BwtN87Ly2esGg9z8mPnwIANP4TkJTx1efVKzxRH9HtI=;
	b=HdVCKT30snBewc8mA4Q21EZTKalrAcPOAh3WJMTu89f7s36lttwwXmDM9L+x+8DHpZs9
	 /CaRLRMALtma6fnckHCpiOzB1NBQcDudkdXO3YY+U+6s/Ipy8t26cluH9PiFH7cPMN4cG
	 n2ehAPqMr2oFl6nr5fwT/mrKJrMNlUzOLw9L2brBMnmURKx6SXZPP6I8PTbnAvlKu8DbS
	 B9MjeBmxhm+90JTLAQiZanETngh/u1kavDepO3mwkXxUHC28nijEHhOS3snYFWgtbsTxg
	 7sxs30fE0ucwBEaRzJyNMWghySOXlWunwPwMwi2Lqdhg+lk4RR29CdGb9+PElrT4dUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b="d/684B74";
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1F606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DC1F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=d/684B74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1793880455; bh=JrhtsvBgHqhtFO1qYgpLLk9bTPY+9LpsSli2ENh7yy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d/684B74nUv4LDO8M36yiV2QsxWXuged84JLUwj/Z5Hy9Cuv1s3b+nPDBaPBUOUJv
	 xbDB/ztcYPefZ2JCgGrue0Eg/0wDCekHn3gr23fAq0FRgx/z6NZXD5jlrLsqfsh6D4
	 ELi7+4bwKx/s2FxASqNElrhMEPLD6pXCGpkgOJW1SyIUr4/uiOywzDa4nv9jbx3CQA
	 KBwmi86qvhmqpYOtl6m4pmv9+TG13K+RfgCmYxfWxLVwKUr+ldrarCiQuL87qCnXRW
	 fA1Tpg9idlUo9rsDOJuujRYpMUbIlrn2s/w4aX8+Xh8NyGhmYZ4SFZfKTg7uRHGhYh
	 72TJcmzLK6dzQ==
Received: from [0.0.0.0] (unknown [213.228.1.188])
	by rcs.proxad.net (Postfix) with ESMTPSA id C5D0844C0F36;
	Thu,  5 Nov 2026 13:07:34 +0100 (CET)
Message-ID: <f2905e29-27c9-4668-a5e3-103cbeb63caa@corp.free.fr>
Date: Thu, 5 Nov 2026 13:07:34 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net/sched: act_api: pass the filter
 offload flags to action init
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
References: <20261104214607.556269-1-acassen@corp.free.fr>
 <20261104214607.556269-3-acassen@corp.free.fr>
 <CAM0EoMk8-BT92QtAgKQYuKu7_DaCymAV53FU-K2cLhSUcPCZTA@mail.gmail.com>
Content-Language: en-US
From: Alexandre Cassen <acassen@corp.free.fr>
In-Reply-To: <CAM0EoMk8-BT92QtAgKQYuKu7_DaCymAV53FU-K2cLhSUcPCZTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/26 12:26, Jamal Hadi Salim wrote:
> BTW - you will have to resend this because net-next is closed (If i am
> not mistaken it opens monday).

ack, I noted 9 too, but double-check yesterday showed open... so I 
probably mistaken... will resend next week.
> Re-looking if you are going to make an update: act_bpf, act_ife and
> act_skbmod still hardcode the per-cpu stats; their fast paths use raw
> per-cpu derefs so they need the helper conversion first. Sorry
> Alexandre ;->
ack will do.

g'd day,
Alexandre
