Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552265;
	b=vgr5PEkJ8+nhOu4iHoqYwvdo0BSXDVyZqmh5RvXsChO9Yvcatt8DKU1mI92EdXD/GRRE
	 McdK2DQDbQSzr0PqNJ6/K52Ol8kBr2DsBSlN/mjpOH8YO9fLiqP5h3C3+PNOICFBA89or
	 viIiPT9AsrfwmnnpL0EmjWd0WFEghqWsYpHiGXZWw8K4Ih5UMJkJYE+ZEWFKYbyGgsVMV
	 DDZMROmQd1A9NWiUx0nHk5DkJ6NTnSYFR5EMVH5aU+46zo9tfZ46ouK9Kr/WS9UgCSuxF
	 dyP8tyCfRlHHmtnKY27Nk0XJ5kj0VC/M7JnsOkU4ozG64Al2Tblbxzip4xNuSnIKpZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To;
	bh=oDdOwoPRKgzJn8S8b+817xvgktjeviRaDZhc+NPSvXE=;
	b=Nxl+wxzxe4o4fydXePb3dbqccf/TCq8Y8AVYzgxcjTwYr+8HdDbhnUt0vfIQ/TJVZA/9
	 pqrdOo436ILEVTpXOIXkZ1oqP9wMOqtSC6Sugf5L363TYKR/dn3Gr/R5kIJgVjTOq+K00
	 wKupa9pjK30hG5yXKAemWSFEKI2cbIWPBTEiV/tlfn0UqUfnVfnFakGP/hWGb7kEkm7Oy
	 i26hbCcm8oMP7Gl9xCXnTf9u55d68pnGqvtTkmNMz8UtAacHBDg6C/xsf+m045uBsBvGW
	 LiCNYV+9EhifRdPRkxWJiBa05C7mLe+3r4fQZy/M2dBLFJCOt1S6dSJACkbqtjtKbrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wt6kHyl2;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593B606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5593B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wt6kHyl2
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9d1114320so1719795ad.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792552265; x=1793157065; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oDdOwoPRKgzJn8S8b+817xvgktjeviRaDZhc+NPSvXE=;
        b=Wt6kHyl2RRla0sGAcD9y1THEYBYw4dDS3XucI3W8bwyIaNGEaYl+usZGOB6n2uYVks
         EEy0WR3nAby5k4KHJCCjgwdvgxWenXN1vts2YrE0btJVQSC4qQNEJIJHfMpb60tEOibJ
         cGJCJw6s1zpYNuB/i2pBk1iRiGhdeJrmfGR78gssE5J2mY9BkxYnTnJznnidT5ohxJtg
         WculERUSuEi5RloxAwHKp2TCaMsJr10ZPLWB3Xg3EN4yvUP8XroZinHQwzetzDkPHsfP
         c4BzaaMTY4C0ppHcQ7GjfIryS3OKPMWfMpSThg45D4/xMj8HgmPblbnMX5W28NS4lUC1
         vE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792552265; x=1793157065;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDdOwoPRKgzJn8S8b+817xvgktjeviRaDZhc+NPSvXE=;
        b=11VLVP201qE1/O3vOz3xtBJj/ubPYpnWbVqIdosKVxEK8ovfVIORbcStH0QsthhYOc
         JGRSq0BLJmp4xAnhu/bSyy1YKsp7kS7MISmHzxrkeMhIsc3vJDRm2h9tIiVnQUTrrXhb
         MbnpRebt+OW+8zDeOwE7Xx4yl3vTp3fbM8cYTVCmd9DNMkFUGHadDp5ZM4D43PH8Tca2
         FWPm6PVY0nb7EFzRSSiO2Ka9GY3ORh9HhVHNW0F2VLuddBFafJ3ra/LzSBfoMVFuN9m5
         EUSPO+KZ39cUxODycd0MsPjKGxBA1MF1kKTqplU6Co7Vh/1Tpk8vGPPb0xY/o5YCn3ZX
         cGzg==
X-Gm-Message-State: AFq9FYJykNiadoaelRt63f4Zva2WduPXBarorenx09AVRPoGDczmDMsl
	gyH7btoXOnXBWlp7vbRoK2LqiCcdJm5t5BSbxubk6yHt713AIVDv0UrG7/BPI/Zr
