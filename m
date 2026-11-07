Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061643;
	b=CzXTUNv7qQYqWngiN12ISQS8TqORwE2yTsflfo0HzPPloQNXCnFF/mWvYlaphF+MtmH5
	 5/d3r8xvt3sDOOOLg0xLqm79ijILwpP0XGKGwqQ+ep1ChQPqIY5H96S4OeNeX6uoV4ulc
	 +WxkjODyrHMdzBxJ09ixMAgdTcOgWiV/MuXBA0IXm/xbk9qqieloUOJ+F9K6SiAcj7nk6
	 bu/SpK4i3t0e1v69e9Lzsd1ilUBAGSXMr4ofjm4SkyY0vSFaW40Dc6qg6cy9tWHdrFzPn
	 xfyI4uyo2OrxC3JpMmf2aBRK7cE5VQFmFag66FhGeQF2BvDDPYf6Hety1NEavKL+R3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061643;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=EFSYc/8RJSUPREtTU6WARYqr0oenygs477L3MFgvPg8=;
	b=Ay/43IeX2j4jMebns5WzgeGKEtfRAogNOhSWmfi23P26dUMUNg5sKyVkybKV/xsZENo5
	 yrGjgY7UrARcjcnHSexoVk3us6KYBri0Jm9uMajIIAuFVRgyBn7+i+9UlsJ8Zx5lcIin5
	 09yi5pv+IAXdCx72BE+A504lCkHcR1206FPaks6FjIrMLEEgMyD+PLMkIg2rzZa0sIiLI
	 XJC/+RvrsV1zhq5Dea2Yc7zpNzJsEkeX+jWNMd4IzhNJ7PPgF8/AlaWXStgsiFUvBWM5T
	 IUEym+gGobvEGjWWct37Kahfp1uSFrJF8MxX/Dd1gQ8tEDeYzAQ+ABncSSvrQEJBdpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=csmVjV4r;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112EF606A332;
	Sat,  7 Nov 2026 14:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 112EF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=csmVjV4r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=csmVjV4rrZDKiNmtqYZutsh3R9feJf2oFkZ4Jvdj7q0iXrE3g2D2hE8jOqKCT0wbE/sq/wD6b7dRn
	 zg2gsWrLB0WmgmS5MYXw7SV9qySyqiPxowKTUqI7FMtqdkRN8w+EZlsOAo3PikNtTyVzp3xxttXNv0
	 ypd++17KLQClEZ40=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36aef3542100-836db;
	Sat, 07 Nov 2026 22:27:14 +0800 (CST)
X-RM-TRANSID:2ee36aef3542100-836db
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.79] (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16aef353f7d0-47dd1;
	Sat, 07 Nov 2026 22:27:14 +0800 (CST)
X-RM-TRANSID:2ee16aef353f7d0-47dd1
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 yana06070@163.com
Subject: Re: [PATCH net-next] net: ethernet: mtk-star-emac: fix device_node
 leak in mtk_star_probe()
Date: Sat, 07 Nov 2026 22:27:13 +0800
Message-ID: <1794061633000.60641.4001961669981893081@cmss.chinamobile.com>
In-Reply-To: <179406131565.488859.1019307996230359534@kernel.org>
References: <1794061182000.57993.3986467551914992480@cmss.chinamobile.com>
 <179406131565.488859.1019307996230359534@kernel.org>
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

On 11/7/26 22:21, netdev-bot+sinfo wrote:
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

Hi,

I don't have any MediaTek hardware with this Ethernet MAC, so the
change is compile-tested only, with CONFIG_NET_MEDIATEK_STAR_EMAC
enabled on x86_64.

Thanks,
Xia Yan


