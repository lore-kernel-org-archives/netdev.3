Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698373C1F4B;
	Sun, 27 Sep 2026 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790500171; cv=none; b=NZAeysrfS6Un9JXnUnQIpL7i+xzhEahf1EaDWnZYAynrDnW1npZQkibaETPwYwzwan5+zLC+RwR6DdnMUu9fQ4s2wJwHdHFhpUS4VKtgi1cTuOksgtn6v2Zac+jfWramavUa4QmDbbNypq/BvxZ6EE1nWbSps902Rz+C2P9rZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790500171; c=relaxed/simple;
	bh=m/1HM/EMkEQeOjSAvIN1hN/z0S0DcPSU6m0w1hSQzn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZF8p9tmpiEd7JfVZEVrzu5CWrQ2cWScEStxYyy34e8gOrN2p+5fQXq3ycvdAkGEg6e+/TSO+pfvrrlikRTGZ/5LC+4pfN2Db2jek7RS8rLD/fhXwHaAT79GSbWWO9yqy77B+mt3VlJTUqZxmM/lvp4z+0NYP2VQhcMKPaWriFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=M9CGBOPJ; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=M9CGBOPJ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="M9CGBOPJ";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="M9CGBOPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790500167;
	bh=m/1HM/EMkEQeOjSAvIN1hN/z0S0DcPSU6m0w1hSQzn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M9CGBOPJLrEOstfNUhA1QZ2oS9ED60A1po7CsgsdZirbRvw6vU+ZJ+inCNOJ6ynqS
	 Pa1AMtlwsInXrsrPKK0e14/8aYZLr9Bunn3IzB29/GCU0kVeq8rB1nVMsUmYelaJCE
	 KRVBEk+cpoagz/FFusCeJhWN/zwb6TXYQh2hcZiSEHbSmVZPcXA+nb6NjrTT1P8hH6
	 /FKRV/vtmpXX2LkKPBxzDA4a8P1O/2qYogEJf9df/P5mJ07m18O7cjcPaomASy8cZf
	 hgLhd8faT1aB/eg7ik8oVa0NcY5dakSzzHzcEfQPj/cQtK1weW9aeH6p37h8Wca12p
	 VxGh7yIhe/0sQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A407C41307; Sun, 27 Sep 2026 09:09:27 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790500167;
	bh=m/1HM/EMkEQeOjSAvIN1hN/z0S0DcPSU6m0w1hSQzn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M9CGBOPJLrEOstfNUhA1QZ2oS9ED60A1po7CsgsdZirbRvw6vU+ZJ+inCNOJ6ynqS
	 Pa1AMtlwsInXrsrPKK0e14/8aYZLr9Bunn3IzB29/GCU0kVeq8rB1nVMsUmYelaJCE
	 KRVBEk+cpoagz/FFusCeJhWN/zwb6TXYQh2hcZiSEHbSmVZPcXA+nb6NjrTT1P8hH6
	 /FKRV/vtmpXX2LkKPBxzDA4a8P1O/2qYogEJf9df/P5mJ07m18O7cjcPaomASy8cZf
	 hgLhd8faT1aB/eg7ik8oVa0NcY5dakSzzHzcEfQPj/cQtK1weW9aeH6p37h8Wca12p
	 VxGh7yIhe/0sQ==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 02462412E0;
	Sun, 27 Sep 2026 09:09:26 +0000 (UTC)
Message-ID: <a1c3fda7-0a85-4953-a98d-489df28ce04e@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:09:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 05/15] ax88179_178a: Add netdev2data()
 convenience function
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-5-60c04c9924a2@birger-koblitz.de>
 <178968029536.22033.3161728030587874115@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968029536.22033.3161728030587874115@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 11:24 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 0 · Low: 1
> 
> - [Low] drivers/net/usb/ax88179_lib.c:131 adds the globally visible
>    helper netdev2data() which has no caller at this commit, and the…
Will fix by squashing commit.

