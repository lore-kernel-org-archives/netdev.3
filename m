Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB43397935;
	Sun,  2 Aug 2026 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785687770; cv=none; b=p0YBX/aV6BGVZeUtVtfHrHCHImA4V1VwqCeS/ZDRzRQpUY51J+BRpKG3P/+agYymj1EAjDUIWoSqDJo1PqQC791Qu3p3Di9GYSP/ZjL63spQncogMjHGfvV1o5dz9kVbiCwu01+hv3PLa1r1jyDzEZlQbhbO6ngKlvCg4Lfxo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785687770; c=relaxed/simple;
	bh=1wgQsSFh55lcxiQhFJ4QsAheAzaU12NsrqQttBoctbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ito66mYl/9jDSGXjM7LXx9vI+MWOjCkwqCW4Jbtcx60/6baFUXBk5FYhNkBxb4JZBbwKr0sg0BigtxO6CMdiiwki8AkDoSBJS4BaMpoHS/GFVn5MaUZnMs512QdAmFworzJFl+RqLfYNc3ARXfV9H1yZaI06JwNDGYlYVG7oUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=u0jkYWXG; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=T+XfLZK1; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="u0jkYWXG";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="T+XfLZK1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785687765;
	bh=1wgQsSFh55lcxiQhFJ4QsAheAzaU12NsrqQttBoctbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u0jkYWXGMMG5EykqN+PQM3r3FOFcov9TgvImelNMT7FG64pnMTd+dxvvdRx9zJsjz
	 mPOtxFft0q0paAbMc7GJA95dQP0x1ywbjDh3R1U1zT8xm281SqxArzdc7JmsJLq/QQ
	 7ZhP7sbOasGwZrNooXRoEcVvXRABjoLWh0MB9Eh1E022OKgcly0v8o2OcUBMXZln1D
	 uV++QvewV5MaF5YQ08O7N5xm/WXM6kAbtQOCC3uFUVLjcGzJgTdi5AaP8jFB1KGfpa
	 7HLsUdkEASTh1u3N8QVIV1cKkYSzYa/ezk/cjO86A/+CsKtIQPoPj1VL/0ImtGLgHE
	 GH2JCKSRoIePQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 279774964F; Sun,  2 Aug 2026 16:22:45 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785687763;
	bh=1wgQsSFh55lcxiQhFJ4QsAheAzaU12NsrqQttBoctbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T+XfLZK1yAwVx5JP7ODRiaLvRxhEFRD+X7eMRgH7zO+W3DQI8gwlwtOH35QSHlXFk
	 56TRe4BvGuGdX4tp3bwMkfX4vvmgJPL+jABtqjYzKWrmQfBtbgBNrG5T6mVznJ/bY1
	 A9M+W6BNiJCwS8dP3ssoc6z3HG4WXZqEjK6C6wnWOJnpWVCSMgIZXJoAaglOKsepvV
	 NYO6eLLdkMU3XEQhya6nqTjsRvBwLEfHWNolERVPPgDoFqbfr+LxU93rC2b3GglstT
	 Eo7TJgo1cEE43gtkXvOeU91I+u3WUqYjhSTL+9huBDNqBlBe1yil6h6A9WFGeEb8mS
	 AI0DAn0dPjLew==
Received: from [192.168.1.146] (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8E4FB4949C;
	Sun,  2 Aug 2026 16:22:42 +0000 (UTC)
Message-ID: <b1d67636-9d11-4255-84d4-aea0b627847d@birger-koblitz.de>
Date: Sun, 2 Aug 2026 18:22:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 06/12] ax88179_178a: Add VLAN offload support
 for AX88179A
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-6-2cf1f71b1dd2@birger-koblitz.de>
 <3e4c8938-3969-46ff-9d95-e8c4a45591ba@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <3e4c8938-3969-46ff-9d95-e8c4a45591ba@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2026 17:25, Andrew Lunn wrote:
>> +static int ax88179a_set_features(struct net_device *net, netdev_features_t features)
>> +{
>> +	u8 tmp;
>> +	int ret;
>> +	struct usbnet *dev = netdev_priv(net);
>> +	netdev_features_t changed = net->features ^ features;
> 
> This however is new code, so should be correct.
Fixed in v5.
