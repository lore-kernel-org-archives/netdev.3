Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472802;
	b=ZLMn3HQd0p5mZc74u0/fEz+ciblc/mqat1Vevlk+A2LjVmfUPqq+aiwKf+uU3jFpNd4e
	 Zrb/7oJDfKf3K8Xu2uYplE/yF9PeAB9N1J+Oefp5YQwH7Ktygc/IvZpKncCfNcOULRsA0
	 +xz+ikbW2WBZEIHPyaIXLbjwWC/ROOSIvDeiPaMIuQNHbC++inPsixFmNPyWSUPhPU4qQ
	 rn1mBCUy+cuH/84xiENyimouOtNyitfrNADbhmKSrChDHNUA/fsLH6WMBYpAoY3diaVt/
	 KJbHQF/C76yWRq8SXJ8E5ZeGsoYw0YpCAx7u1ROTZRpESWgxfEunaoyu0VoA4q7/AFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472802;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=7mQ9PgE1JmToTrJOndvjvlG2pZvNaNVcvI5nSe1P3IU=;
	b=Hg6X6GJdxJvXoK2Q8SbcxJUHBWj5xdLGy/B0QQAWJnVEZsOjEw1fxxkayEoaO2jCUxui
	 QOnVGAGsOg0dBCBNXLNaJQWTXqfvdaQ5RP1MVhlBv8/i3N8PSZLbbYISiUQlBdAmunfrv
	 vZlWOU38f/ZVjRJj1I334rFzvlrO1BDcFkLvhrOKiXPkMIBK8XJT6kYi3gaMdAfC9Yhsg
	 wEDTkpHcKEthVdhVNoJDRZ2y981jG/x+ovCEslX4waR9tSLWBarrPEU45PmNWSpWlaNup
	 uxai4gC239bOgLj7NR6WFWdpyxy9CIqrq1dNff4EDpy7KZXZ/OVfmF8ritcjHULsLiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=dvKOlbjk;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BAB606B38E;
	Thu, 12 Nov 2026 08:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85BAB606B38E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=dvKOlbjk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=dvKOlbjkxzAzGH2CcvRLA9QMKfkzEan6NRcKwcELTpvl7ebAhZ1Vaepsg8AZlTcprcICFIMKlKgw2
	 nWoB1cvrQT3r3NQBAnVqh2MJOPYMs7vof158+T2bpNODcDwBwKDXGTKlsOkHhFtRgd67v2IhHddj92
	 /9+2NK8qZ4v79Gy8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af57b5eb18-e158d;
	Thu, 12 Nov 2026 16:39:58 +0800 (CST)
X-RM-TRANSID:2ee76af57b5eb18-e158d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.6] (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af57b5c081-f984e;
	Thu, 12 Nov 2026 16:39:58 +0800 (CST)
X-RM-TRANSID:2ee56af57b5c081-f984e
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 yana06070@163.com
Subject: Re: [PATCH net-next v2] net: ethernet: mtk-star-emac: fix device_node
 leak in mtk_star_probe()
Date: Thu, 12 Nov 2026 16:39:57 +0800
Message-ID: <1794472797000.690257.2793446627884027520@cmss.chinamobile.com>
In-Reply-To: <179445682040.2168702.1032780874409478036@kernel.org>
References: <1794455490000.585551.2561101329908158128@cmss.chinamobile.com>
 <179445682040.2168702.1032780874409478036@kernel.org>
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

On 11/12/26 12:13, netdev-bot+sinfo wrote:
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

Hi,

I don't have any MediaTek hardware with this Ethernet MAC, so the
change is compile-tested only, with CONFIG_NET_MEDIATEK_STAR_EMAC
enabled on x86_64.

Thanks,
Xia Yan


