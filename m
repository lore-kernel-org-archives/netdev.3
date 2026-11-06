Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951590;
	b=K1LSHXZjjP6v/BP7A3gDoCpvNjX9qIll6tewJSakjoMfytj4lSCb0IHpDQ6ZXnEq/95V
	 ajpQFYA9tH8R8ayPx+dD8cMZS97juqrkpQ8Xja3KqbIDri9vbmuZoJahB9vzqVXGdfCjO
	 +4tEvO/QJdCI9Fzm6gFZ+YwaxBzmmlLUCn1JGJa6cr++C1nOJ+7/+9W9qh8jqAMbWBXSQ
	 EG6yO6+hJl9ZwWMSaiKZX6eYBA/F4dJbO7Qsp+hjbAButq1NpnWWKs6vlrFVP8j/jydN3
	 qFBV2N3zfjpBDdhrsB4Ma8Nz8Z1eK68lHhX7ecuOBKutVBvDoDpA0JGVzrZl0ymC0lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951590;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=kur3oCIADPik00ww6Op7p8ctt5qcVWiVMu2HCk2DBAA=;
	b=uTwLIRxFyQ/8SdSRFAvaqLSnRoFN+wP14VldZQ8wzstUis2vfVytEPKvrTnJl+Pb1jlC
	 Fx/EMVlImU0LX0K9KrISR4K6trAvtIgkvbgBG/Be6XcAsqMYTi2fayM+Jax84N4QgSpUf
	 7DlZHzREq62sIuQDbs05v1/oNxNascPnvtA1FWb1HHr2qAT7FNpvtvpo7vK+DjTSFTCU4
	 Zq3l+zDgW+YwHQa9EQMob05Lg8kEv2+QNwfnVD9R+kTV8MRYCAmVkQflo3ZeroMYTY5MI
	 lvPz0+MDgK+pzHxGox8EqhLVMYC5Dbe5K6/cuV5EoTk7pNmoCTJoFU4bFOryWyHweHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bsNIcf7U;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F888606A326;
	Fri,  6 Nov 2026 07:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F888606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bsNIcf7U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=bsNIcf7U6SmZMfz5/dJXiO/7iwMdPzJDDmuQL292m6KtvL2Mh6QYlslXzuYUNgP6MWap97tVkbsSf
	 y9YmTXRc1QEpvNKOJe/vQjclFjsszjUNPIxqi6IK0EeDpw0ksgjU61Xd/1t5SSZSKdlT7fKISaWjS4
	 8O/bCq+iwoN3WGUQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aed8761cfd-7b6a5;
	Fri, 06 Nov 2026 15:53:05 +0800 (CST)
X-RM-TRANSID:2ee66aed8761cfd-7b6a5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.104] (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16aed875f96d-17b71;
	Fri, 06 Nov 2026 15:53:05 +0800 (CST)
X-RM-TRANSID:2ee16aed875f96d-17b71
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@kernel.org>, David S. Miller <davem@davemloft.net>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Ciprian Regus <ciprian.regus@analog.com>,
 Linkui Xiao <xiaolinkui@kylinos.cn>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-kernel@vger.kernel.org, yana06070@163.com
Subject: Re: [PATCH net-next] net: ethernet: adi: adin1110: Fix phy_device
 leak in probe_netdevs()
Date: Fri, 06 Nov 2026 15:53:04 +0800
Message-ID: <1793951584000.347526.5074428569945602767@cmss.chinamobile.com>
In-Reply-To: <179395006518.488859.7603845397469844366@kernel.org>
References: <1793949783000.333861.5224091507677300156@cmss.chinamobile.com>
 <179395006518.488859.7603845397469844366@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 11/6/26 15:27, netdev-bot+sinfo wrote:
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

Hi,

The leak was not hit at runtime. I found it by code inspection while
reviewing the MDIO attach paths, as the commit message notes. There is
no stack trace: the effect would be one struct phy_device allocated
per port on every probe and never released.

I don't have ADIN1100 or ADIN2111 hardware, so the change is
compile-tested only, with CONFIG_ADIN1110 enabled on x86_64.

Thanks,
Xia Yan