X-Gm-Gg: AYBFou2Ww0jGE5vql/KaHEz4u/dNzc5SZHHW6nJ9GlZ7zCa229i2ay5CAgNX2BadFUO
	TDzqfLq1C1pSTvt87OBg6L64zQr7gLeKEF6FxGby8BuM2lVQt7X1yIuzGJQBCebWg1hEbaMp6Os
	JBzUXMqluaIC+ule0lLjaP5Ty/l2872MuHp8KHU+WBP5DnpI0czWUuFe7oDadRBido+X95JsBI8
	r5Zcww80U3/P+zwG/n1pVb2jRCop4xYkv+XAWJhmskN8QdLY31s1JllFj1A51Vo4QmlUJ8DXYj7
	TQVtmZpCRcwdrHMaPZemmil9Um4JCNtFVUWfP3yNSAODYiGJ5MpPSgJEQk8mbl1lvG1g3DkOzCQ
	WTxVyT56tJENBttadeprFbM1o/31PzQS23PTQi5X8p+sBdZxvNBsBPhxOz47FyG5GdJt73vMyLm
	QM4aRHFQTI+7DPvONcgJWXMxczm8cwfnvw5ejgPwWyudFkcHhSDuxbF8FWhC6dMJeq7ePXd23L4
	xYgB4n82a6ywYv0xtfRqTALmMwGdbwYveB9jg5I7xxTk0CUL4l5OFmxoE3oe1kDym+mTcf4Jme5
	RGQ7BNRbTqvz4fuZpOmufeI+cjp1mr2Y6whORsxReZciq2Ykaal3OSvvJA==
X-Received: by 2002:a17:903:22c6:b0:2e4:b37a:d583 with SMTP id d9443c01a7336-2ea44041d55mr5908745ad.61.1792552264671;
        Tue, 20 Oct 2026 20:11:04 -0700 (PDT)
Received: from localhost ([2601:644:8000:37f::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4af4dasm5066765ad.75.2026.10.20.20.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:11:04 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 20:11:02 -0700
Message-Id: <DMA6QT4SYA41.3VGVOVAWYQMS6@gmail.com>
To: "Andrew Lunn" <andrew@lunn.ch>, "Rosen Penev" <rosenp@gmail.com>
Cc: <netdev@vger.kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Christian Lamparter" <chunkeey@googlemail.com>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: emac: release DT PHY resources on teardown
From: "Rosen Penev" <rosenp@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261020223002.1749284-1-rosenp@gmail.com>
 <59c8f008-9ca0-4620-9a54-e73da131ab6c@lunn.ch>
In-Reply-To: <59c8f008-9ca0-4620-9a54-e73da131ab6c@lunn.ch>

On Tue Oct 20, 2026 at 6:05 PM PDT, Andrew Lunn wrote:
> On Tue, Oct 20, 2026 at 03:30:02PM -0700, Rosen Penev wrote:
>> Disconnect PHYLIB PHYs and deregister fixed PHYs during both probe
>> unwind and driver removal. Without this cleanup, unbinding a DT-based
>> EMAC can leave its PHY attached to the freed netdev, while fixed-link
>> instances retain their registered fixed PHY.
>
> This driver is quite convoluted with its PHY handling.
I agree. I got this LLM to convert the whole thing to phylink. It tested
a bunch of stuff over serial and ethernet, which works. That's net-next
material though. It'll probably get rejected.
>
> Please split this into two, phy_disconnect() and
> of_phy_deregister_fixed_link() and add better commit messages.
>
> 	if ((dev->phy_address =3D=3D 0xffffffff && dev->phy_map =3D=3D 0xfffffff=
f) ||
> 	    of_phy_is_fixed_link(np)) {
>
> 		/* PHY-less configuration. */
> 		dev->phy.address =3D -1;
> ...
> 		if (of_phy_is_fixed_link(np)) {
> 			int res =3D emac_dt_mdio_probe(dev);
>
> 			if (res)
> 				return res;
>
> 			res =3D of_phy_register_fixed_link(np);
>
> The logic here is more complex than
>
>> +	if (of_phy_is_fixed_link(np))
>> +		of_phy_deregister_fixed_link(np);
>
> So you need to explain in the commit message why it is correct.
>
>> +static void emac_cleanup_phy(struct emac_instance *dev)
>> +{
>> +	struct device_node *np =3D dev->ofdev->dev.of_node;
>> +
>> +	if (dev->ndev->phydev && dev->phy.address >=3D 0)
>> +		phy_disconnect(dev->ndev->phydev);
>
> It is also not clear this is correct, since a fixed-link should be
> connected to, yet a fixed link has dev->phy.address =3D=3D -1?
>
> 	Andrew


