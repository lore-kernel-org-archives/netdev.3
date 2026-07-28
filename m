Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED382FE074;
	Tue, 28 Jul 2026 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785215963; cv=none; b=qEYatlzUHgv+6MmblUydoHDXXeI1lUiVEFWtYg2INVkTLbFeNaVMbuT82cJYJ4M4qOS456WiKBVWDJBS9/yXWDfcun3bNrxmXgSzx+xlptVfuExoMtd+fB1YrmiXTnbkt5CrTadhh0TBQXMBTIkdSoe93xdut9FYx5aeeQ7cyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785215963; c=relaxed/simple;
	bh=PP4XiIjr/uvl/N/ND3WIAL8x3f77zKAU45r+8pcdvpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=dZy0xoggm+frIj9eKAOGhAyXoNKOnzBIe7vr5JRhLYnhonLtR8boLP60HTEo1IQmroHDaeB+jEqI+XklfjSqx/OR0iRlJR9HflXdQZQ/NoJJX5U1/2tTWwfPGGueHnVDqoy3nMfFgQgLLiBfCQ2n8Zfn3Kn9UrvjBp3RpL0++24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Orl4zG2H; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Orl4zG2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=PP4XiIjr/uvl/N/ND3WIAL8x3f77zKAU45r+8pcdvpo=; b=O
	rl4zG2HlJjFYf7Szcw1FB8rsYTqMiJnc28mf7z/yuO80uovhTxF4dc3c7ku0YHcF
	Sb9xyeZddmGXBpZiXeq9znGC8xMzUWAEH52cysmZMPLQpI2Yk/+J97w+lSO0iAmt
	NzXmj2E8tNDIqvfA7pQOo3jpr3a4fsKwVaE1d24sjU=
Received: from 19888972804$163.com ( [111.19.71.39] ) by
 ajax-webmail-wmsvr-40-109 (Coremail) ; Tue, 28 Jul 2026 13:18:16 +0800
 (CST)
Date: Tue, 28 Jul 2026 13:18:16 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Jiri Pirko" <jiri@resnulli.us>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] team: reject ARPHRD_CAN devices in team_port_add
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260727182447.114f9fc5@kernel.org>
References: <20260723040032.2094322-1-yaojiale02@163.com>
 <20260727182447.114f9fc5@kernel.org>
X-NTES-SC: AL_Qu2TB/6aukAi4CmdbOkdmkcah+Y8XMu2vfQl24RWc+IEpS7A6wI7YnFTJX3c+fCDBymPvx+7cSZoz8heeIdZj6qZ5cSTM2NHoQEpri7QXQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6be0ce2c.3d2b.19fa728cd87.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bSgvCgCnX1KZO2hqiscmAA--.3924W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRmp42poO5lImQAA3v
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkKClN1cmUsIEkgd2lsbCBjaGVjaywgYW5kIHNlbmQgdjIgcGF0Y2ggaWYgdGhlcmUgYXJlIGFu
eSBvdGhlcnMuCgpKaWFsZSBZYW8KCkF0IDIwMjYtMDctMjggMDk6MjQ6NDcsICJKYWt1YiBLaWNp
bnNraSIgPGt1YmFAa2VybmVsLm9yZz4gd3JvdGU6Cj5PbiBUaHUsIDIzIEp1bCAyMDI2IDEyOjAw
OjMyICswODAwIEppYWxlIFlhbyB3cm90ZToKPj4gRW5zbGF2aW5nIGEgQ0FOIGRldmljZSAoZS5n
LiB2eGNhbikgdG8gYSB0ZWFtIG1hc3RlciB0cmlnZ2VycyBhCj4+IE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZSBpbiBjYW5fcnhfdW5yZWdpc3RlcigpIGluc2lkZQo+PiBuZXQvY2FuL2FmX2Nhbi5j
Lgo+Cj5HZW1pbmkgcmV2aWV3IHNheXMgdGhhdCBzaW1pbGFyIGlzc3VlIGlzIHBvc3NpYmxlIHdp
dGgKPkFSUEhSRF9JRUVFODAyMTU0IGRldmljZXMsIGNvdWxkIHlvdSBkb3VibGUgY2hlY2sgdGhh
dCwKPnNlZSBpZiB0aGVyZSBhcmUgYW55IG90aGVycywgYW5kIGFsbCB0aGVzZSBpbiBhIHNpbmds
ZQo+cGF0Y2g/Cj4tLSAKPnB3LWJvdDogY3IK
