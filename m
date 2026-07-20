Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D001B86C7
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784530851; cv=none; b=FqZgq1N4hBhwBmYAApWcVCvUHX3MjDTGt6YngP/bwL0R46dki0H8GSQ1tEFglUb5+ErIkF4gLtciR6n/coPzbLlzATK4ebkM3/FH5hDuVCVaAxT+rMSQGgzZAzw6yRmjjTbsted83qf2F5F1EaakTIIcvJRifFPMkewFEsX96E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784530851; c=relaxed/simple;
	bh=guwkN6EWhL7ALW6Dt7IN64WVDHCCAbjkDEdW9j9dQ/c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SUaKEjbeqcOWysNBzNWa8K1n32UaJj639KTJ60IrS+xUsZMV44ApKdXfwFSyAZzpg/MkxlBQ46wE56S6Cups+CgQxNx9BNvWblgZLsdVwO3hc+IShSz3GBuLVM8XLbb5PCLXUkj29VJ0d3cS17O6iLBwkD8J1HdHo/dd+7Y7a2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz15t1784530798t9ba8ffdc
X-QQ-Originating-IP: ULOsrv2DhxWOJtzqronFzrIKp9snAcUuN0+EaYOcoxE=
Received: from smtpclient.apple ( [122.235.194.201])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Jul 2026 14:59:56 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8471665954404356850
EX-QQ-RecipientCnt: 6
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v7 0/2] net: libwx: improve VF ethtool support
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260710015925.34769-1-mengyuanlou@net-swift.com>
Date: Mon, 20 Jul 2026 14:59:46 +0800
Cc: jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 horms@kernel.org,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <75E1DE3E-66A0-41A5-8543-8C1B630DEF75@net-swift.com>
References: <20260710015925.34769-1-mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MkCHKSMS5sm67NDeohRTZCKlxvA18ygv+H5NWmpCbh6W3PTd+M2UhbWZ
	y1Z7RDkVRpZQGZUROgxNaoVfBQp2T3mmoT3xk/EJb53bHijh1ZU4Kmqpb2EFzPlqy5uspnP
	Ka6oF1dAZRIy7nkD2PwycrNTTW8RGWd2d6I4WdjChx97vrM2xq/nzhk/Qo773Z8D33GiU+a
	lrxvbrNymCMd71alHyt+D/kubzrDTnbm2lvJq0gqla8lJdeFH++AouhVLTuxNANopB+22qC
	BPJLPR3w33jd0dGCVVMjgtseMSiiU2sf+Ic71GzzbvY3KqvAkxScMpyYuxv8Ha7PnDP7xmM
	qZpAnhXMnWxeMJFY86By6yd/qye3z03AcY5jc3FaVXLVfOh1zYmlOTAAvBVo9u+iwJikss3
	S81k8bv1cB+kkTC7E84nxn/y+mEKMjDC6juDEQBJlqD3O+cl4PhfRiQj7dcIPajZgpmz31e
	GYo0e98MvZpqnC2BKbwEbNZeimNBtyt8j0uPhyViAuhw4fivoY0huk+0xxvlhsslIKuYU0Z
	VOqoTbluA2LR3SYSsBMbJcTlyqWDPVprvInA4vwrTr0a5WqYwtMdl1V6wlX4wR5lIeI8eNW
	atW4HI062dta3XCAvHWfdx/lOgG/lJ5iZ/RITHIWlXWwBspexhFJTouRIVOVqb9Bml8Av9e
	l/5gwpSk8dUW0BlJa9r2UAeGsbreFkRlum9DgRbz0tT+gO4GlVPjhBx2akZ6W5BQWzuO7wY
	6OmrGBLaZkJuHzqMqLXfTS7ftm+WyBjvyrSXrOxIDy8lcWEzMK0w/6ufDpzQsMq5DU5SgOI
	r5e41faLtLoGauw102mwcg4fzgcOhLn92VWGwXz30jEl9sNY7mn1j/DWAw0JGTco6Xjeu0Z
	Nr9Ee6NdEd6EvYq07nTqfEO9HwO0t466vwKkYgqu1AL0CeCwZmaQUdT0dQ+oASDdeYDTd0B
	EHro0ROhNzl3uwIS5z6RthwbB8U95W9DIlWSIfkqws3XyYNZw5xqwslIVcrcF/KKO6UZkVE
	i/ufwA9yN8kF2dTE5uHbekaX/nWWWfrPOcbhAULf741oj9U71R0IlcGz5jA7h8ekN5kYhr5
	c+acHYgi6bUnvuTZCnJBEMqLVKHU7dG/g==
