Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172331714AA
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779236161; cv=none; b=uhBHAN0O+Gmav3TDIMzoe4hNNu6cq5ff/7mEZcJp18ZPHqRLVgZCa1LPW6zoBhDfUkc2YOPZFAk8Xv4zb7ita7OfHxEWJJJ+/vdwN4zgYGk9qf+WOk2A538JcFQJ4Z3k79eQZiPDD9trCke6Qk35cAPOycfiKvEIcCBjTzRlZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779236161; c=relaxed/simple;
	bh=G2jtOc3rWArt7QAbTLompoHipK33HOCr4LzrwmdC+GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnUAs6mzRLEHzn+eBygNtqFW74TXmzV7PX3v/TnIp8/WaXMGKqDJKHNnmLZ72XkiL5fN2IKijKwd41K1WUwSB8OywK4TF9qXa9Gk1iNkJey3ImxUFG1rdEhdlVZF+9EokYplMNADoMO1QkYYBD6/dFwnoVdoYU2BJlrlTM7JVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq423K3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq423K3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7455C1F000E9;
	Wed, 20 May 2026 00:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779236159;
	bh=lzJRdTwVaONPACnFj5mRMdfL3CugN5DL1Ubxl0Mpu0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Qq423K3qCdnZ/bFEeMy6t9M/xAKBGmVzTsmsmImG2HS44Ifk0z8iPgLf8I2+/SmoG
	 ZZzv0zj9roc3df+Kp4HzIWHTY7Sf6svcmSDBUUveA18l8Jcok0WGDiLfpVM1iaLH/w
	 TyP0jZFaCuOgvlqPK9CkijmNIzYjqT7d0gysNDftOj0t0FapU8XtZOUyTVE3WTHjIC
	 ejRQOL0JXINT/9XmZkOD/MQdwhN7E07x0ouqcNhA5bnie54hQ9qCXjbgdL7fU/tlq5
	 fQvNRngmWlXqIiKpjhoeOzl8nkkZXh5aCma2f4XAjRnhtzcxqhKa0LXAPqtzonlFgZ
	 N0VPd/1kWPqlQ==
Message-ID: <b5d12c16-ef45-4d55-821a-6366b9f7510d@kernel.org>
Date: Tue, 19 May 2026 18:15:58 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using VRF to limit 'ip monitor' and 'iw event' messages
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>
Cc: John-Paul Powers <john-paul.powers@candelatech.com>,
 netdev <netdev@vger.kernel.org>
References: <e89dd0e7-3eaf-6385-7cfa-5f0079fabc96@candelatech.com>
 <ccbe47f5-5895-4db4-a472-1288a55a2b50@kernel.org>
 <5e83f1cc-a313-434d-b703-9f020874c03c@candelatech.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <5e83f1cc-a313-434d-b703-9f020874c03c@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/26 8:04 AM, Ben Greear wrote:
> 
> At least many ip events are related to a network interface, so we could
> add meta data about that to the netlink msg path and then filter
> before it gets sent to the listener netlink sockets...

As I recall this problem has been discussed a few times.

There can be many netlink listeners - e.g., ip monitor, frr, ...

The lower level code (ie., the one generating the notification) has no
idea how many sockets will receive the message and which ones will want
some filter to be applied to the message before attaching to the socket.

The higher level code (netlink sockets) has no idea of the content of
the message, so the ability to run a generic filter that is appropriate
for netlink level is really difficult.

> 
> Given a network device, is there an efficient way to get the vrf-id
> to which it belongs?
> 

yes, that is true for ip route, link, neigh, addr, tc, ... not so much
for other netlink users.
