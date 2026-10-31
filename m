Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793447090;
	b=0Avh/TVmBvHOImTyNN0uVi1GUDWKYdVWYdVepjEKacl/BCE+n3TcwQaipc45kc8AUgJM
	 +rCVg0dDKsC7n+e7MVXEfz9aBv1FAeOvQ82SUChxKfYdQftLgm+0Ipai3DGuMsam6UxFd
	 0ln4+jzwtN0AI0VWghM6jKZ/09ur7zqeEuYtGkV8sSh+DSZ2MhQ9Kbz+dY38+WYGPmdg0
	 tEMuly2ldHxn/RIHLj1z1v6VHTul7jdNyZA7Gce2vJKIPSjOGvnzWPYUjZGdJXv1SGs50
	 jS36h8sTnc/S4NFX420AWtSwluWFXP6OC3Ey/qxMSf25nk6aLbbd8PDHM8SVgZwm/rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793447090;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CVHGbPYBXbnlGmadd7sg4ULsHDVkzLKJ1bNCGoljV8I=;
	b=WDaLaKQXkqp0m12Byi1XW4/vjTGYsHYzQnbCq/59XghBWR/X3rnz6ShhQhXQrcOkLoJW
	 9hjdSXf1vCjmp5asV7EnWfWb+2KwPjMHI/W6ERTDX3bwxkqGIyH1+s/P04vmHDa1wzNLk
	 nwxSq1E5bvlIJ48653iZG0jrEDfLbe7byy+VclLd4zoazC3c93oNqkjW5xDQQmP8M7YVD
	 xKkzRMMgcxX7Wbm4MNA9KVyJaACo2g76SUosYebtY7qtPGUDXmwpbHBTdlTJfyvlES507
	 eS1oLxqUgdnOilE9HmIyrxmOhBdarAw+ikD240/JT+kOUfthc4/JZ6pxw/gDNGspY8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xbyOkOlu;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4073606A31A;
	Sat, 31 Oct 2026 11:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4073606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xbyOkOlu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=xbyOkOluZiPxoxtnXmeMntgSXkhHxsiL+Q9xChsHip2tg8YB3dPxFZ2wxTPTxoJTKOIr3DuZlEbj1
	 V2oTC/Xby5YWJPG20AIRSOIxvHN7KaTxRws/CmaXgdSkzxHlvJCBiXm0jLwjnHZf21P4XdmkdnF3zF
	 tcIAWGxE0KESy99g=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ae5d49b899-7ba42;
	Sat, 31 Oct 2026 19:44:38 +0800 (CST)
X-RM-TRANSID:2ee76ae5d49b899-7ba42
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.33] (unknown[222.93.19.82])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76ae5d4a4b6b-82117;
	Sat, 31 Oct 2026 19:44:38 +0800 (CST)
X-RM-TRANSID:2ee76ae5d4a4b6b-82117
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, alexhenrie24@gmail.com, linux-kernel@vger.kernel.org,
 yana06070@163.com
Subject:
 Re: [PATCH net v3] ipv6: reject wrapped temporary address preferred lifetimes
Date: Sat, 31 Oct 2026 19:44:36 +0800
Message-ID: <179344707641.114606.12665582704521593779@cmss.chinamobile.com>
In-Reply-To: <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
References: <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
 <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

One question on the clamp added by f4bcbf360ac8, separate from the
wrap fixed here - I don't think this patch needs to address it. I have
only followed the source and have not run this case.

As far as I can tell the clamp's termination relies on cfg.valid_lft
and if_public_preferred_lft being finite. Consider a public address
with both lifetimes at INFINITY_LIFETIME and a large regen_advance,
with no wrap involved. For example with regen_min_advance=2,
regen_max_retry=3, dad_transmits=1, an RA Retrans Timer around
28,600,000 ms and HZ=1000, regen_advance is around 85802; raising
regen_max_retry via sysctl has the same effect.

If temp_prefered_lft is set below regen_advance, the effective
max_desync_factor goes negative, desync_factor is reset to 0, and the
clamp engages on every creation. The clamped preferred lifetime
regen_advance + age + 1 then passes all three checks, including the
new one. But the temporary address inherits the public address's
tstamp, so addrconf_verify_rtnl() finds it due for regeneration one
second after each creation: one new temporary address per second,
each living about temp_valid_lft. Creation is only refused once age
grows enough that regen_advance + age + 1 exceeds cfg.valid_lft,
which here is just temp_valid_lft, so the accumulation is bounded,
but with the numbers above it can still reach tens of thousands of
addresses.

Is this finite-lifetime assumption part of the intended behavior of
the clamp, or would it be worth tightening separately?

Thanks,
Xia