X-QQ-XMRINFO: MSVp+SPm3vtS7oSxg12VlJBJ0sZvVzFNuw==
X-QQ-RECHKSPAM: 0

Hi,

Gentle ping.

Any comments on this series would be appreciated.

Thanks.

> 2026=E5=B9=B47=E6=9C=8810=E6=97=A5 09:59=EF=BC=8CMengyuan Lou =
<mengyuanlou@net-swift.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> This series improves ethtool support for Wangxun VF drivers
> (ngbevf and txgbevf) in libwx.
>=20
> This series extends VF support by enabling:
> ring parameter configuration via ethtool -G
> interrupt coalescing configuration via ethtool -C
>=20
> Patch 1 adds support for set_ringparam in wx_ethtool_ops_vf,
> allowing VF users to adjust TX/RX descriptor ring sizes.
> Patch 2 enables set_coalesce support for VF devices and updates
> EITR programming to use the VF-specific register access helper.
>=20
> Changelog:
> v7:
> - Remove patch3 and netdev_stat_ops support is deferred to a follow-up =
patch.
> v6: =
https://lore.kernel.org/all/20260701100145.23738-1-mengyuanlou@net-swift.c=
om/
> - Patch 1:
>  Clarify comments describing wx_set_ring() failure semantics.
> - Patch 2:
>  Expand commit message to explain VF ITR encoding changes.
> - Patch 3:
>  Protect ring accesses in wx_update_stats().
> v5: =
https://lore.kernel.org/all/20260615104849.60444-1-mengyuanlou@net-swift.c=
om
> - Patch 3:
>  Convert WX_NUM_{RX,TX}_QUEUES macros to take explicit netdev =
parameter
>  as suggested by Simon Horman.
> v4: =
https://lore.kernel.org/all/20260608103946.25786-1-mengyuanlou@net-swift.c=
om
>  sashiko: =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260529075147.88398-1=
-mengyuanlou%40net-swift.com
> - Patch 2:
>  PF and VF share the same ITR value range. Update wx_write_eitr_vf() =
to apply
>  identical range clamping as the PF path, ensuring consistent coalesce =
behavior
>  across both device types.
> - Patch 3:
>  Remove wx_update_stats in wxvf_down.
>  Replace both WX_GLOBAL_STATS_LEN and WX_STATS_LEN macros with =
type-safe
>  static helpers wx_global_stats_len() and wx_stats_len().
> v3: =
https://lore.kernel.org/all/20260529075147.88398-1-mengyuanlou@net-swift.c=
om
> - Patch 3:
>  Drop netdev_stat_ops support from this patch.
> v2: =
https://lore.kernel.org/all/20260525101115.13151-1-mengyuanlou@net-swift.c=
om
> - Patch 3:
>  Remove some stats which can be replaced by standard stats defined in
>  include/net/netdev_queues.h.
> - Patch 1:
>  Adding a return value to wx_set_ring to make wx_set_ringparam_vf can
>  be passed back to userspace.
>  Remove freeing and requesting of IRQs. Ring resize only updates =
descriptor
>  resources and does not change MSI-X vector or interrupt =
configuration,
>  so IRQs do not need to be reallocated.
> v1: =
https://lore.kernel.org/all/20260514103405.42175-1-mengyuanlou@net-swift.c=
om
>=20
> Mengyuan Lou (2):
>  net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
>  net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
>=20
> .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 68 ++++++++++++++++++-
> drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 +--
> drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  4 +-
> drivers/net/ethernet/wangxun/libwx/wx_vf.h    |  1 -
> .../net/ethernet/wangxun/libwx/wx_vf_common.c |  4 +-
> .../net/ethernet/wangxun/libwx/wx_vf_common.h |  2 +
> .../net/ethernet/wangxun/libwx/wx_vf_lib.c    | 13 +++-
> 7 files changed, 90 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.30.1
>=20

