Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793414709;
	b=C77CVIQqT4zTKLoqTkfpAdZxseqXWiDktCINqc3KgCtOzf+hY0pfVva4cqDnahjTkCeJ
	 fBOR/7WJzXhs9cZ6WlQR6hhRLCvwYuyivNmOLl84Syr7E7aR4Ej5+ubK3JF7TVGzsryZ/
	 Q9k1AKDexUkGsFO/DEcHPIppIra8uZtyaMv9uIo3dUXtIAI8bVDVnOvvF3gtjOKQ4G/Mq
	 VjadHAw35RkuRoVOWqWIDQkxt4iHWYfs38o5NZLYhaNDfY14k3C16q1BaerL95JCfqyt1
	 VlMBKFSZDew11hxx5SRoqmM/lb1Pt1ZQ6kgScwDXtTkilrOdVrTofdo974lPeN3rIYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793414709;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b0mpH8bizZvUDVtvHvklNVmKmiNIRt2f1NPJNIZU6Ao=;
	b=t/4VdfjnS+sq+4GU8emF6qgLZAoKgLDMAot4Q+wxoewUJ1xZZAZM0xhpWSm0yvO9l61q
	 j25nXoQskJvoan/uLAErUlCI+vGCSANVUTfZijg5K0hQVZDteURa3sKFGt1jGMoZyiple
	 LtvYMjC5taeDDUA6Ykr7ZvVJbkvUk6yzZHR+g0ngveJt+hm+DgFzGW3oB7DFjSYOhghX4
	 rS8JU65MHj5FNWeH/51Nvv8/vHPDXP64/68tekjt9X9g4UiT/mVlSmwNimXN4mKzR1UDo
	 v2ZTXwoX208Y8j/MfUTlAEqlsxgGfskVX0SJPAYlY8WLUfg5nhL7UVOZpP7uUPzibvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=J2krGXNo;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F5606A31D;
	Sat, 31 Oct 2026 02:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF0F5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=J2krGXNo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=J2krGXNo6949UessHVH0HsitKmOhDv1BrgsGjt2MPbpwfbsGrfqggDoHKX2d4+HpFovRkdENv3q72
	 ODDna82XTsOsnDQf3cbhGNLTdGTO2tgEb5VWzKcD2GkxQdvv8vo9Cp3/pZPiX8AkVOPz6wkUdKvk8d
	 HqlHhxX4Up4NXHH8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ae5562f3a9-76389;
	Sat, 31 Oct 2026 10:45:03 +0800 (CST)
X-RM-TRANSID:2ee56ae5562f3a9-76389
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[222.93.19.82])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae5562e67f-74a37;
	Sat, 31 Oct 2026 10:45:03 +0800 (CST)
X-RM-TRANSID:2ee66ae5562e67f-74a37
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	xeb@mail.ru,
	linux-kernel@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net] ip6_gre: fix changelink conflict checks for L2 tunnels
Date: Sat, 31 Oct 2026 10:44:51 +0800
Message-ID: <20261031024429.797904-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030151629.GA85001@shredder>
References: <20261028115710.27806-1-yanxia@cmss.chinamobile.com> <20261030151629.GA85001@shredder>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ido,

Thanks for the review. I'll drop the Fixes and stable tags and resend
against net-next when it reopens.

Best regards,
Xia


