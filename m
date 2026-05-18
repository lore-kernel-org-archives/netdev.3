Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C437CD4F
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141125; cv=none; b=YPWp6KJH0q7thzESu3YkLvBnbFHCer5UgTyzCp7YXOLYecjf8WbyWXAb8MTLBUBACNQpwvahXy731tHQxQUNu2nyr4krCAztAMhxCaCqU1Cu3O3rQBZ8QfTaRoNtK6RM29fGqJLZf2BeEqJWUQe63EagEdOLN/o3EYm5qLy7GQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141125; c=relaxed/simple;
	bh=gY6/Mi2Ph0U2oA9EYrEwYl85g+5AAoZxZfF+0wOynf0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eGSUQ7XshER4Ir4NWdxCYx469fA/8j3uR+OdFyAahGdU9vXeF+jdf4qPgnJ+Ggg3aIISybnjhrVlQ3egZpy5ntOiggcnZpjERtnYDBJtmHg1Tp1nFBZsv3io8ZcIiolU591Zmw+Tt3Tzr2K9z8i/u5hY7NU6y9NeD6VertMsy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=f/5ydR6c; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="f/5ydR6c"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 562602C5AD8
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:52:03 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8D0DE70006C;
	Mon, 18 May 2026 21:51:56 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 50CE313C2B0;
	Mon, 18 May 2026 14:51:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 50CE313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1779141114;
	bh=gY6/Mi2Ph0U2oA9EYrEwYl85g+5AAoZxZfF+0wOynf0=;
	h=Date:To:Cc:From:Subject:From;
	b=f/5ydR6cH3VvOmQXk0ME2YSf4UbO9odhik1yP82DsG6Ix4LH3OMNB4oTurQXAD1kI
	 HWIOWSZQH0HYcu2CZ8Khwz/0pc9mj1LE9UrrVrx2cxeNaRdZvdxj6x5GnflYYz7C4V
	 XK4Z2Znfeshx6kHxHL/nz6nqvaN/lic2ZvHSc/zw=
Message-ID: <e89dd0e7-3eaf-6385-7cfa-5f0079fabc96@candelatech.com>
Date: Mon, 18 May 2026 14:51:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>
Cc: John-Paul Powers <john-paul.powers@candelatech.com>,
 netdev <netdev@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: Using VRF to limit 'ip monitor' and 'iw event' messages
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1779141117-2ktDxU_chO1D
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1779141117;2ktDxU_chO1D;<greearb@candelatech.com>;13ea00862af1a4a136f3e80d149399ed
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello David,

We are interested in filtering out iw and ip netlink events for processes bound
to VRFs.

For instance, Chromium starts spewing errors when we try to run it on a system with many
network interfaces, we guess because it is being confused by all of the other network devices
going up and down.

I think the crux of the problem is to know if a netlink listener socket is bound
to a VRF or not, and also to know if the generator of the message is bound to
a particular VRF.

Do you have any suggestions for how we might go about this?  We'll be happy to post
the resulting patches for consideration to be included upstream.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

