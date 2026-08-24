Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1492264DB;
	Mon, 24 Aug 2026 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787546181; cv=none; b=LZc0BZHOnuLFimrbblsMw8vua0gPDSBfMSrNuDQtocQ0WLQKrXD+b3GKyT4wJWCann1tRog7c9c3rc6KCOP1GNe2JuhnZqIyttK2VfNoSr8pih5VpYtrZyE5rKNqWaR0Pq9yk7qy9MgeedHpS49SeAYl0rEb7sSL3GhDpHVML5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787546181; c=relaxed/simple;
	bh=RLpRnaMA4vONnXuk/0O5nOU/yMTGhlnZscTVn2yVWfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Doifw6R1nLa443Bwh4sod2D0NzYiYoU0Im4boWzgHNhmKyEdH0mEzcGAERw5/MNdA92sPpJ6Mo6DMhWFh+vvriBMbRchQkBtAEU71E59QIF4lOClH3WxVw0YoI+UYfBJ380MA/G6pTFWhPZINI1qI5tsH98hfHBmw0fAemUkGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=TbxSMW+K; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="TbxSMW+K"
Received: from SEWP216MB2801.KORP216.PROD.OUTLOOK.COM (unknown [IPV6:2603:1046:c07:1006::5])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b09d5808;
	Mon, 24 Aug 2026 12:36:11 +0800 (GMT+08:00)
From: "springbreeze@stu.pku.edu.cn" <springbreeze@stu.pku.edu.cn>
To: FUJITA Tomonori <tomo@flapping.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "miguel.ojeda.sandonis@gmail.com"
	<miguel.ojeda.sandonis@gmail.com>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "fujita.tomonori@gmail.com"
	<fujita.tomonori@gmail.com>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"boqun@kernel.org" <boqun@kernel.org>
Subject: Re: [PATCH] rust: net: phy: fix off-by-one bit positions in device
 status accessors
Thread-Topic: [PATCH] rust: net: phy: fix off-by-one bit positions in device
 status accessors
Thread-Index: AWVuLS4zlOQ0I7zv0+lHIO3dUcwGOWVmNTRhJDY2JGRvMTQuNOfEOkXf
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Mon, 24 Aug 2026 04:28:08 +0000
Message-ID:
	<SEWP216MB2801DB2C975CA1E879A92E60F9A02@SEWP216MB2801.KORP216.PROD.OUTLOOK.COM>
References:
	<AHMAhwDwKw6suFf01VEIOqo9.2.1787486213219.Hmail.2401213299@stu.pku.edu.cn>
	<f4e5000a-8468-4172-b454-ac97f9ce759e@lunn.ch>
	<000d01dd3317$3d212670$b7637350$@stu.pku.edu.cn>
 <20260824.091142.1032504488154121329.tomo@flapping.org>
In-Reply-To: <20260824.091142.1032504488154121329.tomo@flapping.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HM-Tid: 0aa0320df99b03a1kunm68989d8721691d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHRpLVkpNQ0JJT0geHU4ZQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJTUtIQUpLT01BGEtMQUpLS01BQU5ZV1kWGg8SFR0UWUFZT0
	tIVUpLSUJNS0pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=TbxSMW+Klgyn5A1dQE5SsasOAQNmEhlbttCkcGN99vwYnatoH3cp5JQ+Eucdi2vJaTq4tUhArpD8G66UVnaHRb4NRSnvte6c9W+MlnRdDWpPL+/LXGHxvTgK119cU7D7/zyFonUbo14sId//bqAqotPmMyKb7W2ZsGzrzeM/p9c=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=RLpRnaMA4vONnXuk/0O5nOU/yMTGhlnZscTVn2yVWfk=;
	h=date:mime-version:subject:message-id:from;

> Given that this patch is expected to be merged via netdev, you might=0A=
> need to send with a proper subject:=0A=
> Documentation/process/maintainer-netdev.rst=0A=
=0A=
Thanks for the pointer. Since it is a bug fix, I'll resend as [PATCH net v2=
] after the 24-hour resend window.=0A=
=0A=
Thanks,=0A=
Chunfeng=
