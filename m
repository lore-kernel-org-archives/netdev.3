Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1036B04E;
	Sat, 22 Aug 2026 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430400; cv=none; b=dSosTiTzTb3iWutsdUR8AHIOBTh4QenC2joKcbUcZ4zr8zg40OzkN/Ztd3vjW/ZZcQwqVzSyizg/fLqijJX2dM92N3++JiqcZvdzqwFH0zuPmw+4b6uYxu1sdFwsEDau5WucKJhHTrGF19ZXXkB1s2AdHgnKKMj1ejfDixBZZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430400; c=relaxed/simple;
	bh=eMgxkP4PcukHPUuxpNXtwfbyIs6zpD5wvBEVpl5cUAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TZc+6UFABAKB1UTgF9bqROJR63VRPdfcl7MxqSNWpKWdNzDnkfjhpFRh6/v/CEoZ2Mv/d26fsc6iAig1E6ciWlUwpmBxkBpAZlR+JPZNCc/hqrBvN3K9Rche+F8iSAy9puowLW1ocEBTcyGHot8DC+G77Ie+dJo4hyDyl4V4050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.19.215) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sat, 22 Aug
 2026 23:26:31 +0300
Message-ID: <46bc8a60-8979-4b0c-ba43-f99256561a48@auroraos.dev>
Date: Sat, 22 Aug 2026 23:26:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 8/22/26 11:21 PM, Sergey Shtylyov wrote:

> In generic_ocp_{read,write}(), the *while* loops look very strange:
> the last iteration is executed differently to the prior ones, doing
> some useless assignments before *break*. Move the code for the last
> iteration out of the loop bodies, dropping the pointless statements
> as well...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace
> static analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
[...]

   And of course I forgot [net-next] in the subject... :-)

MBR, Sergey

