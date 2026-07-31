Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476713B6BE3
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491044; cv=none; b=MGoPl9zu+a10xVjMiX+rNEyvQDiZz6v8y6VwaIIDwWngU8chSfgsp2Ri0yj7runv9pYSNGxmXmCCsAAzKJJkqYNeVxI5E68JJTYFRXiq5E4eUVBIcGTIXsN/3lbBPJJn21dn3S8qEdyC9NXhEcF5LFVsIGQcl65rPIAITqLicVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491044; c=relaxed/simple;
	bh=r10tjGTdw1YKHxsPPDh/Dbv9l7XxcRvrmzpMPX5DBGU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Z4CGmNfWY/22+oeLEtHv1LKmTs+BrJ3VFoCoBUFW2vdji/yu0UQa3huF2epFHIZZAi8E8mcY2cqD+xf+yJE1abcolxZg37mYXIWiZdkjst25agKph23LkZp5JPDvlO1HCAVyNfl6NTCs3Tn9S4K5g5+zQzAzLV4PyerZFXJfMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz19t1785490906t37e1ced6
X-QQ-Originating-IP: OR+z2q1hi5WwzgOfHyDBhJwBNfJR5t59x1IE4bnM/bI=
Received: from smtpclient.apple ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 17:41:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 676955962437638295
EX-QQ-RecipientCnt: 10
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next 5/5] net: wangxun: add ndo_get_stats64 support
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <amxh3Ef6FnHNnZQ5@gmail.com>
Date: Fri, 31 Jul 2026 17:41:33 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F8CB138-3F3C-42A2-986E-36E33B0B4F3A@net-swift.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
 <20260731074958.19333-6-mengyuanlou@net-swift.com>
 <amxh3Ef6FnHNnZQ5@gmail.com>
To: Breno Leitao <leitao@debian.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MowohnWo6wX7tcfiHKTF1Wdbx7nf2IXNltAMnp+aXylwHJjKSOuF+Hlf
	9umf92yjuvvC0pMrmWbvjB5Ziwqb2dVtQGLmt1ZM1YlMzs1Wf7zLDS7bnNauLhaMthbvdsY
	gWQMaZdtmiQ+FchaYsHM8mevt8g7Ldc7Oadrbbb3sXZes32b9EEVSqzKzUUcqwyza+kFH79
	kV2VyRYttnn6Rfyg78CRXZ7dmUTqFiYgcXG9/X6sGCKcKkXy5+VUjpdDRA6ml6tXaVod06k
	ur/hXzpnn+PyWZbT6vlMXpiWjQHlW38967RZ5wp/STQVCHWQ3Dg/szRPl8d+/3Fcnx1a8aA
	vSi81LL5MLkGs2dJ2EtIl4SveavJ9J7g4tjUD0i5p+Z55626O1+vAhhdb0/ll5OUB+65eO/
	jTxTLrrcvGS88ZeEiJAIA00cAtGxJyostIwhyp0EsHlnsA+UqUfrKYXcokv8+/R4pPQTBL6
	h9Z9aZ50kZee9mAAK9lwdMnc2UpMB0hZCLVMBLRaAOWAwuczjXbR2J5Bf+mImkF6PnF8WPB
	SqC+f3oPp1qzScXUy1FzVvFodmedsfqpeJ/KnZ1UeiiOWMiWvV+fNGc3/TcPLD1Bx3vMLdl
	4jCbSWopOYLPuIXi8weR3LCQz8ldHATfsgVIxRjo1KuLJRnvCBn2lMZ4qAO+pFZpmm+RsXt
	YNiLDXjJ4rAB9OmSSnnZvUUno4vSZyxl+6m4SXSRFYaoXmgh0aoXt7WMU2OflDb2h3FHDEr
	LNu2DusXyysKhn2tV9aqekCbG346toEqLoDnMmux+iQginlwq5XTLn/4FcZA/0JsdI/bcO3
	R7CJKvnrMSFyMMT9jHy6ZTludB67PfDKEkBAMvV7iD4Hyy08meHVaOrTff5YljgzpoEwH15
	5OURFbE97s0KGqQS5ZMKBtwsZXFwssAzxEb2r2BokG55A+vpdXyegqIXMT2RVODiKl7yvX3
	O28tAHc7TSZskDivYWFEDWH3I50z1iw1lGzMtZrAx4AoT+O0uN9ZyXZ9grUNhIg40Ar8hFS
	K27tjCLtjtx9rInffOQT+jjuW0UPRnvFlQYv+KIrIOiWONiI8IzrWKrXej6xAJmkV9qHLCn
	omWehhBX63c
X-QQ-XMRINFO: OWPUhxQsoeAVghoIfkVcC27dEbRW3cRGQw==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B47=E6=9C=8831=E6=97=A5 16:52=EF=BC=8CBreno Leitao =
<leitao@debian.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 31, 2026 at 03:49:58PM +0800, Mengyuan Lou wrote:
>> Expose network statistics for Wangxun VF drivers by registering the
>>  callback.
>>=20
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>> drivers/net/ethernet/wangxun/libwx/wx_lib.c         | 2 ++
>> drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c   | 1 +
>> drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c | 1 +
>> 3 files changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c =
b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>> index ae20733c703d..a4ca01c18c6a 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>> @@ -3092,6 +3092,8 @@ void wx_get_stats64(struct net_device *netdev,
>> }
>>=20
>> rcu_read_unlock();
>> + if (wx->pdev->is_virtfn)
>> + return;
>=20
> Why you don't want to populate the other entries?

The hardware does not provide the err counts on the vf.
>=20

